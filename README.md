Ever wondered how Path (in path view) and foursquare (in check in view) did that parallax image effect (when you pulling down table view)?
I was wondering also and it's actually prety easy...

    RRTableHeaderView *tableHeaderView = [[RRTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 80)];
    [tableHeaderView setBackgroundImage:[UIImage imageNamed:@"sayounara.jpg"]];
    [self.tableView setTableHeaderView:tableHeaderView];
    [tableHeaderView release];

