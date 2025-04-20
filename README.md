# Contacts iOS App

An iOS application built with Swift that fetches contact data from a public REST API, stores it locally using Core Data, and displays it in a master-detail UI layout. The app demonstrates the use of the MVVM (Model-View-ViewModel) architecture, effective error handling, and local data persistence.

## Features

- Master/detail UI for browsing and viewing contact information
- Fetches and caches contact data from a public REST API
- Saves fetched data to Core Data for offline availability
- Displays contact list with swipe-to-delete functionality
- Navigates to a detailed view showing full contact information
- Loads and displays cached data before fetching new data from the network
- Image caching and asynchronous loading for smooth UI performance

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/nenadljubik/contactsApp.git
   cd contacts-app
2.	Open the project in Xcode

3.	Install dependencies:
This project uses Swift Package Manager (SPM). Packages should resolve automatically, but you can manually trigger resolution via:
  	 - Xcode menu: File > Packages > Resolve Package Versions

4.	Run the app on the simulator or a real device using Xcode.

## Notes
- Core Data is used for local persistence to allow offline access to contact data.
- Kingfisher is used for simple and effective image caching, keeping the UI responsive and efficient.
- Alamofire simplifies networking and response handling.
- Error handling is implemented to catch and present data/network issues, though user-facing error states (e.g., retry buttons, alerts) could be further improved.
- The app prioritizes showing cached data first for better UX while fresh data is being fetched in the background.

## External Libraries
- Alamofire – Networking abstraction.
- Kingfisher – Image downloading and caching.

