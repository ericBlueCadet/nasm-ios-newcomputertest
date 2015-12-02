

import UIKit
import MapKit
import CoreLocation


class AtTheMuseumVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate{

    //   @IBOutlet var scrollView: UIScrollView!

    var locationManager:CLLocationManager!
    var scrollView1: UIScrollView!
    var collectionView: UICollectionView!
    var mapView : MKMapView! = MKMapView()
    var refreshControl:UIRefreshControl!
    var museum = Museum(filename: "NASMLocation")
    var museumObjects = [ObjectModel]()
    var collectionViewIndex:Int!
    var numberOfTiles = 6
    var cvHeight : CGFloat = 667
    var loadMoreButton : UIButton?
    var buttonY : CGFloat!
    var buttonWidth : CGFloat!
    var cell : UICollectionViewCell?
    var mapButton : UIButton?
    //    var labelTest:UILabel


//    @IBOutlet var scrollView1: UIScrollView!
//    @IBOutlet var collectionView: UICollectionView!

    //random heights for collection view
    var heights = [200,175,175,200,175,175,200,175,175,200,175,175,200,175,175,200,175,175,200,175,175,200,175,175] as [CGFloat]

    override func viewDidLoad() {
        super.viewDidLoad()

        //////////////////// Collection View ///////////////////
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 17, bottom: 20, right: 17)
        layout.itemSize = CGSize(width: 165, height: 165)
        let CollectionViewframe = CGRect(x:0,y:310,width:view.frame.width,height:650);

        self.collectionView = UICollectionView(frame: CollectionViewframe, collectionViewLayout: layout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView!.registerNib(UINib(nibName: "CVCell", bundle: nil), forCellWithReuseIdentifier: "cell")

//        self.collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.scrollEnabled   = false


        //////////////////// Location Manager ///////////////////
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self



        /////////////////////// Map View ///////////////////////

        //setting the region to show NASM
        //        let span = MKCoordinateSpanMake(0.0015, 0.0015)
        //        let lat = 38.8879
        //        let long = -77.0200

        //        let lat = locationManager.location?.coordinate.latitude
        //        let long = locationManager.location?.coordinate.longitude
        //        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat!, longitude: long!), span: span)
        //        mapView.setRegion(region, animated: true)
        //
        //        mapView.showsUserLocation = true
        //        mapView.mapType = .Standard
        //        mapView.frame = CGRect(x: 0, y: 105, width: self.view.frame.size.width, height: 200)
        //        mapView.delegate = self


        /////////////// Pull down to refresh controller //////////////
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        let pullDownLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, 45))
        pullDownLabel.textAlignment = .Center
        pullDownLabel.textColor = UIColorFromRGB(0x65686a)
        pullDownLabel.font = UIFont.systemFontOfSize(16)
        pullDownLabel.text = "Pull down to refresh your location"


        //////////////// Near You Label ///////////////////////
        let nearYouLabel = UILabel(frame: CGRectMake(0, 45, self.view.frame.size.width, 55))
        nearYouLabel.textAlignment = .Center
        nearYouLabel.textColor = UIColorFromRGB(0x65686a)
        nearYouLabel.font = UIFont.systemFontOfSize(24)
        nearYouLabel.text = "NEAR YOU"


        ///////////////////  Connections Image ////////////////////
        let imageName = "connectionsImage.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        let y = (200 + collectionView.frame.size.height + pullDownLabel.frame.size.height + nearYouLabel.frame.size.height)
        imageView.frame = CGRect(x: 0, y: y, width: self.view.frame.size.width, height: 450)


        /////////////////////// Load More Button /////////////////////////
        loadMoreButton = UIButton(type: UIButtonType.System) as UIButton
        buttonY = (200 + collectionView.frame.size.height + pullDownLabel.frame.size.height + nearYouLabel.frame.size.height)
        buttonWidth = (self.view.frame.size.width - 20)
        loadMoreButton?.frame = CGRectMake(10, buttonY,buttonWidth, 50)
        loadMoreButton?.backgroundColor = UIColorFromRGB(0xE6E6E6)
        loadMoreButton?.setTitle("Load More", forState: UIControlState.Normal)
        loadMoreButton?.setTitleColor(UIColor.blackColor(), forState: UIControlState .Normal)
       // loadMoreButton?.titleLabel?.textColor = UIColor.blackColor()
        loadMoreButton?.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)

        
        
        /////////////////////// Map Button ////////////////////////
        mapButton = UIButton(type: UIButtonType.System) as UIButton
        mapButton?.frame = CGRectMake (0, 105, self.view.frame.size.width,200)
        mapButton?.backgroundColor = UIColor.clearColor()
        mapButton?.addTarget(self, action: "mapButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        

        /////////////////////// Scroll View /////////////////////////////
        let scrollViewHeight = (200 + collectionView.frame.size.height + pullDownLabel.frame.size.height + nearYouLabel.frame.size.height + 270)
        let scrollViewFrame = CGSize(width: view.frame.size.width, height: scrollViewHeight)
        self.scrollView1 = UIScrollView(frame: view.bounds)
        self.scrollView1.delegate = self
        self.scrollView1.contentSize = scrollViewFrame
        //  self.scrollView1.backgroundColor = UIColor .blackColor()
        view.addSubview(self.scrollView1)
        self.scrollView1.addSubview(pullDownLabel)
        self.scrollView1.addSubview(nearYouLabel)
        self.scrollView1.addSubview(collectionView)
        self.scrollView1.addSubview(mapView)
        //self.scrollView1.addSubview(imageView)
        self.scrollView1.addSubview(loadMoreButton!)
        self.scrollView1.addSubview(mapButton!)
        self.scrollView1.addSubview(refreshControl)
        //self.scrollView1.bringSubviewToFront(self.collectionView)
        self.scrollView1.bringSubviewToFront(pullDownLabel)
        self.scrollView1.bringSubviewToFront(nearYouLabel)
        refreshLocation()
    }


    // button method to load more tiles
    func buttonAction(sender:UIButton!)
    {
        numberOfTiles += 6
        self.collectionView.frame.size.height += 650
        cell?.removeFromSuperview()
        self.collectionView.reloadData()
        //self.cvHeight += 667
        self.scrollView1.contentSize.height += 650
        buttonY = buttonY + 650
        self.loadMoreButton?.frame = CGRectMake(10, buttonY,buttonWidth, 50)
        self.scrollView1 .setNeedsDisplay()
        print("Load More Pressed")
    }
    
    func addFavorite(sender:UIButton!)
    {

        print("Added To Favorites!")
    }
    
    func mapButtonAction(sender:UIButton!){
        performSegueWithIdentifier("toMap", sender: self)
    }

    func addOverlay() {
        let overlay = MapOverlay(museum: museum)
        mapView.userInteractionEnabled = false
        mapView.addOverlay(overlay)
    }
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        if overlay is MapOverlay {
            let NASMMapImage = UIImage(named: "floor1PNG2")
            let overlayView = MapOverlayView(overlay: overlay, overlayImage: NASMMapImage!)

            return overlayView
        }

        return nil
    }

    func refreshLocation() {
        ////////////// Hard Coding Map to center on NASM Location /////////////
        let span = MKCoordinateSpanMake(0.0015, 0.0015)
        let region = MKCoordinateRegionMake(museum.midCoordinate, span)
        mapView.delegate = self
        mapView.region = region
        //   locationManager.startUpdatingLocation()

        mapView.mapType = .Standard
        mapView.frame = CGRect(x: 0, y: 105, width: self.view.frame.size.width, height: 200)
        addOverlay()

        ///////////// Center on Current GPS Location //////////////////////
        //        let span = MKCoordinateSpanMake(0.0015, 0.0015)
        //        let lat = locationManager.location?.coordinate.latitude
        //        let long = locationManager.location?.coordinate.longitude
        //        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat!, longitude: long!), span: span)
        //        mapView.setRegion(region, animated: true)
        //        locationManager.stopUpdatingLocation()
        //        mapView.showsUserLocation = true
        //        mapView.delegate = self
    }

    //    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    //        self.locationManager = locations.last as CLLocation
    //    }
    //

    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
        //        let span = MKCoordinateSpanMake(0.0015, 0.0015)
        //        let lat = locationManager.location?.coordinate.latitude
        //        let long = locationManager.location?.coordinate.longitude
        //        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat!, longitude: long!), span: span)
        //        mapView.setRegion(region, animated: true)
        //
        //        mapView.showsUserLocation = true
        //        mapView.mapType = .Standard
        //        mapView.frame = CGRect(x: 0, y: 105, width: self.view.frame.size.width, height: 200)
        //        mapView.delegate = self






        locationManager.stopUpdatingLocation()
    }
    func refresh(sender:AnyObject)
    {

        NSLog("Refreshed Location")
        self.refreshControl.endRefreshing()
        refreshLocation()
        //   viewDidLoad()
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfTiles
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        
        let cell1 = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        //////////// cell image view///////////////
        cell1.imageView.image = UIImage(named: "tileImage.png")
        cell1.imageView.frame = CGRect(x: 0, y: 0, width: cell1.frame.size.width, height: cell1.frame.size.height*2/3)
        
        
        /////////////cell title label//////////////////
        cell1.textLabel.frame = CGRect(x:10, y: cell1.imageView.frame.size.height, width: (cell1.frame.size.width - 10) , height: cell1.frame.size.height/3)
        cell1.textLabel.textAlignment = NSTextAlignment.Left
        cell1.textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        cell1.textLabel.textColor = UIColor.blackColor()
  //      let textString = museumObjects[indexPath.row].title as! String
        cell1.textLabel.text = "test"
        
        //////////// cell type label ///////////////////
        cell1.typeLabel.frame = CGRect(x: 10, y: cell1.imageView.frame.size.height , width: cell1.frame.size.width, height: 20)
        cell1.typeLabel.textAlignment = NSTextAlignment.Left
        cell1.typeLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        cell1.typeLabel.textColor = UIColor.whiteColor()
        cell1.typeLabel.layer.masksToBounds = true
        let typeTextString = "Featured Tours"
        cell1.typeLabel.text = typeTextString
        let labelTextWidth = cell1.typeLabel.intrinsicContentSize().width
        cell1.typeLabel.frame.size.width = labelTextWidth
//        cell1.typeLabel.lay
        
//        cell1.typeLabel.sizeToFit()
        
        
        //////////// cell type bottom color bar /////////////
        let barHeight : CGFloat = 2
//        cell1.typeLabelBar.frame = CGRect(x: 10, y: cell1.imageView.frame.size.height + barHeight, width: cell1.typeLabel.frame.size.width, height: barHeight)
//        cell1.typeLabelBar.backgroundColor = UIColor.redColor()
//        cell1.typeLabelBar.contentMode = .ScaleAspectFit
//        cell1.typeLabelBar.clipsToBounds = true
//        cell1.bringSubviewToFront(cell1.typeLabelBar)
//        let typeBottomBar = UIImageView()
        cell1.typeLabelBar2 = UIImageView()
        cell1.typeLabelBar2.frame = CGRect(x: 10, y: cell1.imageView.frame.size.height + barHeight, width: cell1.typeLabel.frame.size.width, height: barHeight)
        cell1.typeLabelBar2.backgroundColor = UIColor.redColor()
        cell1.typeLabelBar2.contentMode  = .ScaleAspectFit
        cell1.typeLabelBar2.clipsToBounds = true
        cell1.addSubview(cell1.typeLabelBar2)
//        cell1.bringSubviewToFront(cell1.typeLabelBar2)

        
        //////////////cell favorite button;/////////////////
        cell1.favoriteButton.addTarget(self, action: "addFavorite:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(165, heights[indexPath.row])
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toDetail", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetail" {
            let newViewController = segue.destinationViewController as! ObjectDetailViewController
//            let indexPath = sender as! NSIndexPath
//            let selectedRow: NSManagedObject = locationsList[indexPath.row] as! NSManagedObject
  //          newViewController.passedTrip = selectedRow as! Trips
        }
        else if segue.identifier == "toMap"{
            let newViewController = segue.destinationViewController as! MapViewController
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
    //        mapView.centerCoordinate = userLocation.location!.coordinate
    //    }
    //


}