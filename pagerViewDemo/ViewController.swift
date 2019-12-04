//
//  ViewController.swift
//  pagerViewDemo
//
//  Created by jyothish.johnson on 03/12/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController {
    
    lazy var pages : [UIViewController] =
         [
            self.getViewController(withIdentifier: "P1"),
            self.getViewController(withIdentifier: "P2"),
            self.getViewController(withIdentifier: "P3")
        ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = pages.first
        {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.pageIndicatorTintColor = UIColor.cyan
        appearance.currentPageIndicatorTintColor = UIColor.red
    }
    
    func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }


}

extension ViewController : UIPageViewControllerDataSource{
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        print("Count method called")
        //give the total count
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        print("presentationIndex called")
        //give the initial presentation point index
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        print("viewControllerBefore called")
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0          else { return pages.last }
        
        guard pages.count > previousIndex else { return nil        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("viewControllerAfter called")

        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else { return pages.first }
        
        guard pages.count > nextIndex else { return nil         }
        
        return pages[nextIndex]
    }
}

extension ViewController : UIPageViewControllerDelegate{
    
}

