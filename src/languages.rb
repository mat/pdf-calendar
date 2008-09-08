

module Calendar

  class Languages

  @@weekday_names = {}
  @@month_names   = {}

  def self.lang_en
   [  'en',
      %w(Mon Tue Wed Thu Fri Sat Sun),
      %w(January February March April May June July 
         August September October November December) ]
  end

  def self.lang_de
   [  'de',
      %w(Mo Di Mi Do Fr Sa So),
      %w(Januar Februar März April Mai Juni Juli 
         August September Oktober November Dezember) ]
  end

  def self.lang_fr
   [  'fr',
      %w(lun mar mer jeu ven sam dim),
      %w(janvier février mars avril mai juin juillet 
         août septembre octobre novembre décembre) ]

  end

  def self.lang_es
       # The Spanish week starts on Monday.
   [  'es',
      %w(lun mar mier jue vier sab dom),
      %w(enero febrero marzo abril mayo junio julio 
         agosto septiembre octubre noviembre diciembre) ]

  end

  def self.add_lang(locale, weekdays, months)
     @@weekday_names[locale] = weekdays
     @@month_names[locale]   = [nil] + months
  end

  def self.add_langs()
    add_lang(*lang_en)
    add_lang(*lang_de)
    add_lang(*lang_fr)
    add_lang(*lang_es)
  end

   def self.weekdays(for_locale, weekstart=:monday)
      add_langs

      unless @@weekday_names[for_locale]
        raise "Locale <#{for_locale}> not supported."
      end

      weekdays = @@weekday_names[for_locale]

      if weekstart == :sunday
        sun = weekdays.pop
        weekdays = [sun] + weekdays
      end

      weekdays
   end

   def self.months(for_locale)
      add_langs

      unless @@month_names[for_locale]
        raise "Locale <#{for_locale}> not supported."
      end

      @@month_names[for_locale]
   end
end

end
