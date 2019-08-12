Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64BDA898C5
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 10:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfHLIft (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 04:35:49 -0400
Received: from foss.arm.com ([217.140.110.172]:45112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfHLIft (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 04:35:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B62C15A2;
        Mon, 12 Aug 2019 01:35:48 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E0C03F718;
        Mon, 12 Aug 2019 01:35:47 -0700 (PDT)
Date:   Mon, 12 Aug 2019 09:35:46 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCH 4/4] arm64: dts: fsl: Remove num-lanes property from PCIe
 nodes
Message-ID: <20190812083545.GV56241@e119886-lin.cambridge.arm.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
 <20190812042435.25102-5-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812042435.25102-5-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 12, 2019 at 04:22:33AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> On FSL Layerscape SoCs, the number of lanes assigned to PCIe
> controller is not fixed, it is determined by the selected
> SerDes protocol in the RCW (Reset Configuration Word), and
> the PCIe link training is completed automatically base on
> the selected SerDes protocol, and the link width set-up is
> updated by hardware. So the num-lanes is not needed to
> specify the link width.
> 
> The current num-lanes indicates the max lanes PCIe controller
> can support up to, instead of the lanes assigned to the PCIe
> controller. This can result in PCIe link training fail after
> hot-reset. So remove the num-lanes to avoid set-up to incorrect
> link width.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 -
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ------
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 3 ---
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ----
>  5 files changed, 17 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> index ec6257a5b251..119c597ca867 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -486,7 +486,6 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			num-lanes = <4>;
>  			num-viewport = <2>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 71d9ed9ff985..c084c7a4b6a6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -677,7 +677,6 @@
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			num-lanes = <4>;
>  			num-viewport = <6>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
> @@ -704,7 +703,6 @@
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			num-lanes = <2>;
>  			num-viewport = <6>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
> @@ -731,7 +729,6 @@
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			num-lanes = <2>;
>  			num-viewport = <6>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index b0ef08b090dd..d4c1da3d4bde 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -649,7 +649,6 @@
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			num-lanes = <4>;
>  			num-viewport = <8>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
> @@ -671,7 +670,6 @@
>  			reg-names = "regs", "addr_space";
>  			num-ib-windows = <6>;
>  			num-ob-windows = <8>;
> -			num-lanes = <2>;
>  			status = "disabled";
>  		};
>  
> @@ -687,7 +685,6 @@
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			num-lanes = <2>;
>  			num-viewport = <8>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
> @@ -709,7 +706,6 @@
>  			reg-names = "regs", "addr_space";
>  			num-ib-windows = <6>;
>  			num-ob-windows = <8>;
> -			num-lanes = <2>;
>  			status = "disabled";
>  		};
>  
> @@ -725,7 +721,6 @@
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			num-lanes = <2>;
>  			num-viewport = <8>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
> @@ -747,7 +742,6 @@
>  			reg-names = "regs", "addr_space";
>  			num-ib-windows = <6>;
>  			num-ob-windows = <8>;
> -			num-lanes = <2>;
>  			status = "disabled";
>  		};
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index dfbead405783..76c87afeba1e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -456,7 +456,6 @@
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			num-lanes = <4>;
>  			num-viewport = <256>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
> @@ -482,7 +481,6 @@
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			num-lanes = <4>;
>  			num-viewport = <6>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x28 0x00010000 0x0 0x00010000   /* downstream I/O */
> @@ -508,7 +506,6 @@
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			num-lanes = <8>;
>  			num-viewport = <6>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x30 0x00010000 0x0 0x00010000   /* downstream I/O */
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 64101c9962ce..7a0be8eaa84a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -639,7 +639,6 @@
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			num-lanes = <4>;
>  			num-viewport = <6>;
>  			bus-range = <0x0 0xff>;
>  			msi-parent = <&its>;
> @@ -661,7 +660,6 @@
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			num-lanes = <4>;
>  			num-viewport = <6>;
>  			bus-range = <0x0 0xff>;
>  			msi-parent = <&its>;
> @@ -683,7 +681,6 @@
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			num-lanes = <8>;
>  			num-viewport = <256>;
>  			bus-range = <0x0 0xff>;
>  			msi-parent = <&its>;
> @@ -705,7 +702,6 @@
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			dma-coherent;
> -			num-lanes = <4>;
>  			num-viewport = <6>;
>  			bus-range = <0x0 0xff>;
>  			msi-parent = <&its>;

Reviewed-by: Andrew Murray <andrew.murray@arm.com> 

> -- 
> 2.17.1
> 
