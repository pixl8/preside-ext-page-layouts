component output="false" {
	this.name = "Page Layouts Test Suite";

	this.mappings[ '/tests'   ] = ExpandPath( "/" );
	this.mappings[ '/testbox' ] = ExpandPath( "/testbox" );
	this.mappings[ '/pagelayouts' ] = ExpandPath( "../" );

	setting requesttimeout="6000";

	public void function onRequest( required string requestedTemplate ) output=true {
		include template=arguments.requestedTemplate;
	}
}