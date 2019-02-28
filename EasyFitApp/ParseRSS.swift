//
//  ParseRSS.swift
//  EasyFitApp
//
//  Created by user149446 on 2/28/19.
//  Copyright © 2019 Michal Nowak. All rights reserved.
//

import Foundation


struct RSS
{
    
    var title: String
    var description: String
    var image: String
    var link: String
    
    
    
    
    
}

class ParseRSS: NSObject, XMLParserDelegate
{
    
    private var theData: Data
    private var currentElementName = ""
    private var inItem = false
    private var item: RSS
    
    
    var ready = false
    
    
    var channel: RSS
    var items: [RSS]
    
    
    override init()
    {
        
        //DEFAULT VALUES
        theData = "".data(using: .ascii)!
        channel = RSS(title: "", description: "", image: "", link: "")
        items = []
        
        item = channel
        
        
    }
    
    deinit {
    
    }
    
    //SETS LOCAL DATA FOR PARSING
    func setData(data: Data!) -> Void
    {
        
        if data == nil
        {
            return
        }
        
        theData = data
        
    }
    
    
    //RUNS PARSING PROCESS
    func parse() -> Void
    {
    
        let parser = XMLParser(data: theData)
        parser.delegate = self
        parser.parse()
        
    }
    
    //END SESSION
    func parserDidEndDocument(_ parser: XMLParser) {
        ready = true
    }
    
    
    //NEW SESSION
    func parserDidStartDocument(_ parser: XMLParser) {
        ready = false
    }
    
    
    //ENDS AN ELEMENT
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        
        if elementName == "item"
        {
            
            inItem = false
            items.append(item)
            
            
            
        }
        
        
        
    }
    
    
    //STARTS AN ELEMENT
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        
        currentElementName = elementName
        
        if elementName == "item"
        {
            
            inItem = true
            item = RSS(title: "", description: "", image: "", link: "")
            
        }
        
    }
    
    
    //COLLECTS DATA FROM CDATA BLOCKS
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data)
    {
        
        if !inItem
        {
            
            switch currentElementName.lowercased()
            {
            case "description":
                channel.description = String(data: CDATABlock, encoding: .utf8)!
                break
            
            default:
                break
            }
            return
        }
        
        switch currentElementName.lowercased()
        {
            
        case "description":
            item.description = String(data: CDATABlock, encoding: .utf8)!
            break

        default:
            break
        }
        
    }
    
    //COLLECTS OTHER DATA
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        
        if !inItem
        {
            switch currentElementName.lowercased()
            {
                
            case "title":
                channel.title = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                break
            case "link":
                channel.link = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                break
            case "enclosure":
                channel.image = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                break
            default:
                break
            }
            return
        }
        
        switch currentElementName.lowercased()
        {
            
        case "title":
            item.title = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            break
        case "link":
            item.link = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            break
        default:
            break
        }
        
        
    }
    
    
    
}
