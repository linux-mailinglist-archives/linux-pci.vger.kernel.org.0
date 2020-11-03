Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3118E2A5A5C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 23:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgKCW4u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 17:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgKCW4u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 17:56:50 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C150F22403;
        Tue,  3 Nov 2020 22:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604444209;
        bh=dRvs3Am9oi+dA2dshDT8rT6pIILXvzWwIyROrQ713no=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kgXzOdjv0e2RHQFQbvN1XLgo+FvY8K6dNJy7rHGfSSuPaR+BNjyLEIA31cXku9fOc
         pndJu5Y8KvJA48KZVpre6qRJRE++hFK6aQShmUQ+mMBonQ6R5ZOVVb1LnDlOhUKWJF
         TheSOIMjjheJIdCSxENvMHHVJjn5dTM3rKIz2Qxg=
Date:   Tue, 3 Nov 2020 16:56:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-pci@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, yong.wu@mediatek.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 1/4] dt-bindings: pci: mediatek: Modified the Device
 tree bindings
Message-ID: <20201103225647.GA272422@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029081513.10562-2-chuanjia.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Run "git log --oneline" and follow the convention, e.g.,

  dt-bindings: PCI: mediatek: ...

On Thu, Oct 29, 2020 at 04:15:10PM +0800, Chuanjia Liu wrote:
> Split the PCIe node and add pciecfg node to fix MSI issue.

I assume "split" refers to the new yaml file?  It's not really obvious
how the two files are connected.

Could this be done in two patches?  One for the split and one for the
MSI issue?

It'd be nice to say something more about the MSI issue.

> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-cfg.yaml       |  39 ++++++
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 129 +++++++++++-------
>  2 files changed, 118 insertions(+), 50 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> new file mode 100644
> index 000000000000..d3ecbcd032a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/mediatek-pcie-cfg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek PCIECFG controller
> +
> +maintainers:
> +  - Chuanjia Liu <chuanjia.liu@mediatek.com>
> +  - Jianjun Wang <jianjun.wang@mediatek.com>
> +
> +description: |
> +  The MediaTek PCIECFG controller controls some feature about
> +  LTSSM, ASPM and so on.
> +
> +properties:
> +  compatible:
> +      items:
> +        - enum:
> +            - mediatek,generic-pciecfg
> +        - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pciecfg: pciecfg@1a140000 {
> +        compatible = "mediatek,generic-pciecfg", "syscon";
> +        reg = <0x1a140000 0x1000>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> index 7468d666763a..c14a2745de37 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> @@ -8,7 +8,7 @@ Required properties:
>  	"mediatek,mt7623-pcie"
>  	"mediatek,mt7629-pcie"
>  - device_type: Must be "pci"
> -- reg: Base addresses and lengths of the PCIe subsys and root ports.
> +- reg: Base addresses and lengths of the root ports.
>  - reg-names: Names of the above areas to use during resource lookup.
>  - #address-cells: Address representation for root ports (must be 3)
>  - #size-cells: Size representation for root ports (must be 2)
> @@ -143,56 +143,71 @@ Examples for MT7623:
>  
>  Examples for MT2712:
>  
> -	pcie: pcie@11700000 {
> +	pcie1: pcie@112ff000 {
>  		compatible = "mediatek,mt2712-pcie";
>  		device_type = "pci";
> -		reg = <0 0x11700000 0 0x1000>,
> -		      <0 0x112ff000 0 0x1000>;
> -		reg-names = "port0", "port1";
> +		reg = <0 0x112ff000 0 0x1000>;
> +		reg-names = "port1";
>  		#address-cells = <3>;
>  		#size-cells = <2>;
> -		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&topckgen CLK_TOP_PE2_MAC_P0_SEL>,
> -			 <&topckgen CLK_TOP_PE2_MAC_P1_SEL>,
> -			 <&pericfg CLK_PERI_PCIE0>,
> +		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "pcie_irq";
> +		clocks = <&topckgen CLK_TOP_PE2_MAC_P1_SEL>,
>  			 <&pericfg CLK_PERI_PCIE1>;
> -		clock-names = "sys_ck0", "sys_ck1", "ahb_ck0", "ahb_ck1";
> -		phys = <&pcie0_phy PHY_TYPE_PCIE>, <&pcie1_phy PHY_TYPE_PCIE>;
> -		phy-names = "pcie-phy0", "pcie-phy1";
> +		clock-names = "sys_ck1", "ahb_ck1";
> +		phys = <&u3port1 PHY_TYPE_PCIE>;
> +		phy-names = "pcie-phy1";
>  		bus-range = <0x00 0xff>;
> -		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x10000000>;
> +		ranges = <0x82000000 0 0x11400000  0x0 0x11400000  0 0x300000>;
>  
> -		pcie0: pcie@0,0 {
> -			reg = <0x0000 0 0 0 0>;
> +		slot1: pcie@1,0 {
> +			reg = <0x0800 0 0 0 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			#interrupt-cells = <1>;
>  			ranges;
>  			interrupt-map-mask = <0 0 0 7>;
> -			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> -					<0 0 0 2 &pcie_intc0 1>,
> -					<0 0 0 3 &pcie_intc0 2>,
> -					<0 0 0 4 &pcie_intc0 3>;
> -			pcie_intc0: interrupt-controller {
> +			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> +					<0 0 0 2 &pcie_intc1 1>,
> +					<0 0 0 3 &pcie_intc1 2>,
> +					<0 0 0 4 &pcie_intc1 3>;
> +			pcie_intc1: interrupt-controller {
>  				interrupt-controller;
>  				#address-cells = <0>;
>  				#interrupt-cells = <1>;
>  			};
>  		};
> +	};
>  
> -		pcie1: pcie@1,0 {
> -			reg = <0x0800 0 0 0 0>;
> +	pcie0: pcie@11700000 {
> +		compatible = "mediatek,mt2712-pcie";
> +		device_type = "pci";
> +		reg = <0 0x11700000 0 0x1000>;
> +		reg-names = "port0";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "pcie_irq";
> +		clocks = <&topckgen CLK_TOP_PE2_MAC_P0_SEL>,
> +			 <&pericfg CLK_PERI_PCIE0>;
> +		clock-names = "sys_ck0", "ahb_ck0";
> +		phys = <&u3port0 PHY_TYPE_PCIE>;
> +		phy-names = "pcie-phy0";
> +		bus-range = <0x00 0xff>;
> +		ranges = <0x82000000 0 0x20000000 0x0 0x20000000 0 0x10000000>;
> +
> +		slot0: pcie@0,0 {
> +			reg = <0x0000 0 0 0 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			#interrupt-cells = <1>;
>  			ranges;
>  			interrupt-map-mask = <0 0 0 7>;
> -			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> -					<0 0 0 2 &pcie_intc1 1>,
> -					<0 0 0 3 &pcie_intc1 2>,
> -					<0 0 0 4 &pcie_intc1 3>;
> -			pcie_intc1: interrupt-controller {
> +			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> +					<0 0 0 2 &pcie_intc0 1>,
> +					<0 0 0 3 &pcie_intc0 2>,
> +					<0 0 0 4 &pcie_intc0 3>;
> +			pcie_intc0: interrupt-controller {
>  				interrupt-controller;
>  				#address-cells = <0>;
>  				#interrupt-cells = <1>;
> @@ -202,39 +217,29 @@ Examples for MT2712:
>  
>  Examples for MT7622:
>  
> -	pcie: pcie@1a140000 {
> +	pcie0: pcie@1a143000 {
>  		compatible = "mediatek,mt7622-pcie";
>  		device_type = "pci";
> -		reg = <0 0x1a140000 0 0x1000>,
> -		      <0 0x1a143000 0 0x1000>,
> -		      <0 0x1a145000 0 0x1000>;
> -		reg-names = "subsys", "port0", "port1";
> +		reg = <0 0x1a143000 0 0x1000>;
> +		reg-names = "port0";
>  		#address-cells = <3>;
>  		#size-cells = <2>;
> -		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "pcie_irq";
>  		clocks = <&pciesys CLK_PCIE_P0_MAC_EN>,
> -			 <&pciesys CLK_PCIE_P1_MAC_EN>,
>  			 <&pciesys CLK_PCIE_P0_AHB_EN>,
> -			 <&pciesys CLK_PCIE_P1_AHB_EN>,
>  			 <&pciesys CLK_PCIE_P0_AUX_EN>,
> -			 <&pciesys CLK_PCIE_P1_AUX_EN>,
>  			 <&pciesys CLK_PCIE_P0_AXI_EN>,
> -			 <&pciesys CLK_PCIE_P1_AXI_EN>,
>  			 <&pciesys CLK_PCIE_P0_OBFF_EN>,
> -			 <&pciesys CLK_PCIE_P1_OBFF_EN>,
> -			 <&pciesys CLK_PCIE_P0_PIPE_EN>,
> -			 <&pciesys CLK_PCIE_P1_PIPE_EN>;
> -		clock-names = "sys_ck0", "sys_ck1", "ahb_ck0", "ahb_ck1",
> -			      "aux_ck0", "aux_ck1", "axi_ck0", "axi_ck1",
> -			      "obff_ck0", "obff_ck1", "pipe_ck0", "pipe_ck1";
> -		phys = <&pcie0_phy PHY_TYPE_PCIE>, <&pcie1_phy PHY_TYPE_PCIE>;
> -		phy-names = "pcie-phy0", "pcie-phy1";
> +			 <&pciesys CLK_PCIE_P0_PIPE_EN>;
> +		clock-names = "sys_ck0", "ahb_ck0", "aux_ck0",
> +			      "axi_ck0", "obff_ck0", "pipe_ck0";
> +
>  		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
>  		bus-range = <0x00 0xff>;
> -		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x10000000>;
> +		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x8000000>;
>  
> -		pcie0: pcie@0,0 {
> +		slot0: pcie@0,0 {
>  			reg = <0x0000 0 0 0 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> @@ -251,8 +256,32 @@ Examples for MT7622:
>  				#interrupt-cells = <1>;
>  			};
>  		};
> +	};
> +
> +	pcie1: pcie@1a145000 {
> +		compatible = "mediatek,mt7622-pcie";
> +		device_type = "pci";
> +		reg = <0 0x1a145000 0 0x1000>;
> +		reg-names = "port1";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "pcie_irq";
> +		clocks = <&pciesys CLK_PCIE_P1_MAC_EN>,
> +			 /* designer has connect RC1 with p0_ahb clock */
> +			 <&pciesys CLK_PCIE_P0_AHB_EN>,
> +			 <&pciesys CLK_PCIE_P1_AUX_EN>,
> +			 <&pciesys CLK_PCIE_P1_AXI_EN>,
> +			 <&pciesys CLK_PCIE_P1_OBFF_EN>,
> +			 <&pciesys CLK_PCIE_P1_PIPE_EN>;
> +		clock-names = "sys_ck1", "ahb_ck1", "aux_ck1",
> +			      "axi_ck1", "obff_ck1", "pipe_ck1";
> +
> +		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
> +		bus-range = <0x00 0xff>;
> +		ranges = <0x82000000 0 0x28000000  0x0 0x28000000  0 0x8000000>;
>  
> -		pcie1: pcie@1,0 {
> +		slot1: pcie@1,0 {
>  			reg = <0x0800 0 0 0 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> -- 
> 2.18.0
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
