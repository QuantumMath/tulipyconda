
# This file is generated. Do not modify directly.

import __builtin__
from libc.limits cimport INT_MAX

import numpy as np
cimport numpy as np

cimport ti

TI_VERSION = ti.TI_VERSION
TI_BUILD   = ti.TI_BUILD

class InvalidOptionError(ValueError):
    pass

cdef dict _type_names = {
    ti.TI_TYPE_OVERLAY:     'overlay',
    ti.TI_TYPE_INDICATOR:   'indicator',
    ti.TI_TYPE_MATH:        'math',
    ti.TI_TYPE_SIMPLE:      'simple',
    ti.TI_TYPE_COMPARATIVE: 'comparative',
}

cdef class _Indicator:
    cdef const ti.ti_indicator_info * info

    cdef readonly const char * name
    cdef readonly const char * full_name
    cdef readonly const char * type

    def __init__(self, int index):
        assert 0 <= index < ti.TI_INDICATOR_COUNT

        self.info = ti.ti_indicators + index
        self.name = self.info.name
        self.full_name = self.info.full_name
        self.type = _type_names[self.info.type]

    @property
    def inputs(self):
        return [
            self.info.input_names[i]
            for i in range(self.info.inputs)
        ]

    @property
    def options(self):
        return [
            self.info.option_names[i]
            for i in range(self.info.options)
        ]

    @property
    def outputs(self):
        return [
            self.info.output_names[i]
            for i in range(self.info.outputs)
        ]

    def __call__(self, inputs, options):
        cdef int min_input_len = INT_MAX
        for i in range(self.info.inputs):
            min_input_len = __builtin__.min(min_input_len, inputs[i].shape[0])

        option_list = options if options else [0.0]
        cdef np.ndarray[np.float64_t, ndim=1, mode='c'] c_options = np.array(option_list, dtype=np.float64)

        delta = self.info.start(&c_options[0])
        if min_input_len - delta <= 0:
            # This would cause self.info.indicator to return ti.TI_INVALID_OPTION, but there would
            # be a problem before we got there in creating the `outputs` np.ndarray below with a
            # negative dimension
            raise InvalidOptionError()

        cdef ti.TI_REAL * c_inputs[ti.TI_MAXINDPARAMS]
        cdef np.ndarray[np.float64_t, ndim=1, mode='c'] input_ref

        for i in range(self.info.inputs):
            input_ref = inputs[i][-min_input_len:]
            c_inputs[i] = &input_ref[0]

        cdef ti.TI_REAL * c_outputs[ti.TI_MAXINDPARAMS]
        cdef np.ndarray[np.float64_t, ndim=2, mode='c'] outputs = np.empty((self.info.outputs, min_input_len - delta))
        for i in range(self.info.outputs):
            c_outputs[i] = &outputs[i,0]

        ret = self.info.indicator(min_input_len, c_inputs, &c_options[0], c_outputs)
        if ret == ti.TI_INVALID_OPTION:
            raise InvalidOptionError()

        if self.info.outputs == 1:
            return outputs[0]

        return tuple(outputs)


abs = _Indicator(0)


acos = _Indicator(1)


ad = _Indicator(2)


add = _Indicator(3)


adosc = _Indicator(4)


adx = _Indicator(5)


adxr = _Indicator(6)


ao = _Indicator(7)


apo = _Indicator(8)


aroon = _Indicator(9)


aroonosc = _Indicator(10)


asin = _Indicator(11)


atan = _Indicator(12)


atr = _Indicator(13)


avgprice = _Indicator(14)


bbands = _Indicator(15)


bop = _Indicator(16)


cci = _Indicator(17)


ceil = _Indicator(18)


cmo = _Indicator(19)


cos = _Indicator(20)


cosh = _Indicator(21)


crossany = _Indicator(22)


crossover = _Indicator(23)


cvi = _Indicator(24)


decay = _Indicator(25)


dema = _Indicator(26)


di = _Indicator(27)


div = _Indicator(28)


dm = _Indicator(29)


dpo = _Indicator(30)


dx = _Indicator(31)


edecay = _Indicator(32)


ema = _Indicator(33)


emv = _Indicator(34)


exp = _Indicator(35)


fisher = _Indicator(36)


floor = _Indicator(37)


fosc = _Indicator(38)


hma = _Indicator(39)


kama = _Indicator(40)


kvo = _Indicator(41)


lag = _Indicator(42)


linreg = _Indicator(43)


linregintercept = _Indicator(44)


linregslope = _Indicator(45)


ln = _Indicator(46)


log10 = _Indicator(47)


macd = _Indicator(48)


marketfi = _Indicator(49)


mass = _Indicator(50)


max = _Indicator(51)


md = _Indicator(52)


medprice = _Indicator(53)


mfi = _Indicator(54)


min = _Indicator(55)


mom = _Indicator(56)


msw = _Indicator(57)


mul = _Indicator(58)


natr = _Indicator(59)


nvi = _Indicator(60)


obv = _Indicator(61)


ppo = _Indicator(62)


psar = _Indicator(63)


pvi = _Indicator(64)


qstick = _Indicator(65)


roc = _Indicator(66)


rocr = _Indicator(67)


round = _Indicator(68)


rsi = _Indicator(69)


sin = _Indicator(70)


sinh = _Indicator(71)


sma = _Indicator(72)


sqrt = _Indicator(73)


stddev = _Indicator(74)


stderr = _Indicator(75)


stoch = _Indicator(76)


sub = _Indicator(77)


sum = _Indicator(78)


tan = _Indicator(79)


tanh = _Indicator(80)


tema = _Indicator(81)


todeg = _Indicator(82)


torad = _Indicator(83)


tr = _Indicator(84)


trima = _Indicator(85)


trix = _Indicator(86)


trunc = _Indicator(87)


tsf = _Indicator(88)


typprice = _Indicator(89)


ultosc = _Indicator(90)


var = _Indicator(91)


vhf = _Indicator(92)


vidya = _Indicator(93)


volatility = _Indicator(94)


vosc = _Indicator(95)


vwma = _Indicator(96)


wad = _Indicator(97)


wcprice = _Indicator(98)


wilders = _Indicator(99)


willr = _Indicator(100)


wma = _Indicator(101)


zlema = _Indicator(102)
