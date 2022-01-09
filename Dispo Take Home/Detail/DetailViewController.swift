import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func updateUI(_ gifObject: GifObject)
}

class DetailViewController: UIViewController {
    
    private lazy var navigationDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        return view
    }()
    
    private lazy var gifImage: UIImageView = {
        let gif = UIImageView()
        gif.snp.makeConstraints {
            $0.height.equalTo(300)
        }
        return gif
    }()
    
    private lazy var gifTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        return label
    }()
    
    private lazy var source: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        return label
    }()
    
    private lazy var rating: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        return label
    }()
        
    private let gifId: String
    private var viewModel: DetailViewModelDelegate?
    
    init(searchResult: SearchResult) {
        self.gifId = searchResult.id
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Gif details"
        setupUI()
        self.viewModel = DetailViewModel(delegate: self)
        viewModel?.getGifById(id: gifId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.addSubview(navigationDivider)
        view.addSubview(gifImage)
        view.addSubview(gifTitle)
        view.addSubview(source)
        view.addSubview(rating)
        setupConstraints()
    }
    
    private func setupConstraints() {
        navigationDivider.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview()
            $0.top.equalTo(100)
        }
        gifImage.snp.makeConstraints {
            $0.top.equalTo(navigationDivider.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(32)
            $0.centerX.equalToSuperview()
        }
        gifTitle.snp.makeConstraints{
            $0.top.equalTo(gifImage.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        source.snp.makeConstraints{
            $0.top.equalTo(gifTitle.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        rating.snp.makeConstraints{
            $0.top.equalTo(source.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: DetailViewControllerDelegate
extension DetailViewController: DetailViewControllerDelegate {
    func updateUI(_ gifObject: GifObject) {
        self.gifTitle.text = "Title: " + gifObject.title
        self.gifImage.kf.setImage(with: gifObject.images.fixed_height.url)
        self.source.text = "Source: " + gifObject.source_tld
        self.rating.text = "Rating: " + gifObject.rating
    }
}
