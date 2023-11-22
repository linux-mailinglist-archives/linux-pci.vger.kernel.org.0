Return-Path: <linux-pci+bounces-87-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F7C7F3DD6
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D6B282767
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0B415AC4;
	Wed, 22 Nov 2023 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PB7mH0oW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A949156D9
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8C2C433C8;
	Wed, 22 Nov 2023 06:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633053;
	bh=7dv5I3LN2VwhTdWb7SxBcLxV42q/Vd6RpQOAdXMRlW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PB7mH0oWQ8erWcs1ZR3UuStkrzhIsaw67sjXVvrJJZSthLjexjWw83wOmjUEvQKcI
	 Qs5LUtt0v+xu9Uw7K083M16faar98CNwWp5p3F40sWajvxaCILsryTiWnA/Dbw/x0g
	 9KxY+FNQ8eYxfij/17dcydpqTkqIVy18j5eH7AKI3O1+gxcET7igsPqucnqX3SwmfB
	 AaofZK3GLvQ0q7q+UZCmpoOPEzFzBG8Ylyjf2c2hsOAyPq26XMCD+ISMCPP7bwu3c+
	 5CJbxhsIvnAjHCLKVy3WbGtSIKq9N51fA2J4kd416ieSSXqtapf2SpYiJQM23bBf3C
	 EuXbkEQuBqOEw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 02/16] PCI: endpoint: Drop PCI_EPC_IRQ_XXX definitions
Date: Wed, 22 Nov 2023 15:03:52 +0900
Message-ID: <20231122060406.14695-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linux/pci.h defines the IRQ flags PCI_IRQ_INTX, PCI_IRQ_MSI and
PCI_IRQ_MSIX. Let's use these flags directly instead of the endpoint
definitions provided by enum pci_epc_irq_type. This removes the need
for defining this enum type completely.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c  |  9 ++++-----
 drivers/pci/controller/dwc/pci-dra7xx.c           |  6 +++---
 drivers/pci/controller/dwc/pci-imx6.c             |  9 ++++-----
 drivers/pci/controller/dwc/pci-keystone.c         |  9 ++++-----
 drivers/pci/controller/dwc/pci-layerscape-ep.c    |  8 ++++----
 drivers/pci/controller/dwc/pcie-artpec6.c         |  8 ++++----
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  2 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c |  9 ++++-----
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 drivers/pci/controller/dwc/pcie-keembay.c         | 13 ++++++-------
 drivers/pci/controller/dwc/pcie-qcom-ep.c         |  6 +++---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       |  7 +++----
 drivers/pci/controller/dwc/pcie-tegra194.c        |  9 ++++-----
 drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  7 +++----
 drivers/pci/controller/pcie-rcar-ep.c             |  7 +++----
 drivers/pci/controller/pcie-rockchip-ep.c         |  7 +++----
 drivers/pci/endpoint/functions/pci-epf-mhi.c      |  2 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c      |  4 ++--
 drivers/pci/endpoint/functions/pci-epf-test.c     |  6 +++---
 drivers/pci/endpoint/functions/pci-epf-vntb.c     |  7 ++-----
 drivers/pci/endpoint/pci-epc-core.c               |  2 +-
 include/linux/pci-epc.h                           | 11 ++---------
 22 files changed, 65 insertions(+), 85 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 3142feb8ac19..3d71d687ea64 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -532,25 +532,24 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 }
 
 static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
-				  enum pci_epc_irq_type type,
-				  u16 interrupt_num)
+				  unsigned int type, u16 interrupt_num)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
 	struct device *dev = pcie->dev;
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_IRQ_INTX:
 		if (vfn > 0) {
 			dev_err(dev, "Cannot raise legacy interrupts for VF\n");
 			return -EINVAL;
 		}
 		return cdns_pcie_ep_send_legacy_irq(ep, fn, vfn, 0);
 
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		return cdns_pcie_ep_send_msi_irq(ep, fn, vfn, interrupt_num);
 
-	case PCI_EPC_IRQ_MSIX:
+	case PCI_IRQ_MSIX:
 		return cdns_pcie_ep_send_msix_irq(ep, fn, vfn, interrupt_num);
 
 	default:
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index b445ffe95e3f..f257a42f3314 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -404,16 +404,16 @@ static void dra7xx_pcie_raise_msi_irq(struct dra7xx_pcie *dra7xx,
 }
 
 static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				 enum pci_epc_irq_type type, u16 interrupt_num)
+				 unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_IRQ_INTX:
 		dra7xx_pcie_raise_legacy_irq(dra7xx);
 		break;
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		dra7xx_pcie_raise_msi_irq(dra7xx, interrupt_num);
 		break;
 	default:
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 74703362aeec..a5365ab8897e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1058,17 +1058,16 @@ static void imx6_pcie_ep_init(struct dw_pcie_ep *ep)
 }
 
 static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				  enum pci_epc_irq_type type,
-				  u16 interrupt_num)
+				  unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_IRQ_INTX:
 		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
-	case PCI_EPC_IRQ_MSIX:
+	case PCI_IRQ_MSIX:
 		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
 	default:
 		dev_err(pci->dev, "UNKNOWN IRQ type\n");
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 0def919f89fa..84f6a4acee07 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -900,20 +900,19 @@ static void ks_pcie_am654_raise_legacy_irq(struct keystone_pcie *ks_pcie)
 }
 
 static int ks_pcie_am654_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				   enum pci_epc_irq_type type,
-				   u16 interrupt_num)
+				   unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_IRQ_INTX:
 		ks_pcie_am654_raise_legacy_irq(ks_pcie);
 		break;
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 		break;
-	case PCI_EPC_IRQ_MSIX:
+	case PCI_IRQ_MSIX:
 		dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
 		break;
 	default:
diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 3d3c50ef4b6f..5f78a9415286 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -166,16 +166,16 @@ static void ls_pcie_ep_init(struct dw_pcie_ep *ep)
 }
 
 static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				enum pci_epc_irq_type type, u16 interrupt_num)
+				unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_IRQ_INTX:
 		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
-	case PCI_EPC_IRQ_MSIX:
+	case PCI_IRQ_MSIX:
 		return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
 							  interrupt_num);
 	default:
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 9b572a2b2c9a..fc426182443a 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -352,15 +352,15 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
 }
 
 static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				  enum pci_epc_irq_type type, u16 interrupt_num)
+				  unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
-		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
+	case PCI_IRQ_INTX:
+		dev_err(pci->dev, "EP cannot trigger INTx IRQs\n");
 		return -EINVAL;
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	default:
 		dev_err(pci->dev, "UNKNOWN IRQ type\n");
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f6207989fc6a..87759c899fab 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -443,7 +443,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 
 static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-				enum pci_epc_irq_type type, u16 interrupt_num)
+				unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index b625841e98aa..c83968aa0149 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -42,17 +42,16 @@ static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
 }
 
 static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				     enum pci_epc_irq_type type,
-				     u16 interrupt_num)
+				     unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_IRQ_INTX:
 		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
-	case PCI_EPC_IRQ_MSIX:
+	case PCI_IRQ_MSIX:
 		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
 	default:
 		dev_err(pci->dev, "UNKNOWN IRQ type\n");
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 55ff76e3d384..ffb9a62f3179 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -335,7 +335,7 @@ struct dw_pcie_ep_ops {
 	void	(*ep_init)(struct dw_pcie_ep *ep);
 	void	(*deinit)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
-			     enum pci_epc_irq_type type, u16 interrupt_num);
+			     unsigned int type, u16 interrupt_num);
 	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
 	/*
 	 * Provide a method to implement the different func config space
diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 289bff99d762..8e0e2e28ef67 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -289,19 +289,18 @@ static void keembay_pcie_ep_init(struct dw_pcie_ep *ep)
 }
 
 static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				     enum pci_epc_irq_type type,
-				     u16 interrupt_num)
+				     unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
-		/* Legacy interrupts are not supported in Keem Bay */
-		dev_err(pci->dev, "Legacy IRQ is not supported\n");
+	case PCI_IRQ_INTX:
+		/* INTx interrupts are not supported in Keem Bay */
+		dev_err(pci->dev, "INTx IRQ is not supported\n");
 		return -EINVAL;
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
-	case PCI_EPC_IRQ_MSIX:
+	case PCI_IRQ_MSIX:
 		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
 	default:
 		dev_err(pci->dev, "Unknown IRQ type %d\n", type);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 9e58f055199a..2e5ab5fef310 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -726,14 +726,14 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
 }
 
 static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				  enum pci_epc_irq_type type, u16 interrupt_num)
+				  unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_IRQ_INTX:
 		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	default:
 		dev_err(pci->dev, "Unknown IRQ type\n");
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 3bc45e513b3d..25354a82674d 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -362,15 +362,14 @@ static void rcar_gen4_pcie_ep_deinit(struct dw_pcie_ep *ep)
 }
 
 static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				       enum pci_epc_irq_type type,
-				       u16 interrupt_num)
+				       unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_IRQ_INTX:
 		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	default:
 		dev_err(dw->dev, "Unknown IRQ type\n");
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0fe113598ebb..a1f37d2d7798 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1979,20 +1979,19 @@ static int tegra_pcie_ep_raise_msix_irq(struct tegra_pcie_dw *pcie, u16 irq)
 }
 
 static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				   enum pci_epc_irq_type type,
-				   u16 interrupt_num)
+				   unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_IRQ_INTX:
 		return tegra_pcie_ep_raise_legacy_irq(pcie, interrupt_num);
 
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		return tegra_pcie_ep_raise_msi_irq(pcie, interrupt_num);
 
-	case PCI_EPC_IRQ_MSIX:
+	case PCI_IRQ_MSIX:
 		return tegra_pcie_ep_raise_msix_irq(pcie, interrupt_num);
 
 	default:
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index cba3c88fcf39..d47236d5678d 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -256,15 +256,14 @@ static int uniphier_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
 }
 
 static int uniphier_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				      enum pci_epc_irq_type type,
-				      u16 interrupt_num)
+				      unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_IRQ_INTX:
 		return uniphier_pcie_ep_raise_legacy_irq(ep);
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		return uniphier_pcie_ep_raise_msi_irq(ep, func_no,
 						      interrupt_num);
 	default:
diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index 7034c0ff23d0..e6909271def7 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -402,16 +402,15 @@ static int rcar_pcie_ep_assert_msi(struct rcar_pcie *pcie,
 }
 
 static int rcar_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
-				  enum pci_epc_irq_type type,
-				  u16 interrupt_num)
+				  unsigned int type, u16 interrupt_num)
 {
 	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_IRQ_INTX:
 		return rcar_pcie_ep_assert_intx(ep, fn, 0);
 
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		return rcar_pcie_ep_assert_msi(&ep->pcie, fn, interrupt_num);
 
 	default:
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 0af0e965fb57..95b1c8ef59c3 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -407,15 +407,14 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 }
 
 static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
-				      enum pci_epc_irq_type type,
-				      u16 interrupt_num)
+				      unsigned int type, u16 interrupt_num)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_IRQ_INTX:
 		return rockchip_pcie_ep_send_legacy_irq(ep, fn, 0);
-	case PCI_EPC_IRQ_MSI:
+	case PCI_IRQ_MSI:
 		return rockchip_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
 	default:
 		return -EINVAL;
diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index b7b9d3e21f97..b9f8d2858cb7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -205,7 +205,7 @@ static void pci_epf_mhi_raise_irq(struct mhi_ep_cntrl *mhi_cntrl, u32 vector)
 	 * MHI supplies 0 based MSI vectors but the API expects the vector
 	 * number to start from 1, so we need to increment the vector by 1.
 	 */
-	pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no, PCI_EPC_IRQ_MSI,
+	pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no, PCI_IRQ_MSI,
 			  vector + 1);
 }
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 9aac2c6f3bb9..fad00b1a8335 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -140,9 +140,9 @@ static struct pci_epf_header epf_ntb_header = {
 static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 {
 	enum pci_epc_interface_type type;
-	enum pci_epc_irq_type irq_type;
 	struct epf_ntb_epc *ntb_epc;
 	struct epf_ntb_ctrl *ctrl;
+	unsigned int irq_type;
 	struct pci_epc *epc;
 	u8 func_no, vfunc_no;
 	bool is_msix;
@@ -159,7 +159,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 			ctrl->link_status |= LINK_STATUS_UP;
 		else
 			ctrl->link_status &= ~LINK_STATUS_UP;
-		irq_type = is_msix ? PCI_EPC_IRQ_MSIX : PCI_EPC_IRQ_MSI;
+		irq_type = is_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
 		ret = pci_epc_raise_irq(epc, func_no, vfunc_no, irq_type, 1);
 		if (ret) {
 			dev_err(&epc->dev,
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 1f0d2b84296a..9d39fda5c348 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -602,7 +602,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	switch (reg->irq_type) {
 	case IRQ_TYPE_LEGACY:
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_LEGACY, 0);
+				  PCI_IRQ_INTX, 0);
 		break;
 	case IRQ_TYPE_MSI:
 		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
@@ -612,7 +612,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 			return;
 		}
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_MSI, reg->irq_number);
+				  PCI_IRQ_MSI, reg->irq_number);
 		break;
 	case IRQ_TYPE_MSIX:
 		count = pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
@@ -622,7 +622,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 			return;
 		}
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_MSIX, reg->irq_number);
+				  PCI_IRQ_MSIX, reg->irq_number);
 		break;
 	default:
 		dev_err(dev, "Failed to raise IRQ, unknown type\n");
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 3f60128560ed..e6a0bcc177e4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1172,11 +1172,8 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 	func_no = ntb->epf->func_no;
 	vfunc_no = ntb->epf->vfunc_no;
 
-	ret = pci_epc_raise_irq(ntb->epf->epc,
-				func_no,
-				vfunc_no,
-				PCI_EPC_IRQ_MSI,
-				interrupt_num + 1);
+	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
+				PCI_IRQ_MSI, interrupt_num + 1);
 	if (ret)
 		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 56e1184bc6c2..0810420df42c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -217,7 +217,7 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
  * Invoke to raise an legacy, MSI or MSI-X interrupt
  */
 int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-		      enum pci_epc_irq_type type, u16 interrupt_num)
+		      unsigned int type, u16 interrupt_num)
 {
 	int ret;
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 5cb694031072..f498f9aa2ab0 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -19,13 +19,6 @@ enum pci_epc_interface_type {
 	SECONDARY_INTERFACE,
 };
 
-enum pci_epc_irq_type {
-	PCI_EPC_IRQ_UNKNOWN,
-	PCI_EPC_IRQ_LEGACY,
-	PCI_EPC_IRQ_MSI,
-	PCI_EPC_IRQ_MSIX,
-};
-
 static inline const char *
 pci_epc_interface_string(enum pci_epc_interface_type type)
 {
@@ -79,7 +72,7 @@ struct pci_epc_ops {
 			    u16 interrupts, enum pci_barno, u32 offset);
 	int	(*get_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-			     enum pci_epc_irq_type type, u16 interrupt_num);
+			     unsigned int type, u16 interrupt_num);
 	int	(*map_msi_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			       phys_addr_t phys_addr, u8 interrupt_num,
 			       u32 entry_size, u32 *msi_data,
@@ -229,7 +222,7 @@ int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			phys_addr_t phys_addr, u8 interrupt_num,
 			u32 entry_size, u32 *msi_data, u32 *msi_addr_offset);
 int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-		      enum pci_epc_irq_type type, u16 interrupt_num);
+		      unsigned int type, u16 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
-- 
2.42.0


