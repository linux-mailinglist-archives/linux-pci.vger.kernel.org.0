Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66636C8DBA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2019 18:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfJBQHI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Oct 2019 12:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729190AbfJBQHH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Oct 2019 12:07:07 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1851222BE;
        Wed,  2 Oct 2019 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570032426;
        bh=mQPcQHUPwO41tj6eZFL6xjysxPvRcXAHP637dM6rPBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xqXgGJ9vZy7bk8yuGyGyCZ7HwYOrs+sZX0ScjPpHW2skiKsRVVRbzRGyQcfqtu4D8
         sDlbVfZP8EPCOarDCvgd/OoIf7Cf8wm0Dk0jsfDjrCD4nx9pQtHbxNAKOrgy5zMzDi
         vbSyChOYqADcyyWF+Gryao3inEuvv8/IJSvZMhXw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 3/3] ARM: dts: exynos: Rename power domain nodes to "power-domain" in Exynos4
Date:   Wed,  2 Oct 2019 18:06:32 +0200
Message-Id: <20191002160632.11140-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002160632.11140-1-krzk@kernel.org>
References: <20191002160632.11140-1-krzk@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The device node name should reflect generic class of a device so rename
power domain nodes to "power-domain".  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4.dtsi    | 14 +++++++-------
 arch/arm/boot/dts/exynos4210.dtsi |  2 +-
 arch/arm/boot/dts/exynos4412.dtsi |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 433f109d97ca..d2779a790ce3 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -111,28 +111,28 @@
 			syscon = <&pmu_system_controller>;
 		};
 
-		pd_mfc: mfc-power-domain@10023c40 {
+		pd_mfc: power-domain@10023c40 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10023C40 0x20>;
 			#power-domain-cells = <0>;
 			label = "MFC";
 		};
 
-		pd_g3d: g3d-power-domain@10023c60 {
+		pd_g3d: power-domain@10023c60 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10023C60 0x20>;
 			#power-domain-cells = <0>;
 			label = "G3D";
 		};
 
-		pd_lcd0: lcd0-power-domain@10023c80 {
+		pd_lcd0: power-domain@10023c80 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10023C80 0x20>;
 			#power-domain-cells = <0>;
 			label = "LCD0";
 		};
 
-		pd_tv: tv-power-domain@10023c20 {
+		pd_tv: power-domain@10023c20 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10023C20 0x20>;
 			#power-domain-cells = <0>;
@@ -140,21 +140,21 @@
 			label = "TV";
 		};
 
-		pd_cam: cam-power-domain@10023c00 {
+		pd_cam: power-domain@10023c00 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10023C00 0x20>;
 			#power-domain-cells = <0>;
 			label = "CAM";
 		};
 
-		pd_gps: gps-power-domain@10023ce0 {
+		pd_gps: power-domain@10023ce0 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10023CE0 0x20>;
 			#power-domain-cells = <0>;
 			label = "GPS";
 		};
 
-		pd_gps_alive: gps-alive-power-domain@10023d00 {
+		pd_gps_alive: power-domain@10023d00 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10023D00 0x20>;
 			#power-domain-cells = <0>;
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index f220716239db..ff9a3fb21a85 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -90,7 +90,7 @@
 			};
 		};
 
-		pd_lcd1: lcd1-power-domain@10023ca0 {
+		pd_lcd1: power-domain@10023ca0 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10023CA0 0x20>;
 			#power-domain-cells = <0>;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index d20db2dfe8e2..1c40bd56ce00 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -206,7 +206,7 @@
 			};
 		};
 
-		pd_isp: isp-power-domain@10023ca0 {
+		pd_isp: power-domain@10023ca0 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10023CA0 0x20>;
 			#power-domain-cells = <0>;
-- 
2.17.1

