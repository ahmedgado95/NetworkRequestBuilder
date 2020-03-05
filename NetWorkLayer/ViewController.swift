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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: SearchTableCell.self)
    }
    
    func getServData() {
        // creating request with the builder enum
        UserRouter.getSearch(fullAdress: "").send(SearchModel.self, then: getSearchResponse)
    }
    
    var getSearchResponse: CallResponse<SearchModel> {
        return {[weak self] (response) in
            switch response {
            case .failure(let error):
                // TODO: - Handle error as you want, printing isn't handling.
                print(error)
            case .success(let value):
                self?.searchSource = value.data!
                self?.tableView.reloadData()
            }
        }
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
        tableView.isHidden = false
        getServData()
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

