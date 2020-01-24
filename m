Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4733D147958
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 09:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAXIZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jan 2020 03:25:44 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:60731 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAXIZo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jan 2020 03:25:44 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 63EFEC0016;
        Fri, 24 Jan 2020 08:25:41 +0000 (UTC)
Date:   Fri, 24 Jan 2020 09:34:05 +0100
From:   Remi Pommarel <repk@triplefau.lt>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 4/7] arm64: dts: meson-axg: Add PCIE PHY nodes
Message-ID: <20200124083405.GW1803@voidbox>
References: <20200123232943.10229-1-repk@triplefau.lt>
 <20200123232943.10229-5-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123232943.10229-5-repk@triplefau.lt>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing Reviewed/Acked-by from v5.

On Fri, Jan 24, 2020 at 12:29:40AM +0100, Remi Pommarel wrote:
> Enable both PCIE and shared MIPI/PCIE PHY nodes in order to make PCIE
> reliable on AXG SoC.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 04803c3bccfa..08a178aa0133 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
>  #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
> +#include <dt-bindings/phy/phy.h>
>  
>  / {
>  	compatible = "amlogic,meson-axg";
> @@ -1104,6 +1105,12 @@ hiubus: bus@ff63c000 {
>  			#size-cells = <2>;
>  			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
>  
> +			mipi_analog_phy: phy@0 {
> +				compatible = "amlogic,axg-mipi-pcie-analog-phy";
> +				reg = <0x0 0x0 0x0 0xc>;
> +				#phy-cells = <1>;
> +			};
> +
>  			sysctrl: system-controller@0 {
>  				compatible = "amlogic,meson-axg-hhi-sysctrl",
>  					     "simple-mfd", "syscon";
> @@ -1356,6 +1363,15 @@ tdmout_c: audio-controller@580 {
>  			};
>  		};
>  
> +		pcie_phy: bus@ff644000 {
> +			compatible = "amlogic,axg-pcie-phy";
> +			reg = <0x0 0xff644000 0x0 0x1c>;
> +			resets = <&reset RESET_PCIE_PHY>;
> +			phys = <&mipi_analog_phy PHY_TYPE_PCIE>;
> +			phy-names = "analog";
> +			#phy-cells = <0>;
> +		};
> +
>  		aobus: bus@ff800000 {
>  			compatible = "simple-bus";
>  			reg = <0x0 0xff800000 0x0 0x100000>;

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
