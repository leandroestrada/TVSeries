# TVSeries iOS

This is an iOS application that uses the TVMaze API to display information about TV shows, their seasons, and episodes.

## Architecture

The project follows the MVVM-C architecture

### Key Architecture Points:

- **MVVM Pattern**: Clear separation of concerns between View, ViewModel, and Model layers
- **Protocol-Oriented**: Uses protocols for dependency injection and testability
- **View Code**: UI built programmatically without storyboards
- **Async/Await**: Modern Swift concurrency for network calls
- **Clean Architecture**: Each feature is modular and independent
- **ViewCode**: Each view is separated into its own file for better maintainability
- **Coordinator Pattern**: Manages navigation flow and decouples view controllers from navigation logic

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.5+

## Installation

1. Clone the repository
2. Open `TVMazeTest.xcodeproj` in Xcode
3. Build and run the project

## API

This project uses the [TVMaze API](https://www.tvmaze.com/api) for fetching TV shows data.
