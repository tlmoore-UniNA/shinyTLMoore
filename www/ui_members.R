membersPage <- tabItem(tabName="members", 
  navbarPage("Members",
    tabPanel("Principal Investigator", icon=icon("user"),
      h1("Thomas L. Moore, PhD"),
      fluidRow(
        column(9, 
          h4("Dr. Moore completed his Bachelor’s studies in Bioengineering at 
            Clemson University (Clemson, SC, USA) with a focus on 
            biomaterials, and continued in the Bioengineering Department at 
            Clemson in the Nanomedicine lab of Prof. Frank Alexis. His thesis, 
            titled", em("Theranostic nanoparticles for the treatment of 
            cancer.")),
          h4("After completing his PhD, he joined the BioNanomaterials group 
            of Profs. Alke Fink and Barbara Rothen-Rutishauser at the Adolphe 
            Merkle Institute (Fribourg, Switzerland) as a postdoctoral 
            researcher in 2014. There he studied the fundamental interactions 
            between nanomaterials with biological systems (i.e. colloidal 
            stability in complex media, particle-protein interactions, 
            particle-cell interactions under hydrodynamic conditions)."),
          h4("In 2018 he was awarded a Marie Skłodowska-Curie MINDED 
            fellowship to study the application of nanomedicines and 
            bioengineering techniques to improve drug delivery across the 
            blood-brain barrier 
            for the treatment of neurodevelopmental diseases, and joined Prof. 
            Paolo Decuzzi’s Laboratory of Nanotechnology for Precision 
            Medicine at the Istituto Italiano di Tecnologia (Genoa, Italy). 
            Since December 2023, he has worked as an assistant professor in 
            the Department of Pharmacy at the Università degli Studi di Napoli 
            Federico II (Naples, Italy). He is passionate about studying the 
            interface between biological systems and nanomaterials, and 
            developing nanoparticles to solve problems in the fields of 
            nanomedicine, drug delivery and bioengineering.")
        ), # End column
        column(3,
          img(src="assets/headshot.JPG", width="95%", align="center"),#PI photo
          br(), br(),
          downloadButton("downloadCV", "Download CV")
        ) # End column
      ), # End fluidRow
			fluidRow(
				column(3, 
					
				) # End column
			) # End fluidRow
    ), # End PI tabPanel
    tabPanel("Current Members", icon=icon("users-line"),
      h1("Current Lab Members"),
			# SIMONE MISTO -----------
			h2("Simone Misto"),
			fluidRow(
				column(3, 
					img(src="assets/smisto2.png", width="85%", align="center") # Simone photo
				), # End column
				column(9,
					h4("Simone Misto earned his Bachelor's degree in Chemistry in 2021 
            from the Department of Chemistry at the Università degli Studi di 
            Napoli Federico II (Naples, Italy), where he conducted research in 
            the Macromolecular Chemistry Laboratory under the supervision of 
            Prof. Claudio De Rosa. His work focused on the characterization of 
            the structure and properties of polymeric materials synthesized 
            using organometallic catalysts. In 2023, he completed his Master's 
            degree in Chemical Sciences at the same department, conducting 
            research on the vibrational dynamics of complex molecular systems 
            under the guidance of Prof. Nadia Rega in the Computational 
            Chemistry Laboratory."),
          h4("In 2024, he obtained his professional qualification as a chemist 
            and, in the same year, completed an advanced training program, the 
            Pharmatech Academy, within the Scampia complex of Università degli 
            Studi di Napoli Federico II, designed to prepare highly skilled 
            professionals in the research and development of RNA-based drugs 
            and gene therapies."),
          h4("Since 2024, he has been pursuing a PhD in", 
            em("RNA Therapeutics and Gene Therapy"), "in the research 
            laboratory of Prof. Thomas Lee Moore in the Department of 
            Pharmacy, Università degli Studi di Napoli Federico II. His 
            research focuses on the formulation and characterization of 
            nanoparticles, utilizing microfluidic technologies to develop 
            lipid nanoparticles for the targeted delivery of RNA-based 
            therapeutics. His primary goal is to contribute to the advancement 
            of RNA-based therapies by pioneering innovative nanotechnological 
            approaches, thereby improving treatment strategies for genetic and 
            neurodegenerative diseases and driving progress in pharmaceutical 
            biotechnology.")
				) # End column
			) # End fluidRow
    ), # End Members tabPanel
    tabPanel("Lab Alumni", icon=icon("user-graduate"),
      h1("Lab Alumni"),
      h2("Undergraduate Students"),
      h3(strong("Claudia Cardarelli")),
      h4("Fall 2024"),
      h4(em("Injectable Hydrogels for the Controlled Release of a New Hydrophilic Drug")),
      hr(),
      # Emanuele Picciuti
      h3(strong("Emanuele Picciuti")),
      h4("Spring 2024"),
      h4(em("The Development of Polymeric Nanoparticles via an Automated Microfluidic Method for the Delivery of Drugs to Solid Tumors"))
    ) # End Alumni tabPanel
  ) # End navbarPage
) # End membersPage
