### Diagram Overview:
- The system is designed to assist drivers by giving real-time parking information via a mobile app.
- It connects several subsystems, including user authentication, a backend server for data processing, parking spot detection, and a database.
- **Conventions**:
  - Each **box** represents a component, screen, or task.
  - **Arrows** represent the flow of information and connection between components.

### LEVEL 0:
- **Driver (User)**: This represents the end user interacting with the system.
- **Smart Parking System**: The main service providing real-time parking spot availability.
- **Available Parking Spots**: The result or output of the system, delivering available parking locations to the user.

### LEVEL 1:
- **Driver (User)**: User initiates interaction with the system via the mobile app.
- **Mobile App Interface (UI)**: The user-facing part of the system through which drivers access features like viewing parking spots, authentication, and navigation.
- **User Authentication Method via Backend Server**: Secure login and authentication of users via the backend, ensuring that only registered users access the system.
- **User Database**: Stores user credentials, profiles, and relevant data like login information.
- **Real-Time Data via Backend Server**: The core of the system, this component fetches real-time parking data from the parking database.
- **Parking Spot Location Method**: A process that identifies available parking spots based on sensor data and feeds this information to the backend server.
- **Parking Database**: A repository storing data on available parking spots, updated in real-time by the sensor systems.

### LEVEL 2:
- **Driver (User)**: Continues to interact with the system.
- **Mobile App Interface (UI)**: The user interface continues as the main medium for interaction at this level.
- **User Authentication Method via Backend Server**: Handles registration and login processes through secure backend services.
- **User Database**: Stores user-specific data, including registration details and login history.
  - **Registration Form**: A part of the UI that lets new users register their information, which is stored in the database.
  - **Login**: A feature that allows users to securely log into the system and access parking spot data.
- **Real-Time Data via Backend Server**: Retrieves current parking data from sensors and updates the database.
- **Parking Spot Location Method**: A method using sensors to detect available parking spots and transmit this data to the user.
  - **GPS to locate exact parking garage/lot**: Once a parking spot is located, GPS provides exact coordinates to the user.
  - **Motion or Infrared Sensor to detect vehicles**: Sensors in parking spots detect whether a vehicle is occupying a spot, sending this data back to the server.
  - **Data Analysis Method**: The system processes real-time data from the sensors and updates the parking database accordingly.

### Purpose of Each Component:
1. **Driver (User)**: The end-user of the application.
2. **Mobile App Interface (UI)**: Provides the user with a clear and interactive way to access parking information, register, and log in.
3. **User Authentication**: Ensures that only authenticated users can access the system, enhancing security.
4. **User Database**: Stores user data necessary for account management and service personalization.
5. **Real-Time Data via Backend Server**: This is the core logic engine of the system, processing real-time sensor data to present accurate parking spot availability.
6. **Parking Spot Location Method**: Finds available parking spots using sensor data, providing real-time information to users.
7. **Parking Database**: A storage system for parking spot data, updated in real-time for accurate availability.
8. **GPS Integration**: Allows users to receive exact directions to parking spots.
9. **Motion or Infrared Sensors**: These detect when parking spots are occupied or free, which triggers real-time updates in the app.
10. **Data Analysis Method**: Ensures data from sensors is processed correctly and updates the backend and user interface accordingly.
