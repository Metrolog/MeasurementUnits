﻿////////////////////////////////////////////////////////////////////////////////
// Обновление информационной базы конфигурации.
// Метрологическая служба. Подсистема единиц величин.
// ОбщийМодуль.ОбновлениеИнформационнойБазыМСЕдиницыВеличин.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// Сведения о библиотеке (или конфигурации).

// См. описание в общем модуле ОбновлениеИнформационнойБазыБСП.
Процедура ПриДобавленииПодсистемы(Описание) Экспорт

	Описание.Имя    = "МетрологическаяСлужба.ЕдиницыВеличин";
	Описание.Версия = МСЕдиницыВеличинКлиентСервер.ВерсияБиблиотеки();
	Описание.РежимВыполненияОтложенныхОбработчиков = "Последовательно";

	// Требуется библиотека стандартных подсистем.
	Описание.ТребуемыеПодсистемы.Добавить("СтандартныеПодсистемы");

КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обработчики обновления информационной базы.

// Возвращает список процедур-обработчиков обновления ИБ для всех поддерживаемых версий ИБ.
//
// Пример добавления процедуры-обработчика в список:
//    Обработчик = Обработчики.Добавить();
//    Обработчик.Версия = "1.0.0.0";
//    Обработчик.Процедура = "ОбновлениеИБ.ПерейтиНаВерсию_1_0_0_0";
//
// Вызывается перед началом обновления данных ИБ.
//
Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура =
		"ОбновлениеИнформационнойБазыМСЕдиницыВеличин.НачальноеЗаполнение";
	Обработчик.ОбщиеДанные 		   = Истина;
	Обработчик.НачальноеЗаполнение = Истина;
	Обработчик.РежимВыполнения     = "Монопольно";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия    = "1.0.1.10";
	Обработчик.Процедура =
		"ОбновлениеИнформационнойБазыМСЕдиницыВеличин.Заполнение_1_0_1_10";
	Обработчик.ОбщиеДанные 		   = Истина;
	Обработчик.РежимВыполнения     = "Монопольно";
	Обработчик.Комментарий =
		НСтр("ru = 'Проверка и восстановление единиц величин. Рекомендуется воздержаться от их редактирования до завершения обработки.'");

	Обработчик = Обработчики.Добавить();
	Обработчик.Версия    = "1.0.1.12";
	Обработчик.Процедура =
		"ОбновлениеИнформационнойБазыМСЕдиницыВеличин.Заполнение_1_0_1_12";
	Обработчик.ОбщиеДанные 		   = Истина;
	Обработчик.РежимВыполнения     = "Монопольно";
	Обработчик.Комментарий =
		НСтр("ru = 'Восстановление помеченных на удаление приставок дольных и кратных единиц величин после удаления предопределённых элементов справочника.'");
	
КонецПроцедуры

// Вызывается перед обработчиками обновления данных ИБ.
//
Процедура ПередОбновлениемИнформационнойБазы() Экспорт
	
	
	
КонецПроцедуры

// Вызывается после завершении обновления данных ИБ.
//
// Параметры:
//   ПредыдущаяВерсияИБ     - Строка - версия ИБ до обновления. "0.0.0.0" для "пустой" ИБ.
//   ТекущаяВерсияИБ        - Строка - версия ИБ после обновления.
//   ВыполненныеОбработчики - ДеревоЗначений - список выполненных процедур-обработчиков
//                                             обновления, сгруппированных по номеру версии.
//  Итерирование по выполненным обработчикам:
//		Для Каждого Версия Из ВыполненныеОбработчики.Строки Цикл
//
//			Если Версия.Версия = "*" Тогда
//				группа обработчиков, которые выполняются всегда
//			Иначе
//				группа обработчиков, которые выполняются для определенной версии
//			КонецЕсли;
//
//			Для Каждого Обработчик Из Версия.Строки Цикл
//				...
//			КонецЦикла;
//
//		КонецЦикла;
//
//   ВыводитьОписаниеОбновлений - Булево -	если Истина, то выводить форму с описанием
//											обновлений.
//   МонопольныйРежим           - Булево - признак выполнения обновления в монопольном режиме.
//                                Истина - обновление выполнялось в монопольном режиме.
//
Процедура ПослеОбновленияИнформационнойБазы(Знач ПредыдущаяВерсияИБ, Знач ТекущаяВерсияИБ,
		Знач ВыполненныеОбработчики, ВыводитьОписаниеОбновлений, МонопольныйРежим) Экспорт
	
	
	
КонецПроцедуры

// Вызывается при подготовке табличного документа с описанием изменений системы.
//
// Параметры:
//   Макет - ТабличныйДокумент - описание обновлений.
//
// См. также общий макет ОписаниеИзмененийСистемы.
//
Процедура ПриПодготовкеМакетаОписанияОбновлений(Знач Макет) Экспорт
	
	
	
КонецПроцедуры

// Позволяет переопределить режим обновления данных информационной базы.
// Для использования в редких (нештатных) случаях перехода, не предусмотренных в
// стандартной процедуре определения режима обновления.
//
// Параметры:
//   РежимОбновленияДанных - Строка - в обработчике можно присвоить одно из значений:
//              "НачальноеЗаполнение"     - если это первый запуск пустой базы (области данных);
//              "ОбновлениеВерсии"        - если выполняется первый запуск после обновление конфигурации базы данных;
//              "ПереходСДругойПрограммы" - если выполняется первый запуск после обновление конфигурации базы данных, 
//                                          в которой изменилось имя основной конфигурации.
//
//   СтандартнаяОбработка  - Булево - если присвоить Ложь, то стандартная процедура
//                                    определения режима обновления не выполняется, 
//                                    а используется значение РежимОбновленияДанных.
//
Процедура ПриОпределенииРежимаОбновленияДанных(РежимОбновленияДанных, СтандартнаяОбработка) Экспорт
	
	
	
КонецПроцедуры

// Добавляет в список процедуры-обработчики перехода с другой программы (с другим именем конфигурации).
// Например, для перехода между разными, но родственными конфигурациями: базовая -> проф -> корп.
// Вызывается перед началом обновления данных ИБ.
//
// Параметры:
//  Обработчики - ТаблицаЗначений - с колонками:
//    * ПредыдущееИмяКонфигурации - Строка - имя конфигурации, с которой выполняется переход;
//                                           или "*", если нужно выполнять при переходе с любой конфигурации.
//    * Процедура                 - Строка - полное имя процедуры-обработчика перехода с программы ПредыдущееИмяКонфигурации. 
//                                  Например, "ОбновлениеИнформационнойБазыУПП.ЗаполнитьУчетнуюПолитику"
//                                  Обязательно должна быть экспортной.
//
// Пример добавления процедуры-обработчика в список:
//  Обработчик = Обработчики.Добавить();
//  Обработчик.ПредыдущееИмяКонфигурации  = "УправлениеТорговлей";
//  Обработчик.Процедура                  = "ОбновлениеИнформационнойБазыУПП.ЗаполнитьУчетнуюПолитику";
//
Процедура ПриДобавленииОбработчиковПереходаСДругойПрограммы(Обработчики) Экспорт
	
	
	
КонецПроцедуры

// Вызывается после выполнения всех процедур-обработчиков перехода с другой программы (с другим именем конфигурации),
// и до начала выполнения обновления данных ИБ.
//
// Параметры:
//  ПредыдущееИмяКонфигурации    - Строка - имя конфигурации до перехода.
//  ПредыдущаяВерсияКонфигурации - Строка - имя предыдущей конфигурации (до перехода).
//  Параметры                    - Структура - 
//    * ВыполнитьОбновлениеСВерсии   - Булево - по умолчанию Истина. Если установить Ложь, 
//        то будут выполнена только обязательные обработчики обновления (с версией "*").
//    * ВерсияКонфигурации           - Строка - номер версии после перехода. 
//        По умолчанию, равен значению версии конфигурации в свойствах метаданных.
//        Для того чтобы выполнить, например, все обработчики обновления с версии ПредыдущаяВерсияКонфигурации, 
//        следует установить значение параметра в ПредыдущаяВерсияКонфигурации.
//        Для того чтобы выполнить вообще все обработчики обновления, установить значение "0.0.0.1".
//    * ОчиститьСведенияОПредыдущейКонфигурации - Булево - по умолчанию Истина. 
//        Для случаев когда предыдущая конфигурация совпадает по имени с подсистемой текущей конфигурации, следует указать Ложь.
//
Процедура ПриЗавершенииПереходаСДругойПрограммы(Знач ПредыдущееИмяКонфигурации, 
	Знач ПредыдущаяВерсияКонфигурации, Параметры) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиОбновления

Процедура НачальноеЗаполнение() Экспорт
	
	Заполнение_1_0_1_10();

КонецПроцедуры

Процедура Заполнение_1_0_1_10() Экспорт
	
	ОбновитьКод_1_0_1_10();
	
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,  24, "иотта",   "И");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,  21, "зетта",   "З");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,  18, "экса",    "Э");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,  15, "пета",    "П");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,  12, "тера",    "Т");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,   9, "гига",    "Г");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,   6, "мега",    "М");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,   3, "кило",    "к");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,   2, "гекто",   "г");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,   1, "дека",    "да");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,  -1, "деци",    "д");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,  -2, "санти",   "с");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,  -3, "милли",   "м");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,  -6, "микро",   "мк");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10,  -9, "нано",    "н");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10, -12, "пико",    "п");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10, -15, "фемто",   "ф");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10, -18, "атто",    "а");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10, -21, "зепто",   "з");
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ЗаполнитьПредопределённый(10, -24, "иокто",   "и");

КонецПроцедуры

Процедура ОбновитьКод_1_0_1_10()
	
	Приставка = Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.Выбрать();
	Пока Приставка.Следующий() Цикл
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(Приставка.ПолучитьОбъект(), , Истина);
	КонецЦикла;
	
КонецПроцедуры

Процедура Заполнение_1_0_1_12() Экспорт
	
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю( 24).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю( 21).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю( 18).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю( 15).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю( 12).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю(  9).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю(  6).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю(  3).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю(  2).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю(  1).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю( -1).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю( -2).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю( -3).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю( -6).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю( -9).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю(-12).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю(-15).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю(-18).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю(-21).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);
	Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.НайтиПоПоказателю(-24).ПолучитьОбъект().УстановитьПометкуУдаления(Ложь);

КонецПроцедуры

#КонецОбласти