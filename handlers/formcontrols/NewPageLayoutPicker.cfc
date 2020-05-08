component {

	property name="pageTypesService"   inject="pageTypesService";
	property name="pageLayoutsService" inject="pageLayoutsService";

	public string function index( event, rc, prc, args={} ) output=false {
		var pageType = args.savedData.page_type ?: ( rc.page_type ?: "" );

		if ( !pageTypesService.pageTypeExists( pageType ) ) {
			return "**page type not found**";
		}
		var rawlayouts = pageLayoutsService.getLayoutsForSitetreePageType( pageType );
		if ( rawLayouts.len() <= 1 ) {
			return "";
		}

		var translatedLayouts = [];
		for( var layout in rawlayouts ) {
			var specificLabelUri = "page-layouts:#layout#";

			translatedLayouts.append( {
				  value    = layout
				, label    = translateResource( uri=specificLabelUri, defaultValue=layout )
			} );
		}

		translatedLayouts.sort( function( valueA, valueB ){
			return valueA.label == "index" ? 1 : ( valueA.label > valueB.label ? 1 : -1 );
		} );

		args.values = "";
		args.labels = "";

		for( var layout in translatedLayouts ) {
			args.values = args.values.listAppend( layout.value );
			args.labels = args.labels.listAppend( layout.label );
		}

		var savedValue = args.savedData[ args.name ?: "" ] ?: "";

		if ( isEmpty( savedValue ) ) {
			// setup default
			var selectedLayout = rc[ args.name ?: "" ] ?: rawLayouts[ 1 ];
			if ( !rawlayouts.findNoCase( selectedLayout ) ) {
				selectedLayout = rawLayouts[ 1 ];
			}
			rc[ args.name ?: "" ] = selectedLayout;
		}

		return renderView( view="formcontrols/select/index", args=args );
	}
}