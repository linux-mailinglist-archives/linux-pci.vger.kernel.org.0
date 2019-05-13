Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D31BCD3
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbfEMSJF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:09:05 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18115 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732314AbfEMSJF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:09:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b2c70000>; Mon, 13 May 2019 11:09:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:09:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 May 2019 11:09:04 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:03 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:09:00 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 17/29] PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
Date:   Mon, 13 May 2019 23:37:32 +0530
Message-ID: <20190513180744.16493-18-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770951; bh=LZPSvfbjev7Mvocabf7WFUqbSO4Yo0MHne1OUuLVzIA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=oeRi+Yngd+M7Yc/hKPujm0BDf+qQFPYQb4gnV/lcur2aS8HzuEkT3VdOYvFsC+xf/
         BB1264YUMM3LKfe8xS7kmKGBAZ5rzV4PH7c5MSBOCjkc1jeOsrk9WAd1bKSx+87Sm1
         kQJ2i2uAKFxkdND9TgzT2gcDwdx5cML8EDu6pfTxv+tQXPeUrq5IZZBlmSO4z9uSKZ
         Qj1xpAaDXJuuvzbP4YSlr95q8qRaq/i2ieljSPpdosEeajCFtLTsYjrLYCiHAPc3KB
         lx3E7/Orw/nuOiJfAgnNMdOukgH42/ZCU+3ulrZ20/MdIB53TVYRKPpDjtJFiJDLk3
         JCl8MN0NakEMA==
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

