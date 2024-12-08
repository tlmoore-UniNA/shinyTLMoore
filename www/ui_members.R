membersPage <- tabItem(tabName="members", 
  navbarPage("Members",
    tabPanel("Principal Investigator", icon=icon("user"),
      h1("Thomas L. Moore, PhD"),
      fluidRow(
        column(8, 
          p("Dr. Moore completed his Bachelor’s studies in Bioengineering at 
            Clemson University (Clemson, SC, USA) with a focus on 
            biomaterials, and continued in the Bioengineering Department at 
            Clemson in the Nanomedicine lab of Prof. Frank Alexis. After 
            completing his PhD, he joined the BioNanomaterials group of Profs. 
            Alke Fink and Barbara Rothen-Rutishauser at the Adolphe Merkle 
            Institute (Fribourg, Switzerland) as a postdoctoral researcher in 
            2014. There he studied the fundamental interactions between 
            nanomaterials with biological systems (i.e. colloidal stability in 
            complex media, particle-protein interactions, particle-cell 
            interactions under hydrodynamic conditions). In 2018 he was 
            awarded a Marie Skłodowska-Curie MINDED fellowship to study the 
            application of nanomedicines and bioengineering techniques to 
            improve drug delivery across the blood-brain barrier for the 
            treatment of neurodevelopmental diseases, and joined Prof. Paolo 
            Decuzzi’s Laboratory of Nanotechnology for Precision Medicine at 
            the Istituto Italiano di Tecnologia (Genoa, Italy). Since December 
            2023, he has worked as an assistant professor in the Department of 
            Pharmacy at the Università degli Studi di Napoli Federico II 
            (Naples, Italy). He is passionate about studying the interface 
            between biological systems and nanomaterials, and developing 
            nanoparticles to solve problems in the fields of nanomedicine, 
            drug delivery and bioengineering.")
        ), # End column
        column(4,
          img(src="assets/headshot.JPG", width="85%", align="center") #PI photo
        ) # End column
      ) # End fluidRow
    ), # End PI tabPanel
    tabPanel("Current Members", icon=icon("users-line"),
      h1("Current Lab Members")
    ), # End Members tabPanel
    tabPanel("Lab Alumni", icon=icon("user-graduate"),
      h1("Lab Alumni"),
      h2("Undergraduate Students"),
      h3("Claudia Cardarelli"),
      strong("Fall 2024"),br(),
      em("Injectable Hydrogels for the Controlled Release of a New Hydrophilic Drug"),
      hr(),
      # Emanuele Picciuti
      h3("Emanuele Picciuti"),
      strong("Spring 2024"),br(),
      em("The Development of Polymeric Nanoparticles via an Automated Microfluidic Method for the Delivery of Drugs to Solid Tumors")
    ) # End Alumni tabPanel
  ) # End navbarPage
) # End membersPage
