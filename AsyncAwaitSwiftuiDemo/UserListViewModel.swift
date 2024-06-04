//
//  UserListViewModel.swift
//  AsyncAwaitSwiftuiDemo
//
//  Created by Manoj Shivhare on 04/06/24.
//

import Foundation

@MainActor
final class UserListViewModel: ObservableObject{
    
    @Published var users:[UserModel]?
    @Published var isDataLoading = false
    @Published var errorMessage: String?
    @Published var isShowError = false
    func getUserData() async{
        isDataLoading = true
        do{
            self.users = try await WebServicesManager.getUserData()
            isDataLoading = false
        }catch(let error){
            errorMessage = error.localizedDescription
            isDataLoading = false
            isShowError = true
        }
    }
}
