# ParkEZ - An iOT based Smart Parking Assistant

### Smart Parking Assistant

This project implements a **Smart Parking Assistant** using the **RV IoT Kit** and an **ESP32 microcontroller**, combined with a custom **Flutter-based mobile application** for real-time monitoring and control. The system automates vehicle detection, PIN-based access control, slot occupancy tracking, and car exit management.

#### Key Features:
1. **Vehicle Detection**:  
   A proximity sensor detects incoming cars and prompts the user to enter a PIN via a matrix keypad displayed on a TFT screen.

2. **Access Control**:  
   - If the PIN is correct, the servo motor opens the gate, and a NeoPixel LED turns green to indicate access granted.  
   - If the PIN is incorrect, access is denied, and the LED glows red.  

3. **Slot Management**:  
   - The parking lot has **4 total slots**.  
   - When all slots are occupied, access is denied until a car exits.  
   - Cars can exit by entering the PIN `4321`, which frees up a slot for the next vehicle.  
   - During car exit, the NeoPixel LED glows **blue** to indicate the process.

4. **Mobile Application**:  
   - A custom **Flutter app** provides real-time updates on slot occupancy and allows manual control.  
   - The app communicates wirelessly with the ESP32 microcontroller.

5. **Cloud Integration**:  
   - Data such as slot occupancy and access attempts are uploaded to **ThingSpeak** for graphical analysis and cloud-based tracking.

#### Workflow:
- **Car Entry**:  
   The proximity sensor detects a car, and the user enters a PIN. If access is granted, the gate opens, and the slot count is updated.  
- **Car Exit**:  
   The PIN `4321` is entered to reduce the slot count, allowing the next car to enter. During this process, the NeoPixel LED glows **blue**.

This project provides a seamless and automated parking solution with real-time monitoring, efficient slot management, and cloud-based analytics.


## Images showing the hardware simulation of the Access Granted and Access Denied features:

<div style="text-align: center;">
  <img src="https://github.com/user-attachments/assets/9682ebae-b34f-4924-a969-d47d055315e1" alt="Access Granted Simulation" width="400">
  <img src="https://github.com/user-attachments/assets/e0dfa21c-3b41-4946-aae7-5cb2292234b0" alt="Access Denied Simulation" width="400">
</div>

## The Flutter App Interface:

### The Intro Page:
<div style="text-align: center;">
  <img src="https://github.com/user-attachments/assets/063bb565-2fda-4aaf-8a44-080fb6ff3d8b" alt="Intro Page" width="500">
</div>

### The Home Page:
<div style="text-align: center;">
  <img src="https://github.com/user-attachments/assets/5fdf4ef7-5325-4851-ab0e-202359a7b00f" alt="Home Page" width="500">
</div>

### Slot Status Page:
<div style="text-align: center;">
  <div style="display: flex; justify-content: center; gap: 20px;">
    <img src="https://github.com/user-attachments/assets/f8f6bf3f-0013-4c7d-9ad2-dd93fe234be6" alt="Slot Access Page 1" width="45%">
    <img src="https://github.com/user-attachments/assets/0990a04a-4b01-49fb-90e2-e173cd6080e9" alt="Slot Access Page 2" width="45%">
  </div>
</div>

### Slot Access Logs Page:
<div style="text-align: center;">
  <img src="https://github.com/user-attachments/assets/f015772a-87fd-46a9-b043-b70b10771214" alt="Slot Access Logs Page" width="500">
</div>
