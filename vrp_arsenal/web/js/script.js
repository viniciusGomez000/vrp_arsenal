$('.actionmenu').hide(0);
showWeapon()
$(document).ready(function () {
    window.addEventListener('message',function(event){
        switch(event.data.action){
            case 'showMenu':
                $('.actionmenu').show(700);
            break;
        
            case 'hideMenu':
                $('.actionmenu').hide(700);
            break;
        }
    });

    document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_arsenal/Close");
		};
	};
});

$('.retirar').click(function(){
    var index = $(this).data('index');
    var type = $(this).data('type');

    $.post('http://vrp_arsenal/addWeapon', JSON.stringify({
        weaponName: index,
        ammoName: type
    }))
    
})

$('.guardar').click(function(){
    var index = $(this).attr('data-index');
    var type = $(this).data('type');

    $.post('http://vrp_arsenal/removeWeapon', JSON.stringify({
        weaponName: index,
        ammoName: type
    }))
})

$('.keep-all').click(function(){-
    $.post('http://vrp_arsenal/keppAll')
})


function showWeapon(){
    let htmlWeapons  = ''
    config.forEach((weapon) => {
        htmlWeapons += `
        <div class="guns">
            <div class="image-box"><img src="../img/${weapon.img}.png"></div>
            <div class="name-box">
                <p class="name">${weapon.name}</p>
            </div>
            <div class="button-box">
                <button class="retirar" data-index="${weapon.index}" data-type="${weapon.type}">Retirar</button>
                <button class="guardar" data-index="${weapon.index}" data-type="${weapon.type}">Guardar</button>
            </div>
        </div>
        `
    });
    $('.guns-section').html(htmlWeapons);
    return htmlWeapons;
}