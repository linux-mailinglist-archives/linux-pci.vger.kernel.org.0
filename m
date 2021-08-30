Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591673FB897
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhH3O6A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 10:58:00 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:56498 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhH3O57 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Aug 2021 10:57:59 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id ef38839b;
        Mon, 30 Aug 2021 16:57:02 +0200 (CEST)
Date:   Mon, 30 Aug 2021 16:57:02 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, alyssa@rosenzweig.io,
        kettenis@openbsd.org, tglx@linutronix.de, robh+dt@kernel.org,
        marcan@marcan.st, bhelgaas@google.com, nsaenz@kernel.org,
        jim2101024@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        daire.mcnamara@microchip.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
In-Reply-To: <87pmtvcgec.wl-maz@kernel.org> (message from Marc Zyngier on Mon,
        30 Aug 2021 12:37:31 +0100)
Subject: Re: [PATCH v4 4/4] arm64: apple: Add PCIe node
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-5-mark.kettenis@xs4all.nl> <87pmtvcgec.wl-maz@kernel.org>
Message-ID: <56142808ad64dd79@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Mon, 30 Aug 2021 12:37:31 +0100
> From: Marc Zyngier <maz@kernel.org>
> 
> Hi Mark,

Hi Marc,

> On Fri, 27 Aug 2021 18:15:29 +0100,
> Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > 
> > From: Mark Kettenis <kettenis@openbsd.org>
> > 
> > Add node corresponding to the apcie,t8103 node in the
> > Apple device tree for the Mac mini (M1, 2020).
> > 
> > Clock references and DART (IOMMU) references are left out at the
> > moment and will be added once the appropriate bindings have been
> > settled upon.
> > 
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> >  arch/arm64/boot/dts/apple/t8103.dtsi | 63 ++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> > index 503a76fc30e6..6e4677bdef44 100644
> > --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> > +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> > @@ -214,5 +214,68 @@ pinctrl_smc: pinctrl@23e820000 {
> >  				     <AIC_IRQ 396 IRQ_TYPE_LEVEL_HIGH>,
> >  				     <AIC_IRQ 397 IRQ_TYPE_LEVEL_HIGH>;
> >  		};
> > +
> > +		pcie0: pcie@690000000 {
> > +			compatible = "apple,t8103-pcie", "apple,pcie";
> > +			device_type = "pci";
> > +
> > +			reg = <0x6 0x90000000 0x0 0x1000000>,
> > +			      <0x6 0x80000000 0x0 0x4000>,
> > +			      <0x6 0x81000000 0x0 0x8000>,
> > +			      <0x6 0x82000000 0x0 0x8000>,
> > +			      <0x6 0x83000000 0x0 0x8000>;
> > +			reg-names = "config", "rc", "port0", "port1", "port2";
> > +
> > +			interrupt-parent = <&aic>;
> > +			interrupts = <AIC_IRQ 695 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <AIC_IRQ 698 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <AIC_IRQ 701 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +			msi-controller;
> > +			msi-parent = <&pcie0>;
> > +			msi-ranges = <&aic AIC_IRQ 704 IRQ_TYPE_EDGE_RISING 32>;
> > +
> > +			bus-range = <0 3>;
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +			ranges = <0x43000000 0x6 0xa0000000 0x6 0xa0000000 0x0 0x20000000>,
> > +				 <0x02000000 0x0 0xc0000000 0x6 0xc0000000 0x0 0x40000000>;
> > +
> > +			pinctrl-0 = <&pcie_pins>;
> > +			pinctrl-names = "default";
> > +
> > +			pci@0,0 {
> > +				device_type = "pci";
> > +				reg = <0x0 0x0 0x0 0x0 0x0>;
> > +				reset-gpios = <&pinctrl_ap 152 0>;
> > +				max-link-speed = <2>;
> > +
> > +				#address-cells = <3>;
> > +				#size-cells = <2>;
> > +				ranges;
> > +			};
> > +
> > +			pci@1,0 {
> > +				device_type = "pci";
> > +				reg = <0x800 0x0 0x0 0x0 0x0>;
> > +				reset-gpios = <&pinctrl_ap 153 0>;
> > +				max-link-speed = <2>;
> > +
> > +				#address-cells = <3>;
> > +				#size-cells = <2>;
> > +				ranges;
> > +			};
> > +
> > +			pci@2,0 {
> > +				device_type = "pci";
> > +				reg = <0x1000 0x0 0x0 0x0 0x0>;
> > +				reset-gpios = <&pinctrl_ap 33 0>;
> > +				max-link-speed = <1>;
> > +
> > +				#address-cells = <3>;
> > +				#size-cells = <2>;
> > +				ranges;
> > +			};
> > +		};
> >  	};
> >  };
> 
> I have now implemented the MSI change on the Linux driver side, and it
> works nicely. So thumbs up from me on this front.
> 
> I am now looking at the interrupts provided by each port:
> (1) a bunch of port-private interrupts (link up/down...)
> (2) INTx interrupts
> 
> Given that the programming is per-port, I've implemented this as a
> per-port interrupt controller.
> 
> (1) is dead easy to implement, and doesn't require any DT description.
> (2) is unfortunately exposing the limits of my DT knowledge, and I'm
> not clear how to model it. I came up with the following:
> 
> 	port00: pci@0,0 {
> 		device_type = "pci";
> 		reg = <0x0 0x0 0x0 0x0 0x0>;
> 		reset-gpios = <&pinctrl_ap 152 0>;
> 		max-link-speed = <2>;
> 
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		ranges;
> 
> 		interrupt-controller;
> 		#interrupt-cells = <1>;
> 		interrupt-parent = <&port00>;
> 		interrupt-map-mask = <0 0 0 7>;
> 		interrupt-map = <0 0 0 1 &port00 0>,
> 				<0 0 0 2 &port00 1>,
> 				<0 0 0 3 &port00 2>,
> 				<0 0 0 4 &port00 3>;
> 	};
> 
> which vaguely seem to do the right thing for the devices behind root
> ports, but doesn't seem to work for INTx generated by the root ports
> themselves. Any clue? Alternatively, I could move it to something
> global to the whole PCIe controller, but that doesn't seem completely
> right.
> 
> It also begs the question whether the per-port interrupt to the AIC
> should be moved into each root port, should my per-port approach hold
> any water.

Must admit that I didn't entirely thinkthrough this aspect fo the
hardware.  MSIs work just fine for the built-in hardware of the
current generation of M1 Macs so I ignored INTx for now.

It isn't entirely clear to me what properties are "allowed" on the
individual pci device child nodes that correspond to the ports.  But
"interrupt-map" and "interrupt-map-mask" are certainly among the
allowed properties, so this approach makes sense to me.  I must say I
don't see what the issue with the INTx generated by the root ports
themselves would be.  

I don't think we can move the interrupt property for the AIC to the
ports though, since that property would actually represent the
interrupt of the PCI bridge device according to the standard PCI
bindings and that isn't the case here.

So this makes sense to me and might not even need changing to the
binding for the Apple PCIe controller itself.
