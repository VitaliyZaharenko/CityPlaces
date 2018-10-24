//
//  PlaceDetailView.swift
//  CityPlaces
//
//  Created by zaharenkov on 24/10/2018.
//  Copyright © 2018 zaharenkov. All rights reserved.
//

import UIKit

class PlaceDetailView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeLonLabel: UILabel!
    @IBOutlet weak var placeLatLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit(){
        Bundle.main.loadNibNamed(Consts.PlaceDetailView.xib, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
}
