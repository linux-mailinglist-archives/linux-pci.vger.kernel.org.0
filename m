Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE71A62F9F9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 17:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241741AbiKRQNy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 11:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiKRQNv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 11:13:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548F0657EB;
        Fri, 18 Nov 2022 08:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1668788003;
        bh=uNoPoaQqsCt3VB34ViP+juUR5EdI/2W4QHKFds0rL6w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hY8tQ6CNTTJC+x1cb7eDcgorID2yCPG1M5c4N0Pie0wg/7HMdCXE4WDJUO9znrn2T
         WlCARUm9sEejFEczneQ40EisfjlkQLikKcMsSoUxFoq5pdJ+wWdfONCFfETLVnQema
         XLQQQo4Pd0P6C4F+H32YffH0CfFzgmlkME+xuZ176eJdkmRh1lvjhdGVCCX74bcdqs
         1wc7FF5VBLCKQ4K/6nz4dtdA3kRWCivzLRaF/A5YNfqY8Tgevtw8+YRDgT6cuBDc9v
         HzW0iQyNUPTFtio3XxMYlKgfKq7A4v2WYuEnZs8yV2JTrl5Fm9VvKCWhgGXT4TNRP6
         a+Sngah0EG/Hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.77.125] ([80.245.77.125]) by web-mail.gmx.net
 (3c-app-gmx-bs01.server.lan [172.19.170.50]) (via HTTP); Fri, 18 Nov 2022
 17:13:22 +0100
MIME-Version: 1.0
Message-ID: <trinity-923a3ba9-8956-490e-9e4a-0dc4ff59aba5-1668788002736@3c-app-gmx-bs01>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     =?UTF-8?Q?Chunfeng_Yun_=28=E4=BA=91=E6=98=A5=E5=B3=B0=29?= 
        <Chunfeng.Yun@mediatek.com>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux@fw-web.de" <linux@fw-web.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        =?UTF-8?Q?Sam_Shih_=28=E5=8F=B2=E7=A2=A9=E4=B8=89=29?= 
        <Sam.Shih@mediatek.com>, "kishon@ti.com" <kishon@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        =?UTF-8?Q?Jianjun_Wang_=28=E7=8E=8B=E5=BB=BA=E5=86=9B=29?= 
        <Jianjun.Wang@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        =?UTF-8?Q?Bo_Jiao_=28=E7=84=A6=E6=B3=A2=29?= <Bo.Jiao@mediatek.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Aw: Re: [PATCH v5 07/11] arm64: dts: mt7986: add usb related device
 nodes
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 18 Nov 2022 17:13:22 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <6417076e019640b23fff85e27798b277c74eeb74.camel@mediatek.com>
References: <20221117162728.20608-1-linux@fw-web.de>
 <20221117162728.20608-8-linux@fw-web.de>
 <6417076e019640b23fff85e27798b277c74eeb74.camel@mediatek.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:HYGMb/xYz+XeZpM3XpDKsxgdGc8ewqlZVEcSbPVlQwkmfScvHH2RpSAexRIVX40RRQW9r
 3pALC9qSqnC8awb8gvvin71249NFff0BFoJeO9TvalmQr02KVaF0++xTTsArljvYBYoCqLPZuTZK
 8daI4anoIVL1aPxDipKLCD9KDXfKpGEIwIBx9RNSy+Pa4E03uA5M76bozqEnWWb4/omyYJsS75k3
 0VTpzQyYvkxhjAtMwX2f2fqjgVHKukLUKgXyER9Jh5tDwN/PHpnXs22d0OBM7o35hFZyUPDWilA+
 eg=
UI-OutboundReport: notjunk:1;M01:P0:gwvebTmYFlo=;HK+XyCP7s+prHXZyAzTEO+vkRgf
 yRjlVD4aEyd3O/vVQzvVscZQBDlD5IP5gc39H9LNhVF1PAa4Oi9zAFC920tYDRwayFi+mIv2W
 l6gFf8GhywPm0Pm0ZfK9pzZNGZjy22wciu3nXga8V9NMtKVumPHAT5v0W4IpY0dRz1krzP5Gg
 qbq3Uram4uEGdcCh+p+s775RshRXAp/btPkYXZHbex1qPUD5qQBQXWXLlKtHcFFNtPjZ7JX30
 qeZs7NObqS8dc8d/duY7ApDlNLxJqfuUVAC9MFs51CnsbMXz9LPiJ7X9LWJSWzGjd7p/Rzf6U
 94OjCWkPlI76EEOmo1LIhqGu8yehTdemGzEEnUfbelsSIvkocTEl7T6uSiW2ZfeFm5rI+ZpG2
 FCcaDM/ojIgD5ZDyphVqahPaBlviPwMTIALDTZUhsq1eTeCtWtdDM7NVxjYB7PWUXL4Cfo0/G
 reM4XXKH5zO1LGLQSFHZKti5ukMY+GY6bEuB8UfEjHmkBp8WVBadc4azhIPD09JtIOsqQXJ2t
 vNe/0hphKteHYmm1kEL3fjjqknDhgVuoeYsZg53hitIcRJJHOK3Ck1eXFNGRjD+WdXpAFUhfX
 QPd73TUB/yP8hk/jLtafiIkn9fk2OLNzBqVfnpIHINw7/EC3K3tUs7GozMUH7pwMJx7OAKPl2
 IBXAnWjpYtzT7SQRmFJ10d+IdoAV1tykIXfI7brBlRmHiIttqzvMWDNUdrPksv2qPoGrWieoi
 mZs1Tkn4z/rQ9PA3hHkhxyF2Nc47LivgIktlosjIa+DUt+M9ym4KQFsOSS/ljKEAa1whrbtmk
 e+kxfbJmfKZXeV0oZxvVsQvI8zcGM29/6n6NlxvJul5Vw=
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

> Gesendet: Freitag, 18=2E November 2022 um 07:43 Uhr
> Von: "Chunfeng Yun (=E4=BA=91=E6=98=A5=E5=B3=B0)" <Chunfeng=2EYun@mediat=
ek=2Ecom>
> On Thu, 2022-11-17 at 17:27 +0100, Frank Wunderlich wrote:
> > From: Sam Shih <sam=2Eshih@mediatek=2Ecom>
> >=20
> > This patch adds USB support for MT7986=2E
> >=20
> > Signed-off-by: Sam Shih <sam=2Eshih@mediatek=2Ecom>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
> > ---
> > changes compared to sams original version:
> > - reorder xhci-clocks based on yaml binding
> >=20
> > v5:
> >  - update ranges/reg of usb-phy
> >  - not added RB from AngeloGioacchino for v4 because of these changes

> > diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb=2Edts
> > b/arch/arm64/boot/dts/mediatek/mt7986a-rfb=2Edts
> > index 006878e3f2b2=2E=2E2b5d7ea31b4d 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb=2Edts
> > +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb=2Edts
> > @@ -23,6 +23,24 @@ memory@40000000 {
> >  		device_type =3D "memory";
> >  		reg =3D <0 0x40000000 0 0x40000000>;
> >  	};
> > +
> > +	reg_3p3v: regulator-3p3v {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "fixed-3=2E3V";
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> > +
> > +	reg_5v: regulator-5v {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "fixed-5V";
> > +		regulator-min-microvolt =3D <5000000>;
> > +		regulator-max-microvolt =3D <5000000>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> >  };
> Usually if we use a gpio to control a switch to turn on/off power, we
> model it as a fixed regulator, but here no gpio provided in reg_3p3v
> and reg_5v, if no gpio used, no need these two fixed regulators too=2E

i can drop 5v regulator, but 3v3 is used by emmc, so i would move that to =
the mmc-patch

> > =20
> >  &crypto {
> > @@ -140,6 +158,12 @@ &spi1 {
> >  	status =3D "okay";
> >  };
> > =20
> > +&ssusb {
> > +	vusb33-supply =3D <&reg_3p3v>;
> > +	vbus-supply =3D <&reg_5v>;
> These two supply can be removed if no swith to control them, they are
> optional=2E

ok, i drop the references=2E

anything else ok?

prepared patch here (now yet squashed):
https://github=2Ecom/frank-w/BPI-R2-4=2E14/commits/6=2E1-r3dts

regards Frank
