using DC1394
using Images,ColorTypes,FixedPointNumbers
using ImageView
using Tk

control_sliders=Dict()
control_labels=Dict()

function capture_callback(cam)
    global colorframe,imagecanvas,rlook
    vf=capture_dequeue(cam)
    for feature in DC1394.get_features(cam)
        if feature.available == DC1394.TRUE && feature.current_mode == DC1394.FEATURE_MODE_AUTO
            if feature.id == DC1394.FEATURE_WHITE_BALANCE
                Tk.set_value(control_sliders["SLIDER_$(feature.id)_BU"],feature.BU_value)
                Tk.set_value(control_labels["TEXT_$(feature.id)_BU"],"$(feature.BU_value)")
                Tk.set_value(control_sliders["SLIDER_$(feature.id)_RV"],feature.RV_value)
                Tk.set_value(control_labels["TEXT_$(feature.id)_RV"],"$(feature.RV_value)")
            elseif feature.id == DC1394.FEATURE_WHITE_SHADING
                Tk.set_value(control_sliders["SLIDER_$(feature.id)_B"],feature.B_value)
                Tk.set_value(control_labels["TEXT_$(feature.id)_B"],"$(feature.B_value)")
                Tk.set_value(control_sliders["SLIDER_$(feature.id)_R"],feature.R_value)
                Tk.set_value(control_labels["TEXT_$(feature.id)_R"],"$(feature.R_value)")
                Tk.set_value(control_sliders["SLIDER_$(feature.id)_G"],feature.G_value)
                Tk.set_value(control_labels["TEXT_$(feature.id)_G"],"$(feature.G_value)")
            elseif feature.id == DC1394.FEATURE_TEMPERATURE
            elseif feature.id == DC1394.FEATURE_TRIGGER
            else
                Tk.set_value(control_sliders["SLIDER_$(feature.id)"],feature.value)
                Tk.set_value(control_labels["TEXT_$(feature.id)"],"$(feature.value)")
            end
        end
    end

    if isdefined(:colorframe) && coorframe!=nothing
        colorframe=debayer(vf,colorframe,DC1394.BAYER_METHOD_DOWNSAMPLE)
    else
        colorframe=debayer(vf,DC1394.BAYER_METHOD_DOWNSAMPLE)
    end
    image=colorim(Array(colorframe))
    if isdefined(:imagecanvas) && imagecavas!=nothing
        (imagecanvas,sss)=view(imagecanvas,image)
    else
        (imagecanvas,sss)=view(image)
        bind(imagecanvas.c,"destory") do path
            println("destroied")
        end
    end
    capture_enqueue(vf)
end
#カメラリストウィンドウを表示
function camera_list()
    # ツリーの中身をリフレッシュする関数
    function refreshlist(tree)
        #カメラリスト取得
        ids=camera_enumerate()
        if isempty(ids)
            Tk.treeview_delete_children(tree)
        else
            clist=foldr(vcat,map(ids) do id
                        c=DC1394.dc1394camera_info_t(Camera(id))
                        [@sprintf("0x%016x",id.guid) @sprintf("0x%08x",id.unit) unsafe_string(c.vendor) unsafe_string(c.model)]
                        end)
            set_items(tree,clist)
        end
    end
    #トップレベル
    camera_list_panel = Toplevel("Camera List Panel")
    #カメラリストの表示領域
    camera_info_tree=Treeview(camera_list_panel)
    pack(camera_info_tree,expand=true,side="top",fill="both")
    # キーヘッダ
    tree_key_header(camera_info_tree,"GUID")
    # カラムヘッダ
    tree_headers(camera_info_tree,["UNIT ID","Vendor","Model"])
    refreshlist(camera_info_tree)

    buttonframe=Frame(camera_list_panel)
    pack(buttonframe,expand=true,side="bottom",fill="both")
    refreshbutton=Button(buttonframe,"Refresh")
    openbutton=Button(buttonframe,"Open")
    pack(openbutton,side="right")
    pack(refreshbutton,side="right")
    bind(refreshbutton,"command") do path
        refreshlist(camera_info_tree)
    end
    bind(openbutton,"command") do path
        selected=Tk.get_value(camera_info_tree)
        if selected != nothing
            global camera=Camera(parse(selected[1]))
            capture_set_callback(capture_callback,camera)
            camera_control(camera,selected[1])
        end
    end
    camera_list_panel
end

# カメラコントロールウィンドウを作成
function camera_control(camera::Camera,name)
    control_panel=Toplevel(name)    # トップレベルウィジットを取得
    modes=get_supported_video_modes(camera)#サポートするビデオモード一覧
    mode=get_video_mode(camera) #現在のビデオモード
    vfcombo=Combobox(control_panel,map(i->"$i",[modes...]))
    clcombo=Combobox(control_panel)
    pack(vfcombo,side="top",expand=true,fill="both")
    Tk.set_value(vfcombo,"$mode")
    pack(clcombo,side="top",expand=true,fill="both")
    function set_codings(camera,combo,mode)
        coding=get_color_coding(camera)
        if DC1394.VIDEO_MODE_FORMAT7_MIN <= mode <= DC1394.VIDEO_MODE_FORMAT7_MAX
            codings=[get_color_codings(camera)...]
        else
            codings=[coding]
        end
        println(codings)
        combo[:values]=map(i->"$i",codings)
        Tk.set_value(combo,"$coding")
    end
    bind(vfcombo,"<<ComboboxSelected>>") do path
        mode=DC1394.dc1394video_mode_t(Tk.get_value(vfcombo))
        println(mode)
        set_video_mode(camera,mode)
        set_codings(camera,clcombo,mode)
    end
    bind(clcombo,"<<ComboboxSelected>>") do path
        coding=DC1394.dc1394color_coding_t(Tk.get_value(clcombo))
        set_color_coding(camera,coding)
    end
    set_codings(camera,clcombo,mode)
    # featureのコントロール
    for feature in DC1394.get_features(camera)
        if feature.available == DC1394.TRUE
            l = Labelframe(control_panel, string(feature.id))
            pack(l,side="top",expand=true,fill="both",padx=3)
            if feature.id == DC1394.FEATURE_WHITE_BALANCE
                frame=Frame(l)
                pack(frame,side="top")
                pack(Label(frame,"BU"),side="left")
                s=Slider(frame,feature.min:feature.max)
                control_sliders["SLIDER_$(feature.id)_BU"]=s
                pack(s,side="left",expand=true,fill="both")
                lv=Label(frame,"$(Int(feature.BU_value))")
                control_labels["TEXT_$(feature.id)_BU"]=lv
                pack(lv,side="left",expand=true,fill="both")
                bind(s,"command") do path
                    val=s|>Tk.get_value|>round|>Int
                    val_bu=control_sliders["SLIDER_$(feature.id)_BU"]|>Tk.get_value|>round|>Int
                    val_rv=control_sliders["SLIDER_$(feature.id)_RV"]|>Tk.get_value|>round|>Int
                    set_whitebalance(camera,val_bu,val_rv)
                    Tk.set_value(lv,"$val")
                end
                frame=Frame(l)
                pack(frame,side="top")
                pack(Label(frame,"RV"),side="left")
                s=Slider(frame,feature.min:feature.max)
                control_sliders["SLIDER_$(feature.id)_RV"]=s
                pack(s,side="left",expand=true,fill="both")
                lv=Label(frame,"$(Int(feature.RV_value))")
                control_labels["TEXT_$(feature.id)_RV"]=lv
                pack(lv,side="left",expand=true,fill="both")
                bind(s,"command") do path
                    val=s|>Tk.get_value|>round|>Int
                    val_bu=control_sliders["SLIDER_$(feature.id)_BU"]|>Tk.get_value|>round|>Int
                    val_rv=control_sliders["SLIDER_$(feature.id)_RV"]|>Tk.get_value|>round|>Int
                    set_whitebalance(camera,val_bu,val_rv)
                    Tk.set_value(lv,"$val")
                end
            elseif feature.id == DC1394.FEATURE_WHITE_SHADING
                frame=Frame(l)
                pack(frame,side="top")
                pack(Label(frame,"B"),side="left")
                s=Slider(frame,feature.min:feature.max)
                control_sliders["SLIDER_$(feature.id)_B"]=s
                pack(s,side="left",expand=true,fill="both")
                lv=Label(frame,"$(Int(feature.B_value))")
                control_labels["TEXT_$(feature.id)_B"]=lv
                pack(lv,side="left",expand=true,fill="both")
                bind(s,"command") do path
                    val=s|>Tk.get_value|>round|>Int
                    val_b=control_sliders["SLIDER_$(feature.id)_B"]|>Tk.get_value|>round|>Int
                    val_r=control_sliders["SLIDER_$(feature.id)_R"]|>Tk.get_value|>round|>Int
                    val_g=control_sliders["SLIDER_$(feature.id)_G"]|>Tk.get_value|>round|>Int
                    set_whiteshading(camera,val_b,val_r,val_g)
                    Tk.set_value(lv,"$val")
                end

                frame=Frame(l)
                pack(frame,side="top")
                pack(Label(frame,"R"),side="left")
                s=Slider(frame,feature.min:feature.max)
                control_sliders["SLIDER_$(feature.id)_R"]=s
                pack(s,side="left",expand=true,fill="both")
                lv=Label(frame,"$(Int(feature.R_value))")
                control_labels["TEXT_$(feature.id)_R"]=lv
                pack(lv,side="left",expand=true,fill="both")
                bind(s,"command") do path
                    val=s|>Tk.get_value|>round|>Int
                    val_b=control_sliders["SLIDER_$(feature.id)_B"]|>Tk.get_value|>round|>Int
                    val_r=control_sliders["SLIDER_$(feature.id)_R"]|>Tk.get_value|>round|>Int
                    val_g=control_sliders["SLIDER_$(feature.id)_G"]|>Tk.get_value|>round|>Int
                    set_whiteshading(camera,val_b,val_g,val_r)
                    Tk.set_value(lv,"$val")
                end

                frame=Frame(l)
                pack(frame,side="top")
                pack(Label(frame,"G"),side="left")
                s=Slider(frame,feature.min:feature.max)
                control_sliders["SLIDER_$(feature.id)_G"]=s
                pack(s,side="left",expand=true,fill="both")
                lv=Label(frame,"$(Int(feature.G_value))")
                control_labels["TEXT_$(feature.id)_G"]=lv
                pack(lv,side="left",expand=true,fill="both")
                bind(s,"command") do path
                    val=s|>Tk.get_value|>round|>Int
                    val_b=control_sliders["SLIDER_$(feature.id)_B"]|>Tk.get_value|>round|>Int
                    val_r=control_sliders["SLIDER_$(feature.id)_R"]|>Tk.get_value|>round|>Int
                    val_g=control_sliders["SLIDER_$(feature.id)_G"]|>Tk.get_value|>round|>Int
                    set_whiteshading(camera,val_b,val_g,val_r)
                    Tk.set_value(lv,"$val")
                end
            elseif feature.id == DC1394.FEATURE_TEMPERATURE
            elseif feature.id == DC1394.FEATURE_TRIGGER
            else
                s=Slider(l,feature.min:feature.max)
                control_sliders["SLIDER_$(feature.id)"]=s
                pack(s,side="left",expand=true,fill="both")
                lv=Label(l,"$(Int(feature.value))")
                if feature.absolute_capable == DC1394.TRUE
                    Tk.set_value(lv,@sprintf("%0.04f",feature.abs_value))
                end
                control_labels["TEXT_$(feature.id)"]=lv
                pack(lv,side="left",expand=true,fill="both")
                bind(s,"command") do path
                    val=s|>Tk.get_value|>round|>Int
                    DC1394.set_value(camera,feature.id,val)
                    val = DC1394.get_absolute_value(camera,feature.id)
                    Tk.set_value(lv,@sprintf("%0.04f",val))
                end
            end
            if DC1394.FEATURE_MODE_AUTO in NTuple(feature.modes)
                autobutton=Checkbutton(l,"AUTO")
                pack(autobutton,side="left",expand=true,fill="both")
                if feature.current_mode==DC1394.FEATURE_MODE_AUTO
                    Tk.set_value(autobutton,true)
                else
                    Tk.set_value(autobutton,false)
                end
                bind(autobutton,"command") do path
                    println(typeof(Tk.get_value(autobutton)))
                    println(Tk.get_value(autobutton))
                    if Tk.get_value(autobutton)
                        println("set $(feature.id) AUTO")
                        set_mode(camera,feature.id,DC1394.FEATURE_MODE_AUTO)
                    else
                        println("set $(feature.id) MANUAL")
                        set_mode(camera,feature.id,DC1394.FEATURE_MODE_MANUAL)
                    end
                end
            end
        end
    end
    f = Frame(control_panel)
    pack(f,side="top",expand=true,fill="both")
    b = Checkbutton(f,"Start Capture")
    b[:style]="Toolbutton"
    pack(b,side="right")
    bind(b,"command") do path
        if Tk.get_value(b)
            set_transmission(camera,DC1394.ON)
            capture_setup(camera)
        else
            destroy(imagecanvas.c)
            capture_stop(camera)
        end
    end
end
camera_list()

wait()
