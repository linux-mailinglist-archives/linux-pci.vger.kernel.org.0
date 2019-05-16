Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A47A71FF2E
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfEPFyl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:54:41 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15092 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfEPFyk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:54:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfb1b0001>; Wed, 15 May 2019 22:54:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:54:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:54:39 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:39 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:39 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:54:36 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 24/28] arm64: tegra: Add PEX DPD states as pinctrl properties
Date:   Thu, 16 May 2019 11:23:03 +0530
Message-ID: <20190516055307.25737-25-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986075; bh=sML8TUSgjAVdHpUCGv1r8lViyg+XyjdNrzUHpr8EbaU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=oYohqnm687tCQTXtHjADzcLlp5h1RHrYnS+wupo6jqB2fdrbJ4Z7xvgqb1mnLUQgG
         QnUQkKuHhTRmpwz7mHqzCHYQHGrzkj9t4BTXwSf9I3b+pRKIiOH7hWcoHNhofWvc4L
         TJo8vwdZdRRUUXFswFUh9Cw0edpnFKjiokYFL78zeNzHhT5PDRgz9lRwyHzgOZZPKL
         91B+IyM/Xj7FuO3nf/932yNd2U+ohf9pXhAVS7k53GsILN+dtQvhggcV2yr2XxKanN
         RMJfDhk5qXc3YF6fUA2WoCazDs6WZUUCII4wjyiCUKACRwZeC6yk0JWLDQkRqdX30Q
         c+gM1F5taQ4YA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PEX deep power down states as pinctrl properties to set in PCIe driver.
In Tegra210, BIAS pads are not in power down mode when clamps are applied.
To set the pads in DPD, pass the PEX DPD states as pinctrl properties to
PCIe driver.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4: No change

V3: No change

V2: Using standard pinctrl names, default and idle

 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index a550c0a4d572..3899c54ea28f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -48,6 +48,11 @@
 			 <&tegra_car 72>,
 			 <&tegra_car 74>;
 		reset-names = "pex", "afi", "pcie_x";
+
+		pinctrl-names = "default", "idle";
+		pinctrl-0 = <&pex_dpd_disable>;
+		pinctrl-1 = <&pex_dpd_enable>;
+
 		status = "disabled";
 
 		pci@1,0 {
@@ -848,6 +853,20 @@
 			pins = "sdmmc3";
 			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
 		};
+
+		pex_dpd_disable: pex_en {
+			pex-dpd-disable {
+				pins = "pex-bias", "pex-clk1", "pex-clk2";
+				low-power-disable;
+			};
+		};
+
+		pex_dpd_enable: pex_dis {
+			pex-dpd-enable {
+				pins = "pex-bias", "pex-clk1", "pex-clk2";
+				low-power-enable;
+			};
+		};
 	};
 
 	fuse@7000f800 {
-- 
2.17.1

