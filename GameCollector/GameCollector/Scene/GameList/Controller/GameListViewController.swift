//
//  ViewController.swift
//  GameCollector
//
//  Created by Ali Rıza İLHAN on 7.12.2022.
//

import UIKit



final class GameListViewController: BaseViewController {
    
    @IBOutlet private weak var gameListTableView: UITableView! {
        didSet {
            gameListTableView.delegate = self
            gameListTableView.dataSource = self
        }
    }
    private var viewModel: GameListViewModelProtocol = GameListViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    private var timer = Timer()
    private var isLoading = false // A flag to track whether we are currently loading more data
    override func viewDidLoad() {
        super.viewDidLoad()
        gameListTableView.tableFooterView = UIView()
        viewModel.delegate = self
        viewModel.fetchGames()
        viewModel.fetchGenres()
//        createNotes()
    }
    
    func initSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.scopeButtonTitles = viewModel.getGenresName()
        definesPresentationContext = true
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Game List"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.and.down.text.horizontal"),
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(showSearch)
        )
    }
    func createNotes () {
        for i in 1...10 {
            var newNotes = UserNoteModel(gameName: String(i), userNote: "alsjdada\(i)", date: Date(), id: UUID())
            CoreDataManager.shared.saveNote(newNote: newNotes)
        }
    }
    @objc func showSearch() {
        SortingView.showView() { selectedSortingFilter in
            if let selectedSortingFilter = selectedSortingFilter {
                self.viewModel.fetchGamesBySortingFilter(sortingFilter: selectedSortingFilter.filterValue())
            }
        }
    }
}

extension GameListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getGamesCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as? GameTableViewCell,
            let model = viewModel.getGame(at: indexPath.row) else { return UITableViewCell() }
        cell.configureCell(model: model)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.getGamesCount() > 5 && indexPath.row >= viewModel.getGamesCount() - 1 && !isLoading {
            isLoading = true
            viewModel.fetchMore()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailViewController") as? GameDetailViewController else { return }
        detailVC.gameId = viewModel.getGame(at: indexPath.row)?.id
//        present(detailVC, animated: true)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension GameListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if !(searchBar.text?.isEmpty ?? true){
            viewModel.searchGames(searchText: "")
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.searchGames(searchText: String(searchText))
        })
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
     
    }
  
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if selectedScope != 0 {
            let selectedGenreId = self.viewModel.getGenre(at: selectedScope-1 )?.id
            self.viewModel.fetchGameByGenre(genreId: selectedGenreId)
        } else {
            self.viewModel.fetchGameByGenre(genreId: nil)
        }
       
        //        scopeButtonPressed = true
        //        let scopeButton = searchController.searchBar.scopeButtonTitles!
        //        [searchController.searchBar.selectedScopeButtonIndex]
        //        gameListTableView.reloadData()
        
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("Click")
    }
    
    
}

extension GameListViewController: GameListViewModelDelegate {
    func genreLoaded() {
        self.initSearchController()
    }

    func startFetching() {
        self.indicator.startAnimating()
    }

    func endingFetching() {
        self.indicator.stopAnimating()
    }

    func gameLoaded() {
       gameListTableView.reloadData()
       isLoading = false
    }

    func onError(message: String) {
        self.showErrorAlert(message: message) {
            self.navigationController?.popViewController(animated: true)
        }
        gameListTableView.reloadData()
    }
    
    
}
