const String jokesUrl = 'https://api.sampleapis.com/jokes/goodJokes';
const String messageErrorJokesApi =
    'Error en obtenir els acudits des de l\'API';
const String messageEmptyJokesApi =
    'L\'API no ha retornat cap acudit';
const String messageInvalidJokeData =
    'El format de l\'acudit retornat no es valid';

const String tmbBaseUrl = 'https://api.tmb.cat/v1';
const String tmbBusLinesEndpoint =
        String.fromEnvironment('TMB_LINES_ENDPOINT', defaultValue: '/transit/linies/bus');
const String tmbBusStopsEndpoint =
        String.fromEnvironment('TMB_STOPS_ENDPOINT', defaultValue: '/transit/parades');
const String tmbStopArrivalsEndpoint = String.fromEnvironment(
    'TMB_ARRIVALS_ENDPOINT',
    defaultValue: '/ibus/stops/{stopCode}',
);
const String tmbBusLinesEndpointFallbacks = String.fromEnvironment(
    'TMB_LINES_ENDPOINT_FALLBACKS',
    defaultValue:
            '/transit/linies/bus|/transit/linies/bus/format/json|/transit/linies/bus/format/geojson',
);
const String tmbAppId =
        String.fromEnvironment('TMB_APP_ID', defaultValue: 'b8908ea3');
const String tmbAppKey = String.fromEnvironment(
    'TMB_APP_KEY',
    defaultValue: '22725f88f982e89af11d085ef02db218',
);
const String messageMissingTmbCredentials =
    'Falten credencials TMB. Usa --dart-define TMB_APP_ID i TMB_APP_KEY.';
const String messageTmbUnexpectedResponse =
    'Resposta no valida de l\'API de TMB';

const String endPointBrands = '/cars/makes';
const String messageErrorCarsApi =
    'Error al obtener la lista de coches desde la API';
const String messageErrorBrandApi =
    'Error al obtener la lista de marcas desde la API';
