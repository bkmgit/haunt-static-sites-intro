---
title: "Starting With Haunt"
teaching: 20
exercises: 10
---

:::::::::::::::::::::::::::::::::::::: questions

- "How can I create a static website with Haunt?"
- "How can I configure values/settings for my site?"

::::::::::::::::::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::: objectives

- "Substitute variable values into page content"
- "Adjust the configuration of the site and individual pages"

::::::::::::::::::::::::::::::::::::::::::::::::


[Haunt](https://dthompson.us/projects/haunt.html) is a powerful static site
generator. It creates static HTML website content out of various files in
your repository (Skribe files, Markdown files, CSS style sheets, layouts, etc.).
This 'compiled' content can then be served as your website via the `github.io`
Web domain (remember your website's URL from the previous episode?). Your
GitHub repository can be configured to re-generate all the HTML pages for your
website each time you make a change in it.

Haunt makes managing your website easier because it depends on templates.
Templates are blueprints that can be reused by multiple pages.
For example, instead of repeating the same navigation markup on every page you
create (such a header, a footer or a top navigation bar), you can create a
layout that gets used on all the pages.  Otherwise, each time you update a
navigation item - you'd have to make edits on every page.  We will cover
templates and layouts in a bit; for now let's start learning Haunt and its
scripting language called [Scheme](https://www.scheme.org/).

## A first site

To create a Haunt site, fork the repository https://github.com/bkmgit/haunt-site
and give it the name https://github.com/my-username.github.io Be sure to copy
all branches of the repository.

Then go to settings, and choose to serve the site from the `gh-pages` branch and
from the `root` folder.

The website should be rebuilt whenever there are changes to the repository. 
GitHub has a service called
[GitHub Actions](https://docs.github.com/en/actions).  On the settings page,
expand the `Actions` submenu and choose the `General` page. Ensure that
- **Allow all actions and reusable workflows**
- **Require approval for first-time contributors**
= **Read and write permissions**
are selected. The save your settings. For more on GitHub Actions settings, see
the
[documentation](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository).

### Global Configuration
Haunt's main configuration options are specified in a `haunt.scm` file, which
is written in called [Scheme](https://www.scheme.org/) and placed in your
site’s root directory.

The initial global configuration contains

```scheme
(use-modules (haunt asset)
             (haunt page)
             (haunt builder blog)
             (haunt builder atom)
             (haunt builder assets)
	     (haunt builder flat-pages)
             (haunt builder redirects)
             (haunt builder rss)
	     (haunt reader)
             (haunt reader skribe)
             (haunt reader texinfo)
             (haunt reader commonmark)
             (haunt site))

(site #:title "Built with Haunt, a Scheme Static Site generator"
      #:domain "bkmgit.github.io"
      #:build-directory "docs"
      #:default-metadata
      '((author . "A.N. Other")
        (email  . "ano@contact.me"))
      #:readers (list commonmark-reader texinfo-reader skribe-reader sxml-reader html-reader)
      #:builders (list (blog)
                       (atom-feed)
                       (atom-feeds-by-tag)
                       (rss-feed)
                       (static-directory "images")))
```


Let's modify the parameters for our website.

1. From the GitHub interface, click on the `haunt.scm` file in your site’s
   root directory.
2. Click on the pencil icon to edit the `haunt.scm` file.
3. Update the author to `your name` and domain to `myusername.github.io`
4. Optionally update the email or remove it if you do not wish to share your
   email address.
5. Commit your changes.


## A first change

Go to the code section of the repository, then view the `posts` folder and
click on `my-first-post.skr` which should contain

```scheme
(post
 :title "My first post!"
 :date (make-date* 2025 06 21 09 00)
 :tags '("Skribe" "scheme" "program")

(h1 [My first post!])

(p [This is a static website and blog.])

(p [The source is written in Skribe, a
    document format that allows you to use
    embed scheme programs to create your
    document.])

(p [1 + 2 + 3 + 4 + 5 = ]
   (+ 1 2 3 4 5)))
```

The post contains some metadata including the title and date as well as
tags to be used to indicate the topics of interest.  It is written in
Skribe.  Text is enclosed in square brackets `[]` and code and
annotations are enclosed in parenthesis `()`.  The tag `h1` indicates
a first level heading and the tag `p` indicates a paragraph.

The third paragraph is unusual, there is a string
`[1 + 2 + 3 + 4 + 5 =]` in square brackets followed by an expression
`(+ 1 2 3 4 5)` in parenthesis.  The expression is evaluated when
generating the website.

Go to your website which should be avilable at https://my-username.github.io
there should be a page with a link to your first blog post. Click on the
link to open the first blog post.  The last line should have
`1 + 2 + 3 + 4 + 5 = 14`.


::::::::::::::::::::::::::::::::::::: challenge

## Challenge: Modify the expression to be evaluated

In `my-first-post.skr` modify

```scheme
(p [1 + 2 + 3 + 4 + 5 = ]
   (+ 1 2 3 4 5)))
```

to add numbers from 1 to 7. Commit your changes,
then wait for the site to be regenerated.  Confirm
that the correct sum is shown.


:::::::::::::::::::::::: solution

1. Modify the last section of `my-first-post.skr` to contain

```scheme
(p [1 + 2 + 3 + 4 + 5 + 6 + 7= ]
   (+ 1 2 3 4 5 6 7)))
```

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

## When Things Go Wrong

So far we have seen how to successfully use Haunt to produce a website.
There are however some situations where Haunt may fail to do so
either due to a typo or missing information.


::::::::::::::::::::::::::::::::::::: challenge

## Challenge: Troubleshooting Haunt

This exercise will help you recognise what common mistakes look like
when working with these elements of a Haunt website.

Edit your `haunt.scm` file and omit a closing parenthesis `)` in one of
the lists.


:::::::::::::::::::::::: solution


For instance, a missing closing parenthesis `)` after blog in the site
section.

```scheme
(use-modules (haunt asset)
             (haunt page)
             (haunt builder blog)
             (haunt builder atom)
             (haunt builder assets)
	     (haunt builder flat-pages)
             (haunt builder redirects)
             (haunt builder rss)
	     (haunt reader)
             (haunt reader skribe)
             (haunt reader texinfo)
             (haunt reader commonmark)
             (haunt site))

(site #:title "Built with Haunt, a Scheme Static Site generator"
      #:domain "bkmgit.github.io"
      #:build-directory "docs"
      #:default-metadata
      '((author . "A.N. Other")
        (email  . "ano@contact.me"))
      #:readers (list commonmark-reader texinfo-reader skribe-reader sxml-reader html-reader)
      #:builders (list (blog
                       (atom-feed)
                       (atom-feeds-by-tag)
                       (rss-feed)
                       (static-directory "images")))
```

Haunt will refuse to build the website and produce an error message.

We will see after this where to find the error message and identify what caused them.

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

If you were keeping an eye on the GitHub repository page until now, you may have noticed
a yellow circle visible when the website is still being processed and a green check mark (✓) when successful.
You may have also noticed that in the same location there is now a red cross/X next to the commit message (❌). 
This indicates that something went wrong with the Haunt build process after that commit.

![Jekyll pending/successful/failed builds after different commits](fig/jekyll_fail_pending_successful.png)

You may also find an email from GitHub in your inbox with details about the error.
But let's look at our repository again.
If we click the red cross/X next to the commit message (❌) a little pop-up will appear with additional information.

![Jekyll - a failed build](fig/jekyll_build_error.png)

Visiting the page behind the **Details** link will give us the information we were missing.

![Jekyll - error details of a failed build](fig/jekyll_build_error_detail.png)

The build should contain output with some content similar to
```output
ice-9/read.scm:126:4: In procedure lp:
haunt.scm:27:1: unexpected end of input while searching for: )
```

From this page we can see that what caused the failure affected the `haunt.scm` file,
and we should check for a missing parenthesis.  Since this typo prevents Haunt from
building the page, the process cannot continue.


:::::::::::::: callout

## Failure Will Not Remove Your Website

Given the failure you may be wondering what happened to the website?
If you visit the address you will find that the website is still be available.

GitHub will keep your previous version online until the error is fixed
and a new build is completed successfully.

::::::::::::::::::::::

Lets go ahead and fix your intentional typo and re-add the missing `)`:

```scheme
(use-modules (haunt asset)
             (haunt page)
             (haunt builder blog)
             (haunt builder atom)
             (haunt builder assets)
	     (haunt builder flat-pages)
             (haunt builder redirects)
             (haunt builder rss)
	     (haunt reader)
             (haunt reader skribe)
             (haunt reader texinfo)
             (haunt reader commonmark)
             (haunt site))

(site #:title "Built with Haunt, a Scheme Static Site generator"
      #:domain "bkmgit.github.io"
      #:build-directory "docs"
      #:default-metadata
      '((author . "A.N. Other")
        (email  . "ano@contact.me"))
      #:readers (list commonmark-reader texinfo-reader skribe-reader sxml-reader html-reader)
      #:builders (list (blog)
                       (atom-feed)
                       (atom-feeds-by-tag)
                       (rss-feed)
                       (static-directory "images")))
```

After a few seconds we should see a green checkmark again and our website will be updated.


::::::::::::::::::::::::::::::::::::: challenge

## Challenge: Practice With Troubleshooting

Sometimes typos happen and can make your website change in surprising ways.
Let's experiment with some possible issues that might come up and see what
happens.

Try the changes listed below on your `my-first-post.skr` file and see what
happens when you try to build the site. You will want to correct the previous
mistake each time.
1. Remove an opening square bracket `[`.
2. Remove a closing square bracket `]`.
3. Change `:tags '(` to `:tags (`.
4. Change `:date` to `date`.
5. Change `(p [The source ` to `( [The source `.


:::::::::::::::::::::::: solution

1. The site refuses to build and the build logs have an error message.

```output
ERROR: In procedure %resolve-variable:
Unbound variable: #{\x5d;}#
```

2. The site builds, butwhen viewed in a browser a section is extended.
   Example generated html is below.

```html
<!DOCTYPE html><head><meta charset="utf-8" /><title>My first post! — Built with Haunt, a Scheme Static Site generator</title></head><body><h1>Built with Haunt, a Scheme Static Site generator</h1><h2>My first post!</h2><h3>by A.N. Other — Sat 21 June 2025</h3><div><h1>My first post!)

(p [This is a static website and blog.</h1><p>The source is written in Skribe, a
    document format that allows you to use
    embed scheme programs to create your
    document.</p><p>1 + 2 + 3 = 6</p></div></body>
```

3. The site refuses to build with the output message

```output
ice-9/eval.scm:217:33: In procedure lp:
Wrong type to apply: "Skribe"
```

4. When the colon before `date` is removed the site refuses to build with the
   error message:

```output
ERROR: In procedure %resolve-variable:
Unbound variable: date
```

5. When the `p` annotation is removed the site refuses to build with the
   error message:

```output
ice-9/eval.scm:217:33: In procedure lp:
Wrong type to apply: ("The source is written in Skribe, a\n    document format that allows you to use\n    embed scheme programs to create your\n    document.")
```

:::::::::::::::::::::::::::::::::

Note: Be sure to fix any errors you intentionally introduced in your page before moving on.

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: keypoints 

- "Sites can be built by GitHub using GitHub Actions"
- "Site build configuration is done in `haunt.scm`"
- "Errors can happen but Haunt will often tell us something is wrong"

::::::::::::::::::::::::::::::::::::::::::::::::
