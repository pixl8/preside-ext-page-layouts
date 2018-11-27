<cffunction name="renderPageLayout" access="public" returntype="any" output="false">
	<cfscript>
		var args = arguments;

		return getController().getWireBox().getInstance( "pageLayoutsService" ).renderPageLayout( argumentCollection=arguments );
	</cfscript>
</cffunction>