component extends="preside.system.handlers.Errors"{

	property name="pageLayoutsService" inject="pageLayoutsService";

	private string function notFound( event, rc, prc, args={} ) {
		if( event.getCurrentPageType() != "notFound" ){
			var pageLayout = pageLayoutsService.getLayoutsForSitetreePageType( "notFound" );

			return renderPageLayout(
				  layout = pageLayout[ 1 ] ?: ""
				, body   = super.notFound( argumentCollection=arguments )
			);
		}

		return super.notFound( argumentCollection=arguments );
	}

	private string function accessDenied( event, rc, prc, args={} ) {
		if( event.getCurrentPageType() != "accessDenied" ){
			var pageLayout = pageLayoutsService.getLayoutsForSitetreePageType( "accessDenied" );

			return renderPageLayout(
				  layout = pageLayout[ 1 ] ?: ""
				, body   = super.accessDenied( argumentCollection=arguments )
			);
		}

		return super.accessDenied( argumentCollection = arguments );
	}

}