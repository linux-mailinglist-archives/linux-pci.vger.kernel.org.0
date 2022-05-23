Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000CB5318F2
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 22:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiEWTPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 15:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiEWTNn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 15:13:43 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAFE8CCE1
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 11:48:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p8so14449448pfh.8
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nLb+QNOlLrmnjGmbCc4cBD9THL8cLJijlBwsUv7Yj+0=;
        b=7q5AvmJyA6JKQ6Eu+mRPtBRXj8ayTLjjc9laEl3IAQTOcm4i31M11AK5e1B7dbrVdM
         Nt94/lVT3BU2QHlboFGFeeorycdJKl8SO8iA2SaZdsmnur/ybAIV8CXv0XDHCwPaxqHG
         UZlRT0kPYj8ZB17IVXyb10r8n0k05XD6hOgCA76N9lE/0v2W+o4ljzBe1gh53+fWoXmq
         Frs8s5GH6D6JCDhAyoN3sz13uUF0Y2AaMzc7mjELjw0jshHBJ2SPoyApA3oHIq2y1kde
         ZnGdvJvicByjfY27b4PYG4aonwmAjkHW5YxYECo/ZrGOIAb5/pKbc3GbS3RQtsZOdZIL
         qlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nLb+QNOlLrmnjGmbCc4cBD9THL8cLJijlBwsUv7Yj+0=;
        b=wELyLjigyXNfAwHLYfgOuHwT86LVzyeNUQkPh73n82siK04A4DD9+yMklERv/hs2rZ
         M8LWL0+96SyWvYm+ZQzz5VD1tUFVhC7OJPa5TYCemIuB4lLC1Vi6or2HKKsYvorJJq8p
         r8H+pvSVonvdDP+0ULgn37dRWPw0qLfM7zOSqHCkH/78MzJxZAcPOEsdv6GK7y6t7WU+
         Yb/pDsCRCawgBtfzfOQO1KAGVSFX8P2fSpPsewn+IiDpIBubfbZWBFXX/zTRdt2JYLxt
         PZb144UMI96LKJFOSv87zrYT82AG95t368seUUapErKfdsOWvMxBrOsg/NvMYRrQMWB0
         uxJg==
X-Gm-Message-State: AOAM531+UZQy9ikL0mQfmeOQ/5iR9DTRVHArvEaP9hgqSL42c2hZ/KYt
        WyZmZm6qQH++FEChtLYerdenj4lTV7tTotqAsbrEVQ==
X-Google-Smtp-Source: ABdhPJxXB2uf13Hv8DHZCFacAhqHSty8tb0o6r+b2jnBBbVZaOTV5CVnW5PRbnP4CQxq6Xy/u4U6jTIlMLcwL2hFeCQ=
X-Received: by 2002:a63:8a4c:0:b0:3fa:218c:5c12 with SMTP id
 y73-20020a638a4c000000b003fa218c5c12mr8020259pgd.115.1653331690719; Mon, 23
 May 2022 11:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
 <1646644054-24421-6-git-send-email-hongxing.zhu@nxp.com> <fc2c6ddbf55723ac4c0f366e5a6131afafe546aa.camel@pengutronix.de>
 <AS8PR04MB8676F9A410442049E3DCA1F68CF39@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676F9A410442049E3DCA1F68CF39@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 23 May 2022 11:47:59 -0700
Message-ID: <CAJ+vNU271mS78iC7qFnaF1owzTF6+DWEY7gYVAQNmwiQk2-H0w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm64: dts: imx8mp: add the iMX8MP PCIe support
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 17, 2022 at 10:00 PM Hongxing Zhu <hongxing.zhu@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Lucas Stach <l.stach@pengutronix.de>
> > Sent: 2022=E5=B9=B44=E6=9C=8815=E6=97=A5 5:03
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; p.zabel@pengutronix.de;
> > bhelgaas@google.com; lorenzo.pieralisi@arm.com; robh@kernel.org;
> > shawnguo@kernel.org; vkoul@kernel.org; alexander.stein@ew.tq-group.com
> > Cc: linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v2 5/7] arm64: dts: imx8mp: add the iMX8MP PCIe
> > support
> >
> > Am Montag, dem 07.03.2022 um 17:07 +0800 schrieb Richard Zhu:
> > > Add the i.MX8MP PCIe support.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 46
> > > ++++++++++++++++++++++-
> > >  1 file changed, 45 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > index b40a5646f205..e7b3d8029e34 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > @@ -5,6 +5,7 @@
> > >
> > >  #include <dt-bindings/clock/imx8mp-clock.h>
> > >  #include <dt-bindings/power/imx8mp-power.h>
> > > +#include <dt-bindings/reset/imx8mp-reset.h>
> > >  #include <dt-bindings/gpio/gpio.h>
> > >  #include <dt-bindings/input/input.h>
> > >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > @@ -375,7 +376,8 @@ iomuxc: pinctrl@30330000 {
> > >                     };
> > >
> > >                     gpr: iomuxc-gpr@30340000 {
> > > -                           compatible =3D "fsl,imx8mp-iomuxc-gpr", "=
syscon";
> > > +                           compatible =3D "fsl,imx8mp-iomuxc-gpr",
> > > +                                        "fsl,imx6q-iomuxc-gpr", "sys=
con";
> > >                             reg =3D <0x30340000 0x10000>;
> > >                     };
> > >
> > > @@ -965,6 +967,17 @@ aips4: bus@32c00000 {
> > >                     #size-cells =3D <1>;
> > >                     ranges;
> > >
> > > +                   pcie_phy: pcie-phy@32f00000 {
> > > +                           compatible =3D "fsl,imx8mp-pcie-phy";
> > > +                           reg =3D <0x32f00000 0x10000>;
> > > +                           resets =3D <&src IMX8MP_RESET_PCIEPHY>,
> > > +                                    <&src IMX8MP_RESET_PCIEPHY_PERST=
>;
> > > +                           reset-names =3D "pciephy", "perst";
> > > +                           power-domains =3D <&hsio_blk_ctrl
> > IMX8MP_HSIOBLK_PD_PCIE_PHY>;
> > > +                           #phy-cells =3D <0>;
> > > +                           status =3D "disabled";
> > > +                   };
> > > +
> > >                     hsio_blk_ctrl: blk-ctrl@32f10000 {
> > >                             compatible =3D "fsl,imx8mp-hsio-blk-ctrl"=
, "syscon";
> > >                             reg =3D <0x32f10000 0x24>;
> > > @@ -980,6 +993,37 @@ hsio_blk_ctrl: blk-ctrl@32f10000 {
> > >                     };
> > >             };
> > >
> > > +           pcie: pcie@33800000 {
> > > +                   compatible =3D "fsl,imx8mp-pcie";
> > > +                   reg =3D <0x33800000 0x400000>, <0x1ff00000 0x8000=
0>;
> > > +                   reg-names =3D "dbi", "config";
> > > +                   #address-cells =3D <3>;
> > > +                   #size-cells =3D <2>;
> > > +                   device_type =3D "pci";
> > > +                   bus-range =3D <0x00 0xff>;
> > > +                   ranges =3D  <0x81000000 0 0x00000000 0x1ff80000 0
> > 0x00010000 /* downstream I/O 64KB */
> > > +                              0x82000000 0 0x18000000 0x18000000 0
> > 0x07f00000>; /* non-prefetchable memory */
> > > +                   num-lanes =3D <1>;
> > > +                   num-viewport =3D <4>;
> > > +                   interrupts =3D <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> > > +                   interrupt-names =3D "msi";
> > > +                   #interrupt-cells =3D <1>;
> > > +                   interrupt-map-mask =3D <0 0 0 0x7>;
> > > +                   interrupt-map =3D <0 0 0 1 &gic GIC_SPI 126
> > IRQ_TYPE_LEVEL_HIGH>,
> > > +                                   <0 0 0 2 &gic GIC_SPI 125 IRQ_TYP=
E_LEVEL_HIGH>,
> > > +                                   <0 0 0 3 &gic GIC_SPI 124 IRQ_TYP=
E_LEVEL_HIGH>,
> > > +                                   <0 0 0 4 &gic GIC_SPI 123 IRQ_TYP=
E_LEVEL_HIGH>;
> > > +                   fsl,max-link-speed =3D <3>;
> >
> > I believe that imx6_pcie_start_link does not properly handle Gen3 speed=
s.
> Good caught.
> The according link_gen condition should be changed in driver too.
> Would be changed in next version.
> Thanks.
>
> Best Regards
> Richard Zhu
> >
> > Regards,
> > Lucas
> >
> > > +                   linux,pci-domain =3D <0>;
> > > +                   power-domains =3D <&hsio_blk_ctrl IMX8MP_HSIOBLK_=
PD_PCIE>;
> > > +                   resets =3D <&src IMX8MP_RESET_PCIE_CTRL_APPS_EN>,
> > > +                            <&src IMX8MP_RESET_PCIE_CTRL_APPS_TURNOF=
F>;
> > > +                   reset-names =3D "apps", "turnoff";
> > > +                   phys =3D <&pcie_phy>;
> > > +                   phy-names =3D "pcie-phy";
> > > +                   status =3D "disabled";
> > > +           };
> > > +
> > >             gpu3d: gpu@38000000 {
> > >                     compatible =3D "vivante,gc";
> > >                     reg =3D <0x38000000 0x8000>;
> >
>

Richard,

Do you have an updated series for IMX8MP PCIe yet? I believe
everything you were waiting on is now merged (blk-ctrl and
power-domain).

Best Regards,

Tim
