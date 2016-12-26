//
//  ViewController.swift
//  PropertyInspetor
//
//  Created by admin on 16/12/25.
//  Copyright © 2016年 admin. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD
class ViewControlvar: UIViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initCommon()
        loadData()
        
        
        
        
    }
    //MARK:tableView delegate datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return dataSource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        self.tableView.registerNib(UINib.init(nibName: "RadioCell", bundle: nil), forCellReuseIdentifier: "RadioCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("RadioCell", forIndexPath: indexPath) as! RadioCell
        cell.data = dataSource[indexPath.row]
        cell.selectionStyle = .None
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 96
    }
    //MARK:初始化设置
    func initCommon()  {
        
        tableView = UITableView(frame: CGRectMake(0, 0, screenW, screenH))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
    }
    //MARK:数据请求
    func loadData()  {
        
        let parameters = [
            "start":"0"
        ]
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "加载中"
        hud.labelColor = UIColor.whiteColor()
        Http.getDataFormWeb(HttpMethod.POST, url: kRedioUrl, parameters: parameters, headers: nil, sucess: { (status, data) in
            
            hud.hide(true, afterDelay: 1)
            let dic = JSON(data: data)
            let dic1 = dic["data"].dictionary
            let hotListAray = dic1!["hotlist"]?.array
            for i in 0..<hotListAray!.count{
                
                let model = RadioModel()
                let d = hotListAray![i].dictionary
                model.title = (d!["title"]?.string!)!
                model.coverimg = d!["coverimg"]!.string!
                self.dataSource.append(model)
            }
            self.tableView.reloadData()
            }) { (status, error) in
                
                hud.labelText = "请求出错"
                hud.hide(true, afterDelay: 1)
        }
    }

    private var dataSource = [RadioModel]()
    private var tableView : UITableView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

