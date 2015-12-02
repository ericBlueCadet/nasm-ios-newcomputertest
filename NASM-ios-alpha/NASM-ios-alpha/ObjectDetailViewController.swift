//
//  ObjectDetailViewController.swift
//  NASM-ios-alpha
//
//  Created by Eric  Gilbert on 11/23/15.
//  Copyright © 2015 Eric  Gilbert. All rights reserved.
//

import Foundation
import UIKit

class ObjectDetailViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate,UIWebViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    var scrollView1: UIScrollView!
    var findOnMapButton : UIButton?
    var container2 : UIView!
    var container3 : UIView!
    var storiesTitleLabel : UILabel!
    var connectionsTitleLabel : UILabel!
    var objectConnectionsImageView : UIImageView!
    var lookCloserImageView : UIImageView!
    var lookCloserDetailLabel : UILabel!
    var lookCloserFindOnMapButton : UIButton?
    var lookCloserShareFactsButton : UIButton?
    var exploreCockpitImageView : UIImageView!
    var exploreCockpitButton : UIButton?
    var talkBackTitleLabel : UILabel!
    var talkBackQuestionLabel : UILabel!
    var talkBackTweetButton : UIButton?
    var talkBackWebButton : UIButton?
    var relatedTopicsTitleLabel : UILabel!
    
    var collectionView : UICollectionView!
    var scrollViewContainer : UIScrollView!
    var colors:[UIColor] = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.yellowColor()]
    var frame: CGRect = CGRectMake(0, 0, 0, 0)
    var pageControl : UIPageControl = UIPageControl(frame: CGRectMake(50, 100, 200, 50))
    override func viewDidLoad() {

        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGrayColor()
        
        let textLabel = UILabel(frame: CGRectMake(0, 0, 200, 30))
        textLabel.center = view.center
        textLabel.textAlignment = .Center
        textLabel.font = UIFont.systemFontOfSize(24)
        textLabel.text = "Object Details"
        view.addSubview(textLabel)
        
        
        
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*2/3)
        self.scrollView.hidden = true
        
       // configurePageControl()
        
        for index in 0..<4 {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            self.scrollView.pagingEnabled = true
            
            let subView = UIView(frame: frame)
            subView.backgroundColor = colors[index]
            self.scrollView .addSubview(subView)
        }
        
        ///////////// page controller ///////////////////////
        self.pageControl.numberOfPages = colors.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.redColor()
        self.pageControl.pageIndicatorTintColor = UIColor.blackColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
        self.pageControl.frame = CGRectMake((self.view.frame.size.width / 2) - 50, 15, 100, 30)
        //self.pageControl.tintColor = UIColor.redColor()
        self.pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
       // self.scrollView1.addSubview(pageControl)
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 4, 1.0)
        pageControl.addTarget(self, action: Selector("changePage:"), forControlEvents: UIControlEvents.ValueChanged)
        //self.scrollView.addSubview(pageControl)
        
        ///////////////////  Detail Image ////////////////////
        let objectImageView = UIImageView()
        objectImageView.backgroundColor = UIColorFromRGB(0x008F24)
        objectImageView.frame = CGRect(x: 0, y: 0 , width: self.view.frame.size.width, height: self.view.frame.size.height - 80)
        objectImageView.contentMode = .ScaleAspectFit
        
        
        ///////////////// Detail Title Image Label ///////////////////
        let titleLabel = UILabel(frame: CGRectMake(0, self.view.frame.size.height * 1/3, self.view.frame.size.width, 75))
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(40)
        titleLabel.text = "Object Detail Title"
        
        ///////////////// Optional Tag Line Label ///////////////////
        let tagLineLabel = UILabel(frame: CGRectMake(0, titleLabel.frame.size.height + (self.view.frame.size.height * 1/3), self.view.frame.size.width, 50))
        tagLineLabel.textAlignment = .Center
        tagLineLabel.textColor = UIColor.lightGrayColor()
        tagLineLabel.font = UIFont.systemFontOfSize(25)
        tagLineLabel.text = "Optional Tag Line"
        
        
        //////////////// blur effect box /////////////////////////////////////
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRectMake(0, objectImageView.frame.size.height - 250, self.view.frame.size.width, 250)
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        
        ///////////////// Optional Transformative Statement ///////////////////
        let statementLabel = UILabel(frame: CGRectMake(10, 10, self.view.frame.size.width - 10, 50))
        statementLabel.textAlignment = .Center
        statementLabel.textColor = UIColor.whiteColor()
        statementLabel.font = UIFont.systemFontOfSize(20)
        statementLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        statementLabel.numberOfLines = 0
        statementLabel.text = "The X-15 gathered critical flight data that made spaceflight and future hypersonic aircraft possible"
        blurEffectView.addSubview(statementLabel)
        

        /////////////////////// Find On Map Button ////////////////////////
        findOnMapButton = UIButton(type: UIButtonType.System) as UIButton
        findOnMapButton?.frame = CGRectMake (10, statementLabel.frame.size.height + 25 , self.view.frame.size.width - 20 ,55)
        findOnMapButton?.backgroundColor = UIColor.clearColor()
        findOnMapButton?.layer.borderWidth = 2.0
        findOnMapButton?.layer.borderColor = UIColorFromRGB(0xEBDF36).CGColor
        findOnMapButton?.addTarget(self, action: "mapButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        findOnMapButton?.setTitle("Find On Map", forState: UIControlState.Normal)
        findOnMapButton?.setTitleColor(UIColor.whiteColor(), forState: UIControlState .Normal)
                    ////map icon image///
        let mapButtonImageName = "mapIcon.png"
        let image = UIImage(named: mapButtonImageName)
        let mapButtonImage = UIImageView(image: image)
        mapButtonImage.frame = CGRect(x: 70, y: 0 , width: (findOnMapButton?.frame.size.height)!, height: (findOnMapButton?.frame.size.height)!)
        mapButtonImage.image = mapButtonImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        mapButtonImage.tintColor = UIColor.whiteColor()
        mapButtonImage.contentMode = .ScaleAspectFit
        findOnMapButton?.addSubview(mapButtonImage)
        blurEffectView.addSubview(findOnMapButton!)
        
        
        ///////////////// Scroll For Stories Label ///////////////////
        let scrollForStoriesLabel = UILabel(frame: CGRectMake(0,statementLabel.frame.size.height + 20 + mapButtonImage.frame.size.height + 25 , self.view.frame.size.width, 30))
        scrollForStoriesLabel.textAlignment = .Center
        scrollForStoriesLabel.textColor = UIColor.whiteColor()
        scrollForStoriesLabel.font = UIFont.systemFontOfSize(15)
        scrollForStoriesLabel.text = "Scroll For Stories"
        blurEffectView.addSubview(scrollForStoriesLabel)
        
        
        ///////////////// down arrow image //////////////////////////
        let arrowImageName = "ScrollDownArrow.png"
        let arrowImage = UIImage(named: arrowImageName)
        let arrowImageView = UIImageView(image: arrowImage)
        arrowImageView.frame = CGRect(x: (self.view.frame.size.width / 2) - 15 , y: statementLabel.frame.size.height + 20 + mapButtonImage.frame.size.height + 60 , width: 30, height: 17)
        blurEffectView.addSubview(arrowImageView)
        
        ////////////////  favorite Icon Image ///////////////////////
        let favoriteIconImageName = "favoriteStarIcon.png"
        let favoriteIconImage = UIImage(named: favoriteIconImageName)
        let favoriteIconImageView = UIImageView(image: favoriteIconImage)
        favoriteIconImageView.frame = CGRect(x: self.view.frame.size.width - 40, y: 15, width: 30, height: 30)
        
        ////////////////  share Icon Image ///////////////////////
        let shareIconImageName = "shareIcon.png"
        let shareIconImage = UIImage(named: shareIconImageName)
        let shareIconImageView = UIImageView(image: shareIconImage)
        shareIconImageView.frame = CGRect(x: self.view.frame.size.width - 90, y: 15, width: 19.14, height: 30)
        
        ////////////////  back Icon Image ///////////////////////
        let backIconImageName = "backArrow.png"
        let backIconImage = UIImage(named: backIconImageName)
        let backIconImageView = UIImageView(image: backIconImage)
        backIconImageView.frame = CGRect(x: 10, y: 25, width: 20 , height: 20)
        
        /////////////// show image gallery button ////////////////
        let showImageGalleryButton = UIButton(type: UIButtonType.System) as UIButton
        showImageGalleryButton.frame = CGRectMake (0, 80, self.view.frame.size.width, 250)
        showImageGalleryButton.backgroundColor = UIColor.clearColor()
        showImageGalleryButton.addTarget(self, action: "showGallery:", forControlEvents: UIControlEvents.TouchUpInside)
        //self.view.addSubview(showImageGallery)
        
        
        //////////////////// stories title label /////////////////
        storiesTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80))
        storiesTitleLabel.text = "Title Label"
        storiesTitleLabel.font = storiesTitleLabel.font.fontWithSize(22)
        storiesTitleLabel.textAlignment = NSTextAlignment.Center
        storiesTitleLabel.textColor = UIColor.blackColor()
        


        

        
        //////////////////// Collection View ///////////////////
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 17, bottom: 20, right: 17)
        layout.itemSize = CGSize(width: 165, height: 165)
        let CollectionViewframe = CGRect(x:0,y:storiesTitleLabel.frame.size.height,width:view.frame.width,height:400);
        
        self.collectionView = UICollectionView(frame: CollectionViewframe, collectionViewLayout: layout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView!.registerNib(UINib(nibName: "CVCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        //        self.collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.scrollEnabled   = false
        
        
        /////////////////// Object connections title label ///////
        connectionsTitleLabel = UILabel(frame: CGRect(x: 0, y: storiesTitleLabel.frame.size.height + collectionView.frame.size.height, width: self.view.frame.size.width, height: 80))
        connectionsTitleLabel.text = "Object Connections Title"
        connectionsTitleLabel.font = connectionsTitleLabel.font.fontWithSize(22)
        connectionsTitleLabel.textAlignment = NSTextAlignment.Center
        connectionsTitleLabel.textColor = UIColor.blackColor()
        connectionsTitleLabel.backgroundColor = UIColor.whiteColor()
        
        ////////////////// object connections image view ///////////
        objectConnectionsImageView = UIImageView(frame: CGRect(x: 0, y: storiesTitleLabel.frame.size.height + collectionView.frame.size.height + connectionsTitleLabel.frame.size.height, width: self.view.frame.size.width
            , height: self.view.frame.size.width))
        let imageName1 = "objectConnections.png"
        let image1 = UIImage(named: imageName1)
        objectConnectionsImageView.image = image1
        
        //////////////////// Look Closer View ///////////////////////////////////////////////////////////////////////
        let lookCloserView = UIView(frame: CGRect(x: 0, y: storiesTitleLabel.frame.size.height + collectionView.frame.size.height + connectionsTitleLabel.frame.size.height + objectConnectionsImageView.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.width * 1.25))
        lookCloserView.backgroundColor = UIColorFromRGB(0xFFC400)
        
        let lookCloserTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        lookCloserTitleLabel.text = "Look Closer"
        lookCloserTitleLabel.textAlignment = .Center
        lookCloserTitleLabel.textColor = UIColor.blackColor()
        lookCloserTitleLabel.font = lookCloserTitleLabel.font.fontWithSize(15)
        lookCloserView.addSubview(lookCloserTitleLabel)
        
        lookCloserImageView = UIImageView(frame: CGRect(x: 15, y: lookCloserTitleLabel.frame.size.height, width: self.view.frame.size.width - 30, height: lookCloserView.frame.size.height / 2))
        lookCloserImageView.backgroundColor = UIColor.redColor()
        lookCloserView.addSubview(lookCloserImageView)
        
        lookCloserDetailLabel = UILabel(frame: CGRect(x: 15, y: lookCloserTitleLabel.frame.size.height + lookCloserImageView.frame.size.height + 30 , width: self.view.frame.size.width - 30 , height: 100))
        lookCloserDetailLabel.numberOfLines = 0
        lookCloserDetailLabel.text = "Accumsan appellatio aptent dolor euismod ex sudo valetudo. Camur dolore immitto jugis persto quibus utinam. Augue imputo mos neque nibh typicus valde verto."
        lookCloserDetailLabel.textAlignment = .Center
        lookCloserDetailLabel.font = lookCloserDetailLabel.font.fontWithSize(15)
        //lookCloserDetailLabel.backgroundColor = UIColor.whiteColor()
        lookCloserView.addSubview(lookCloserDetailLabel)
        
                            ///////// look closer find on map button //////////////
        lookCloserFindOnMapButton = UIButton(frame: CGRect(x: 15, y: lookCloserTitleLabel.frame.size.height + lookCloserImageView.frame.size.height + lookCloserDetailLabel.frame.size.height + 30 , width: self.view.frame.size.width / 2 - 30, height: 50))
        //lookCloserFindOnMapButton?.backgroundColor = UIColor.greenColor()
        lookCloserFindOnMapButton?.addTarget(self, action: "lookCloserMapAction:", forControlEvents: UIControlEvents.TouchUpInside)
        lookCloserFindOnMapButton?.setTitle("Find On Map", forState: UIControlState.Normal)
        lookCloserFindOnMapButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
        lookCloserFindOnMapButton?.titleLabel?.font = lookCloserFindOnMapButton?.titleLabel?.font.fontWithSize(12)
                                        ///////////// find on map button icon /////////////////
        let image2 = UIImage(named: "mapIcon.png")
        let mapButtonImage2 = UIImageView(image: image2)
        mapButtonImage2.frame = CGRect(x: 2, y: 0 , width: (lookCloserFindOnMapButton!.frame.size.height), height: (lookCloserFindOnMapButton?.frame.size.height)! * 3/4)
        mapButtonImage2.image = mapButtonImage2.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        mapButtonImage2.tintColor = UIColor.whiteColor()
        mapButtonImage2.contentMode = .ScaleAspectFit
        lookCloserFindOnMapButton?.addSubview(mapButtonImage2)
        lookCloserView.addSubview(lookCloserFindOnMapButton!)
        
                        /////////// look closer share facts button ////////////////
        lookCloserShareFactsButton = UIButton(frame: CGRect(x: (self.view.frame.size.width / 2) + 15, y: lookCloserTitleLabel.frame.size.height + lookCloserImageView.frame.size.height + lookCloserDetailLabel.frame.size.height + 30 , width: self.view.frame.size.width / 2 - 30, height: 50))
        //lookCloserShareFactsButton?.backgroundColor = UIColor.blackColor()
        lookCloserShareFactsButton?.addTarget(self, action: "lookCloserShareAction:", forControlEvents: UIControlEvents.TouchUpInside)
        lookCloserShareFactsButton?.setTitle("Share Facts", forState: UIControlState.Normal)
        lookCloserShareFactsButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
        lookCloserShareFactsButton?.titleLabel?.font = lookCloserShareFactsButton?.titleLabel?.font.fontWithSize(12)
                                    /////// share facts button icon ////////////////////////
        let image3 = UIImage(named: "shareIcon.png")
        let shareIconImage2 = UIImageView(image: image3)
        shareIconImage2.frame = CGRect(x: 2, y: 10 , width: (lookCloserShareFactsButton!.frame.size.height), height: (lookCloserFindOnMapButton?.frame.size.height)! * 1/2)
        shareIconImage2.image = shareIconImage2.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        shareIconImage2.tintColor = UIColor.whiteColor()
        shareIconImage2.contentMode = .ScaleAspectFit
        lookCloserShareFactsButton?.addSubview(shareIconImage2)
        lookCloserView.addSubview(lookCloserShareFactsButton!)
        
                    ///////////// button dividing lines ////////////////////////
        let horizontalBar = UIImageView(frame: CGRect(x: 5, y: lookCloserTitleLabel.frame.size.height + lookCloserImageView.frame.size.height + lookCloserDetailLabel.frame.size.height + 25, width: self.view.frame.size.width - 10, height: 1))
        horizontalBar.backgroundColor = UIColor.grayColor()
        lookCloserView.addSubview(horizontalBar)
        
        let verticleBar = UIImageView(frame: CGRect(x: self.view.frame.size.width / 2, y: lookCloserTitleLabel.frame.size.height + lookCloserImageView.frame.size.height + lookCloserDetailLabel.frame.size.height + 30 , width: 1, height: (lookCloserFindOnMapButton?.frame.size.height)! - 5))
        verticleBar.backgroundColor = UIColor.grayColor()
        lookCloserView.addSubview(verticleBar)
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
        /////////// explore cockpit imageview /////////////////////
        exploreCockpitImageView = UIImageView(frame: CGRect(x: 0, y: storiesTitleLabel.frame.size.height + collectionView.frame.size.height + connectionsTitleLabel.frame.size.height + objectConnectionsImageView.frame.size.height + lookCloserView.frame.size.height , width: self.view.frame.size.width, height: self.view.frame.size.width * 2/3))
        exploreCockpitImageView.backgroundColor = UIColor.grayColor()
        
        exploreCockpitButton = UIButton(type: UIButtonType.System) as UIButton
        exploreCockpitButton!.frame = CGRect(x: self.view.frame.size.width * 1/4, y: (exploreCockpitImageView.frame.size.height / 2) - 25 , width: self.view.frame.size.width / 2, height: 50)
        exploreCockpitButton?.addTarget(self, action: Selector("exploreCockpit:"), forControlEvents: UIControlEvents.TouchUpInside)
        exploreCockpitButton?.layer.borderWidth = 2.0
        exploreCockpitButton?.layer.borderColor = UIColor.whiteColor().CGColor
        exploreCockpitButton?.setTitle("Explore Cockpit", forState: UIControlState.Normal)
        exploreCockpitButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        exploreCockpitButton?.titleLabel?.font = exploreCockpitButton?.titleLabel?.font.fontWithSize(20)
        exploreCockpitButton?.enabled = true
        exploreCockpitImageView.addSubview(exploreCockpitButton!)
        exploreCockpitImageView.bringSubviewToFront(exploreCockpitButton!)
        exploreCockpitImageView.userInteractionEnabled = true
        
        
        /////////////////////// talk back image view ///////////////////
        let talkBackImageView = UIImageView(frame: CGRect(x: 0, y: storiesTitleLabel.frame.size.height + collectionView.frame.size.height + connectionsTitleLabel.frame.size.height + objectConnectionsImageView.frame.size.height + lookCloserView.frame.size.height + exploreCockpitImageView.frame.size.height
            , width: self.view.frame.size.width, height: self.view.frame.size.width * 2/3))
        talkBackImageView.backgroundColor = UIColor.whiteColor()
        talkBackImageView.userInteractionEnabled = true
        
                    ///////// talk back title ///////////////////////
        talkBackTitleLabel = UILabel(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 50))
        talkBackTitleLabel.text = "Talk Back Title"
       // talkBackTitleLabel.backgroundColor = UIColor.blackColor()
        talkBackTitleLabel.textAlignment = .Center
        talkBackTitleLabel.font = talkBackTitleLabel.font.fontWithSize(20)
        talkBackTitleLabel.textColor = UIColor.blackColor()
        talkBackImageView.addSubview(talkBackTitleLabel)
        
                    ///////// talk back question ///////////////////////
        talkBackQuestionLabel = UILabel(frame: CGRect(x: 40, y: talkBackTitleLabel.frame.size.height, width: self.view.frame.size.width - 80, height: 80))
        talkBackQuestionLabel.text = "Accumsan appellatio aptent dolor euismod ex sudo valetudo?"
        talkBackQuestionLabel.numberOfLines = 0
        //talkBackQuestionLabel.backgroundColor = UIColor.blackColor()
        talkBackQuestionLabel.textAlignment = .Center
        talkBackQuestionLabel.font = talkBackTitleLabel.font.fontWithSize(15)
        talkBackQuestionLabel.textColor = UIColor.blackColor()
        talkBackImageView.addSubview(talkBackQuestionLabel)
        
        
                    //////////////// talk back twitter button //////////////
        talkBackTweetButton = UIButton(frame: CGRect(x: 40, y: talkBackTitleLabel.frame.size.height + talkBackQuestionLabel.frame.size.height + 10, width: self.view.frame.size.width - 80, height: 35))
        talkBackTweetButton?.addTarget(self, action: Selector("talkbackTweetAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        talkBackTweetButton?.setTitle("TWEET YOUR ANSWERS WITH #", forState: UIControlState.Normal)
        talkBackTweetButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
        talkBackTweetButton?.titleLabel?.font = talkBackTweetButton?.titleLabel?.font.fontWithSize(15)
        talkBackTweetButton?.backgroundColor = UIColorFromRGB(0xFFC400)
        talkBackImageView.addSubview(talkBackTweetButton!)
        
        let image4 = UIImage(named: "twitterIcon.png")
        let tweetIconImageView = UIImageView(image: image4)
        tweetIconImageView.frame = CGRect(x: 10, y: 10 , width: ((talkBackTweetButton?.frame.size.height)!) / 2, height: ((talkBackTweetButton?.frame.size.height)!) / 2 )
        tweetIconImageView.image = tweetIconImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        tweetIconImageView.tintColor = UIColor.whiteColor()
        tweetIconImageView.contentMode = .ScaleAspectFit
        talkBackTweetButton?.addSubview(tweetIconImageView)
        
                  ///////////// talk back web button ////////////
        
        talkBackWebButton = UIButton(frame: CGRect(x: 40, y: talkBackTitleLabel.frame.size.height + talkBackQuestionLabel.frame.size.height + (talkBackTweetButton?.frame.size.height)!
            + 20, width: self.view.frame.size.width - 80, height: 35))
        talkBackWebButton?.addTarget(self, action: Selector("talkbackWebAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        talkBackWebButton?.setTitle("OR SEND A DETAILED EXPLANATION", forState: .Normal)
        talkBackWebButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
        talkBackWebButton?.titleLabel?.font = talkBackWebButton?.titleLabel?.font.fontWithSize(15)
        talkBackWebButton?.backgroundColor = UIColorFromRGB(0xDEDEDE)
        talkBackImageView.addSubview(talkBackWebButton!)
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        
        ////////////////////////// related topics /////////////////////
        let relatedTopicsView = UIView(frame: CGRect(x: 0, y: storiesTitleLabel.frame.size.height + collectionView.frame.size.height + connectionsTitleLabel.frame.size.height + objectConnectionsImageView.frame.size.height + lookCloserView.frame.size.height + exploreCockpitImageView.frame.size.height + talkBackImageView.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.width * 2/3))
        relatedTopicsView.backgroundColor = UIColorFromRGB(0xDEDEDE)
                    /////////////////// title label //////////////////
        relatedTopicsTitleLabel = UILabel(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 35))
        relatedTopicsTitleLabel.text = "Related Topics"
        relatedTopicsTitleLabel.textAlignment = .Center
        relatedTopicsTitleLabel.font = relatedTopicsTitleLabel.font.fontWithSize(25)
        relatedTopicsTitleLabel.textColor = UIColor.blackColor()
        relatedTopicsView.addSubview(relatedTopicsTitleLabel)
                   /////////////////// related topics buttons ////////
        var buttonTitles = ["Technology", "Aviation", "Space Flight", "History", "Pop Culture"]
//        var buttonTitles = ["Technology", "Aviation", "Space Flight"]
        var buttonX: CGFloat = 10
        var buttonY = relatedTopicsTitleLabel.frame.size.height + 30
        let labelPading: CGFloat = 20
        var totalButtonsWidth: CGFloat = 0
        for titles in buttonTitles{
            
            let relatedTopicsButton = UIButton(frame: CGRect(x: buttonX, y: relatedTopicsTitleLabel.frame.size.height + 30, width: 100, height: 40))
            relatedTopicsButton.backgroundColor = UIColor.clearColor()
            relatedTopicsButton.layer.borderWidth = 2.0
            relatedTopicsButton.layer.borderColor = UIColor.whiteColor().CGColor
            relatedTopicsButton.setTitle(titles, forState: .Normal)
            relatedTopicsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
            let buttonWidth: CGFloat = (relatedTopicsButton.titleLabel?.intrinsicContentSize().width)!
            
            
           // relatedTopicsButton.frame = CGRect(x: buttonX, y: relatedTopicsTitleLabel.frame.size.height + 30, width: buttonWidth + 20, height: 40)
            
            
            totalButtonsWidth = buttonX + buttonWidth + labelPading + 10
            
            
            if totalButtonsWidth < self.view.frame.size.width {
                relatedTopicsButton.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth + 20, height: 40)
                buttonX = buttonX + relatedTopicsButton.frame.size.width + 10
            } else {
                totalButtonsWidth = 0
                buttonX = 10
                buttonY = buttonY + relatedTopicsButton.frame.size.height + 10
                relatedTopicsButton.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth + 20, height: 40)
                buttonX = buttonX + relatedTopicsButton.frame.size.width + 10
                totalButtonsWidth = buttonX + buttonWidth + labelPading + 10
            }
            
            
            relatedTopicsButton.addTarget(self, action: "relatedTopicsButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
           // relatedTopicsButton.sizeToFit()
            relatedTopicsView.addSubview(relatedTopicsButton)
        }
        
        /////////////////////////////// button to web //////////////////////////////
        let buttonToBrowser = UIButton(frame: CGRect(x: 0, y: storiesTitleLabel.frame.size.height + collectionView.frame.size.height + connectionsTitleLabel.frame.size.height + objectConnectionsImageView.frame.size.height + lookCloserView.frame.size.height + exploreCockpitImageView.frame.size.height + talkBackImageView.frame.size.height + relatedTopicsView.frame.size.height, width: self.view.frame.size.width, height: 60))
        buttonToBrowser.backgroundColor = UIColor.lightGrayColor()
        buttonToBrowser.setTitle("View Object On Website", forState: .Normal)
        buttonToBrowser.setTitleColor(UIColor.blackColor(), forState: .Normal)
        buttonToBrowser.addTarget(self, action: Selector("toBrowserButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        ///////////// scroll view container for parallax scrolling
        scrollViewContainer = UIScrollView(frame: CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height - 80))
        scrollViewContainer.delegate = self
        scrollViewContainer.backgroundColor = UIColor.redColor()
        scrollViewContainer.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height - 80)
        scrollViewContainer.addSubview(objectImageView)
        scrollViewContainer.addSubview(titleLabel)
        scrollViewContainer.addSubview(tagLineLabel)
        scrollViewContainer.addSubview(blurEffectView)
        scrollViewContainer.addSubview(favoriteIconImageView)
        scrollViewContainer.addSubview(shareIconImageView)
        scrollViewContainer.addSubview(backIconImageView)
        scrollViewContainer.addSubview(showImageGalleryButton)
        scrollViewContainer.addSubview(pageControl)
        
        /////////// container 2 for parallax scrolling //////////////
        container2 = UIView(frame: CGRect(x: 0, y: self.view.frame.height + 80, width: self.view.frame.size.width, height: self.view.frame.size.height * 10))
        container2.addSubview(collectionView)
        container2.addSubview(storiesTitleLabel)
        container2.addSubview(connectionsTitleLabel)
        container2.addSubview(objectConnectionsImageView)
        container2.addSubview(exploreCockpitImageView)
        container2.addSubview(talkBackImageView)
        container2.addSubview(lookCloserView)
        container2.addSubview(relatedTopicsView)
        container2.addSubview(buttonToBrowser)
        container2.backgroundColor  = UIColor.purpleColor()
        container2.userInteractionEnabled = true
       // container2.backgroundColor = UIColor.whiteColor()
        

        
        

        
        /////////////////////// Scroll View /////////////////////////////
//        let scrollViewHeight = (200 + collectionView.frame.size.height + pullDownLabel.frame.size.height + nearYouLabel.frame.size.height + 270)
        let scrollViewHeight : CGFloat = 2000.0
        let scrollViewFrame = CGSize(width: view.frame.size.width, height: scrollViewHeight)
        //self.scrollView1 = UIScrollView(frame: view.bounds)
        self.scrollView1 = UIScrollView(frame: CGRectMake(0, 60, self.view.frame.size.width , self.view.frame.size.height))
        self.scrollView1.delegate = self
        self.scrollView1.contentSize = scrollViewFrame
        self.scrollView1.addSubview(scrollViewContainer)
        self.scrollView1.addSubview(container2)
        self.scrollView1.userInteractionEnabled = true
        
        view.userInteractionEnabled = true
        view.addSubview(self.scrollView1)


    }


    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

//        let scrollViewWidth:CGFloat = self.scrollView.frame.width
//        let scrollViewHeight:CGFloat = self.scrollView.frame.height
//        
//        let imgOne = UIImageView(frame: CGRectMake(0, 0,scrollViewWidth, scrollViewHeight))
//        imgOne.image = UIImage(named: "connectionsImage.png")
//        let imgTwo = UIImageView(frame: CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight))
//        imgTwo.image = UIImage(named: "NearYouScreenShot.png")
//        
//        self.scrollView.addSubview(imgOne)
//        self.scrollView.addSubview(imgTwo)
//        
//        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 4, self.scrollView.frame.height)
//        self.scrollView.delegate = self
//        self.pageControl.currentPage = 0
    
    
    
    func toBrowserButtonAction(sender:UIButton!){
        NSLog("open in browser button pressed")
    }
    func relatedTopicsButtonAction(sender:UIButton!){
        NSLog("related topic button pressed")
    }
    func talkbackWebAction(sender:UIButton!){
        NSLog("web button pressed")
    }
    
    func talkbackTweetAction(sender:UIButton!){
        NSLog("tweet button pressed")
    }
    
    func exploreCockpit(sender:UIButton!){
        NSLog("explore cockpit")
        let webV:UIWebView = UIWebView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 49))
        webV.loadRequest(NSURLRequest(URL: NSURL(string: "http://airandspace.si.edu/explore-and-learn/multimedia/vr/?passthrough=/files/360/interior/A19960005000_1")!))
        webV.delegate = self;
        self.view.addSubview(webV)
    }
    func lookCloserMapAction(sender:UIButton!){

    }
    func lookCloserShareAction(sender:UIButton!){
        
    }
    func showGallery(sender:UIButton!){
        scrollView.hidden = false
        view.bringSubviewToFront(scrollView)
        //scrollView1.hidden = true
    //    pageControl.hidden = false
    }
    func mapButtonAction(sender:UIButton!){
 //       performSegueWithIdentifier("toMap", sender: self)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollViewContainer.contentOffset.y = scrollView1.contentOffset.y/2
        container2.frame = CGRect(x:0,y:self.view.frame.height - 50 - scrollView1.contentOffset.y,width:view.frame.width,height:4000);
    }

func configurePageControl() {
    // The total number of pages that are available is based on how many available colors we have.
    
    self.pageControl.numberOfPages = colors.count
    self.pageControl.currentPage = 0
    self.pageControl.tintColor = UIColor.redColor()
    self.pageControl.pageIndicatorTintColor = UIColor.blackColor()
    self.pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
    self.view.addSubview(pageControl)
    
    }
    
    
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPointMake(x, 0), animated: true)
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// collection view delegate methods ////////
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        return cell
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSizeMake(165, heights[indexPath.row])
//    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
   //     performSegueWithIdentifier("toDetail", sender: self)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}