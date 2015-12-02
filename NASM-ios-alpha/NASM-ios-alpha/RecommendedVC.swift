import UIKit

class RecommendedVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGrayColor()
        
        let textLabel = UILabel(frame: CGRectMake(0, 0, 200, 30))
        textLabel.center = view.center
        textLabel.textAlignment = .Center
        textLabel.font = UIFont.systemFontOfSize(24)
        textLabel.text = "Recommended"
        view.addSubview(textLabel)
    }
}
//
//
//import UIKit
//import MapKit
//import CoreLocation
//
//
//class AtTheMuseumVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate{
//    
//    //   @IBOutlet var scrollView: UIScrollView!
//    
//    var locationManager:CLLocationManager!
//    var scrollView1: UIScrollView!
//    var collectionView: UICollectionView!
//    var mapView : MKMapView! = MKMapView()
//    var refreshControl:UIRefreshControl!
//    var museum = Museum(filename: "NASMLocation")
//    var museumObjects = [ObjectModel]()
//    var collectionViewIndex:Int!
//    var numberOfTiles = 6
//    //    var labelTest:UILabel
//    
//    
//    //    @IBOutlet var collectionView: UICollectionView!
//    
//    //random heights for collection view
//    var heights = [200,175,175,200,175,175,200,175,175,200,175,175,200,175,175,200,175,175,200,175,175,200,175,175] as [CGFloat]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //////////////////// Collection View ///////////////////
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 17, bottom: 50, right: 17)
//        layout.itemSize = CGSize(width: 165, height: 165)
//        let CollectionViewframe = CGRect(x:0,y:310,width:view.frame.width,height:667);
//        
//        collectionView = UICollectionView(frame: CollectionViewframe, collectionViewLayout: layout)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//        collectionView.backgroundColor = UIColor.whiteColor()
//        collectionView.scrollEnabled   = false
//        
//        
//        //////////////////// Location Manager ///////////////////
//        locationManager = CLLocationManager()
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.delegate = self
//        
//        
//        
//        /////////////////////// Map View ///////////////////////
//        
//        //setting the region to show NASM
//        //        let span = MKCoordinateSpanMake(0.0015, 0.0015)
//        //        let lat = 38.8879
//        //        let long = -77.0200
//        
//        //        let lat = locationManager.location?.coordinate.latitude
//        //        let long = locationManager.location?.coordinate.longitude
//        //        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat!, longitude: long!), span: span)
//        //        mapView.setRegion(region, animated: true)
//        //
//        //        mapView.showsUserLocation = true
//        //        mapView.mapType = .Standard
//        //        mapView.frame = CGRect(x: 0, y: 105, width: self.view.frame.size.width, height: 200)
//        //        mapView.delegate = self
//        
//        
//        /////////////// Pull down to refresh controller //////////////
//        self.refreshControl = UIRefreshControl()
//        self.refreshControl.attributedTitle = NSAttributedString(string: "")
//        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
//        let pullDownLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, 45))
//        pullDownLabel.textAlignment = .Center
//        pullDownLabel.textColor = UIColorFromRGB(0x65686a)
//        pullDownLabel.font = UIFont.systemFontOfSize(16)
//        pullDownLabel.text = "Pull down to refresh your location"
//        
//        
//        //////////////// Near You Label ///////////////////////
//        let nearYouLabel = UILabel(frame: CGRectMake(0, 45, self.view.frame.size.width, 55))
//        nearYouLabel.textAlignment = .Center
//        nearYouLabel.textColor = UIColorFromRGB(0x65686a)
//        nearYouLabel.font = UIFont.systemFontOfSize(24)
//        nearYouLabel.text = "NEAR YOU"
//        
//        
//        ///////////////////  Connections Image ////////////////////
//        let imageName = "connectionsImage.png"
//        let image = UIImage(named: imageName)
//        let imageView = UIImageView(image: image!)
//        let y = (200 + collectionView.frame.size.height + pullDownLabel.frame.size.height + nearYouLabel.frame.size.height)
//        imageView.frame = CGRect(x: 0, y: y, width: self.view.frame.size.width, height: 450)
//        
//        
//        /////////////////////// Load More Button /////////////////////////
//        let loadMoreButton   = UIButton(type: UIButtonType.System) as UIButton
//        let buttonY = (200 + collectionView.frame.size.height + imageView.frame.size.height + pullDownLabel.frame.size.height + nearYouLabel.frame.size.height + 20)
//        let buttonWidth = (self.view.frame.size.width - 20)
//        loadMoreButton.frame = CGRectMake(10, buttonY,buttonWidth, 70)
//        loadMoreButton.backgroundColor = UIColor.lightGrayColor()
//        loadMoreButton.setTitle("Load More", forState: UIControlState.Normal)
//        loadMoreButton.titleLabel?.textColor = UIColor.blackColor()
//        loadMoreButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        
//        
//        /////////////////////// Scroll View /////////////////////////////
//        let scrollViewHeight = (200 + collectionView.frame.size.height + imageView.frame.size.height + pullDownLabel.frame.size.height + nearYouLabel.frame.size.height + 270)
//        let scrollViewFrame = CGSize(width: view.frame.size.width, height: scrollViewHeight)
//        self.scrollView1 = UIScrollView(frame: view.bounds)
//        self.scrollView1.delegate = self
//        self.scrollView1.contentSize = scrollViewFrame
//        //  self.scrollView1.backgroundColor = UIColor .blackColor()
//        view.addSubview(self.scrollView1)
//        self.scrollView1.addSubview(pullDownLabel)
//        self.scrollView1.addSubview(nearYouLabel)
//        self.scrollView1.addSubview(collectionView)
//        self.scrollView1.addSubview(mapView)
//        self.scrollView1.addSubview(imageView)
//        self.scrollView1.addSubview(loadMoreButton)
//        
//        self.scrollView1.addSubview(refreshControl)
//        self.scrollView1.bringSubviewToFront(pullDownLabel)
//        self.scrollView1.bringSubviewToFront(nearYouLabel)
//        refreshLocation()
//    }
//    
//    
//    // button method to load more tiles
//    func buttonAction(sender:UIButton!)
//    {
//        numberOfTiles += 6
//        self.collectionView.reloadData()
//        print("Load More Pressed")
//    }
//    
//    func addOverlay() {
//        let overlay = MapOverlay(museum: museum)
//        mapView.addOverlay(overlay)
//    }
//    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
//        if overlay is MapOverlay {
//            let NASMMapImage = UIImage(named: "floor1PNG2")
//            let overlayView = MapOverlayView(overlay: overlay, overlayImage: NASMMapImage!)
//            
//            return overlayView
//        }
//        
//        return nil
//    }
//    
//    func refreshLocation() {
//        ////////////// Hard Coding Map to center on NASM Location /////////////
//        let span = MKCoordinateSpanMake(0.0015, 0.0015)
//        let region = MKCoordinateRegionMake(museum.midCoordinate, span)
//        mapView.delegate = self
//        mapView.region = region
//        //   locationManager.startUpdatingLocation()
//        
//        mapView.mapType = .Standard
//        mapView.frame = CGRect(x: 0, y: 105, width: self.view.frame.size.width, height: 200)
//        addOverlay()
//        
//        ///////////// Center on Current GPS Location //////////////////////
//        //        let span = MKCoordinateSpanMake(0.0015, 0.0015)
//        //        let lat = locationManager.location?.coordinate.latitude
//        //        let long = locationManager.location?.coordinate.longitude
//        //        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat!, longitude: long!), span: span)
//        //        mapView.setRegion(region, animated: true)
//        //        locationManager.stopUpdatingLocation()
//        //        mapView.showsUserLocation = true
//        //        mapView.delegate = self
//    }
//    
//    //    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//    //        self.locationManager = locations.last as CLLocation
//    //    }
//    //
//    
//    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
//        //        let span = MKCoordinateSpanMake(0.0015, 0.0015)
//        //        let lat = locationManager.location?.coordinate.latitude
//        //        let long = locationManager.location?.coordinate.longitude
//        //        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat!, longitude: long!), span: span)
//        //        mapView.setRegion(region, animated: true)
//        //
//        //        mapView.showsUserLocation = true
//        //        mapView.mapType = .Standard
//        //        mapView.frame = CGRect(x: 0, y: 105, width: self.view.frame.size.width, height: 200)
//        //        mapView.delegate = self
//        
//        
//        
//        
//        
//        
//        locationManager.stopUpdatingLocation()
//    }
//    func refresh(sender:AnyObject)
//    {
//        
//        NSLog("Refreshed Location")
//        self.refreshControl.endRefreshing()
//        refreshLocation()
//        //   viewDidLoad()
//    }
//    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return numberOfTiles
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        //
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
//        //        cell.backgroundColor = UIColor.orangeColor()
//        //        let textLabel = UILabel(frame: CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height))
//        //        textLabel.textAlignment = NSTextAlignment.Center
//        //        textLabel.textColor = UIColor.whiteColor()
//        //        let textString = museumObjects[indexPath.row].title as! String
//        //
//        //        textLabel.text = textString
//        //
//        //        //   textLabel.text = "Cell \(indexPath.row)"
//        //        cell.contentView.addSubview(textLabel)
//        
//        
//        
//        
//        return cell
//    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSizeMake(165, heights[indexPath.row])
//    }
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    //    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
//    //        mapView.centerCoordinate = userLocation.location!.coordinate
//    //    }
//    //    
//    
//    
//}