const int sensorPin = A0;  // Use A0 explicitly for clarity
const int ledPin = 9;

int lightLevel, high = 0, low = 1023;

void setup() {
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600); // Initialize Serial Communication at 9600 baud
}

void loop() {
  lightLevel = analogRead(sensorPin);
  
  manualTune();  // You can switch to autoTune()

  analogWrite(ledPin, lightLevel);

  Serial.println(lightLevel); // Send the light level data over serial

  delay(100); // Small delay to prevent excessive data transmission
}

void manualTune() {
  lightLevel = map(lightLevel, 0, 1023, 0, 255);
  lightLevel = constrain(lightLevel, 0, 255);
}

void autoTune() {
  if (lightLevel < low) low = lightLevel;
  if (lightLevel > high) high = lightLevel;

  lightLevel = map(lightLevel, low + 30, high - 30, 0, 255);
  lightLevel = constrain(lightLevel, 0, 255);
}
