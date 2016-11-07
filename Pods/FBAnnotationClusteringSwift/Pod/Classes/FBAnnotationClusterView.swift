//
//  FBAnnotationClusterView.swift
//  FBAnnotationClusteringSwift
//
//  Created by Robert Chen on 4/2/15.
//  Copyright (c) 2015 Robert Chen. All rights reserved.
//

import Foundation
import MapKit

open class FBAnnotationClusterView: MKAnnotationView {
  
  var count = 0
  
  var fontSize: CGFloat = 12
  
  var imageName = "clusterSmall"
  var loadExternalImage: Bool = false
  
  var borderWidth: CGFloat = 3
  
  var countLabel: UILabel? = nil
  
  //var option: FBAnnotationClusterViewOptions? = nil
  
  public init(annotation: MKAnnotation?, reuseIdentifier: String?, options: FBAnnotationClusterViewOptions?) {
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    
    let cluster: FBAnnotationCluster = annotation as! FBAnnotationCluster
    count = cluster.annotations.count
    
    // change the size of the cluster image based on number of stories
    //        switch count {
    //        case 0...5:
    //            fontSize = 12
    //            if options != nil {
    //                loadExternalImage = true
    //                imageName = (options?.smallClusterImage)!
    //            } else {
    //                imageName = "clusterSmall"
    //            }
    //            borderWidth = 3
    //
    //        case 6...15:
    //            fontSize = 13
    //            if options != nil {
    //                loadExternalImage = true
    //                imageName = (options?.mediumClusterImage)!
    //            } else {
    //                imageName = "clusterMedium"
    //            }
    //            borderWidth = 4
    //
    //        default:
    //            fontSize = 14
    //            if options != nil {
    //                loadExternalImage = true
    //                imageName = (options?.largeClusterImage)!
    //            } else {
    //                imageName = "clusterLarge"
    //            }
    //            borderWidth = 5
    //
    //        }
    
    
    fontSize = 14
    if options != nil {
      loadExternalImage = true
      imageName = (options?.largeClusterImage)!
    } else {
      imageName = "clusterLarge"
    }
    borderWidth = 5
    
    backgroundColor = UIColor.clear
    setupLabel()
    setTheCount(count)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func setupLabel() {
    countLabel = UILabel(frame: CGRect(x: 6, y: 0, width: 26, height: 26))
    
    
    
    if let countLabel = countLabel {
      //countLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      //  countLabel.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
      
      //  countLabel.translatesAutoresizingMaskIntoConstraints = false // Swift 2
      
      //  countLabel.autoresizingMask = [.flexibleWidth]
      countLabel.textAlignment = .center
      countLabel.backgroundColor = UIColor.clear
      countLabel.textColor = UIColor.white
      countLabel.adjustsFontSizeToFitWidth = true
      countLabel.minimumScaleFactor = 2
      countLabel.numberOfLines = 1
      countLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
      countLabel.baselineAdjustment = .alignCenters
      addSubview(countLabel)
      
      
      //          label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
      //          [self addSubview:label];
      //          label.textColor = [UIColor whiteColor];
      //          label.backgroundColor = [UIColor clearColor];
      //          label.font = [UIFont boldSystemFontOfSize:11];
      //          label.textAlignment = UITextAlignmentCenter;
      //          label.shadowColor = [UIColor blackColor];
      //          label.shadowOffset = CGSizeMake(0,-1);
      
    }
  }
  
  func setTheCount(_ localCount: Int) {
    count = localCount
    
    countLabel?.text = "\(localCount)"
    setNeedsLayout()
  }
  
  override open func layoutSubviews() {
    
    // Images are faster than using drawRect:
    
    let imageAsset = UIImage(
      named: imageName,
      in: (!loadExternalImage) ? Bundle(for: FBAnnotationClusterView.self) : nil, compatibleWith: nil)
    
    //UIImage(named: imageName)!
    
    //countLabel?.frame = self.bounds
    countLabel?.frame = CGRect(x: 6, y: 0, width: 26, height: 26)
    image = imageAsset
    centerOffset = CGPoint.zero
    
    // adds a white border around the green circle
    //  layer.borderColor = UIColor.white.cgColor
    // layer.borderWidth = borderWidth
    //layer.cornerRadius = self.bounds.size.width / 2
  }
}

open class FBAnnotationClusterViewOptions: NSObject {
  var smallClusterImage: String
  var mediumClusterImage: String
  var largeClusterImage: String
  
  
  public init (smallClusterImage: String, mediumClusterImage: String, largeClusterImage: String) {
    self.smallClusterImage = smallClusterImage
    self.mediumClusterImage = mediumClusterImage
    self.largeClusterImage = largeClusterImage
  }
}
