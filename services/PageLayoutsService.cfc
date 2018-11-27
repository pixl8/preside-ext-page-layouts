/**
 * @presideService true
 * @singleton      true
 */
component {

// CONSTRUCTOR
	/**
	 * @pageLayoutConfiguration.inject coldbox:setting:pagelayouts
	 *
	 */
	public any function init( required struct pageLayoutConfiguration ) {
		_setDefaultPageLayout( arguments.pageLayoutConfiguration.defaultPageLayout ?: "" );
		_setDefaultSiteTreePageLayout( Len( Trim( arguments.pageLayoutConfiguration.defaultSiteTreePageLayout ?: "" ) ) ? arguments.pageLayoutConfiguration.defaultSiteTreePageLayout : _getDefaultPageLayout() );

		return this;
	}

// PUBLIC API METHODS
	public string function renderPageLayout(
		  required string body
		,          string layout = getRequestPageLayout()
	) {
		if ( Len( Trim( arguments.layout ) ) ) {
			return $renderViewlet(
				  event = "layout.page.#arguments.layout#"
				, args  = { body=arguments.body }
			);
		}

		return arguments.body;
	}

	public string function getLayoutForCurrentPage() {
		var event           = $getRequestContext();
		var currentPageType = event.getCurrentPageType();
		var validLayouts    = getLayoutsForSitetreePageType( currentPageType );
		var fromPageDbEntry = event.getPageProperty( "page_layout" );

		if ( validLayouts.findNoCase( fromPageDbEntry ) ) {
			return fromPageDbEntry;
		}

		return validLayouts[ 1 ];
	}

	public array function getLayoutsForSitetreePageType( required string pageType ) {
		var fromObjDefinition = $getPresideObjectService().getObjectAttribute(
			  objectName    = arguments.pageType
			, attributeName = "pageLayouts"
		);

		if ( Len( Trim( fromObjDefinition ) ) ) {
			return ListToArray( fromObjDefinition );
		}

		return [ _getDefaultSiteTreePageLayout() ];
	}

	public string function getRequestPageLayout() {
		var val = $getRequestContext().getValue(
			  name         = "__presidePageLayout"
			, private      = true
			, defaultValue = ""
		);

		if ( !Len( Trim( val ) ) ) {
			return getDefaultPageLayout();
		}

		return val;
	}

	public void function setRequestPageLayout( required string layout ) {
		$getRequestContext().setValue(
			  name    = "__presidePageLayout"
			, private = true
			, value   = arguments.layout
		);
	}

	public string function getDefaultSiteTreePageLayout() {
		return _getDefaultSiteTreePageLayout();
	}

	public string function getDefaultPageLayout() {
		return _getDefaultPageLayout();
	}


// PRIVATE HELPERS

// GETTERS AND SETTERS
	private string function _getDefaultPageLayout() {
		return _defaultPageLayout;
	}
	private void function _setDefaultPageLayout( required string defaultPageLayout ) {
		_defaultPageLayout = arguments.defaultPageLayout;
	}

	private any function _getDefaultSiteTreePageLayout() {
		return _defaultSiteTreePageLayout;
	}
	private void function _setDefaultSiteTreePageLayout( required any defaultSiteTreePageLayout ) {
		_defaultSiteTreePageLayout = arguments.defaultSiteTreePageLayout;
	}

}