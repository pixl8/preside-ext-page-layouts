# Preside page layouts extension

The purpose of this extension is to provide a methodolgy of creating re-usable page layout templates for your Preside applications.

## Why this is needed

Coldbox already comes with a general *layouts* concept. However, these layouts are best used for a whole *site* layout. Preside _also_ comes with a layouts concept for page types. However, these layouts are specific to each page type (i.e. variations of the page type).

This extension adds a concept of re-usable page layouts across multiple page types and/or for your non site-tree page requests.

## Usage

### Creating a layout

Page layouts are just Preside viewlets that live at `layout.page.{layoutid}`. The viewlet will be passed `args.body`, the layout should wrap this in whatever HTML it requires.

For example, the following is all that is required to create a new page layout called `mylayout`:

```cfm
<!-- /views/layout/page/mylayout.cfm -->
<cfoutput>
	<div class="container">
		<h1 class="page-title">#event.getPageProperty( "title" )#</h1>

		#( args.body ?: "" )#
	</div>
</cfoutput>
```

### Assigning a layout to a page type

To assign a specific layout to your page type, add the `@pageLayouts` annotation to your page type **preside object**. e.g.

```cfc
/**
 * /preside-objects/page-types/my_page_type.cfc
 *
 * @pageLayouts mylayout
 *
 */
component {
	// ...	
}
```

#### Allowing multiple layouts for a page type

To allow editorial users to _choose_ from a number of page types, simply add a comma separated list to your **preside object**. e.g.


```cfc
/**
 * /preside-objects/page-types/my_page_type.cfc
 *
 * @pageLayouts default,twocol,fullwidth
 *
 */
component {
	// ...	
}
```

You can also add human readable titles for these layouts at `/i18n/page-layouts.properties`:

```properties
default=Default (single column)
twocol=Two column layout
fullwidth=Full width layout
```

### Defining a default layout

You can define two kinds of default layout in your application's `/config/Config.cfc` file:

1. a general default layout
2. a default layout for site tree pages (if blank, the general default will be used)

These can be set with:

```cfc
// /config/Config.cfc
component extends="preside.system.config.Config" {
	function configure() {
		super.configure( argumentCollection=arguments );

		// ...
		settings.pagelayouts.defaultPageLayout         = "default";
		settings.pageLayouts.defaultSiteTreePageLayout = "siteTreeDefault";

		// ...
	}
}
```

### Rendering layouts in non-sitetree requests

You can directly render a layout from within your handlers and views with:

```cfc
renderPageLayout( body=myBodyContent, layout="nameofLayout" );
```

Use this method to wrap your custom pages in re-usable layouts.

You can also use the pageLayout view by setting the 2 variables `prc.pageLayoutBody` and `prc.pageLayout` and set your view to `general/_pageLayout` to render the view using Page Layout

```cfc
	function detail(event, rc, prc){

		...

		prc.pageLayoutBody = renderView( view="page-types/event/detail/", args=args );

		prc.pageLayout = "eventLayout"

		event.setView( view="/general/_pageLayout" );

	}
```

The `_pageLayout` view consists of a simple wrapper as below

```cfc
<cfoutput>
	#renderPageLayout( body=prc.pageLayoutBody ?: '' , layout=prc.pageLayout ?: '' )#
</cfoutput>
```


# Contributing

Contribution in all forms is very welcome. Use Github to create pull requests for tests, logic, features and documentation. Or, get in touch over at Preside's slack team and we'll be happy to help and chat: [https://presidecms-slack.herokuapp.com/](https://presidecms-slack.herokuapp.com/).