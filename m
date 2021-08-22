Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C763F40D7
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 20:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhHVS3Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 14:29:25 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:50940 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhHVS3Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 14:29:24 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 28f884f6;
        Sun, 22 Aug 2021 20:28:41 +0200 (CEST)
Date:   Sun, 22 Aug 2021 20:28:41 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io,
        stan@corellium.com, maz@kernel.org, kettenis@openbsd.org,
        sven@svenpeter.dev, marcan@marcan.st, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210816031621.240268-7-alyssa@rosenzweig.io> (message from
        Alyssa Rosenzweig on Sun, 15 Aug 2021 23:16:21 -0400)
Subject: Re: [PATCH v2 6/6] arm64: apple: Add PCIe node
References: <20210816031621.240268-1-alyssa@rosenzweig.io> <20210816031621.240268-7-alyssa@rosenzweig.io>
Message-ID: <56140c9183a8d1c2@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Date: Sun, 15 Aug 2021 23:16:21 -0400
> 
> From: Mark Kettenis <kettenis@openbsd.org>
> 
> Add node corresponding to the apcie,t8103 node in the Apple device tree
> for the Mac mini (M1, 2020).
> 
> Clock references are left out at the moment and will be added once the
> appropriate bindings have been settled on.
> 
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
>  arch/arm64/boot/dts/apple/t8103.dtsi | 124 +++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index 342e01c6098e..c0d3b2fb0366 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -214,5 +214,129 @@ pinctrl_aop: pinctrl@24a820000 {
>  				     <AIC_IRQ 273 IRQ_TYPE_LEVEL_HIGH>,
>  				     <AIC_IRQ 274 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> +
> +		pcie0_dart_0: dart@681008000 {
> +			compatible = "apple,t8103-dart";
> +			reg = <0x6 0x81008000 0x0 0x4000>;
> +			#iommu-cells = <1>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 696 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pcie0_dart_1: dart@682008000 {
> +			compatible = "apple,t8103-dart";
> +			reg = <0x6 0x82008000 0x0 0x4000>;
> +			#iommu-cells = <1>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 699 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pcie0_dart_2: dart@683008000 {
> +			compatible = "apple,t8103-dart";
> +			reg = <0x6 0x83008000 0x0 0x4000>;
> +			#iommu-cells = <1>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 702 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pcie0: pcie@690000000 {
> +			compatible = "apple,t8103-pcie", "apple,pcie";
> +			device_type = "pci";
> +
> +			reg = <0x6 0x90000000 0x0 0x1000000>,
> +			      <0x6 0x80000000 0x0 0x100000>,
> +			      <0x6 0x81000000 0x0 0x4000>,
> +			      <0x6 0x82000000 0x0 0x4000>,
> +			      <0x6 0x83000000 0x0 0x4000>;
> +			reg-names = "config", "rc", "port0", "port1", "port2";
> +
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 695 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 698 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 701 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 704 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 705 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 706 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 707 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 708 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 709 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 710 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 711 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 712 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 713 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 714 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 715 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 716 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 717 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 718 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 719 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 720 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 721 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 722 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 723 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 724 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 725 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 726 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 727 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 728 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 729 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 730 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 731 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 732 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 733 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 734 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 735 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			msi-controller;
> +			msi-parent = <&pcie0>;
> +			msi-ranges = <704 32>;
> +
> +			iommu-map = <0x100 &pcie0_dart_0 0 1>,
> +				    <0x200 &pcie0_dart_1 0 1>,
> +				    <0x300 &pcie0_dart_2 0 1>;
> +			iommu-map-mask = <0xff00>;

So this will need a little bit more thought.

The PCIe bridge hardware has logic to map a PCIe Requester ID (RID) to
an IOMMU Stream ID (SID).  The RID is basically just the PCI
bus/device/function number of the PCI device that initiates the DMA.
As far as I can tell if the RID isn't matched by the PCIe bridge
RID-to-SID mapping hardware it will be mapped to SID 0.  Your driver
doesn't program the RID-to-SID hardware so using 0 as the SID in your
device tree makes some sense.

However, since SID 0 is the default used when there is no match for an
RID, we should probably avoid it if we can.  That's why in my
apple,pcie DT binding series I used SID 1.  But this would require
additional code in the driver to parse the iommu-map property and
program the RID-to-SID hardware accordingly.

Now until we support the Tunderbolt ports, this isn't all that
important and we can go with your current driver and DT.  I can adjust
the U-Boot DT accordingly.

> +
> +			bus-range = <0 3>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x43000000 0x6 0xa0000000 0x6 0xa0000000 0x0 0x20000000>,
> +				 <0x02000000 0x0 0xc0000000 0x6 0xc0000000 0x0 0x40000000>;
> +
> +			pinctrl-0 = <&pcie_pins>;
> +			pinctrl-names = "default";
> +
> +			pci@0,0 {
> +				device_type = "pci";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				reset-gpios = <&pinctrl_ap 152 0>;
> +				max-link-speed = <2>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +			};
> +
> +			pci@1,0 {
> +				device_type = "pci";
> +				reg = <0x800 0x0 0x0 0x0 0x0>;
> +				reset-gpios = <&pinctrl_ap 153 0>;
> +				max-link-speed = <2>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +			};
> +
> +			pci@2,0 {
> +				device_type = "pci";
> +				reg = <0x1000 0x0 0x0 0x0 0x0>;
> +				reset-gpios = <&pinctrl_ap 33 0>;
> +				max-link-speed = <1>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +			};
> +		};
>  	};
>  };
> -- 
> 2.30.2
> 
> 
