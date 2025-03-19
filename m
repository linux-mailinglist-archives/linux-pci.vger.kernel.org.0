Return-Path: <linux-pci+bounces-24084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21D9A68842
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 10:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A0A168EA2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 09:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849F325A35E;
	Wed, 19 Mar 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAm11FZz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0DF253B6E;
	Wed, 19 Mar 2025 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376742; cv=none; b=s5eDPeB3VKmu4nvmvzbf0Q5rnHhvcdFcIh6qi8ojoBadUlrEEWXEhXpK5bTOAER+lmNQX6p361rDVPZ7BC5UzgPRzsRE8XpPAVcZ2h+nSJA4rKrs/GsqjmVJPh6zSJBCmGgqb0AjJIewMwfIX6qrc46dQTsdaNa3SL0mdRV1Va0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376742; c=relaxed/simple;
	bh=WmolbYADk/HgtcX4FFtbA+sZUbnRdoFjblnJqTCUNwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opVyA5EO2BEtkVLXhJ1hywRd6FYJirWPJVMShBoTKJHO/yyM4ZSne5ONPxb3mBZuMJHLAncvQ8iMpvKxOLL74DHhwiRIBnN2d059ewayPohg09YE4SQk5ubCZrh1CWCac/yYQjuIERnRY9QgU0z+jjHu8TCpmX60ZzUjB6AtABM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAm11FZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723C7C4CEE9;
	Wed, 19 Mar 2025 09:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376741;
	bh=WmolbYADk/HgtcX4FFtbA+sZUbnRdoFjblnJqTCUNwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MAm11FZz7MlEOZr364jjvY6giNGkq7ov/vCfF2HUB8KdSmXFnfO6qnf7RRcae/QQC
	 OstaI6YFA6WM+/SL7z77M6BtbpqqCPNw0JyiyoZmITT7s92B1WY4eY2JdsYPTZIx6+
	 7DQfZAzLA/b1q21BPpCxJvMM9um8qmBKdEBJbtj1c/IV1FOzj5qJpvriqjW+T5cHwS
	 BmxA6iwfMD14eVt+xjYG1fCex6qiazLNHwhY4SaDtA2RqQtQTqQ5SmO0sBf047AmJT
	 AwX5GwYCikNHekntK+5aWDcvCPw0vb6XuSu+HxpM6fZZq8GiYhLIuYpaYpHAe5bgO4
	 +LfsxdU1EHiOw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Toan Le <toan@os.amperecomputing.com>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 29/57] irqdomain: pci: Switch to irq_domain_create_linear()
Date: Wed, 19 Mar 2025 10:29:22 +0100
Message-ID: <20250319092951.37667-30-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: "Pali Rohár" <pali@kernel.org>
Cc: Toan Le <toan@os.amperecomputing.com>
Cc: Joyce Ooi <joyce.ooi@intel.com>
Cc: Jim Quinlan <jim2101024@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-dra7xx.c            |  4 ++--
 drivers/pci/controller/dwc/pci-keystone.c          |  2 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      |  4 ++--
 drivers/pci/controller/dwc/pcie-uniphier.c         |  2 +-
 .../pci/controller/mobiveil/pcie-mobiveil-host.c   |  9 ++++-----
 drivers/pci/controller/pci-aardvark.c              | 14 +++++---------
 drivers/pci/controller/pci-ftpci100.c              |  4 ++--
 drivers/pci/controller/pci-mvebu.c                 |  6 +++---
 drivers/pci/controller/pci-xgene-msi.c             |  3 +--
 drivers/pci/controller/pcie-altera-msi.c           |  2 +-
 drivers/pci/controller/pcie-altera.c               |  2 +-
 drivers/pci/controller/pcie-brcmstb.c              |  2 +-
 drivers/pci/controller/pcie-iproc-msi.c            |  4 ++--
 drivers/pci/controller/pcie-mediatek-gen3.c        |  9 +++++----
 drivers/pci/controller/pcie-mediatek.c             |  4 ++--
 drivers/pci/controller/pcie-rockchip-host.c        |  4 ++--
 drivers/pci/controller/pcie-xilinx-cpm.c           | 10 ++++------
 drivers/pci/controller/pcie-xilinx-dma-pl.c        | 12 ++++++------
 drivers/pci/controller/pcie-xilinx-nwl.c           |  9 +++------
 drivers/pci/controller/pcie-xilinx.c               |  5 ++---
 drivers/pci/controller/plda/pcie-plda-host.c       | 14 ++++++--------
 21 files changed, 56 insertions(+), 69 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 33d6bf460ffe..3219704aba0e 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -359,8 +359,8 @@ static int dra7xx_pcie_init_irq_domain(struct dw_pcie_rp *pp)
 
 	irq_set_chained_handler_and_data(pp->irq, dra7xx_pcie_msi_irq_handler,
 					 pp);
-	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						   &intx_domain_ops, pp);
+	dra7xx->irq_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node),
+						      PCI_NUM_INTX, &intx_domain_ops, pp);
 	of_node_put(pcie_intc_node);
 	if (!dra7xx->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 76a37368ae4f..1385d9db7b32 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -761,7 +761,7 @@ static int ks_pcie_config_intx_irq(struct keystone_pcie *ks_pcie)
 						 ks_pcie);
 	}
 
-	intx_irq_domain = irq_domain_add_linear(intc_np, PCI_NUM_INTX,
+	intx_irq_domain = irq_domain_create_linear(of_fwnode_handle(intc_np), PCI_NUM_INTX,
 					&ks_pcie_intx_irq_domain_ops, NULL);
 	if (!intx_irq_domain) {
 		dev_err(dev, "Failed to add irq domain for INTX irqs\n");
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c624b7ebd118..678d510a261d 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -144,8 +144,8 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
 		return -EINVAL;
 	}
 
-	rockchip->irq_domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
-						    &intx_domain_ops, rockchip);
+	rockchip->irq_domain = irq_domain_create_linear(of_fwnode_handle(intc), PCI_NUM_INTX,
+							&intx_domain_ops, rockchip);
 	of_node_put(intc);
 	if (!rockchip->irq_domain) {
 		dev_err(dev, "failed to get a INTx IRQ domain\n");
diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 5757ca3803c9..43b28f826edd 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -279,7 +279,7 @@ static int uniphier_pcie_config_intx_irq(struct dw_pcie_rp *pp)
 		goto out_put_node;
 	}
 
-	pcie->intx_irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
+	pcie->intx_irq_domain = irq_domain_create_linear(of_fwnode_handle(np_intc), PCI_NUM_INTX,
 						&uniphier_intx_domain_ops, pp);
 	if (!pcie->intx_irq_domain) {
 		dev_err(pci->dev, "Failed to get INTx domain\n");
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 6628eed9d26e..a600f46ee3c3 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -439,8 +439,8 @@ static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
 	struct mobiveil_msi *msi = &pcie->rp.msi;
 
 	mutex_init(&msi->lock);
-	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
-						&msi_domain_ops, pcie);
+	msi->dev_domain = irq_domain_create_linear(NULL, msi->num_of_vectors,
+						   &msi_domain_ops, pcie);
 	if (!msi->dev_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
@@ -461,12 +461,11 @@ static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
 static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	struct device_node *node = dev->of_node;
 	struct mobiveil_root_port *rp = &pcie->rp;
 
 	/* setup INTx */
-	rp->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
-						&intx_domain_ops, pcie);
+	rp->intx_domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node), PCI_NUM_INTX,
+						   &intx_domain_ops, pcie);
 
 	if (!rp->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index a29796cce420..7bac64533b14 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1456,9 +1456,8 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 	raw_spin_lock_init(&pcie->msi_irq_lock);
 	mutex_init(&pcie->msi_used_lock);
 
-	pcie->msi_inner_domain =
-		irq_domain_add_linear(NULL, MSI_IRQ_NUM,
-				      &advk_msi_domain_ops, pcie);
+	pcie->msi_inner_domain = irq_domain_create_linear(NULL, MSI_IRQ_NUM,
+							  &advk_msi_domain_ops, pcie);
 	if (!pcie->msi_inner_domain)
 		return -ENOMEM;
 
@@ -1508,9 +1507,8 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	irq_chip->irq_mask = advk_pcie_irq_mask;
 	irq_chip->irq_unmask = advk_pcie_irq_unmask;
 
-	pcie->irq_domain =
-		irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-				      &advk_pcie_irq_domain_ops, pcie);
+	pcie->irq_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), PCI_NUM_INTX,
+						    &advk_pcie_irq_domain_ops, pcie);
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		ret = -ENOMEM;
@@ -1549,9 +1547,7 @@ static const struct irq_domain_ops advk_pcie_rp_irq_domain_ops = {
 
 static int advk_pcie_init_rp_irq_domain(struct advk_pcie *pcie)
 {
-	pcie->rp_irq_domain = irq_domain_add_linear(NULL, 1,
-						    &advk_pcie_rp_irq_domain_ops,
-						    pcie);
+	pcie->rp_irq_domain = irq_domain_create_linear(NULL, 1, &advk_pcie_rp_irq_domain_ops, pcie);
 	if (!pcie->rp_irq_domain) {
 		dev_err(&pcie->pdev->dev, "Failed to add Root Port IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index ffdeed25e961..28e43831c0f1 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -345,8 +345,8 @@ static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
 		return irq ?: -EINVAL;
 	}
 
-	p->irqdomain = irq_domain_add_linear(intc, PCI_NUM_INTX,
-					     &faraday_pci_irqdomain_ops, p);
+	p->irqdomain = irq_domain_create_linear(of_fwnode_handle(intc), PCI_NUM_INTX,
+						&faraday_pci_irqdomain_ops, p);
 	of_node_put(intc);
 	if (!p->irqdomain) {
 		dev_err(p->dev, "failed to create Gemini PCI IRQ domain\n");
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index b0e3bce10aa4..60da24ba0a19 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1078,9 +1078,9 @@ static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
 		return -ENODEV;
 	}
 
-	port->intx_irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						      &mvebu_pcie_intx_irq_domain_ops,
-						      port);
+	port->intx_irq_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node),
+							 PCI_NUM_INTX,
+							 &mvebu_pcie_intx_irq_domain_ops, port);
 	of_node_put(pcie_intc_node);
 	if (!port->intx_irq_domain) {
 		dev_err(dev, "Failed to get INTx IRQ domain for %s\n", port->name);
diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 69a9c0a87639..d07e97e22d6d 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -242,8 +242,7 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 static int xgene_allocate_domains(struct xgene_msi *msi)
 {
-	msi->inner_domain = irq_domain_add_linear(NULL, NR_MSI_VEC,
-						  &msi_domain_ops, msi);
+	msi->inner_domain = irq_domain_create_linear(NULL, NR_MSI_VEC, &msi_domain_ops, msi);
 	if (!msi->inner_domain)
 		return -ENOMEM;
 
diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index 5fb3a2e0017e..a43f21eb8fbb 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -166,7 +166,7 @@ static int altera_allocate_domains(struct altera_msi *msi)
 {
 	struct fwnode_handle *fwnode = of_fwnode_handle(msi->pdev->dev.of_node);
 
-	msi->inner_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
+	msi->inner_domain = irq_domain_create_linear(NULL, msi->num_of_vectors,
 					     &msi_domain_ops, msi);
 	if (!msi->inner_domain) {
 		dev_err(&msi->pdev->dev, "failed to create IRQ domain\n");
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 70409e71a18f..0fc77176a52e 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -855,7 +855,7 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 	struct device_node *node = dev->of_node;
 
 	/* Setup INTx */
-	pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
+	pcie->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), PCI_NUM_INTX,
 					&intx_domain_ops, pcie);
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 1f356fca07a2..fbbbe9f2d171 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -584,7 +584,7 @@ static int brcm_allocate_domains(struct brcm_msi *msi)
 	struct fwnode_handle *fwnode = of_fwnode_handle(msi->np);
 	struct device *dev = msi->dev;
 
-	msi->inner_domain = irq_domain_add_linear(NULL, msi->nr, &msi_domain_ops, msi);
+	msi->inner_domain = irq_domain_create_linear(NULL, msi->nr, &msi_domain_ops, msi);
 	if (!msi->inner_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index 804b3a5787c5..d2cb4c4f821a 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -446,8 +446,8 @@ static void iproc_msi_disable(struct iproc_msi *msi)
 static int iproc_msi_alloc_domains(struct device_node *node,
 				   struct iproc_msi *msi)
 {
-	msi->inner_domain = irq_domain_add_linear(NULL, msi->nr_msi_vecs,
-						  &msi_domain_ops, msi);
+	msi->inner_domain = irq_domain_create_linear(NULL, msi->nr_msi_vecs,
+						     &msi_domain_ops, msi);
 	if (!msi->inner_domain)
 		return -ENOMEM;
 
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 9d52504acae4..b55f5973414c 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -745,8 +745,8 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 		return -ENODEV;
 	}
 
-	pcie->intx_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
-						  &intx_domain_ops, pcie);
+	pcie->intx_domain = irq_domain_create_linear(of_fwnode_handle(intc_node), PCI_NUM_INTX,
+						     &intx_domain_ops, pcie);
 	if (!pcie->intx_domain) {
 		dev_err(dev, "failed to create INTx IRQ domain\n");
 		ret = -ENODEV;
@@ -756,8 +756,9 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 	/* Setup MSI */
 	mutex_init(&pcie->lock);
 
-	pcie->msi_bottom_domain = irq_domain_add_linear(node, PCIE_MSI_IRQS_NUM,
-				  &mtk_msi_bottom_domain_ops, pcie);
+	pcie->msi_bottom_domain = irq_domain_create_linear(of_fwnode_handle(node),
+							   PCIE_MSI_IRQS_NUM,
+							   &mtk_msi_bottom_domain_ops, pcie);
 	if (!pcie->msi_bottom_domain) {
 		dev_err(dev, "failed to create MSI bottom domain\n");
 		ret = -ENODEV;
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index efcc4a7c17be..e1934aa06c8d 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -569,8 +569,8 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 		return -ENODEV;
 	}
 
-	port->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						 &intx_domain_ops, port);
+	port->irq_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), PCI_NUM_INTX,
+						    &intx_domain_ops, port);
 	of_node_put(pcie_intc_node);
 	if (!port->irq_domain) {
 		dev_err(dev, "failed to get INTx IRQ domain\n");
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 6a46be17aa91..b9e7a8710cf0 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -693,8 +693,8 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
 		return -EINVAL;
 	}
 
-	rockchip->irq_domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
-						    &intx_domain_ops, rockchip);
+	rockchip->irq_domain = irq_domain_create_linear(of_fwnode_handle(intc), PCI_NUM_INTX,
+							&intx_domain_ops, rockchip);
 	of_node_put(intc);
 	if (!rockchip->irq_domain) {
 		dev_err(dev, "failed to get a INTx IRQ domain\n");
diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index d0ab187d917f..879746e82c50 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -395,17 +395,15 @@ static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie *port)
 		return -EINVAL;
 	}
 
-	port->cpm_domain = irq_domain_add_linear(pcie_intc_node, 32,
-						 &event_domain_ops,
-						 port);
+	port->cpm_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), 32,
+						    &event_domain_ops, port);
 	if (!port->cpm_domain)
 		goto out;
 
 	irq_domain_update_bus_token(port->cpm_domain, DOMAIN_BUS_NEXUS);
 
-	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						  &intx_domain_ops,
-						  port);
+	port->intx_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), PCI_NUM_INTX,
+						     &intx_domain_ops, port);
 	if (!port->intx_domain)
 		goto out;
 
diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index 71cf13ae51c7..dc9690a535e1 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -472,8 +472,8 @@ static int xilinx_pl_dma_pcie_init_msi_irq_domain(struct pl_dma_pcie *port)
 	int size = BITS_TO_LONGS(XILINX_NUM_MSI_IRQS) * sizeof(long);
 	struct fwnode_handle *fwnode = of_fwnode_handle(port->dev->of_node);
 
-	msi->dev_domain = irq_domain_add_linear(NULL, XILINX_NUM_MSI_IRQS,
-						&dev_msi_domain_ops, port);
+	msi->dev_domain = irq_domain_create_linear(NULL, XILINX_NUM_MSI_IRQS,
+						   &dev_msi_domain_ops, port);
 	if (!msi->dev_domain)
 		goto out;
 
@@ -585,15 +585,15 @@ static int xilinx_pl_dma_pcie_init_irq_domain(struct pl_dma_pcie *port)
 		return -EINVAL;
 	}
 
-	port->pldma_domain = irq_domain_add_linear(pcie_intc_node, 32,
-						   &event_domain_ops, port);
+	port->pldma_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), 32,
+						      &event_domain_ops, port);
 	if (!port->pldma_domain)
 		return -ENOMEM;
 
 	irq_domain_update_bus_token(port->pldma_domain, DOMAIN_BUS_NEXUS);
 
-	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						  &intx_domain_ops, port);
+	port->intx_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), PCI_NUM_INTX,
+						     &intx_domain_ops, port);
 	if (!port->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 9cf8a96f7bc4..c8b05477b719 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -498,8 +498,7 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 	struct fwnode_handle *fwnode = of_fwnode_handle(dev->of_node);
 	struct nwl_msi *msi = &pcie->msi;
 
-	msi->dev_domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
-						&dev_msi_domain_ops, pcie);
+	msi->dev_domain = irq_domain_create_linear(NULL, INT_PCI_MSI_NR, &dev_msi_domain_ops, pcie);
 	if (!msi->dev_domain) {
 		dev_err(dev, "failed to create dev IRQ domain\n");
 		return -ENOMEM;
@@ -582,10 +581,8 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 		return -EINVAL;
 	}
 
-	pcie->intx_irq_domain = irq_domain_add_linear(intc_node,
-						      PCI_NUM_INTX,
-						      &intx_domain_ops,
-						      pcie);
+	pcie->intx_irq_domain = irq_domain_create_linear(of_fwnode_handle(intc_node), PCI_NUM_INTX,
+							 &intx_domain_ops, pcie);
 	of_node_put(intc_node);
 	if (!pcie->intx_irq_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 0b534f73a942..e36aa874bae9 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -461,9 +461,8 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie *pcie)
 		return -ENODEV;
 	}
 
-	pcie->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						 &intx_domain_ops,
-						 pcie);
+	pcie->leg_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), PCI_NUM_INTX,
+						    &intx_domain_ops, pcie);
 	of_node_put(pcie_intc_node);
 	if (!pcie->leg_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 4c7a9fa311e3..3abedf723215 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -155,8 +155,7 @@ static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
 
 	mutex_init(&port->msi.lock);
 
-	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_vectors,
-						&msi_domain_ops, port);
+	msi->dev_domain = irq_domain_create_linear(NULL, msi->num_vectors, &msi_domain_ops, port);
 	if (!msi->dev_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
@@ -393,10 +392,9 @@ static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 		return -EINVAL;
 	}
 
-	port->event_domain = irq_domain_add_linear(pcie_intc_node,
-						   port->num_events,
-						   &plda_event_domain_ops,
-						   port);
+	port->event_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node),
+						      port->num_events, &plda_event_domain_ops,
+						      port);
 	if (!port->event_domain) {
 		dev_err(dev, "failed to get event domain\n");
 		of_node_put(pcie_intc_node);
@@ -405,8 +403,8 @@ static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 
 	irq_domain_update_bus_token(port->event_domain, DOMAIN_BUS_NEXUS);
 
-	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						  &intx_domain_ops, port);
+	port->intx_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), PCI_NUM_INTX,
+						     &intx_domain_ops, port);
 	if (!port->intx_domain) {
 		dev_err(dev, "failed to get an INTx IRQ domain\n");
 		of_node_put(pcie_intc_node);
-- 
2.49.0


