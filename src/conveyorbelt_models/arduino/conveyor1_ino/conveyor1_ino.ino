#include <WiFi.h>
#include <ESPmDNS.h>
#include <PubSubClient.h>

//#define MAX_COUNT 3

WiFiClient client;
PubSubClient mqtt(client);

// Pin Conf
const int led_pin = 2;
const int sensor_ir1 = 12;
const int sensor_ir2 = 13;
const int motor_pin_cw = 19;
const int motor_pin_ccw = 21;
bool start_obj = false;
bool stop_obj = false;
bool start_pub = true;
bool stop_pub = true;
bool start_again = false;
bool start_flag = false;
bool timer_stop = false;
unsigned int motor_status = 0;

// MQTT Conf
const char* HOSTNAME = "EspDuino32-1";
const char* MQTT_SERVER = "broker.emqx.io";
//const char* MQTT_SERVER = "36.92.136.155";
const char* TOPIC_CLIENT = "AppleConveyor/Conveyor1/Client/"; 
const char* TOPIC_SERVER = "AppleConveyor/Conveyor1/Server/";

// Device Conf
const char* device_name = "Conveyor1_client";

// WiFi Conf
const char* ssid = "WannaCry";
const char* password = "081274695021";

// Timeout
unsigned int wifi_timeout = 0;
unsigned long prevMillis_start = 0;
unsigned long prevMillis_stop = 0;
unsigned long mqttMillis = 0;
unsigned long start_time = 0;
unsigned long timer_convey = 0;
const int interval_pub = 1000;
const int interval_start = 2000;
const int interval_stop = 2000;

// msgs Callback
/*  1 : Start
 *  2 : Stop
 *  3 : Conveyor ON
 *  4 : Box Detected
 */
String cmd_msg = "";
///int count = 0;

void connectToWiFi(){
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.mode(WIFI_STA);
  WiFi.disconnect();
  WiFi.begin(ssid, password);
//  WiFi.printDiag(Serial);

  while(WiFi.waitForConnectResult() != WL_CONNECTED){
    if(wifi_timeout >= 10) ESP.restart();
    else wifi_timeout++;

//    Serial.print(".");
 
    WiFi.disconnect();
    WiFi.reconnect();
    delay(500);
  }

  wifi_timeout = 0;
  
  if (!MDNS.begin(HOSTNAME)) {
//      Serial.println("Error setting up MDNS responder!");
      
      while (1) delay(1000);
  }

//  Serial.print("...");
//  Serial.println(" connected");
//  Serial.print("IP address: ");
//  Serial.println(WiFi.localIP());
}

void reconnectMQTT() {
//    Serial.println("Attempting MQTT connection...");
//    Serial.print("Subsricbing to :");
//    Serial.println(TOPIC_CLIENT);
    
    if(mqtt.connect(device_name, HOSTNAME, "")) 
    {
//        Serial.print(device_name);
//        Serial.println(" connected");
        mqtt.subscribe(TOPIC_CLIENT, 1);
    }
    else
    {
//        Serial.print("failed, rc=");
//        Serial.print(mqtt.state());
//        Serial.println(" try again in 1 seconds");
        mqtt.unsubscribe(TOPIC_CLIENT);
    }
}

void mqtt_callback(char* topic, byte* payload, unsigned int length)
{
    payload[length] = '\0';
    String _message = String((char*)payload);
    String _topic = String(topic);
    
    if(_topic.equals(TOPIC_CLIENT)){
//      Serial.println(_message);
      
      if(_message=="start" || _message=="stop" || _message=="0") 
        cmd_msg = _message;
    }
}

void setup() {
//  Serial.begin(115200);

  pinMode(sensor_ir1, INPUT);
  pinMode(sensor_ir2, INPUT);
  pinMode(led_pin, OUTPUT);
  pinMode(motor_pin_cw, OUTPUT);
  pinMode(motor_pin_ccw, OUTPUT);

  delay(10);
  connectToWiFi();
  mqtt.setServer(MQTT_SERVER, 1883);
  mqtt.setCallback(mqtt_callback);

}

void loop() {

  if(!mqtt.connected()){
      // Reconnect WiFi Connection
      if(WiFi.status() != WL_CONNECTED){
//        Serial.println("Connection Lost! Reconnecting...");
        connectToWiFi();  
      }
      else reconnectMQTT();  

      digitalWrite(led_pin, LOW);
  }
  else {
    mqtt.loop();
    digitalWrite(led_pin, HIGH);
  }

  unsigned long currentMillis = millis();
  
  if(!start_pub){
    unsigned long startMillis = millis();
    
    if(startMillis - prevMillis_start >= interval_start)
      start_pub = true;  
  }
  else{
    prevMillis_start = currentMillis;
  }

  if(!stop_pub && start_again){
    unsigned long stopMillis = millis();
    
    if(stopMillis - prevMillis_stop >= interval_stop){
      stop_pub = true;  
      start_again = false;
      timer_stop = true;
    }
  }
  else if(timer_stop){
    unsigned long stopMillis = millis();

    if(stopMillis - prevMillis_stop >= interval_stop){
      motor_status = 0;
      timer_stop = false;
    }
  }
  else{
    prevMillis_stop = currentMillis;
  }

  start_obj = !digitalRead(sensor_ir2);
  stop_obj = !digitalRead(sensor_ir1);

//  Serial.print("Ir 1: ");
//  Serial.println(start_obj);
//  Serial.println(start_pub);

//  Serial.print("Ir 2: ");
//  Serial.println(stop_obj);

  if(cmd_msg == "0"){
    switch(motor_status){
      case 0:{                // get update conveyor start
        mqtt.publish(TOPIC_SERVER, "2");
        cmd_msg = "";
        break;
      }
      case 1:{               // get update conveyor stop
        mqtt.publish(TOPIC_SERVER, "1");
        cmd_msg = "";
        break;
      }
    }
  }

  if(cmd_msg=="start"){
    mqtt.publish(TOPIC_SERVER, "1");
    motor_status = 1;

    if(stop_obj)
      start_again = true;
    else
      start_again = false;
    
    prevMillis_stop = currentMillis;
    cmd_msg = "";
  }
  else if(cmd_msg=="stop"){
    mqtt.publish(TOPIC_SERVER, "2");
    motor_status = 0;
    start_flag = false;
    cmd_msg = "";
  }

  if(start_obj && start_pub && motor_status){
    mqtt.publish(TOPIC_SERVER, "3");
    start_pub = false;  
    start_flag = true;
  }
  else if((stop_obj && stop_pub && motor_status) || (stop_obj && start_flag)){
    mqtt.publish(TOPIC_SERVER, "4");
    mqtt.publish("AppleConveyor/Conveyor2/Client/", "start");
    
    motor_status = 0;
    stop_pub = false;
    start_flag = false;
  }

  if(currentMillis - mqttMillis >= interval_pub)
  {  
    if(motor_status){
      mqtt.publish(TOPIC_SERVER, "1");
    }
    else{
      mqtt.publish(TOPIC_SERVER, "2");
    }
    mqttMillis = currentMillis;
//    mqtt.publish(TOPIC_SERVER, (char*)timer_convey);
  }

//  if(start_flag)
//  {
//    if(currentMillis - start_time >= 100)
//    {
//      timer_convey+=100;
//      start_time = currentMillis;
//      Serial.print(timer_convey);
//      Serial.println(" ms");
//    }
//  }
  
  digitalWrite(motor_pin_ccw, motor_status);  
}
