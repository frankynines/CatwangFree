//  I'ma Unicorn
//
//  Created by Franky Aguilar on 7/27/12.
//  Copyright (c) 2012 99centbrains Inc. All rights reserved.
//  @99centbrains - http://99centbrains.com
//  ALL ARTWORK AND DESIGN OWNED BY 99centbrains, not for reproduction or redistribution

import Foundation
import UIKit

// MARK: - SDK Keys

enum AppConstants {
    static let applicationProductName = "Catwang"
    static let appiTunesID = 967807794
}

// MARK: - Share Copy

enum ShareConstants {
    static let subject = "#Catwang by @Catgnaw"
    static let description = "Get #Catwang free on the appstore."
    static let instagramParam = "@Catgnaw #Catwang"
    static let url = "http://catgnaw.com"
}

// MARK: - Photo Library

enum PhotoConstants {
    static let albumName = "Catwang"
}

// MARK: - In-App Purchases

/// Represents a single page within a sticker pack
struct StickerPage {
    let productID: String
    let title: String
    let path: String
    
    init(_ productID: String, _ title: String, _ path: String) {
        self.productID = productID
        self.title = title
        self.path = path
    }
}

/// Represents a complete sticker pack with banner and pages
struct StickerPackData {
    let bannerImage: String
    let pages: [StickerPage]
    
    init(banner: String, pages: [StickerPage]) {
        self.bannerImage = banner
        self.pages = pages
    }
}

enum StickerPacks {
    // MARK: - Sticker Pack 1
    
    static let pack1Page01 = StickerPage("com.99centbrains.catwang.01", "Free Stuff", "/stickers/1Catwang/01_catwang/")
    static let pack1Page02 = StickerPage("com.99centbrains.catwang.02", "Free Stuff 2", "/stickers/1Catwang/02_catwang/")
    static let pack1Page03 = StickerPage("com.99centbrains.catwang.03", "Free Stuff 3", "/stickers/1Catwang/03_catwang/")
    
    static let pack1 = StickerPackData(
        banner: "catwang_banner_01.png",
        pages: [pack1Page01, pack1Page02, pack1Page03]
    )
    
    // MARK: - Sticker Pack 2
    
    static let pack2Page01 = StickerPage("com.99centbrains.catgang.01", "More Catwang", "/stickers/2Catgnaw/cw_morecatwang/")
    static let pack2Page02 = StickerPage("com.99centbrains.catgang.02", "Even More", "/stickers/2Catgnaw/cw_evenmorecatwang/")
    static let pack2Page03 = StickerPage("com.99centbrains.catgang.03", "Megawang", "/stickers/2Catgnaw/cw_megawang/")
    static let pack2Page04 = StickerPage("com.99centbrains.catgang.04", "Show Me Catwang", "/stickers/2Catgnaw/cw_showmeyour/")
    static let pack2Page05 = StickerPage("com.99centbrains.catgang.05", "FVCK Catwang", "/stickers/2Catgnaw/cw_fvckcatwang/")
    static let pack2Page06 = StickerPage("com.99centbrains.catgang.06", "Sun Burnt", "/stickers/2Catgnaw/cw_ss13/")
    
    static let pack2 = StickerPackData(
        banner: "catwang_banner_02.png",
        pages: [pack2Page01, pack2Page02, pack2Page03, pack2Page04, pack2Page05, pack2Page06]
    )
    
    // MARK: - Sticker Pack 3
    
    static let pack3Page01 = StickerPage("com.99centbrains.catgnaw.01", "OMGlob", "/stickers/3Catgang/cw_ohmyglob/")
    static let pack3Page02 = StickerPage("com.99centbrains.catgnaw.02", "Radical", "/stickers/3Catgang/cw_radical/")
    static let pack3Page03 = StickerPage("com.99centbrains.catgnaw.03", "S.W.A.F", "/stickers/3Catgang/cw_swaf/")
    
    static let pack3 = StickerPackData(
        banner: "catwang_banner_03.png",
        pages: [pack3Page01, pack3Page02, pack3Page03]
    )
    
    // MARK: - Sticker Pack 4
    
    static let pack4Page01 = StickerPage("com.99centbrains.eatit.01", "Super Food", "/stickers/Eatit/cw_morefood/")
    static let pack4Page02 = StickerPage("com.99centbrains.eatit.02", "OMGPizza", "/stickers/Eatit/cw_omg_pizza/")
    static let pack4Page03 = StickerPage("com.99centbrains.eatit.03", "Munchies", "/stickers/Eatit/cw_stuffit/")
    
    static let pack4 = StickerPackData(
        banner: "catwang_banner_04.png",
        pages: [pack4Page01, pack4Page02, pack4Page03]
    )
    
    // MARK: - Sticker Pack 5
    
    static let pack5Page01 = StickerPage("com.99centbrains.rockit.01", "Doodle Squad", "/stickers/Rockit/cw_doodlesquad/")
    static let pack5Page02 = StickerPage("com.99centbrains.rockit.02", "Summer Gear", "/stickers/Rockit/cw_summer1401/")
    static let pack5Page03 = StickerPage("com.99centbrains.rockit.03", "Summer Swag", "/stickers/Rockit/cw_summer1402/")
    static let pack5Page04 = StickerPage("com.99centbrains.rockit.04", "Super Gear", "/stickers/Rockit/cw_supergear/")
    
    static let pack5 = StickerPackData(
        banner: "catwang_banner_05.png",
        pages: [pack5Page01, pack5Page02, pack5Page03, pack5Page04]
    )
    
    // MARK: - Sticker Pack 6
    
    static let pack6Page01 = StickerPage("com.99centbrains.splasher.01", "Pop Splash", "/stickers/Splash/cw_moreshapes/")
    static let pack6Page02 = StickerPage("com.99centbrains.splasher.02", "More Shapes", "/stickers/Splash/cw_popsplash/")
    static let pack6Page03 = StickerPage("com.99centbrains.splasher.03", "Hollow Swag", "/stickers/Splash/fillers_01/")
    static let pack6Page04 = StickerPage("com.99centbrains.splasher.04", "Big Black", "/stickers/Splash/fillers_10/")
    
    static let pack6 = StickerPackData(
        banner: "catwang_banner_06.png",
        pages: [pack6Page01, pack6Page02, pack6Page03, pack6Page04]
    )
    
    // MARK: - All Packs
    
    static let allPacks: [StickerPackData] = [
        pack1, pack2, pack3, pack4, pack5, pack6
    ]
    
    // MARK: - Free & Locked Packs
    
    static let freePacks: Set<String> = [
        "com.99centbrains.catwang.01",
        "com.99centbrains.catwang.02",
        "com.99centbrains.catwang.03"
    ]
    
    static let lockedPacks: Set<String> = [
        "com.99centbrains.catgang.01",
        "com.99centbrains.catgang.02",
        "com.99centbrains.catgang.03",
        "com.99centbrains.catgang.04",
        "com.99centbrains.catgang.05",
        "com.99centbrains.catgang.06",
        "com.99centbrains.catgnaw.01",
        "com.99centbrains.catgnaw.02",
        "com.99centbrains.catgnaw.03",
        "com.99centbrains.eatit.01",
        "com.99centbrains.eatit.02",
        "com.99centbrains.eatit.03",
        "com.99centbrains.rockit.01",
        "com.99centbrains.rockit.02",
        "com.99centbrains.rockit.03",
        "com.99centbrains.rockit.04",
        "com.99centbrains.splasher.01",
        "com.99centbrains.splasher.02",
        "com.99centbrains.splasher.03",
        "com.99centbrains.splasher.04"
    ]
    
    // MARK: - Convenience Methods
    
    /// Check if a product ID is a free pack
    static func isFree(productID: String) -> Bool {
        return freePacks.contains(productID)
    }
    
    /// Check if a product ID is a locked pack
    static func isLocked(productID: String) -> Bool {
        return lockedPacks.contains(productID)
    }
    
    /// Find a sticker page by product ID
    static func page(for productID: String) -> StickerPage? {
        return allPacks
            .flatMap { $0.pages }
            .first { $0.productID == productID }
    }
}
