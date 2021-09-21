Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0375D413A3B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 20:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhIUSoo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 14:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhIUSog (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 14:44:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537F2C061575;
        Tue, 21 Sep 2021 11:43:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t18so42065927wrb.0;
        Tue, 21 Sep 2021 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rF8wJWBUry98FnALCx856EJXkY0yc8D+oMwQoKs4yAA=;
        b=Mt01c1h1PCClo1XK44RVGwXotNKp5hq03SPTZ+03EAmVwmS3xtDYoT0G7za7gjceFT
         aHbsGYmrLAdQCsC19xR601jgE+JstEL3iuROr6YSR0a41Ddx63/QoOtOgn+ck7leq/er
         I8oQkGE7v5gJ4KuCyPNk3Ps5A7OJms/mkoTnmU1CkJZYax36GGdVBW2GCGbTguhV5cjO
         pJI3rd5gHrqF3HRTVe+6Ui52OZAJ+UNn+LYRcKr4BPcmJ2sm6sHuet9r82YkFL1+dkJ9
         ic/197tP2dzfU3Dz5xHMfLO0OzLtB33C0qo2WRn+xcyHKpue7NHsolS5uGDk4M2/XmnP
         8Inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rF8wJWBUry98FnALCx856EJXkY0yc8D+oMwQoKs4yAA=;
        b=V5pTwLxVjm6MrILBtHh3bU+6WNw+Gk/T44nQ76szP3XhheFHzo/rLd0yahFc6T5HmM
         sVPwSCaxU3ESM/NHfivo+Xg/POw0d59JdTVnyWJWRpyekZ2FOc+cODqh0yp6lqW5Ffet
         VdsHcdALWYL29j1OKocuIOUM8hlISY7VkncUcDs6mgmyeWwNFoPFE5+95quUjKXOJXuz
         KcB02Qg4WL0dkX6tb2LXNMkH5+I+yX0T8n6k/M+UQjwPgHOEBnnoC1vqHexb1KNwSydh
         LeINmNVZEAMtEmpT4a024Lpp4Qza9+1m+mHsvJBsSi6fGUOYBS5B6HvmmibuarZKd5Iy
         +jPA==
X-Gm-Message-State: AOAM531EY4p+5CfpzP0doUOvO6FRHtshED3EoUSMey7l3osIKnldXvDH
        eCWTqr6sd0J94T0DLP3yUwo=
X-Google-Smtp-Source: ABdhPJwDrbocziC/FxPik10J+mNPbhs7vJCodT4L9Ss/+gg5pYrzfdMAVno4u1IcPJgEayIxHX0cpQ==
X-Received: by 2002:a5d:59a4:: with SMTP id p4mr36131476wrr.332.1632249785784;
        Tue, 21 Sep 2021 11:43:05 -0700 (PDT)
Received: from [192.168.2.177] ([206.204.146.29])
        by smtp.gmail.com with ESMTPSA id i9sm3903163wmi.44.2021.09.21.11.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 11:43:05 -0700 (PDT)
Message-ID: <668b6ebb-e929-1305-de64-0b2a5d38391b@gmail.com>
Date:   Tue, 21 Sep 2021 20:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v12 5/6] arm64: dts: mediatek: Split PCIe node for MT2712
 and MT7622
Content-Language: en-US
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>, robh+dt@kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com
Cc:     ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
        yong.wu@mediatek.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210823032800.1660-1-chuanjia.liu@mediatek.com>
 <20210823032800.1660-6-chuanjia.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20210823032800.1660-6-chuanjia.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 23/08/2021 05:27, Chuanjia Liu wrote:
> There are two independent PCIe controllers in MT2712 and MT7622
> platform. Each of them should contain an independent MSI domain.
> 
> In old dts architecture, MSI domain will be inherited from the root
> bridge, and all of the devices will share the same MSI domain.
> Hence that, the PCIe devices will not work properly if the irq number
> which required is more than 32.
> 
> Split the PCIe node for MT2712 and MT7622 platform to comply with
> the hardware design and fix MSI issue.
> 
> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>

Queued in v5.15-next/dts64

Thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |  97 +++++++--------
>   .../dts/mediatek/mt7622-bananapi-bpi-r64.dts  |  16 ++-
>   arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts  |   6 +-
>   arch/arm64/boot/dts/mediatek/mt7622.dtsi      | 112 ++++++++++--------
>   4 files changed, 118 insertions(+), 113 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> index a9cca9c146fd..de16c0d80c30 100644
> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> @@ -915,64 +915,67 @@
>   		};
>   	};
>   
> -	pcie: pcie@11700000 {
> +	pcie1: pcie@112ff000 {
>   		compatible = "mediatek,mt2712-pcie";
>   		device_type = "pci";
> -		reg = <0 0x11700000 0 0x1000>,
> -		      <0 0x112ff000 0 0x1000>;
> -		reg-names = "port0", "port1";
> +		reg = <0 0x112ff000 0 0x1000>;
> +		reg-names = "port1";
> +		linux,pci-domain = <1>;
>   		#address-cells = <3>;
>   		#size-cells = <2>;
> -		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&topckgen CLK_TOP_PE2_MAC_P0_SEL>,
> -			 <&topckgen CLK_TOP_PE2_MAC_P1_SEL>,
> -			 <&pericfg CLK_PERI_PCIE0>,
> +		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "pcie_irq";
> +		clocks = <&topckgen CLK_TOP_PE2_MAC_P1_SEL>,
>   			 <&pericfg CLK_PERI_PCIE1>;
> -		clock-names = "sys_ck0", "sys_ck1", "ahb_ck0", "ahb_ck1";
> -		phys = <&u3port0 PHY_TYPE_PCIE>, <&u3port1 PHY_TYPE_PCIE>;
> -		phy-names = "pcie-phy0", "pcie-phy1";
> +		clock-names = "sys_ck1", "ahb_ck1";
> +		phys = <&u3port1 PHY_TYPE_PCIE>;
> +		phy-names = "pcie-phy1";
>   		bus-range = <0x00 0xff>;
> -		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x10000000>;
> +		ranges = <0x82000000 0 0x11400000  0x0 0x11400000  0 0x300000>;
> +		status = "disabled";
>   
> -		pcie0: pcie@0,0 {
> -			device_type = "pci";
> -			status = "disabled";
> -			reg = <0x0000 0 0 0 0>;
> -			#address-cells = <3>;
> -			#size-cells = <2>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> +				<0 0 0 2 &pcie_intc1 1>,
> +				<0 0 0 3 &pcie_intc1 2>,
> +				<0 0 0 4 &pcie_intc1 3>;
> +		pcie_intc1: interrupt-controller {
> +			interrupt-controller;
> +			#address-cells = <0>;
>   			#interrupt-cells = <1>;
> -			ranges;
> -			interrupt-map-mask = <0 0 0 7>;
> -			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> -					<0 0 0 2 &pcie_intc0 1>,
> -					<0 0 0 3 &pcie_intc0 2>,
> -					<0 0 0 4 &pcie_intc0 3>;
> -			pcie_intc0: interrupt-controller {
> -				interrupt-controller;
> -				#address-cells = <0>;
> -				#interrupt-cells = <1>;
> -			};
>   		};
> +	};
>   
> -		pcie1: pcie@1,0 {
> -			device_type = "pci";
> -			status = "disabled";
> -			reg = <0x0800 0 0 0 0>;
> -			#address-cells = <3>;
> -			#size-cells = <2>;
> +	pcie0: pcie@11700000 {
> +		compatible = "mediatek,mt2712-pcie";
> +		device_type = "pci";
> +		reg = <0 0x11700000 0 0x1000>;
> +		reg-names = "port0";
> +		linux,pci-domain = <0>;
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
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> +				<0 0 0 2 &pcie_intc0 1>,
> +				<0 0 0 3 &pcie_intc0 2>,
> +				<0 0 0 4 &pcie_intc0 3>;
> +		pcie_intc0: interrupt-controller {
> +			interrupt-controller;
> +			#address-cells = <0>;
>   			#interrupt-cells = <1>;
> -			ranges;
> -			interrupt-map-mask = <0 0 0 7>;
> -			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> -					<0 0 0 2 &pcie_intc1 1>,
> -					<0 0 0 3 &pcie_intc1 2>,
> -					<0 0 0 4 &pcie_intc1 3>;
> -			pcie_intc1: interrupt-controller {
> -				interrupt-controller;
> -				#address-cells = <0>;
> -				#interrupt-cells = <1>;
> -			};
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> index 2f77dc40b9b8..2b9bf8dd14ec 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> @@ -257,18 +257,16 @@
>   	};
>   };
>   
> -&pcie {
> +&pcie0 {
>   	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie0_pins>, <&pcie1_pins>;
> +	pinctrl-0 = <&pcie0_pins>;
>   	status = "okay";
> +};
>   
> -	pcie@0,0 {
> -		status = "okay";
> -	};
> -
> -	pcie@1,0 {
> -		status = "okay";
> -	};
> +&pcie1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_pins>;
> +	status = "okay";
>   };
>   
>   &pio {
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> index f2dc850010f1..596c073d8b05 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> @@ -234,14 +234,10 @@
>   	};
>   };
>   
> -&pcie {
> +&pcie0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pcie0_pins>;
>   	status = "okay";
> -
> -	pcie@0,0 {
> -		status = "okay";
> -	};
>   };
>   
>   &pio {
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 890a942ec608..6f8cb3ad1e84 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -781,75 +781,83 @@
>   		#reset-cells = <1>;
>   	};
>   
> -	pcie: pcie@1a140000 {
> +	pciecfg: pciecfg@1a140000 {
> +		compatible = "mediatek,generic-pciecfg", "syscon";
> +		reg = <0 0x1a140000 0 0x1000>;
> +	};
> +
> +	pcie0: pcie@1a143000 {
>   		compatible = "mediatek,mt7622-pcie";
>   		device_type = "pci";
> -		reg = <0 0x1a140000 0 0x1000>,
> -		      <0 0x1a143000 0 0x1000>,
> -		      <0 0x1a145000 0 0x1000>;
> -		reg-names = "subsys", "port0", "port1";
> +		reg = <0 0x1a143000 0 0x1000>;
> +		reg-names = "port0";
> +		linux,pci-domain = <0>;
>   		#address-cells = <3>;
>   		#size-cells = <2>;
> -		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "pcie_irq";
>   		clocks = <&pciesys CLK_PCIE_P0_MAC_EN>,
> -			 <&pciesys CLK_PCIE_P1_MAC_EN>,
> -			 <&pciesys CLK_PCIE_P0_AHB_EN>,
>   			 <&pciesys CLK_PCIE_P0_AHB_EN>,
>   			 <&pciesys CLK_PCIE_P0_AUX_EN>,
> -			 <&pciesys CLK_PCIE_P1_AUX_EN>,
>   			 <&pciesys CLK_PCIE_P0_AXI_EN>,
> -			 <&pciesys CLK_PCIE_P1_AXI_EN>,
>   			 <&pciesys CLK_PCIE_P0_OBFF_EN>,
> -			 <&pciesys CLK_PCIE_P1_OBFF_EN>,
> -			 <&pciesys CLK_PCIE_P0_PIPE_EN>,
> -			 <&pciesys CLK_PCIE_P1_PIPE_EN>;
> -		clock-names = "sys_ck0", "sys_ck1", "ahb_ck0", "ahb_ck1",
> -			      "aux_ck0", "aux_ck1", "axi_ck0", "axi_ck1",
> -			      "obff_ck0", "obff_ck1", "pipe_ck0", "pipe_ck1";
> +			 <&pciesys CLK_PCIE_P0_PIPE_EN>;
> +		clock-names = "sys_ck0", "ahb_ck0", "aux_ck0",
> +			      "axi_ck0", "obff_ck0", "pipe_ck0";
> +
>   		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
>   		bus-range = <0x00 0xff>;
> -		ranges = <0x82000000 0 0x20000000 0x0 0x20000000 0 0x10000000>;
> +		ranges = <0x82000000 0 0x20000000 0x0 0x20000000 0 0x8000000>;
>   		status = "disabled";
>   
> -		pcie0: pcie@0,0 {
> -			reg = <0x0000 0 0 0 0>;
> -			#address-cells = <3>;
> -			#size-cells = <2>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> +				<0 0 0 2 &pcie_intc0 1>,
> +				<0 0 0 3 &pcie_intc0 2>,
> +				<0 0 0 4 &pcie_intc0 3>;
> +		pcie_intc0: interrupt-controller {
> +			interrupt-controller;
> +			#address-cells = <0>;
>   			#interrupt-cells = <1>;
> -			ranges;
> -			status = "disabled";
> -
> -			interrupt-map-mask = <0 0 0 7>;
> -			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> -					<0 0 0 2 &pcie_intc0 1>,
> -					<0 0 0 3 &pcie_intc0 2>,
> -					<0 0 0 4 &pcie_intc0 3>;
> -			pcie_intc0: interrupt-controller {
> -				interrupt-controller;
> -				#address-cells = <0>;
> -				#interrupt-cells = <1>;
> -			};
>   		};
> +	};
>   
> -		pcie1: pcie@1,0 {
> -			reg = <0x0800 0 0 0 0>;
> -			#address-cells = <3>;
> -			#size-cells = <2>;
> +	pcie1: pcie@1a145000 {
> +		compatible = "mediatek,mt7622-pcie";
> +		device_type = "pci";
> +		reg = <0 0x1a145000 0 0x1000>;
> +		reg-names = "port1";
> +		linux,pci-domain = <1>;
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
> +		ranges = <0x82000000 0 0x28000000 0x0 0x28000000 0 0x8000000>;
> +		status = "disabled";
> +
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> +				<0 0 0 2 &pcie_intc1 1>,
> +				<0 0 0 3 &pcie_intc1 2>,
> +				<0 0 0 4 &pcie_intc1 3>;
> +		pcie_intc1: interrupt-controller {
> +			interrupt-controller;
> +			#address-cells = <0>;
>   			#interrupt-cells = <1>;
> -			ranges;
> -			status = "disabled";
> -
> -			interrupt-map-mask = <0 0 0 7>;
> -			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> -					<0 0 0 2 &pcie_intc1 1>,
> -					<0 0 0 3 &pcie_intc1 2>,
> -					<0 0 0 4 &pcie_intc1 3>;
> -			pcie_intc1: interrupt-controller {
> -				interrupt-controller;
> -				#address-cells = <0>;
> -				#interrupt-cells = <1>;
> -			};
>   		};
>   	};
>   
> 
