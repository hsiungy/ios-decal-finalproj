//
//  AddItemViewController.swift
//  QRCodeReader
//
//  Created by Placeholder on 5/1/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import AVFoundation

class AddItemViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var sendImageButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    @IBOutlet weak var imageViewOverlay: UIImageView!
    // manages real time capture activity from input devices to create output media (photo/video)
    let captureSession = AVCaptureSession()
    
    // the device we are capturing media from (i.e. front camera of an iPhone 7)
    var captureDevice : AVCaptureDevice?
    
    // view that will let us preview what is being captured from the captureSession
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    // Object used to capture a single photo from our capture device
    let photoOutput = AVCapturePhotoOutput()
    
    // The image to send as a Snap
    var selectedImage = UIImage()
    @IBAction func takePhoto(_ sender: UIButton) {
        photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        toggleUI(isInPreviewMode: true)
    }
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let photoSampleBuffer = photoSampleBuffer {
            // First, get the photo data using the parameters above
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
            
            // Then use this data to create a UIImage, and set it equal to `selectedImage`
            selectedImage = UIImage(data: photoData!)!
            
            // This method updates the UI so the send button appears (no need to edit it)
            toggleUI(isInPreviewMode: true)
        }
    }
    /// Creates a new capture session, and starts updating it using the user's
    /// input device
    ///
    /// - Parameter devicePostion: location of user's camera - you'll need to figure out how to use this
    func captureNewSession(devicePostion: AVCaptureDevicePosition?) {
        // specifies that we want high quality video captured from the device
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        if let deviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInWideAngleCamera],
                                                                        mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.unspecified) {
            // Iterate through available devices until we find one that works
            for device in deviceDiscoverySession.devices {
                // only use device if it supports video
                if (device.hasMediaType(AVMediaTypeVideo)) {
                    if (device.position == AVCaptureDevicePosition.back) {
                        captureDevice = device
                        if captureDevice != nil {
                            // Now we can begin capturing the session using the user's device!
                            do {
                                // TODO: uncomment this line, and add a parameter to `addInput`
                                try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
                                if captureSession.canAddOutput(photoOutput) {
                                    captureSession.addOutput(photoOutput)
                                }
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                            if let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) {
                                view.layer.addSublayer(previewLayer)
                                previewLayer.frame = view.layer.frame
                                // TODO: start running your session
                                captureSession.startRunning()
                            }
                        }
                    }
                }
            }
        }
    }
    func toggleUI(isInPreviewMode: Bool) {
        if isInPreviewMode {
            imageViewOverlay.image = selectedImage
            takePhotoButton.isHidden = true
            sendImageButton.isHidden = false
            cancelButton.isHidden = false
        }
        else {
            takePhotoButton.isHidden = false
            sendImageButton.isHidden = true
            cancelButton.isHidden = true
            imageViewOverlay.image = nil
        }
        
        // Makes sure that all of the buttons appear in front of the previewLayer
        view.bringSubview(toFront: imageViewOverlay)
        view.bringSubview(toFront: takePhotoButton)
        view.bringSubview(toFront: cancelButton)
        view.bringSubview(toFront: sendImageButton)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: call captureNewSession here
        tabBarController?.tabBar.isHidden = true
        captureNewSession(devicePostion: nil)
        toggleUI(isInPreviewMode: false)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // hide the navigation bar while we are in this view
        navigationController?.navigationBar.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func selectImage(_ image: UIImage) {
        //The image being selected is passed in as "image".
        selectedImage = image
    }
    @IBAction func CancelPressed(_ sender: UIButton) {
        selectedImage = UIImage()
        toggleUI(isInPreviewMode: false)
    }
    @IBAction func sendImage(_ sender: UIButton) {
        performSegue(withIdentifier: "cameraToDescrip", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.navigationBar.isHidden = false
        let destination = segue.destination as! DescriptionViewController
        destination.chosenImage = selectedImage
        toggleUI(isInPreviewMode: false)
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
