//
//  ContentView.swift
//  ImagePickerDemo
//
//  Created by Mahesh Prasad on 30/08/20.
//  Copyright © 2020 CreatesApp. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var imgData = Data.init(count: 0)
    @State var shown = false
    
    var body: some View {
        VStack {
            if imgData.count != 0 {
                Image(uiImage: UIImage(data: imgData)!).resizable()
                .frame(height: 300)
                .padding()
                .cornerRadius(20)
            }
            

            Button(action: {
                self.shown.toggle()
            }) {
                
                Text("Select Image")
            }.sheet(isPresented: $shown) {
                
                picker(shown: self.$shown, imgData: self.$imgData)
            }
            
        }.animation(.spring())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct picker : UIViewControllerRepresentable {
    
    @Binding var shown : Bool
    @Binding var imgData : Data
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(imgData1: $imgData, shown1: $shown)
    }
    
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<picker>) ->
        UIImagePickerController {
        
        let controller = UIImagePickerController()
            controller.sourceType = .photoLibrary
            controller.delegate = context.coordinator
            return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<picker>) {

    }
    
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var imgData : Data
        @Binding var shown : Bool
        
        init(imgData1 : Binding<Data>, shown1 : Binding<Bool>) {
            
            _imgData = imgData1
            _shown = shown1
            
            
        }
        
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            shown.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
           let imgage = info[.originalImage] as! UIImage
            imgData = imgage.jpegData(compressionQuality: 80)!
            shown.toggle()
            
        }
        
    }
    
}

