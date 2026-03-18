# TMB - Validacio prvia a la implementacio

Aquest document deixa constancia de les 3 crides provades al Postman abans d'integrar-les a Flutter.

## 1) Preparacio

1. Registra't a https://developer.tmb.cat/
2. Crea una aplicacio i copia:
- `app_id`
- `app_key`

## 2) Variables d'entorn Postman

- `base_url`: `https://api.tmb.cat/v1`
- `app_id`: `<EL_TEU_APP_ID>`
- `app_key`: `<LA_TEVA_APP_KEY>`

## 3) Endpoints (omple amb els que t'han funcionat)

### Endpoint 1: Linies de bus
- Metode: `GET`
- URL: `{{base_url}}/<PATH_LINIES_BUS>`
- Params:
  - `app_id={{app_id}}`
  - `app_key={{app_key}}`
- Estat esperat: `200`
- Exemple resposta: enganxa JSON de mostra

### Endpoint 2: Parades
- Metode: `GET`
- URL: `{{base_url}}/<PATH_PARADES>`
- Params:
  - `app_id={{app_id}}`
  - `app_key={{app_key}}`
- Estat esperat: `200`
- Exemple resposta: enganxa JSON de mostra

### Endpoint 3: Arribades per codi de parada
- Metode: `GET`
- URL: `{{base_url}}/<PATH_ARRIBADES_AMB_STOP_CODE>`
- Params:
  - `app_id={{app_id}}`
  - `app_key={{app_key}}`
- Exemple codi de parada: `<CODI_REAL_DE_PROVA>`
- Estat esperat: `200`
- Exemple resposta: enganxa JSON de mostra

## 4) Notes de mapeig a Flutter

Un cop validats els paths exactes al Postman, posa'ls a:
- `lib/utils/const_app.dart`

Constants a revisar:
- `tmbBusLinesEndpoint`
- `tmbBusStopsEndpoint`
- `tmbStopArrivalsEndpoint`

## 5) Execucio de Flutter amb credencials

Exemple (PowerShell):

```bash
flutter run -d chrome --dart-define=TMB_APP_ID=<APP_ID> --dart-define=TMB_APP_KEY=<APP_KEY>
```
