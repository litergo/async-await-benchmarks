# async-await-benchmark

Таргет `AsyncAwaitBenchmarks` содержит бенчмарки работы async/await в сравнении с GCD. Для запуска бенчмарков нужно вызвать из корня проекта:

```
swift run -c release AsyncAwaitBenchmarks
```

Если будете запускать бенчмарки на своем маке, присылайте результаты прогона.

Mattermost: @avmischenko

Таргет `Example` содержит упрощенный до базовых вызовов код модуля `Abuses`, который переведен с GCD на async/await в качестве примера. 
