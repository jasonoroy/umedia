import Slider from '../../../../app/javascript/lib/viewer/slider.js';

it('slides', () => {
  const sliderNumElem = {
    val: jest.fn()
  }

  const sliderKlass = {
    create: jest.fn(),
    on: jest.fn()
  }

  const sliderElem = {
    slider: jest.fn(),
    show: jest.fn(),
    setAttribute: jest.fn(),
    hasChildNodes: jest.fn(),
    sliderKlass: sliderKlass,
    style: {
      height: jest.fn()
    },
    noUiSlider: {
      on: jest.fn(),
    },
  }
  const callback = jest.fn();

  Slider({ recordCount: 54,
           sliderElem: sliderElem,
           sliderNumElem: sliderNumElem,
           sliderKlass: sliderKlass,
           callback: callback })

  expect(sliderElem.setAttribute.mock.calls[0][0]).toEqual('style');
  expect(sliderElem.hasChildNodes.mock.calls).toEqual([[]]);
  expect(sliderElem.noUiSlider.on.mock.calls[0][0]).toEqual('update');
});