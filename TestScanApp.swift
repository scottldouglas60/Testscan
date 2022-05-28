//
//  TestScanApp.swift
//  Shared
//
//  Created by Scott Douglas on 4/23/22.
//

import SwiftUI
import StandardCyborgFusion
import StandardCyborgUI
import UIKit

@UIApplicationMain
class AppDelegate:UIResponder, UIApplicationDelegate{
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //window = UIWindow(frame: UIScreen.main.bounds)
      let mainViewController = MyViewController()
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        return true
        }

    
}




/*
@main
   
    
struct TestScanApp: App {
  var body: some Scene {
       WindowGroup {
          ContentView()
       }
}
 
    
}

*/
class MyViewController: UIViewController, ScanningViewControllerDelegate {

    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
          super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.present(ScanningViewController(delegate: self), animated: true)
        var message:String = "";
        message = "Hello Swift"
         print(message)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // @IBAction for storyboards
    func presentScanningVC() {
       // self.present(ScanningViewController(delegate: self), animated: true)
        DispatchQueue.main.async {
            self.getTopMostViewController()?.present(ScanningViewController (delegate: self), animated: true)
        }
        //
    }


    // MARK: - ScanningViewControllerDelegate

    func scanningViewControllerDidCancel(_ controller: ScanningViewController) {
        dismiss(animated: true)
    }

    /*func scanningViewController(_ controller: ScanningViewController, didScan pointCloud: SCPointCloud)
         {
             let previewVC =   PointCloudPreviewViewController(pointCloud: pointCloud)
               controller.present(previewVC, animated: false)
        }*/
    func scanningViewController(_ controller: ScanningViewController, didScan pointCloud: SCPointCloud){
        let previewVC = PointCloudPreviewViewController(pointCloud: pointCloud,landmarks: nil)
        previewVC.leftButton.setTitle("Rescan", for: UIControl.State.normal)
        previewVC.leftButton.addTarget(self, action: #selector(previewRescanTapped(_:)), for: UIControl.Event.touchUpInside)
        previewVC.rightButton.setTitle("Save", for: UIControl.State.normal)
        previewVC.rightButton.addTarget(self, action: #selector(previewSaveTapped(_:)), for: UIControl.Event.touchUpInside)
        controller.present(previewVC, animated: false)
    }
        @objc func previewRescanTapped(_ sender: UIButton) {
            presentedViewController?.dismiss(animated: false)
        }

        @objc func previewSaveTapped(_ sender: UIButton) {
            // Do your thing with the scan here!
            if  let previewVC = presentedViewController as? PointCloudPreviewViewController,
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            {
                let plyURL = documentsURL.appendingPathComponent("Scan.ply")
                //let thumbnailURL = documentsURL.appendingPathComponent("Scan.jpeg")
                previewVC.pointCloud?.writeToPLY(atPath: plyURL.path)

              /*  if  let thumbnail = thumbnail,
                    let jpegData = thumbnail.jpegData(compressionQuality: 0.8)
                {
                    try? jpegData.write(to: scanThumbnailURL)
                }*/
            }

            presentedViewController?.dismiss(animated: true)
        }
        
    
    
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.windows[0].rootViewController

        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }

        return topMostViewController
    }
    

   


}// End My class
