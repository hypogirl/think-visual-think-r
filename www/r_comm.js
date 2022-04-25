/*$(document).on('shiny:connected', function(event) {
    Shiny.setInputValue("x", "time");
    Shiny.setInputValue("y", "measles");
    alert("vmkrfknr");
});*/

$(function(){ 
    $("#upload_button").on("click", function() {
        Shiny.onInputChange("csvfile:shinyjs.dataframe", fileContent);
        showAxisSelect();
    });
});

$(function(){ 
    $("#set_axis").on("click", function(){
        /* test */
    });
});