//
//  ContactUsViewController.swift
//  RCGApp
//
//  Created by iFoxxy on 12.05.15.
//  Copyright (c) 2015 LightBlueFox. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var nameTextField: RCGTextFieldClass!
    @IBOutlet weak var emailTextField: RCGTextFieldClass!
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageTextRectangle: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "ОБРАТНАЯ СВЯЗЬ"
        self.navigationController?.navigationBar.translucent = false;
        //Добавляем кнопку для вызоа sideBar
        
        let revealViewController = self.revealViewController() as SWRevealViewController
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //self.navigationController?.navigationBarHidden = false;
        
        let revealButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem(rawValue: 15)!, target: revealViewController, action: Selector("rightRevealToggle:"))
        revealButton.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = revealButton
        
        //Mark: Скрывать, клавиатуру при тапе по скрол вью
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard:");
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
        
        messageTextView.textContainerInset = UIEdgeInsetsMake(8, 3, 8, 30)
        messageTextView.layer.borderWidth = 1
        messageTextView.layer.cornerRadius = 5
        messageTextView.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.2).CGColor
        messageTextRectangle.selected = false;
        
        messageTextView.delegate = self
        messageTextView.text = "Текст сообщения"
        messageTextView.textColor = UIColor(red: 199/255, green: 199/255, blue: 205/255, alpha: 1)
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
    func textViewDidBeginEditing(textView: UITextView) {
        if messageTextView.textColor == UIColor(red: 199/255, green: 199/255, blue: 205/255, alpha: 1)
        {
            messageTextView.text = ""
            messageTextView.textColor = UIColor.darkGrayColor()
        }
    }
    func textViewDidEndEditing(textView: UITextView) {
        if messageTextView.text == ""
        {
            messageTextView.text = "Текст сообщения"
            messageTextView.textColor = UIColor(red: 199/255, green: 199/255, blue: 205/255, alpha: 1)
            messageTextRectangle.selected = false
        }
        else
        {
            messageTextRectangle.selected = true
        }
        
    }
    @available(iOS 8.0, *)
    @IBAction func submitButtonClick(sender: UIButton) {
        if messageTextView.textColor == UIColor(red: 199/255, green: 199/255, blue: 205/255, alpha: 1) || nameTextField.text == "" || emailTextField.text == ""
        {
            let failureNotification = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
            failureNotification.mode = MBProgressHUDMode.Text
            failureNotification.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3);
            //failureNotification.color = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 0.8);
            failureNotification.labelFont = UIFont(name: "Roboto Regular", size: 12)
            failureNotification.labelText = "Ошибка"
            failureNotification.detailsLabelText = "Все поля обязательны для заполнения"
            failureNotification.hide(true, afterDelay: 3)
        }
        else
        {
            let loadingNotification = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.Indeterminate
            loadingNotification.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            //loadingNotification.color = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 0.8);
            loadingNotification.labelFont = UIFont(name: "Roboto Regular", size: 12)
            loadingNotification.labelText = "Отправляем..."
            
            let request = HTTPTask();
            let requestUrl = "http://agency.cloudapp.net/feedbacks"
            let params: Dictionary<String,AnyObject> = ["name":nameTextField.text!, "email":emailTextField.text!, "text":messageTextView.text];
            
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
                        successNotification.labelText = "Спасибо"
                        successNotification.detailsLabelText = "Сообщение отправлено!"
                        
                        successNotification.hide(true, afterDelay: 3)
                    }
                }
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideKeyboard(sender: AnyObject) {
        self.scrollView.endEditing(true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    

}
