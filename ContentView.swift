//
//  ContentView.swift
//  Shared
//
//  Created by Scott Douglas on 4/23/22.
//

import SwiftUI

//let parent = UIViewController()
//let child = myVC

let myVC = MyViewController()
let parent = UIViewController()
let child = MyViewController()


struct ContentView: View {
    var body: some View {
             
        Text("Hello, world!")
          .padding()
        
        Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
            parent.view.addSubview(child.view)
            parent.addChild(child)
            //myVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            //myVC.presentScanningVC()
            myVC.viewDidAppear(true)
        }

   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
