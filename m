Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955931BCC8
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbfEMSIx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:08:53 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3200 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732296AbfEMSIx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:08:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b28c0000>; Mon, 13 May 2019 11:08:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:08:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 11:08:51 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:08:51 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:08:50 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:08:47 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 13/29] PCI: tegra: Increase the deskew retry time
Date:   Mon, 13 May 2019 23:37:28 +0530
Message-ID: <20190513180744.16493-14-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770892; bh=CHNHlc0xPyru+CXVMSLVoLNdWVkSv4fUevr0ikhdqE0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=N6+Bmh5A/Tc7ULqLNxvl94XBwC3SIPb/xKAi2lslBAL9YfLQLvaVAE/1ICmmknARX
         JGQVpfmuIoToVZAGp4b7vAE7l80ItStFq23YGXmWh4PcSC5FCI2JZPNpsVfu1EotL7
         FJyf71b+gjnp4hrIeTHvirrnuysjmt13YCydYpLQpw7gr3buDexUDLKT/OmAwJ9tIu
         4Cf9/knb4h4jvqzQI83E42AsWGTe/2EaGkbvKh5RQbCiradtnYFCHQWd5mZf+0EnNf
         sUi/H5zcx25oiaj65LySaU1L8z3B5Uu/cxJviXMD/plUZGdZ7GkyAiqlU5i34dUn8S
         tFWYmaUNRZigA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sometimes link speed change from Gen2 to Gen1 fails due to instability
in deskew logic on lane-0 in Tegra210. Increase the deskew retry time
to resolve this issue.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V3: No change

V2: Took care of typos in commit log and coding style comments.

 drivers/pci/controller/pci-tegra.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 96cd75821872..9c28f1d9f177 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -209,6 +209,10 @@
 #define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
 #define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
 
+#define RP_VEND_CTL0	0x00000f44
+#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
+#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH	(0x9 << 12)
+
 #define RP_VEND_CTL1	0x00000f48
 #define  RP_VEND_CTL1_ERPT	(1 << 13)
 
@@ -305,6 +309,7 @@ struct tegra_pcie_soc {
 	bool force_pca_enable;
 	bool program_uphy;
 	bool update_clamp_threshold;
+	bool program_deskew_time;
 	struct {
 		struct {
 			u32 rp_ectl_2_r1;
@@ -620,6 +625,24 @@ static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *port)
 	writel(value, port->base + RP_ECTL_6_R2);
 }
 
+static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
+{
+	const struct tegra_pcie_soc *soc = port->pcie->soc;
+	u32 value;
+
+	/*
+	 * Sometimes link speed change from Gen2 to Gen1 fails due to
+	 * instability in deskew logic on lane-0. Increase the deskew
+	 * retry time to resolve this issue.
+	 */
+	if (soc->program_deskew_time) {
+		value = readl(port->base + RP_VEND_CTL0);
+		value &= ~RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK;
+		value |= RP_VEND_CTL0_DSK_RST_PULSE_WIDTH;
+		writel(value, port->base + RP_VEND_CTL0);
+	}
+}
+
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 {
 	unsigned long ctrl = tegra_pcie_port_get_pex_ctrl(port);
@@ -649,6 +672,8 @@ static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 
 	if (soc->ectl.enable)
 		tegra_pcie_program_ectl_settings(port);
+
+	tegra_pcie_apply_sw_fixup(port);
 }
 
 static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
@@ -2356,6 +2381,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.force_pca_enable = false,
 	.program_uphy = true,
 	.update_clamp_threshold = false,
+	.program_deskew_time = false,
 	.ectl.enable = false,
 };
 
@@ -2381,6 +2407,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.force_pca_enable = false,
 	.program_uphy = true,
 	.update_clamp_threshold = false,
+	.program_deskew_time = false,
 	.ectl.enable = false,
 };
 
@@ -2399,6 +2426,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.force_pca_enable = false,
 	.program_uphy = true,
 	.update_clamp_threshold = true,
+	.program_deskew_time = false,
 	.ectl.enable = false,
 };
 
@@ -2417,6 +2445,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.force_pca_enable = true,
 	.program_uphy = true,
 	.update_clamp_threshold = true,
+	.program_deskew_time = true,
 	.ectl = {
 		.regs = {
 			.rp_ectl_2_r1 = 0x0000000f,
@@ -2454,6 +2483,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.force_pca_enable = false,
 	.program_uphy = false,
 	.update_clamp_threshold = false,
+	.program_deskew_time = false,
 	.ectl.enable = false,
 };
 
-- 
2.17.1

