Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9CC1FF18
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfEPFyP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:54:15 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15061 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFyP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:54:15 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfb020000>; Wed, 15 May 2019 22:54:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:54:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 May 2019 22:54:14 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:14 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:13 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:54:10 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 17/28] PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
Date:   Thu, 16 May 2019 11:22:56 +0530
Message-ID: <20190516055307.25737-18-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986050; bh=fImwIdaqRPVQHwnOPQkJin73Y+Urt7fh1Wn+RJI99Sg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=nGWUiCOcbW1VCFz/gmiA33whfJ+lzsUv1SxaCa6ZoFxMQQ37shU+x1rEqFeLty/Nn
         9m4RrGmJ3uwz8Rs/R8ylXBqdHcEWHlb9LnLgl0fmQPpjyFkH2A+G2ubGZVRiguiegd
         NNAa53GgGElgsUOmHgNQx7WIEgQ4+Y2l0AnKKvvL+HlnuxQU8+5W8LONDRngocdUuA
         aQdCA454bhLTAci6RpyNqXjK6kQNJGpUGsoY7SlINqWl60sVa0OXKTevJIVnNljkMO
         CGBCut+XYQDepx6NmRdTlPSahFNHEJtpNRmsLODYdsL5zrrgIyVNL8h/5gcaAL5V1L
         cFl8w4jNcMsaQ==
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
V4: No change

V3: No change

V2: Corrected the comment in driver

 drivers/pci/controller/pci-tegra.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 9ee111062ab7..4767af9f3b88 100644
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

