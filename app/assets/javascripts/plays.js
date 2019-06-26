var Play = function() {
    var self = this;

    this.currentTime = 1;
    this.counterEl = document.getElementById('counter');
    this.imageEl = document.getElementById('counter-image');
    this.buttonEl = document.getElementById('save-play-button');
    this.imagesIndexTable = [];
    this.imagesJson = [];

    this.playTemplate = `
        <tr>
            <td>{timer}</td>
            <td><img src="{image_url}" /></td>
        </tr>
    `;
    this.playsContainer = document.getElementById('plays-table-tbody');

    this.generateIndexTable = function() {
        var table = [];
        var imagesTable = []

        var imagesCount = this.imagesJson.length;

        if (imagesCount < 10) {
            for (var i = 0; i < 10; i++) {
                imagesTable.push(this.imagesJson[i%imagesCount]);
            }
        } else {
            imagesTable = this.imagesJson;
        }

        return imagesTable;
    };

    this.getImageForIndex = function(index) {
        return self.imagesIndexTable[index - 1];
    };

    this.countdownTimer = function () {
        if (self.currentTime == 1) {
            self.currentTime = 10;
        } else {
            self.currentTime--;
        }

        self.imageEl.src = self.getImageForIndex(self.currentTime).url;
        self.counterEl.innerHTML = self.currentTime;
    };

    this.handleButtonClick = function() {
        var data = {
            play: {
                timer: self.currentTime,
                upload_id: self.getImageForIndex(self.currentTime).id
            }
        };

        var request = fetch("/plays", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': Rails.csrfToken()
            },
            body: JSON.stringify(data)
        });

        request
            .then(response => response.json())
            .then(json => {
                self.renderPlay(json)
            });
    };

    this.renderPlay = function(play) {
        var playEntry = self.playTemplate
            .replace(/\{timer\}/, play.timer)
            .replace(/\{image_url\}/, play.image_url);

        self.playsContainer.insertAdjacentHTML("afterbegin", playEntry);
    };

    this.initialize = function() {
        this.imagesJson = JSON.parse(
            document.getElementById('images-json').innerHTML
        );

        this.imagesIndexTable = self.generateIndexTable();

        this.countdownTimer();
        setInterval(this.countdownTimer, 1000);

        self.buttonEl.onclick = self.handleButtonClick;
    };
};


document.addEventListener('DOMContentLoaded', () => {
    if (document.getElementById("play-game")) {
        var play = new Play();
        play.initialize();
    }
});
