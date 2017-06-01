# Beta App Test Description Section for TestFlight Beta Testing

The main purpose of this iPhone App is to suggest Acrylic paints associated with tapped areas on a photo. It does this by applying a selected Match Algorithm against a database of reference paints, paint mixes, and generic paint references (see http://rgbutterfly.com/ to access detailed documentation)

The three main tasks this App performs are Reference & Search, Image Area(s) Match against a reference database, and the Paints Data Capture.

Reference & Search: The Initial View allows a user to switch between the five types of displays below.

* Color Associations: An ordered list of collections each representing a Mix, Coverage, or Generic Association
* Match Associations: An ordered list of collections each representing a Match Association
* Individual Colors: An ordered list of individual colors (mainly reference and mix paint swatches)
* Keywords Listing: An alphabetized list of keywords and their associated reference or paint mixes
* Subjective Colors: A list of color categories and their associated reference or paint mixes

Image Area(s) Match: A new photo can be taken or and existing image used for the Image Match.

The first step is to integrate an image. This can be initiated by clicking on the photo icon top-left of the Main View. Once the image (or photo taken) is selected it can be positioned in the Match type (default) view that is part of the Image View.

Single tapping on the image will create a numbered circle or square surrounding the tapped area and, along with it, a new row in the table area below the image. The left-most item in this row, corresponds to the tapped section thumbnail and the remaining items (scrollable right-to-left) the closest paint matches derived from applying a Match Algorithm (in this case the RGB Only method). The default items Count is configurable in the Settings view and currently defaults to 30.

By moving the image around you can reveal the areas not shown. To remove a tapped area simply tap on the image area you wish to remove and both tapped area and table entry disappear instantly.

Paints Data Capture: Photographed paint swatch areas can be tapped and integrated into a Mix Association. The Add Color Mix feature allows users to add existing reference colors to the mix.

Settings: The Settings Controller, accessible from the gear button (bottom right on most views), allows a number of global App customizations. Other “Non-Settings” features embedded in this controller include the About this App and Disclaimer pages, Links to the Web Documentation (GitHub Pages), Email Provide Feedback link, and documentation Share buttons which enable docs  distribution using any share-able App (such as Facebook, Twitter, Messenger, and Email) that user has access to.
