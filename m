Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF03AA04E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 12:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388145AbfIEKql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 06:46:41 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10052 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIEKql (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 06:46:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d70e7930000>; Thu, 05 Sep 2019 03:46:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 05 Sep 2019 03:46:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 05 Sep 2019 03:46:40 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Sep
 2019 10:46:39 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Sep
 2019 10:46:39 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 5 Sep 2019 10:46:39 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d70e78a0002>; Thu, 05 Sep 2019 03:46:38 -0700
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
Subject: [PATCH V4 6/6] arm64: tegra: Add PCIe slot supply information in p2972-0000 platform
Date:   Thu, 5 Sep 2019 16:15:53 +0530
Message-ID: <20190905104553.2884-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905104553.2884-1-vidyas@nvidia.com>
References: <20190905104553.2884-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567680403; bh=nyKuLeTIA5lFQ8rcT43LcJOlCizLUussQKLCCIzlvfo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=hzV6ALI355TWeEPqn6T7xLHvqVSAxU74dLqT+pV/Kcea/ZsooTSOUtcDbaMQWCeOD
         ydYD5sVkR1bGEFx3PMeqkxsd1WB1FL9ucjTXhBxPFT4skFzQW06Eu1O8ycqrgUpgwX
         5eivCxxulCYGwBX6XPPP0wlUvLINQDthFtU0PxTDTXC/XvkwHQxoXKRN7F8nNLMgqc
         wbhbEjrENY2R9Tp31eUkpScCltajay6/xHIhk6EFsEbJhAy0JA/oi0V4MDEY5uZUAm
         JBmOvl/VsHpXWhygpSfSVU7//0m7Fk1kxgGnUHf0sOXJsSA6LwNMynoFVcmq6eb2Mu
         Pmc25iyP0WJ5Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add 3.3V and 12V supplies regulators information of x16 PCIe slot in
p2972-0000 platform which is owned by C5 controller and also enable C5
controller.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
V4:
* None

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

