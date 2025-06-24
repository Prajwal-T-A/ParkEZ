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


Images showing the hardware simulation of the Access Granted and Access Denied features: 
![image](https://github.com/user-attachments/assets/edee2ade-93fe-4223-96cd-1c39d6dc66b3)
![IMG_8251](https://github.com/user-attachments/assets/48108a12-c924-4e34-b1f4-1c24d1ee6820)



