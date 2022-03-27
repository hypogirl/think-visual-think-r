const dropArea = document.getElementById('dragdrop');

function importData(files) {
    const input = document.getElementById("file-import");
    readFile(files[0]);
}

function readFile(file) {
    const fl = new FileReader();
    const dataFile = document.getElementById('dataFile');
    fl.addEventListener("load", () => {
        // this will then display a text file
        console.log(fl.result);
        dataFile.value = fl.result;
      }, false);

    if (file) fl.readAsText(file);
}

;['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
    dropArea.addEventListener(eventName, preventDefaults, false);
})
  
function preventDefaults (e) {
    e.preventDefault();
    e.stopPropagation();
}

;['dragenter', 'dragover'].forEach(eventName => {
    dropArea.addEventListener(eventName, highlight, false);
})
  
;['dragleave', 'drop'].forEach(eventName => {
    dropArea.addEventListener(eventName, unhighlight, false);
})
  
function highlight(e) {
    dropArea.classList.add('highlight');
    dropArea.innerHTML = "Drop the file to import it."
}
  
function unhighlight(e) {
    dropArea.classList.remove('highlight');
    dropArea.innerHTML = '\t<input type="file" id="dataFile" onchange="importData(this.files)" style="display: none;">\n\t<label for="dataFile" style="display: block;"><i class="bi bi-upload"></i></label>\n\t<label for="dataFile" style="text-decoration: underline;">Choose a file</label> or drag it here.'
}

dropArea.addEventListener('drop', handleDrop, false);

function handleDrop(e) {
    let dt = e.dataTransfer;
    let files = dt.files;

    readFile(files[0]);
}