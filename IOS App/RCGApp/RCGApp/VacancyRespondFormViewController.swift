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
        
        //Добавляем кнопку для вызова sideBar
        
        let revealViewController = self.revealViewController() as SWRevealViewController
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //self.navigationController?.navigationBarHidden = false;
        
        let revealButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem(rawValue: 15)!, target: revealViewController, action: Selector("rightRevealToggle:"))
        revealButton.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = revealButton
        
        //Mark: заголовок и кнопка "Назад"
        self.navigationItem.title = "ОТКЛИК НА ВАКАНСИЮ"
        let buttonBack: UIButton = UIButton(type: .Custom);
        buttonBack.frame = CGRectMake(0, 0, 40, 40);
        buttonBack.setImage(UIImage(named: "backButton"), forState: .Normal);
        buttonBack.setImage(UIImage(named: "backButtonSelected"), forState: UIControlState.Highlighted)
        buttonBack.addTarget(self, action: "leftNavButtonClick:", forControlEvents: UIControlEvents.TouchUpInside);
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: buttonBack);
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
                    
                    let options = UIViewAnimationOptions(rawValue: curve.unsignedLongValue)
                    
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
                
                let options = UIViewAnimationOptions(rawValue: curve.unsignedLongValue)
                
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
            let imageView = UIImageView();
            imageView.image = UIImage(named: "textRectangleOk");
            imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 14);
            imageView.contentMode = UIViewContentMode.Left;
            sender.rightView = imageView;
        }
        else
        {
            let imageView = UIImageView();
            imageView.image = UIImage(named: "textRectangle");
            imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 14);
            imageView.contentMode = UIViewContentMode.Left;
            sender.rightView = imageView;
        }
    }
    
    @available(iOS 8.0, *)
    @IBAction func submitButtonClick(sender: UIButton) {
        if name.text == "" || lastName.text == "" || telephone.text == ""
        {
            let failureNotification = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
            failureNotification.mode = MBProgressHUDMode.Text
            failureNotification.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            //failureNotification.color = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 0.8);
            failureNotification.labelFont = UIFont(name: "Roboto Regular", size: 12)
            failureNotification.labelText = "Ошибка"
            failureNotification.detailsLabelText = "Все поля обязательны для заполнения"
            failureNotification.hide(true, afterDelay: 3)
        }
        else {
            let loadingNotification = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.Indeterminate
            loadingNotification.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            //loadingNotification.color = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 0.8);
            loadingNotification.labelFont = UIFont(name: "Roboto Regular", size: 12)
            loadingNotification.labelText = "Отправляем"
            
            let request = HTTPTask()
                let replyText = "{\"lastname\":\"\(lastName.text!)\",\"name\":\"\(name.text!)\",\"telephone\":\"\(telephone.text!)\"}"
                let requestUrl = "http://agency.cloudapp.net/vacancy/\(vacancyId!)/replies"
                let params: Dictionary<String,AnyObject> = ["userId":"654654","commentType":"vacancyReply","text":replyText];
                
                request.PUT(requestUrl, parameters: params, completionHandler: {(response: HTTPResponse) in
                    if let err = response.error {
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            loadingNotification.hide(true)
                            
                            let failureNotification = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
                            failureNotification.mode = MBProgressHUDMode.Text
                            failureNotification.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
                            //failureNotification.color = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 0.8);
                            failureNotification.labelFont = UIFont(name: "Roboto Regular", size: 12)
                            failureNotification.labelText = "Ошибка"
                            failureNotification.detailsLabelText = err.localizedDescription
                            failureNotification.hide(true, afterDelay: 3)
                        }
                        print("error: " + err.localizedDescription)
                    }
                    else if let resp: AnyObject = response.responseObject {
                        _ = NSString(data: resp as! NSData, encoding: NSUTF8StringEncoding)
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            loadingNotification.hide(true)
                            
                            let successNotification = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
                            successNotification.mode = MBProgressHUDMode.Text
                            successNotification.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
                            successNotification.color = UIColor(red: 0/255, green: 194/255, blue: 18/255, alpha: 0.8);
                            successNotification.labelFont = UIFont(name: "Roboto Regular", size: 12)
                            successNotification.labelText = "Отклик отправлен"
                            successNotification.detailsLabelText = "Мы вам перезвоним!"
                            
                            successNotification.hide(true, afterDelay: 3)
                        }
                    }
                })
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
