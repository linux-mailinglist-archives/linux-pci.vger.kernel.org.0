Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345EC630354
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 00:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiKRX2S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 18:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiKRX1l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 18:27:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF02BEB55;
        Fri, 18 Nov 2022 15:15:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F468B825A6;
        Fri, 18 Nov 2022 23:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4275BC43146;
        Fri, 18 Nov 2022 23:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668813326;
        bh=WZ8PKekF+dncjbvSjEZDmCUz4Gtb/LLsdxmayfMcHhY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uUiNErb6Tgnfb5oEusUI+JFCYQV1AQQE05w7FhzIsK2QfXqv5WsrIBGnaJv18JYvC
         US6ufr5tGWw4TNPSFjoVvPs7U73mqwT1Iif0fsS9HXuEbFaQoIp9RziFSIfk2BPtoE
         8l5WjmxXsF7+ApkuRNUWknyBnVBp4pvUXVu8CxIOSuojIfmmxBescMXFY6IZVe1blp
         AJJ8nA9+lDruS2WhwLVsVCcGwMAA7v822zB/DmdeFXNSPcHARY4PQoJnUkiOA7XuZE
         ddwQAvFkqqhmpHMN9HEF3cuyJhmo7NkpzDNBR0yjGLXO1VC2dp/SMfJS5h2xPCjZfo
         8tIBa4wckr4xg==
Received: by mail-lf1-f52.google.com with SMTP id bp15so10541638lfb.13;
        Fri, 18 Nov 2022 15:15:26 -0800 (PST)
X-Gm-Message-State: ANoB5pk03BMWnt68Eu6iKHesJ7pILzzmNNtc8Ev2I1DvHdIKt6CiRULP
        YenaMt0ae2YeAgbs2Xp5S0OYCuxAn+mjCaVZoQ==
X-Google-Smtp-Source: AA0mqf7ny5ZctZuI1Cpiin0JrEQILuNcodrW4ZzJpLZW7EwRw7CspieqMwRy4PVq7H6JZQt+lTyd0ysP9CVMaXrkZpU=
X-Received: by 2002:ac2:442f:0:b0:4a2:8d76:abaa with SMTP id
 w15-20020ac2442f000000b004a28d76abaamr3212413lfl.74.1668813323939; Fri, 18
 Nov 2022 15:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20221118190126.100895-1-linux@fw-web.de> <20221118190126.100895-12-linux@fw-web.de>
 <CAL_JsqKiRzRToSzk3q+csWR5DEZjZpQWChqZ3mH8MLruvfe=Dw@mail.gmail.com> <99114D73-22EF-43CD-848E-88A37B29B953@public-files.de>
In-Reply-To: <99114D73-22EF-43CD-848E-88A37B29B953@public-files.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Nov 2022 08:45:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKz1qQFZnStLnApraJvp=-cQoW6x5=p7-GBcftYKVMErg@mail.gmail.com>
Message-ID: <CAL_JsqKz1qQFZnStLnApraJvp=-cQoW6x5=p7-GBcftYKVMErg@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] arm64: dts: mt7986: add BPI-R3 nand/nor overlays
To:     frank-w@public-files.de
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 18, 2022 at 4:05 PM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> Am 18. November 2022 22:39:52 MEZ schrieb Rob Herring <robh+dt@kernel.org>:
> >On Fri, Nov 18, 2022 at 1:01 PM Frank Wunderlich <linux@fw-web.de> wrote:
> >>
> >> From: Frank Wunderlich <frank-w@public-files.de>
> >>
> >> Add devicetree overlays for using nand and nor on BPI-R3.
> >
> >Can you not tell at runtime which one you booted from? If not, how
> >does one choose which overlay to apply? If you can, why not populate
> >both nodes and enable the right one? IMO, if all h/w is present, it
> >should all be in the DT. Selecting what h/w to use is a separate
> >problem and overlays aren't a great solution for that.
>
> It is not the decision about bootdevice,more available devices.
>
> Only 1 spi device (nand OR nor) is available
> at boottime as they share same spi bus and
> chipselect is set via hw jumper.
> Both nodes have reg 0,which is imho not
> supported in linux.

As long as one is set to disabled, it should be fine.


> I choosed overlays to add the right spi
> device on the right mmc device where
> similar selection happens (see patch 10).
> Either sd OR emmc can be used (1 mmc
> controller,first 4bits from bus switched by
> hardware jumper).But for mmc i use it as
> base fdt because i see mmc as primary
> device which holds rootfs too. Nand/nor is
> imho helping device for accessing emmc or
> like rescue system (only uboot).

No way to read the jumper state or know what you booted from I gues?

> I probe in uboot if emmc is available (mmc
>  partconf) and choose emmc else sd. For
>  spi i try with sf command to check for nor,if
>  this does not work i apply nand overlay.

Instead of applying overlays, wouldn't just changing 'status' be easier?

>
> >> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> >> ---
> >> maybe rename to dtso?
> >>
> >> "kbuild: Allow DTB overlays to built from .dtso named source files"
> >> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=363547d2191cbc32ca954ba75d72908712398ff2
>
> Should i do this?

Yes. .dts -> .dtbo is going to be removed.

> >> more comments about the dt overlay-support:
> >>
> >> https://patchwork.kernel.org/comment/25092116/
> >> https://patchwork.kernel.org/comment/25085681/
>
> Daniel suggest define sd/emmc as overlay too...with way you mention below we could create 4 full fdt without applying overlays in uboot.

Yes, but if you are going to do that, then you can just do all this
with includes.

> >> --- a/arch/arm64/boot/dts/mediatek/Makefile
> >> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> >> @@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
> >>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> >>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
> >>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtb
> >> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
> >> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
> >
> >These need rules to apply them to the base dtb(s). You just need:
> >
> >full.dtb := base.dtb overlay.dtb
> >dtb-y += full.dtb
>
> I would prefer to do this in bootloader to allow all 4 possible configurations:
>
> Sd+nand
> Sd+nor
> Emmc+nand
> Emmc+nor

That's fine. The purpose here is to document what the overlays apply
to, check that they actually apply, and validate them when applied
(unless someone wants to figure out all the issues with validating
just an overlay and make that work). You for example have an
undocumented compatible in yours (denx,fit).

Rob
