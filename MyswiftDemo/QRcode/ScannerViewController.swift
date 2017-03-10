//
//  ScannerViewController.swift
//  QRCode
//
//
//  Created by Liyanjun on 2017/1/14.
//  Copyright © 2017年 hand. All rights reserved.
//import UIKit
import AVFoundation
import UIKit
import Photos

class ScannerViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //相机显示视图
    let cameraView = ScannerBackgroundView(frame: UIScreen.main.bounds ,scanResultPlaceHolder:"请输入扫描设备")
    
    
    let captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addrightMenue()
        
        self.view.backgroundColor = UIColor.black
//        //设置导航栏
//                let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(ScannerViewController.selectPhotoFormPhotoLibrary(_:)))
//                self.navigationItem.rightBarButtonItem = barButtonItem
//        
        //
        self.view.addSubview(cameraView)
        
        //初始化捕捉设备（AVCaptureDevice），类型AVMdeiaTypeVideo
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        let input :AVCaptureDeviceInput
        
        //创建媒体数据输出流
        let output = AVCaptureMetadataOutput()
        
        //捕捉异常
        do{
            debugPrint("进入do循环")
            //创建输入流
            input = try AVCaptureDeviceInput(device: captureDevice)
            
            //把输入流添加到会话
            captureSession.addInput(input)
            
            //把输出流添加到会话
            captureSession.addOutput(output)
        }catch {
            print("异常")
        }
        
        //创建串行队列
        let dispatchQueue = DispatchQueue(label: "queue", attributes: [])
        
        //设置输出流的代理
        output.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        
        //设置输出媒体的数据类型
        output.metadataObjectTypes = NSArray(array: [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]) as [AnyObject]
        
        //创建预览图层
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        //设置预览图层的填充方式
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        //设置预览图层的frame
        videoPreviewLayer?.frame = cameraView.bounds
        
        //将预览图层添加到预览视图上
        cameraView.layer.insertSublayer(videoPreviewLayer!, at: 0)
        
        //设置扫描范围
        output.rectOfInterest = CGRect(x: 0.2, y: 0.15, width: 0.6, height: 0.6)
        
    }
    
    
    //增加右导航，显示手电筒
    func addrightMenue()  {
        
        let rightButton = UIBarButtonItem.init(image: UIImage.init(named: "flashlight"), style: .plain, target: self, action: #selector(rightMenueClick(_:)))
        
      
        
        
        
        self.navigationItem.setRightBarButton(rightButton, animated: true)
        
        
    }
    
    //MARK:右边导航点击
    //MARK:打开手电筒
    func rightMenueClick(_ sender:UIButton)  {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        if device == nil {
            sender.isEnabled = false
            return
        }
        if device?.torchMode == AVCaptureTorchMode.off{
            do {
                try device?.lockForConfiguration()
            } catch {
                return
            }
            device?.torchMode = .on
            device?.unlockForConfiguration()
            sender.isSelected = true
        }else {
            do {
                try device?.lockForConfiguration()
            } catch {
                return
            }
            device?.torchMode = .off
            device?.unlockForConfiguration()
            sender.isSelected = false
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.scannerStart()
    }
    
    func scannerStart(){
        captureSession.startRunning()
        debugPrint("开始扫描")
        
    }
    
    func scannerStop() {
        captureSession.stopRunning()
        debugPrint("结束扫描")
        
        cameraView.stopScan()
    }
    
    
    
    //扫描代理方法
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects != nil && metadataObjects.count > 0 {
            let metaData = metadataObjects.first
            
            debugPrint("进入代理方法")
            
            debugPrint("扫描结果是=======\((metaData as AnyObject).stringValue ?? " ")")
            //            print((metaData as AnyObject).stringValue ?? " ")
            DispatchQueue.main.async(execute: {
                let result:String = (metaData as AnyObject).stringValue ?? " "
                
                self.cameraView.scanResultD(reslut: result)
                
                self.cameraView.isUserInteractionEnabled = false
                
            })
            
            self.scannerStop()
            
            //            captureSession.stopRunning()
        }
        
        
    }
    
    
    
    //从相册中选择图片
    func selectPhotoFormPhotoLibrary(_ sender : AnyObject){
        
        if self.PhotoLibraryPermissions(){
            let picture = UIImagePickerController()
            picture.sourceType = UIImagePickerControllerSourceType.photoLibrary
            picture.delegate = self
            self.present(picture, animated: true, completion: nil)
            
            
        }else{
            
            
            self.displayAlertControllerWithMessage("该设备没有相册权限")
        }
        
        
    }
    
    //选择相册中的图片完成，进行获取二维码信息
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage]
        
        let imageData = UIImagePNGRepresentation(image as! UIImage)
        
        let ciImage = CIImage(data: imageData!)
        
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        
        let array = detector?.features(in: ciImage!)
        
        let result : CIQRCodeFeature = array!.first as! CIQRCodeFeature
        
        
        debugPrint("扫描结果是=======\((result.messageString))")
        
        
        let resultView = WebViewController()
        resultView.url = result.messageString
        
        self.navigationController?.pushViewController(resultView, animated: true)
        picker.dismiss(animated: true, completion: nil)
        print(result.messageString ?? "错误信息")
    }
    
   
    
    
    
    
    /**
     判断相册权限
     
     - returns: 有权限返回ture， 没权限返回false
     */
    
    func PhotoLibraryPermissions() -> Bool {
        
        
        
        let library:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        if(library == PHAuthorizationStatus.denied || library == PHAuthorizationStatus.restricted){
            return false
        }else {
            return true
        }
        
    }
    
}
