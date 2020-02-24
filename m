Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD7169BC3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 02:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgBXB2S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Feb 2020 20:28:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXB2S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Feb 2020 20:28:18 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D8582067D;
        Mon, 24 Feb 2020 01:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582507697;
        bh=wuZf8v7s/ZfDka2P3YUYpDnWNCA0VPIdBjzd5E5TqzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xinodtHybZ2zERMZboQ/lO0ba3tYO8hysLnZ+8z8p/HwgmJNwzOEtqGv0qefOr4nb
         e4PPc9NJ2J6knJJMxeZRa2va7rNicVIqLqghHXzDVFZxhc36nu4tZa5LuNkbVSRkDe
         KKy5Enhd/KSrF2UMpc/9V+590EtR5a/cz5g+V4FM=
Date:   Mon, 24 Feb 2020 09:28:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        m.karthikeyan@mobiveil.co.in, leoyang.li@nxp.com,
        lorenzo.pieralisi@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com,
        Xiaowei.Bao@nxp.com
Subject: Re: [PATCHv10 12/13] arm64: dts: lx2160a: Add PCIe controller DT
 nodes
Message-ID: <20200224012809.GB14331@dragon>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-13-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213040644.45858-13-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 12:06:43PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The LX2160A integrated 6 PCIe Gen4 controllers.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V10:
>  - No change
> 
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index e5ee5591e52b..aee2810d91cc 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -1076,5 +1076,168 @@
>  				};
>  			};
>  		};
> +
> +		pcie@3400000 {

The nodes should be sorted in unit-address.  That said, they should be
added after ata3: sata@3230000.

> +			compatible = "fsl,lx2160a-pcie";
> +			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
> +			       0x80 0x00000000 0x0 0x00001000>; /* configuration space */
> +			reg-names = "csr_axi_slave", "config_axi_slave";
> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +			interrupt-names = "aer", "pme", "intr";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			apio-wins = <8>;
> +			ppio-wins = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		pcie@3500000 {
> +			compatible = "fsl,lx2160a-pcie";
> +			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
> +			       0x88 0x00000000 0x0 0x00001000>; /* configuration space */
> +			reg-names = "csr_axi_slave", "config_axi_slave";
> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +			interrupt-names = "aer", "pme", "intr";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			apio-wins = <8>;
> +			ppio-wins = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		pcie@3600000 {
> +			compatible = "fsl,lx2160a-pcie";
> +			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
> +			       0x90 0x00000000 0x0 0x00001000>; /* configuration space */
> +			reg-names = "csr_axi_slave", "config_axi_slave";
> +			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +			interrupt-names = "aer", "pme", "intr";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			apio-wins = <256>;
> +			ppio-wins = <24>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		pcie@3700000 {
> +			compatible = "fsl,lx2160a-pcie";
> +			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
> +			       0x98 0x00000000 0x0 0x00001000>; /* configuration space */
> +			reg-names = "csr_axi_slave", "config_axi_slave";
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +			interrupt-names = "aer", "pme", "intr";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			apio-wins = <8>;
> +			ppio-wins = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		pcie@3800000 {
> +			compatible = "fsl,lx2160a-pcie";
> +			reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
> +			       0xa0 0x00000000 0x0 0x00001000>; /* configuration space */
> +			reg-names = "csr_axi_slave", "config_axi_slave";
> +			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +			interrupt-names = "aer", "pme", "intr";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			apio-wins = <256>;
> +			ppio-wins = <24>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		pcie@3900000 {
> +			compatible = "fsl,lx2160a-pcie";
> +			reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
> +			       0xa8 0x00000000 0x0 0x00001000>; /* configuration space */
> +			reg-names = "csr_axi_slave", "config_axi_slave";
> +			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +			interrupt-names = "aer", "pme", "intr";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			apio-wins = <8>;
> +			ppio-wins = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +

Unnecessary newline.

I fixed them up and applied the patch.

Shawn

>  	};
>  };
> -- 
> 2.17.1
> 
