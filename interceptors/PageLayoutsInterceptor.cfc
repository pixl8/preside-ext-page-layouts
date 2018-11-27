component extends="coldbox.system.Interceptor"{

	property name="pageLayoutsService" inject="delayedInjector:pageLayoutsService";

	public void function configure() {}

	public void function postRenderSiteTreePage( event ) {
		var rc            = event.getCollection();
		var layoutService = pageLayoutsService.get();
		var layout        = layoutService.getLayoutForCurrentPage();

		if ( Len( Trim( layout ) ) ) {
			layoutService.setRequestPageLayout( layout );
			rc.body = layoutService.renderPageLayout( rc.body ?: "" );
		}
	}
}