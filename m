Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61732A5A4C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 23:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgKCWvt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 17:51:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbgKCWvt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 17:51:49 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 532222074F;
        Tue,  3 Nov 2020 22:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604443908;
        bh=ZTc1hgZLMSAMqmuiHXxbYJqFXykktHOtVDml/cKUNQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K6DzT0ksd3lJgCr+h18+p8FlRdsdY5B8CYGfhGx6IshX9G71zdkA9OJEr5+v+WnDG
         W3iKWYFFhiCFyIbrWhP2aLH+7d5F0y6cuF5faq3ECbKRZHQPrufds4Y6x+gApQdyqF
         tJnQfARtjZ6R8PTljKHYcG1GsqgzSnRWzcTbsJOU=
Date:   Tue, 3 Nov 2020 16:51:47 -0600
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
Subject: Re: [PATCH v7 4/4] ARM: dts: mediatek: Modified MT7629 PCIe node
Message-ID: <20201103225147.GA272037@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029081513.10562-5-chuanjia.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This subject line is pointless.

Every patch modifies something.  Give us a hint about what you
modified and why.

And use the present tense verb, i.e., "Modify ...", not "Modified".
Probably "Add" would be better than "Modify".  Or "Update" with some
meaningful description of the update.

On Thu, Oct 29, 2020 at 04:15:13PM +0800, Chuanjia Liu wrote:
> Remove unused property and add pciecfg node.

Apparently this also removes "subsys" from the "reg" property.
And removes an interrupt.  And adds "pcie_irq".

> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  arch/arm/boot/dts/mt7629-rfb.dts |  3 ++-
>  arch/arm/boot/dts/mt7629.dtsi    | 22 ++++++++++++----------
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7629-rfb.dts b/arch/arm/boot/dts/mt7629-rfb.dts
> index 9980c10c6e29..eb536cbebd9b 100644
> --- a/arch/arm/boot/dts/mt7629-rfb.dts
> +++ b/arch/arm/boot/dts/mt7629-rfb.dts
> @@ -140,9 +140,10 @@
>  	};
>  };
>  
> -&pcie {
> +&pcie1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pcie_pins>;
> +	status = "okay";
>  };
>  
>  &pciephy1 {
> diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
> index 5cbb3d244c75..6d6397f0c2fc 100644
> --- a/arch/arm/boot/dts/mt7629.dtsi
> +++ b/arch/arm/boot/dts/mt7629.dtsi
> @@ -360,16 +360,20 @@
>  			#reset-cells = <1>;
>  		};
>  
> -		pcie: pcie@1a140000 {
> +		pciecfg: pciecfg@1a140000 {
> +			compatible = "mediatek,generic-pciecfg", "syscon";
> +			reg = <0x1a140000 0x1000>;
> +		};
> +
> +		pcie1: pcie@1a145000 {
>  			compatible = "mediatek,mt7629-pcie";
>  			device_type = "pci";
> -			reg = <0x1a140000 0x1000>,
> -			      <0x1a145000 0x1000>;
> -			reg-names = "subsys","port1";
> +			reg = <0x1a145000 0x1000>;
> +			reg-names = "port1";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> -			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_LOW>,
> -				     <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-names = "pcie_irq";
>  			clocks = <&pciesys CLK_PCIE_P1_MAC_EN>,
>  				 <&pciesys CLK_PCIE_P0_AHB_EN>,
>  				 <&pciesys CLK_PCIE_P1_AUX_EN>,
> @@ -390,21 +394,19 @@
>  			power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
>  			bus-range = <0x00 0xff>;
>  			ranges = <0x82000000 0 0x20000000 0x20000000 0 0x10000000>;
> +			status = "disabled";
>  
> -			pcie1: pcie@1,0 {
> -				device_type = "pci";
> +			slot1: pcie@1,0 {
>  				reg = <0x0800 0 0 0 0>;
>  				#address-cells = <3>;
>  				#size-cells = <2>;
>  				#interrupt-cells = <1>;
>  				ranges;
> -				num-lanes = <1>;
>  				interrupt-map-mask = <0 0 0 7>;
>  				interrupt-map = <0 0 0 1 &pcie_intc1 0>,
>  						<0 0 0 2 &pcie_intc1 1>,
>  						<0 0 0 3 &pcie_intc1 2>,
>  						<0 0 0 4 &pcie_intc1 3>;
> -
>  				pcie_intc1: interrupt-controller {
>  					interrupt-controller;
>  					#address-cells = <0>;
> -- 
> 2.18.0
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
