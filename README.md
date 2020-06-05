About:
- Challenge project exemplifies my coding organization, style, etc.

How to start app:
- Please `pod install` in project directory

Project consists of:
- Autolayout
- NRLSession
- Cocoapods
    - Realm for local storage
- All orientation (landscape & portrait) including all iOS sizes iPad & iPhones
- MVC

Please open Challenge.xcworkspace.

Observations & Notes:
- iPhone X’s do not conform to upside down portrait mode.
- The description model is usally a very long String and I believe it shouldn’t be included in the master view’s cell (StarWarsCollectionViewController). The StarWarsDetailViewController will show the description as it should since it is the detail of the model. Instead, I displayed the masterViewCell to look more iOS UI/UX with what I believe is the most important content in the order of:u
    - Date
    - Title
    - Location 1
    - Location 2
    - Phone Number.
- I have used Realm to store locally the basic info other than the images since that is to make the ‘app functional’. But, if I were to display images locally, I would have used a framework like SDWebImage to cache and load images without network connection. But the reason why I didn’t do so is because I wanted to show Error Handling for the invalid URL image specifically: (https://raw.githubusercontent.com/solechang/SwiftExample/master/Images/intentional_404_error_handling.jpg). In addition, storing data images locally would be an overkill because what if there were 1000+ images? However, I did use NSCache to implement simple, lightweight image caching.
- What exactly is the user trying to share? As for this implementation, I set up UIActivityViewController to send everything including: image, date, title, description, locationline1, locationline2, and phone.

Optional animation plans:
- As for one of the optional animations, I would approach the master view cell’s image transition with dissolve/crossfade to the detailViewController by using UIViewControllerTransitioningDelegate. From that delegate, I can pinpoint which cell is selected, and I can transition the origin frame to be presented to the next detailViewController. Of course, calculation of the master view’s cell position to the detailViewController is imperative to get that ‘popAnimator’ animation. I would have followed https://www.raywenderlich.com/2925473-ios-animation-tutorial-custom-view-controller-presentation-transitions to gage what can done similarly.
- As for the other animation of the title going into the navigation bar, the first step I would have taken is the UIScrollViewDelegate within the DetailViewController to calculate the offset of where the title will be placed while the scrolling in the y coordinate. Next steps are to look into using a ‘header view’ to replace the navigation bar and calculate what other components are supposed to fade in/out while scrolling.

Challenges:
- The hardest part of this challenge was to make sure all the UI/UX work seamlessly. Are the users going to see the correct info? What information does the user want to see? What happens when I double/triple button tap real fast? Does the portrait to landscape (and vice-versa) mode work smoothly, especially when user switches orientation for iPhone on the Master’s ViewController?
