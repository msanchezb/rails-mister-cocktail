
const bannerChange = () => {

  let myVar = setInterval(changeBackgroundImage, 5000);


  function changeBackgroundImage() {
    const wrapper = document.getElementById('back-image');
    const options = ['image-1', 'image-2', 'image-3', 'image-4'];

    const image = wrapper.classList[1];
    let last = 0;
    let next = 1;
    options.forEach((element, index) => {
      if (image === element) {
        last = index;
        if (index === options.length - 1) {
          next = 0;
        } else {
          next = index + 1;
        }
      }
    });
    wrapper.classList.remove(options[last]);
    wrapper.classList.add(options[next]);
  }
}


export { bannerChange }
