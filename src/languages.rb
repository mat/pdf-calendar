

module Calendar

  class Languages

@weekday_names = {}
@month_names = {}

@weekday_names['de'] = %w(Mo Di Mi Do Fr Sa So)
@month_names['de']   = [nil] + %w(Januar Februar März April Mai Juni Juli August September Oktober November Dezember)

@weekday_names['en'] = %w(Mon Tue Wed Thu Fri Sat Sun)
@month_names['en']   = [nil] + %w(January February March April May June July August September October November December)

@weekday_names['fr'] = %w(lun mar mer jeu ven sam dim)
@month_names['fr']   = [nil] + %w(janvier février mars avril mai juin juillet août septembre octobre novembre décembre)

   def self.weekdays(for_locale)
      @weekday_names[for_locale]
   end

   def self.months(for_locale)
      @month_names[for_locale]
   end
end

end
