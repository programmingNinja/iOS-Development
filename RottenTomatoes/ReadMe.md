## Rotten Tomatoes

This is a movies app displaying box office and top rental DVDs using the [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON).

Time spent: `7 hours`

### Features

#### Required

- [Completed] User can view a list of movies. Poster images load asynchronously.
- [Completed] User can view movie details by tapping on a cell.
- [Completed] User sees loading state while waiting for the API.
- [Completed] User sees error message when there is a network error
- [Completed] User can pull to refresh the movie list.

#### Optional

- [Completed] All images fade in.
- [ ] For the larger poster, load the low-res first and switch to high-res when complete.
- [ ] All images should be cached in memory and disk: AppDelegate has an instance of `NSURLCache` and `NSURLRequest` makes a request with `NSURLRequestReturnCacheDataElseLoad` cache policy. I tested it by turning off wifi and restarting the app.
- [ ] Customize the highlight and selection effect of the cell.
- [Completed] Customize the navigation bar.
- [Tried, commented] Add a tab bar for Box Office and DVD.
- [Tried, commented] Add a search bar: pretty simple implementation of searching against the existing table view data.

### Walkthrough
![Video Walkthrough](demoRottenTomatoes.gif)
