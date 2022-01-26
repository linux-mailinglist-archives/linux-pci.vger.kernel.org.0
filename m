Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8900A49C14E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 03:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiAZC1D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 21:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiAZC1C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 21:27:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C342FC06161C;
        Tue, 25 Jan 2022 18:27:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B6CBB81B99;
        Wed, 26 Jan 2022 02:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E9AC340E0;
        Wed, 26 Jan 2022 02:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643164019;
        bh=0EB6cP7OR7AmWV0MNJu9iQEAQNNivvS5YyjvxnTpexE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8iR6TQxOFtjWVXILWWOYJkWJq9QPkdGUr9b/pvZEE6jPKltvYUMh6gJl3DLKxulg
         hBo3jWAffJrb2QQCiv6FyAS1UuwQqVwwvyHZbSZUCheOlr0bdrqB+in/1nCWnrF336
         /WsoK5hPvanUSFFC52rGKmB7HnJKnUoZsh4p56MdxlX0s5Sa4S5k5fvNY4jJd5PAt0
         AI5fz9L3cqbxH9fT/V/XwuYScbrAEYKsavA3+ttbXFEmaJ28c7u9nU3wRcJVuOLiPe
         LZT5ciovcTpmPoor1KnthJftPqiP1wVAjyAoMX63+xhlx/P4zhch0+GO4pS99Gv49x
         BJQoxzinEC72w==
Date:   Wed, 26 Jan 2022 10:26:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v7 7/8] arm64: dts: imx8mm-evk: Add the pcie support on
 imx8mm evk board
Message-ID: <20220126022651.GD4686@dragon>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
 <1638432158-4119-8-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638432158-4119-8-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 02, 2021 at 04:02:37PM +0800, Richard Zhu wrote:
> Add the PCIe support on iMX8MM EVK boards.
> And set the default reference clock mode.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index e033d0257b5a..87a30daf0b3c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -5,6 +5,7 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
>  #include <dt-bindings/usb/pd.h>
>  #include "imx8mm.dtsi"
>  
> @@ -30,6 +31,23 @@ status {
>  		};
>  	};
>  
> +	pcie0_refclk: pcie0-refclk {
> +		compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <100000000>;

Incorrect indent.  Fixed them up and applied.

Shawn

> +	};
> +
> +	reg_pcie0: regulator-pcie {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcie0_reg>;
> +		regulator-name = "MPCIE_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	reg_usdhc2_vmmc: regulator-usdhc2 {
>  		compatible = "regulator-fixed";
>  		pinctrl-names = "default";
> @@ -289,6 +307,30 @@ pca6416: gpio@20 {
>  	};
>  };
>  
> +&pcie_phy {
> +	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
> +	fsl,tx-deemph-gen1 = <0x2d>;
> +	fsl,tx-deemph-gen2 = <0xf>;
> +	clocks = <&pcie0_refclk>;
> +	status = "okay";
> +};
> +
> +&pcie0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie0>;
> +	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
> +	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
> +		 <&pcie0_refclk>;
> +	clock-names = "pcie", "pcie_aux", "pcie_bus";
> +	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
> +			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
> +	assigned-clock-rates = <10000000>, <250000000>;
> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
> +				 <&clk IMX8MM_SYS_PLL2_250M>;
> +	vpcie-supply = <&reg_pcie0>;
> +	status = "okay";
> +};
> +
>  &sai3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sai3>;
> @@ -406,6 +448,19 @@ MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x400001c3
>  		>;
>  	};
>  
> +	pinctrl_pcie0: pcie0grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B    0x61
> +			MX8MM_IOMUXC_SAI2_RXFS_GPIO4_IO21       0x41
> +		>;
> +	};
> +
> +	pinctrl_pcie0_reg: pcie0reggrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5       0x41
> +		>;
> +	};
> +
>  	pinctrl_pmic: pmicirqgrp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x141
> -- 
> 2.25.1
> 
