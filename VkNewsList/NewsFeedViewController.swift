//
//  NewsFeedViewController.swift
//  VkNewsList
//
//  Created by Philip Bratov on 26.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic, NewsFeedCodeCellDelegate {

    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?

    private var feedViewModel = FeedViewModel.init(cells: [])

    @IBOutlet weak var table: UITableView!

    // MARK: Object lifecycle

    // MARK: Setup

    private func setup() {
        let viewController        = self
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        let router                = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }

    // MARK: Routing



    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        table.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.reuseId)
        table.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseIdentifier)

        table.separatorStyle = .none
        table.backgroundColor = .clear
        self.view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        self.interactor?.makeRequest(request: .getNewsFeed)
    }

    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {

        case .displayNewsFeed(feedViewModel: let feedViewModel):
            self.feedViewModel = feedViewModel
            table.reloadData()
        }
    }

    //MARK:- NewsFeedCodeCellDelegate
    func revealPost(for cell: NewsFeedCodeCell) {
        guard let indexPath = table.indexPath(for: cell) else { return }
        let cellViewModel = feedViewModel.cells[indexPath.row]

        interactor?.makeRequest(request: .revealPostIds(postId: cellViewModel.postId))
        print("tap")
    }
}


extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedViewModel.cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId, for: indexPath) as! NewsFeedCell
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseIdentifier, for: indexPath) as! NewsFeedCodeCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.feedViewModel.cells[indexPath.row].sizes.totalHeight
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.feedViewModel.cells[indexPath.row].sizes.totalHeight
    }
}
