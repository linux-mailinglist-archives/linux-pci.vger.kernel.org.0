Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 306A948A9D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfFQRlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:41:17 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10976 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRlR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:41:17 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d0bc0000>; Mon, 17 Jun 2019 10:41:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:41:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Jun 2019 10:41:16 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:41:15 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:41:12 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 23/27] arm64: tegra: Add PEX DPD states as pinctrl properties
Date:   Mon, 17 Jun 2019 23:09:48 +0530
Message-ID: <20190617173952.29363-24-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617173952.29363-1-mmaddireddy@nvidia.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793276; bh=+yoSYmHwASO1ouGKodiaWjKxkselDDeony32F/bzvyw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=APrJjzNew10MPbO50W6sqHiuuMsySYcMcr08ec8G5PTReN6pTCDtwbGK5BHIoakuP
         Z9xWeNSllMHcebI6ybtAaTn06GndKKnMKCFu9xZQhewkpYQykricVmmfGvHy/RhWHo
         eh/RKUesrMszxkmeObrlOkO+hEYWSb0izZD9DhAGDiN3/LCqbN54uDfvvteya/+hX0
         HiQxmvvOBR9YIAvgMeWT0X6mcubCoWTbGLLYaOCQVQnNY46NFGlQ5qR/FF2NJR6uai
         U9nnYZSh8x3g2m3RzBE/o6k4UlVXp+sfNwQqkSX18TQDBvgG0gQvXdnmJLW7jDyyzQ
         V1VGRjxkema5A==
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
V5: No change

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

