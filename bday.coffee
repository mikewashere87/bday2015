message = "Поздравляю, Вы приглашены на день рождения Никиты!
Соизвольте явиться 3 октября (суббота) сего года в салон госпожи Анны
аккурат к 18 часам (кто забыл/не знает адрес — высылайте голубиную почту).
Проходить на территорию мероприятия без алкогольных напитков строжайше
запрещено."
$(() ->

    $("body").css("background", "#293134")
    $("body").css("color", "#293134")
    [w, h] = [$(window).width(), $(window).height()]

    for ch, i in message

        if ch == " "

            ch = "&nbsp;"

        $(".inner").append("<div id='char#{i}' class='inline'>#{ch}</div>")

    states = [0...message.length].map((i) ->
        o = $("#char#{i}")
        return {
            offset: o.offset(),
            object: o,
        }

    )

    max_width = Math.max(states.map((state) -> state.object.width())...)
    max_height = Math.max(states.map((state) -> state.object.height())...)

    $("div").removeClass("inline")
    for state in states

        state.object.addClass("absolute").offset(state.offset)

    animate_shuffle = () =>

        for state in states

            state.object.velocity(
                {
                    left: Math.random() * (w - max_width)
                    top: Math.random() * (h - max_height)
                },
                1000
            )

    animate_restore = () ->

        for state in states

            state.object.velocity(
                {
                    left: state.offset.left
                    top: state.offset.top
                },
                1000
            )

    action = animate_restore
    animate_shuffle()
    $("body").css("color", "#e0e2e4")
    $(window).on("click", () =>

        console.log("click")
        action()
        action = if action is animate_shuffle then animate_restore else animate_shuffle

    )

)
