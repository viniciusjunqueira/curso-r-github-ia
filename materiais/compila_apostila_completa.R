setwd('/Users/viniciusjunqueira/Library/CloudStorage/OneDrive-Pessoal/Cursos/curso-r-github-ia/materiais')

bookdown::render_book("index.Rmd", "bookdown::pdf_book")

# Para formato GitBook (recomendado para web)
bookdown::render_book("index.Rmd", "bookdown::gitbook")

setwd('/Users/viniciusjunqueira/Library/CloudStorage/OneDrive-Pessoal/Cursos/curso-r-github-ia')
system('sh copy_html.sh')
