Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2504A936
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfFRSDN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 14:03:13 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12523 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbfFRSDN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 14:03:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0927610003>; Tue, 18 Jun 2019 11:03:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 11:03:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 11:03:12 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:03:11 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 18:03:08 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 17/27] PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
Date:   Tue, 18 Jun 2019 23:31:56 +0530
Message-ID: <20190618180206.4908-18-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618180206.4908-1-mmaddireddy@nvidia.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560880993; bh=V45grrq6EH7sr5LF0RBE0ARHzk0EF17iu2N7jIO08KQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZfTdNnSOgQke2PXJxxwZZVCxPCl4J6ZQRKYgSjhLS1FiLkfoyzN585Gzvd+w3KSqM
         HWfN+1x1woV1UtKDqk0LDq0eRraQx7eMhKnfvfQT84rl1mkGt9HYJQLzCYj3mOqlGG
         inZ+jdoD1IWLcS3/L9113/L3JDUqMAojMUUprq2jttEZtnp0T3BgLxbU014x2HgzDU
         TtNG5yZGauF2gr9GhUalrxb/thG68dp0p6xfqMUQ14KoHtDQ+V+8g2X48MMRN266Eq
         Sz5aOeHNVkyDZlxGRgjeBV493jWPphn16673dQ+CbGvLY+XfW8Lpn0VaK3/EnzgDfH
         dIZDgiZom/l5Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Disable controllers which failed to link up and configure CLKREQ# signals
of these controllers as GPIO. This is required to avoid CLKREQ# signal of
inactive controllers interfering with PLLE power down sequence.

PCIE_CLKREQ_GPIO bits are defined only in Tegra186, however programming
these bits in other SoCs doesn't cause any side effects. Program these
bits for all Tegra SoCs to avoid conditional check.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V6: No change

V5: No change

V4: No change

V3: No change

V2: Corrected the comment in driver

 drivers/pci/controller/pci-tegra.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index abb94595c76b..3d9028cecc18 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -160,6 +160,8 @@
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_211	(0x1 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_411	(0x2 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_111	(0x2 << 20)
+#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO(x)		(1 << ((x) + 29))
+#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO_ALL		(0x7 << 29)
 
 #define AFI_FUSE			0x104
 #define  AFI_FUSE_PCIE_T0_GEN2_DIS	(1 << 2)
@@ -741,6 +743,12 @@ static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
 
 	value &= ~AFI_PEX_CTRL_REFCLK_EN;
 	afi_writel(port->pcie, value, ctrl);
+
+	/* disable PCIe port and set CLKREQ# as GPIO to allow PLLE power down */
+	value = afi_readl(port->pcie, AFI_PCIE_CONFIG);
+	value |= AFI_PCIE_CONFIG_PCIE_DISABLE(port->index);
+	value |= AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO(port->index);
+	afi_writel(port->pcie, value, AFI_PCIE_CONFIG);
 }
 
 static void tegra_pcie_port_free(struct tegra_pcie_port *port)
@@ -1153,9 +1161,12 @@ static void tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 	value = afi_readl(pcie, AFI_PCIE_CONFIG);
 	value &= ~AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_MASK;
 	value |= AFI_PCIE_CONFIG_PCIE_DISABLE_ALL | pcie->xbar_config;
+	value |= AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO_ALL;
 
-	list_for_each_entry(port, &pcie->ports, list)
+	list_for_each_entry(port, &pcie->ports, list) {
 		value &= ~AFI_PCIE_CONFIG_PCIE_DISABLE(port->index);
+		value &= ~AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO(port->index);
+	}
 
 	afi_writel(pcie, value, AFI_PCIE_CONFIG);
 
-- 
2.17.1

