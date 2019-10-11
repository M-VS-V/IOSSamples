print(Environment.swiftVersion)

import UIKit

protocol ModelProtocol {}

protocol ModelProvider {
    associatedtype Model: ModelProtocol
    func provideModel() -> Model
}

class AnyModelProvider<TModel: ModelProtocol> {
    typealias Model = TModel
    
    init<T: ModelProvider>(modelProvider: T) where T.Model == Model {
        modelFactory = { modelProvider.provideModel() }
    }

    func provideModel() -> Model {
        return modelFactory()
    }

    private let modelFactory: Func<Model>
}

//Generic code to perform common tasks — such as rendering a detail view for a given model:

class DetailViewControllerSimple<Model: ModelProtocol>: UIViewController {
    private let modelProvider: AnyModelProvider<Model>

    init<T: ModelProvider>(modelProvider: T) where T.Model == Model {
        // We wrap the injected provider in an AnyModelProvider
        // instance to be able to store a reference to it.
        self.modelProvider = AnyModelProvider(modelProvider: modelProvider)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let model = modelProvider.provideModel()

    }
}

//without PAT its good for

class DetailViewController2<Model: ModelProtocol>: UIViewController {
    private let modelProvider: () -> Model

    init(modelProvider: @escaping () -> Model) {
        self.modelProvider = modelProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let model = modelProvider()
    }
}

//complex requirements

class DetailViewControllerComplex<Model: ModelProtocol>: UIViewController {
    private let modelProvider: () -> Model
    private let modelBookmarker: (Model) -> Void
    private let modelDeleter: (Model) -> Void

    init(modelProvider: @escaping () -> Model,
         modelBookmarker: @escaping (Model) -> Void,
         modelDeleter: @escaping (Model) -> Void) {
        self.modelProvider = modelProvider
        self.modelBookmarker = modelBookmarker
        self.modelDeleter = modelDeleter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct ModelHandling<Model: ModelProtocol> {
    var provide: () -> Model
    var bookmark: (Model) -> Void
    var delete: (Model) -> Void
}

class DetailViewController<Model: ModelProtocol>: UIViewController {
    private let modelHandler: ModelHandling<Model>
    private lazy var model = modelHandler.provide()

    init(modelHandler: ModelHandling<Model>) {
        self.modelHandler = modelHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func bookmarkButtonTapped() {
        modelHandler.bookmark(model)
    }
    
    @objc private func deleteButtonTapped() {
        modelHandler.delete(model)
        dismiss(animated: true)
    }
    
}


