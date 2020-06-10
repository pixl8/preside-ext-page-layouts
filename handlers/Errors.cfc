component extends="preside.system.handlers.Errors"{

<!--- VIEWLETS --->
	private string function notFound( event, rc, prc, args={} ) {
		return renderPageLayout( super.notFound( argumentCollection = arguments ) );
	}

	private string function accessDenied( event, rc, prc, args={} ) {
		return renderPageLayout( super.accessDenied( argumentCollection = arguments ) );
	}

}