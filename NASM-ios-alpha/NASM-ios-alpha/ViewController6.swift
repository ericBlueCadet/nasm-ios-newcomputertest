import UIKit

class ViewController6: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGrayColor()
        
        let textLabel = UILabel(frame: CGRectMake(0, 0, 200, 30))
        textLabel.center = view.center
        textLabel.textAlignment = .Center
        textLabel.font = UIFont.systemFontOfSize(24)
        textLabel.text = "Social"
        view.addSubview(textLabel)
    }
}