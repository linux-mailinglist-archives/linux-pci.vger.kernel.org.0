Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE74B21858
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 14:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfEQMj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 08:39:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6600 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfEQMj7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 08:39:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdeaba30000>; Fri, 17 May 2019 05:40:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 May 2019 05:39:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 May 2019 05:39:57 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 12:39:56 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 12:39:56 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 May 2019 12:39:56 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cdeab960000>; Fri, 17 May 2019 05:39:55 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V7 05/15] PCI: dwc: Add ext config space capability search API
Date:   Fri, 17 May 2019 18:08:36 +0530
Message-ID: <20190517123846.3708-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517123846.3708-1-vidyas@nvidia.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558096803; bh=TBwnLyW0Hb7HWdvbSQliUL8oClxFf72lEWp/tl/F3hw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=G5sKCFAEdSd5b+Uwe78ZBQcF2CooWOzw1mfoykIoWRUhai5VikO4f6Ou6fdVja+HW
         tdqTvkhZv39XqEdWnMUNsAU5PBqLUkrn26LyLwSJJJpdoHoLkm/YF7rGtMWk64a4IS
         iqjH9REeWvtpVjSfQLoT4zIXiN94kHgnSZDAkJiVoaUZ/8Bd9+9EiI7sTQUF+4C+Mc
         6mRDTSQwzq6bA1dU02vJ+keXMTbwLSwK0glqnjS/4o2lNefDjjS9hVhOgvK9bYDfhX
         eFhhF2YKmABTDLxxIBjFkXvo83G4phkP3tLx2Hw+BMifFDJWs9MGGh8fbzedKTYqtM
         6d3YgNVU3sN5A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add extended configuration space capability search API using struct dw_pcie *
pointer

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Changes since [v6]:
* None

Changes since [v5]:
* None

Changes since [v4]:
* None

Changes since [v3]:
* None

Changes since [v2]:
* None

Changes since [v1]:
* This is a new patch in v2 series

 drivers/pci/controller/dwc/pcie-designware.c | 41 ++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 42 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 8f53ce63d17e..3b7d50888caa 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -54,6 +54,47 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
 
+static int dw_pcie_find_next_ext_capability(struct dw_pcie *pci, int start,
+					    int cap)
+{
+	u32 header;
+	int ttl;
+	int pos = PCI_CFG_SPACE_SIZE;
+
+	/* minimum 8 bytes per capability */
+	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
+
+	if (start)
+		pos = start;
+
+	header = dw_pcie_readl_dbi(pci, pos);
+	/*
+	 * If we have no capabilities, this is indicated by cap ID,
+	 * cap version and next pointer all being 0.
+	 */
+	if (header == 0)
+		return 0;
+
+	while (ttl-- > 0) {
+		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
+			return pos;
+
+		pos = PCI_EXT_CAP_NEXT(header);
+		if (pos < PCI_CFG_SPACE_SIZE)
+			break;
+
+		header = dw_pcie_readl_dbi(pci, pos);
+	}
+
+	return 0;
+}
+
+int dw_pcie_find_ext_capability(struct dw_pcie *pci, int cap)
+{
+	return dw_pcie_find_next_ext_capability(pci, 0, cap);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 6cb978132469..fff284098117 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -252,6 +252,7 @@ struct dw_pcie {
 		container_of((endpoint), struct dw_pcie, ep)
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
+int dw_pcie_find_ext_capability(struct dw_pcie *pci, int cap);
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
-- 
2.17.1

