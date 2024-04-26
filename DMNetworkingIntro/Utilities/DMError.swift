//
//  DMError.swift
//  DMNetworkingIntro
//
//  Created by Lesley Lopez on 4/24/24.
//

import Foundation

enum DMError: String, Error {
    case invalidURL = "There was an issue connecting to the server."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}

//
//2.1 Modify the getUsers function to accept a completion closure. 

//The closure should accept a Result For the success case, the associated value for the result should be an array of User.

//For the failure case, the associated value should be a DMError.




//2.2 Continue to modify getUsers to use the closure. For all failures, call the completion closure with the correct DMError. For a success, call the completion closure with the array of User.
//



//3.1 Modify the UsersViewController to use the completion closure instead of the NetworkManagerDelegate.




//3.2 Add a function called presentAlert to the UsersViewController that accepts a DMError and presents a UIAlertController with that error. Call presentError if there's a failure.
