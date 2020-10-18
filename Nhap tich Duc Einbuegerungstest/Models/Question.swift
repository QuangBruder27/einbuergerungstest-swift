//
//  Question.swift
//  Nhap tich Duc Einbuegerungstest
//
//  Created by Nguyen Quang on 21.02.19.
//  Copyright © 2019 Nguyen Quang. All rights reserved.
//

import Foundation

class Question{
    var id: String
    var quest: String
    var a : String
    var b : String
    var c : String
    var d : String
    var result: String
    
    init(id: String, quest : String, a : String, b : String, c : String, d : String, result: String) {
        self.id = id
        self.quest = quest
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.result = result
    }
}
