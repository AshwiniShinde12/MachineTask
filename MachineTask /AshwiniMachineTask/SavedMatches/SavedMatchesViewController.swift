//
//  SavedMatchesViewController.swift
//  AshwiniMachineTask
//


import UIKit

class SavedMatchesViewController: UIViewController {
    
    @IBOutlet weak var tableSavedlist: UITableView!
    var isActive : Bool?
    var venune = [Venues]()
    var indexP = IndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.topItem?.title = "Saved Matches"
        tableSavedlist.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        dataModal()
    }
    func dataModal()
    {
        venune = DatabaseHelper.shareInstant.getVenueData()
        DispatchQueue.main.async {
            self.tableSavedlist.reloadData()
        }
    }
}
extension SavedMatchesViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venune.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableSavedlist.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SavedListTableViewCell
        cell.backView.addShadow(radius: 20)
        let indx = venune[indexPath.row]
        cell.lblSId.text = indx.id
        cell.lblSName.text = indx.name
        cell.btnSStar.tag = indexPath.row
        indexP = indexPath
        cell.btnSStar.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        cell.btnSStar.setImage(UIImage(named: "star.png"), for: UIControlState.selected)
        cell.btnSStar.setImage(UIImage(named: "star (1).png"), for: UIControlState.normal)
        isActive = true
        cell.btnSStar.isSelected = false
        return cell
    }
    
    @objc func buttonSelected(sender: UIButton){
        self.venune = DatabaseHelper.shareInstant.getVenueData()
        print(self.venune.count)
        let indx = sender.tag
        var data = DatabaseHelper.shareInstant.deleteData(index: indx)
        DispatchQueue.main.async {
            self.venune.remove(at: indx)
            self.tableSavedlist.deleteRows(at: [self.indexP], with: .automatic)
            self.tableSavedlist.reloadData()
        }
        if (sender.isSelected)
        {
            sender.isSelected = false
        }
        else
        {
            sender.isSelected = true
        }
    }
    
    
}
