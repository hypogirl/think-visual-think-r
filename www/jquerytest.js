$(document).on('shiny:connected', function(event) {
    Shiny.setInputValue("x", "time");
    Shiny.setInputValue("y", "measles");
    alert("vmkrfknr");
});

$(function(){ 
    // Selecting all `{shiny}` plots
    $("#buttontest").on("click", function(){
      /* Calling the alertme function with the id 
      of the clicked plot */
      console.log(fileContent);
      Shiny.onInputChange("csvfile:shinyjs.dataframe", fileContent);
    });
});