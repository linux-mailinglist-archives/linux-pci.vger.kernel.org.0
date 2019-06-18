Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F241E4A923
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfFRSCx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 14:02:53 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12490 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfFRSCx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 14:02:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d09274d0000>; Tue, 18 Jun 2019 11:02:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 11:02:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 11:02:52 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:02:51 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 18:02:48 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 11/27] PCI: tegra: Process pending DLL transactions before entering L1 or L2
Date:   Tue, 18 Jun 2019 23:31:50 +0530
Message-ID: <20190618180206.4908-12-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618180206.4908-1-mmaddireddy@nvidia.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560880973; bh=MnXPSAHe2ad6GKU0/VnKBASSl+c9Wus37t9Bip23ySk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=DxHYSJUPr6VXtlDQ5ImWRFuHqtprOMx1iZNU6AWL5N/o2AfDHtgT5+KvIvqnQaC7P
         USyq7ph/eKJ+FSryX30LgSbaiLLSJE7EGR1pPasy0NBYGmP6xgVhPQKfUbC92LK877
         3BfjSE21AWJFvtKsZr0+LhytX7Li2vlGUWVTkuYgDOMAio+tXGVJQCqzJQ4m4YXRKF
         hi0UedN5EPts7fkzrAdJa/exS36cgrUjsx8OnLhA1LSBnCm9un1m33UvaOIohMkQ06
         0Rwjqn9KIaWRBetdpQBEqXbtiUP96CXxOmsP7Sax4M3ZAyEFP1b5NfAV3NqDYqFdwB
         S2TTkdZ2BOPMw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PM message are truncated while entering L1 or L2, which is resulting in
receiver errors. Set the required bit to finish processing DLLP before
link enter L1 or L2.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V6: No change

V5: No change

V4: No change

V3: No change

V2: No change

 drivers/pci/controller/pci-tegra.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index ca02866fbbb4..7cd2a8948919 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -212,6 +212,9 @@
 #define RP_VEND_CTL1	0x00000f48
 #define  RP_VEND_CTL1_ERPT	(1 << 13)
 
+#define RP_VEND_XP_BIST	0x00000f4c
+#define  RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE	(1 << 28)
+
 #define RP_VEND_CTL2 0x00000fa8
 #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
 
@@ -538,6 +541,14 @@ static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
 	value |= RP_VEND_XP_OPPORTUNISTIC_ACK;
 	value |= RP_VEND_XP_OPPORTUNISTIC_UPDATEFC;
 	writel(value, port->base + RP_VEND_XP);
+
+	/*
+	 * LTSSM will wait for DLLP to finish before entering L1 or L2,
+	 * to avoid truncation of PM messages which results in receiver errors
+	 */
+	value = readl(port->base + RP_VEND_XP_BIST);
+	value |= RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE;
+	writel(value, port->base + RP_VEND_XP_BIST);
 }
 
 static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *port)
-- 
2.17.1

