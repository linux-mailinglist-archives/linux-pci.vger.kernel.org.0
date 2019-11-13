Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C9CFAC96
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 10:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfKMJJG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 04:09:06 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2673 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfKMJJG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 04:09:06 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcbc82f0000>; Wed, 13 Nov 2019 01:09:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 Nov 2019 01:09:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 Nov 2019 01:09:04 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 09:09:04 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Nov 2019 09:09:04 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dcbc82c0001>; Wed, 13 Nov 2019 01:09:03 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 1/4] PCI: dwc: Add new feature to skip core initialization
Date:   Wed, 13 Nov 2019 14:38:48 +0530
Message-ID: <20191113090851.26345-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113090851.26345-1-vidyas@nvidia.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573636144; bh=0b7zNkaq3r9gWXtdHZm2JDtZxE+2KMnhpXzYRweAuu8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Z6cxlQ63keRXT2mya47vvYaTlFXMJQFUnpt+qIR/agTAl/EQ1G49AaDv1Zh2yVEMR
         A0MeqOt2PEwKuQadTZ60ZLfRejDVObegOsKdhq0KKVnvBpT3Y2XFw+NEyrj+Rnxlo2
         JluwZ48v42qWOts1azrYTIzFN9RqI2KLyOzeJWflESTAc2VCVVdr1uSHIzpG49zpj0
         DiQaLXJsPGLphPDKd/xHG/JXRYxs/CTNPX7AxVGkxI1oKa/zrtQk/EiZS4Dm5D8LiG
         ILSCY6gVTQrTdOq/5K7gH0UGA2JGrMm719O0FRvJH1ulpYSOtpu1GU6p1JgBXaYOcr
         jKxUFzQz5SivA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new feature 'skip_core_init' that can be set by platform drivers
of devices that do not have their core registers available until reference
clock from host is available (Ex:- Tegra194) to indicate DesignWare
endpoint mode sub-system to not perform core registers initialization.
Existing dw_pcie_ep_init() is refactored and all the code that touches
registers is extracted to form a new API dw_pcie_ep_init_complete() that
can be called later by platform drivers setting 'skip_core_init' to '1'.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 72 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  |  6 ++
 include/linux/pci-epc.h                       |  1 +
 3 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 3dd2e2697294..06f4379be8a3 100644
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
+		if (epc_features->skip_core_init)
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
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 36644ccd32ac..241e6a6f39fb 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -121,6 +121,7 @@ struct pci_epc_features {
 	u8	bar_fixed_64bit;
 	u64	bar_fixed_size[PCI_STD_NUM_BARS];
 	size_t	align;
+	bool	skip_core_init;
 };
 
 #define to_pci_epc(device) container_of((device), struct pci_epc, dev)
-- 
2.17.1

