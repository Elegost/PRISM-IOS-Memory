//
//  LogScore.swift
//  Memory
//
//  Created by E.L.3.G.O.S.T. on 09/04/2016.
//  Copyright © 2016 Langot Benjamin. All rights reserved.
//

import Foundation

struct s_LogScore
{
    var highScore: Int
    var TabScore: [Int]
    var username: String
    
    init()
    {
        self.highScore = Int.max
        self.TabScore = [Int.max]
        self.username = ""
    }
    
    init(highScore: Int, TabScore: [Int], username: String)
    {
        self.highScore = highScore
        self.TabScore = TabScore
        self.username = username
    }
}

class LogScore
{
    let filePath : String
    
    required init(username: String)
    {
        self.filePath = NSHomeDirectory() + "/Library/Caches/MemoryGameLog_" + username + ".txt"
    }
    
    func WriteToFile(content: String)
    {
        do
        {
            _ = try content.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        }
        catch let error as NSError
        {
            print(error.description)
        }
    }
    
    func ReadFromFile() -> s_LogScore
    {
        var readString: String
        var res = s_LogScore.init()
        do
        {
            readString = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding) as String
            var tabSplit: [String] = readString.componentsSeparatedByString("/")
            var split_highScore = tabSplit[0]
            let split_tabScore = tabSplit[1]
            var split_tabScoreSplitted = split_tabScore.componentsSeparatedByString(";")
            var tabScore: [Int] = []
            for i in 0 ..< split_tabScoreSplitted.count
            {
                if(split_tabScoreSplitted[i] != "")
                {
                    tabScore.append(Int(split_tabScoreSplitted[i])!)
                }
            }
            let split_username = tabSplit[2]
            if(split_highScore == "")
            {
                split_highScore = String(Int.max)
            }
            res = s_LogScore(highScore: Int(split_highScore)!, TabScore: tabScore, username: split_username
            )
        }
        catch let error as NSError
        {
            print(error.description)
            WriteToFile("/;/")
            ReadFromFile()
        }
        return res
    }
    
    
    
}