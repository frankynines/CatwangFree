# CatwangFree: Swift & SwiftUI Migration Plan

## Executive Summary
Complete migration from Objective-C/UIKit/Storyboard to Swift/SwiftUI. This is a full rewrite using modern iOS development practices, targeting iOS 15.0+.

---

## Migration Strategy

### Approach: **Incremental Migration with SwiftUI**
- Start with new SwiftUI app structure
- Migrate core functionality first
- Use UIKit interoperability where needed (for complex views like image editing)
- Gradually replace all Objective-C code

### Target Architecture: **MVVM (Model-View-ViewModel)**
- **Models**: Data structures, business logic
- **Views**: SwiftUI views
- **ViewModels**: ObservableObject classes managing state
- **Services**: Photo library, in-app purchases, sharing

---

## Project Structure

```
CatwangFree/
├── CatwangFree/
│   ├── App/
│   │   ├── CatwangApp.swift          # @main app entry point
│   │   └── AppDelegate.swift         # (if needed for legacy support)
│   │
│   ├── Models/
│   │   ├── StickerPack.swift
│   │   ├── Sticker.swift
│   │   ├── UserImage.swift
│   │   └── PurchaseProduct.swift
│   │
│   ├── ViewModels/
│   │   ├── PhotoPickerViewModel.swift
│   │   ├── PlayViewModel.swift
│   │   ├── StickerViewModel.swift
│   │   ├── ShareViewModel.swift
│   │   └── PurchaseViewModel.swift
│   │
│   ├── Views/
│   │   ├── ContentView.swift         # Main entry view
│   │   ├── PhotoPickerView.swift
│   │   ├── PlayView.swift            # Main editing view
│   │   ├── StickerSelectionView.swift
│   │   ├── ShareView.swift
│   │   └── Components/
│   │       ├── StickerImageView.swift
│   │       ├── PaintView.swift       # UIKit wrapper
│   │       └── ToolbarView.swift
│   │
│   ├── Services/
│   │   ├── PhotoLibraryService.swift
│   │   ├── PurchaseService.swift
│   │   ├── ShareService.swift
│   │   └── StickerLoaderService.swift
│   │
│   ├── Utilities/
│   │   ├── ImageExtensions.swift
│   │   ├── Constants.swift
│   │   └── Helpers.swift
│   │
│   └── Resources/
│       ├── Assets.xcassets/
│       └── Localizable.strings
│
└── CatwangFreeTests/
    └── (Unit tests)
```

---

## Migration Phases

### **Phase 1: Project Setup & Foundation** (Week 1)
**Goal**: Create new Swift/SwiftUI project structure

#### Tasks:
1. **Create New Swift Project**
   - New Xcode project with SwiftUI template
   - iOS 15.0+ deployment target
   - Configure bundle identifier
   - Set up app icons and launch screen

2. **Project Structure Setup**
   - Create folder structure (Models, Views, ViewModels, Services, Utilities)
   - Set up Swift Package Manager (if needed)
   - Configure build settings

3. **Migrate Constants & Configuration**
   - Convert `Constants.h` to `Constants.swift`
   - Migrate sticker pack definitions
   - Set up localization structure

4. **Asset Migration**
   - Copy all sticker images
   - Copy UI assets
   - Organize in Assets.xcassets

**Deliverable**: Working SwiftUI app that launches with basic structure

---

### **Phase 2: Core Models & Services** (Week 2)
**Goal**: Build foundation data models and services

#### Tasks:
1. **Model Migration**
   - `StickerPack.swift` - Sticker pack data structure
   - `Sticker.swift` - Individual sticker model
   - `UserImage.swift` - User photo model
   - `PurchaseProduct.swift` - In-app purchase model

2. **Service Layer**
   - `StickerLoaderService.swift` - Load stickers from bundle
   - `PhotoLibraryService.swift` - Modern Photos framework wrapper
   - `Constants.swift` - App constants and configuration

3. **Utilities**
   - `ImageExtensions.swift` - Image processing utilities
   - Migrate `UIImage+Trim.swift` functionality
   - Migrate `UIImage+ImageEffects.swift` functionality

**Deliverable**: Complete model layer with services

---

### **Phase 3: Photo Picker & Main Navigation** (Week 3)
**Goal**: Implement photo selection and main app flow

#### Tasks:
1. **PhotoPickerView**
   - SwiftUI view for camera/photo library selection
   - Use `PhotosPicker` (iOS 16+) or `UIImagePickerController` wrapper
   - Handle permissions

2. **ContentView**
   - Main navigation structure
   - Tab-based or navigation-based flow
   - Connect to photo picker

3. **Navigation Flow**
   - Photo selection → PlayView
   - Proper navigation handling

**Deliverable**: Working photo picker that navigates to editing view

---

### **Phase 4: PlayView (Main Editing Screen)** (Weeks 4-5)
**Goal**: Core editing functionality with stickers

#### Tasks:
1. **PlayView Structure**
   - SwiftUI view with image display
   - Sticker overlay system
   - Toolbar integration

2. **StickerImageView**
   - SwiftUI view for draggable/rotatable stickers
   - Gesture handling (drag, pinch, rotate)
   - Selection state management

3. **StickerViewModel**
   - Manage sticker state
   - Handle sticker operations (add, remove, transform)
   - Coordinate with PlayView

4. **Sticker Selection**
   - StickerCategoryView (SwiftUI)
   - StickerPackView (SwiftUI)
   - Collection view for stickers

**Deliverable**: Working sticker editing interface

---

### **Phase 5: Paint/Drawing Functionality** (Week 6)
**Goal**: Implement drawing/painting tools

#### Tasks:
1. **PaintView Wrapper**
   - Create UIKit wrapper for PaintView
   - Use `UIViewRepresentable` to integrate with SwiftUI
   - Maintain existing drawing logic (convert to Swift)

2. **PaintToolSetView**
   - SwiftUI toolbar for paint tools
   - Color picker
   - Brush size selector
   - Eraser toggle

3. **PaintViewModel**
   - Manage paint state
   - Coordinate with PaintView

**Deliverable**: Working paint/draw functionality

---

### **Phase 6: Share Functionality** (Week 7)
**Goal**: Modern sharing implementation

#### Tasks:
1. **ShareView**
   - SwiftUI share interface
   - Preview of final image
   - Share options

2. **ShareService**
   - Use native `UIActivityViewController`
   - Photo library saving (Photos framework)
   - Social media sharing
   - Export functionality

3. **Image Export**
   - Render final composite image
   - Save to photo library
   - Share via system share sheet

**Deliverable**: Complete sharing functionality

---

### **Phase 7: In-App Purchases** (Week 8)
**Goal**: Modern StoreKit 2 implementation

#### Tasks:
1. **PurchaseService**
   - Migrate from old StoreKit to StoreKit 2
   - Use async/await patterns
   - Product loading
   - Purchase handling
   - Restore purchases

2. **PurchaseViewModel**
   - Manage purchase state
   - Handle UI updates
   - Product availability

3. **Purchase UI**
   - SwiftUI purchase interface
   - Product display
   - Purchase buttons
   - Restore button

**Deliverable**: Working in-app purchase system

---

### **Phase 8: Polish & Optimization** (Week 9)
**Goal**: Refinement and performance

#### Tasks:
1. **UI/UX Polish**
   - Animations
   - Transitions
   - Loading states
   - Error handling

2. **Performance Optimization**
   - Image caching
   - Lazy loading
   - Memory management
   - Rendering optimization

3. **Error Handling**
   - User-friendly error messages
   - Graceful degradation
   - Permission handling

**Deliverable**: Polished, performant app

---

### **Phase 9: Testing & Bug Fixes** (Week 10)
**Goal**: Comprehensive testing

#### Tasks:
1. **Device Testing**
   - iPhone (various sizes)
   - iPad
   - iOS 15, 16, 17

2. **Feature Testing**
   - All sticker packs
   - All purchase flows
   - All sharing options
   - Edge cases

3. **Bug Fixes**
   - Fix identified issues
   - Performance improvements

**Deliverable**: Fully tested, bug-free app

---

### **Phase 10: App Store Preparation** (Week 11)
**Goal**: Ready for submission

#### Tasks:
1. **Info.plist Configuration**
   - Privacy descriptions
   - App capabilities
   - URL schemes

2. **App Store Assets**
   - Screenshots
   - App description
   - Keywords

3. **Final Validation**
   - App Store Connect setup
   - Build validation
   - Archive creation

**Deliverable**: App ready for App Store submission

---

## Technical Decisions

### **SwiftUI vs UIKit Interop**
- **SwiftUI**: All new views, navigation, UI components
- **UIKit Wrappers**: Complex views like PaintView (using `UIViewRepresentable`)
- **Gradual Migration**: Can keep some UIKit initially, migrate later

### **State Management**
- **@StateObject**: For ViewModels
- **@ObservedObject**: For shared state
- **@EnvironmentObject**: For app-wide state (if needed)
- **Combine**: For reactive programming where beneficial

### **Dependencies**
- **Native Only**: Use Swift standard library and iOS frameworks
- **No Third-Party**: Remove AFNetworking, SVProgressHUD, etc.
- **Modern APIs**: URLSession, Photos framework, StoreKit 2

### **Image Processing**
- **Core Image**: For filters/effects
- **Core Graphics**: For drawing and compositing
- **Metal**: (Optional) For advanced image processing

### **Networking**
- **URLSession**: Native networking
- **Async/Await**: Modern async patterns
- **Combine**: For reactive networking (if needed)

---

## Key Migrations

### **1. Photo Library Access**
**Old**: `ALAssetsLibrary`
```objective-c
ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
[library saveImage:image toAlbum:albumName withCompletionBlock:^(NSError *error) {
    // ...
}];
```

**New**: `PHPhotoLibrary` (Swift)
```swift
import Photos

PHPhotoLibrary.requestAuthorization { status in
    if status == .authorized {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        })
    }
}
```

### **2. Alerts**
**Old**: `UIAlertView`
```objective-c
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" 
                                                message:@"Message" 
                                               delegate:self 
                                      cancelButtonTitle:@"OK" 
                                      otherButtonTitles:nil];
[alert show];
```

**New**: SwiftUI Alert
```swift
.alert("Title", isPresented: $showAlert) {
    Button("OK") { }
} message: {
    Text("Message")
}
```

### **3. In-App Purchases**
**Old**: StoreKit 1 (delegate-based)
**New**: StoreKit 2 (async/await)
```swift
import StoreKit

let products = try await Product.products(for: productIDs)
for product in products {
    let result = try await product.purchase()
    // Handle result
}
```

### **4. Sharing**
**Old**: Custom Twitter/Facebook implementations
**New**: `UIActivityViewController` (via `UIViewControllerRepresentable`)
```swift
struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
```

---

## File-by-File Migration Map

| Objective-C File | Swift/SwiftUI Equivalent |
|------------------|-------------------------|
| `AppDelegate.m/h` | `CatwangApp.swift` (SwiftUI App) |
| `ViewController.m/h` | `ContentView.swift` + `PhotoPickerView.swift` |
| `PlayViewController.m/h` | `PlayView.swift` + `PlayViewModel.swift` |
| `ShareViewController.m/h` | `ShareView.swift` + `ShareViewModel.swift` |
| `StickerCategoryViewController.m/h` | `StickerCategoryView.swift` |
| `SelectStickerQuickViewController.m/h` | `StickerSelectionView.swift` |
| `StickyImageView.m/h` | `StickerImageView.swift` (SwiftUI) |
| `PaintView.m/h` | `PaintView.swift` (UIKit wrapper) |
| `PaintToolSetViewController.m/h` | `PaintToolSetView.swift` |
| `PlayEditModeViewController.m/h` | `EditToolbarView.swift` |
| `CWInAppHelper.m/h` | `PurchaseService.swift` + `PurchaseViewModel.swift` |
| `ALAssetsLibrary+CustomPhotoAlbum.m/h` | `PhotoLibraryService.swift` |
| `Constants.h` | `Constants.swift` |
| `UIImage+Trim.m/h` | `ImageExtensions.swift` |
| `UIImage+ImageEffects.m/h` | `ImageExtensions.swift` |

---

## Timeline Summary

| Phase | Duration | Cumulative |
|-------|----------|------------|
| Phase 1: Setup | 1 week | Week 1 |
| Phase 2: Models | 1 week | Week 2 |
| Phase 3: Photo Picker | 1 week | Week 3 |
| Phase 4: PlayView | 2 weeks | Week 5 |
| Phase 5: Paint | 1 week | Week 6 |
| Phase 6: Share | 1 week | Week 7 |
| Phase 7: IAP | 1 week | Week 8 |
| Phase 8: Polish | 1 week | Week 9 |
| Phase 9: Testing | 1 week | Week 10 |
| Phase 10: App Store | 1 week | Week 11 |

**Total: 11 weeks (~3 months)**

---

## Success Criteria

✅ 100% Swift codebase  
✅ SwiftUI for all UI  
✅ iOS 15.0+ deployment target  
✅ Modern APIs (Photos, StoreKit 2, etc.)  
✅ No deprecated APIs  
✅ MVVM architecture  
✅ Clean, maintainable code  
✅ All features working  
✅ App Store ready  

---

## Risk Mitigation

1. **Complex Views**: Use UIKit wrappers initially, migrate to pure SwiftUI later
2. **Performance**: Profile early, optimize as needed
3. **Feature Parity**: Maintain checklist of all features during migration
4. **Testing**: Test on real devices throughout development
5. **Rollback Plan**: Keep Objective-C code in separate branch until migration complete

---

## Next Steps

1. Review and approve this plan
2. Set up new Swift project
3. Begin Phase 1: Project Setup
4. Iterate through phases with regular testing
