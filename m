Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9ED1FEFB
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfEPFxk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:53:40 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15008 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFxk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:53:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfadf0000>; Wed, 15 May 2019 22:53:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:53:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:53:39 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:53:38 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:53:35 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 07/28] PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
Date:   Thu, 16 May 2019 11:22:46 +0530
Message-ID: <20190516055307.25737-8-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986015; bh=JcxiEZoQFOb32SXwUEQC8SKF3SwbmFh5VPcA0xZEyYw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Mpsnb5pMHABhEsj60r3y8V2G+5RSLyfwwviWSx2bJs89WSR3CbFlp+/VYCx8yTume
         cPzRELhkPnQAmMeB9DSYWbBClCNRE8nznz/uXvLgYJdi06MKsvHoV5od56srfwW4Bt
         w9rKmFxyA9QmNXKNjaWeRWQZA5eetzw5CAQz3xmu3tbRAlcQCGnqyIDSMn4EpVePuy
         A834r4FHJwh1JtI5ESGRiJixHEMKDfFytRXBoywp8PirWZU01dywuYmo5TbHSEDf5c
         MPcUrqdQpr0AzfHlwQwazNlWpQWmmdAC5aOj0MfbhGwzmxHrOs+HPhj4/GskWYSidZ
         LZjHVZ5AymH6Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Default root port setting hides AER capability. This patch enables the
advertisement of AER capability by root port.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4: No change

V3: No change

V2: No change

 drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index cd542a8af618..e402627bd221 100644
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

