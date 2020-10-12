component extends="preside.system.handlers.Errors"{

	property name="pageLayoutsService" inject="pageLayoutsService";

<!--- VIEWLETS --->

	private string function notFound( event, rc, prc, args={} ) {
		var pageLayout = pageLayoutsService.getLayoutsForSitetreePageType('notFound');
		if( event.getCurrentPageType() != 'notFound' ){
			return renderPageLayout( layout=pageLayout[1]?:"", body=super.notFound( argumentCollection = arguments ) );
		}
		return super.notFound( argumentCollection = arguments );
	}

	private string function accessDenied( event, rc, prc, args={} ) {
		var pageLayout = pageLayoutsService.getLayoutsForSitetreePageType('accessDenied');
		if( event.getCurrentPageType() != 'accessDenied' ){
			return renderPageLayout( layout=pageLayout[1]?:"", body=super.accessDenied( argumentCollection = arguments ) );
		}
		return super.accessDenied( argumentCollection = arguments );
	}

}