//
//  MainIO.swift
//  PhotoGalleryApp
//


import Foundation

protocol MainOutput: AnyObject { 
    func showDetails(for photo: PhotoModel)
}
