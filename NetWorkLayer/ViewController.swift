//
//  ViewController.swift
//  NetWorkLayer
//
//  Created by A on 25/02/2020.
//  Copyright © 2020 Ahmed Gado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var searchSource = [SearchData]()
    var selectedDataImage : Data?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: SearchTableCell.self)
    }
    
    func getServData() {
        // creating request with the builder enum
        SearchRouter.getSearch(fullAdress: "").send(SearchModel.self, then: getSearchResponse)
    }
    
    var getSearchResponse: CallResponse<SearchModel> {
        return {[weak self] (response) in
            guard let self = self else {return}
            switch response {
            case .failure(let error):
                // TODO: - Handle error as you want, printing isn't handling.
                print(error)
            case .success(let value):
                self.searchSource = value.data!
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
    
 
    @IBAction func searchButtonPressed(_ sender: Any) {
        getServData()
    }
    
    @IBAction func uploadButtonPressed(_ sender: Any) {
        tappedMe()
    }
    
     func tappedMe()
      {
          print("Tapped on Image")
          let imagePickerController = UIImagePickerController()
          imagePickerController.delegate = self
          //               imagePickerController.view.tag = 1
          let actionSheet = UIAlertController(title: "photocamera", message: "choose a sourse", preferredStyle: .actionSheet)
          actionSheet.addAction(UIAlertAction(title: "camera", style: .default, handler: { (action:UIAlertAction) in
              if UIImagePickerController.isSourceTypeAvailable(.camera){
                  imagePickerController.sourceType = .camera
                  imagePickerController.modalPresentationStyle = .fullScreen
                  self.present(imagePickerController, animated: true, completion: nil)
              }else{
                  //show alert
                  let alert = UIAlertController(title: "camera Dont work", message: "Restart Your App", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
                  
                  self.present(alert, animated: true, completion: nil)
                  print("No camera")
              }
              
              
              
          }))
          actionSheet.addAction(UIAlertAction(title: "photoLibrary", style: .default, handler: { (action:UIAlertAction) in
              imagePickerController.sourceType = .photoLibrary
              imagePickerController.allowsEditing = true
              imagePickerController.modalPresentationStyle = .fullScreen
              self.present(imagePickerController, animated: true, completion: nil)
              
          }))
          actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
          self.present(actionSheet, animated: true, completion: nil)
      }
    func sendDateMU(){
        var uploadData = [UploadData]()
        let uPDaTa = UploadData.init(data: selectedDataImage!, fileName: "Image.jpg", mimeType: "image/jpg", name: "photo")
        uploadData.append(uPDaTa)
        SearchRouter.register(name: "Ahmed", email: "Ahmed@admin.net", password: "123456", code: "+20", phone: "01258874378").send(RegisterModel.self, data: uploadData, progress: { (Progress) in
            print(Progress)
        }, then: getRegisterResponse)
    }
    //////
    var getRegisterResponse : CallResponse<RegisterModel>{
         return {[weak self] (response) in
            guard self != nil else {return}
             switch response {
             case .failure(let error):
                 // TODO: - Handle error as you want, printing isn't handling.
                 print(error)
             case .success(let value):
                print("welcome" , value.message ?? "")
             }
         }
     }
}


extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as SearchTableCell
        let item = searchSource[indexPath.row]
        cell.configerCell(item: item)
        return cell
    }
}
extension ViewController : UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            
            selectedImage = editedImage
//                        let imgData:Data = (selectedImage!).pngData()! as Data
            //            let imageData : Data = UIImageJPEGRepresentation(selectedImage!, 0.75) as! Data
            let imageData = selectedImage!.jpegData(compressionQuality: 0.2)!
            
            selectedDataImage = imageData
            sendDateMU()
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
//                        let imageData:Data = (selectedImage!).pngData()! as Data
            let imageData = selectedImage!.jpegData(compressionQuality: 0.2)!
            selectedDataImage = imageData
            //
            sendDateMU()
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
}

