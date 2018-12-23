options(shiny.maxRequestSize=30*1024^2)
shinyServer(function(input, output) {
 #output$txt <- renderText(readLines("./hindi.txt", encoding = "UTF-8"))
 
 output$plot <- renderPlot({
   if(is.null(input$txtFile) || is.null(input$modelFile)){
     return(NULL)
   } else {
     textData = readLines(file(input$txtFile$datapath), encoding = "UTF-8")
     textData  =  str_replace_all(textData, "<.*?>", "") 
     model = udpipe_load_model(input$modelFile$datapath)  
     
     x <- udpipe_annotate(model, x = textData) #%>% as.data.frame() %>% head()
     x <- as.data.frame(x)
     #chckVal <- input$checkbox
     #strsplit(chckVal, " ")
     #test <- subset(x, upos %in% strsplit(chckVal, " "))
     #print(test)
     
    #print(chckVal)
    #print(c("NOUN", "ADJ"))
    #print(typeof(chckVal))
    #print(typeof(c("NOUN", "ADJ")))
    #print(gsub("  ", " ", chckVal))
    
     nokia_cooc <- cooccurrence(     # try `?cooccurrence` for parm options
       x = subset(x, upos %in% c("NOUN", "ADJ")), 
       term = "lemma", 
       group = c("doc_id", "paragraph_id", "sentence_id"))  # 0.02 secs
     # str(nokia_cooc)
     wordnetwork <- head(nokia_cooc, 50)
     wordnetwork <- igraph::graph_from_data_frame(wordnetwork) # needs edgelist in first 2 colms.
     
     ggraph(wordnetwork, layout = "fr") +  
       geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "orange") +  
       geom_node_text(aes(label = name), col = "darkgreen", size = 4) +
       theme_graph(base_family = "Arial Narrow") +  
       theme(legend.position = "none") +
       labs(title = "Cooccurrences within 3 words distance", subtitle = input$checkbox)
     
   }
 })
 
 output$wcloud <- renderPlot({
   if(is.null(input$txtFile) || is.null(input$modelFile)){
     return(NULL)
   } else {
     textData = readLines(file(input$txtFile$datapath), encoding = "UTF-8")
     textData  =  str_replace_all(textData, "<.*?>", "") 
     model = udpipe_load_model(input$modelFile$datapath)  
     
     x <- udpipe_annotate(model, x = textData) #%>% as.data.frame() %>% head()
     x <- as.data.frame(x)
   all_nouns = x %>% subset(., upos %in% "NOUN"); all_nouns$token[1:20]
   
   top_nouns = txt_freq(all_nouns$lemma)
   head(top_nouns$key, 20) 
   
   all_verbs = x %>% subset(., upos %in% "VERB") 
   top_verbs = txt_freq(all_verbs$lemma)
   head(top_verbs$key, 20)
   
   
   wordcloud(words = top_nouns$key, 
             freq = top_nouns$freq, 
             min.freq = 2, 
             max.words = 100,
             random.order = FALSE,
             scale=c(4,2),
             colors = brewer.pal(8, "Dark2"),
            main="Title")
   }
 }, height = 800, width = 1200 )
})