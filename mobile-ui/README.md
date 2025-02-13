# smart_parking

## Instructions

Run an Android device on the Android Studio emulator (or a physical device). Run the app with ``flutter run``, passing the ``-v`` option for verbose console logging on the run.

## Project Structure

All these directories are in the ``lib/`` directory, where ``main.dart`` is the entry point of the app:
- ``core/`` - Contains app-wide constants, theming, and other core configurations.
- ``models/`` - Defines data structures such as ParkingSpot and User models.
- ``services/`` - Manages API communication, handling backend interactions and IoT sensor data.
- ``providers/`` - Implements state management using [Riverpod](https://riverpod.dev/docs/introduction/why_riverpod) for handling parking and authentication states.
- ``views/`` - Holds UI screens such as the home screen, parking details, login, and settings.
- ``widgets/`` - Contains reusable UI components like parking spot cards and custom buttons.
- ``routes/`` - Centralized management of navigation within the app.
- ``utils/`` - Helper functions for common tasks like validation and data formatting.