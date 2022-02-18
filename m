Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995894BC25B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 22:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbiBRVyP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 16:54:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiBRVyO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 16:54:14 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7AB53B61;
        Fri, 18 Feb 2022 13:53:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d10so17883061eje.10;
        Fri, 18 Feb 2022 13:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FWjdBe+0iGvT17Rwh8+jH620QfW830WBiVyztTPJiZ4=;
        b=cuJQ0U/C5XgQav95flETsO4jqW2/uNxp6h5ICO0we+V6X/hIWc76b2/nP3HBNIo622
         9iEjeXPglvTjn8DRMW/M8Sg34xvRO9lxJJ0gxMe7LitkhgmEQ9Aur1chH4I+mLgMEl7U
         iZ1ZJbTspcYz03LIe0DT0BdKkOCbytJvurVhXiHTB+/hGeNc4GduB6IosQHTUEr4ZtSl
         QHXMmckdzT/J6Be9rKfJPucKeU6dvBy/jHgPmkMradZexEk0FzkC1HAYdJEKUIJOFMS3
         oB83vDNlcJKdjAeWcukBt6BjKNDX9i+IURZghm/ss3F6DFYLAT25XbNnlgqlzIGZDUsT
         AVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FWjdBe+0iGvT17Rwh8+jH620QfW830WBiVyztTPJiZ4=;
        b=lacZoBw05pYKJQzQhdW8nVrkZlLWrYDQTW73psZIQTO04mHmLOWlj7m0xMSWcB2/GJ
         yq5bpXKBgoWRWakaOjFKOkgHysjsKijmxnQhDRdxMopw63n/1p2iUlrz9mOd9qsy2XVz
         ORSIwddtEUVa6aZgpwDkpsixQPn1nZS6iyUwLTEg0lHYTPu37fAO605JWitEJL5j7nkM
         z4ezUded1TortdlRzzIMObSW5YSbvt6IxzIdypeyK+wDYHdmreihnRUfy6Q2X/QkRcyX
         PgUviuecawE+U5lm42wTpCWFLz2MBJehx16nDzP1gtW3AaN++NoKevL5PDVUIy/cUZCE
         TWrw==
X-Gm-Message-State: AOAM531CE4yvPgxpvRiC2NCWWUVAFnlLzfknUuQ2vYkmjrzOM/MqywWI
        zKd6R9vi34cpqARB3TOMDoZ+G0vj9dF6AaVRe3s=
X-Google-Smtp-Source: ABdhPJxTYk1PuoLsKrkmYSnq/p7pVMta5oAECeyrazqKqG1PmTQ0ULGxXm/IXzsyeVcQAaqxnu7qPX3Oa8lysB45NM8=
X-Received: by 2002:a17:906:5f89:b0:6d0:226c:628d with SMTP id
 a9-20020a1709065f8900b006d0226c628dmr7974725eju.646.1645221234740; Fri, 18
 Feb 2022 13:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20220105150239.9628-1-pali@kernel.org> <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-12-pali@kernel.org> <87wnhxjxlq.fsf@BL-laptop>
 <20220214150923.a5ttxoh426cfxn4v@pali> <87tud1jwpr.fsf@BL-laptop>
 <CAEzXK1qYKVk7QiSY_DwqkZ7WV6WU06WBtiqZx0JJCc+mOP-7Kg@mail.gmail.com>
 <CAEzXK1rj7pOvJgAMd11TJVqzgWD2GSJ-25_BWL7X9wiZWOhieQ@mail.gmail.com> <20220215105214.f5biuptsruoredqi@pali>
In-Reply-To: <20220215105214.f5biuptsruoredqi@pali>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Fri, 18 Feb 2022 21:53:43 +0000
Message-ID: <CAEzXK1qbv+cuRqoNh9_JQK=ViDtO9a+2S9sRMr-o4dUvRnn4Uw@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ARM: dts: armada-385.dtsi: Add definitions for
 PCIe legacy INTx interrupts
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Successfully tested on my custom A388 system with two PCI express slots.

If you wish you can add a:
Tested-by: Luis Mendes <luis.p.mendes@gmail.com>

On Tue, Feb 15, 2022 at 10:52 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello! armada-388.dtsi file has #include "armada-385.dtsi" line and
> therefore is already covered by this my patch.
>
> Gregory's question was about A380.
>
> But if you want, you can test this patch series (which already covers
> A388) on your A388 HW. It is still better to do tests on more HW.
>
> On Tuesday 15 February 2022 10:48:17 Lu=C3=ADs Mendes wrote:
> > Hello,
> >
> > Sorry for jumping in the conversation, but I read this thread and I
> > have an Armada A388 HW so I can test it, if desired.
> >
> > Lu=C3=ADs
> >
> >
> > On Tue, Feb 15, 2022 at 10:47 AM Lu=C3=ADs Mendes <luis.p.mendes@gmail.=
com> wrote:
> > >
> > > Hello,
> > >
> > > Sorry for jumping in the conversation, but I read this thread and I h=
ave an Armada A388 HW so I can test it, if desired.
> > >
> > > Lu=C3=ADs
> > >
> > > On Mon, Feb 14, 2022 at 7:57 PM Gregory CLEMENT <gregory.clement@boot=
lin.com> wrote:
> > >>
> > >> Hello,
> > >>
> > >> > On Monday 14 February 2022 16:07:13 Gregory CLEMENT wrote:
> > >> >> Hello Pali,
> > >> >>
> > >> >> > With this change legacy INTA, INTB, INTC and INTD interrupts ar=
e reported
> > >> >> > separately and not mixed into one Linux virq source anymore.
> > >> >> >
> > >> >> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > >> >> > ---
> > >> >> >  arch/arm/boot/dts/armada-385.dtsi | 52 +++++++++++++++++++++++=
+++-----
> > >> >>
> > >> >> Is there any reason for not doing the same change in armada-380.d=
tsi ?
> > >> >
> > >> > I do not have A380 HW, so I did this change only for A385 which I =
have
> > >> > tested.
> > >>
> > >> OK fair enough.
> > >>
> > >> So you can add my
> > >> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> > >>
> > >> Moreover to keep biscetability  this patch should be merged after th=
e
> > >> support in the driver. So the easier is to let merge it through the =
PCI
> > >> subsystem with the other patches from this series. I do not think th=
ere
> > >> will be any other changes in this file so there won't be any merge
> > >> conflicts.
> > >>
> > >> Thanks,
> > >>
> > >> Gr=C3=A9gory
> > >>
> > >>
> > >> >
> > >> >> Gr=C3=A9gory
> > >> >>
> > >> >> >  1 file changed, 44 insertions(+), 8 deletions(-)
> > >> >> >
> > >> >> > diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/=
dts/armada-385.dtsi
> > >> >> > index f0022d10c715..83392b92dae2 100644
> > >> >> > --- a/arch/arm/boot/dts/armada-385.dtsi
> > >> >> > +++ b/arch/arm/boot/dts/armada-385.dtsi
> > >> >> > @@ -69,16 +69,25 @@
> > >> >> >                            reg =3D <0x0800 0 0 0 0>;
> > >> >> >                            #address-cells =3D <3>;
> > >> >> >                            #size-cells =3D <2>;
> > >> >> > +                          interrupt-names =3D "intx";
> > >> >> > +                          interrupts-extended =3D <&gic GIC_SP=
I 29 IRQ_TYPE_LEVEL_HIGH>;
> > >> >> >                            #interrupt-cells =3D <1>;
> > >> >> >                            ranges =3D <0x82000000 0 0 0x8200000=
0 0x1 0 1 0
> > >> >> >                                      0x81000000 0 0 0x81000000 =
0x1 0 1 0>;
> > >> >> >                            bus-range =3D <0x00 0xff>;
> > >> >> > -                          interrupt-map-mask =3D <0 0 0 0>;
> > >> >> > -                          interrupt-map =3D <0 0 0 0 &gic GIC_=
SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> > >> >> > +                          interrupt-map-mask =3D <0 0 0 7>;
> > >> >> > +                          interrupt-map =3D <0 0 0 1 &pcie1_in=
tc 0>,
> > >> >> > +                                          <0 0 0 2 &pcie1_intc=
 1>,
> > >> >> > +                                          <0 0 0 3 &pcie1_intc=
 2>,
> > >> >> > +                                          <0 0 0 4 &pcie1_intc=
 3>;
> > >> >> >                            marvell,pcie-port =3D <0>;
> > >> >> >                            marvell,pcie-lane =3D <0>;
> > >> >> >                            clocks =3D <&gateclk 8>;
> > >> >> >                            status =3D "disabled";
> > >> >> > +                          pcie1_intc: interrupt-controller {
> > >> >> > +                                  interrupt-controller;
> > >> >> > +                                  #interrupt-cells =3D <1>;
> > >> >> > +                          };
> > >> >> >                    };
> > >> >> >
> > >> >> >                    /* x1 port */
> > >> >> > @@ -88,16 +97,25 @@
> > >> >> >                            reg =3D <0x1000 0 0 0 0>;
> > >> >> >                            #address-cells =3D <3>;
> > >> >> >                            #size-cells =3D <2>;
> > >> >> > +                          interrupt-names =3D "intx";
> > >> >> > +                          interrupts-extended =3D <&gic GIC_SP=
I 33 IRQ_TYPE_LEVEL_HIGH>;
> > >> >> >                            #interrupt-cells =3D <1>;
> > >> >> >                            ranges =3D <0x82000000 0 0 0x8200000=
0 0x2 0 1 0
> > >> >> >                                      0x81000000 0 0 0x81000000 =
0x2 0 1 0>;
> > >> >> >                            bus-range =3D <0x00 0xff>;
> > >> >> > -                          interrupt-map-mask =3D <0 0 0 0>;
> > >> >> > -                          interrupt-map =3D <0 0 0 0 &gic GIC_=
SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> > >> >> > +                          interrupt-map-mask =3D <0 0 0 7>;
> > >> >> > +                          interrupt-map =3D <0 0 0 1 &pcie2_in=
tc 0>,
> > >> >> > +                                          <0 0 0 2 &pcie2_intc=
 1>,
> > >> >> > +                                          <0 0 0 3 &pcie2_intc=
 2>,
> > >> >> > +                                          <0 0 0 4 &pcie2_intc=
 3>;
> > >> >> >                            marvell,pcie-port =3D <1>;
> > >> >> >                            marvell,pcie-lane =3D <0>;
> > >> >> >                            clocks =3D <&gateclk 5>;
> > >> >> >                            status =3D "disabled";
> > >> >> > +                          pcie2_intc: interrupt-controller {
> > >> >> > +                                  interrupt-controller;
> > >> >> > +                                  #interrupt-cells =3D <1>;
> > >> >> > +                          };
> > >> >> >                    };
> > >> >> >
> > >> >> >                    /* x1 port */
> > >> >> > @@ -107,16 +125,25 @@
> > >> >> >                            reg =3D <0x1800 0 0 0 0>;
> > >> >> >                            #address-cells =3D <3>;
> > >> >> >                            #size-cells =3D <2>;
> > >> >> > +                          interrupt-names =3D "intx";
> > >> >> > +                          interrupts-extended =3D <&gic GIC_SP=
I 70 IRQ_TYPE_LEVEL_HIGH>;
> > >> >> >                            #interrupt-cells =3D <1>;
> > >> >> >                            ranges =3D <0x82000000 0 0 0x8200000=
0 0x3 0 1 0
> > >> >> >                                      0x81000000 0 0 0x81000000 =
0x3 0 1 0>;
> > >> >> >                            bus-range =3D <0x00 0xff>;
> > >> >> > -                          interrupt-map-mask =3D <0 0 0 0>;
> > >> >> > -                          interrupt-map =3D <0 0 0 0 &gic GIC_=
SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> > >> >> > +                          interrupt-map-mask =3D <0 0 0 7>;
> > >> >> > +                          interrupt-map =3D <0 0 0 1 &pcie3_in=
tc 0>,
> > >> >> > +                                          <0 0 0 2 &pcie3_intc=
 1>,
> > >> >> > +                                          <0 0 0 3 &pcie3_intc=
 2>,
> > >> >> > +                                          <0 0 0 4 &pcie3_intc=
 3>;
> > >> >> >                            marvell,pcie-port =3D <2>;
> > >> >> >                            marvell,pcie-lane =3D <0>;
> > >> >> >                            clocks =3D <&gateclk 6>;
> > >> >> >                            status =3D "disabled";
> > >> >> > +                          pcie3_intc: interrupt-controller {
> > >> >> > +                                  interrupt-controller;
> > >> >> > +                                  #interrupt-cells =3D <1>;
> > >> >> > +                          };
> > >> >> >                    };
> > >> >> >
> > >> >> >                    /*
> > >> >> > @@ -129,16 +156,25 @@
> > >> >> >                            reg =3D <0x2000 0 0 0 0>;
> > >> >> >                            #address-cells =3D <3>;
> > >> >> >                            #size-cells =3D <2>;
> > >> >> > +                          interrupt-names =3D "intx";
> > >> >> > +                          interrupts-extended =3D <&gic GIC_SP=
I 71 IRQ_TYPE_LEVEL_HIGH>;
> > >> >> >                            #interrupt-cells =3D <1>;
> > >> >> >                            ranges =3D <0x82000000 0 0 0x8200000=
0 0x4 0 1 0
> > >> >> >                                      0x81000000 0 0 0x81000000 =
0x4 0 1 0>;
> > >> >> >                            bus-range =3D <0x00 0xff>;
> > >> >> > -                          interrupt-map-mask =3D <0 0 0 0>;
> > >> >> > -                          interrupt-map =3D <0 0 0 0 &gic GIC_=
SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> > >> >> > +                          interrupt-map-mask =3D <0 0 0 7>;
> > >> >> > +                          interrupt-map =3D <0 0 0 1 &pcie4_in=
tc 0>,
> > >> >> > +                                          <0 0 0 2 &pcie4_intc=
 1>,
> > >> >> > +                                          <0 0 0 3 &pcie4_intc=
 2>,
> > >> >> > +                                          <0 0 0 4 &pcie4_intc=
 3>;
> > >> >> >                            marvell,pcie-port =3D <3>;
> > >> >> >                            marvell,pcie-lane =3D <0>;
> > >> >> >                            clocks =3D <&gateclk 7>;
> > >> >> >                            status =3D "disabled";
> > >> >> > +                          pcie4_intc: interrupt-controller {
> > >> >> > +                                  interrupt-controller;
> > >> >> > +                                  #interrupt-cells =3D <1>;
> > >> >> > +                          };
> > >> >> >                    };
> > >> >> >            };
> > >> >> >    };
> > >> >> > --
> > >> >> > 2.20.1
> > >> >> >
> > >> >>
> > >> >> --
> > >> >> Gregory Clement, Bootlin
> > >> >> Embedded Linux and Kernel engineering
> > >> >> http://bootlin.com
> > >>
> > >> --
> > >> Gregory Clement, Bootlin
> > >> Embedded Linux and Kernel engineering
> > >> http://bootlin.com
