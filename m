Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534754B54BC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 16:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355858AbiBNP0j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 10:26:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355816AbiBNP0h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 10:26:37 -0500
X-Greylist: delayed 1151 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 07:26:28 PST
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F2EC4D;
        Mon, 14 Feb 2022 07:26:28 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9AC19240014;
        Mon, 14 Feb 2022 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644852386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+Q/XGnHf9irD5sCh0C/7PF0D//d8ipVJPI4owGtOS4=;
        b=e4q1FrKfMdef6/DF9DT5NRlw6RWKgo4HAS3+DYgKOvaAp/2k9LttFnY3O476KP9nICbJsf
        mcsRvNsGOc5G34qhOYGJHmkjNGw+8qeucXSGEX6kuQ/o1xmeXt5UsMOxzGuncO/rfcaNBW
        WU3K6pwllDzR5au65vBHlaKP0yIibkgr3LU2R6StiaceLraEBJTBm8yyX1xhvtL4QAx9sI
        /j6/70AgLg/j0DodVLyPK0PQUkv/qZALx2NLkZcyZVaQKMbun8CSyfHHnrO4GB5Uw4cDh1
        2O8qLPYibp9cNZdfhdSuYsbT39yF+r8mmhZCQ+6uVc5D9ZQil8aJOVhQdP1rwA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/11] ARM: dts: armada-385.dtsi: Add definitions for
 PCIe legacy INTx interrupts
In-Reply-To: <20220214150923.a5ttxoh426cfxn4v@pali>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-12-pali@kernel.org> <87wnhxjxlq.fsf@BL-laptop>
 <20220214150923.a5ttxoh426cfxn4v@pali>
Date:   Mon, 14 Feb 2022 16:26:24 +0100
Message-ID: <87tud1jwpr.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> On Monday 14 February 2022 16:07:13 Gregory CLEMENT wrote:
>> Hello Pali,
>>=20
>> > With this change legacy INTA, INTB, INTC and INTD interrupts are repor=
ted
>> > separately and not mixed into one Linux virq source anymore.
>> >
>> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>> > ---
>> >  arch/arm/boot/dts/armada-385.dtsi | 52 ++++++++++++++++++++++++++-----
>>=20
>> Is there any reason for not doing the same change in armada-380.dtsi ?
>
> I do not have A380 HW, so I did this change only for A385 which I have
> tested.

OK fair enough.

So you can add my
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Moreover to keep biscetability  this patch should be merged after the
support in the driver. So the easier is to let merge it through the PCI
subsystem with the other patches from this series. I do not think there
will be any other changes in this file so there won't be any merge
conflicts.

Thanks,

Gr=C3=A9gory


>
>> Gr=C3=A9gory
>>=20
>> >  1 file changed, 44 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/arm=
ada-385.dtsi
>> > index f0022d10c715..83392b92dae2 100644
>> > --- a/arch/arm/boot/dts/armada-385.dtsi
>> > +++ b/arch/arm/boot/dts/armada-385.dtsi
>> > @@ -69,16 +69,25 @@
>> >  				reg =3D <0x0800 0 0 0 0>;
>> >  				#address-cells =3D <3>;
>> >  				#size-cells =3D <2>;
>> > +				interrupt-names =3D "intx";
>> > +				interrupts-extended =3D <&gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>> >  				#interrupt-cells =3D <1>;
>> >  				ranges =3D <0x82000000 0 0 0x82000000 0x1 0 1 0
>> >  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
>> >  				bus-range =3D <0x00 0xff>;
>> > -				interrupt-map-mask =3D <0 0 0 0>;
>> > -				interrupt-map =3D <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>> > +				interrupt-map-mask =3D <0 0 0 7>;
>> > +				interrupt-map =3D <0 0 0 1 &pcie1_intc 0>,
>> > +						<0 0 0 2 &pcie1_intc 1>,
>> > +						<0 0 0 3 &pcie1_intc 2>,
>> > +						<0 0 0 4 &pcie1_intc 3>;
>> >  				marvell,pcie-port =3D <0>;
>> >  				marvell,pcie-lane =3D <0>;
>> >  				clocks =3D <&gateclk 8>;
>> >  				status =3D "disabled";
>> > +				pcie1_intc: interrupt-controller {
>> > +					interrupt-controller;
>> > +					#interrupt-cells =3D <1>;
>> > +				};
>> >  			};
>> >=20=20
>> >  			/* x1 port */
>> > @@ -88,16 +97,25 @@
>> >  				reg =3D <0x1000 0 0 0 0>;
>> >  				#address-cells =3D <3>;
>> >  				#size-cells =3D <2>;
>> > +				interrupt-names =3D "intx";
>> > +				interrupts-extended =3D <&gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>> >  				#interrupt-cells =3D <1>;
>> >  				ranges =3D <0x82000000 0 0 0x82000000 0x2 0 1 0
>> >  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
>> >  				bus-range =3D <0x00 0xff>;
>> > -				interrupt-map-mask =3D <0 0 0 0>;
>> > -				interrupt-map =3D <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>> > +				interrupt-map-mask =3D <0 0 0 7>;
>> > +				interrupt-map =3D <0 0 0 1 &pcie2_intc 0>,
>> > +						<0 0 0 2 &pcie2_intc 1>,
>> > +						<0 0 0 3 &pcie2_intc 2>,
>> > +						<0 0 0 4 &pcie2_intc 3>;
>> >  				marvell,pcie-port =3D <1>;
>> >  				marvell,pcie-lane =3D <0>;
>> >  				clocks =3D <&gateclk 5>;
>> >  				status =3D "disabled";
>> > +				pcie2_intc: interrupt-controller {
>> > +					interrupt-controller;
>> > +					#interrupt-cells =3D <1>;
>> > +				};
>> >  			};
>> >=20=20
>> >  			/* x1 port */
>> > @@ -107,16 +125,25 @@
>> >  				reg =3D <0x1800 0 0 0 0>;
>> >  				#address-cells =3D <3>;
>> >  				#size-cells =3D <2>;
>> > +				interrupt-names =3D "intx";
>> > +				interrupts-extended =3D <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>> >  				#interrupt-cells =3D <1>;
>> >  				ranges =3D <0x82000000 0 0 0x82000000 0x3 0 1 0
>> >  					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
>> >  				bus-range =3D <0x00 0xff>;
>> > -				interrupt-map-mask =3D <0 0 0 0>;
>> > -				interrupt-map =3D <0 0 0 0 &gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>> > +				interrupt-map-mask =3D <0 0 0 7>;
>> > +				interrupt-map =3D <0 0 0 1 &pcie3_intc 0>,
>> > +						<0 0 0 2 &pcie3_intc 1>,
>> > +						<0 0 0 3 &pcie3_intc 2>,
>> > +						<0 0 0 4 &pcie3_intc 3>;
>> >  				marvell,pcie-port =3D <2>;
>> >  				marvell,pcie-lane =3D <0>;
>> >  				clocks =3D <&gateclk 6>;
>> >  				status =3D "disabled";
>> > +				pcie3_intc: interrupt-controller {
>> > +					interrupt-controller;
>> > +					#interrupt-cells =3D <1>;
>> > +				};
>> >  			};
>> >=20=20
>> >  			/*
>> > @@ -129,16 +156,25 @@
>> >  				reg =3D <0x2000 0 0 0 0>;
>> >  				#address-cells =3D <3>;
>> >  				#size-cells =3D <2>;
>> > +				interrupt-names =3D "intx";
>> > +				interrupts-extended =3D <&gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>> >  				#interrupt-cells =3D <1>;
>> >  				ranges =3D <0x82000000 0 0 0x82000000 0x4 0 1 0
>> >  					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
>> >  				bus-range =3D <0x00 0xff>;
>> > -				interrupt-map-mask =3D <0 0 0 0>;
>> > -				interrupt-map =3D <0 0 0 0 &gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>> > +				interrupt-map-mask =3D <0 0 0 7>;
>> > +				interrupt-map =3D <0 0 0 1 &pcie4_intc 0>,
>> > +						<0 0 0 2 &pcie4_intc 1>,
>> > +						<0 0 0 3 &pcie4_intc 2>,
>> > +						<0 0 0 4 &pcie4_intc 3>;
>> >  				marvell,pcie-port =3D <3>;
>> >  				marvell,pcie-lane =3D <0>;
>> >  				clocks =3D <&gateclk 7>;
>> >  				status =3D "disabled";
>> > +				pcie4_intc: interrupt-controller {
>> > +					interrupt-controller;
>> > +					#interrupt-cells =3D <1>;
>> > +				};
>> >  			};
>> >  		};
>> >  	};
>> > --=20
>> > 2.20.1
>> >
>>=20
>> --=20
>> Gregory Clement, Bootlin
>> Embedded Linux and Kernel engineering
>> http://bootlin.com

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
