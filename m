Return-Path: <linux-pci+bounces-98-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 168267F3DE2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB75CB21BB1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1CD15ADC;
	Wed, 22 Nov 2023 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCcpJPZa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967AF12B96
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0971CC43391;
	Wed, 22 Nov 2023 06:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633071;
	bh=eH/+BbUfsA/+s+RHJGPhOvhjXTJ6CiR/lnQQm5YBt6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UCcpJPZalDTIPJk1ZKcf5LA38UpyRUrEw9jwhIyNhhcPv39deDxZo5gWqCIVjDfdi
	 NRzmsTq6DFsTelplub+W2hVs0Vtz91re8GdbuxOgHZipXICnIR8Cc1ruoREXPERPFH
	 s31s+Z51CQR3/cQHRun4Y9UYB5Fdb+t+8trcdgmyPEdHNYTxcaXRuWjy2GNhpswKZv
	 fFWP58x61Q4rL+lCyggYS+fGiZwGewqojvejUqj72KE0T+UaPmYcDIVLcePPkPRgwA
	 ZA8cCYeJSXgQsuTHJzNpc8O78GI/Bf12ihSJGM7bAjm3i8JRcTfNNa0Vuce0iLspQx
	 3zPRP0Xfd6syA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 13/16] PCI: uniphier: Use INTX instead of legacy
Date: Wed, 22 Nov 2023 15:04:03 +0900
Message-ID: <20231122060406.14695-14-dlemoal@kernel.org>
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

In the Designware uniphier controller driver, including the endpoint
driver, change all names using "legacy" to use "intx", to match the
term used in the PCI specifications.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-uniphier-ep.c |  4 ++--
 drivers/pci/controller/dwc/pcie-uniphier.c    | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index d47236d5678d..a45f94b284a2 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -212,7 +212,7 @@ static void uniphier_pcie_ep_init(struct dw_pcie_ep *ep)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
-static int uniphier_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep)
+static int uniphier_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct uniphier_pcie_ep_priv *priv = to_uniphier_pcie(pci);
@@ -262,7 +262,7 @@ static int uniphier_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	switch (type) {
 	case PCI_IRQ_INTX:
-		return uniphier_pcie_ep_raise_legacy_irq(ep);
+		return uniphier_pcie_ep_raise_intx_irq(ep);
 	case PCI_IRQ_MSI:
 		return uniphier_pcie_ep_raise_msi_irq(ep, func_no,
 						      interrupt_num);
diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 48c3eba817b4..ff16b7345cfc 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -67,7 +67,7 @@ struct uniphier_pcie {
 	struct clk *clk;
 	struct reset_control *rst;
 	struct phy *phy;
-	struct irq_domain *legacy_irq_domain;
+	struct irq_domain *intx_irq_domain;
 };
 
 #define to_uniphier_pcie(x)	dev_get_drvdata((x)->dev)
@@ -253,12 +253,12 @@ static void uniphier_pcie_irq_handler(struct irq_desc *desc)
 	reg = FIELD_GET(PCL_RCV_INTX_ALL_STATUS, val);
 
 	for_each_set_bit(bit, &reg, PCI_NUM_INTX)
-		generic_handle_domain_irq(pcie->legacy_irq_domain, bit);
+		generic_handle_domain_irq(pcie->intx_irq_domain, bit);
 
 	chained_irq_exit(chip, desc);
 }
 
-static int uniphier_pcie_config_legacy_irq(struct dw_pcie_rp *pp)
+static int uniphier_pcie_config_intx_irq(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
@@ -279,9 +279,9 @@ static int uniphier_pcie_config_legacy_irq(struct dw_pcie_rp *pp)
 		goto out_put_node;
 	}
 
-	pcie->legacy_irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
+	pcie->intx_irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
 						&uniphier_intx_domain_ops, pp);
-	if (!pcie->legacy_irq_domain) {
+	if (!pcie->intx_irq_domain) {
 		dev_err(pci->dev, "Failed to get INTx domain\n");
 		ret = -ENODEV;
 		goto out_put_node;
@@ -301,7 +301,7 @@ static int uniphier_pcie_host_init(struct dw_pcie_rp *pp)
 	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
 	int ret;
 
-	ret = uniphier_pcie_config_legacy_irq(pp);
+	ret = uniphier_pcie_config_intx_irq(pp);
 	if (ret)
 		return ret;
 
-- 
2.42.0


