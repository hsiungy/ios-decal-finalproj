//
//  QRViewController.swift
//  QRCodeReader
//
//  Created by Placeholder on 5/2/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
var qrcodeImage: CIImage!

class QRViewController: UIViewController {

    @IBOutlet weak var qrcode: UIImageView!
    @IBOutlet weak var phoneNum: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var introText: UITextView!
    @IBOutlet weak var QRShop: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        introText.isHidden = true
        QRShop.isHidden = true
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(QRViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func generate(_ sender: UIButton) {
        let tel = "tel:"
        //let phone = "5105082637"
        let rawData = tel + phoneNum.text!
        let data = rawData.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        qrcodeImage = filter?.outputImage
        qrcode.image = UIImage(ciImage: qrcodeImage)
        displayQRCodeImage()
        return

    }
    func displayQRCodeImage() {
        //let scaleX = qrcode.frame.size.width / qrcodeImage.extent.size.width
        //let scaleY = qrcode.frame.size.height / qrcodeImage.extent.size.height
        let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: 10, y: 10))
        qrcode.image = UIImage(ciImage: transformedImage)
        qrcode.isHidden = false
        phoneNum.isHidden = true
        generateButton.isHidden = true
        introText.isHidden = false
        QRShop.isHidden = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
