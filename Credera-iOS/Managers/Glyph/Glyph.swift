//
//  Glyph.swift
//  OCKSample
//
//  Created by Akshay on 10/30/16.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class Glyph: NSObject {

    enum GlyphType: Int {
        case GlyphTypeHeart = 0
        
        case GlyphTypeAccessibility
        
        case GlyphTypeActiveLife
        
        case GlyphTypeAdultLearning
        
        case GlyphTypeAwareness
        
        case GlyphTypeBlood
        
        case GlyphTypeBloodPressure
        
        case GlyphTypeCardio
        
        case GlyphTypeChildLearning
        
        case GlyphTypeDentalHealth
        
        case GlyphTypeFemaleHealth
        
        case GlyphTypeHearing
        
        case GlyphTypeHomeCare
        
        case GlyphTypeInfantCare
        
        case GlyphTypeLaboratory
        
        case GlyphTypeMaleHealth
        
        case GlyphTypeMaternalHealth
        
        case GlyphTypeMedication
        
        case GlyphTypeMentalHealth
        
        case GlyphTypeNeuro
        
        case GlyphTypeNutrition
        
        case GlyphTypeOptometry
        
        case GlyphTypePediatrics
        
        case GlyphTypePhysicalTherapy
        
        case GlyphTypePodiatry
        
        case GlyphTypeRespiratoryHealth
        
        case GlyphTypeScale
        
        case GlyphTypeStethoscope
        
        case GlyphTypeSyringe
        
        case GlyphTypeCustom

    }
    
    // swiftlint:disable cyclomatic_complexity
    class func imageNameForGlyphType(glyphType: GlyphType) -> String {
        
        var imageName = ""
        
        switch glyphType {
        case .GlyphTypeHeart : imageName = "Heart"
        case .GlyphTypeAccessibility : imageName = "Accessibility"
        case .GlyphTypeActiveLife : imageName = "ActiveLife"
        case .GlyphTypeAdultLearning : imageName = "AdultLearning"
        case .GlyphTypeAwareness : imageName = "Awareness"
        case .GlyphTypeBlood : imageName = "Blood"
        case .GlyphTypeBloodPressure : imageName = "BloodPressure"
        case .GlyphTypeCardio : imageName = "Cardio"
        case .GlyphTypeChildLearning : imageName = "ChildLearning"
        case .GlyphTypeDentalHealth : imageName = "DentalHealth"
        case .GlyphTypeFemaleHealth : imageName = "FemaleHealth"
        case .GlyphTypeHearing : imageName = "Hearing"
        case .GlyphTypeHomeCare : imageName = "HomeCare"
        case .GlyphTypeInfantCare : imageName = "InfantCare"
        case .GlyphTypeLaboratory : imageName = "Laboratory"
        case .GlyphTypeMaleHealth : imageName = "MaleHealth"
        case .GlyphTypeMaternalHealth : imageName = "MaternalHealth"
        case .GlyphTypeMedication : imageName = "Medication"
        case .GlyphTypeMentalHealth : imageName = "MentalHealth"
        case .GlyphTypeNeuro : imageName = "Neuro"
        case .GlyphTypeNutrition : imageName = "Nutrition"
        case .GlyphTypeOptometry : imageName = "Optometry"
        case .GlyphTypePediatrics : imageName = "Pediatrics"
        case .GlyphTypePhysicalTherapy : imageName = "PhysicalTherapy"
        case .GlyphTypePodiatry : imageName = "Podiatry"
        case .GlyphTypeRespiratoryHealth : imageName = "RespiratoryHealth"
        case .GlyphTypeScale : imageName = "Scale"
        case .GlyphTypeStethoscope : imageName = "Stethoscope"
        case .GlyphTypeSyringe : imageName = "Syringe"
        case .GlyphTypeCustom : imageName = "Custom"
        }
        
        return imageName
    }
    // swiftlint:enable cyclomatic_complexity
}
