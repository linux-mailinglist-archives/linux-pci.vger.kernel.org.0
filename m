Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590911FF09
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEPFx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:53:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8945 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:53:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfafb0000>; Wed, 15 May 2019 22:54:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:53:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:53:56 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:53:56 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:53:56 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:53:53 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 12/28] PCI: tegra: Enable PCIe xclk clock clamping
Date:   Thu, 16 May 2019 11:22:51 +0530
Message-ID: <20190516055307.25737-13-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986043; bh=BfSF0Z6QwYNVPTIXmNffDnWm1l4TzbPlzXyBv/wd7gA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Qkry6oTjbfvOwbpPnycSMdgrLq5N2RXp+SSrM/UJw0ytYDOWIrTsH2L6CkGxNt54x
         iy8eMTAGK7nb1Wv6T/DMO0dIrz8S8ABUUZ2cve20476I9NuEm2vYdRX5g507Qq/h7F
         YMDWctAvZ26CAzlriYiNPs0XM/+ISD6qfXtke7C0/845PMQm1a9XowxNtjhnAnbO7i
         x6NNtt64MpEQBVyk89gYjYspwZ78eha8j7bjAQpxo3B4oTUdL1DRUf3MfTy0kKenCj
         HSLRGzzInt6u2yI63tREPBJ6TwrZQQSBqTWBYZZaMz0WttYCCvePXYCFDSGjMKU229
         3gGjfZtcDgQhA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable xclk clock clamping when entering L1. Clamp threshold will
determine the time spent waiting for clock module to turn on xclk after
signaling it. Default threshold value in Tegra124 and Tegra210 is not
enough to turn on xclk clock. Increase the clamp threshold to meet the
clock module timing in Tegra124 and Tegra210. Default threshold value is
enough in Tegra20, Tegra30 and Tegra186.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4: No change

V3: No change

V2: Took care of typos in commit log and coding style comments.

 drivers/pci/controller/pci-tegra.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index d3da03a10e04..96cd75821872 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -219,8 +219,14 @@
 #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
 
 #define RP_PRIV_MISC	0x00000fe0
-#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT (0xe << 0)
-#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT (0xf << 0)
+#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT		(0xe << 0)
+#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT		(0xf << 0)
+#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 16)
+#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD		(0xf << 16)
+#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE		(1 << 23)
+#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 24)
+#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD		(0xf << 24)
+#define  RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE		(1 << 31)
 
 #define RP_LINK_CONTROL_STATUS			0x00000090
 #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
@@ -298,6 +304,7 @@ struct tegra_pcie_soc {
 	bool has_gen2;
 	bool force_pca_enable;
 	bool program_uphy;
+	bool update_clamp_threshold;
 	struct {
 		struct {
 			u32 rp_ectl_2_r1;
@@ -529,6 +536,7 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
 
 static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
 {
+	const struct tegra_pcie_soc *soc = port->pcie->soc;
 	u32 value;
 
 	/* Enable AER capability */
@@ -549,6 +557,19 @@ static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
 	value = readl(port->base + RP_VEND_XP_BIST);
 	value |= RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE;
 	writel(value, port->base + RP_VEND_XP_BIST);
+
+	value = readl(port->base + RP_PRIV_MISC);
+	value |= RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE;
+	value |= RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE;
+
+	if (soc->update_clamp_threshold) {
+		value &= ~(RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK |
+				RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK);
+		value |= RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD |
+			RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD;
+	}
+
+	writel(value, port->base + RP_PRIV_MISC);
 }
 
 static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *port)
@@ -2334,6 +2355,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.update_clamp_threshold = false,
 	.ectl.enable = false,
 };
 
@@ -2358,6 +2380,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.update_clamp_threshold = false,
 	.ectl.enable = false,
 };
 
@@ -2375,6 +2398,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.update_clamp_threshold = true,
 	.ectl.enable = false,
 };
 
@@ -2392,6 +2416,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = true,
 	.program_uphy = true,
+	.update_clamp_threshold = true,
 	.ectl = {
 		.regs = {
 			.rp_ectl_2_r1 = 0x0000000f,
@@ -2428,6 +2453,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = false,
+	.update_clamp_threshold = false,
 	.ectl.enable = false,
 };
 
-- 
2.17.1

