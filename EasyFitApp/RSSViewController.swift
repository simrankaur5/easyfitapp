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

    @IBOutlet weak var testImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let feedURL = URL(string: "https://www.runtastic.com/blog/en/feed/")!
        let parser = FeedParser(URL: feedURL)
        
        let result = parser.parse()
        
        guard let feed = result.rssFeed, result.isSuccess else {
            print(result.error)
            return
        }
        
        let item = feed.items?[1]
        print(item!.title)
        print(item!.link)
        print(item!.enclosure!.attributes!.url)
        
        let url = URL(string: item!.enclosure!.attributes!.url!)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        testImage.image = UIImage(data: data!)
        
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
