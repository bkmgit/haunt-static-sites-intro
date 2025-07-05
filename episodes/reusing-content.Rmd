---
title: "Reusing Blocks of Content"
teaching: 35
exercises: 40
---


:::::::::::::::::::::::::::::::::::::: questions

- "How can I reuse the same chunks of material in multiple pages?"

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- "Create reusable blocks of content and insert them into pages"

::::::::::::::::::::::::::::::::::::::::::::::::


In the previous episode, we discussed the benefits of creating a file with
commonly use links to enable us to reuse these throughout our pages.
However, repeated use of content in and across websites is usually not limited
to individual values such as website links.

::::::::::::::::::::::::::::::::::::: challenge

## Challenge: What Gets Reused?

Look at the three pages linked below, and browse some other pages on the same
site.

* [Bootstrappable Builds][bootstrappable-builds]
* [Karl Halsby][karl-halsby]
* [g0v.tw][g0v-dot-tw]

1. What content is being reused between pages on these sites?
2. Pair up and compare your partner's notes with your own.
3. Can you identify any common type(s) of content that is being reused in these
   sites?


:::::::::::::::::::::::: solution

## Solution

The Bootstrappable Builds website reuses many structural elements, such as the
**page header** (containing the menu and the logo) and **footer** (containing
licensing information, links to contact the maintainers and the source code).

Karl Halsby's site has the same kind of shared header and footer
on each page: this is a common theme across most websites,
helping to improve navigation and other aspects of the user experience
and achieve consistent "branding" across the whole site.

g0v.tw has shared headers and footers, although the main landing page
does not have the sharedheader. The site is available in three
languages and images are reused between the translated pages.  Not
all pages are translated though.

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

The most commonly reused content is structural: menus and branding information
used to present a consistent and recognisable interface to the user regardless
of which specific page of the site they're visiting.
We'll look more at that in the next episode.
But some content, such as contact statements and post/product listings,
can be reused in the body of pages.
The motivation for reusing content like this is that,
if you need to update that content - changing the contact address,
updating a price or picture associated with a listing, and so on -
you need only change this information in one place
for the update to be propagated across the whole site.
This is related to the __DRY__ (Don't Repeat Yourself) principle of
good practice in programming.

:::::::::::::: callout

## __DRY__ (Don't Repeat Yourself) Principle       
[DRY principle](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) 
is one of the basic principles of software development aimed at reducing repetition of information. 

::::::::::::::::::::::


Two of the three sites linked in the previous exercise are built with Haunt.
But the principles behind reusing content apply regardless of the particular
framework being used to build the site.

## Reusing Site Footer

Let's look at an example of how we can create a block of common content and
reuse it in multiple pages on our site. Websites typically have some text and
links at the bottom of each page to help visitors with links to privacy
information, site source code and site licensing information. To make these
links appear above every page on our site, we could add the same code at the
end of each skribe file in our repository.  But if we wanted to modify this
information, we would need to make the same adjustment on every page.  This
is both time-consuming and error-prone:  it would be easy to accidentally
mistype a link or forget to update one of the files.  Instead, we can go
some way to avoid this hassle by using some magic that Haunt provides:
`programmability`.

To demonstrate this, we will modify the `haunt.scm` file to add a footer to
each page.

```scheme
(use-modules (haunt asset)
             (haunt builder blog)
             (haunt builder atom)
             (haunt builder assets)
	    (haunt builder flat-pages)
             (haunt builder redirects)
             (haunt builder rss)
	    (haunt html)
	    (haunt page)
	    (haunt post)
	    (haunt reader)
             (haunt reader skribe)
             (haunt reader texinfo)
             (haunt reader commonmark)
             (haunt site)
	    (srfi srfi-19))

(define footer
  `(footer
    (p "Made with "
       (a (@ (href "https://dthompson.us/projects/haunt.html"))
	 "Haunt")
       ".")
    (p "Subscribe to "
       (a (@ (href "/feed.xml")) "atom")
       " or "
       (a (@ (href "/rss-feed.xml")) "rss")
       " feeds.")))

(define demo-theme
  (theme #:name "demo-theme"
	#:layout
	(lambda (site title body)
	  `((doctype "html")
		     (head
		      (meta (@ (http-equiv "Content-Type") (content "text/html; charset=UTF-8")))
		      (meta (@ (http-equiv "Content-Language") (content "en")))
		      (meta (@ (name "viewport") (content "width=device-width")))
		      (title ,(string-append title " - " (site-title site)))
		      (link (@ (rel "alternate")
				(type "application/atom+xml")
				(title "Atom feed")
				(href "/feed.xml"))))
		     (body (@ (id "page"))
			   (div (@ (id "content"))
				,body))
		     ,footer))
	#:post-template
	(lambda (post)
	  `((article
	     (h1 (@ (id "title")) ,(post-ref post 'title))
	     (div (@ (id "date")) ,(date->string (post-date post) "~B ~d, ~Y"))
	     (div (@ (id "post")) ,(post-sxml post)))))
	#:collection-template
	(lambda (site title posts prefix)
	  (define (post-uri post)
	    (string-append prefix "/" (site-post-slug site post) ".html"))
	  `((h1 ,title)
	    (p (ul (@ (id "posts"))
		   ,@(map (lambda (post)
			    `(li
			      (a (@ (href ,(post-uri post)))
				 ,(post-ref post 'title))))
			  posts)))))))
   
(site #:title "Built with Haunt, a Scheme Static Site generator"
      #:domain "bkmgit.github.io"
      #:build-directory "docs"
      #:default-metadata
      '((author . "A.N. Other")
        (email  . "ano@contact.me"))
      #:readers (list commonmark-reader texinfo-reader skribe-reader sxml-reader html-reader)
      #:builders (list (blog #:theme demo-theme)
                       (atom-feed)
                       (atom-feeds-by-tag)
                       (rss-feed)
                       (static-directory "images")))
```

Commit your changes and once the site has built preview it.  Notice that the landing page
is fine, but the linked blog post has the title twice.  To fix this, modify the
blog post file so that the title is not in the top of the blog post, but is instead
inserted by the template from the metadata.

```scheme
(add-to-load-path "../")
(use-modules (links))

(post
 :title "My first post!"
 :date (make-date* 2025 06 21 09 00)
 :tags '("Skribe" "scheme" "program")

(p [This is a static website and blog.])

(p [The source is written in Skribe, a
    document format that allows you to use
    embed scheme programs to create your
    document.])

(p [1 + 2 + 3 = ]
   (+ 1 2 3))

(h2 [More about Skribe])

(p [You can find this lesson ,(anchor "here" "https://bkmgit.github.io/haunt-intro").])

(h3 [Four reasons you should learn Skribe:])

(ol
 (li [Less formatting than HTML])
 (li [Easy to read even with formatting])
 (li [Powerful programming environment])
 (li [Allows you to ,(em [automate]) the ,(strong [boring]) stuff.]))

(p [To find out more about the Carpentries, go to the ,(%carpentries)  website.])
  
(image "/images/thecarpentries-opengraph.png"))
```

Commit your changes, wait for the site to build and then refresh the page where the
blog post is rendered.  There shoul now only be one title.

TODO: Add image


::::::::::::::::::::::::::::::::::::: challenge

## Challenge: Add content licensing information

The repository has a license for the code used to generate it, but not for the content.
[Creative commons](https://creativecommons.org/) has a list of licenses for sharing content.
They have a [guide](https://creativecommons.org/share-your-work/) to enable you to choose an
appropriate license to share your work. Follow the
[guide](https://creativecommons.org/share-your-work/) to choose a license and add it to your
footer.

You might also consider using a creative commons license specific to your country or
available in the language of your blog. A list of Creative Commons affiliates is available
on the
[Creative Commons wiki](https://wiki.creativecommons.org/wiki/Category:CC_Affiliate_Locale),
check if a more suitable license is available for your content. 

:::::::::::::::::::::::: solution


Modify the footer section in `haunt.scm` so that it is now:
 
```scheme

(define footer
  `(footer
    (p "Made with "
       (a (@ (href "https://dthompson.us/projects/haunt.html"))
          "Haunt")
       ".")
    (p "Content available under "
       (a (@ (href "https://creativecommons.org/licenses/by-sa/4.0/"))
          "Creative Commons Attribution-ShareAlike 4.0 International")
       " License.")
    (p "Subscribe to "
       (a (@ (href "/feed.xml")) "atom")
       " or "
       (a (@ (href "/rss-feed.xml")) "rss")
       " feeds.")))
```

TODO: Add image

:::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::


This is another example of how we can create a block of common content and reuse it in multiple
pages on our site.


::::::::::::::::::::::::::::::::::::: keypoints 

- "Programming is like a bicycle for the mind, it can increase our efficiency"
- "Choose licensing information for your content appropriately"

::::::::::::::::::::::::::::::::::::::::::::::::
