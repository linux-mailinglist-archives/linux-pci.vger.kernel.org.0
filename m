Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0704238DE6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2019 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfFGOtF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jun 2019 10:49:05 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5284 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfFGOtE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jun 2019 10:49:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfa795f0001>; Fri, 07 Jun 2019 07:49:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 07:49:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Jun 2019 07:49:03 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 14:49:03 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 7 Jun 2019 14:49:03 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cfa79590007>; Fri, 07 Jun 2019 07:49:03 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V9 12/15] arm64: tegra: Enable PCIe slots in P2972-0000 board
Date:   Fri, 7 Jun 2019 20:16:37 +0530
Message-ID: <20190607144640.13427-13-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607144640.13427-1-vidyas@nvidia.com>
References: <20190607144640.13427-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559918943; bh=+t/CZEJl2H8END4ut/exV7+WUwAy8UBaMb1HDi9Tn5U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=hHFXQEeFkwCPVg0IKzhAghuZT3VL6BN8Lk5iMzQ7bBcApEhgwpjMJTJhk4TfgnkPJ
         C3xFW8lQfpWcuadT/Mk6AFiaW2LB52Rdn8IKyeoOvmecXyc4v674LaQlbvt6ytyLJ4
         YohTwGANxCp3CWUYKOR41af1MWAirc2s+MBIQaU3X9nAUY6BLKdn2XEUjpy7PQGj/V
         lbPuI37sF0DgMyC02V64srU5OmXKAc5U1te0KieVuSHKRFHzcisBYM/7ByB9SXyNoO
         GLyk6q+FNguJOolvGXC/ReZ95xM9UKANP+z9SRTek1rPUbWSOnCF8702EIUJDTFCoF
         2/xZCrhNvk56g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe controller nodes to enable respective PCIe slots on
P2972-0000 board. Following is the ownership of slots by different
PCIe controllers.
Controller-0 : M.2 Key-M slot
Controller-1 : On-board Marvell eSATA controller
Controller-3 : M.2 Key-E slot

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v8]:
* None

Changes since [v7]:
* None

Changes since [v6]:
* None

Changes since [v5]:
* Arranged PCIe nodes in the order of their addresses

Changes since [v4]:
* None

Changes since [v3]:
* None

Changes since [v2]:
* Changed P2U label names to reflect new format that includes 'hsio'/'nvhs'
  strings to reflect UPHY brick they belong to

Changes since [v1]:
* Dropped 'pcie-' from phy-names property strings

 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  2 +-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 41 +++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 9f5810765efc..62e07e1197cc 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -191,7 +191,7 @@
 						regulator-boot-on;
 					};
 
-					sd3 {
+					vdd_1v8ao: sd3 {
 						regulator-name = "VDD_1V8AO";
 						regulator-min-microvolt = <1800000>;
 						regulator-max-microvolt = <1800000>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 6e6df650a4b0..eb79663b2af8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -167,4 +167,45 @@
 			};
 		};
 	};
+
+	pcie@14100000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		phys = <&p2u_hsio_0>;
+		phy-names = "p2u-0";
+	};
+
+	pcie@14140000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		phys = <&p2u_hsio_7>;
+		phy-names = "p2u-0";
+	};
+
+	pcie@14180000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
+		       <&p2u_hsio_5>;
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
+	};
+
+	pcie@141a0000 {
+		status = "disabled";
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
+		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
+		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
+
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
+			    "p2u-5", "p2u-6", "p2u-7";
+	};
 };
-- 
2.17.1

