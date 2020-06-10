component extends="preside.system.handlers.Errors"{

	// remove once this has checked into Pagelayout extension
	property name="pageLayoutsService" inject="pageLayoutsService";

<!--- VIEWLETS --->

	private string function notFound( event, rc, prc, args={} ) {
		var pageLayout = pageLayoutsService.getLayoutsForSitetreePageType('notFound');
		return renderPageLayout( layout=pageLayout[1]?:"", body=super.notFound( argumentCollection = arguments ) );
	}

	private string function accessDenied( event, rc, prc, args={} ) {
		var pageLayout = pageLayoutsService.getLayoutsForSitetreePageType('accessDenied');
		return renderPageLayout( layout=pageLayout[1]?:"", body=super.accessDenied( argumentCollection = arguments ) );
	}

}