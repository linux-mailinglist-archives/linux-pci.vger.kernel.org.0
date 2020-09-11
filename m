Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D720826762B
	for <lists+linux-pci@lfdr.de>; Sat, 12 Sep 2020 00:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgIKWua (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 18:50:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37130 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgIKWu2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 18:50:28 -0400
Received: by mail-io1-f68.google.com with SMTP id y13so12778944iow.4;
        Fri, 11 Sep 2020 15:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X7iH2gL3TGegBIDLIKlWXcEbx8NEf9M8ur9gTzrs3rc=;
        b=Tgpzd6xGczKMf7nhdbi+lbpqnD03goI4CjTBrS9XG9fhLT2gdUvrQm4k1Dc8HKvNg6
         AK167CdXDfxjEi4HKW3qlJn0wW5WFzsf8NcqtPa7EuJoT9P2fcW1ci0FDXWYkgUGbEhn
         uBXPFvuL3Ni+xr4qoX6J8CSR/3VAtWSWifnt2hmB+hARSltljWtriZepsZn2ou3CLtxC
         x1Eg2EU7f/PRYUpwpcNFX8YJjS7KG457jPdHxdD9lPb5hqHoF4q7JRaG62wdI7Cq9Tj+
         i0XUi5DDbnECKt+b/7Dt8iOBLhCpo7OVEDcyE1rLRHPZz/B9JuFJ3I+U97+UXGe3837T
         SFXA==
X-Gm-Message-State: AOAM5318Fff6sZVpqUeMRUWihqdXp3wbOssIQF26zQOxd6iKAzetq7/z
        AdQ+hjgx1yj+uhleQ8BGgg==
X-Google-Smtp-Source: ABdhPJyLgpUwEqdBoCEc1Uj+Z/n0aBHakYt3NgITVkM42PZL4627E/gOVbzkvk3u8Qh9QBXlEaZBkA==
X-Received: by 2002:a6b:da16:: with SMTP id x22mr3487643iob.33.1599864625891;
        Fri, 11 Sep 2020 15:50:25 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t10sm1900423iog.49.2020.09.11.15.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 15:50:25 -0700 (PDT)
Received: (nullmailer pid 2966093 invoked by uid 1000);
        Fri, 11 Sep 2020 22:50:24 -0000
Date:   Fri, 11 Sep 2020 16:50:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        yong.wu@mediatek.com, Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: pci: mediatek: Modified the Device
 tree bindings
Message-ID: <20200911225024.GB2960430@bogus>
References: <20200910061115.909-1-chuanjia.liu@mediatek.com>
 <20200910061115.909-2-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910061115.909-2-chuanjia.liu@mediatek.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 02:11:12PM +0800, Chuanjia Liu wrote:
> Split the PCIe node and add pciecfg node to fix MSI issue.
> 
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-cfg.yaml       |  38 +++++
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 144 +++++++++++-------
>  2 files changed, 129 insertions(+), 53 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> new file mode 100644
> index 000000000000..4d2835ab4858
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> @@ -0,0 +1,38 @@
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
> +            - mediatek,mt7622-pciecfg
> +            - mediatek,mt7629-pciecfg
> +        - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    pciecfg: pciecfg@1a140000 {
> +        compatible = "mediatek,mt7622-pciecfg", "syscon";
> +        reg = <0 0x1a140000 0 0x1000>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> index 7468d666763a..31e261933685 100644
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
> @@ -19,10 +19,10 @@ Required properties:
>     - sys_ckN :transaction layer and data link layer clock
>    Required entries for MT2701/MT7623:
>     - free_ck :for reference clock of PCIe subsys
> -  Required entries for MT2712/MT7622:
> +  Required entries for MT2712/MT7622/MT7629:
>     - ahb_ckN :AHB slave interface operating clock for CSR access and RC
>  	      initiated MMIO access
> -  Required entries for MT7622:
> +  Required entries for MT7622/MT7629:
>     - axi_ckN :application layer MMIO channel operating clock
>     - aux_ckN :pe2_mac_bridge and pe2_mac_core operating clock when
>  	      pcie_mac_ck/pcie_pipe_ck is turned off
> @@ -47,10 +47,13 @@ Required properties for MT7623/MT2701:
>  - reset-names: Must be "pcie-rst0", "pcie-rst1", "pcie-rstN".. based on the
>    number of root ports.
>  
> -Required properties for MT2712/MT7622:
> +Required properties for MT2712/MT7622/MT7629:
>  -interrupts: A list of interrupt outputs of the controller, must have one
>  	     entry for each PCIe port
>  
> +Required properties for MT7622/MT7629:
> +- mediatek,pcie-subsys: Should be a phandle of the pciecfg node.
> +

You don't need this. You can search for the node by compatible.

Plus it doesn't match the example.

>  In addition, the device tree node must have sub-nodes describing each
>  PCIe port interface, having the following mandatory properties:
>  
> @@ -143,56 +146,73 @@ Examples for MT7623:
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
> +		status = "disabled";
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
> +		status = "disabled";
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
> @@ -202,39 +222,31 @@ Examples for MT2712:
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
> +		mediatek,pcie-cfg = <&pciecfg>;
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
> +		status = "disabled";
>  
> -		pcie0: pcie@0,0 {
> +		slot0: pcie@0,0 {
>  			reg = <0x0000 0 0 0 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> @@ -251,8 +263,34 @@ Examples for MT7622:
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
> +		mediatek,pcie-cfg = <&pciecfg>;
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
> +		status = "disabled";
>  
> -		pcie1: pcie@1,0 {
> +		slot1: pcie@1,0 {
>  			reg = <0x0800 0 0 0 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> -- 
> 2.18.0
