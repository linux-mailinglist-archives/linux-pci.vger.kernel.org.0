Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A2C1BCCE
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbfEMSI7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:08:59 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3213 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732296AbfEMSI6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:08:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b2920000>; Mon, 13 May 2019 11:08:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:08:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 May 2019 11:08:57 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:08:57 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:08:57 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:08:53 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 15/29] PCI: tegra: Update flow control timer frequency in Tegra210
Date:   Mon, 13 May 2019 23:37:30 +0530
Message-ID: <20190513180744.16493-16-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770898; bh=CT1n8OScIX250EoIrvdVevvkcfJXE8sgglZyNPlP+tc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=pIGh6sPKeQEm8Qnn18b42NO2iuGcW2UWz14t1hFITOuQyZ/4fiYy7XmxQb5Blsdwh
         m+5ep6KVWxdScdZdOsiHwodJzyNyoWd8y3J4vi1zVx9A/9jOD2j6NcEh8urCHPYP1L
         ngaCS/aEKo+ue4tllcPVqBZ0pOCdZvQArprE41jlwCb2xaSG0cNAsfW3W0PLTpuZbe
         6PYrkNBqKaQPceC1Ksnlh+2C2YehmBwii28bhxx31vTW+fUONCGPF28h+Ukr2mpIXb
         HtOAwdEjUfqPTsETAfiQn8RAwGu+P6YCuhhTF/OrhXL8uD1sXNWLjVWD4i8BAWtRTe
         yPUwut4akOpVw==
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

