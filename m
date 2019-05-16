Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D61A1FF00
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfEPFxr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:53:47 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15024 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFxr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:53:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfae60000>; Wed, 15 May 2019 22:53:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:53:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:53:46 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:53:46 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:53:45 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:53:42 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 09/28] PCI: tegra: Enable opportunistic UpdateFC and ACK
Date:   Thu, 16 May 2019 11:22:48 +0530
Message-ID: <20190516055307.25737-10-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986022; bh=fW/Yk8Cx7uZLxBdbdJROOXOQJH4Z2oSbZCVYgO+C/p4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Kzfoai83MOg2NtQglDq1bOFPH4/ydCbC+yohdS0bdlQ4lL12GSN+WodvhbsvK4DF2
         eZ981Y/dsRga6gooTjMmFWC6QEOznozR7fkLScprjmBoJx/lTO1pW9d6uqglPRQkAn
         MJZ7cJMq3rfdQrBLEJ64LGWZx0pxx4oAKQVdepXq1DiUvMa2z1S7kUvnYk8sx1tB8W
         +zt+4RFHyCKMi0gPun+P38p8wt8Em4WyBMDFyhgUahuC94x6m1Tx7RUSqlC3nJ/Ral
         iby+5aYWqF0kSS6y7pAgnP5BgKlDU9UR0vxLornigaoy1h4QAopqUueFDY1/AaMacv
         TnujQDRHwLw1w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable opportunistic UpdateFC and ACK to allow data link layer send
pending ACKs and UpdateFC packets when link is idle instead of waiting
for timers to expire. This improves the PCIe performance due to better
utilization of PCIe bandwidth.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4: No change

V3: No change

V2: No change

 drivers/pci/controller/pci-tegra.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 76d913ef5bf4..b1e2e398b4e8 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -204,7 +204,9 @@
 #define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK	0xffffffff
 
 #define RP_VEND_XP	0x00000f00
-#define  RP_VEND_XP_DL_UP	(1 << 30)
+#define  RP_VEND_XP_DL_UP			(1 << 30)
+#define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
+#define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
 
 #define RP_VEND_CTL1	0x00000f48
 #define  RP_VEND_CTL1_ERPT	(1 << 13)
@@ -529,6 +531,12 @@ static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
 	value = readl(port->base + RP_VEND_CTL1);
 	value |= RP_VEND_CTL1_ERPT;
 	writel(value, port->base + RP_VEND_CTL1);
+
+	/* Optimal settings to enhance bandwidth */
+	value = readl(port->base + RP_VEND_XP);
+	value |= RP_VEND_XP_OPPORTUNISTIC_ACK;
+	value |= RP_VEND_XP_OPPORTUNISTIC_UPDATEFC;
+	writel(value, port->base + RP_VEND_XP);
 }
 
 static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *port)
-- 
2.17.1

