# Sicario

[![Build Status](https://travis-ci.org/ifyouseewendy/sicario.svg?branch=production)](https://travis-ci.org/ifyouseewendy/sicario)
[![Code Climate](https://codeclimate.com/github/ifyouseewendy/sicario/badges/gpa.svg)](https://codeclimate.com/github/ifyouseewendy/sicario)

A demo API project, names after a wonderful movie.

## Usage

**Deploy**

[sicario.ifyouseewendy.com/](http://sicario.ifyouseewendy.com/)


**Authentication**

Custom header `X-Sicario-Authorization`, and the demo apikey is `benicio_del_toro_rocks`.

**Seeds**

organization | model | model_type
------------ | ----- | ----------
flexible | serie_1 | bmw_1 
flexible | serie_1 | bmw_2
fixed | serie_2 | bmw_3
fixed | serie_2 | bmw_4
prestige | serie_3 | bmw_5
prestige | serie_3 | bmw_6

**API**


+ *GET* `models/:model_slug/model_types`

```sh
$ http sicario.ifyouseewendy.com/models/serie_1/model_types X-Sicario-Authorization:benecio_del_toro_rocks
```

```json
{
  "models": [
    {
      "name": "serie_1",
      "model_types": [
        {
          "name": "bmw_1",
          "total_price": 51000
        },
        {
          "name": "bmw_2",
          "total_price": 102000
        }
      ]
    }
  ]
}
```

+ *POST* `models/:model_slug/model_types_price/:model_type_slug`

```sh
http POST sicario.ifyouseewendy.com/models/serie_1/model_types_price/bmw_3 base_price=10000 X-Sicario-Authorization:benecio_del_toro_rocks
```

```json
{
  "model_type": {
    "name": "bmw_3",
    "base_price": 10000,
    "total_price": 50600
  }
}
```
