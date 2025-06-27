---
title: "Authoring With Skribe"
teaching: 20
exercises: 15
---



:::::::::::::::::::::::::::::::::::::: questions

- "How can I write content for my webpages?"
- "How do I link to other pages?"

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- "Create simple pages with formatted text"

::::::::::::::::::::::::::::::::::::::::::::::::

# Skribe
Skribe is a language used to enable writing documents
that can be output in a variety of formats include HTML. 
Plain text characters and parenthesis are used in place of HTML tags. 
These characters are then processed by Haunt (or another script or
application) and transformed into HTML.  Skribe separates content
from layout and formatting details which are handled by a program.
Frequently used elements, like headings, paragraphs, lists
and text formatting (i.e. bold, italic) are part of Skribe.
Skribe's simplified syntax keeps content human-readable.  Skribe's
power comes from the ability to use Scheme to automate and customize
the websites you create relieving you of tedious repetitive work.

::::::::::::::::::::::::::::::::::::: challenge

Challenge: Learn more about Skribe

Read through the
[paper](https://www-sop.inria.fr/members/Manuel.Serrano/publi/jfp05/article.html)
introducing Skribe.  Note that some of the annotations used differ from the
Skribe implementation in Haunt.

- What features make Skribe attractive?
- What are some output formats that have been programmed to be generated from
  Skribe?
- What is type checking and why might it be helpful? What drawbacks does type
  checking have?

:::::::::::::::::::::::: solution

- Skribe uses scheme to allow one to create a compact notation that describes
  writer intent for formatting.  Skribe allows one to use code to create
  documents that can be output in multiple formats.
- Skribe documents can be output to HTML, TexInfo and through LaTeX to PDF.
- A [type system](https://en.wikipedia.org/wiki/Type_system) is a way of
  associating a set of properties to variables in a program.  It is similar
  to how units are assigned to physical quantities, for example one might
  measure length in meters and speed in meters per second.  Types allow
  programs to prevent some errors - for example it can be reasonable to add
  two distances, but it is not reasonable to add a distance to a speed.  It
  is however reasonable to calculate a speed knowing distance travelled in a
  certain time.  Type checking can increase the time it takes for a program
  to be compiled and/or run as extra operations are needed to verify the
  rules associated to each type are satisfied.

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

# Where to Start Writing Skribe?

When editing Skribe source code, many editors will help you by
highlighting matching brackets and parenthesis.  You can also
customize text editors you install on your own hardware to
provide additional features, such as highlighting.

As we are working towards authoring websites using Haunt and GitHub pages,
we will use GitHub straight away for learning the basics of Skribe.
The GitHub project you created in contains a file `my-first-post.skr`.

TODO: Add image

Click on that pencil symbol to open an editing interface of your project's
`my-first-post.skr` file. Once we've clicked the pencil symbol, GitHub will
open that file in the editing interface.

TODO: Add image

Let us change the content by modifying `written in Skribe` to
`written in (bold Skribe)`. Examine the rendered view by clicking the
_Preview changes_ tab.

TODO: Add image

GitHub shows green vertical bars visually highlighting the
new content. To save the content to the file `my-first-post.skr`,
search for a _Commit changes_ button.
After having changed something, the commit menu looks like this:

TODO: Add image

:::::::::::::: callout

## Writing a Commit Message

A commit message is a short, descriptive, and specific comment that
will help us remember later on what we did and why. When editing in
the Github interface, it will suggest a vague message about which file
you've updated or added. It is best practice to change this message to
a short but more informative message about what in the file has changed.
This more descriptive message will make it much easier if future you
needs to go looking through the history for which commit made a specific change.
You can find more about writing commit message in
[the Software Carpentry _Version Control with Git_ lesson](https://swcarpentry.github.io/git-novice/04-changes/index.html).

::::::::::::::::::::::

Commit this change to the `main` branch, wait for the website to rebuild
then view the website.

TODO: add image of update post

# Writing Skribe

Now that we know about the editing interface and preview tab of our projects
`my-first-post.skr` we can use it as a text editor and investigate selected
Skribe features.

Our `my-first-post.skr` already contains vanilla text and
three formatting features:
- Heading `(h1 [My first post!])`
- Paragraph `(p [This is a static website and blog.])`
- Emphasis using `(bold Skribe)`.

Additionally it shows how to evaluate a scheme expression:
- `(+ 1 2 3 4 5)

Let's learn some more Skribe by adding some formatting and 
see what happens when we rebuild the website.
Add the following to your `my-first-post.skr` file.

```scheme
(post
 :title "My first post!"
 :date (make-date* 2025 06 21 09 00)
 :tags '("Skribe" "scheme" "program")

(h1 [My first post!])

(p [This is a ,(em static) website and blog.])

(p [It forms the basis of a ,(anchor "Carpentries" "https://carpentries.org/") lesson.])

(p [Some established Carpentries lesson programs are:
 ,(ol
   (li Software Carpentry)
   (li Data Carpentry)
   (li Library Carpentry))])

(p [The source is written in (bold Skribe), a
    document format that allows you to use
    embed scheme programs to create your
    document.])

(p [1 + 2 + 3 + 4 + 5 = ]
   (+ 1 2 3 4 5)))
```

If you click the `preview` button, GitHub will show a preview
of differences, the green bar indicates added lines, and the
red bar indicates deleted lines.

TODO: Add image

You can then commit changes, wait for the site to build
and then check how your new changes appear online.

TODO: Add image

:::::::::::::: callout

## Line breaks

All text has so far been grouped into either a header, a list
or a paragraph.  The output has linebreaks automatically
inserted. This allows for a variety of output formats where
the layout is determined according to the context and linebreaks
are automatically inserted appropriately.


::::::::::::::::::::::


Let's do an exercise to try out writing more Skribe.


::::::::::::::::::::::::::::::::::::: challenge

## Challenge: Try Out Skribe
Read through the Haunt
[Skribe implementation](https://git.dthompson.us/haunt/tree/haunt/skribe/utils.scm)
to add the following to your `my-first-post.skr`:

- A second level heading
- Some text under that second level heading that includes a link and <b>bold</b> text.
- A third level heading
- A numbered list
- Bonus: Add this image <https://raw.githubusercontent.com/carpentries/carpentries.org/main/images/TheCarpentries-opengraph.png>

:::::::::::::::::::::::: solution

## Example Solution
For example your might add the following:

```scheme
(h2 [More about Skribe])

(p [You can find this lesson ,(anchor "here" "https://bkmgit.github.io/haunt-intro").]

(h3 [Four reasons you should learn Skribe:])

(ol
 (li [Less formatting than HTML])
 (li [Easy to read even with formatting])
 (li [Powerful programming environment])
 (li [Allows you to ,(em [automate]) the ,(bold [boring]) stuff.]))

(image "/images/thecarpentries-opengraph.png"))
```

Where the image file is obtained from 
https://github.com/carpentries/carpentries.org/blob/main/static/thecarpentries-opengraph.png
and placed in the images folder


TODO: Add image of generated site

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::: callout

## Reference-Style Links

Up to now, we have used _inline-style_ links which have the URL inline with the description text, for example:

```scheme
,(anchor "Carpentries" "https://carpentries.org/")
```

If you use a link more than once, consider using so called _reference-style_ links instead.
Reference-style links reference the URL via a label.  In Haunt, we can write a module
to accomplish this.  Create a file `links.scm` and within it add

```scheme
(define-module (links)
  #:use-module (haunt skribe utils)
  #:export (%carpentries))

(define (%carpentries)
  (anchor "The Carpentries" "https://carpentries.org"))
```

Then modify `posts/my-first-post.skr` to contain

```scheme
(add-to-load-path "../")
(use-modules (links))

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
   (+ 1 2 3 4 5))

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

This follows the [DRY principle][dry-principle], avoiding redundant
specification of information.

::::::::::::::::::::::


:::::::::::::: callout

## Note about image use and attribution
When using images on your website that you don't own, it's important to reuse
the  content responsibly. This means ensuring that the image owner has given
permission for the image to be reused and that the image includes appropriate
attribution to the owner. If you're unsure about the availability of an image
you can always contact the owner or check if a license is provided alongside
the image which may include conditions for reuse. Anyone can re-use and edit
Public Domain images so searching for images in the public domain can be a good
way to find images for your website.  However, it is still good practice to
give credit when possible, even for public domain images.

::::::::::::::::::::::


We will continue to use Skribe and learn more throughout the rest of the lesson.


:::::::::::::: callout

## A note on documents created by Skribe

The basic building blocks used to create a Skribe document are the
same, but because of its extensibility, you will need to read through
the code to determine what new functionality has been added to material
created using Skribe. Do not expect to be able to copy and paste material
from one Skribe document to another without understanding it and modifying
it for your needs.

::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::: challenge

## Optional Exercise: Examine other Haunt sites

- The [Bootstrapable builds site](http://bootstrappable.org/) is created using
Haunt and uses Skribe for its posts. Examine the
[source](https://codeberg.org/guix/bootstrappable).
- The [ActivityPub site](https://activitypub.rocks) is created using Haunt
and uses Skribe for its posts. Examine the
[source](https://gitlab.com/dustyweb/activitypub.rocks).
- [Karl Hallsby's blog](https://karl.hallsby.com/) is created using Haunt and
uses [SXML](https://okmij.org/ftp/Scheme/SXML.html) for its posts.
Examine the [source](https://cgit.karl.hallsby.com/website.git/tree/).
A brief description of SXML is also available on
[wikipedia](https://en.wikipedia.org/wiki/SXML).

How do SXML and Skribe differ?

:::::::::::::::::::::::: solution

SXML is a markup language that faciliates using scheme to work with
XML documents.  Skribe is a document as a program.  Both Skribe and
SXML can be converted to XML, to take advantage of the powerful
query, validation and transformation tools available for XML.

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::: callout

## More Skribe Features
Check out our [Extras page on Skribe](../more_skribe/index.html) for a more
comprehensive overview of Skribe, including how to create fenced code blocks,
do syntax highlighting for various languages and typeset academic papers. Do
also examine the discussion on Skribe as used in
[Skribilo](https://www.nongnu.org/skribilo),
which more closely follows the original Skribe specification documented in the
[Skribe manual](https://www-sop.inria.fr/mimosa/fp/Skribe/doc/user.html#Skribe-User-Manual).

::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::: keypoints

- "Skribe is a powerful and relatively easy way to write formatted text"
- "Skribe allows a single source to be output to a variety of formats, including html and pdf"

::::::::::::::::::::::::::::::::::::::::::::::::
