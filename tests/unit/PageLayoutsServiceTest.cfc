component extends="testbox.system.BaseSpec" {

	function run(){
		describe( "getDefaultPageLayout()", function(){
			it( "should return the configured default layout", function(){
				var defaultLayout = CreateUUId();
				var svc = _getService( defaultLayout );

				expect( svc.getDefaultPageLayout() ).toBe( defaultLayout );
			} );
		} );

		describe( "getDefaultSiteTreePageLayout()", function(){
			it( "should return the configured default layout", function(){
				var defaultLayout = CreateUUId();
				var defaultSiteTreePageLayout = CreateUUId();
				var svc = _getService( defaultLayout, defaultSiteTreePageLayout );

				expect( svc.getDefaultSiteTreePageLayout() ).toBe( defaultSiteTreePageLayout );
			} );

			it( "should return the defaultPageLayout when the default site tree page layout is empty", function(){
				var defaultLayout = CreateUUId();
				var svc = _getService( defaultLayout );

				expect( svc.getDefaultSiteTreePageLayout() ).toBe( defaultLayout );
			} );
		} );

		describe( "setRequestPageLayout()", function(){
			it( "should set a private variable in the request context", function(){
				var svc = _getService();
				var layout = CreateUUId();

				mockRequestContext.$( "setValue" );
				svc.setRequestPageLayout( layout );

				var callLog = mockRequestContext.$callLog().setValue;
				expect( callLog.len() ).toBe( 1 );
				expect( callLog[ 1 ] ).toBe( {
					  name    = "__presidePageLayout"
					, private = true
					, value   = layout
				} );


			} );
		} );

		describe( "getRequestPageLayout()", function(){
			it( "should get value from private variable in the request context", function(){
				var svc = _getService();
				var layout = CreateUUId();

				mockRequestContext.$( "getValue" ).$args( name="__presidePageLayout", private=true, defaultValue="" ).$results( layout );

				expect( svc.getRequestPageLayout() ).toBe( layout );
			} );

			it( "should return the default page layout if no variable exists in private request context", function(){
				var defaultLayout = CreateUUId();
				var svc = _getService( defaultLayout );

				mockRequestContext.$( "getValue" ).$args( name="__presidePageLayout", private=true, defaultValue="" ).$results( "" );

				expect( svc.getRequestPageLayout() ).toBe( defaultLayout );
			} );
		} );

		describe( "getLayoutsForSitetreePageType", function(){
			it( "should return an array of possible site templates when page type cfc defines them in annotation", function(){
				var svc = _getService();
				var templates = [ CreateUUId(), CreateUUId(), CreateUUId() ];
				var pageType = "some_type";

				mockPresideObjectService.$( "getObjectAttribute" ).$args(
					  objectName    = pageType
					, attributeName = "pageLayouts"
				).$results( templates.toList() )

				expect( svc.getLayoutsForSitetreePageType( pageType ) ).toBe( templates );
			} );

			it( "should return default site tree page layout when no page templates defined on the object", function(){
				var defaultLayout = CreateUUId();
				var defaultSiteTreePageLayout = CreateUUId();
				var svc = _getService( defaultLayout, defaultSiteTreePageLayout );
				var pageType = "some_type";

				mockPresideObjectService.$( "getObjectAttribute" ).$args(
					  objectName    = pageType
					, attributeName = "pageLayouts"
				).$results( "" )

				expect( svc.getLayoutsForSitetreePageType( pageType ) ).toBe( [ defaultSiteTreePageLayout ] );
			} );
		} );

		describe( "getLayoutForCurrentPage()", function(){
			it( "should get the layout from event.getPageProperty( 'page_layout' ) and use that when a valid layout for the page type", function(){
				var svc          = _getService();
				var pageType     = "test_type";
				var validLayouts = [ CreateUUId(), CreateUUId(), CreateUUId(), CreateUUId() ];
				var layout       = validLayouts[ 2 ];

				svc.$( "getLayoutsForSitetreePageType" ).$args( pageType ).$results( validLayouts );
				mockRequestContext.$( "getCurrentPageType", pageType );
				mockRequestContext.$( "getPageProperty" ).$args( "page_layout" ).$results( layout );

				expect( svc.getLayoutForCurrentPage() ).toBe( layout );
			} );

			it( "should return the first valid layout for the page type when the saved layout is not valid for the page type", function(){
				var svc          = _getService();
				var pageType     = "test_type";
				var validLayouts = [ CreateUUId(), CreateUUId(), CreateUUId(), CreateUUId() ];
				var layout       = CreateUUId();

				svc.$( "getLayoutsForSitetreePageType" ).$args( pageType ).$results( validLayouts );
				mockRequestContext.$( "getCurrentPageType", pageType );
				mockRequestContext.$( "getPageProperty" ).$args( "page_layout" ).$results( layout );

				expect( svc.getLayoutForCurrentPage() ).toBe( validLayouts[ 1 ] );
			} );

		} );

		describe( "renderPageLayout()", function(){
			it( "should return result of conventions based viewlet for the given layout, passing in args.body for given body content", function(){
				var svc                    = _getService();
				var body                   = CreateUUId();
				var layout                 = "my_layout";
				var conventionBasedViewlet = "layout.page.#layout#";
				var dummyResult            = CreateUUId();

				svc.$( "$renderViewlet" ).$args( event=conventionBasedViewlet, args={ body=body } ).$results( dummyResult );

				expect( svc.renderPageLayout( body, layout ) ).toBe( dummyResult );
			} );

			it( "should do nothing when passed in renderer is empty", function(){
				var svc    = _getService();
				var body   = CreateUUId();
				var layout = "";

				expect( svc.renderPageLayout( body, layout ) ).toBe( body );
			} );
		} );
	}

// private helpers
	private any function _getService( string defaultPageLayout="test", string defaultSiteTreePageLayout="" ) {
		var svc = createMock( object=new pagelayouts.services.PageLayoutsService( pageLayoutConfiguration=arguments ) );

		mockRequestContext       = createStub();
		mockPresideObjectService = createStub();

		svc.$( "$getRequestContext", mockRequestContext )
		svc.$( "$getPresideObjectService", mockPresideObjectService )

		return svc;
	}

}