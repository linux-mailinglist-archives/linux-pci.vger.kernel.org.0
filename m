Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04C508918
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 15:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiDTNWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 09:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiDTNWP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 09:22:15 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1AF42A15;
        Wed, 20 Apr 2022 06:19:28 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D362D60009;
        Wed, 20 Apr 2022 13:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650460767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2gBVdSWSq3Kx05ZGBgji7QKyco/sOoB/fTj/ec1PlaM=;
        b=mdDgwMkQSfRFn8KS53atkc9yX7+YFArUgPLKVATkP0/tYIwuNJUX9Laa4RSo4Pnj7p/kRa
        baSjthpCeMD8cXSlldSJuEBqPNHuyzA04PeoRmE3Hmv8k7qlycTUzqiX4/GYtX1vvSI8++
        nbsAR1MHM2O/DQ7pT0l8E5M/eWrKqao6y+vDB87sz3bLgMMx6LY/SGx/sOK6ANFJNi+SEp
        zQIcVjSdWbWx/d7EEFvJ5nAhvd2bP/V8gDFaimXu/6Jx+6YQsfjccCi4HgCgA10OWPjC+p
        ujftpQ72mI8XUVgEsl6RnPpMtStgFqU/pgdwRNg05jHyYKwTTtHt/akC6joDeQ==
Date:   Wed, 20 Apr 2022 15:19:23 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 6/8] ARM: dts: r9a06g032: Add internal PCI bridge
 node
Message-ID: <20220420151923.1852a681@bootlin.com>
In-Reply-To: <05c96b4d-313b-1aad-0ee5-61e54672765e@omp.ru>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
        <20220414074011.500533-7-herve.codina@bootlin.com>
        <05c96b4d-313b-1aad-0ee5-61e54672765e@omp.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sergey,

On Mon, 18 Apr 2022 12:02:52 +0300
Sergey Shtylyov <s.shtylyov@omp.ru> wrote:

> Hello!
>=20
> On 4/14/22 10:40 AM, Herve Codina wrote:
>=20
> > Add the device node for the r9a06g032 internal PCI bridge device.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  arch/arm/boot/dts/r9a06g032.dtsi | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06=
g032.dtsi
> > index 636a6ab31c58..848dc034bb8c 100644
> > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > @@ -211,6 +211,34 @@ gic: interrupt-controller@44101000 {
> >  			interrupts =3D
> >  				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> >  		};
> > +
> > +		pci_usb: pci@40030000 {
> > +			compatible =3D "renesas,pci-r9a06g032", "renesas,pci-rzn1";
> > +			device_type =3D "pci";
> > +			clocks =3D <&sysctrl R9A06G032_HCLK_USBH>,
> > +				 <&sysctrl R9A06G032_HCLK_USBPM>,
> > +				 <&sysctrl R9A06G032_CLK_PCI_USB>;
> > +			clock-names =3D "hclk_usbh", "hclk_usbpm", "clk_pci_usb";
> > +			reg =3D <0x40030000 0xc00>,
> > +			      <0x40020000 0x1100>;
> > +			interrupts =3D <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> > +			status =3D "disabled";
> > +
> > +			bus-range =3D <0 0>;
> > +			#address-cells =3D <3>;
> > +			#size-cells =3D <2>;
> > +			#interrupt-cells =3D <1>; =20
>=20
>    Really? I don't think this PCI bridge is also an interrupt controller.=
..

The #interrupt-cells property is required in the binding.
The #interrupt-cells is needed when we use interrupt-map property.

At least from 'make dtbindings_check':
	properties: '#interrupt-cells' is a dependency of 'interrupt-map'
	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#

Do I miss something ?

Regards,
Herv=C3=A9

>=20
> > +			ranges =3D <0x02000000 0 0x40020000 0x40020000 0 0x00010000>;
> > +			/* Should map all possible DDR as inbound ranges, but
> > +			 * the IP only supports a 256MB, 512MB, or 1GB window.
> > +			 * flags, PCI addr (64-bit), CPU addr, PCI size (64-bit)
> > +			 */
> > +			dma-ranges =3D <0x42000000 0 0x80000000 0x80000000 0 0x40000000>;
> > +			interrupt-map-mask =3D <0xf800 0 0 0x7>;
> > +			interrupt-map =3D <0x0000 0 0 1 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
> > +					 0x0800 0 0 1 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
> > +					 0x1000 0 0 2 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> > +		};
> >  	};
> > =20
> >  	timer { =20
>=20
> MBR, Sergey



--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
