//  I'ma Unicorn
//
//  Created by Franky Aguilar on 7/27/12.
//  Copyright (c) 2012 99centbrains Inc. All rights reserved.
//  @99centbrains - http://99centbrains.com
//  ALL ARTWORK AND DESIGN OWNED BY 99centbrains, not for reproduction or redistribution
//

import UIKit
import AVFoundation
import AudioToolbox

@objcMembers public class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var ibo_getphoto: UIView!
    
    private var popController: UIPopoverController?
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View Did Appear")
    }
    
    // MARK: - Photos
    
    @IBAction func iba_photoTake(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            present(picker, animated: true, completion: nil)
        } else {
            iba_photoChoose(sender)
        }
    }
    
    @IBAction func iba_photoChoose(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func iba_shareApp(_ sender: UIButton) {
        let shareText = kShareDescription
        guard let shareURL = URL(string: kShareURL) else { return }
        
        let activityItems: [Any] = [shareText, shareURL]
        let excludeActivities: [UIActivity.ActivityType] = [
            .addToReadingList,
            .assignToContact,
            .print
        ]
        
        let activityController = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        activityController.excludedActivityTypes = excludeActivities
        
        activityController.completionWithItemsHandler = { activityType, completed, returnedItems, error in
            // Handle completion if needed
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            popController = UIPopoverController(contentViewController: activityController)
            popController?.contentSize = CGSize(width: 500, height: 425)
            let rect = sender.convert(sender.bounds, to: self.view)
            popController?.present(from: rect, in: self.view, permittedArrowDirections: .up, animated: true)
            SVProgressHUD.dismiss()
        } else {
            SVProgressHUD.dismiss()
            present(activityController, animated: true, completion: nil)
        }
    }
    
    @IBAction func iba_Facebook(_ sender: Any) {
        guard let url = URL(string: "http://facebook.com/99centbrains") else { return }
        let modalWeb = SVModalWebViewController(url: url)!
        present(modalWeb, animated: true, completion: nil)
    }
    
    @IBAction func iba_Twitter(_ sender: Any) {
        guard let url = URL(string: "http://twitter.com/catgnaw") else { return }
        let modalWeb = SVModalWebViewController(url: url)!
        present(modalWeb, animated: true, completion: nil)
    }
    
    @IBAction func iba_Insta(_ sender: Any) {
        guard let url = URL(string: "http://instagram.com/catgnaw") else { return }
        let modalWeb = SVModalWebViewController(url: url)!
        present(modalWeb, animated: true, completion: nil)
    }
    
    @IBAction func iba_Web(_ sender: Any) {
        guard let url = URL(string: "http://catgnaw.com") else { return }
        let modalWeb = SVModalWebViewController(url: url)!
        present(modalWeb, animated: true, completion: nil)
    }
    
    // MARK: - External URL Handling
    
    func handleDocumentOpenURL(_ url: String) {
        guard !url.isEmpty, let imageURL = URL(string: url) else { return }
        
        do {
            let data = try Data(contentsOf: imageURL)
            if let image = UIImage(data: data) {
                let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
                if let playViewController = storyboard.instantiateViewController(withIdentifier: "seg_PlayViewController") as? PlayViewController {
                    playViewController.userImage = image
                    present(playViewController, animated: false, completion: nil)
                }
            }
        } catch {
            print("Error loading image: \(error)")
        }
    }
    
    func handleExternalURL(_ url: String) {
        guard let urlToOpen = URL(string: url) else { return }
        UIApplication.shared.open(urlToOpen, options: [:], completionHandler: nil)
    }
    
    func handleInternalURL(_ url: String) {
        guard let urlToOpen = URL(string: url) else { return }
        UIApplication.shared.open(urlToOpen, options: [:], completionHandler: nil)
    }
    
    // MARK: - Image Editing
    
    private func editedImage(fromMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) -> UIImage? {
        let finalImageSize = CGSize(width: 700, height: 700)
        let fillColor = UIColor.clear
        
        guard let sourceImage = info[.originalImage] as? UIImage,
              let cropRectValue = info[.cropRect] as? CGRect,
              let sourceImageRef = sourceImage.cgImage else {
            return nil
        }
        
        let cropRect = cropRectValue
        
        // Transform crop rect to match source image orientation
        let rectTransform = transformSize(sourceImage.size, orientation: sourceImage.imageOrientation)
        let transformedRect = cropRect.applying(rectTransform)
        
        // Get the cropped region
        guard let cropRectImage = sourceImageRef.cropping(to: transformedRect) else {
            return nil
        }
        
        // Calculate aspect fit size
        let horizontalRatio = finalImageSize.width / CGFloat(cropRectImage.width)
        let verticalRatio = finalImageSize.height / CGFloat(cropRectImage.height)
        let ratio = min(horizontalRatio, verticalRatio)
        let aspectFitSize = CGSize(
            width: CGFloat(cropRectImage.width) * ratio,
            height: CGFloat(cropRectImage.height) * ratio
        )
        
        // Create bitmap context
        guard let colorSpace = cropRectImage.colorSpace,
              let context = CGContext(
                data: nil,
                width: Int(finalImageSize.width),
                height: Int(finalImageSize.height),
                bitsPerComponent: cropRectImage.bitsPerComponent,
                bytesPerRow: 0,
                space: colorSpace,
                bitmapInfo: cropRectImage.bitmapInfo.rawValue
              ) else {
            print("NULL CONTEXT!")
            return nil
        }
        
        // Fill with background color
        context.setFillColor(fillColor.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: finalImageSize.width, height: finalImageSize.height))
        
        // Rotate and transform context based on source image orientation
        let contextTransform = transformSize(finalImageSize, orientation: sourceImage.imageOrientation)
        context.concatenate(contextTransform)
        
        // Set high quality interpolation
        context.interpolationQuality = .high
        
        // Draw image centered
        let drawRect = CGRect(
            x: (finalImageSize.width - aspectFitSize.width) / 2,
            y: (finalImageSize.height - aspectFitSize.height) / 2,
            width: aspectFitSize.width,
            height: aspectFitSize.height
        )
        context.draw(cropRectImage, in: drawRect)
        
        // Create final image
        guard let finalImageRef = context.makeImage() else {
            return nil
        }
        
        let resultImage = UIImage(cgImage: finalImageRef)
        
        // Convert to PNG data and back to ensure consistency
        guard let pngData = resultImage.pngData() else {
            return resultImage
        }
        
        return UIImage(data: pngData)
    }
    
    private func transformSize(_ imageSize: CGSize, orientation: UIImage.Orientation) -> CGAffineTransform {
        var transform = CGAffineTransform.identity
        
        switch orientation {
        case .left: // EXIF #8
            let txTranslate = CGAffineTransform(translationX: imageSize.height, y: 0.0)
            let txCompound = txTranslate.rotated(by: .pi / 2)
            transform = txCompound
            
        case .down: // EXIF #3
            let txTranslate = CGAffineTransform(translationX: imageSize.width, y: imageSize.height)
            let txCompound = txTranslate.rotated(by: .pi)
            transform = txCompound
            
        case .right: // EXIF #6
            let txTranslate = CGAffineTransform(translationX: 0.0, y: imageSize.width)
            let txCompound = txTranslate.rotated(by: -.pi / 2)
            transform = txCompound
            
        case .up, .upMirrored, .downMirrored, .leftMirrored, .rightMirrored:
            // EXIF #1 - do nothing, or ignore mirrored cases
            break
            
        @unknown default:
            break
        }
        
        return transform
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            popController?.dismiss(animated: true)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        
        guard let playViewController = storyboard.instantiateViewController(withIdentifier: "seg_PlayViewController") as? PlayViewController else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        picker.dismiss(animated: true) { [weak self] in
            playViewController.userImage = self?.editedImage(fromMediaWithInfo: info)
            self?.navigationController?.pushViewController(playViewController, animated: true)
        }
    }
}

// MARK: - UIPopoverControllerDelegate

extension ViewController: UIPopoverControllerDelegate {
    
    public func popoverControllerDidDismissPopover(_ popoverController: UIPopoverController) {
        popController = nil
        print("PopOver NIL")
    }
}
