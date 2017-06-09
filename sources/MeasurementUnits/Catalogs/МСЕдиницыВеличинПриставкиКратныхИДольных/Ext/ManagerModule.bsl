﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает реквизиты справочника, которые образуют естественный ключ
//  для элементов справочника.
//
// Возвращаемое значение: Массив(Строка) - массив имен реквизитов, образующих
//  естественный ключ.
//
Функция ПоляЕстественногоКлюча() Экспорт
	
	Результат = Новый Массив();
	
	Результат.Добавить("Основание");
	Результат.Добавить("Порядок");
	
	Возврат Результат;
	
КонецФункции

// Возвращает элемент справочника по основанию степени и показателю.
//
// Параметры:
//  ПоказательСтепени	- Строка, Число		- Показатель степени
//  ОснованиеСтепени    - Строка, Число		- Основание степени
// 
// Возвращаемое значение:
//   Ссылка             - элемент справочника
//   Неопределено       - в случае, искомый элемент не найден.
//
Функция НайтиПоПоказателю(Знач ПоказательСтепени, Знач ОснованиеСтепени = 10) Экспорт
	
	Перем Запрос;
	Перем РезультатЗапроса;

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|   Ссылка
		|ИЗ
		|   Справочник.МСЕдиницыВеличинПриставкиКратныхИДольных
		|ГДЕ
		|   (Основание = &Основание)
		|	И (Порядок = &Порядок)";

	Запрос.УстановитьПараметр("Основание", ОснованиеСтепени);
	Запрос.УстановитьПараметр("Порядок", ПоказательСтепени);
	РезультатЗапроса = Запрос.Выполнить().Выбрать();

	Если РезультатЗапроса.Следующий() Тогда
		Возврат РезультатЗапроса.Ссылка;
	Иначе
		Возврат Неопределено;
	КонецЕсли;

КонецФункции

// Создаёт либо обновляет поставляемый элемент справочника при обновлении ИБ.
//
// Параметры:
//  Основание           		- Число		- Основание степени
//  Показатель					- Число		- Показатель степени
//  Наименование 				- Строка    - Наименование приставки
//  НаименованиеРус 			- Строка    - Приставка для наименования единиц величин русская
//  ОбозначениеРус 				- Строка    - Обозначение приставки русское
//  НаименованиеМн 				- Строка    - Приставка для наименования единиц величин международная
//  ОбозначениеМн 				- Строка    - Обозначение приставки международное
//  НаименованиеРусISO_80000_1 	- Строка    - Приставка для наименования единиц величин русская по ISO 80000-1
//  ОбозначениеРусISO_80000_1 	- Строка    - Обозначение приставки русское по ISO 80000-1
//  НаименованиеМнISO_80000_1 	- Строка    - Приставка для наименования единиц величин международная по ISO 80000-1
//  ОбозначениеМнISO_80000_1 	- Строка    - Обозначение приставки международное по ISO 80000-1
// 
Процедура ЗаполнитьПредопределённый(Знач Основание, Знач Порядок, Знач Наименование,
	Знач НаименованиеРус, Знач ОбозначениеРус,
	Знач НаименованиеМн, Знач ОбозначениеМн,
	Знач НаименованиеРусISO_80000_1 = Неопределено, Знач ОбозначениеРусISO_80000_1 = Неопределено,
	Знач НаименованиеМнISO_80000_1 = Неопределено, Знач ОбозначениеМнISO_80000_1 = Неопределено) Экспорт
	
	Перем ТребуетсяЗапись;
		
	Параметры = Новый ФиксированнаяСтруктура(
		"Основание,Порядок,Наименование,
		| НаименованиеРус,ОбозначениеРус,
		| НаименованиеМн,ОбозначениеМн,
		| НаименованиеРусISO_80000_1,ОбозначениеРусISO_80000_1,
		| НаименованиеМнISO_80000_1,ОбозначениеМнISO_80000_1",
		Основание, Порядок, Наименование,
		НаименованиеРус, ОбозначениеРус,
		НаименованиеМн, ОбозначениеМн,
		?(НаименованиеРусISO_80000_1 <> Неопределено, НаименованиеРусISO_80000_1, НаименованиеРус),
			?(ОбозначениеРусISO_80000_1 <> Неопределено, ОбозначениеРусISO_80000_1, ОбозначениеРус),
		?(НаименованиеМнISO_80000_1 <> Неопределено, НаименованиеМнISO_80000_1, НаименованиеМн),
			?(ОбозначениеМнISO_80000_1 <> Неопределено, ОбозначениеМнISO_80000_1, ОбозначениеМн)
	);

	Приставка = НайтиПоПоказателю(Порядок, Основание);
	
	Если Приставка <> ПустаяСсылка() Тогда
		
		ТребуетсяЗапись = Ложь;
		
		Для Каждого Реквизит из Параметры цикл
			ТребуетсяЗапись = НЕ (Реквизит.Значение = Приставка[Реквизит.Ключ]);
			Если ТребуетсяЗапись Тогда
                Прервать;
	        КонецЕсли;
	    КонецЦикла;

		Если НЕ ТребуетсяЗапись Тогда
			Возврат;
		Иначе
			ПриставкаОбъект = Приставка.ПолучитьОбъект();
		КонецЕсли;
		
	Иначе
		
		ПриставкаОбъект = СоздатьЭлемент();
		
	КонецЕсли;
	
	ПриставкаОбъект.Заполнить(Параметры);
	ОбновлениеИнформационнойБазы.ЗаписатьДанные(ПриставкаОбъект, , Истина);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Интерфейс для работы с подсистемой ЗапретРедактированияРеквизитовОбъектов.

// Возвращает описание блокируемых реквизитов.
//
// Возвращаемое значение:
//  Массив - содержит строки в формате ИмяРеквизита[;ИмяЭлементаФормы,...]
//           где ИмяРеквизита - имя реквизита объекта, ИмяЭлементаФормы - имя элемента формы,
//           связанного с реквизитом.
//
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт
	
	Перем БлокируемыеРеквизиты;
	БлокируемыеРеквизиты = Новый Массив;
	
	БлокируемыеРеквизиты.Добавить("Основание");
	БлокируемыеРеквизиты.Добавить("Порядок");
	
	Для Каждого ВариантОбозначения Из МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьВариантыОбозначенийЕдиницВеличин() Цикл
		БлокируемыеРеквизиты.Добавить(МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования(ВариантОбозначения));
		БлокируемыеРеквизиты.Добавить(МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитОбозначения(ВариантОбозначения));
	КонецЦикла;

	Возврат БлокируемыеРеквизиты;

КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Интерфейс для работы с подсистемой ПоискИУдалениеДублей.

// Вызывается для определения прикладных параметров поиска дублей.
//
// Параметры:
//
//     ПараметрыПоиска - Структура - Предлагаемые параметры поиска. Содержит поля:
//
//         *  ПравилаПоиска - ТаблицаЗначений - Предлагаемые правила сравнения для объектов.
//                            Может быть изменена для установки новых вариантов. Содержит колонки.
//               ** Реквизит - Строка - Имя реквизита для сравнения.
//               ** Правило  - Строка - Правило сравнения: "Равно" - сравнение по равенству, "Подобно" -подобие строк,
//                                     "" - пустая строка - не сравнивать.
//
//         * КомпоновщикОтбора - КомпоновщикНастроекКомпоновкиДанных - Инициализированный компоновщик для 
//                               предварительного отбора. Может быть изменен, например, для 
//                               усиления отборов.
// 
//         * ОграниченияСравнения - Массив - Предназначен для заполнения описания прикладных правил-ограничений.
//                                  Должен быть дополнен структурами с полями:
//               ** Представление      - Строка - Описание правила-ограничения для пользователя.
//               ** ДополнительныеПоля - Строка - Список дополнительных реквизитов запятую, необходимых для
//                                                дополнительного анализа.
// 
//         * КоличествоЭлементовДляСравнения - Число - Количество кандидатов в дубли, передаваемых одним вызовом
//                                                     обработчику.
//
//     ДополнительныеПараметры - Произвольный - Значение, переданное при вызове программного интерфейса
//                                              ОбщегоНазначения.НайтиДублиЭлементов.
//                               При вызове пользователем из обработки "ПоискИЗаменаДублей" равно Неопределено.
// 
Процедура ПараметрыПоискаДублей(ПараметрыПоиска, ДополнительныеПараметры = Неопределено) Экспорт
	
	ОграниченияСравнения = ПараметрыПоиска.ОграниченияСравнения;
	ПравилаПоиска        = ПараметрыПоиска.ПравилаПоиска;
	КомпоновщикОтбора    = ПараметрыПоиска.КомпоновщикОтбора;
	
	// Общие ограничения для всех случаев.
	
	// Размер таблицы для передачи в обработчик.
	ПараметрыПоиска.КоличествоЭлементовДляСравнения = 100;
	
	// Анализ режима работы - варианта вызова.
	Если ДополнительныеПараметры = Неопределено Тогда
		// Внешний вызов из обработки, больше ничего делать не надо, но можно отредактировать параметры пользователя.
		СтрокаПравила = ПравилаПоиска.Найти("Основание", "Реквизит");
		СтрокаПравила.Правило  = "Равно";
		СтрокаПравила = ПравилаПоиска.Найти("Порядок", "Реквизит");
		СтрокаПравила.Правило  = "Равно";
		Возврат;
	КонецЕсли;
	
	// Вызов из программного интерфейса.
	ЭлементыОтбора = КомпоновщикОтбора.Настройки.Отбор.Элементы;
	ЭлементыОтбора.Очистить();
	ПравилаПоиска.Очистить();
	
	Отбор = ЭлементыОтбора.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	Отбор.Использование  = Истина;
	Отбор.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ПометкаУдаления");
	Отбор.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	Отбор.ПравоеЗначение = Ложь;
	СтрокаПравила = ПравилаПоиска.Добавить();
	СтрокаПравила.Реквизит = "Основание";
	СтрокаПравила.Правило  = "Равно";
	СтрокаПравила = ПравилаПоиска.Добавить();
	СтрокаПравила.Реквизит = "Порядок";
	СтрокаПравила.Правило  = "Равно";
	
КонецПроцедуры

// Вызывается для определения дублей по прикладным правилам.
//
// Параметры:
//
//     ТаблицаКандидатов - ТаблицаЗначений - Описывает кандидатов в дубли. Содержит колонки:
//         - Ссылка1  - ЛюбаяСсылка - Ссылка на элемент первого кандидата.
//         - Ссылка2  - ЛюбаяСсылка - Ссылка на элемент второго кандидата.
//         - ЭтоДубли - Булево      - Флаг того, что кандидаты действительно являются дублями. По умолчанию содержит 
//                                    значение Ложь, может быть изменено на Истина, если кандидаты - действительно
//                                    дубли.
//         - Поля1    - Структура   - Содержит поля Код, Наименование и дополнительные поля первого кандидата,
//         указанные в ПараметрыПоискаДублей.
//         - Поля2    - Структура   - Содержит поля Код, Наименование и дополнительные поля второго кандидата,
//         указанные в ПараметрыПоискаДублей.
//
//     ДополнительныеПараметры - Произвольный - Значение, переданное при вызове программного интерфейса
//                                              ОбщегоНазначения.НайтиДублиЭлементов.
//                               При вызове пользователем из обработки "ПоискИЗаменаДублей" равно Неопределено.
//
Процедура ПриПоискеДублей(ТаблицаКандидатов, ДополнительныеПараметры = Неопределено) Экспорт
	
	Если ДополнительныеПараметры = Неопределено Тогда
		// Общие проверки
		Для Каждого Вариант Из ТаблицаКандидатов Цикл
			Вариант.ЭтоДубли = Истина;
		КонецЦикла;
	Иначе
		// Исключим себя самого
		Для Каждого Вариант Из ТаблицаКандидатов Цикл
			Если Вариант.Ссылка1 <> ДополнительныеПараметры.Ссылка
				Или Вариант.Ссылка2 <> ДополнительныеПараметры.Ссылка Тогда
				Вариант.ЭтоДубли = Истина;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка) 
	
	СтандартнаяОбработка = Ложь; 
	
	Поля.Добавить("Основание");
    Поля.Добавить("Порядок");
	
	Для Каждого ВариантОбозначения Из МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьВариантыОбозначенийЕдиницВеличин() Цикл
		Поля.Добавить(МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименованияПриставки(ВариантОбозначения));
		Поля.Добавить(МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименованияПриставки(ВариантОбозначения) + "ISO_80000_1");
	КонецЦикла;

КонецПроцедуры 

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка) 
	
	СтандартнаяОбработка = Ложь;

	Если Данные.Порядок = 0 Тогда
		Представление = "";
	Иначе
	    //Представление = Данные[МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования()] + " (" + Данные.Основание + РаботаСоСтрокамиЮникодКлиентСервер.ПолучитьСтрокуИзПоказателяСтепени(Данные.Порядок) + ")";
	    Представление = Данные[МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименованияПриставки()]
			+ " (" + Данные.Основание
			+ РаботаСоСтрокамиЮникодКлиентСервер.ПолучитьСтрокуИзПоказателяСтепени(Данные.Порядок) + ")";
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
    
	Если НЕ Параметры.Отбор.Свойство("ПометкаУдаления") Тогда
		Параметры.Отбор.Вставить("ПометкаУдаления", Ложь);
	КонецЕсли;
    
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти

#КонецЕсли