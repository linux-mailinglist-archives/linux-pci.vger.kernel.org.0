Return-Path: <linux-pci+bounces-23862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81ACA63267
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6517A3AD7BC
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 20:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DDF205E31;
	Sat, 15 Mar 2025 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+vyVat5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD7205E1A;
	Sat, 15 Mar 2025 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742069770; cv=none; b=hC0lcN6USFPvGXKvW1w1nDW0ZVdGua+qeTKG3Ldcp8/gVCQAdIWbZzt4pvEPC5ynAILMlXYB9AIhzD8gY9rnEQLEtIQPflpcv9yAwmdi2TotS9dExONasYIzXVmdpOHPK/VLmnFAdrWX0UE4pQk/EGYtGSW4FtW1J0w9vmYKS6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742069770; c=relaxed/simple;
	bh=sQygIqg4qV1xiOq77OkyiaeYdUXtZIaj/l0SEvW8lvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P33UMkxedGvzNsQKjbslKkFLRiC0XJlyZlY1h2JYRtzLn0ZXu5/NWnCMF18OMSq5Ml7I2mTaMtpUVUBrk3vSnIlwaIPRfsvDc0F09KjwcdhI9dNJC1inVX+3bnslbuf1ICJx5QyNTRxOaW/Ohhr7s/03uxw/bPIb1XfIHpaor8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+vyVat5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E483C4CEE5;
	Sat, 15 Mar 2025 20:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742069769;
	bh=sQygIqg4qV1xiOq77OkyiaeYdUXtZIaj/l0SEvW8lvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+vyVat5vCFT2D2kEQKSYPAfHjHV7WTithLM+T1omrIWQ1pilyFBvPCnGWOp2UZg/
	 1bP8D+/r1sWmQb506r03Kd40Sicgb9OO6d/dCG5w+M6T3eo2c4gaplnJilaX7c2+nO
	 Td5sy18tq/1LzPtwjCHXRjZc4umPwyb3wb/gUBYCYZ6Oi86n0aYfTBlW/b+Gudx/qd
	 S2SlN8cAr8VXFJimIo3qY3dXN59gRjtAGnrllrO/3S2AZ0bbwie1ME7+23ZR94LV1u
	 BLThqb8pQI2BZWH0SmiwrFv1f6zXp5vKdUKP0Hpazo3AUYSqpLVVEJTV6PvWsCJ82P
	 npUUwgjIJmyzA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 09/13] PCI: dwc: ep: Consolidate devicetree handling in dw_pcie_ep_get_resources()
Date: Sat, 15 Mar 2025 15:15:44 -0500
Message-Id: <20250315201548.858189-10-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250315201548.858189-1-helgaas@kernel.org>
References: <20250315201548.858189-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Consolidate devicetree resource handling in dw_pcie_ep_get_resources().
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 68 +++++++++++--------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 100d26466f05..2db834345ec2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -883,35 +883,15 @@ void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_linkdown);
 
-/**
- * dw_pcie_ep_init - Initialize the endpoint device
- * @ep: DWC EP device
- *
- * Initialize the endpoint device. Allocate resources and create the EPC
- * device with the endpoint framework.
- *
- * Return: 0 if success, errno otherwise.
- */
-int dw_pcie_ep_init(struct dw_pcie_ep *ep)
+static int dw_pcie_ep_get_resources(struct dw_pcie_ep *ep)
 {
-	int ret;
-	struct resource *res;
-	struct pci_epc *epc;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
-
-	INIT_LIST_HEAD(&ep->func_list);
-
-	epc = devm_pci_epc_create(dev, &epc_ops);
-	if (IS_ERR(epc)) {
-		dev_err(dev, "Failed to create epc device\n");
-		return PTR_ERR(epc);
-	}
-
-	ep->epc = epc;
-	epc_set_drvdata(epc, ep);
+	struct pci_epc *epc = ep->epc;
+	struct resource *res;
+	int ret;
 
 	ret = dw_pcie_get_resources(pci);
 	if (ret)
@@ -924,13 +904,47 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
-	if (ep->ops->pre_init)
-		ep->ops->pre_init(ep);
-
 	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
 	if (ret < 0)
 		epc->max_functions = 1;
 
+	return 0;
+}
+
+/**
+ * dw_pcie_ep_init - Initialize the endpoint device
+ * @ep: DWC EP device
+ *
+ * Initialize the endpoint device. Allocate resources and create the EPC
+ * device with the endpoint framework.
+ *
+ * Return: 0 if success, errno otherwise.
+ */
+int dw_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	int ret;
+	struct pci_epc *epc;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct device *dev = pci->dev;
+
+	INIT_LIST_HEAD(&ep->func_list);
+
+	epc = devm_pci_epc_create(dev, &epc_ops);
+	if (IS_ERR(epc)) {
+		dev_err(dev, "Failed to create epc device\n");
+		return PTR_ERR(epc);
+	}
+
+	ep->epc = epc;
+	epc_set_drvdata(epc, ep);
+
+	ret = dw_pcie_ep_get_resources(ep);
+	if (ret)
+		return ret;
+
+	if (ep->ops->pre_init)
+		ep->ops->pre_init(ep);
+
 	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
 			       ep->page_size);
 	if (ret < 0) {
-- 
2.34.1


