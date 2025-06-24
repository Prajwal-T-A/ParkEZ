{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #include <Wire.h>\
#include "I2CKeyPad.h"\
#include <Adafruit_NeoPixel.h>\
#include <Adafruit_PWMServoDriver.h>\
#include <TFT_eSPI.h>\
#include <WiFi.h>\
#include <WebServer.h>\
#include <NTPClient.h>\
#include <WiFiUdp.h>\
#include <HTTPClient.h>\
\
const char* ssid = "";\
const char* password = "";\
\
const char* thingSpeakServer = "http://api.thingspeak.com/update";\
const char* thingSpeakAPIKey = "RJSOAJJS1CD1BL75";\
\
WebServer server(80);\
WiFiUDP ntpUDP;\
NTPClient timeClient(ntpUDP, "pool.ntp.org", 19800, 60000);\
\
#define KEYPAD_ADDRESS 0x3D\
#define PROXIMITY_ADDRESS 0x3A\
I2CKeyPad keyPad(KEYPAD_ADDRESS);\
char keys[] = "147*2580369#ABCDNF";\
\
TFT_eSPI tft = TFT_eSPI();\
int cursorY = 2;\
\
#define PIN_WS2812B 17\
Adafruit_NeoPixel ws2812b(1, PIN_WS2812B, NEO_GRB + NEO_KHZ800);\
\
Adafruit_PWMServoDriver pca9685 = Adafruit_PWMServoDriver(0x40);\
#define SERVO_PIN 0\
#define SERVOMIN 100\
#define SERVOMAX 500\
\
String enteredPIN = "";\
String entryPIN = "1234";\
String exitPIN = "4321";\
bool accessGranted = false;\
bool carDetected = false;\
\
int carCount = 0;\
const int maxSlots = 4;\
\
int accessAttempts = 0;\
int unauthorizedEvents = 0;\
\
#define MAX_LOGS 7\
String accessLogs[MAX_LOGS];\
int logIndex = 0;\
\
void addLog(String status) \{\
  timeClient.update();\
  String timestamp = timeClient.getFormattedTime();\
  String log = timestamp + " - " + status;\
  accessLogs[logIndex % MAX_LOGS] = log;\
  logIndex++;\
\}\
\
void sendToThingSpeak() \{\
  timeClient.update();\
\
  if (WiFi.status() == WL_CONNECTED) \{\
    HTTPClient http;\
    String url = String(thingSpeakServer) + "?api_key=" + thingSpeakAPIKey +\
                 "&field1=" + String(carCount) +\
                 "&field2=" + String(accessAttempts) +\
                 "&field3=" + String(unauthorizedEvents);\
    http.begin(url);\
    int response = http.GET();\
    http.end();\
  \}\
\}\
\
void handleSlotStatus() \{\
  server.send(200, "text/plain", String(carCount));\
\}\
\
void handleAccessLogs() \{\
  String json = "[";\
  int start = max(0, logIndex - MAX_LOGS);\
  for (int i = start; i < logIndex; i++) \{\
    if (i > start) json += ",";\
    String logStr = accessLogs[i % MAX_LOGS];\
    int sep = logStr.indexOf(" - ");\
    String time = logStr.substring(0, sep);\
    String status = logStr.substring(sep + 3);\
    json += "\{\\"time\\":\\"" + time + "\\",\\"status\\":\\"" + status + "\\"\}";\
  \}\
  json += "]";\
  server.send(200, "application/json", json);\
\}\
\
void setup() \{\
  Serial.begin(115200);\
  Wire.begin();\
\
  WiFi.begin(ssid, password);\
  while (WiFi.status() != WL_CONNECTED) delay(500);\
\
  timeClient.begin();\
  server.on("/slotStatus", handleSlotStatus);\
  server.on("/accessLogs", handleAccessLogs);\
  server.begin();\
\
  keyPad.begin();\
\
  tft.init();\
  tft.setRotation(3);\
  tft.fillScreen(TFT_WHITE);\
  tft.setTextColor(TFT_BLACK, TFT_WHITE);\
  tft.setTextSize(2);\
  tft.setCursor(0, cursorY);\
  tft.println("System Ready");\
  cursorY += 20;\
\
  ws2812b.begin();\
  ws2812b.setBrightness(100);\
  ws2812b.clear();\
  ws2812b.show();\
\
  pca9685.begin();\
  pca9685.setPWMFreq(50);\
  moveServo(0);\
\}\
\
void blinkNeoPixel(uint8_t r, uint8_t g, uint8_t b) \{\
  ws2812b.setPixelColor(0, ws2812b.Color(r, g, b));\
  ws2812b.show();\
\}\
\
void moveServo(int angle) \{\
  int pulse = map(angle, 0, 180, SERVOMIN, SERVOMAX);\
  pca9685.setPWM(SERVO_PIN, 0, pulse);\
\}\
\
void displayLine(String msg) \{\
  if (cursorY > 200) \{\
    tft.fillScreen(TFT_WHITE);\
    cursorY = 2;\
  \}\
  tft.fillRect(0, cursorY, 240, 20, TFT_WHITE);\
  tft.setCursor(0, cursorY);\
  tft.println(msg);\
  cursorY += 20;\
\}\
\
char readKeypad() \{\
  uint8_t idx = keyPad.getKey();\
  if (keys[idx] != 'N') \{\
    delay(300);\
    return keys[idx];\
  \}\
  return '\\0';\
\}\
\
bool isCarPresent() \{\
  Wire.requestFrom(PROXIMITY_ADDRESS, 1);\
  if (Wire.available()) \{\
    byte sensorByte = Wire.read();\
    return (sensorByte != 0xFF);\
  \}\
  return false;\
\}\
\
void loop() \{\
  server.handleClient();\
  carDetected = isCarPresent();\
\
  if (carDetected && !accessGranted) \{\
    displayLine("Car Detected!");\
    displayLine(" Enter PIN:");\
    accessGranted = true;\
  \}\
\
  char key = readKeypad();\
  if (key != '\\0') \{\
    displayLine("Key: " + String(key));\
\
    if (key == '#') \{\
      accessAttempts++;\
\
      if (enteredPIN == entryPIN && carDetected) \{\
        if (carCount < maxSlots) \{\
          displayLine("Access Granted");\
          blinkNeoPixel(0, 255, 0);\
          moveServo(90);\
          delay(1500);\
          moveServo(0);\
          carCount++;\
          addLog("Car Entered. Count: " + String(carCount));\
        \} else \{\
          displayLine("Slots Full");\
          blinkNeoPixel(255, 0, 0);\
          addLog("Entry Denied: Full");\
        \}\
      \}\
      else if (enteredPIN == exitPIN && carCount > 0) \{\
        displayLine("Exit Approved");\
        blinkNeoPixel(0, 0, 255);\
        moveServo(90);\
        delay(1500);\
        moveServo(0);\
        carCount--;\
        addLog("Car Exited. Count: " + String(carCount));\
      \}\
      else \{\
        displayLine(" Access Denied");\
        blinkNeoPixel(255, 0, 0);\
        unauthorizedEvents++;\
        addLog("Access Denied");\
      \}\
\
      displayLine("Slots Used: " + String(carCount) + "/4");\
      sendToThingSpeak();\
      enteredPIN = "";\
      accessGranted = false;\
    \}\
    else if (key == '*') \{\
      enteredPIN = "";\
      displayLine("PIN Cleared");\
    \}\
    else \{\
      enteredPIN += key;\
    \}\
  \}\
\
  // Periodic ThingSpeak update\
  static unsigned long lastUpdate = 0;\
  if (millis() - lastUpdate > 20000) \{\
    sendToThingSpeak();\
    lastUpdate = millis();\
  \}\
\
  delay(300);\
\}}