//
//  MulticastDelegate.swift
//  Lab4_copy
//
//  Created by Kriztin Abellon on 27/3/2022.
//

import Foundation
//
//kriztin
//#1771
//🐸🌈 uWu
//
//kriztin — 25/03/2022
//i-
//Ohh yes please dont feel bad that im helping out, im doing it cuz i want to, not cuz i have to so dont worry about it!! 💪😎 and and only if its okay with you
//🌚🌚
//nhiii — 25/03/2022
//🥺 🥺 🥺
//MAHAL !
//i love you
//kriztin — 25/03/2022
//💖💖💖 i love you!!!!!!!!!!
//nhiii — 25/03/2022
//my qamar!
//kriztin — 25/03/2022
//HAHAH
//oWo
//nhiii — 25/03/2022
//🥰
//i love you
//kriztin — 25/03/2022
//🥰🥰 babezzz uWu
//I love you!!!!
//nhiii — 25/03/2022
//i love you i love you i love you
//kriztin — 25/03/2022
//I LOVE YOU AND ALWAYS
//nhiii — 25/03/2022
//i want to spend the rest of my life with you!
//kriztin — 25/03/2022
//HEHEH LETS GROW TOGETHER 👉👈
//nhiii — 25/03/2022
//💖w💖
//🥺🥺🥺
//kriztin — 25/03/2022
//OWOWOWO 💖
//nhiii — 25/03/2022
//OWOWOW
//kriztin — 25/03/2022
//💪🥰
//nhiii — Yesterday at 08:36
//Not gonna be active on Discowd tonight. I'm meeting a giww (a weaw one) in hawf an houw (wouwdn't expect a wot of you to undewstand anyway) so pwease don't DM me asking me whewe I am (im with the giww, ok) you'ww most wikewy get aiwed because iww be with the giww (again I don't expect you to undewstand) shes actuawwy weawwy intewested in me and its not a situation i can pass up fow some meaningwess Discowd degenewates (because iww be meeting a giww, not that you weawwy awe going to undewstand) this is my wife now. Meeting women and not wasting my pwecious time onwine, I have to move on fwom such simpwe things and bwanch out (you wouwdnt undewstand)
//kriztin — Yesterday at 09:40
//No worries!
//👴
//nhiii — Yesterday at 09:40
//thanks fow undewstanding
//kriztin — Yesterday at 09:41
//Any tldr??
//🌚
//nhiii — Yesterday at 09:41
//im not a summariser
//im a poet
//kriztin — Yesterday at 09:41
//Nah im jk, i read the whole thing
//🤣🤣
//I actually woke up to this
//And was like wha…
//nhiii — Yesterday at 09:42
//HEHEHE
//kriztin — Yesterday at 09:42
//Then formed a reply in my head
//Then slept
//For another 30 mins HAHAH
//nhiii — Yesterday at 09:42
//HAHAHA
//kriztin — Yesterday at 09:42
//All my head could come up was “no worries!”
//😭😭
//nhiii — Yesterday at 09:42
//No worries!
//👴
//kriztin — Yesterday at 09:43
//Well thought out if u ask me
//😎🐸💪
//nhiii — Yesterday at 22:28
//Attachment file type: acrobat
//W04_-_Lab.pdf
//1.22 MB
//nhiii — Today at 02:00
//
//  MulticastDelegate.swift
//
//  Created by Michael Wybrow on 23/3/19.
//  Copyright Â© 2019 Monash University.
//
//
//  MulticastDelegate.swift
//
//  Created by Michael Wybrow on 23/3/19.
//  Copyright Â© 2019 Monash University.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import Foundation

class MulticastDelegate <T> {
    private var delegates = Set<WeakObjectWrapper>()
    
    func addDelegate(_ delegate: T) {
        let delegateObject = delegate as AnyObject
        delegates.insert(WeakObjectWrapper(value: delegateObject))
    }
    
    func removeDelegate(_ delegate: T) {
        let delegateObject = delegate as AnyObject
        delegates.remove(WeakObjectWrapper(value: delegateObject))
    }
    
    func invoke(invocation: (T) -> ()) {
        delegates.forEach { (delegateWrapper) in
            if let delegate = delegateWrapper.value {
                invocation(delegate as! T)
            }
        }
    }
}

private class WeakObjectWrapper: Equatable, Hashable {
    weak var value: AnyObject?
    
    init(value: AnyObject) {
        self.value = value
    }
    
    // Hash based on the address (pointer) of the value.
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(value!).hashValue)
    }
    
    // Equate based on equality of the value pointers of two wrappers.
    static func == (lhs: WeakObjectWrapper, rhs: WeakObjectWrapper) -> Bool {
        return lhs.value === rhs.value
    }
}
