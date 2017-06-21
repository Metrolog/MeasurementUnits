﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает реквизиты справочника, которые образуют естественный ключ
//  для элементов справочника.
//
// Возвращаемое значение: Массив(Строка) - массив имен реквизитов, образующих
//  естественный ключ.
//
Функция ПоляЕстественногоКлюча() Экспорт
	
	Перем Результат;
	
	Результат = Новый Массив();
	Результат.Добавить(ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования());
	
	Возврат Результат;
	
КонецФункции

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
	
	БлокируемыеРеквизиты.Добавить("Код");
	БлокируемыеРеквизиты.Добавить("ЭтоОсновнаяЕдиница");
	БлокируемыеРеквизиты.Добавить("ЭтоКогерентнаяЕдиница");
	БлокируемыеРеквизиты.Добавить("ИмеетСпециальныеНаименованиеИОбозначение");
	
	Для Каждого ВариантОбозначения Из ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьВариантыОбозначенийЕдиницВеличин() Цикл
		БлокируемыеРеквизиты.Добавить(ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования(ВариантОбозначения));
		БлокируемыеРеквизиты.Добавить(ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитОбозначения(ВариантОбозначения));
		БлокируемыеРеквизиты.Добавить(ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитПробелПередОбозначением(ВариантОбозначения));
		БлокируемыеРеквизиты.Добавить(ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитПредлогаДляЗнаменателя(ВариантОбозначения));
	КонецЦикла;

	БлокируемыеРеквизиты.Добавить("ОснованиеСтепениПриставки");
	БлокируемыеРеквизиты.Добавить("ИспользоватьНаименованиеСтепениКакПрилагательное");
	
	БлокируемыеРеквизиты.Добавить("ДопустимоПрименениеПриставок");
	БлокируемыеРеквизиты.Добавить("МинимальныйПоказательСтепениПриставки; МинимальныйПоказательСтепениПриставки");
	БлокируемыеРеквизиты.Добавить("МаксимальныйПоказательСтепениПриставки; МаксимальныйПоказательСтепениПриставки");
	
	БлокируемыеРеквизиты.Добавить("Коэффициент");
	БлокируемыеРеквизиты.Добавить("Выражение");
	
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
	
	Если ДополнительныеПараметры.Режим = "КонтрольПоНаименованию" Тогда
		// Ищем среди неудаленных таких же по равенству Наименования
		СтрокаПравила = ПравилаПоиска.Добавить();
		СтрокаПравила.Реквизит = ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования();
		СтрокаПравила.Правило  = "Равно";
	ИначеЕсли ДополнительныеПараметры.Режим = "ПоискПохожихПоНаименованию" Тогда
		// Ищем все похожие по наименованию.
		СтрокаПравила = ПравилаПоиска.Добавить();
		СтрокаПравила.Реквизит = ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования();
		СтрокаПравила.Правило  = "Подобно";
	ИначеЕсли ДополнительныеПараметры.Режим = "КонтрольПоОбозначению" Тогда
		// Ищем среди неудаленных таких же по равенству Обозначения
		СтрокаПравила = ПравилаПоиска.Добавить();
		СтрокаПравила.Реквизит = ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитОбозначения();
		СтрокаПравила.Правило  = "Равно";
	КонецЕсли;
	
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
	
	Для Каждого ВариантОбозначения Из ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьВариантыОбозначенийЕдиницВеличин() Цикл
		Поля.Добавить(ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования(ВариантОбозначения));
		Поля.Добавить(ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитОбозначения(ВариантОбозначения));
	КонецЦикла;

КонецПроцедуры 

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка) 
	
	СтандартнаяОбработка = Ложь;

    Представление = Данные[ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования()] +
		" (" + Данные[ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитОбозначения()] + ")";
	
КонецПроцедуры

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
    
    Перем ДополнительныеПараметры, Запрос, РезультатЗапроса, Построитель,
		МенеджерВременныхТаблиц, Отбор, ОтборИзПараметров;
	
	Если НЕ Параметры.Свойство("ДополнительныеПараметры", ДополнительныеПараметры) Тогда
		
		Если НЕ Параметры.Отбор.Свойство("ПометкаУдаления") Тогда
			Параметры.Отбор.Вставить("ПометкаУдаления", Ложь);
		КонецЕсли;
		
	Иначе
		
		СтандартнаяОбработка = Ложь;
		ДанныеВыбора = Новый СписокЗначений;

		Если НЕ ДополнительныеПараметры.Свойство("ДляПроизводнойЕдиницыВеличины") Тогда
			
			Построитель = Новый ПостроительЗапроса(СтрШаблон(
			"ВЫБРАТЬ
			|	ЕдиницыВеличин.Ссылка КАК Ссылка
			|ИЗ
			|	Справочник.ЕдиницыВеличин КАК ЕдиницыВеличин
			|ГДЕ
			|	НЕ ЕдиницыВеличин.ПометкаУдаления
			|	И ЕдиницыВеличин.%1 ПОДОБНО &Наименование + ""%%""
			|{ГДЕ
			|	ЕдиницыВеличин.ПометкаУдаления.*,
			|	ЕдиницыВеличин.Ссылка.*,
			|	ЕдиницыВеличин.ИмеетСпециальныеНаименованиеИОбозначение.*}
			|
			|УПОРЯДОЧИТЬ ПО
			|	ЕдиницыВеличин.%1"
			, ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования()));
			
			Построитель.Параметры.Вставить("Наименование", Параметры.СтрокаПоиска);
			
			Для Каждого ОтборИзПараметров Из Параметры.Отбор Цикл
				Отбор = Построитель.Отбор.Добавить(ОтборИзПараметров.Ключ);
				Отбор.Использование = Истина;
				Отбор.ВидСравнения  = ВидСравнения.Равно;
				Отбор.Значение = ОтборИзПараметров.Значение;
			КонецЦикла;
			
			Построитель.Выполнить();
			
			ДанныеВыбора.ЗагрузитьЗначения(Построитель.Результат.Выгрузить().ВыгрузитьКолонку("Ссылка"));
		
		Иначе 
			
			Запрос = Новый Запрос;
			МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
			Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
			
			Запрос.Текст = 
				"ВЫБРАТЬ
				|	&ЕдиницаВеличины КАК Ссылка
				|ПОМЕСТИТЬ ПроизводныеПервогоПорядка
				|
				|ИНДЕКСИРОВАТЬ ПО
				|	Ссылка
				|;
				|
				|////////////////////////////////////////////////////////////////////////////////
				|ВЫБРАТЬ
				|	ПроизводныеПервогоПорядка.Ссылка КАК Ссылка
				|ПОМЕСТИТЬ ВсеПроизводные
				|ИЗ
				|	ПроизводныеПервогоПорядка КАК ПроизводныеПервогоПорядка
				|
				|ИНДЕКСИРОВАТЬ ПО
				|	Ссылка
				|;
				|
				|////////////////////////////////////////////////////////////////////////////////
				|ВЫБРАТЬ
				|	ПроизводныеПервогоПорядка.Ссылка КАК Ссылка
				|ИЗ
				|	ПроизводныеПервогоПорядка КАК ПроизводныеПервогоПорядка";
			Запрос.УстановитьПараметр("ЕдиницаВеличины", ДополнительныеПараметры.ДляПроизводнойЕдиницыВеличины);
			РезультатЗапроса = Запрос.Выполнить();
			
			Запрос.Текст = 
				"ВЫБРАТЬ
				|	ПроизводныеПервогоПорядка.Ссылка КАК Ссылка
				|ПОМЕСТИТЬ ПроизводныеПервогоПорядкаПредыдущейИтерации
				|ИЗ
				|	ПроизводныеПервогоПорядка КАК ПроизводныеПервогоПорядка
				|
				|ИНДЕКСИРОВАТЬ ПО
				|	Ссылка
				|;
				|
				|////////////////////////////////////////////////////////////////////////////////
				|УНИЧТОЖИТЬ ПроизводныеПервогоПорядка
				|;
				|
				|////////////////////////////////////////////////////////////////////////////////
				|ВЫБРАТЬ РАЗЛИЧНЫЕ
				|	ЕдиницыВеличинВыражение.Ссылка КАК Ссылка
				|ПОМЕСТИТЬ ПроизводныеПервогоПорядка
				|ИЗ
				|	Справочник.ЕдиницыВеличин.Выражение КАК ЕдиницыВеличинВыражение
				|ГДЕ
				|	ЕдиницыВеличинВыражение.Ссылка.ИмеетСпециальныеНаименованиеИОбозначение
				|	И НЕ ЕдиницыВеличинВыражение.Ссылка.ПометкаУдаления
				|	И ЕдиницыВеличинВыражение.БазоваяЕдиница В
				|			(ВЫБРАТЬ
				|				ПроизводныеПервогоПорядкаПредыдущейИтерации.Ссылка
				|			ИЗ
				|				ПроизводныеПервогоПорядкаПредыдущейИтерации)
				|
				|ИНДЕКСИРОВАТЬ ПО
				|	Ссылка
				|;
				|////////////////////////////////////////////////////////////////////////////////
				|УНИЧТОЖИТЬ ПроизводныеПервогоПорядкаПредыдущейИтерации
				|;
				|
				|
				|////////////////////////////////////////////////////////////////////////////////
				|ВЫБРАТЬ
				|	ВсеПроизводные.Ссылка КАК Ссылка
				|ПОМЕСТИТЬ ВсеПроизводныеПредыдущейИтерации
				|ИЗ
				|	ВсеПроизводные КАК ВсеПроизводные
				|
				|ИНДЕКСИРОВАТЬ ПО
				|	Ссылка
				|;
				|
				|////////////////////////////////////////////////////////////////////////////////
				|УНИЧТОЖИТЬ ВсеПроизводные
				|;
				|
				|////////////////////////////////////////////////////////////////////////////////
				|ВЫБРАТЬ
				|	ПроизводныеПервогоПорядка.Ссылка КАК Ссылка
				|ПОМЕСТИТЬ ВсеПроизводные
				|ИЗ
				|	ПроизводныеПервогоПорядка КАК ПроизводныеПервогоПорядка
				|
				|ОБЪЕДИНИТЬ
				|
				|ВЫБРАТЬ
				|	ВсеПроизводныеПредыдущейИтерации.Ссылка
				|ИЗ
				|	ВсеПроизводныеПредыдущейИтерации КАК ВсеПроизводныеПредыдущейИтерации
				|
				|ИНДЕКСИРОВАТЬ ПО
				|	Ссылка
				|;
				|
				|////////////////////////////////////////////////////////////////////////////////
				|УНИЧТОЖИТЬ ВсеПроизводныеПредыдущейИтерации
				|;
				|
				|////////////////////////////////////////////////////////////////////////////////
				|ВЫБРАТЬ
				|	ПроизводныеПервогоПорядка.Ссылка КАК Ссылка
				|ИЗ
				|	ПроизводныеПервогоПорядка КАК ПроизводныеПервогоПорядка";
				
			Пока НЕ РезультатЗапроса.Пустой() Цикл
				РезультатЗапроса = Запрос.Выполнить();
			КонецЦикла;
    
			Запрос.Текст = СтрШаблон(
				"ВЫБРАТЬ
				|	ЕдиницыВеличин.Ссылка КАК Ссылка
				|ИЗ
				|	Справочник.ЕдиницыВеличин КАК ЕдиницыВеличин
				|ГДЕ
				|	ЕдиницыВеличин.ИмеетСпециальныеНаименованиеИОбозначение
				|	И НЕ ЕдиницыВеличин.ПометкаУдаления
				|	И НЕ ЕдиницыВеличин.Ссылка В
				|			(ВЫБРАТЬ
				|				ВсеПроизводные.Ссылка
				|			ИЗ
				|				ВсеПроизводные)
				|	И ЕдиницыВеличин.%1 ПОДОБНО &Наименование + ""%%""
				|
				|УПОРЯДОЧИТЬ ПО
				|	ЕдиницыВеличин.%1"
				, ЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования());
			Запрос.Параметры.Вставить("Наименование", Параметры.СтрокаПоиска);
			ДанныеВыбора.ЗагрузитьЗначения(Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка"));
			МенеджерВременныхТаблиц.Закрыть();
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли