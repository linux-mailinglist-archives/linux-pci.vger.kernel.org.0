Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47BAA1FF0D
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfEPFyC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:54:02 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15042 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFyC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:54:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfaf30000>; Wed, 15 May 2019 22:53:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:53:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:53:59 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:53:59 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:53:56 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 13/28] PCI: tegra: Increase the deskew retry time
Date:   Thu, 16 May 2019 11:22:52 +0530
Message-ID: <20190516055307.25737-14-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986035; bh=IEjv2rSP2jvUnERcogfyAm21azs6yVKE9DYuM5TILsA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=aCVJ2LZEzlutSPys+gdpbxthb8UOZHszgivh03ZlKqZ2tEArNZ4rAQKGOSkiN11l2
         9iRDoCsc0kc0GqzvVI3ET/h1bUQrdhC6WvAOkRtmxVN70Jt+h6DfsQF2VrAP7XHkOP
         oK7sgxQoZPDvN10cErpZv47C1piISUc3TswaZ1Cp7WrL5T9Z5/bzF2B3uBEb2j3VZI
         7IlZqW2yihQhirJ+5vfdkrjSQRej38c8rlpkIZso1tsNcmmnxhmFlcVF6zx1hPx2HA
         akb6/6YuyTewwt+OoC9f99c/4k13FcoagkTX4Zi8HWMwn6i2JBG1MNR7CehZn+SDcu
         uQieqRcjR3rvw==
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
V4: No change

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

