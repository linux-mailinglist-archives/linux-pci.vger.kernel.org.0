Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D039763153D
	for <lists+linux-pci@lfdr.de>; Sun, 20 Nov 2022 17:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKTQsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 11:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKTQsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 11:48:11 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A2E13E1E;
        Sun, 20 Nov 2022 08:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1668962851;
        bh=kN1ix6DsnqlIaJ1DQdtXu0RkNkA/M6KneNeTlPLILwE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PPdIHlbYixoLxy7bio1Yjdp8DmVQGA2yqZJ8QB7XZOhOwkDuimMD7tMmy9N859IQC
         DpXE4fLZK5p8am2giDU0usoeVBqL97j1ZmSif0bfDGVx9VZnbs70Yjg0yEcv5hjSzE
         9IfosZl4Z3RR1lgR3EwyicBHNaIAdbnYin7N8Myw5p94xWL+oQ1YKm6AVh+c9cYomp
         jjBcivN+fwLRZalKgwyrZnyYBnRJIrGsAUc3FGaQSgoMmmXLOJrirINGmqKjr2ixyc
         MsQb8vJUAuK0noJm29Alevzqtn0t5JJ/f1nHxm/x4xKV4eaOBhcWLKZSK9t32enVdf
         FBcbL7/UJtuBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.78.132] ([80.245.78.132]) by web-mail.gmx.net
 (3c-app-gmx-bs53.server.lan [172.19.170.137]) (via HTTP); Sun, 20 Nov 2022
 17:47:31 +0100
MIME-Version: 1.0
Message-ID: <trinity-173fe7db-fa76-43c0-ac05-f30b26fe763a-1668962851364@3c-app-gmx-bs53>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh@kernel.org>, Daniel Golle <daniel@makrotopia.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Aw: Re: [PATCH v6 11/11] arm64: dts: mt7986: add BPI-R3 nand/nor
 overlays
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 20 Nov 2022 17:47:31 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20221120161251.GA3133853-robh@kernel.org>
References: <20221118190126.100895-1-linux@fw-web.de>
 <20221118190126.100895-12-linux@fw-web.de>
 <CAL_JsqKiRzRToSzk3q+csWR5DEZjZpQWChqZ3mH8MLruvfe=Dw@mail.gmail.com>
 <99114D73-22EF-43CD-848E-88A37B29B953@public-files.de>
 <CAL_JsqKz1qQFZnStLnApraJvp=-cQoW6x5=p7-GBcftYKVMErg@mail.gmail.com>
 <192D4414-DC88-4321-BB2A-4345C48E3C12@fw-web.de>
 <20221120161251.GA3133853-robh@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:C7xJd2hzPN9fyMTUXsj8PYqDg4YzTaRB/7S5nxyzaLv4uA0E1gEhdMDdksdqVpn+VUfJj
 GDZKxU20mADzmc/XyHrg5mbPyipbNd11BmoGm86B/Co5GiSEmXzCpBCevNY2Y3TJW1i0OnIjNsY0
 knJi3WzV2IShfSEkyRmIoFpfLT9rGen7JpeNz9Sv3BwC48MqIj760wHBx+ajTXEfC+9U6IMOtU4G
 dwJGN4cWNt2I3YgHUMBuNg6KZwfB9IWL0irt7lEjnivUBa7xNKIy19Vbn0kw5Ill0rejRvE/+CuQ
 TY=
UI-OutboundReport: notjunk:1;M01:P0:jDG5B94+XiE=;BtwYU38VBQ3E6C6jO8fJOaIThMS
 XZiYy1LXpzIVrbaIodm0Rt/x1t3iUNGICq8jTc5pgLBuUcn+Zwc1AAF3/3nCWpQuaL7GH98ow
 FuU1mbwf5/1Icu0hZgBntUbg2VsewCxV9MTjwYm44T+ZvbQU2627SsrJ75Uw/Ah32ZMGWmTdW
 7X0Bd9cov19WZcHT4scXMoFUCuWPYqt0i1fzgBPG1DohL+HSaQjnvmTcIIWpQLy/jcZtRPRfs
 O+ps+9P4DzXYPyMza0zyFScdyvv03jxTsVc6dwvGyww7wVYawEqdCDjYszU6ngjHKKKKbL9W2
 3n8KMV8917ir/J84OnMZct+g/n4cECtNjr1FqOi5aPA5daK5Vmk4UxfR26aaQ+q3DxvHcmgbi
 CGDid5vVEm8xZZq4DI+e8cZgoed3Vo3mzNlZunJakNLFppzcnOtRloLVFhzIGaklVGfND2Oox
 TKQPZ53a4VV9H89uQMRpXGVyvbAPTe3nv26GQei4j6HzUDKMw+pFFh/8lJPPPF3Om7J1aH2yP
 liz/R2GCBEnoNCHQrQ0XI3zHjorgPcBBpVsxXjdyhU68T6ZH0C5DYGeZAP/bkF2Gc91171IHI
 857iqo5BgQlfGc/ih77VbOF3M43wKAZG7Ds8/EbwXivy4oZEyNVprZmsDHvmcRffc90v7rtWG
 Jt687iBQ9qwNB0Ys6Zuqk+LV5BcU1/e43D6300ThdPYHeeSEdGfGj1BhU3/HMgwgjYUHKdgo9
 lbUVyRfZ+oUwcMU5FmQg5fcP74lJC/6rbEIEGLQAfq/NXPuessD6fJ7b0YziGM0IVaBkTi6MU
 V1kASQBLsUwWoAGm6CHvr9wA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

> Gesendet: Sonntag, 20. November 2022 um 17:12 Uhr
> Von: "Rob Herring" <robh@kernel.org>
> On Sat, Nov 19, 2022 at 08:19:52AM +0100, Frank Wunderlich wrote:
> > Am 8. November 2022 15:45:49 MEZ schrieb Rob Herring <robh+dt@kernel.o=
rg>:
> > >On Fri, Nov 18, 2022 at 4:05 PM Frank Wunderlich
> > ><frank-w@public-files.de> wrote:
> > >>
> > >> Am 18. November 2022 22:39:52 MEZ schrieb Rob Herring <robh+dt@kern=
el.org>:
> > >> >On Fri, Nov 18, 2022 at 1:01 PM Frank Wunderlich <linux@fw-web.de>=
 wrote:
> > >> >>
> > >> >> From: Frank Wunderlich <frank-w@public-files.de>
> > >> >>
> > >> >> Add devicetree overlays for using nand and nor on BPI-R3.
> > >> >
> > >> >Can you not tell at runtime which one you booted from? If not, how
> > >> >does one choose which overlay to apply? If you can, why not popula=
te
> > >> >both nodes and enable the right one? IMO, if all h/w is present, i=
t
> > >> >should all be in the DT. Selecting what h/w to use is a separate
> > >> >problem and overlays aren't a great solution for that.
> > >>
> > >> It is not the decision about bootdevice,more available devices.
> > >>
> > >> Only 1 spi device (nand OR nor) is available
> > >> at boottime as they share same spi bus and
> > >> chipselect is set via hw jumper.
> > >> Both nodes have reg 0,which is imho not
> > >> supported in linux.
> > >
> > >As long as one is set to disabled, it should be fine.
> > >
> > >
> > >> I choosed overlays to add the right spi
> > >> device on the right mmc device where
> > >> similar selection happens (see patch 10).
> > >> Either sd OR emmc can be used (1 mmc
> > >> controller,first 4bits from bus switched by
> > >> hardware jumper).But for mmc i use it as
> > >> base fdt because i see mmc as primary
> > >> device which holds rootfs too. Nand/nor is
> > >> imho helping device for accessing emmc or
> > >> like rescue system (only uboot).
> > >
> > >No way to read the jumper state or know what you booted from I gues?
> > >
> > >> I probe in uboot if emmc is available (mmc
> > >>  partconf) and choose emmc else sd. For
> > >>  spi i try with sf command to check for nor,if
> > >>  this does not work i apply nand overlay.
> > >
> > >Instead of applying overlays, wouldn't just changing 'status' be easi=
er?
> >
> > It will be easier,but requires dts for all
> >  combinations,we have have sd/emmc
> >  combination twice (once for nand
> >  enabling,once for nor) and we have then 4
> >  full dts instead of smaller overlays in fit.
>
> No, I mean can't you have 1 dtb with everything, but nand, nor, emmc,
> and sd are all disabled. Then at boot change 'status' for what's
> enabled.

at least for sd/emmc: no, as they share same mmc-node with different setti=
ngs (bus-width,speed,...).

for nand/nor i'm not sure if spi can have 2 childs with same unit-address/=
reg even if disabled.
Then i do not know how to enable a dts-node in uboot...only know (not long=
 time) how to apply overlay ;)

> > So i should add spi subnodes both disabled
> >  in base dtsi and create 4 dts (sd-nand,sd-nor,emmc-nand,emmc-nor) wit=
h
> >  mmc node and enabling the right spi node?
> > >>
> > >> >> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > >> >> ---
> > >> >> maybe rename to dtso?
> > >> >>
> > >> >> "kbuild: Allow DTB overlays to built from .dtso named source fil=
es"
> > >> >> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/c=
ommit/?h=3Ddt/next&id=3D363547d2191cbc32ca954ba75d72908712398ff2
> > >>
> > >> Should i do this?
> > >
> > >Yes. .dts -> .dtbo is going to be removed.
> >
> > Do this if still using overlays,will test new way.
> >
> > Maybe we can apply parts 1-9 first?
>
> Sure.

i would wait for them applied before posting next version, i hope they can=
 go into 6.2. Then it is easier because depencies are all in.

overlay was only for discussion the right way...my preferred way was mmc i=
n board dts and spi as overlay,
daniel preferred base fdt without them all and 4 overlays. another way alr=
eady discussed were 4 full fdt, but
how to get all 4 combinations with less files and not defining mmc/spi dev=
ice twice? i see only the overlay
version and combining via Makefile.

what is your preferred way (except all devices in 1 dts which is afair not=
 possible, daniel please correct me if
i'm wrong)?

> >
> > >> >> more comments about the dt overlay-support:
> > >> >>
> > >> >> https://patchwork.kernel.org/comment/25092116/
> > >> >> https://patchwork.kernel.org/comment/25085681/
> > >>
> > >> Daniel suggest define sd/emmc as overlay too...with way you mention=
 below we could create 4 full fdt without applying overlays in uboot.
> > >
> > >Yes, but if you are going to do that, then you can just do all this
> > >with includes.
> >
> > This is a third way if i understand correctly
> >
> > Make all of them as overlay (dtso?) but
> >  build dtb by combining them in makefile.
> >
> > This looks the best way because it avoids
> >  redundand code for mmc node and allows
> >  my current spi config (not the status way
> >  which may break due to same unit address).
> >
> > I guess my base dtsi is then a dts too?
>
> Yes, it can be.
>
> >
> > Or should these overlays only duplicated and either include sd dts or =
emmc dts (but this creates again redundant code)?
> > >> >> --- a/arch/arm64/boot/dts/mediatek/Makefile
> > >> >> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > >> >> @@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-x20-dev.=
dtb
> > >> >>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-rfb1.dtb
> > >> >>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-bananapi-bpi-r64.dtb
> > >> >>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc.d=
tb
> > >> >> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nand.d=
tbo
> > >> >> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nor.dt=
bo
> > >> >
> > >> >These need rules to apply them to the base dtb(s). You just need:
> > >> >
> > >> >full.dtb :=3D base.dtb overlay.dtb
> > >> >dtb-y +=3D full.dtb
> > >>
> > >> I would prefer to do this in bootloader to allow all 4 possible con=
figurations:
> > >>
> > >> Sd+nand
> > >> Sd+nor
> > >> Emmc+nand
> > >> Emmc+nor
> > >
> > >That's fine. The purpose here is to document what the overlays apply
> > >to, check that they actually apply, and validate them when applied
> > >(unless someone wants to figure out all the issues with validating
> > >just an overlay and make that work). You for example have an
> > >undocumented compatible in yours (denx,fit).
> >
> > Oh,need to check,copied partitions from my
> >  uboot dts...maybe there is a linux version
> >  for marking it as fit partition,else i drop
> >  completely.
>
> You just need to document it. But the first thing I'm going to say, is
> 'u-boot' is the vendor, not 'denx'. So 'u-boot,fit'.

imho it is not needed in linux, so i drop it.

regards Frank
