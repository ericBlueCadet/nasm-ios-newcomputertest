//
//  ViewController.swift
//  NASM-ios-alpha
//
//  Created by Eric  Gilbert on 11/18/15.
//  Copyright © 2015 Eric  Gilbert. All rights reserved.
//



// This class sets up the Paging Controller for the main View Controllers

import UIKit
import PagingMenuController
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate{
    
    var locationManager:CLLocationManager!
    var bytes: NSMutableData?
    var JSONObjects: NSArray?
//    var viewControllers = NSMutableArray()
    var museumObjects = [ObjectModel]()
//    var museumObject : ObjectModel
    
    enum JSONError: String, ErrorType {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getJSON()


        navigationController?.navigationBar.barTintColor = UIColorFromRGB(0x012032)

        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        // initiaite view controllers for paging slider
        let atTheMuseum = self.storyboard!.instantiateViewControllerWithIdentifier("AtTheMuseum") as! AtTheMuseumVC
        // pass museumObjects to AtTheMuseumVC
        atTheMuseum.museumObjects = museumObjects
        atTheMuseum.title = "Near You"
        
        
        let topStories = TopStoriesVC()
        topStories.title = "Top Stories"
        
        let exhibitions = ExhibitionsVC()
        exhibitions.title = "Exhibitions"
        
        let events = EventsVC()
        events.title = "Events"
        
        let talkBack = TalkBackVC()
        talkBack.title = "Talk Back"
        
        let social = SocialVC()
        social.title = "Social"
        
        let recommended = RecommendedVC()
        recommended.title = "Recommended"
        
        
        //array of view controllers to be displayed
        let viewControllers = [atTheMuseum, topStories, exhibitions,events,talkBack,social,recommended]
        
        
        // define options for paging controller
        let options = PagingMenuOptions()
        options.backgroundColor = UIColorFromRGB(0x012032)
        options.selectedBackgroundColor = UIColorFromRGB(0x012032)
        options.textColor = UIColorFromRGB(0x8fcaed)
        options.selectedTextColor = UIColorFromRGB(0x8fcaed)
        options.menuItemMargin = 5
        options.menuHeight = 60
        options.menuDisplayMode = .Infinite(widthMode: PagingMenuOptions.MenuItemWidthMode.Flexible)
      //  options.menuDisplayMode = .Standard(widthMode: PagingMenuOptions.MenuItemWidthMode.Fixed(width: 100), centerItem: false, scrollingMode: PagingMenuOptions.MenuScrollingMode.PagingEnabled)
        let pagingMenuController = PagingMenuController(viewControllers: viewControllers, options: options)
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMoveToParentViewController(self)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // use rgb for UIcolor
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // retrieves JSON data
    func getJSON() {
        let urlPath = "http://files.bluecadet.com/nasm/prototype_feed.json"
        guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");
            return }
        let request = NSMutableURLRequest(URL:endpoint)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                guard let dat = data else { throw JSONError.NoData }
                guard let json = try NSJSONSerialization.JSONObjectWithData(dat, options: []) as? NSArray else { throw JSONError.ConversionFailed }
                self.JSONObjects = json
                self.parseJSON()
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch {
                print(error)
            }
            }.resume()
    }
    
    // parses incoming JSON data and sets it to global variable: musueumObjects which will be passed to other classes
    func parseJSON (){
     
        for mi in JSONObjects as! [NSDictionary] {
            
            let museumObject =  ObjectModel()
            //let titleString : String
            let titleString = mi.objectForKey("title") as! String
           // let floor = mi.objectForKey("floor") as! String
           // museumObject.floor = floor
            museumObject.title = titleString
            museumObjects.append(museumObject)


        }

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

