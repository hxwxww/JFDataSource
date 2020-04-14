# JFDataSource
A simple way to create dataSource and delegate for UITableView and UICollectionView

## Usage

- UITableView:

store  `TableViewDataSource` instance:
```
private let dataSource = TableViewDataSource()
```

set DatatSource and Delegate:
```
tableView.dataSource = dataSource
tableView.delegate = dataSource
```

config section:
```
let section = TableViewScection(items: feeds) { (tableView, indexPath, feed) -> UITableViewCell in
    let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
    cell.configureCell(feed: feed)
    return cell
}

dataSource.sections = [section]
```

- UICollectionView:

store  `CollectionViewDataSource` instance:
```
private let dataSource = CollectionViewDataSource()
```

set DatatSource and Delegate:
```
collectionView.dataSource = dataSource
collectionView.delegate = dataSource
```

config section:
```
let section = CollectionViewSection(items: feeds) { (collectionView, indexPath, feed) -> UICollectionViewCell in
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactCell", for: indexPath) as! ContactCell
    cell.configureCell(feed: feed)
    return cell
}

dataSource.sections = [section]
```

