Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA48655CF3
	for <lists+linux-pci@lfdr.de>; Sun, 25 Dec 2022 12:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiLYLvD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Dec 2022 06:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYLvA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Dec 2022 06:51:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F81BA0;
        Sun, 25 Dec 2022 03:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1671968822;
        bh=cigTGUVAg3Yj9PBuOXrP7a8GktisvMkb4W/saccjwJQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ma/xkta6H/Vvu8O4rhc4uZyrSkGoLzcj0u3e+4+TsD4ecPjO4RdiTm8nzUIpHBg8t
         yODU1TLBIFTfdJLVBlQPzfNkaUw4INHVjuJ4gklf1gC+4NS7bQxFhZdLTJComCawxT
         FoNsX+YKxX2QusrfdnIZzotnf9ovGBKNZvqERLVsG8XKa+QpTP+3jnz5cduXBc6ZJb
         XDpzyAP8rRElSmXpRYqE6Flyu5JYhkA9jbHoa88IAt8F0oKr/i8WXIlnG/A1H+x37k
         jIamcERWlvttUqlamw9zawJZdLhlNurOM2MxVzlYyQE7NYgmOINTAzmtKMDzqbr6AT
         fINsT6KW8DG/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [157.180.225.172] ([157.180.225.172]) by web-mail.gmx.net
 (3c-app-gmx-bap38.server.lan [172.19.172.108]) (via HTTP); Sun, 25 Dec 2022
 12:47:02 +0100
MIME-Version: 1.0
Message-ID: <trinity-b51cbf64-8df3-4a0b-883a-dbb7443eb954-1671968822286@3c-app-gmx-bap38>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org
Subject: Aw: Re: [next v7 8/8] arm64: dts: mt7986: add Bananapi R3
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 25 Dec 2022 12:47:02 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <Y6dMWFy7gChG88j0@makrotopia.org>
References: <20221127114142.156573-1-linux@fw-web.de>
 <20221127114142.156573-9-linux@fw-web.de> <Y6dMWFy7gChG88j0@makrotopia.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:10CT/kHfUVpSwqOqwS7PiCBR0/UkRQWIuyHUPEIPBF4ZQybqHeav5erxkfhPt6CkPU6ev
 P2jwPeR/U1/CsU0cypsmIs4UKNmh6TMGRmE9N8BKS0TbhXVNMX4nifJlVBx0/sT+mC1DTHpe7Lm0
 ZWTvo5zBoXH7rzgei9CR+fXrJGdfl+LYJmaNbBJV9dJV3cfgTHqW/IWi9dXZWuu9PEWsGOdppoeX
 JFIMemszjkAeplliNJluXNK5PmagMPT+eXXsMkTHO3XWdQck6hJrq/ckQvChW3JNDndJB1bzqU4q
 GY=
UI-OutboundReport: notjunk:1;M01:P0:pwFcvI8EngI=;Xzb4kTlhYwuChZI1qpgA1uiBqPU
 0VRdCykSt9KTXu8yY9kmRrx7TUx5EFBj/CWBFLhFCAuUvqO+4VGvbUWKt0/ui4Stz591phL4x
 V6D2S/PlSOoK+x7PH/19JEuZKEr5cZZhv/LAaLdmWxmbQ6Ch8dMf/wUp1jZ/eXMG6DQ5sj46p
 EXO5bAt6xkRITCny9gY4QR1XL7ITdV97qUPfmQRubcACLurNRiTr1QjoIHgepkenO2tKABFEZ
 aJlUCiDQm5KNF8h4qRZgm+UrvL87097zlMkEmBYS0EhImEM4apgdFixunpgiN9VC0tE6hKIN0
 RulXsPDMfJyIbonqk8r0HLhEzVeqs6enS34vIqnFEbe8J51x8eU6Jg6NdGPFevExob8aDMeA5
 r4qRPKfr7LrlcIZgNnTPkmGZlLHG8op2cuELClFACNBxSYklDi61bGdcrGZ7zgWk3QN5sMjFd
 KlKgPUWpw5/2Ky/5xfMK3GT7p3vDoQsfCHWpotsshwNqzEVX7wneqQHwqgxD//E/bDFOw5OMa
 ok4obFcCNMkLzPS+ofYi4/P0dL4DeC2uH2WDbe3VoYjcV/6sH3jn/5XmyqldDIs+E5Djrt7LP
 QLVtrJzCxdBJwNbpDlCK6jlqsRSUyIk7Auv2qYiSoTNGfBqQuwpHW2LI5G2C0x3uOnx2kkzUP
 sFzbOVN9r/dTxS9JeWVf4mH3r5urzdXFrMvBaujgNVJ3jt6wvufj84Ejbe88doESaimya4+QF
 +jTNS8V4hj1DozC05FKDuBggiU2hqUxx5Q6lGPoMFa94cU4cBp5hYxx4dU5WsG6eYssc0MUJe
 v7pKBoXRZTACH/SOAAOVa4uzu3j406KqJjqu430gP7Hiw=
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

> Gesendet: Samstag, 24. Dezember 2022 um 20:00 Uhr
> Von: "Daniel Golle" <daniel@makrotopia.org>

> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dtso
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2021 MediaTek Inc.
> > + * Author: Sam.Shih <sam.shih@mediatek.com>
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +/ {
> > +	compatible =3D "bananapi,bpi-r3", "mediatek,mt7986a";
> > +	model =3D "Bananapi BPI-R3 (emmc)";
>
> Why do you set the model string here?

seems to be a left over from testing where i wanted to see which base-dtb =
was
loaded without comparing mmc-node settings. Was easier to see with model-s=
tring :)

> > +
> > +	fragment@0 {
> > +		target-path =3D "/soc/mmc@11230000";
> > +		__overlay__ {
> > +			bus-width =3D <8>;
> > +			max-frequency =3D <200000000>;
> > +			cap-mmc-highspeed;
> > +			mmc-hs200-1_8v;
> > +			mmc-hs400-1_8v;
> > +			hs400-ds-delay =3D <0x14014>;
> > +			non-removable;
> > +			no-sd;
> > +			no-sdio;
> > +			status =3D "okay";
> > +		};
> > +	};
> > +};

> > diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts =
b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> > new file mode 100644
> > index 000000000000..618d3bb2f32f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts

> > +&mdio {
> > +	switch: switch@31 {
> > +		compatible =3D "mediatek,mt7531";
> > +		reg =3D <31>;
> > +		reset-gpios =3D <&pio 5 GPIO_ACTIVE_HIGH>;
>
> Please add:
>
>                 interrupt-controller;
>                 #interrupt-cells =3D <1>;
>                 interrupt-parent =3D <&pio>;
>                 interrupts =3D <66 IRQ_TYPE_LEVEL_HIGH>;
>
> to have IRQ driven phy status instead of having to poll the link status
> of the 5x rj-45 ports.
> The value comes from schematics (pin AD24, GPIO66, 7531_INT) and I've
> tested this on my board.

ok, if you have it tested i add these properties in next version (and test=
 it too).
I wait for tphy-binding to be applied to next (pcie and xhci already in to=
rvalds/master).

> > +	};
> > +};
> > +

> > +&spi0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&spi_flash_pins>;
> > +	cs-gpios =3D <0>, <0>;
>
> I don't think those bogus cs-gpios here and for spi1 below are needed.

can drop them in next version

> > +	status =3D "okay";
> > +};
> > +
> > +&spi1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&spic_pins>;
> > +	cs-gpios =3D <0>, <0>;
> > +	status =3D "okay";
> > +};
> > +

regards Frank
