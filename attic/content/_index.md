---
# Leave the homepage title empty to use the site title
title: ''
date: 2023-12-21
type: landing

sections:
  - block: about.biography
    id: about
    content:
      title: Welcome! #Biography
      # Choose a user profile to display (a folder name within `content/authors/`)
      username: admin
  - block: collection
    id: posts
    content:
      title: Posts #Recent Posts
      subtitle: ''
      text: ''
      # Choose how many pages you would like to display (0 = all pages)
      count: 2
      # Filter on criteria
      filters:
        folders:
          - post
        author: ""
        category: ""
        tag: ""
        exclude_featured: false
        exclude_future: false
        exclude_past: false
        publication_type: ""
      # Choose how many pages you would like to offset by
      offset: 0
      # Page order: descending (desc) or ascending (asc) date.
      order: desc
    design:
      # Choose a layout view
      view: compact
      columns: '2'
  - block: portfolio
    id: projects
    content:
      title: Projects
      #subtitle: My subtitle
      #text: Add any **markdown** formatted content here - text, images, videos, galleries - and even HTML code!
      filters:
        # Folders to display content from
        folders:
          - project
        # Only show content with these tags
        tags: []
        # Exclude content with these tags
        exclude_tags: []
        # Which Hugo page kinds to show (https://gohugo.io/templates/section-templates/#page-kinds)
        kinds:
          - page
      # Field to sort by, such as Date or Title
      sort_by: 'Date'
      sort_ascending: false
      # Default portfolio filter button
      # 0 corresponds to the first button below and so on
      # For example, 0 will default to showing all content as the first button below shows content with *any* tag
      default_button_index: 0
      # Filter button toolbar (optional).
      # Add or remove as many buttons as you like.
      # To show all content, set `tag` to "*".
      # To filter by a specific tag, set `tag` to an existing tag name.
      # To remove the button toolbar, delete the entire `buttons` block.
      # buttons:
      #   - name: All
      #     tag: '*'
      #   - name: Deep Learning
      #     tag: Deep Learning
      #   - name: Other
      #     tag: Demo
    design:
      # See Page Builder docs for all section customization options.
      # Choose how many columns the section has. Valid values: '1' or '2'.
      columns: '1'
      # Choose a listing view
      view: showcase
      # For Showcase view, flip alternate rows?
      flip_alt_rows: false
   # - block: collection
   #   id: featured
   #   content:
   #     title: Featured Publications
   #     filters:
   #       folders:
   #         - publication
   #       featured_only: true
   #   design:
   #     columns: '2'
   #     view: card
  - block: collection
    id: publications
    content:
      title: Publications & Preprints #Recent Publications
      count: 3
     # text: |-
     #   {{% callout note %}}
     #    [See here](./publication/) for the full list.
     #   {{% /callout %}}
      filters:
        folders:
          - publication
        exclude_featured: true
    design:
      columns: '2'
      view: compact
  - block: collection
    id: talks
    content:
      title: Selected Talks #Recent & Upcoming Talks
      count: 3
      filters:
        folders:
          - event
    design:
      columns: '2'
      view: compact
  # - block: tag_cloud
  #   content:
  #     title: Popular Topics
  #   design:
  #     columns: '2'
  - block: contact
    id: contact
    content:
      title: Contact
      #subtitle:
      #text: |-
      #  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam mi diam, venenatis ut magna et, vehicula efficitur enim.
      # Contact (add or remove contact options as necessary)
      email: athanasios.giannakopoulos@nottingham.ac.uk
      #phone: 888 888 88 88
      #appointment_url: 'https://calendly.com'
      address:
        street: Mathematical Sciences Building, University Park
        city: Nottingham
        #region: Nottinghamshire
        postcode: 'NG7 2RD '
        country: United Kingdom
        country_code: UK
      #directions: Enter Building 1 and take the stairs to Office 200 on Floor 2
      #office_hours:
      #  - 'Monday 10:00 to 13:00'
      #  - 'Wednesday 09:00 to 10:00'
      # Choose a map provider in `params.yaml` to show a map from these coordinates
      #coordinates:
      #  latitude: '37.4275'
      #  longitude: '-122.1697'  
      contact_links:
        - icon: linkedin
          icon_pack: fab
          name: LinkedIn message
          link: 'https://www.linkedin.com/in/thanasis-giannakopoulos/'
        #- icon: twitter
        #  icon_pack: fab
        #  name: DM Me
        #  link: 'https://twitter.com/Twitter'
        #- icon: skype
        #  icon_pack: fab
        #  name: Skype Me
        #  link: 'skype:echo123?call'
        #- icon: video
        #  icon_pack: fas
        #  name: Zoom Me
        #  link: 'https://zoom.com'
      # Automatically link email and phone or display as text?
      #autolink: true
      # Email form provider
      #form:
      #  provider: netlify
      #  formspree:
      #    id:
      #  netlify:
          # Enable CAPTCHA challenge to reduce spam?
      #    captcha: false
    design:
      columns: '2'
---
