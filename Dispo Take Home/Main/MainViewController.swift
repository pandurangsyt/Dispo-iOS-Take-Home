import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func reloadCollection(_ list: [GifObject])
}

class MainViewController: UIViewController {
    
    private var viewModel: MainViewModelDelegate?
    private var gifList = [GifObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        viewModel = MainViewModel(delegate: self)
        addCollectionView()
        viewModel?.getTrendingGifs()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "search gifs..."
        searchBar.delegate = self
        return searchBar
    }()
    
    private var layout: UICollectionViewLayout {
        // TODO: implement
        // PY - Implemented
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionViewLayout.scrollDirection = .vertical
        return collectionViewLayout
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .white
        collectionView.keyboardDismissMode = .onDrag
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListGifsCollectionViewCell.self, forCellWithReuseIdentifier: "ListGifsCollectionViewCell")
        return collectionView
    }()
    
    private lazy var navigationDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        return view
    }()
    
    private func addCollectionView() {
        view.addSubview(navigationDivider)
        view.addSubview(collectionView)
        
        navigationDivider.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview()
            $0.top.equalTo(100)
        }
        collectionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview()
            $0.top.equalTo(navigationDivider.snp.bottom)
            $0.bottom.equalToSuperview()
            //            $0.edges.equalToSuperview()
        }
    }
}

// MARK: UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: Navigate to detail view controller
        // PY - Implemented
        let gif = gifList[indexPath.row]
        let gifModel = SearchResult(id: gif.id, gifUrl: gif.url, title: gif.title)
        let detailVC = DetailViewController(searchResult: gifModel)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListGifsCollectionViewCell", for: indexPath) as? ListGifsCollectionViewCell {
            let gif = gifList[indexPath.row]
            let gifModel = SearchResult(id: gif.id, gifUrl: gif.images.fixed_height.url, title: gif.title)
            cell.setupCell(gifModel)
            return cell
        }
        fatalError()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: Update it with result
        // PY - Implemented
        return gifList.count
    }
}

// MARK: MainViewControllerDelegate
extension MainViewController: MainViewControllerDelegate {
    func reloadCollection(_ list: [GifObject]) {
        self.gifList = list
        self.collectionView.reloadData()
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 16, height: 80)
    }
}
// MARK: UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO: implement
        // PY - Implemented
        self.viewModel?.searchGifs(searchText: searchText)
    }
}
