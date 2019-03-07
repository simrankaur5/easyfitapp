//
//  RSSViewController.swift
//  EasyFitApp
//
//  Created by user149446 on 2/28/19.
//  Copyright © 2019 Michal Nowak. All rights reserved.
//

import UIKit
import FeedKit


class RSSViewController: UIViewController {

    
    
    @IBOutlet weak var rssLabel1: UILabel!
    @IBOutlet weak var rssButton1: UIButton!
    
    @IBOutlet weak var rssLabel2: UILabel!
    @IBOutlet weak var rssButton2: UIButton!
    
    @IBOutlet weak var rssLabel3: UILabel!
    @IBOutlet weak var rssButton3: UIButton!
    
    @IBOutlet weak var rssLabel4: UILabel!
    @IBOutlet weak var rssButton4: UIButton!
    
    @IBOutlet weak var rssLabel5: UILabel!
    @IBOutlet weak var rssButton5: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        assignButtonImages()
    }
    
    func assignButtonImages()
    {
        let feedURL = URL(string: "https://www.runtastic.com/blog/en/feed/")!
        let parser = FeedParser(URL: feedURL)
        
        let result = parser.parse()
        
        guard let feed = result.rssFeed, result.isSuccess else {
            print(result.error)
            return
        }
        
        //RSS BUTTON1  AND LABEL1
        var item = feed.items?[1]
        
        var url = URL(string: item!.enclosure!.attributes!.url!)
        var data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        rssButton1.setBackgroundImage(UIImage(data: data!), for: .normal)
        rssLabel1.text = item!.title!
        
        //RSS BUTTON2  AND LABEL2
        item = feed.items?[2]
        
        url = URL(string: item!.enclosure!.attributes!.url!)
        data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        rssButton2.setBackgroundImage(UIImage(data: data!), for: .normal)
        rssLabel2.text = item!.title!
    
        //RSS BUTTON3  AND LABEL3
        item = feed.items?[3]
        
        url = URL(string: item!.enclosure!.attributes!.url!)
        data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        rssButton3.setBackgroundImage(UIImage(data: data!), for: .normal)
        rssLabel3.text = item!.title!
        
        //RSS BUTTON4  AND LABEL4
        item = feed.items?[4]
        
        url = URL(string: item!.enclosure!.attributes!.url!)
        data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        rssButton4.setBackgroundImage(UIImage(data: data!), for: .normal)
        rssLabel4.text = item!.title!
        
        //RSS BUTTON2  AND LABEL2
        item = feed.items?[5]
        
        url = URL(string: item!.enclosure!.attributes!.url!)
        data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        rssButton5.setBackgroundImage(UIImage(data: data!), for: .normal)
        rssLabel5.text = item!.title!
        
        
        
        
    }
    
 
    func buttonLinkRedirect(number: Int)
    {
        
        let feedURL = URL(string: "https://www.runtastic.com/blog/en/feed/")!
        let parser = FeedParser(URL: feedURL)
        
        let result = parser.parse()
        
        guard let feed = result.rssFeed, result.isSuccess else {
            print(result.error)
            return
        }
        
        let item = feed.items?[number]
        var theLink:String = item!.link!
        UIApplication.shared.open(URL(string: theLink)! as URL, options: [:], completionHandler: nil)
        
        
        
    }
    
    @IBAction func rssButton1Click(_ sender: Any) {
        buttonLinkRedirect(number: 1)
        
    }
    
    @IBAction func rssButton2Click(_ sender: Any) {
        buttonLinkRedirect(number: 2)
        
    }
    
    @IBAction func rssButton3Click(_ sender: Any) {
        buttonLinkRedirect(number: 3)
        
    }
    
    @IBAction func rssButton4Click(_ sender: Any) {
        buttonLinkRedirect(number: 4)
        
    }
    
    @IBAction func rssButtonClick5(_ sender: Any) {
        buttonLinkRedirect(number: 5)
        
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool){
        
        
        
    }
//
//    private func loadData() -> Void
//    {
//
//        let url = "https://www.runtastic.com/blog/en/feed/"
//
//        let request = URLRequest(url: URL(string: url)!)
//
//        let session = URLSession.shared.dataTask(with: request)
//        {
//            //HANDLES ERROR
//            (data, _, error) in
//
//            if error != nil
//            {
//                return
//            }
//
//
//            guard let data = data else
//            {
//                return
//            }
//
//
//            //CONVERTES THE DATA TO A STRING
//            var s: String = String(data: data, encoding: .ascii)!
//
//            //XML FOR ALL STANDARDS
//            s = s.replacingOccurrences(of: "\r", with: "\n")
//
//            //PARSE XML
//            let p = ParseRSS()
//            p.setData(data: data)
//            p.parse()
//
//        }
//
//        //run
//        session.resume()
//
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
