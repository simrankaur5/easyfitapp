//
//  RSSViewController.swift
//  EasyFitApp
//
//  Created by user149446 on 2/28/19.
//  Copyright © 2019 Michal Nowak. All rights reserved.
//

import UIKit

class RSSViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        
        
        
    }
    
    private func loadData() -> Void
    {
        
        let url = "https://www.runtastic.com/blog/en/feed/"
        
        let request = URLRequest(url: URL(string: url)!)
        
        let session = URLSession.shared.dataTask(with: request)
        {
            //HANDLES ERROR
            (data, _, error) in
            
            if error != nil
            {
                return
            }
            
            
            guard let data = data else
            {
                return
            }
            
            
            //CONVERTES THE DATA TO A STRING
            var s: String = String(data: data, encoding: .ascii)!
            
            //XML FOR ALL STANDARDS
            s = s.replacingOccurrences(of: "\r", with: "\n")
            
            //PARSE XML
            let p = ParseRSS()
            p.setData(data: data)
            p.parse()
            
        }
        
        //run
        session.resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
