Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0AF6568FF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Dec 2022 10:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiL0JoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Dec 2022 04:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiL0JoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2022 04:44:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDAA6467;
        Tue, 27 Dec 2022 01:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1672134220;
        bh=YTCy4JEIxOF81L2tkx2q9iUbicPXUbuTb5BUmkJ6Svk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Wh5879NVfovwfw6MPcWgTOF9m3eH52aFbDRk39uA3E/Ad8jO78miYBrYzLlJF5pMU
         Z/UdSo+F+IVHBl4CwgqCHGrr01zACXS6fv/QbFvG3momTUWkqdfdyx4si1efPaw9MC
         DnEq8H1/ZSxxSyssbOlQHKPaHX8WdiEWupzDlpgm4ZZQ+SxdbRBsvVZhRNQmcgY67N
         xFlyatiBM4/v74Klw4ZNdSwdnBDXnT37cPlmpvRc73Y/LndBRfGihBJq1CUwRf9wde
         pTg0E8Vuf68U2J6P9402diqrE70zLoUY26yyzQTnLuVbKBg+9Fn6nwrBGwG/sPwzES
         YeJJ13pXhrFBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.153.252] ([217.61.153.252]) by web-mail.gmx.net
 (3c-app-gmx-bap27.server.lan [172.19.172.97]) (via HTTP); Tue, 27 Dec 2022
 10:43:40 +0100
MIME-Version: 1.0
Message-ID: <trinity-256904b6-bbb5-4424-9686-50ec7fa14f26-1672134220733@3c-app-gmx-bap27>
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
Date:   Tue, 27 Dec 2022 10:43:40 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <Y6dMWFy7gChG88j0@makrotopia.org>
References: <20221127114142.156573-1-linux@fw-web.de>
 <20221127114142.156573-9-linux@fw-web.de> <Y6dMWFy7gChG88j0@makrotopia.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:bFXzqV914PcH77ozsLVgYaS5I0Vqyn3RZhEoaWQjT7lE8jUeDSGhl7uuTVF9Ur9aotjQ0
 kJ2zzC2KY87PZVu/kmymoEKe35/OcBtOMhCh69+CaSU97Q9IEwbEKdPDdi/4klIWCuVChTeJcIkj
 hNsZM0Mk1Pfs9vpZZDPsUz9DoYXK9kS1qRfMMLvmCZPLC+4Lg7e58vZ42EilOMyj+xsYwdzqZSLK
 J90OlPs5STS14EAJX6MQoYcvaIcSTZQ03+8S8dvHZIAn5qg8LuC3GTwkABj7y/Yk0/0CSu38KfiW
 d4=
UI-OutboundReport: notjunk:1;M01:P0:6NV/Op75bNk=;g9hXBa/jc9i8FeIMnr5EwLzU8mP
 pXy4CNgfhS7gmAFE0ch8bzzVD4MlzuFhtB3o+MMaWTQLz2nPUUmFrJlFzSta1yOb8PU7iyKU5
 OXisXe7c1ZvK5X1CAp4UfhyKjzW9fMULB7hwrMdnb/k3+VUATHoTV3l7/KPVpqAfQSaURykhF
 ipfIzASaFOKmYQnmCBC4AxLKWd53ooLwStPuXeLKOtiPVevdUo3UEI4/lz+p8o2Y3X+vIROQE
 ZfoVuEA0iRmK4a1gWvKnGxv7qbNJEbKnLYNgUWgOjecdxhIFjw2KTSxk0mFMDYU5/YYSsU0aU
 F8+G0W5mOzeDcZqnvelHmfLFjoey6M+9dhZWnZ9o7zpEM1ejDSmLXKsqHtWgkKYxVZ7N2caG9
 m+XTEc/j83X71YCecqGZJmpw7AtbLBtSByXOOSYfdwiTNaCdNFjHsRwXNc4Ea05X+7gJWttRr
 YNN8cWsLINNoA4WR7SujssEI/iW28LJjQeLyStTd+lAy0S8v7LMBGUs0+UZCM5S5ehpMgXr/l
 N2640kTns3x2PLA1AqqpTsHmQquIryxs+UWYJuoGQDL9GtMIEtonpvMH6TYsssBBqC/WRSs7d
 9igluMBSsF/x+U/YR9n5VtcttsmzHP6mVawxBOuKxgmb8G1sP7dBKz2ibbPzZbzm0PyS/soEx
 uDGzKN7P9Cav1VO8e9MfFgLeX5/MGVD6BKkWKRiAlsCccIJqWZ4Cxh5ORwCRHwy51F/Gy3p28
 dV9CToPtm7wPOJ4yoFykebIIKFKlw7gZMlz4mt5nfUPlMGvHeqe0bv+dlcBNWpTUvT7c3yPer
 arRA4ipNplPCK3LO4coyP2Lgq/Y0w57gR5GD3RAHFdFdU=
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


> Gesendet: Samstag, 24. Dezember 2022 um 20:00 Uhr
> Von: "Daniel Golle" <daniel@makrotopia.org>

> > +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts

> > +&spi0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&spi_flash_pins>;
> > +	cs-gpios =3D <0>, <0>;
>
> I don't think those bogus cs-gpios here and for spi1 below are needed.

at first look it seems it is needed...as i get this trace with 6.2:

[    2.145931] pc : mtk_spi_can_dma+0x0/0x34
[    2.155212] lr : mtk_spi_interrupt+0x74/0x360

[    2.091801] mtk-spi 1100a000.spi: spi-mem transfer timeout
[    2.097310] spi-nor: probe of spi0.0 failed with error -110
[    2.102930] Unable to handle kernel read from unreadable memory at virt=
ual address 0000000000000010

but i get the same trace when reverting the cs-gpios change....seems somet=
hing is broken in 6.2-rc1

6.1 works without the bogus cs-gpios (and the mt7531 interrupt-change)...

have tried reverting this commit, but it does not fix the issue:

8330e9e8269b 2022-12-07 spi: spi-mtk-nor: Add recovery mechanism for dma r=
ead timeout

any idea without doing a bisect?

regards Frank

> > +	status =3D "okay";
> > +};
> > +
> > +&spi1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&spic_pins>;
> > +	cs-gpios =3D <0>, <0>;
> > +	status =3D "okay";
> > +};

