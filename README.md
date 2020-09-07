<img alt="Logo" src="http://coderslab.pl/svg/logo-coderslab.svg" width="400">

# ScrumLab .NET

Witaj w ScrumLab, w którym wspólnie z Twoim zespołem Scrumowym wykonasz projekt `Zaplanuj Jedzonko`. Wykonaj z zespołem zadania przygotowane na `tablicy Kanban` dostarczonej przez `ScrumMastera`.

## Przygotowanie

### Technologia

Do wykonania projektu użyj technologii `ASP.NET Core MVC` z `EntityFramework Core` oraz logowanie oparte o `ASP.NET Core Identity`. Używaj wiedzy i technik poznanych podczas zajęć z wykładowcą i mentorem. Możesz również używać dodatkowej wiedzy poznanej poza zajęciami, ale pamiętaj, że pracujesz w zespole i ważne jest, aby reszta zespołu wiedziała co się dzieje w projekcie i rozumiała Twój kod.

### Przykładowy projekt `PlanFood.Mvc`

Przygotowaliśmy dla Ciebie przykładowy projekt z zainstalowanym pakietem NuGet `Microsoft.AspNetCore.All` i stroną główną w formie szablonu dostarczonego przez klienta. Uważaj, nie ma w tym projekcie pliku `_Layout.cshtml`. Utworzysz go w ramach jednego z zadań.

### Połączenie z bazą danych i praca na DbContext

1. W `EntityFramework` skorzystaj z podejścia `Code First`.
1. W przykładowym projekcie w klasie `Startup` znajduje ścieżką do połączenia z bazą danych. Dostosuj ścieżkę do bazy danych do własnych potrzeb.
1. Pamiętaj, aby w klasie kontekstu wykorzystać dziedziczenie z odpowiedniego bazowego `DbContext`. Zadecyduj wspólnie z zespołem czy chcecie korzystać z jednego kontekstu współdzielonego z `ASP.NET Core Identity` czy z dwóch niezależnych kontekstów. Jednakże pamiętaj, aby dostarczyć dla obu kontekstów migracje bazy danych.
1. Pamiętaj, aby zawsze dostarczać odpowiednie migracje baz danych.
1. W folderze `resources\sql` znajduje się plik `insert.sql`, który dodaje do bazy danych przykładowe dane. Użyj tego pliku w porcjach dodając poszczególne wpisy dot. pojedynczej tabeli po utworzeniu migracji lub poczekaj, aż będzie kompletny model bazy danych i dodaj komplet danych.

### Zabezpiecz aplikację

1. Używaj atrybutów zapewniających dostęp do odpowiednich kontrolerów i akcji zalogowanym użytkownikom.
1. Jeżeli dane są pobierane dla bieżącego zalogowanego użytkownika skorzystaj z właściwości `User.Identity.Name` dostępnej w kontrolerze, aby przekazać nazwę bieżącego zalogowanego użytkownika do metody pobierającej dane.

### Inne porady

1. Wykorzystaj `Dependency Injection`, np. do wstrzykiwania kontekstu i innych serwisów.
1. Pamiętaj o dobrych praktykach `DRY` (Don't Repeat Yourself) i `KISS` (Keep It Sweet and Simple).

Powodzenia :)