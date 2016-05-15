//
//  LogConn.swift
//  Memory
//
//  Created by E.L.3.G.O.S.T. on 26/04/2016.
//  Copyright © 2016 Langot Benjamin. All rights reserved.
//

import Foundation

struct s_logConn
{
    var username: String
    var name: String
    var familyName: String
    
    init()
    {
        self.username = ""
        self.name = ""
        self.familyName = ""
    }
    
    init(username: String, name: String, familyName: String)
    {
        self.username = username
        self.name = name
        self.familyName = familyName
    }

}

class LogConn
{
    let filePath : String
    
    required init()
    {
        self.filePath = NSHomeDirectory() + "/Library/Caches/MemoryGameLogConnexion.txt"
    }
    
    func WriteToFile(content: String)
    {
        do
        {
            _ = try content.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
            NSLog(content + " Written to file " + self.filePath)
        }
        catch let error as NSError
        {
            print(error.description)
        }
    }
    
    func ReadFromFile() -> s_logConn
    {
        var readString: String = ""
        var res = s_logConn.init()
        do
        {
            readString = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding) as String
            var tabSplit: [String] = readString.componentsSeparatedByString("/")
            let split_Username = tabSplit[0]
            var split_Name = ""
            var split_familyName = ""
            if(tabSplit.count > 1)
            {
                split_Name = tabSplit[1]
            }
            if(tabSplit.count > 2)
            {
                split_familyName = tabSplit[2]
            }
            res = s_logConn.init(username: split_Username, name: split_Name, familyName: split_familyName)
            NSLog(readString)
        }
        catch let error as NSError
        {
            print(error.description)
            WriteToFile("");
            ReadFromFile()
        }
        return res
    }
    
    
    
}
