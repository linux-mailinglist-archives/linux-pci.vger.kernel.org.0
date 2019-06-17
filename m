Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97FE48A84
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfFQRkv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:40:51 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10923 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRku (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:40:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d0a10000>; Mon, 17 Jun 2019 10:40:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:40:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 10:40:49 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:40:49 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:40:46 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 15/27] PCI: tegra: Update flow control timer frequency in Tegra210
Date:   Mon, 17 Jun 2019 23:09:40 +0530
Message-ID: <20190617173952.29363-16-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617173952.29363-1-mmaddireddy@nvidia.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793249; bh=YLhzUZJSFbhsQ1X0SbFe+TLa7Alhn2g9T+lQcQupn04=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZawLCM7wQK9jsYnBgweqneDnU29FN213GJkpNvFwZK1I94EcEfF+DNcv93X3kAQTX
         1RgUoAu7BEEFP0KrznUQ8EwBE3Ea5WOEOnRzI/gxOwWb/VUzxRAZ7b1qku07+fzBxF
         tosjTzHy+ZNG6cSh5u+zicXCfVNw4RDOELw+Htc9LK7ODEDRJZ4vM9B35iBdl9lOF4
         g0H1zaUfCGCGJvWDJU2WXsPVWu/90UPvka8Z4Hs8Sv9J/ldCcT54mLberXewKXaXLE
         EuCTl+wOlvRFh383h331dEloXJF02MW88rA+Zyf659wRlCT4XSK96Mpi9tV8n8MiDy
         5shh3wqg7U/Vg==
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
V5: No change

V4: No change

V3: No change

V2: Changed update_fc_val to update_fc_threshold

 drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 70bfbb7930c8..6ed406c46409 100644
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

