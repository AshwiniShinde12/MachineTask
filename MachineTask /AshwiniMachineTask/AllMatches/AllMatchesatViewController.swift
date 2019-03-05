//
//  AllMatchesatViewController.swift
//  AshwiniMachineTask
//

import UIKit

class AllMatchesatViewController: UIViewController {

    @IBOutlet weak var tableAllList: UITableView!
    var nameArr = [String]()
    var idArr = [String]()
    var isActive = Bool()
    var id = String()
    var name = String()
     var venune = [Venues]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "All Matches"
        tableAllList.tableFooterView = UIView()
   
        APICall()
        dataModal()
    }
    func dataModal()
    {
        venune = DatabaseHelper.shareInstant.getVenueData()
        print(venune.count)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func APICall(){
      let url = URL(string:"https://api.foursquare.com/v2/venues/search?ll=40.7484,-73.9857&oauth_token=NPKYZ3WZ1VYMNAZ2FLX1WLECAWSMUVOQZOIDBN53F3LVZBPQ&v=20180616")
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, res, error) in
         
            do {
                if let content = data
                {
                 let json =  try JSONSerialization.jsonObject(with: content, options: .mutableContainers)  as! [String:AnyObject]
                     let jsonData = json
                    let response = jsonData["response"] as? [String:Any]
                    let venues:NSArray = (response!["venues"] as? NSArray)!
                    for details in venues
                    {
                        let dict = details as? [String:Any]
                        let name = dict!["name"] as! String
                        self.nameArr.append(name)
                        let id = dict!["id"] as! String
                        self.idArr.append(id)
                    }
                        print(self.nameArr.count)
                    DispatchQueue.main.async {
                        self.tableAllList.reloadData()
                    }
                }
            } catch
            {
                print("error")
            }
        }).resume()
    }

 

}
extension AllMatchesatViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableAllList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        cell.backView.addShadow(radius: 20)
        let indx = indexPath.row
        cell.lblAId.text = idArr[indx]
        cell.lblAName.text = nameArr[indx]
        cell.btnAstar.tag = indexPath.row
        cell.tag = indexPath.row
        let id = nameArr[indx]
          print("id =\(id) ,index =\(indx)")
        if (venune.count != 0)
        {
        for i in 0...venune.count-1
        {
            var count = 0
            let activeId = venune[i].name
            print("activeId=\(activeId!),index=\(i)")
            if(cell.lblAName.text == activeId! )
            {
            
                count = count + 1
                isActive = true
                print("equality check true")
                DispatchQueue.main.async {
                    if (cell.tag == indx)
                    {
                        cell.btnAstar.setImage(UIImage(named: "star.png"), for: .normal)
                    }
                }
            }
          //  print(count)
        }
        }
        cell.btnAstar.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        cell.btnAstar.setImage(UIImage(named: "star.png"), for: UIControlState.selected)
        cell.btnAstar.setImage(UIImage(named: "star (1).png"), for: UIControlState.normal)
        cell.btnAstar.isSelected = false //default A image display
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indx = indexPath.row
       
    }
    
    
    @objc func buttonSelected(sender: UIButton){
        print(sender.tag)
        print(sender.isSelected)
        name = nameArr[sender.tag]
        id = idArr[sender.tag]
        dataSaveLocally()
        if (sender.isSelected)
        {
            sender.isSelected = false
            print("\(name)\(id)")
            let indx = sender.tag
            DatabaseHelper.shareInstant.deleteData(index: indx)

        }
        else
        {
            sender.isSelected = true
        }
    }
   
    func dataSaveLocally()
    {
         let  data = ["id":id,"name":name]
        DatabaseHelper.shareInstant.saveData(object: data )
    }
    
  
    
    
}
