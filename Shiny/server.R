shinyServer(function(input,output){
##############################sidebar#######################################
    output$selectstate<-renderUI({
        selectInput("state","Choose a State:",
                    sort(data[,"state"]),"state")
    })
    output$selectcity<-renderUI({
        selectInput("city","Choose a City:",
                    sort(data[which(data[,"state"]==input$state),"city"]))
    })
    output$selectname<-renderUI({
        selectInput("name","Choose Business Name:",
                    sort(data[which(data[,"city"]==input$city & data[,"state"]==input$state),"name"]))
    })
    output$selectid<-renderUI({
        selectInput("nameid","Choose Business ID:",
                    sort(data[which(data[,"city"]==input$city & data[,"name"]==input$name & data[,"state"]==input$state),"business_id"]))
    })
    
#################################info########################################
    id <- eventReactive(input$submit,{
        if( input$inputway == "bid" & input$id %in% as.character(data[,"business_id"]))
            return( input$id )
        else if( input$inputway == "bname" & is.na(input$nameid)==0)
            return( input$nameid )
        else
            return( 0 )
    })
    output$nametitle <- renderText({data[data[,"business_id"]==id(),"name"]})
    output$genre<-renderText({data[data[,"business_id"]==id(),"categories"]})
    output$reviewcount<-renderText({paste(data[data[,"business_id"]==id(),"review_count"],"reviews")})
    output$address<-renderText({
        paste(data[data[,"business_id"]==id(),"address"],data[data[,"business_id"]==id(),"city"],data[data[,"business_id"]==id(),"state"],data[data[,"business_id"]==id(),"postal_code"],sep=", ")
    })
    output$takeout<-renderText({
        if(data[data[,"business_id"]==id(),"RestaurantsTakeOut"]){
            return("Offers Takeout")
        }else{
            return("Takeout unavailable")
        }
    })
    output$delivery<-renderText({
        if(data[data[,"business_id"]==id(),"RestaurantsDelivery"]){
            return("Offers Delivery")
        }else{
            return("Delivery unavailable")
        }
    })
    
    output$parking<-renderText({
        col <- c("garage","street","validated","lot","valet")
        s <- ""
        for(i in col){
            if(data[data[,"business_id"]==id(),i]){
                if(s==""){s <- i}
                else{s <- paste(s, i, sep=", ") }
            }
        }
        if(s==""){return("No Parking")}
        return(s)
    })
    
    output$noise<-renderText({
        paste(data[data[,"business_id"]==id(),"NoiseLevel"])
    })
    output$alcohol<-renderText({
        if(data[data[,"business_id"]==id(),"Alcohol"] == "'none'" | data[data[,"business_id"]==id(),"Alcohol"] == "u'none'"){
            return("No alcohol")
        }else
        {
            return(paste("Alcohol: ",data[data[,"business_id"]==id(),"Alcohol"]))
        }
    })
    output$outdoorseating<-renderText({
        if(data[data[,"business_id"]==id(),"OutdoorSeating"]){
            return("Offers Outdoor Seating")
        }else{
            return("No Outdoor Seating")
        }
    })
    output$star<-renderImage({
        list(src = paste("image/",data[data[,"business_id"]==id(),"stars"],".jpg",sep=""),
             contentType = 'image/png',
             height=20)
    },deleteFile = FALSE)
##########################map######################################
    output$map <- renderLeaflet({
        df <- data[data[,"business_id"]==id(),]
        leaflet() %>%
            addTiles() %>%
            addMarkers(lng=df$longitude,
                       lat=df$latitude,
                       label = df$name,
                       popup = df$address, 
                       icon=makeIcon("image/mark.png"))
    })
########################wordcloud###################################
    output$pos<-renderWordcloud2({
        review1 <- review[review[,"business_id"]==id(),]
        review1$text <- as.character(review1$text)
        words1 <- review1[which(review1$stars>3),] %>%
            unnest_tokens(word,text) %>%
            count(word,sort=TRUE)
        return(wordcloud2(data=words1, size=1, color='random-light'))
    })
    
    output$neg<-renderWordcloud2({
        review2 <- review[review[,"business_id"]==id(),]
        review2$text <- as.character(review2$text)
        words2 <- review2[which(review2$stars<3),] %>%
            unnest_tokens(word,text) %>%
            count(word,sort=TRUE)
        return(wordcloud2(data=words2, size=1, color='random-light'))
    })
##########################SUGGESTION################################
    output$generalsuggestion<-renderText({
        if(data[data[,"business_id"]==id(),"OutdoorSeating"] != TRUE){
            return("Provide outdoor seating to customers")
        }
        if(data[data[,"business_id"]==id(),"NoiseLevel"] == "'very_loud'" | 
           data[data[,"business_id"]==id(),"NoiseLevel"] == "u'very_loud'" |
           data[data[,"business_id"]==id(),"NoiseLevel"] == "'loud'" |
           data[data[,"business_id"]==id(),"NoiseLevel"] == "u'loud'"){
            return("Pay attention to noise level and reduce noise")
        }
    })
    output$suggestion<-renderUI({
        a.bid <- review[review[,"business_id"]==id(),]
        a.bid.ser = a.bid[which(grepl("service",a.bid$text)==1),]
        a.bid.pri = a.bid[which(grepl("price",a.bid$text)==1),]
        a.bid.atm = a.bid[which(grepl("atmosphere",a.bid$text)==1),]
        a.bid.foo = a.bid[which(grepl("food",a.bid$text)==1),]
        a.bid.chi = a.bid[which(grepl("chicken",a.bid$text)==1),]
        a.bid.bee = a.bid[which(grepl("beef",a.bid$text)==1),]
        a.bid.mea = a.bid[which(grepl("meat",a.bid$text)==1),]
        a.bid.pla = a.bid[which(grepl("place",a.bid$text)==1),]
        a.bid.por = a.bid[which(grepl("pork",a.bid$text)==1),]
        a.bid.sta = a.bid[which(grepl("staff",a.bid$text)==1),]
        a.bid.rib = a.bid[which(grepl("ribs",a.bid$text)==1),]
        b = sum(a.bid$stars>3)/sum(a.bid$stars<3)
        s1 = ""
        s2 = ""
        s3 = ""
        s4 = ""
        s5 = ""
        s6 = ""
        s7 = ""
        s8 = ""
        s9 = ""
        s10 = ""
        s11 = ""
        if(sum(a.bid.ser$stars>3)/sum(a.bid.ser$stars<3)<b){
            s1 = "Customer service could be better. Most customers enjoy speedy and prompt service in barbeque restaurants. The waiters and waitresses need to be trained to work faster."
        }
        if(sum(a.bid.ser$stars>3)/sum(a.bid.ser$stars<3)>b){
            s1 = "Customer service is great."
        }
        if(sum(a.bid.pri$stars>3)/sum(a.bid.pri$stars<3)<b){
            s2 = "The food prices could be ajusted. People prefer barbeque restaurants with fair and reasonable price. Take the food prices in other barbeque restaurants as references." 
        }
        if(sum(a.bid.pri$stars>3)/sum(a.bid.pri$stars<3)>b){
            s2 = "The food prices are reasonable overall." 
        } 
        if(sum(a.bid.atm$stars>3)/sum(a.bid.atm$stars<3)<b){
            s3 = "Efforts should be made to create a better atmosphere. Most customers like barbeque restaurants with relaxed and chill atmosphere."
        }
        if(sum(a.bid.atm$stars>3)/sum(a.bid.atm$stars<3)>b){
            s3 = "The atmosphere is great overall."
        }
        if(!is.na(sum(a.bid.foo$stars>3)/sum(a.bid.foo$stars<3)) & sum(a.bid.foo$stars>3)/sum(a.bid.foo$stars<3)<b){
            s4 = "The food could be improved. "
        }
        if(!is.na( sum(a.bid.foo$stars>3)/sum(a.bid.foo$stars<3)) & sum(a.bid.foo$stars>3)/sum(a.bid.foo$stars<3)>b){
            s4 = "The food is great overall. "
        }
        if(!is.na(sum(a.bid.chi$stars>3)/sum(a.bid.chi$stars<3)) & sum(a.bid.chi$stars>3)/sum(a.bid.chi$stars<3)<b){
            s5 = "The chicken could be improved. Fried chicken and chicken tenders are the most favourable in barbeque restaurants. Consider adding these two dishes to the menu. If they already exist, consider modifying them."
        }
        if(!is.na(sum(a.bid.chi$stars>3)/sum(a.bid.chi$stars<3)) & sum(a.bid.chi$stars>3)/sum(a.bid.chi$stars<3)>b){
            s5 = "The chicken is great overall. "
        }
        if(!is.na(sum(a.bid.bee$stars>3)/sum(a.bid.bee$stars<3)) & sum(a.bid.bee$stars>3)/sum(a.bid.bee$stars<3)<b){
            s6 = "The beef could be improved. People love beef ribs, beef tongues and corned beef. Consider adding these dishes to the menu. If they already exist, consider modifying them."
        }
        if(!is.na(sum(a.bid.bee$stars>3)/sum(a.bid.bee$stars<3)) & sum(a.bid.bee$stars>3)/sum(a.bid.bee$stars<3)>b){
            s6 = "The beef is great overall. "
        }
        if(!is.na(sum(a.bid.mea$stars>3)/sum(a.bid.mea$stars<3)) & sum(a.bid.mea$stars>3)/sum(a.bid.mea$stars<3)<b){
            s7 = "The meat could be improved. Customers care a lot about the cut of meat. So, consider providing better cuts of meat. They also love marinated and smoked meat in barbeque restaurant. So, it would be better to provide these option if haven't already."
        }
        if(!is.na(sum(a.bid.mea$stars>3)/sum(a.bid.mea$stars<3)) & sum(a.bid.mea$stars>3)/sum(a.bid.mea$stars<3)>b){
            s7 = "The meat is great overall. "
        }
        if(!is.na(sum(a.bid.pla$stars>3)/sum(a.bid.pla$stars<3)) & sum(a.bid.pla$stars>3)/sum(a.bid.pla$stars<3)<b){
            s8 = "The restaurant is not an ideal place for customers. People like clean places with table services. Consider improve these aspects."
        }
        if(!is.na(sum(a.bid.pla$stars>3)/sum(a.bid.pla$stars<3)) & sum(a.bid.pla$stars>3)/sum(a.bid.pla$stars<3)>b){
            s8 = "Overall, the restaurant is a great place to eat barbeque. "
        }
        if(!is.na(sum(a.bid.por$stars>3)/sum(a.bid.por$stars<3)) & sum(a.bid.por$stars>3)/sum(a.bid.por$stars<3)<b){
            s9 = "The pork could be improved. People love pulled pork, pork belly, pork rinds and pork chops the best in barbeque restaurant. Consider adding these to the menu or improve them if they are already on the menu."
        }
        if(!is.na(sum(a.bid.por$stars>3)/sum(a.bid.por$stars<3)) & sum(a.bid.por$stars>3)/sum(a.bid.por$stars<3)>b){
            s9 = "The pork is great overall. "
        }
        if(!is.na(sum(a.bid.sta$stars>3)/sum(a.bid.sta$stars<3)) & sum(a.bid.sta$stars>3)/sum(a.bid.sta$stars<3)<b){
            s10 = "The staffs need to improve. Customers like the staffs that are friendly, helpful, attentive and courteous. Consider training the staffs in these areas "
        }
        if(!is.na(sum(a.bid.sta$stars>3)/sum(a.bid.sta$stars<3)) & sum(a.bid.sta$stars>3)/sum(a.bid.sta$stars<3)>b){
            s10 = "The staffs are great overall. "
        }
        if(!is.na(sum(a.bid.rib$stars>3)/sum(a.bid.rib$stars<3)) & sum(a.bid.rib$stars>3)/sum(a.bid.rib$stars<3)<b){
            s11 = "The ribs could be improved. People love spare ribs and short ribs. Consider adding these to the menu or improve them if they are already on the menu."
        }
        if(!is.na(sum(a.bid.rib$stars>3)/sum(a.bid.rib$stars<3)) & sum(a.bid.rib$stars>3)/sum(a.bid.rib$stars<3)>b){
            s11 = "The ribs are great overall. "
        }
        HTML(paste(s8,s2,s3,s1,s10,s4,s7,s5,s6,s9,s11,sep="<br/>"))
    })
})