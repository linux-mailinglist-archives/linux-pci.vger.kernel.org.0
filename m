Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2561FF12
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfEPFyI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:54:08 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19784 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFyI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:54:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfad60001>; Wed, 15 May 2019 22:53:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:54:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:54:07 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:06 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:54:04 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 15/28] PCI: tegra: Update flow control timer frequency in Tegra210
Date:   Thu, 16 May 2019 11:22:54 +0530
Message-ID: <20190516055307.25737-16-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986006; bh=eLZrU3bcJVGUHLh91X4YKlhbFb6GQ1A/7Dh8riBypZo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=R3y4JFtJAzhNHtXEAvIbxlvf5NIlKwTxCbCcNbUTQAenIbBxeQdvXgGrpq8rt47v6
         it22+zoCWlTfvh/cYZcYyAX3CjIJeDQkMQx6D/P4EUzXg06TkEKLNYqrP4n3ihh5XR
         A1+RZsaNNIsSWSRNBwCi+tFJq4r7aLS/TGworXnIJSurvkSazmihfRlUC2AP5DKvLR
         jULDXV8lKEz5ZNJmXc50nCtKvPW0OaH6aG9ijG4VnYmUYK7UhJylT6ZtkGBlYg4Fno
         qIWB7JqBxi7iYfY+Ccj7JDQAyUopQfBdPIVeau/B+7+vP2q//IDoHITtIawZD0y8Iv
         4Mt43JwQQWUNg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recommended UpdateFC threshold in Tegra210 is 0x60 for best performance
of x1 link. Setting this to 0x60 provides the best balance between number
of UpdateFC packets and read data sent over the link.

UpdateFC timer frequency is equal to twice the value of register content
in nsec, i.e (2 * 0x60) = 192 nsec.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4: No change

V3: No change

V2: Changed update_fc_val to update_fc_threshold

 drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index be39f28a7a28..16d4d3cba3ff 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -320,6 +320,7 @@ struct tegra_pcie_soc {
 	bool update_clamp_threshold;
 	bool program_deskew_time;
 	bool raw_violation_fixup;
+	bool update_fc_timer;
 	struct {
 		struct {
 			u32 rp_ectl_2_r1;
@@ -668,6 +669,13 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
 		value |= soc->update_fc_threshold;
 		writel(value, port->base + RP_VEND_XP);
 	}
+
+	if (soc->update_fc_timer) {
+		value = readl(port->base + RP_VEND_XP);
+		value &= ~RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK;
+		value |= soc->update_fc_threshold;
+		writel(value, port->base + RP_VEND_XP);
+	}
 }
 
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
@@ -2410,6 +2418,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
+	.update_fc_timer = false,
 	.ectl.enable = false,
 };
 
@@ -2437,6 +2446,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
+	.update_fc_timer = false,
 	.ectl.enable = false,
 };
 
@@ -2459,6 +2469,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.update_clamp_threshold = true,
 	.program_deskew_time = false,
 	.raw_violation_fixup = true,
+	.update_fc_timer = false,
 	.ectl.enable = false,
 };
 
@@ -2469,6 +2480,8 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0x90b890b8,
+	/* FC threshold is bit[25:18] */
+	.update_fc_threshold = 0x01800000,
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
@@ -2479,6 +2492,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.update_clamp_threshold = true,
 	.program_deskew_time = true,
 	.raw_violation_fixup = false,
+	.update_fc_timer = true,
 	.ectl = {
 		.regs = {
 			.rp_ectl_2_r1 = 0x0000000f,
@@ -2518,6 +2532,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
+	.update_fc_timer = false,
 	.ectl.enable = false,
 };
 
-- 
2.17.1

