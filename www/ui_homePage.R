### HOMEPAGE -------------------------
homePage <- tabItem(tabName = "home",
  h2("Welcome"),
  h3("This is the homepage of the ",strong("Nano-High Throughput Formulation Screening"),"laboratory."),
  br(), br(),
  h4("Please take a moment to look around. 
    Check out our work, browse the publications, and follow us on social media!
    "),
  h4("Thanks for stopping by."),
  br(), br(),
  fluidRow(
    column(1,
      tags$a(href="https://bsky.app/profile/tlmoore.bsky.social",
        tags$img(src="assets/bluesky.svg",
          title="bluesky",
          target="_blank",
          width="100%",
          tags$caption("Bluesky")
        ),# End image tag
        target="_blank"
      ) # End hyperref tag
    ), # End column
    column(1,
      tags$a(href="https://scholar.google.com/citations?user=l5fRQdoAAAAJ&hl=en",
        tags$img(src="assets/google-scholar.svg",
          title="google_scholar",
          target="_blank",
          width="100%",
          tags$caption("Google Scholar")
        ),# End image tag
        target="_blank"
      ) # End hyperref tag
    ), # End column
    column(1,
      tags$a(href="https://www.linkedin.com/in/thomas-moore-b9444725",
        tags$img(src="assets/linkedin.svg",
          title="linkedin",
          target="_blank",
          width="100%",
          tags$caption("LinkedIn")
        ), # End image tag
        target="_blank"
      ) # End hyperref tag
    ), # End column
#  ), # End fluidRow
#  fluidRow(
    column(1,
      tags$a(href="https://github.com/tlmoore-UniNA",
        tags$img(src="assets/github.svg",
          title="github",
          target="_blank",
          width="100%",
          tags$caption("GitHub")
        ), # End image tag
        target="_blank"
      ) # End hyperref tag
    ), # End column
    column(1,
      tags$a(href="mailto:thomaslee.moore@unina.it",
        tags$img(src="assets/envelope.svg",
          title="email",
          target="_blank",
          width="100%",
          tags$caption("E-mail")
        ), # End image tag
        target="_blank"
      ) # End hyperref tag
    ), # End column
    column(1,
      tags$a(href="https://linktr.ee/tlmooreunina",
        tags$img(src="assets/linktree_tlmooreunina.svg",
          title="linktree",
          target="_blank",
          width="100%",
          tags$caption("Linktree")
        ), # End image tag
        target="_blank"
      ) # End hyperref tag
    ) # End column
  ) # End fluidRow
) # End homepage
