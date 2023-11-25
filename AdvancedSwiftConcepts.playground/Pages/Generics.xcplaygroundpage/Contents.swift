import SwiftUI
// AdvancedSwiftConcepts: Generics
/// Generics can be abit tough to understand as they are very abstract

/// To begin we have created a view model for our generics view with some simple functionality and used it within our view

class GenericsViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    init() {
        dataArray = ["one", "Two", "Three", "Four"]
    }
    
    func removeDataFromDataArray() {
        dataArray.removeAll()
    }
}

struct Generics: View {
    @StateObject private var viewModel = GenericsViewModel()
    
    var body: some View {
        ForEach(viewModel.dataArray, id: \.self) { item in
            Text(item)
                .onTapGesture {
                    viewModel.removeDataFromDataArray()
                }
        }
    }
}

/// So we used this example to illustrate how we are always using generics already in some or other fashion
///  If we look at our remove function the .removeAll() will always work on any collection type.
///  This is because an array works with and accepts generic types.

/// This is what makes generics so powerful because they arent restricted by a specific type.

///lets create a new struct called string model which again will host functionality
struct StringModel {
    let info: String?
    
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

/// with this we can then replace functionality within the view model, and display that on our screen
class GenericsViewModel_2: ObservableObject {
    @Published var stringModel = StringModel(info: "Hello Developer!")
}

/// now what would happen if we wanted to update the model to accept a boolean? instead of a string?
/// we could create another struct...
struct BoolModel {
    let info: Bool?
    
    func removeInfo() -> BoolModel {
        BoolModel(info: nil)
    }
}


/// while yes we could create another struct, however that could lead to a bunch of code duplication.
///  that makes our code very unscalable and unmaintainable
///
class GenericsViewModel_3: ObservableObject {
    @Published var stringModel = StringModel(info: "Hello Developer!")
    @Published var boolModel = BoolModel(info: true)
}

///  so what we want is a generic model which takes any type.
///  and how we do that is we instantiate the struct with a type input which we will go on to declare: GenericModel<customType>
struct GenericModel<customType> {
    let info: customType?
    
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

/// adding this to our view model
class GenericsViewModel_4: ObservableObject {
    @Published var stringModel = StringModel(info: "Hello Developer!")
    @Published var boolModel = BoolModel(info: true)
    @Published var genericStringModel = GenericModel(info: "Defined as string now")
    @Published var genericBoolModel = GenericModel(info: true)
    @Published var genericIntModel = GenericModel(info: 23)
}

/// This approach now makes the initial type specific models unnecessary, our code cleaner, scalable and maintainable
///  In production the customType would normally be written as T for type , but you can indeed name this  anything that youd like.

// Using Generics with views
/// usually with views we usually give it a value to be init with and that value is then used within the body of the view
struct GenericView: View {
    var bodyText: String = "Generic view"
    
    var body: some View {
        Text(bodyText)
    }
}

/// so what if we wanted to pass in a subview to this view?

struct GenericView_2: View {
    var bodyText: String = "Generic view"
  //  var content: View
    
    var body: some View {
        Text(bodyText)
    }
}
/// you would notice that because the view is a protocol can only be used as a generic constraint, so which type would we have to make the content to pass in an actual view

struct GenericView_3<CustomType>: View {
    var bodyText: String = "Generic view"
    var content: CustomType
    
    var body: some View {
        Text(bodyText)
       // content
    }
}

/// but now the problem is that the type being used in content doesnt conform to View to be passed into the body of our view.
///  we would have to define that custom type as any type that conforms to view, this however restricts us to only use an object that conforms to view, we cant go and pass in string as our custom types protocol

struct GenericView_4<CustomType: View>: View {
    var bodyText: String = "Generic view"
    var content: CustomType
    
    var body: some View {
        Text(bodyText)
    }
}

/// and that in essence is the basics of Generics and how we can use them
