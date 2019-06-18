Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033444A917
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 20:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbfFRSCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 14:02:40 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8329 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfFRSCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 14:02:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d09273e0000>; Tue, 18 Jun 2019 11:02:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 11:02:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 11:02:39 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:02:38 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:02:38 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 18:02:35 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 07/27] PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
Date:   Tue, 18 Jun 2019 23:31:46 +0530
Message-ID: <20190618180206.4908-8-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618180206.4908-1-mmaddireddy@nvidia.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560880958; bh=TCpYgPiyxd1scDOPM8LGIEZuJ16A4iHNgxZEzJ/T6v0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=CSiIgP83FrDBs0zqrYgm27BJNpMtLHpVDhHX+xtvg5UyhrpnLr+wMoMROZHCPw+6b
         p5IvtG8xFxNZoiQR4D7myVSBRNcLBezKPZF7ruoiHNq3Hhj2/e8UUrww8W3rk9lMDi
         7t6K11dr83eaLldPOsusnzWiYnaNNvYX+OULykA+gfpghoOzwmrk9UF8nns26WC9XT
         m9WspW/s0it1w3Ew8mrtTAN5GsirFlFPUFM+HbwSFLsaNSQzjjSxu0SCW5SIPqocOU
         55MVoL1ZWv9ne209AIzd7rEv+QHJmZKWnYkOFarkuCz4bA7lSGkDJNlwP0onja8e+q
         fRiJ8DuhKfGMA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Default root port setting hides AER capability. This patch enables the
advertisement of AER capability by root port.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V6: No change

V5: No change

V4: No change

V3: No change

V2: No change

 drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 5d19067f7193..39a8cbf6da24 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -180,6 +180,9 @@
 #define RP_VEND_XP	0x00000f00
 #define  RP_VEND_XP_DL_UP	(1 << 30)
 
+#define RP_VEND_CTL1	0x00000f48
+#define  RP_VEND_CTL1_ERPT	(1 << 13)
+
 #define RP_VEND_CTL2 0x00000fa8
 #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
 
@@ -479,6 +482,16 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
 	afi_writel(port->pcie, value, ctrl);
 }
 
+static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
+{
+	u32 value;
+
+	/* Enable AER capability */
+	value = readl(port->base + RP_VEND_CTL1);
+	value |= RP_VEND_CTL1_ERPT;
+	writel(value, port->base + RP_VEND_CTL1);
+}
+
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 {
 	unsigned long ctrl = tegra_pcie_port_get_pex_ctrl(port);
@@ -503,6 +516,8 @@ static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 		value |= RP_VEND_CTL2_PCA_ENABLE;
 		writel(value, port->base + RP_VEND_CTL2);
 	}
+
+	tegra_pcie_enable_rp_features(port);
 }
 
 static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
-- 
2.17.1

