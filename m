Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586A3A0877
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfH1R3g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 13:29:36 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7444 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfH1R3g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 13:29:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d66ba010001>; Wed, 28 Aug 2019 10:29:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 28 Aug 2019 10:29:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 28 Aug 2019 10:29:35 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 17:29:35 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 17:29:35 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 28 Aug 2019 17:29:34 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d66b9fa0000>; Wed, 28 Aug 2019 10:29:34 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3 6/6] arm64: tegra: Add PCIe slot supply information in p2972-0000 platform
Date:   Wed, 28 Aug 2019 22:58:50 +0530
Message-ID: <20190828172850.19871-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828172850.19871-1-vidyas@nvidia.com>
References: <20190828172850.19871-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567013377; bh=pqenOE/Va6ZccwLf8/ZCtakjRCrDvI5bZnar6GjXaYE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Zxu+zqpoWxxbZwxEbY6fRhF1p0oN39Mz8qXzcjZkrUsb3xAlI46nkOIVN36SRn4mS
         JAyBR922LYR0RNBasYMcItyRlKGZOnhY2P0JAgxu/j8ec8A3EeXGtKWlVNyOfQA4vX
         Whb82J/tEtD/8cYe6YBAmK3ijeCEEEyWeM0cOBplFjF+BykjINIOnbC01nnbSwaZQ4
         3eo1evbA3bAO3o9WMqka7257ml61Nr29dgRoOC/yq48OtphbmDemnLxFN4KBxEJxS2
         5JnEfDhygAmB/j3ip/PNEyPourAeOiz4lVQRTLJr6GDhR7wGgPa93m90SRf3j4UR9/
         h4GeNzZXX+rSg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add 3.3V and 12V supplies regulators information of x16 PCIe slot in
p2972-0000 platform which is owned by C5 controller and also enable C5
controller.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* None

V2:
* None

 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 24 +++++++++++++++++++
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  4 +++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 62e07e1197cc..4c38426a6969 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -289,5 +289,29 @@
 			gpio = <&gpio TEGRA194_MAIN_GPIO(A, 3) GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
+
+		vdd_3v3_pcie: regulator@2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+
+			regulator-name = "PEX_3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio TEGRA194_MAIN_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
+			regulator-boot-on;
+			enable-active-high;
+		};
+
+		vdd_12v_pcie: regulator@3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+
+			regulator-name = "VDD_12V";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			gpio = <&gpio TEGRA194_MAIN_GPIO(A, 1) GPIO_ACTIVE_LOW>;
+			regulator-boot-on;
+			enable-active-low;
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 23597d53c9c9..d47cd8c4dd24 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -93,9 +93,11 @@
 	};
 
 	pcie@141a0000 {
-		status = "disabled";
+		status = "okay";
 
 		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+		vpcie3v3-supply = <&vdd_3v3_pcie>;
+		vpcie12v-supply = <&vdd_12v_pcie>;
 
 		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
 		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
-- 
2.17.1

