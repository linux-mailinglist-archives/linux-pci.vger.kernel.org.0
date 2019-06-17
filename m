Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEC448A7E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfFQRkt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:40:49 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17084 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRks (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:40:48 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d09f0000>; Mon, 17 Jun 2019 10:40:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:40:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Jun 2019 10:40:46 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:40:46 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:40:45 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:40:42 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 14/27] PCI: tegra: Add SW fixup for RAW violations
Date:   Mon, 17 Jun 2019 23:09:39 +0530
Message-ID: <20190617173952.29363-15-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617173952.29363-1-mmaddireddy@nvidia.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793247; bh=a6iVcl6t/fzzOPZbcr9JH5FISQHIaofCLT35PoVQOcU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ImY72hOkaVPL+6jDP7QQHtAC+RAOSgTKCkZNy9ZO7EZ5HOIPTcHq0gKGSZEsNHGNu
         YfbYadIcr/cpt8wcSVExzZFQOyUt2p6K5FMLpsnigXweG8SV9rhKipZSj12AE25v1w
         625RkwRcqcFApkK/LaWdFm3HBRuBM0DN5SHDoek1+AVcDWeKbiLJ34UcBZY0BGMk9b
         M0URDPo85OadqWt2oEqy7bIUJvTZ8N3xX++LcJsvTwbp37BJN8qImQIUl48h1hhZj/
         Z9IDOKJK9gLBxUEgY4rpso7jXypOgFJ7r830lzWtJMkuUxNk86h+5UErfnVGnjpqZM
         /VI+pHriEqv4A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The logic which blocks read requests till AFI gets ACK for all outstanding
writes from memory controller does not behave correctly when number of
outstanding writes become more than 32 in Tegra124 and Tegra132.

SW fixup is to prevent writes from accumulating more than 32 by,
 - limiting outstanding posted writes to 14
 - modifying Gen1 and Gen2 UpdateFC timer frequency

UpdateFC timer frequency is equal to twice the value of register content
in nsec. These settings are recommended after stress testing with different
values.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V5: No change

V4: No change

V3: No change

V2: Changed update_fc_val to update_fc_threshold

 drivers/pci/controller/pci-tegra.c | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 6f06327ca0aa..70bfbb7930c8 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -178,6 +178,13 @@
 
 #define AFI_PEXBIAS_CTRL_0		0x168
 
+#define RP_PRIV_XP_DL		0x00000494
+#define  RP_PRIV_XP_DL_GEN2_UPD_FC_TSHOLD	(0x1ff << 1)
+
+#define RP_RX_HDR_LIMIT		0x00000e00
+#define  RP_RX_HDR_LIMIT_PW_MASK	(0xff << 8)
+#define  RP_RX_HDR_LIMIT_PW		(0x0e << 8)
+
 #define RP_ECTL_2_R1	0x00000e84
 #define  RP_ECTL_2_R1_RX_CTLE_1C_MASK		0xffff
 
@@ -208,6 +215,7 @@
 #define  RP_VEND_XP_DL_UP			(1 << 30)
 #define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
 #define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
+#define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	(0xff << 18)
 
 #define RP_VEND_CTL0	0x00000f44
 #define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
@@ -301,6 +309,7 @@ struct tegra_pcie_soc {
 	u32 tx_ref_sel;
 	u32 pads_refclk_cfg0;
 	u32 pads_refclk_cfg1;
+	u32 update_fc_threshold;
 	bool has_pex_clkreq_en;
 	bool has_pex_bias_ctrl;
 	bool has_intr_prsnt_sense;
@@ -310,6 +319,7 @@ struct tegra_pcie_soc {
 	bool program_uphy;
 	bool update_clamp_threshold;
 	bool program_deskew_time;
+	bool raw_violation_fixup;
 	struct {
 		struct {
 			u32 rp_ectl_2_r1;
@@ -641,6 +651,23 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
 		value |= RP_VEND_CTL0_DSK_RST_PULSE_WIDTH;
 		writel(value, port->base + RP_VEND_CTL0);
 	}
+
+	/* Fixup for read after write violation. */
+	if (soc->raw_violation_fixup) {
+		value = readl(port->base + RP_RX_HDR_LIMIT);
+		value &= ~RP_RX_HDR_LIMIT_PW_MASK;
+		value |= RP_RX_HDR_LIMIT_PW;
+		writel(value, port->base + RP_RX_HDR_LIMIT);
+
+		value = readl(port->base + RP_PRIV_XP_DL);
+		value |= RP_PRIV_XP_DL_GEN2_UPD_FC_TSHOLD;
+		writel(value, port->base + RP_PRIV_XP_DL);
+
+		value = readl(port->base + RP_VEND_XP);
+		value &= ~RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK;
+		value |= soc->update_fc_threshold;
+		writel(value, port->base + RP_VEND_XP);
+	}
 }
 
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
@@ -2382,6 +2409,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.program_uphy = true,
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
+	.raw_violation_fixup = false,
 	.ectl.enable = false,
 };
 
@@ -2408,6 +2436,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.program_uphy = true,
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
+	.raw_violation_fixup = false,
 	.ectl.enable = false,
 };
 
@@ -2418,6 +2447,8 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0x44ac44ac,
+	/* FC threshold is bit[25:18] */
+	.update_fc_threshold = 0x03fc0000,
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
@@ -2427,6 +2458,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.program_uphy = true,
 	.update_clamp_threshold = true,
 	.program_deskew_time = false,
+	.raw_violation_fixup = true,
 	.ectl.enable = false,
 };
 
@@ -2446,6 +2478,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.program_uphy = true,
 	.update_clamp_threshold = true,
 	.program_deskew_time = true,
+	.raw_violation_fixup = false,
 	.ectl = {
 		.regs = {
 			.rp_ectl_2_r1 = 0x0000000f,
@@ -2484,6 +2517,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.program_uphy = false,
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
+	.raw_violation_fixup = false,
 	.ectl.enable = false,
 };
 
-- 
2.17.1

