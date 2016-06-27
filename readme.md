#### Notes

This is an implementation for the task found at https://github.com/holidayextras/culture/blob/master/recruitment/developer-flickr-task.md

To run the project please use FlickrAPI.xcworkspace

I have used FlickrKit to accomplish the API request. Once the data for the newest photos is received from the Flickr API, network requests for the actual images are done as the user scrolls the list. Data brought by the API is cached in CoreData and persisted across launches. Only the title of each photo is displayed, although description, tags and author name for each item are also being fetched and cached.

Let me know if there are any questions.
