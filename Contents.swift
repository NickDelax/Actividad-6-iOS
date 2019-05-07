//Nicolas De La Cruz Ramos

import UIKit

class LinkedNode {
    var v:Int = 0
    var next:LinkedNode?
    var previous:LinkedNode?
    
    init(_ v1:Int) { self.v = v1 }
}

class LRUCache {
    var tempHead:LinkedNode?
    var tempTail:LinkedNode?
    var head:LinkedNode?
    var tail:LinkedNode?
    let limit:Int = 3
    var size:Int = 0
    
    var hashT: [Int : LinkedNode] = [:]
    
    var n:LinkedNode?
    var p:LinkedNode?
    var s:LinkedNode?
    
    func get (_ value:Int) -> Int?{
        var result:Int? = 0
        s = hashT[value]
        p = s?.previous
        n = s?.next
        p?.next = n
        n?.previous = p
        if s?.previous == nil {
            head = s?.next
        } else if s?.next == nil {
            tail = s?.previous
        }
        result = s?.v
                if let x = s {
            print("borraremos \(s!.v)")
            hashT[s!.v] = nil
        }
        return result
    }
    func Colocate (_ value:Int) -> Void{
        var LN:LinkedNode = LinkedNode(value)
        
        if hashT.count > 0 {
            tempHead = head
            LN.next = tempHead
            LN.previous = nil
            
            tempHead?.previous = LN
        }
        
        if tail == nil { tail = LN }
        head = LN
        hashT[value] = LN
        
        if hashT.count > limit {
            tempTail = tail?.previous
            tempTail?.next = nil
            //remover tail de hashT
            if let x = tail { hashT[tail!.v] = nil }
            
            tail = tempTail
        }
    }
}
extension LRUCache {
    var hashSize:Int {
        return self.hashT.count
    }
}

var l = LRUCache()

l.Colocate(2)
print(l.hashT)
l.Colocate(3)
print(l.hashT)
l.Colocate(4)
print(l.hashT)

print("Normal")
print("el primero es \(l.head?.v)")
print(l.head?.next?.v)
print("el ultimo es \(l.tail?.v)")

print("se agrega el cuarto elemento")
l.Colocate(5)
print(l.hashT)
print("el primero es \(l.head?.v)")
print(l.head?.next?.v)
print("el ultimo es \(l.tail?.v)")
print()
print("se obtiene \(l.get(3))")
print("el primero es \(l.head?.v)")
print(l.head?.next?.v)
print(l.hashT)
print("se obtiene \(l.get(5))")
print("el primero es \(l.head?.v)")
print(l.hashT)
print("tamano total \(l.hashSize)")
