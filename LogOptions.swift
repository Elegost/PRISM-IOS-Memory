

//
//  LogOptions.swift
//  Memory
//
//  Created by etudiant on 09/05/2016.
//  Copyright © 2016 Langot Benjamin. All rights reserved.
//

import Foundation

struct s_logOption
{
    var split_musique: Bool
    var split_soundEffect: Bool
    var displayAnimatedBackground: Bool
    
    init()
    {
        self.split_musique = true
        self.split_soundEffect = true
        self.displayAnimatedBackground = true
    }
    
    init(musique: Bool, soundEffect: Bool, displayAnimatedBackground: Bool)
    {
        self.split_musique = musique
        self.split_soundEffect = soundEffect
        self.displayAnimatedBackground = displayAnimatedBackground
    }
}

class LogOptions
{
    let filePath : String
    
    required init()
    {
        self.filePath = NSHomeDirectory() + "/Library/Caches/MemoryGameLogOptions.txt"
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
    
    func ReadFromFile() -> s_logOption
    {
        var readString: String = ""
        var res = s_logOption.init()
        do
        {
            readString = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding) as String

            if(readString == "")
            {
                WriteToFile("0/0/0")
                readString = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding) as String
            }
            var tabSplit: [String] = readString.componentsSeparatedByString("/")
            let split_Musique = tabSplit[0] == "0" ? false : true
            let split_SoundEffect = tabSplit[1] == "0" ? false : true
            let displayBackground = tabSplit[2] == "0" ? false : true
            res = s_logOption.init(musique: split_Musique, soundEffect: split_SoundEffect, displayAnimatedBackground: displayBackground)
            NSLog(readString)
        }
        catch let error as NSError
        {
            print(error.description)
            WriteToFile("0/0/0");
            ReadFromFile()
        }
        return res
    }
}

