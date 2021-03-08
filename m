Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE235330EAC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 13:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCHMvd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 07:51:33 -0500
Received: from muru.com ([72.249.23.125]:40832 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229754AbhCHMvZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Mar 2021 07:51:25 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 93F7A80D4;
        Mon,  8 Mar 2021 12:52:05 +0000 (UTC)
Date:   Mon, 8 Mar 2021 14:51:20 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 09/15] ARM: dts: Configure interconnect target module for
 dra7 dmm
Message-ID: <YEYdyFShtqq1uXes@atomide.com>
References: <20210126124004.52550-1-tony@atomide.com>
 <20210126124004.52550-10-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126124004.52550-10-tony@atomide.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [210126 12:43]:
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
...

> +		target-module@4e000000 {
> +			compatible = "ti,sysc-omap2", "ti,sysc";
>  			ti,hwmods = "dmm";
> +			reg = <0x4e000000 0x4>,
> +			      <0x4e000010 0x4>;
> +			reg-names = "rev", "sysc";
> +			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> +					<SYSC_IDLE_NO>,
> +					<SYSC_IDLE_SMART>;
> +			ranges = <0x0 0x4e000000 0x2000000>;
> +			#size-cells = <1>;
> +			#address-cells = <1>;
> +
> +			dmm@0 {
> +				compatible = "ti,omap5-dmm";
> +				reg = <0x4e000000 0x800>;
> +				interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +			};
>  		};


The dmm@0 reg property above should be zero instead of 0x4e000000 now that
we're using ranges. Looks like I did not test with omapdrm loaded earlier,
updated patch below.

Regards,

Tony

8< ---------------------------
From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 8 Mar 2021 14:22:49 +0200
Subject: [PATCH] ARM: dts: Configure interconnect target module for dra7
 dmm

We can now probe devices with device tree only configuration using
ti-sysc interconnect target module driver. Let's configure the
module, but keep the legacy "ti,hwmods" peroperty to avoid new boot
time warnings. The legacy property will be removed in later patches
together with the legacy platform data.

Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7.dtsi | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -464,11 +464,24 @@ edma_tptc1: dma@0 {
 			};
 		};
 
-		dmm@4e000000 {
-			compatible = "ti,omap5-dmm";
-			reg = <0x4e000000 0x800>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+		target-module@4e000000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
 			ti,hwmods = "dmm";
+			reg = <0x4e000000 0x4>,
+			      <0x4e000010 0x4>;
+			reg-names = "rev", "sysc";
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ranges = <0x0 0x4e000000 0x2000000>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+
+			dmm@0 {
+				compatible = "ti,omap5-dmm";
+				reg = <0 0x800>;
+				interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		ipu1: ipu@58820000 {
-- 
2.30.1
