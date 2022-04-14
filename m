Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C46501D08
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 23:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbiDNVFc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 17:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346709AbiDNVFb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 17:05:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD2AD8F44
        for <linux-pci@vger.kernel.org>; Thu, 14 Apr 2022 14:03:05 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nf6cA-0007a8-B6; Thu, 14 Apr 2022 23:02:54 +0200
Message-ID: <fc2c6ddbf55723ac4c0f366e5a6131afafe546aa.camel@pengutronix.de>
Subject: Re: [PATCH v2 5/7] arm64: dts: imx8mp: add the iMX8MP PCIe support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, p.zabel@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Thu, 14 Apr 2022 23:02:53 +0200
In-Reply-To: <1646644054-24421-6-git-send-email-hongxing.zhu@nxp.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
         <1646644054-24421-6-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Montag, dem 07.03.2022 um 17:07 +0800 schrieb Richard Zhu:
> Add the i.MX8MP PCIe support.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 46 ++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index b40a5646f205..e7b3d8029e34 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -5,6 +5,7 @@
>  
>  #include <dt-bindings/clock/imx8mp-clock.h>
>  #include <dt-bindings/power/imx8mp-power.h>
> +#include <dt-bindings/reset/imx8mp-reset.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -375,7 +376,8 @@ iomuxc: pinctrl@30330000 {
>  			};
>  
>  			gpr: iomuxc-gpr@30340000 {
> -				compatible = "fsl,imx8mp-iomuxc-gpr", "syscon";
> +				compatible = "fsl,imx8mp-iomuxc-gpr",
> +					     "fsl,imx6q-iomuxc-gpr", "syscon";
>  				reg = <0x30340000 0x10000>;
>  			};
>  
> @@ -965,6 +967,17 @@ aips4: bus@32c00000 {
>  			#size-cells = <1>;
>  			ranges;
>  
> +			pcie_phy: pcie-phy@32f00000 {
> +				compatible = "fsl,imx8mp-pcie-phy";
> +				reg = <0x32f00000 0x10000>;
> +				resets = <&src IMX8MP_RESET_PCIEPHY>,
> +					 <&src IMX8MP_RESET_PCIEPHY_PERST>;
> +				reset-names = "pciephy", "perst";
> +				power-domains = <&hsio_blk_ctrl IMX8MP_HSIOBLK_PD_PCIE_PHY>;
> +				#phy-cells = <0>;
> +				status = "disabled";
> +			};
> +	
>  			hsio_blk_ctrl: blk-ctrl@32f10000 {
>  				compatible = "fsl,imx8mp-hsio-blk-ctrl", "syscon";
>  				reg = <0x32f10000 0x24>;
> @@ -980,6 +993,37 @@ hsio_blk_ctrl: blk-ctrl@32f10000 {
>  			};
>  		};
>  
> +		pcie: pcie@33800000 {
> +			compatible = "fsl,imx8mp-pcie";
> +			reg = <0x33800000 0x400000>, <0x1ff00000 0x80000>;
> +			reg-names = "dbi", "config";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			bus-range = <0x00 0xff>;
> +			ranges =  <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
> +				   0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
> +			num-lanes = <1>;
> +			num-viewport = <4>;
> +			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &gic GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &gic GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &gic GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> +			fsl,max-link-speed = <3>;

I believe that imx6_pcie_start_link does not properly handle Gen3
speeds.

Regards,
Lucas

> +			linux,pci-domain = <0>;
> +			power-domains = <&hsio_blk_ctrl IMX8MP_HSIOBLK_PD_PCIE>;
> +			resets = <&src IMX8MP_RESET_PCIE_CTRL_APPS_EN>,
> +				 <&src IMX8MP_RESET_PCIE_CTRL_APPS_TURNOFF>;
> +			reset-names = "apps", "turnoff";
> +			phys = <&pcie_phy>;
> +			phy-names = "pcie-phy";
> +			status = "disabled";
> +		};
> +
>  		gpu3d: gpu@38000000 {
>  			compatible = "vivante,gc";
>  			reg = <0x38000000 0x8000>;


