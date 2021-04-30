# Project Name: MoviesInfoDemoApp

It is demo app for movies and tv shows database 

## Implementation
1) Implemented Tab Bar Controller for Home Screen, Search Screen and Profile Screen
2) Implemented Generic Network layer using URLSession to get the data from The Movie DB API and download images
3) Implemented NSCache library to store Images in the local cache 


### Search Screen/ Main Screen
1) Implemented TableView to show a list of 'Now Playing' tvshows and movies when search is empty
2) Implement active search functionality in the Search screen to search for movies and tv shows
3) Implemented segmented control to filter searched shows to be either movies or tvshows


### Detail Screen
1) Implemented Details Screen to show the info for Movie and TV shows and configured it to be accessed from any collections from Home Screen or Search Screen
2) Implemented UICollectionView to show list of cast for that particular movie/tvshow in the Detail Screen

![Detail Screen iPhone SE(2nd Gen)](https://drive.google.com/uc?export=view&id=1o3mzoKUTndJFrdelIQ6n_25u5FSWNUHg)

### Profile Screen
1) Implemented Wishlist collection which displays movies or tv shows added to the wishlist by user from Detail Screen
2) Implemented a clear all button to clear the wishlist data

![Profile Screen iPhone SE(2nd Gen)](https://drive.google.com/uc?export=view&id=1F9b2EvjABNAhDT-7MbV_qGh5N5wR00UU)
