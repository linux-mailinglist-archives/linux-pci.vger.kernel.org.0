Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01FDE735DF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 19:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfGXRtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 13:49:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14324 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGXRtC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 13:49:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d389a0d0000>; Wed, 24 Jul 2019 10:49:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 24 Jul 2019 10:49:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 24 Jul 2019 10:49:01 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jul
 2019 17:49:00 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 24 Jul 2019 17:49:00 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d389a070004>; Wed, 24 Jul 2019 10:49:00 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V14 04/13] PCI: dwc: Move config space capability search API
Date:   Wed, 24 Jul 2019 23:18:15 +0530
Message-ID: <20190724174824.20933-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724174824.20933-1-vidyas@nvidia.com>
References: <20190724174824.20933-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563990541; bh=pSX4szLrhmCjh5VEaltxX6tPvF91YFM4CxZfXqF3he8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=KnexkMFLPl2XhWd0v0+taMDueWnJDIfX0aYeico6khyDxcB1875crxVtYtCMHEtVh
         xINy329U93D1YQaRIqMq1ZV4WdhtxANox07VTQV4h0SSNuXPOvqeszhcUxgcNfiHA+
         NlD5JDvnkwNuA0EjLYn748j7PumYxyNRBynwtHkqJuHTb1I2tDzHzV5ZCCp+iT+50x
         jgOaIDS+DUa8yqtIL8/YjOJ/fozxcgu8JHogCRKFz3cAIL3gsc4qf+OnpeifMMzRSJ
         HaYc6IU9IsUASGXTgRhqL6cjm6RDm4a8f5Sg/BwPXP8EJUJ2JddPXoCdoodapiBvYV
         H3RvFri0kvzPg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move PCIe config space capability search API to common DesignWare file
as this can be used by both host and ep mode codes.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
V14:
* None

V13:
* None

V12:
* None

V11:
* None

V10:
* None

V9:
* None

V8:
* Changed comment to explicitly state their mere resemblance to standard APIs
  but not their operation and place of use.

V7:
* Exported dw_pcie_find_capability() API

V6:
* None

V5:
* Removed redundant APIs in pcie-designware-ep.c file after moving them
  to pcie-designware.c file based on Bjorn's comments.

V4:
* Rebased to linux-next top of the tree

V3:
* None

V2:
* Removed dw_pcie_find_next_ext_capability() API from here and made a
  separate patch for that

 .../pci/controller/dwc/pcie-designware-ep.c   | 37 +-----------------
 drivers/pci/controller/dwc/pcie-designware.c  | 39 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +
 3 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 2bf5a35c0570..65f479250087 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -40,39 +40,6 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 	__dw_pcie_ep_reset_bar(pci, bar, 0);
 }
 
-static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
-			      u8 cap)
-{
-	u8 cap_id, next_cap_ptr;
-	u16 reg;
-
-	if (!cap_ptr)
-		return 0;
-
-	reg = dw_pcie_readw_dbi(pci, cap_ptr);
-	cap_id = (reg & 0x00ff);
-
-	if (cap_id > PCI_CAP_ID_MAX)
-		return 0;
-
-	if (cap_id == cap)
-		return cap_ptr;
-
-	next_cap_ptr = (reg & 0xff00) >> 8;
-	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
-}
-
-static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
-{
-	u8 next_cap_ptr;
-	u16 reg;
-
-	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
-	next_cap_ptr = (reg & 0x00ff);
-
-	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
-}
-
 static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
 				   struct pci_epf_header *hdr)
 {
@@ -612,9 +579,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
 		return -ENOMEM;
 	}
-	ep->msi_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSI);
+	ep->msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
 
-	ep->msix_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSIX);
+	ep->msix_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSIX);
 
 	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
 	if (offset) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 7d25102c304c..7818b4febb08 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -14,6 +14,45 @@
 
 #include "pcie-designware.h"
 
+/*
+ * These interfaces resemble the pci_find_*capability() interfaces, but these
+ * are for configuring host controllers, which are bridges *to* PCI devices but
+ * are not PCI devices themselves.
+ */
+static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
+				  u8 cap)
+{
+	u8 cap_id, next_cap_ptr;
+	u16 reg;
+
+	if (!cap_ptr)
+		return 0;
+
+	reg = dw_pcie_readw_dbi(pci, cap_ptr);
+	cap_id = (reg & 0x00ff);
+
+	if (cap_id > PCI_CAP_ID_MAX)
+		return 0;
+
+	if (cap_id == cap)
+		return cap_ptr;
+
+	next_cap_ptr = (reg & 0xff00) >> 8;
+	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
+}
+
+u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
+{
+	u8 next_cap_ptr;
+	u16 reg;
+
+	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
+	next_cap_ptr = (reg & 0x00ff);
+
+	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ffed084a0b4f..d8c66a6827dc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -251,6 +251,8 @@ struct dw_pcie {
 #define to_dw_pcie_from_ep(endpoint)   \
 		container_of((endpoint), struct dw_pcie, ep)
 
+u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
 
-- 
2.17.1

