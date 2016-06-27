#### Notes

This is an implementation for the task found at https://github.com/holidayextras/culture/blob/master/recruitment/developer-flickr-task.md

To run the project please use FlickrAPI.xcworkspace

I have used FlickrKit for API connectivity. Once the data for the newest photos is received from Flickr, network requests for the actual images are made as the user scrolls the list, so the app remains responsive at all times.

Data brought by the API is cached in CoreData and persisted across launches, so after the intial launch the user will never see an empty screen. Only the title of each photo is displayed, although description, tags and author name for each item are also being fetched and cached. Vibrancy and blur effects can be added to achieve better looks.

Let me know if there are any questions.
