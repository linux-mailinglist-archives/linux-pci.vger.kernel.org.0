Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B9D107011
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfKVKqB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 05:46:01 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12091 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbfKVKqA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:46:00 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd7bc630000>; Fri, 22 Nov 2019 02:45:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 Nov 2019 02:45:59 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 Nov 2019 02:45:59 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Nov
 2019 10:45:59 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Nov
 2019 10:45:59 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 22 Nov 2019 10:45:58 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd7bc610002>; Fri, 22 Nov 2019 02:45:57 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH 6/6] arm64: tegra: Add support for PCIe endpoint mode in P2972-0000 platform
Date:   Fri, 22 Nov 2019 16:15:05 +0530
Message-ID: <20191122104505.8986-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122104505.8986-1-vidyas@nvidia.com>
References: <20191122104505.8986-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574419555; bh=PzuZi1jgVofZ8q1sxB8QaUCLTmbzr9ZfQuYuJ3/x5K8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Ktb+gOuEAFazZJ++Zih63UDEUoq0Knd69pW4jpEgWQQY/wL9Cskb2VbxFNT8TEADn
         Y9EPP73h3nNDlsroK4+P25izEt3p7Er44xIuQ//JykAE5kEHrf9RIgf3WoHL950+V+
         k6qX3ylaMlyw9ZZmBlxJpfcqsnsVlZvsYoQL17CDGQRQyEEgtcnT/64eIY/Ab/eVG/
         PBANvUKXqBUL85kYaOFdKm/3OR9sxoWowDpqpZJKs0epAQBKC4RTu6YtukDCn72YZP
         572sSGOMxonhi0hP2UKLucl5vYIfssW7ToleKPUz/Hv9Xi/c0GCmjpgmbH+GY5kCqI
         CQRH1Qu0L470g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add endpoint mode support for PCIe C5 controller in P2972-0000 platform
with information about supplies, PHY, PERST GPIO and GPIO that controls
PCIe reference clock coming from the host system.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 7eb64b816e08..58c3a9677bc8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -43,6 +43,19 @@
 
 		gpio@c2f0000 {
 			status = "okay";
+			/*
+			 * Change the below node's status to 'okay' when
+			 * PCIe C5 controller is enabled to operate in endpoint
+			 * to allow REFCLK from the host system to flow into
+			 * the controller.
+			 */
+			pex-refclk-sel-high {
+				gpio-hog;
+				output-high;
+				gpios = <TEGRA194_AON_GPIO(AA, 5) 0>;
+				label = "pex_refclk_sel_high";
+				status = "disabled";
+			};
 		};
 
 		pwm@c340000 {
@@ -144,6 +157,22 @@
 			    "p2u-5", "p2u-6", "p2u-7";
 	};
 
+	pcie_ep@141a0000 {
+		status = "disabled";
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		nvidia,pex-rst-gpio = <&gpio TEGRA194_MAIN_GPIO(GG, 1)
+					GPIO_ACTIVE_LOW>;
+
+		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
+		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
+		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
+
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
+			    "p2u-5", "p2u-6", "p2u-7";
+	};
+
 	fan: fan {
 		compatible = "pwm-fan";
 		pwms = <&pwm4 0 45334>;
-- 
2.17.1

