//
//  ViewController.swift
//  AshwiniMachineTask
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var sideBarView: UIView!
    @IBOutlet weak var tableListView: UITableView!
    var menuArr : [String]?
    
    var isSideViewOpen: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        sideBarView.isHidden = true
        tableListView.backgroundColor = UIColor.groupTableViewBackground
        isSideViewOpen = false
        menuArr = ["All Matches","Saved Matches"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
 
    @IBAction func btnSideBarTapped(_ sender: Any) {
        tableListView.isHidden = false
        sideBarView.isHidden = false
        topView.isHidden = false
        self.view.bringSubview(toFront: sideBarView)
        if !isSideViewOpen{
            isSideViewOpen = true//0
            sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: 667)
            tableListView.frame = CGRect(x: 0, y: 166, width: 0, height: 667)
            topView.frame = CGRect(x: 0, y: 0, width: 0, height: 165)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)//1
            sideBarView.frame = CGRect(x: 0, y: 0, width: 259, height: 667)
            tableListView.frame = CGRect(x: 0, y: 166, width: 259, height: 667)
             topView.frame = CGRect(x: 0, y: 0, width: 259, height: 165)
            UIView.commitAnimations()
            
        }else{
            tableListView.isHidden = true
            sideBarView.isHidden = true
            topView.isHidden = true
            isSideViewOpen = false
            sideBarView.frame = CGRect(x: 0, y: 0, width: 259, height: 667)
            tableListView.frame = CGRect(x: 0, y: 166, width: 259, height: 667)
             topView.frame = CGRect(x: 0, y: 0, width: 259, height: 499)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)
            sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: 667)
            tableListView.frame = CGRect(x: 0, y: 166, width: 0, height: 667)
             topView.frame = CGRect(x: 0, y: 0, width: 0, height: 165)
            UIView.commitAnimations()
        }
        
        
        
    }
    

}
extension ViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableListView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        cell.lblMenu.text = menuArr?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indx = indexPath.row
        switch indx {
        case 0:
             print("first")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllMatchesVC") as! AllMatchesatViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            print("second")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SavedVC") as! SavedMatchesViewController
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("default")
        }
    }
    
    
}

