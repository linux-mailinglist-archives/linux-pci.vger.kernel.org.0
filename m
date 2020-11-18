Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FED12B8668
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 22:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgKRVO3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 16:14:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37208 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRVO3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 16:14:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id m17so3855845oie.4;
        Wed, 18 Nov 2020 13:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TqcGINwohT+7UC/kHYM+8ER/mhekpmF0p0KJgia3/fc=;
        b=LTT2JcnOGUjAoUGobHRp+CGVtAj0J3ckp0EIcVd4YGNh5ojtqIjczhD8zD5xbV6K/j
         RO+7Ez9dXCKrFvIjPn98dr5IX+5PdvsRLBBmX4rppSCr7+dHXqE5uWhK9lCvRjnkjQo3
         1b9qStJFHo0Bqu+IecAp0RTzHZtkZLaZdOO+xEEccIc5X5qer6Ojckgo23nVrhR4/EfI
         g7w8Hb0x/07yT7460e280tYLR4b1mf8brc5CwefcLdDhamsqHid7ubi7/s0nhKTKu76Q
         GHyaIj2PO3nUXneAzDcmnHDSjmfNepmKLRoVWjcnHqz3bZmiZqJp0xjU5HdPCTq9AUjp
         TJSQ==
X-Gm-Message-State: AOAM5305HQmBWxA/9I9RM5OV6o5r1+ZqxlFr0DACK08y09IrDcpW1RIX
        /X66f+Qc+TzZdJZGCPoC8A==
X-Google-Smtp-Source: ABdhPJzefncKYXXmsPX44RYU6Xp+VUO4NqgZ4A2T6a/+gi6BlsihS5QQgyaUtK7XSf1UoVc+ec0qNQ==
X-Received: by 2002:aca:4387:: with SMTP id q129mr779432oia.108.1605734067523;
        Wed, 18 Nov 2020 13:14:27 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q3sm8455159oot.33.2020.11.18.13.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:14:26 -0800 (PST)
Received: (nullmailer pid 1827283 invoked by uid 1000);
        Wed, 18 Nov 2020 21:14:26 -0000
Date:   Wed, 18 Nov 2020 15:14:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes
 added for pcieX_ctrl
Message-ID: <20201118211426.GB1815279@bogus>
References: <20201116173141.31873-1-kishon@ti.com>
 <20201116173141.31873-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116173141.31873-4-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 11:01:41PM +0530, Kishon Vijay Abraham I wrote:
> Remove "syscon" nodes added for pcieX_ctrl and have the PCIe node
> point to the parent with an offset argument.

This should say breaks compatibility, but that fine because ????. It 
only landed in 5.9 and a new platform I suppose. 

> 
> Link: http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com

Should have a Fixes tag IMO.

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 48 ++++-------------------
>  1 file changed, 8 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 620e69e42974..23a0024dda79 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -28,38 +28,6 @@
>  		#size-cells = <1>;
>  		ranges = <0x0 0x0 0x00100000 0x1c000>;
>  
> -		pcie0_ctrl: syscon@4070 {
> -			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> -			reg = <0x00004070 0x4>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0x4070 0x4070 0x4>;
> -		};
> -
> -		pcie1_ctrl: syscon@4074 {
> -			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> -			reg = <0x00004074 0x4>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0x4074 0x4074 0x4>;
> -		};
> -
> -		pcie2_ctrl: syscon@4078 {
> -			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> -			reg = <0x00004078 0x4>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0x4078 0x4078 0x4>;
> -		};
> -
> -		pcie3_ctrl: syscon@407c {
> -			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> -			reg = <0x0000407c 0x4>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0x407c 0x407c 0x4>;
> -		};
> -
>  		serdes_ln_ctrl: mux@4080 {
>  			compatible = "mmio-mux";
>  			reg = <0x00004080 0x50>;
> @@ -619,7 +587,7 @@
>  		interrupt-names = "link_state";
>  		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
>  		device_type = "pci";
> -		ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
> +		ti,syscon-pcie-ctrl = <&scm_conf 0x4070>;
>  		max-link-speed = <3>;
>  		num-lanes = <2>;
>  		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
> @@ -646,7 +614,7 @@
>  		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
>  		interrupt-names = "link_state";
>  		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
> -		ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
> +		ti,syscon-pcie-ctrl = <&scm_conf 0x4070>;
>  		max-link-speed = <3>;
>  		num-lanes = <2>;
>  		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
> @@ -668,7 +636,7 @@
>  		interrupt-names = "link_state";
>  		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
>  		device_type = "pci";
> -		ti,syscon-pcie-ctrl = <&pcie1_ctrl>;
> +		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
>  		max-link-speed = <3>;
>  		num-lanes = <2>;
>  		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
> @@ -695,7 +663,7 @@
>  		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
>  		interrupt-names = "link_state";
>  		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
> -		ti,syscon-pcie-ctrl = <&pcie1_ctrl>;
> +		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
>  		max-link-speed = <3>;
>  		num-lanes = <2>;
>  		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
> @@ -717,7 +685,7 @@
>  		interrupt-names = "link_state";
>  		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
>  		device_type = "pci";
> -		ti,syscon-pcie-ctrl = <&pcie2_ctrl>;
> +		ti,syscon-pcie-ctrl = <&scm_conf 0x4078>;
>  		max-link-speed = <3>;
>  		num-lanes = <2>;
>  		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
> @@ -744,7 +712,7 @@
>  		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
>  		interrupt-names = "link_state";
>  		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
> -		ti,syscon-pcie-ctrl = <&pcie2_ctrl>;
> +		ti,syscon-pcie-ctrl = <&scm_conf 0x4078>;
>  		max-link-speed = <3>;
>  		num-lanes = <2>;
>  		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
> @@ -766,7 +734,7 @@
>  		interrupt-names = "link_state";
>  		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
>  		device_type = "pci";
> -		ti,syscon-pcie-ctrl = <&pcie3_ctrl>;
> +		ti,syscon-pcie-ctrl = <&scm_conf 0x407c>;
>  		max-link-speed = <3>;
>  		num-lanes = <2>;
>  		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
> @@ -793,7 +761,7 @@
>  		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
>  		interrupt-names = "link_state";
>  		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
> -		ti,syscon-pcie-ctrl = <&pcie3_ctrl>;
> +		ti,syscon-pcie-ctrl = <&scm_conf 0x407c>;
>  		max-link-speed = <3>;
>  		num-lanes = <2>;
>  		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
> -- 
> 2.17.1
> 
