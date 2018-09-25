//
//  GridTimerView+DataSource.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 4/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import UIKit

extension GridTimerView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(dataSource?.numberOfRows(inGridTimerView: self))
        return dataSource?.numberOfRows(inGridTimerView: self) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.gridTimerView(gridTimerView: self, numberOfItemsAtRowIndex: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellforitem")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridTimeLineView.uniqueIdentifier, for: indexPath)
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            let dataSource = dataSource,
            kind == UICollectionView.elementKindSectionHeader,
            let customCellType = customCellType,
            let reusableCell = dequeReusableView(withType: customCellType.self, forRowIndex: indexPath.section)
            else {
                fatalError("Custom item view register is needed! Register your custom item view once GridTimerView is initializated\n")
        }
        
        let cell = dataSource.gridTimerView(gridTimerView: self, setupView: reusableCell, forItemIndex: indexPath.item, inRowIndex: indexPath.section)
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
}

extension GridTimerView: CustomCollectionViewLayoutDataSource {
    
    func initDateForIndexPath(indexPath: IndexPath) -> Date? {
        return dataSource?.gridTimerView(gridTimerView: self, startTimeForItemIndex: indexPath.item, inRowIndex: indexPath.section)
    }
    
    func endDateForIndexPath(indexPath: IndexPath) -> Date? {
        return dataSource?.gridTimerView(gridTimerView: self, endTimeForItemIndex: indexPath.item, inRowIndex: indexPath.section)
    }
    
    func cellHeaderHeight() -> CGFloat? {
        return dataSource?.heightForRow(inGridTimerView: self)
    }
    
    func cellItemHeight() -> CGFloat? {
        return dataSource?.heightForTimelineRow(inGridTimerView: self)
    }
}
