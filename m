Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0AA4B69AC
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 11:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiBOKso (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 05:48:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiBOKsl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 05:48:41 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBF6BB578;
        Tue, 15 Feb 2022 02:48:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id f17so31418167edd.2;
        Tue, 15 Feb 2022 02:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1M5SOvvR5UxFyyhKJEPFzJaclHyq3gw5Z8ty3dGyG3U=;
        b=RUZ6ElIuzBkDsHh4cMLyoJAlFhzyYs28MqDrmj7itCu3kYSJ+bRRsJQR7GYTe33zyH
         HH4ln1cNxX2X2VRqgQHsAtrf5ejHxxfMkYED3ucMCauUuKERW/uUCQdHJs5yiV3AHkfD
         eRwSay8GYw3hgFrNhRwr+7J5soKzzX1KIumv5jm/yg7BqNbfPe6CC7w90sX9gdGkdV0w
         zrS2GGQMrqCIM8ewIZbvt40x5rGc7oZBcR9GSq0YKhgggV/JIQCfrLmfzyxkNWXCnmPN
         1Wa5KBli2ZjCcFm9BvJoGcGUxHUiimUWcyB9B4Afqbl/SzcaERFJBesPG+O3USckjS6K
         IG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1M5SOvvR5UxFyyhKJEPFzJaclHyq3gw5Z8ty3dGyG3U=;
        b=oEgqaFfj93YV094Wmiq654HpVC4Q1ajydGIAOwMzvaMqy7bSPwWddkEAecqxHwU9Y9
         t70tmK90Ro1RkhuvRS4haPsoiZis1Y8LcMBziR8a053Et/gowgIlEY2Cce5xm9Yb2OCy
         AHllrZPZwoI40T+XJeiYF9kpzKPD++H6l6qoevHrbAZ9UXiVHr1KKYVetol1Nrp4DYH9
         j0bAOMZ7en8fZ1iv1PFly0nK/c7ErSnSzitncSnbFnOklVr/7PgYvwC1Kv6/okVxxxwr
         3XFpDrOkpRznQhtDUZybl9MHHNofPSkmIFQKnKJB8gOco0NQQ3EbJH5bhPjibrmnQ87v
         rOWg==
X-Gm-Message-State: AOAM532a5YxSN/rRf+oG0IPa+P8GeCGl7xxd6O3aKPZrs2S1JbvNfIuJ
        F2NCsYmL0UsT6ya+hLbWAcEL38diK9eDlP/i1qo=
X-Google-Smtp-Source: ABdhPJzBJK61z/+n98rQlJ7TM8RncgIkE9xYPUqFPHexEGmqCyS7CjMirxLl1b2l6anz1sgrfT6S+OfTTkrHsJCvHw0=
X-Received: by 2002:a05:6402:191:: with SMTP id r17mr3272762edv.348.1644922108457;
 Tue, 15 Feb 2022 02:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20220105150239.9628-1-pali@kernel.org> <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-12-pali@kernel.org> <87wnhxjxlq.fsf@BL-laptop>
 <20220214150923.a5ttxoh426cfxn4v@pali> <87tud1jwpr.fsf@BL-laptop> <CAEzXK1qYKVk7QiSY_DwqkZ7WV6WU06WBtiqZx0JJCc+mOP-7Kg@mail.gmail.com>
In-Reply-To: <CAEzXK1qYKVk7QiSY_DwqkZ7WV6WU06WBtiqZx0JJCc+mOP-7Kg@mail.gmail.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Tue, 15 Feb 2022 10:48:17 +0000
Message-ID: <CAEzXK1rj7pOvJgAMd11TJVqzgWD2GSJ-25_BWL7X9wiZWOhieQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ARM: dts: armada-385.dtsi: Add definitions for
 PCIe legacy INTx interrupts
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
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

Hello,

Sorry for jumping in the conversation, but I read this thread and I
have an Armada A388 HW so I can test it, if desired.

Lu=C3=ADs


On Tue, Feb 15, 2022 at 10:47 AM Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>=
 wrote:
>
> Hello,
>
> Sorry for jumping in the conversation, but I read this thread and I have =
an Armada A388 HW so I can test it, if desired.
>
> Lu=C3=ADs
>
> On Mon, Feb 14, 2022 at 7:57 PM Gregory CLEMENT <gregory.clement@bootlin.=
com> wrote:
>>
>> Hello,
>>
>> > On Monday 14 February 2022 16:07:13 Gregory CLEMENT wrote:
>> >> Hello Pali,
>> >>
>> >> > With this change legacy INTA, INTB, INTC and INTD interrupts are re=
ported
>> >> > separately and not mixed into one Linux virq source anymore.
>> >> >
>> >> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>> >> > ---
>> >> >  arch/arm/boot/dts/armada-385.dtsi | 52 ++++++++++++++++++++++++++-=
----
>> >>
>> >> Is there any reason for not doing the same change in armada-380.dtsi =
?
>> >
>> > I do not have A380 HW, so I did this change only for A385 which I have
>> > tested.
>>
>> OK fair enough.
>>
>> So you can add my
>> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>>
>> Moreover to keep biscetability  this patch should be merged after the
>> support in the driver. So the easier is to let merge it through the PCI
>> subsystem with the other patches from this series. I do not think there
>> will be any other changes in this file so there won't be any merge
>> conflicts.
>>
>> Thanks,
>>
>> Gr=C3=A9gory
>>
>>
>> >
>> >> Gr=C3=A9gory
>> >>
>> >> >  1 file changed, 44 insertions(+), 8 deletions(-)
>> >> >
>> >> > diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/=
armada-385.dtsi
>> >> > index f0022d10c715..83392b92dae2 100644
>> >> > --- a/arch/arm/boot/dts/armada-385.dtsi
>> >> > +++ b/arch/arm/boot/dts/armada-385.dtsi
>> >> > @@ -69,16 +69,25 @@
>> >> >                            reg =3D <0x0800 0 0 0 0>;
>> >> >                            #address-cells =3D <3>;
>> >> >                            #size-cells =3D <2>;
>> >> > +                          interrupt-names =3D "intx";
>> >> > +                          interrupts-extended =3D <&gic GIC_SPI 29=
 IRQ_TYPE_LEVEL_HIGH>;
>> >> >                            #interrupt-cells =3D <1>;
>> >> >                            ranges =3D <0x82000000 0 0 0x82000000 0x=
1 0 1 0
>> >> >                                      0x81000000 0 0 0x81000000 0x1 =
0 1 0>;
>> >> >                            bus-range =3D <0x00 0xff>;
>> >> > -                          interrupt-map-mask =3D <0 0 0 0>;
>> >> > -                          interrupt-map =3D <0 0 0 0 &gic GIC_SPI =
29 IRQ_TYPE_LEVEL_HIGH>;
>> >> > +                          interrupt-map-mask =3D <0 0 0 7>;
>> >> > +                          interrupt-map =3D <0 0 0 1 &pcie1_intc 0=
>,
>> >> > +                                          <0 0 0 2 &pcie1_intc 1>,
>> >> > +                                          <0 0 0 3 &pcie1_intc 2>,
>> >> > +                                          <0 0 0 4 &pcie1_intc 3>;
>> >> >                            marvell,pcie-port =3D <0>;
>> >> >                            marvell,pcie-lane =3D <0>;
>> >> >                            clocks =3D <&gateclk 8>;
>> >> >                            status =3D "disabled";
>> >> > +                          pcie1_intc: interrupt-controller {
>> >> > +                                  interrupt-controller;
>> >> > +                                  #interrupt-cells =3D <1>;
>> >> > +                          };
>> >> >                    };
>> >> >
>> >> >                    /* x1 port */
>> >> > @@ -88,16 +97,25 @@
>> >> >                            reg =3D <0x1000 0 0 0 0>;
>> >> >                            #address-cells =3D <3>;
>> >> >                            #size-cells =3D <2>;
>> >> > +                          interrupt-names =3D "intx";
>> >> > +                          interrupts-extended =3D <&gic GIC_SPI 33=
 IRQ_TYPE_LEVEL_HIGH>;
>> >> >                            #interrupt-cells =3D <1>;
>> >> >                            ranges =3D <0x82000000 0 0 0x82000000 0x=
2 0 1 0
>> >> >                                      0x81000000 0 0 0x81000000 0x2 =
0 1 0>;
>> >> >                            bus-range =3D <0x00 0xff>;
>> >> > -                          interrupt-map-mask =3D <0 0 0 0>;
>> >> > -                          interrupt-map =3D <0 0 0 0 &gic GIC_SPI =
33 IRQ_TYPE_LEVEL_HIGH>;
>> >> > +                          interrupt-map-mask =3D <0 0 0 7>;
>> >> > +                          interrupt-map =3D <0 0 0 1 &pcie2_intc 0=
>,
>> >> > +                                          <0 0 0 2 &pcie2_intc 1>,
>> >> > +                                          <0 0 0 3 &pcie2_intc 2>,
>> >> > +                                          <0 0 0 4 &pcie2_intc 3>;
>> >> >                            marvell,pcie-port =3D <1>;
>> >> >                            marvell,pcie-lane =3D <0>;
>> >> >                            clocks =3D <&gateclk 5>;
>> >> >                            status =3D "disabled";
>> >> > +                          pcie2_intc: interrupt-controller {
>> >> > +                                  interrupt-controller;
>> >> > +                                  #interrupt-cells =3D <1>;
>> >> > +                          };
>> >> >                    };
>> >> >
>> >> >                    /* x1 port */
>> >> > @@ -107,16 +125,25 @@
>> >> >                            reg =3D <0x1800 0 0 0 0>;
>> >> >                            #address-cells =3D <3>;
>> >> >                            #size-cells =3D <2>;
>> >> > +                          interrupt-names =3D "intx";
>> >> > +                          interrupts-extended =3D <&gic GIC_SPI 70=
 IRQ_TYPE_LEVEL_HIGH>;
>> >> >                            #interrupt-cells =3D <1>;
>> >> >                            ranges =3D <0x82000000 0 0 0x82000000 0x=
3 0 1 0
>> >> >                                      0x81000000 0 0 0x81000000 0x3 =
0 1 0>;
>> >> >                            bus-range =3D <0x00 0xff>;
>> >> > -                          interrupt-map-mask =3D <0 0 0 0>;
>> >> > -                          interrupt-map =3D <0 0 0 0 &gic GIC_SPI =
70 IRQ_TYPE_LEVEL_HIGH>;
>> >> > +                          interrupt-map-mask =3D <0 0 0 7>;
>> >> > +                          interrupt-map =3D <0 0 0 1 &pcie3_intc 0=
>,
>> >> > +                                          <0 0 0 2 &pcie3_intc 1>,
>> >> > +                                          <0 0 0 3 &pcie3_intc 2>,
>> >> > +                                          <0 0 0 4 &pcie3_intc 3>;
>> >> >                            marvell,pcie-port =3D <2>;
>> >> >                            marvell,pcie-lane =3D <0>;
>> >> >                            clocks =3D <&gateclk 6>;
>> >> >                            status =3D "disabled";
>> >> > +                          pcie3_intc: interrupt-controller {
>> >> > +                                  interrupt-controller;
>> >> > +                                  #interrupt-cells =3D <1>;
>> >> > +                          };
>> >> >                    };
>> >> >
>> >> >                    /*
>> >> > @@ -129,16 +156,25 @@
>> >> >                            reg =3D <0x2000 0 0 0 0>;
>> >> >                            #address-cells =3D <3>;
>> >> >                            #size-cells =3D <2>;
>> >> > +                          interrupt-names =3D "intx";
>> >> > +                          interrupts-extended =3D <&gic GIC_SPI 71=
 IRQ_TYPE_LEVEL_HIGH>;
>> >> >                            #interrupt-cells =3D <1>;
>> >> >                            ranges =3D <0x82000000 0 0 0x82000000 0x=
4 0 1 0
>> >> >                                      0x81000000 0 0 0x81000000 0x4 =
0 1 0>;
>> >> >                            bus-range =3D <0x00 0xff>;
>> >> > -                          interrupt-map-mask =3D <0 0 0 0>;
>> >> > -                          interrupt-map =3D <0 0 0 0 &gic GIC_SPI =
71 IRQ_TYPE_LEVEL_HIGH>;
>> >> > +                          interrupt-map-mask =3D <0 0 0 7>;
>> >> > +                          interrupt-map =3D <0 0 0 1 &pcie4_intc 0=
>,
>> >> > +                                          <0 0 0 2 &pcie4_intc 1>,
>> >> > +                                          <0 0 0 3 &pcie4_intc 2>,
>> >> > +                                          <0 0 0 4 &pcie4_intc 3>;
>> >> >                            marvell,pcie-port =3D <3>;
>> >> >                            marvell,pcie-lane =3D <0>;
>> >> >                            clocks =3D <&gateclk 7>;
>> >> >                            status =3D "disabled";
>> >> > +                          pcie4_intc: interrupt-controller {
>> >> > +                                  interrupt-controller;
>> >> > +                                  #interrupt-cells =3D <1>;
>> >> > +                          };
>> >> >                    };
>> >> >            };
>> >> >    };
>> >> > --
>> >> > 2.20.1
>> >> >
>> >>
>> >> --
>> >> Gregory Clement, Bootlin
>> >> Embedded Linux and Kernel engineering
>> >> http://bootlin.com
>>
>> --
>> Gregory Clement, Bootlin
>> Embedded Linux and Kernel engineering
>> http://bootlin.com
