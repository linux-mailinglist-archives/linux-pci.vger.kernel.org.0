Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1232925DC
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 12:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgJSKbG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 06:31:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33883 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgJSKbF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 06:31:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id k21so1768294wmi.1;
        Mon, 19 Oct 2020 03:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y7i1TyZUzmXRsY5pIxFL2MFRDCxpc5Am6FYuPxwF2JM=;
        b=dOlj1cc4iHLM7eX8S2LYO+Ix7GuvosGE/z4PSID6oCz1x4bRjNaRbfazpr5eiPX/ns
         0mfAhI/7rfw3U5DOof9ywhT1ShNDqAUbVthUUKGVto7d/KTWfDdVrAe9wcnGdJ2UuyDR
         aX9zZQJVwWcgea/F/+RAMTLHiV8sJqj/yNuprJ/aPWHHgi5twDF9bMG+8A8aaQOC0492
         /rMzeh7aEtMyNQ0VMDzkd8T+r4Y+HUBQqkkkv0DxtPM7WBi4/E0GekSSTqVMAdvD3LTs
         kmyuhnGOLPFvqYB6x5S/Bb4cQ/lC4JQJN9aypx4KR48J1ApAfmhQ2AQ4ApJb1KKJKffo
         XlUw==
X-Gm-Message-State: AOAM532PSGlQGAaqL+tfGU0tOli2s4bWftTs9ogtVUYEPKYI2GMEjNuM
        jOz3yt5AdzkpjEk7M0eMggc=
X-Google-Smtp-Source: ABdhPJzv+DIuqd5ahzA1hbcPTTIGhKeXBZqDPa3ze3Rv54OxSc12Y4upe+A5hdcUtmovpn6m5MPzrQ==
X-Received: by 2002:a7b:cb8c:: with SMTP id m12mr17665894wmi.12.1603103463585;
        Mon, 19 Oct 2020 03:31:03 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id t12sm17586959wrm.25.2020.10.19.03.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 03:31:02 -0700 (PDT)
Date:   Mon, 19 Oct 2020 12:31:00 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 6/6] arm64: dts: exynos: add the WiFi/PCIe support to
 TM2(e) boards
Message-ID: <20201019103100.GA53305@kozik-lap>
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
 <CGME20201019094741eucas1p1b4934cd5024a18804fcee921294acee0@eucas1p1.samsung.com>
 <20201019094715.15343-7-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019094715.15343-7-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 11:47:15AM +0200, Marek Szyprowski wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Add the nodes relevant to PCIe PHY and PCIe support. PCIe is used for the
> WiFi interface (Broadcom Limited BCM4358 802.11ac Wireless LAN SoC).
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> [mszyprow: rewrote commit message, reworked board/generic dts/dtsi split]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../boot/dts/exynos/exynos5433-pinctrl.dtsi   |  2 +-
>  .../dts/exynos/exynos5433-tm2-common.dtsi     | 24 ++++++++++++-
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi    | 36 +++++++++++++++++++
>  3 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
> index 9df7c65593a1..32a6518517e5 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
> @@ -329,7 +329,7 @@
>  	};
>  
>  	pcie_bus: pcie_bus {
> -		samsung,pins = "gpr3-4", "gpr3-5", "gpr3-6", "gpr3-7";
> +		samsung,pins = "gpr3-4", "gpr3-5", "gpr3-6";
>  		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
>  		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>  	};
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index 829fea23d4ab..ef45ef86c48d 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -969,6 +969,25 @@
>  	bus-width = <4>;
>  };
>  
> +&pcie {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_bus &pcie_wlanen>;
> +	vdd10-supply = <&ldo6_reg>;
> +	vdd18-supply = <&ldo7_reg>;
> +	assigned-clocks = <&cmu_fsys CLK_MOUT_SCLK_PCIE_100_USER>,
> +			<&cmu_top CLK_MOUT_SCLK_PCIE_100>;
> +	assigned-clock-parents = <&cmu_top CLK_SCLK_PCIE_100_FSYS>,
> +			<&cmu_top CLK_MOUT_BUS_PLL_USER>;
> +	assigned-clock-rates = <0>, <100000000>;
> +	interrupt-map-mask = <0 0 0 0>;
> +	interrupt-map = <0 0 0 0 &gic GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&pcie_phy {
> +	status = "okay";
> +};
> +
>  &ppmu_d0_general {
>  	status = "okay";
>  	events {
> @@ -1085,8 +1104,11 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&initial_ese>;
>  
> +	pcie_wlanen: pcie-wlanen {
> +		PIN(INPUT, gpj2-0, UP, FAST_SR4);
> +	};
> +
>  	initial_ese: initial-state {
> -		PIN(INPUT, gpj2-0, DOWN, FAST_SR1);
>  		PIN(INPUT, gpj2-1, DOWN, FAST_SR1);
>  		PIN(INPUT, gpj2-2, DOWN, FAST_SR1);
>  	};
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 8eb4576da8f3..be2d1753d1d1 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -1029,6 +1029,11 @@
>  			reg = <0x145f0000 0x1038>;
>  		};
>  
> +		syscon_fsys: syscon@156f0000 {
> +			compatible = "syscon";
> +			reg = <0x156f0000 0x1044>;
> +		};
> +
>  		gsc_0: video-scaler@13c00000 {
>  			compatible = "samsung,exynos5433-gsc";
>  			reg = <0x13c00000 0x1000>;
> @@ -1830,6 +1835,37 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		pcie_phy: pcie-phy@15680000 {
> +			compatible = "samsung,exynos5433-pcie-phy";
> +			reg = <0x15680000 0x1000>;
> +			samsung,pmu-syscon = <&pmu_system_controller>;
> +			samsung,fsys-sysreg = <&syscon_fsys>;
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		pcie: pcie@15700000 {
> +			compatible = "samsung,exynos5433-pcie";
> +			reg = <0x156b0000 0x1000>, <0x15700000 0x1000>,
> +			      <0x0c000000 0x1000>;

dtc should complain here:
arch/arm64/boot/dts/exynos/exynos5433.dtsi:1848.23-1868.5: Warning (simple_bus_reg): /soc@0/pcie@15700000: simple-bus unit address format error, expected "156b0000"

> +			reg-names = "elbi", "dbi", "config";

This does not match your own bindings:
pcie@15700000: reg-names:1: 'bdi' was expected
pcie@15700000: 'interrupt-names' is a required property

Best regards,
Krzysztof
