//
//  VacancyRespondFormViewController.swift
//  RCGApp
//
//  Created by iFoxxy on 12.05.15.
//  Copyright (c) 2015 LightBlueFox. All rights reserved.
//

import UIKit

class VacancyRespondFormViewController: UIViewController {
    
    var vacancyId: Int?

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var name: RCGTextFieldClass!
    @IBOutlet weak var lastName: RCGTextFieldClass!
    @IBOutlet weak var telephone: RCGTextFieldClass!
    
    @IBOutlet weak var submitButtonTopMargin: NSLayoutConstraint!
    var textFieldValue = "";
    
    @IBOutlet weak var submitButtonBottomSpacingConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollViewBottomMargin: NSLayoutConstraint!
    
    
    @IBOutlet weak var errorbox: UILabel!
    
    //Mark: константа для хранения значения нижнего отступа ScrollView
    var scrollViewBottomMarginConstant : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mark: заголовок и кнопка "Назад"
        self.navigationItem.title = "ОТКЛИК НА ВАКАНСИЮ"
        let buttonBack: UIButton = UIButton.buttonWithType(.Custom) as! UIButton;
        buttonBack.frame = CGRectMake(0, 0, 40, 40);
        buttonBack.setImage(UIImage(named: "backButton"), forState: .Normal);
        buttonBack.addTarget(self, action: "leftNavButtonClick:", forControlEvents: UIControlEvents.TouchUpInside);
        var leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: buttonBack);
        self.navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: false);
        
        
        //Mark: Скрывать, клавиатуру при тапе по скрол вью
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard:");
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
        
        
        //Mark: Сжимать размер скрол вью при появлении клавы
        self.scrollViewBottomMarginConstant = self.scrollViewBottomMargin.constant;
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
        
        //Mark: скрыли бокс с ошибкой
        
        errorbox.hidden = true;
        
        //Mark: Проставили rightView
        /*var imageView = UIImageView();
        imageView.image = UIImage(named: "textRectangle");
        imageView.frame = CGRect(x: 0, y: 0, width: 14, height: 14);
        name.rightView = imageView
        lastName.rightView = imageView
        telephone.rightView = imageView
        
        name.rightViewMode = UITextFieldViewMode.Always;
        //lastName.rightViewMode = UITextFieldViewMode.Always;
        //telephone.rightViewMode = UITextFieldViewMode.Always;*/
        
    }
    func keyboardWillShowNotification(notification: NSNotification){
        if let userInfo = notification.userInfo {
            if let frameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let frame = frameValue.CGRectValue()
                self.scrollViewBottomMargin.constant = self.scrollViewBottomMarginConstant + frame.size.height
                
                switch (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber) {
                case let (.Some(duration), .Some(curve)):
                    
                    let options = UIViewAnimationOptions(curve.unsignedLongValue)
                    
                    UIView.animateWithDuration(
                        NSTimeInterval(duration.doubleValue),
                        delay: 0,
                        options: options,
                        animations: {
                            UIApplication.sharedApplication().keyWindow?.layoutIfNeeded()
                            return
                        }, completion: { finished in
                    })
                default:
                    
                    break
                }
            }
        }
    }
    func keyboardWillHideNotification(notification: NSNotification){
        self.scrollViewBottomMargin.constant = self.scrollViewBottomMarginConstant
        if let userInfo = notification.userInfo {
            
            switch (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber) {
            case let (.Some(duration), .Some(curve)):
                
                let options = UIViewAnimationOptions(curve.unsignedLongValue)
                
                UIView.animateWithDuration(
                    NSTimeInterval(duration.doubleValue),
                    delay: 0,
                    options: options,
                    animations: {
                        UIApplication.sharedApplication().keyWindow?.layoutIfNeeded()
                        return
                    }, completion: { finished in
                })
            default:
                break
            }
        }
    }
    
    @IBAction func textFieldEditingDone(sender: UITextField) {
        if sender.text != "" {
            var imageView = UIImageView();
            imageView.image = UIImage(named: "textRectangleOk");
            imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 14);
            imageView.contentMode = UIViewContentMode.Left;
            sender.rightView = imageView;
        }
        else
        {
            var imageView = UIImageView();
            imageView.image = UIImage(named: "textRectangle");
            imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 14);
            imageView.contentMode = UIViewContentMode.Left;
            sender.rightView = imageView;
        }
    }
    
    
    @IBAction func submitButtonClick(sender: UIButton) {
        if name.text == "" || lastName.text == "" || telephone.text == ""
        {
            submitButtonTopMargin.constant = 40.0;
            errorbox.text! = "Все поля обязательны к заполнению."
            errorbox.hidden = false;
        }
        else {
            errorbox.hidden = true;
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var request = HTTPTask();
            let replyText = "{lastname:\(lastName.text);name:\(name.text);telephone:\(telephone.text)}"
            let requestUrl = "http://agency.cloudapp.net/vacancy/\(vacancyId!)/replies"
            let params: Dictionary<String,AnyObject> = ["userId":"654654","commentType":"vacancyReply","text":replyText];

            request.PUT(requestUrl, parameters: params, completionHandler: {(response: HTTPResponse) in
                if let err = response.error {
                    println("error: " + err.localizedDescription)
                }
                if let resp: AnyObject = response.responseObject {
                    let str = NSString(data: resp as! NSData, encoding: NSUTF8StringEncoding)
                    println("Response \(str)")
                }
                println(response.statusCode!)
                println(response.text)
            })
            UIApplication.sharedApplication().endIgnoringInteractionEvents()

        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func leftNavButtonClick(sender: UIButton!)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //func keyboardWillShow(notification: NSNotification){
        
    //}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideKeyboard(sender: AnyObject) {
        self.scrollView.endEditing(true)
    }
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
