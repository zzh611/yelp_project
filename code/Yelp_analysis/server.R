shinyServer(function(input,output){
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
    
    output$takeouticon<-renderImage({
        list(src = "image/Takeout.PNG",
             contentType = 'image/png',
             height=20)
    },deleteFile = FALSE)
    
    output$deliveryicon<-renderImage({
        list(src = "image/Delivery.PNG",
             contentType = 'image/png',
             height=20)
    },deleteFile = FALSE)
    
    output$parkingicon<-renderImage({
        list(src = "image/Parking.PNG",
             contentType = 'image/png',
             height=20)
    },deleteFile = FALSE)
    
    output$outdoorseatingicon<-renderImage({
        list(src = "image/Outdoor.PNG",
             contentType = 'image/png',
             height=20)
    },deleteFile = FALSE)
    
    output$title<-renderImage({
        list(src = "title.jpg",
             width=153.75,
             height=54.75,
             alt = "OOF! The Pic Seems Broken!")
    },deleteFile = FALSE)
})