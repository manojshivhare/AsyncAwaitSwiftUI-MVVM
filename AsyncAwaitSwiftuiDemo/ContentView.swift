//
//  ContentView.swift
//  AsyncAwaitSwiftuiDemo
//
//  Created by Manoj Shivhare on 04/06/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = UserListViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                List(viewModel.users ?? [], id: \.id){ user in
                    HStack{
                        AsyncImage(url: URL(string: user.avatarURL ?? "")){ image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                        }placeholder: {
                            Circle()
                                .foregroundColor(.gray)
                        }.frame(width: 50,height: 50)
                        
                        VStack(alignment: .leading){
                            Text(user.login?.capitalized ?? "")
                                .font(.headline)
                            Text(user.url ?? "")
                                .font(.subheadline)
                        }
                    }
                }.navigationTitle("User List")
                
                if viewModel.isDataLoading{
                    ProgressView()
                        .scaleEffect(2.0, anchor: .center)
                        .progressViewStyle(.circular)
                }
            }
        }.task {
            await viewModel.getUserData()
        }
        .alert(isPresented: $viewModel.isShowError){
            return Alert(title: Text("Error!"), message: Text(viewModel.errorMessage ?? ""))
        }
    }
}

#Preview {
    ContentView()
}
