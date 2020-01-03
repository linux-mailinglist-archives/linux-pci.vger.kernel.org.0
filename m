Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC912F68F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 11:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgACKH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 05:07:58 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2362 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgACKH6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2020 05:07:58 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0f12510001>; Fri, 03 Jan 2020 02:07:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 02:07:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 03 Jan 2020 02:07:57 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 10:07:56 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 10:07:56 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0f12780005>; Fri, 03 Jan 2020 02:07:56 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 2/5] PCI: dwc: Refactor core initialization code for EP mode
Date:   Fri, 3 Jan 2020 15:37:33 +0530
Message-ID: <20200103100736.27627-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103100736.27627-1-vidyas@nvidia.com>
References: <20200103100736.27627-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578046033; bh=jC+jVFEIhEm9CKmOx1bqAgrHEJ74z8k/IwNBM3Cv20w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=iWe/sUAQag0bLCAEcACXzQAujuLm78mNTsZ4zR82hM3WohEaCJuWmrXL9BMGDJMBt
         oz10bAzud1T6cF5A97IvGS+oEcBE83QTMJKUBcg/kcq6zrU8Etnm1sr5SBtvgx3/Dp
         NOeQxylP7ZG3WXoJXL/w/c4LfhlATyjXU3pB3ZXW2LRu3MHezRBVeILD0Rad4AcwMa
         aGMyg2T959BcOpGlWuY08Qf+Jxm7ewNszfFaHL4fwtyEz/IkXiDJjMwPocBWTf7uDN
         0Z72k9IlCXsWyzwIqu2z0YwsjvlN47rNeAbnMdxbiTu9r5k9EpIFE2MVYIyF/RXAs7
         Yop3XyBJUeaCg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Splits core initialization code for EP mode into two, one that doesn't
touch core registers and the other that touches core registers. The latter
would be called/skipped based on the EPC feature 'core_init_notifier'.
In case of platforms where this is skipped (Ex:- Tegra194), it would be
called indirectly through hooks from the function driver.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Changed EPC feature name from 'skip_core_init' to 'core_init_notifier'
* Made the pci-epc.h header file change as a separate patch as per the review
  comment from Kishon

 .../pci/controller/dwc/pcie-designware-ep.c   | 72 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  |  6 ++
 2 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 3dd2e2697294..c0ff34e5a1e3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -492,19 +492,53 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 	return 0;
 }
 
-int dw_pcie_ep_init(struct dw_pcie_ep *ep)
+int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	unsigned int offset;
+	unsigned int nbars;
+	u8 hdr_type;
+	u32 reg;
 	int i;
+
+	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
+	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
+		dev_err(pci->dev,
+			"PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
+			hdr_type);
+		return -EIO;
+	}
+
+	ep->msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
+
+	ep->msix_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSIX);
+
+	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
+	if (offset) {
+		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
+			PCI_REBAR_CTRL_NBAR_SHIFT;
+
+		dw_pcie_dbi_ro_wr_en(pci);
+		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
+			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+
+	dw_pcie_setup(pci);
+
+	return 0;
+}
+
+int dw_pcie_ep_init(struct dw_pcie_ep *ep)
+{
 	int ret;
-	u32 reg;
 	void *addr;
-	u8 hdr_type;
-	unsigned int nbars;
-	unsigned int offset;
 	struct pci_epc *epc;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
+	const struct pci_epc_features *epc_features;
 
 	if (!pci->dbi_base || !pci->dbi_base2) {
 		dev_err(dev, "dbi_base/dbi_base2 is not populated\n");
@@ -563,13 +597,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ep->ops->ep_init)
 		ep->ops->ep_init(ep);
 
-	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
-	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
-		dev_err(pci->dev, "PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
-			hdr_type);
-		return -EIO;
-	}
-
 	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
 	if (ret < 0)
 		epc->max_functions = 1;
@@ -587,23 +614,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
 		return -ENOMEM;
 	}
-	ep->msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
 
-	ep->msix_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSIX);
-
-	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
-	if (offset) {
-		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
-		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
-			PCI_REBAR_CTRL_NBAR_SHIFT;
-
-		dw_pcie_dbi_ro_wr_en(pci);
-		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
-			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
-		dw_pcie_dbi_ro_wr_dis(pci);
+	if (ep->ops->get_features) {
+		epc_features = ep->ops->get_features(ep);
+		if (epc_features->core_init_notifier)
+			return 0;
 	}
 
-	dw_pcie_setup(pci);
-
-	return 0;
+	return dw_pcie_ep_init_complete(ep);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5accdd6bc388..340783e9032e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -399,6 +399,7 @@ static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
 #ifdef CONFIG_PCIE_DW_EP
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
+int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -416,6 +417,11 @@ static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	return 0;
 }
 
+static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
+{
+	return 0;
+}
+
 static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 }
-- 
2.17.1

