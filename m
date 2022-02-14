Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BA84B544C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355669AbiBNPNd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 10:13:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344516AbiBNPNc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 10:13:32 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3ADD66;
        Mon, 14 Feb 2022 07:13:22 -0800 (PST)
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id AAB7DCEBE9;
        Mon, 14 Feb 2022 15:07:22 +0000 (UTC)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BD7E11BF204;
        Mon, 14 Feb 2022 15:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644851235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ss+CgBMxTZ4PvxtZAL6RbpWF0KZZk0nOt+eGe+JgCI=;
        b=QJjKYEYMtunNXrNVeX1nAnszUawCIwvP0QelWuJMtgUYwbmAzd5e6Y7ItoC+UoMFJBdLy3
        3dsgOPnV+icQP45B1XTWyvsK8mnoAnSjCt4Fx2dOJzhh7GsKzjshubCX0w2gcjj/rBdXM5
        vOuK8D9MypKxKumhDjEp0aiNUqMAS8lnC+xccae6OUWoLuW3k243MVVDeroFF5Swb+iMCN
        NI7P357xgeaME4gZu05bzdtFa74f1bWBRx/ewm/4V480l8Rzdg6ayVkZPkvJYo3ER/SASm
        Z2idB5WrS7D2qmR7V2E7D43g1gBulpHI+cwVxCKIHOY8jjZvY8fXog026aDbDA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/11] ARM: dts: armada-385.dtsi: Add definitions for
 PCIe legacy INTx interrupts
In-Reply-To: <20220112151814.24361-12-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-12-pali@kernel.org>
Date:   Mon, 14 Feb 2022 16:07:13 +0100
Message-ID: <87wnhxjxlq.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Pali,

> With this change legacy INTA, INTB, INTC and INTD interrupts are reported
> separately and not mixed into one Linux virq source anymore.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  arch/arm/boot/dts/armada-385.dtsi | 52 ++++++++++++++++++++++++++-----

Is there any reason for not doing the same change in armada-380.dtsi ?

Gr=C3=A9gory

>  1 file changed, 44 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada=
-385.dtsi
> index f0022d10c715..83392b92dae2 100644
> --- a/arch/arm/boot/dts/armada-385.dtsi
> +++ b/arch/arm/boot/dts/armada-385.dtsi
> @@ -69,16 +69,25 @@
>  				reg =3D <0x0800 0 0 0 0>;
>  				#address-cells =3D <3>;
>  				#size-cells =3D <2>;
> +				interrupt-names =3D "intx";
> +				interrupts-extended =3D <&gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>  				#interrupt-cells =3D <1>;
>  				ranges =3D <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
>  				bus-range =3D <0x00 0xff>;
> -				interrupt-map-mask =3D <0 0 0 0>;
> -				interrupt-map =3D <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-map-mask =3D <0 0 0 7>;
> +				interrupt-map =3D <0 0 0 1 &pcie1_intc 0>,
> +						<0 0 0 2 &pcie1_intc 1>,
> +						<0 0 0 3 &pcie1_intc 2>,
> +						<0 0 0 4 &pcie1_intc 3>;
>  				marvell,pcie-port =3D <0>;
>  				marvell,pcie-lane =3D <0>;
>  				clocks =3D <&gateclk 8>;
>  				status =3D "disabled";
> +				pcie1_intc: interrupt-controller {
> +					interrupt-controller;
> +					#interrupt-cells =3D <1>;
> +				};
>  			};
>=20=20
>  			/* x1 port */
> @@ -88,16 +97,25 @@
>  				reg =3D <0x1000 0 0 0 0>;
>  				#address-cells =3D <3>;
>  				#size-cells =3D <2>;
> +				interrupt-names =3D "intx";
> +				interrupts-extended =3D <&gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>  				#interrupt-cells =3D <1>;
>  				ranges =3D <0x82000000 0 0 0x82000000 0x2 0 1 0
>  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
>  				bus-range =3D <0x00 0xff>;
> -				interrupt-map-mask =3D <0 0 0 0>;
> -				interrupt-map =3D <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-map-mask =3D <0 0 0 7>;
> +				interrupt-map =3D <0 0 0 1 &pcie2_intc 0>,
> +						<0 0 0 2 &pcie2_intc 1>,
> +						<0 0 0 3 &pcie2_intc 2>,
> +						<0 0 0 4 &pcie2_intc 3>;
>  				marvell,pcie-port =3D <1>;
>  				marvell,pcie-lane =3D <0>;
>  				clocks =3D <&gateclk 5>;
>  				status =3D "disabled";
> +				pcie2_intc: interrupt-controller {
> +					interrupt-controller;
> +					#interrupt-cells =3D <1>;
> +				};
>  			};
>=20=20
>  			/* x1 port */
> @@ -107,16 +125,25 @@
>  				reg =3D <0x1800 0 0 0 0>;
>  				#address-cells =3D <3>;
>  				#size-cells =3D <2>;
> +				interrupt-names =3D "intx";
> +				interrupts-extended =3D <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>  				#interrupt-cells =3D <1>;
>  				ranges =3D <0x82000000 0 0 0x82000000 0x3 0 1 0
>  					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
>  				bus-range =3D <0x00 0xff>;
> -				interrupt-map-mask =3D <0 0 0 0>;
> -				interrupt-map =3D <0 0 0 0 &gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-map-mask =3D <0 0 0 7>;
> +				interrupt-map =3D <0 0 0 1 &pcie3_intc 0>,
> +						<0 0 0 2 &pcie3_intc 1>,
> +						<0 0 0 3 &pcie3_intc 2>,
> +						<0 0 0 4 &pcie3_intc 3>;
>  				marvell,pcie-port =3D <2>;
>  				marvell,pcie-lane =3D <0>;
>  				clocks =3D <&gateclk 6>;
>  				status =3D "disabled";
> +				pcie3_intc: interrupt-controller {
> +					interrupt-controller;
> +					#interrupt-cells =3D <1>;
> +				};
>  			};
>=20=20
>  			/*
> @@ -129,16 +156,25 @@
>  				reg =3D <0x2000 0 0 0 0>;
>  				#address-cells =3D <3>;
>  				#size-cells =3D <2>;
> +				interrupt-names =3D "intx";
> +				interrupts-extended =3D <&gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>  				#interrupt-cells =3D <1>;
>  				ranges =3D <0x82000000 0 0 0x82000000 0x4 0 1 0
>  					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
>  				bus-range =3D <0x00 0xff>;
> -				interrupt-map-mask =3D <0 0 0 0>;
> -				interrupt-map =3D <0 0 0 0 &gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-map-mask =3D <0 0 0 7>;
> +				interrupt-map =3D <0 0 0 1 &pcie4_intc 0>,
> +						<0 0 0 2 &pcie4_intc 1>,
> +						<0 0 0 3 &pcie4_intc 2>,
> +						<0 0 0 4 &pcie4_intc 3>;
>  				marvell,pcie-port =3D <3>;
>  				marvell,pcie-lane =3D <0>;
>  				clocks =3D <&gateclk 7>;
>  				status =3D "disabled";
> +				pcie4_intc: interrupt-controller {
> +					interrupt-controller;
> +					#interrupt-cells =3D <1>;
> +				};
>  			};
>  		};
>  	};
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
