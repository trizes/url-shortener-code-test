const list = document.querySelector('ul.list');
const form = document.querySelector('.url-form');
form.addEventListener('submit', sendUrl);

document.addEventListener('DOMContentLoaded', getKnownUrls);
function getKnownUrls() {
    fetch('/list')
        .then(data => data.json())
        .then(data => appendToList(data.data));
}


function sendUrl(e) {
    e.preventDefault();

    let url = new FormData(e.target).get('url-input');

    if (url == null || url == '') return;

    let data = JSON.stringify({url: url});

    e.target.reset();

    fetch('/', { method: 'POST', body: data })
        .then(handleErrors)
        .then(data => data.json())
        .then(data => appendToList([data]))
        .catch(error => shakeForm());
}

function shakeForm() {
    form.classList.add('shake');

    setTimeout(
        () => form.classList.remove('shake'),
        300
    )
}

function handleErrors(response) {
    if (!response.ok) {
        throw Error(response.statusText);
    }
    return response;
}

function appendToList(data) {
    data.forEach(link => {
        let item = document.createElement("li");

        item.innerHTML = `<a href="${link.short_url}">${link.short_url}</a> ⇒ <a href="${link.url}">${link.url}</a>`

        list.appendChild(item);
    });
}
