Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41FB54A91A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 20:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfFRSCo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 14:02:44 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8808 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfFRSCo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 14:02:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0927410000>; Tue, 18 Jun 2019 11:02:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 11:02:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 11:02:42 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:02:41 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 18:02:38 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 08/27] PCI: tegra: Program UPHY electrical settings for Tegra210
Date:   Tue, 18 Jun 2019 23:31:47 +0530
Message-ID: <20190618180206.4908-9-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618180206.4908-1-mmaddireddy@nvidia.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560880962; bh=y3QRSovanmnWJKARK1pOs6tVyiR4f6T26tjr/eDOLk4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=E0tMMUup/rENo2luQdF8TZeKGADw9ysiTJhUE5womVZ6fMiaeqtPLwkWoKTlU63b5
         Age/d7Y1bYbaf1p+5+pEnMt13JYJY+pQ0KxBjh3CRLi9KLnzRQYs5RqjiAI+MF+JUZ
         Gq5A6fuX1ZMCSfYMGPbZYJd8MNqdOoHnkE5kje8uincICCmwnYXB/aVleFqGcyDFBo
         J25lCwUFSKlPAAvlfXKQZd49xgvqLE4SCLRaYv6AcHM44waInBggzaMi6WP1pIz7S1
         48TktkSSx8nujdfxAkNrJziDwa6XSLuUmj/e5jkwRogTfEs7wKNPGZfSO/wFS+deBz
         2Y4d6ht0/aQow==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UPHY electrical programming guidelines are documented in Tegra210 TRM.
Program these electrical settings for proper eye diagram in Gen1 and Gen2
link speeds.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V6: No change

V5: No change

V4: No change

V3: No change

V2: Addressed coding style comments

 drivers/pci/controller/pci-tegra.c | 107 +++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 39a8cbf6da24..c38a370ed853 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -177,6 +177,32 @@
 
 #define AFI_PEXBIAS_CTRL_0		0x168
 
+#define RP_ECTL_2_R1	0x00000e84
+#define  RP_ECTL_2_R1_RX_CTLE_1C_MASK		0xffff
+
+#define RP_ECTL_4_R1	0x00000e8c
+#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
+#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_SHIFT	16
+
+#define RP_ECTL_5_R1	0x00000e90
+#define  RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK	0xffffffff
+
+#define RP_ECTL_6_R1	0x00000e94
+#define  RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK	0xffffffff
+
+#define RP_ECTL_2_R2	0x00000ea4
+#define  RP_ECTL_2_R2_RX_CTLE_1C_MASK	0xffff
+
+#define RP_ECTL_4_R2	0x00000eac
+#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
+#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_SHIFT	16
+
+#define RP_ECTL_5_R2	0x00000eb0
+#define  RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK	0xffffffff
+
+#define RP_ECTL_6_R2	0x00000eb4
+#define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK	0xffffffff
+
 #define RP_VEND_XP	0x00000f00
 #define  RP_VEND_XP_DL_UP	(1 << 30)
 
@@ -266,6 +292,19 @@ struct tegra_pcie_soc {
 	bool has_gen2;
 	bool force_pca_enable;
 	bool program_uphy;
+	struct {
+		struct {
+			u32 rp_ectl_2_r1;
+			u32 rp_ectl_4_r1;
+			u32 rp_ectl_5_r1;
+			u32 rp_ectl_6_r1;
+			u32 rp_ectl_2_r2;
+			u32 rp_ectl_4_r2;
+			u32 rp_ectl_5_r2;
+			u32 rp_ectl_6_r2;
+		} regs;
+		bool enable;
+	} ectl;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -492,6 +531,54 @@ static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
 	writel(value, port->base + RP_VEND_CTL1);
 }
 
+static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *port)
+{
+	const struct tegra_pcie_soc *soc = port->pcie->soc;
+	u32 value;
+
+	value = readl(port->base + RP_ECTL_2_R1);
+	value &= ~RP_ECTL_2_R1_RX_CTLE_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_2_r1;
+	writel(value, port->base + RP_ECTL_2_R1);
+
+	value = readl(port->base + RP_ECTL_4_R1);
+	value &= ~RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_4_r1 <<
+				RP_ECTL_4_R1_RX_CDR_CTRL_1C_SHIFT;
+	writel(value, port->base + RP_ECTL_4_R1);
+
+	value = readl(port->base + RP_ECTL_5_R1);
+	value &= ~RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_5_r1;
+	writel(value, port->base + RP_ECTL_5_R1);
+
+	value = readl(port->base + RP_ECTL_6_R1);
+	value &= ~RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_6_r1;
+	writel(value, port->base + RP_ECTL_6_R1);
+
+	value = readl(port->base + RP_ECTL_2_R2);
+	value &= ~RP_ECTL_2_R2_RX_CTLE_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_2_r2;
+	writel(value, port->base + RP_ECTL_2_R2);
+
+	value = readl(port->base + RP_ECTL_4_R2);
+	value &= ~RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_4_r2 <<
+				RP_ECTL_4_R2_RX_CDR_CTRL_1C_SHIFT;
+	writel(value, port->base + RP_ECTL_4_R2);
+
+	value = readl(port->base + RP_ECTL_5_R2);
+	value &= ~RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_5_r2;
+	writel(value, port->base + RP_ECTL_5_R2);
+
+	value = readl(port->base + RP_ECTL_6_R2);
+	value &= ~RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_6_r2;
+	writel(value, port->base + RP_ECTL_6_R2);
+}
+
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 {
 	unsigned long ctrl = tegra_pcie_port_get_pex_ctrl(port);
@@ -518,6 +605,9 @@ static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 	}
 
 	tegra_pcie_enable_rp_features(port);
+
+	if (soc->ectl.enable)
+		tegra_pcie_program_ectl_settings(port);
 }
 
 static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
@@ -2223,6 +2313,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.ectl.enable = false,
 };
 
 static const struct tegra_pcie_port_soc tegra30_pcie_ports[] = {
@@ -2246,6 +2337,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.ectl.enable = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2262,6 +2354,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.ectl.enable = false,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2278,6 +2371,19 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = true,
 	.program_uphy = true,
+	.ectl = {
+		.regs = {
+			.rp_ectl_2_r1 = 0x0000000f,
+			.rp_ectl_4_r1 = 0x00000067,
+			.rp_ectl_5_r1 = 0x55010000,
+			.rp_ectl_6_r1 = 0x00000001,
+			.rp_ectl_2_r2 = 0x0000008f,
+			.rp_ectl_4_r2 = 0x000000c7,
+			.rp_ectl_5_r2 = 0x55010000,
+			.rp_ectl_6_r2 = 0x00000001,
+		},
+		.enable = true,
+	},
 };
 
 static const struct tegra_pcie_port_soc tegra186_pcie_ports[] = {
@@ -2301,6 +2407,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = false,
+	.ectl.enable = false,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.17.1

