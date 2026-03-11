document.addEventListener("DOMContentLoaded", function () => {
    let video = document.getElementById("video");
    let finished = false;

    video.addEventListener("play", () => {
        console.log("Video is started.")
    });

    video.addEventListener("ended", () => {
        finished = true;
        sendRecord("Completed");
    });

    window.addEventListener("beforeunload", function () {
        if(!finished){
            sendRecord("Not Finished");
            alert("You must finish the video.");
        }
    });

    function sendRecord(status){

    fetch("YOUR_GOOGLE_SCRIPT_URL", {
        method: "POST",
        body: JSON.stringify({
            user: "Student1",
            video: "Lesson1",
            status: status,
            time: new Date().toLocaleString()
        })
    });
});
