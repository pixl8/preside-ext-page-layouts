component {

	public void function configure( required struct config ) {
		var conf     = arguments.config;
		var settings = conf.settings ?: {};

		_setupExtensionSettings( settings );
		_setupInterceptors( conf );
	}

// private helpers
	private void function _setupExtensionSettings( settings ) {
		settings.pageLayouts = settings.pageLayouts ?: {
			  defaultPageLayout         = ""
			, defaultSiteTreePageLayout = ""
		};
	}

	private void function _setupInterceptors( conf ) {
		conf.interceptors.append( { class="app.extensions.preside-ext-page-layouts.interceptors.PageLayoutsInterceptor" } );
	}
}
