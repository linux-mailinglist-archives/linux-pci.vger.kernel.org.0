Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1B1F2CA7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 11:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbfKGKhK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 05:37:10 -0500
Received: from foss.arm.com ([217.140.110.172]:53890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfKGKhJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 05:37:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB1091FB;
        Thu,  7 Nov 2019 02:37:08 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50D633F71A;
        Thu,  7 Nov 2019 02:37:08 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:37:06 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>, james.quinlan@broadcom.com,
        mbrugger@suse.com, f.fainelli@gmail.com, phil@raspberrypi.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: dts: bcm2711: Enable PCIe controller
Message-ID: <20191107103705.GX9723@e119886-lin.cambridge.arm.com>
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
 <20191106214527.18736-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106214527.18736-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 10:45:24PM +0100, Nicolas Saenz Julienne wrote:
> This enables bcm2711's PCIe bus, wich is hardwired to a VIA Technologies

s/wich/which/

> XHCI USB 3.0 controller.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  arch/arm/boot/dts/bcm2711.dtsi | 47 ++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
> index a9d84e28f245..c7b2e7b57da6 100644
> --- a/arch/arm/boot/dts/bcm2711.dtsi
> +++ b/arch/arm/boot/dts/bcm2711.dtsi
> @@ -288,6 +288,53 @@
>  		arm,cpu-registers-not-fw-configured;
>  	};
>  
> +	scb {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +
> +		ranges = <0x0 0x7c000000  0x0 0xfc000000  0x03800000>,
> +			 <0x6 0x00000000  0x6 0x00000000  0x40000000>;
> +
> +		pcie_0: pcie@7d500000 {
> +			compatible = "brcm,bcm2711-pcie";
> +			reg = <0x0 0x7d500000 0x9310>;
> +			msi-controller;
> +			msi-parent = <&pcie_0>;
> +			#address-cells = <3>;
> +			#interrupt-cells = <1>;
> +			#size-cells = <2>;
> +			linux,pci-domain = <0>;

pci-domain is unlikely to be needed here.

> +			brcm,enable-ssc;
> +			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "pcie", "msi";
> +			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +			interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 143
> +							IRQ_TYPE_LEVEL_HIGH
> +					 0 0 0 2 &gicv2 GIC_SPI 144
> +							IRQ_TYPE_LEVEL_HIGH
> +					 0 0 0 3 &gicv2 GIC_SPI 145
> +							IRQ_TYPE_LEVEL_HIGH
> +					 0 0 0 4 &gicv2 GIC_SPI 146
> +							IRQ_TYPE_LEVEL_HIGH>;
> +
> +			ranges = <0x02000000 0x0 0xf8000000 0x6 0x00000000
> +				  0x0 0x04000000>;

Is legacy I/O supported by this controller?

> +			/*
> +			 * The wrapper around the PCIe block has a bug
> +			 * preventing it from accessing beyond the first 3GB of
> +			 * memory. As the bus DMA mask is rounded up to the
> +			 * closest power of two of the dma-range size, we're
> +			 * forced to set the limit at 2GB. This can be
> +			 * harmlessly changed in the future once the DMA code
> +			 * handles non power of two DMA limits.
> +			 */
> +			dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000
> +				      0x0 0x80000000>;
> +		};
> +	};

Thanks,

Andrew Murray

> +
>  	cpus: cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -- 
> 2.23.0
> 
