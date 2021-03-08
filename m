Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D0E330CC8
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 12:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhCHLyC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 06:54:02 -0500
Received: from muru.com ([72.249.23.125]:40734 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231579AbhCHLxa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Mar 2021 06:53:30 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C136980D4;
        Mon,  8 Mar 2021 11:54:08 +0000 (UTC)
Date:   Mon, 8 Mar 2021 13:53:23 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 08/15] ARM: dts: Configure interconnect target module for
 dra7 mpu
Message-ID: <YEYQM9yiiMH4kc+w@atomide.com>
References: <20210126124004.52550-1-tony@atomide.com>
 <20210126124004.52550-9-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126124004.52550-9-tony@atomide.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [210126 12:43]:
> We can now probe devices with device tree only configuration using
> ti-sysc interconnect target module driver. Let's configure the
> module, but keep the legacy "ti,hwmods" peroperty to avoid new boot
> time warnings. The legacy property will be removed in later patches
> together with the legacy platform data.
...

> +		target-module@48210000 {
> +			compatible = "ti,sysc-omap4-simple", "ti,sysc";
> +			ti,hwmods = "mpu";
> +			power-domains = <&prm_mpu>;
> +			clocks = <&mpu_clkctrl DRA7_MPU_CLKCTRL 0>;
> +			clock-names = "fck";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x1f0000>;
> +
> +			mpu {
> +				compatible = "ti,omap5-mpu";
> +			};
> +		};

I noticed the ranges property above is wrong, it should not be 0.
That range is currently unused thoug. Updated patch below.

Regards,

Tony

8< ----------------------
From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 8 Mar 2021 10:47:59 +0200
Subject: [PATCH] ARM: dts: Configure interconnect target module for dra7
 mpu

We can now probe devices with device tree only configuration using
ti-sysc interconnect target module driver.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7.dtsi | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -124,18 +124,6 @@ opp_high@1500000000 {
 		};
 	};
 
-	/*
-	 * The soc node represents the soc top level view. It is used for IPs
-	 * that are not memory mapped in the MPU view or for the MPU itself.
-	 */
-	soc {
-		compatible = "ti,omap-infra";
-		mpu {
-			compatible = "ti,omap5-mpu";
-			ti,hwmods = "mpu";
-		};
-	};
-
 	/*
 	 * XXX: Use a flat representation of the SOC interconnect.
 	 * The real OMAP interconnect network is quite complex.
@@ -165,6 +153,21 @@ l4_wkup: interconnect@4ae00000 {
 		};
 		l4_per1: interconnect@48000000 {
 		};
+
+		target-module@48210000 {
+			compatible = "ti,sysc-omap4-simple", "ti,sysc";
+			power-domains = <&prm_mpu>;
+			clocks = <&mpu_clkctrl DRA7_MPU_CLKCTRL 0>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x48210000 0x1f0000>;
+
+			mpu {
+				compatible = "ti,omap5-mpu";
+			};
+		};
+
 		l4_per2: interconnect@48400000 {
 		};
 		l4_per3: interconnect@48800000 {
-- 
2.30.1
