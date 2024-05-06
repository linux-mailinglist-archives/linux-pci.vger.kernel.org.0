Return-Path: <linux-pci+bounces-7130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DFA8BD255
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 18:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB391F24673
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 16:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C87D157483;
	Mon,  6 May 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nAc75tKK"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6E156653
	for <linux-pci@vger.kernel.org>; Mon,  6 May 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012141; cv=none; b=SHQyNnFh1OSGbgj1k6XvG6jXxs8u9dvh1SAkzPKY5+z4GREIpUDIcnDBw7+1ofWejntWyhNhAAWbJSZe2aHf8r5xVwOwT0P5EPutLGjhoyZqIoZpCSVIP1hGvF2u6uH3YtqWEB14jolfBxuUDiCpcws4FvOl/CR6FYokvRvScUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012141; c=relaxed/simple;
	bh=wMWeRjhSwJ6uSpmrW8+ckHY4I9c54ZmMIivHdPuG4Lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWhuFfI5UlbprFzETXx/UM7m5nXFurtodaGIXGdNn+KSI+EjiqDXDwV8TfiMuyqOUsHWtBRjn6Hy+UBwdzJ13l3AoH+aFHNlgUqwory5koERmWdJWcyDyfpL/OFM0ZgH3ksksNZrOe/NTVQnY6O4MslxDOYFmJJqfQE6z4eyTlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nAc75tKK; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715012138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6i/SJ7VatesNXmh/HC9q2B25IAsAKm2+03IxNVFUYGQ=;
	b=nAc75tKKd/wUpiy5BtEC8Nj/NNVFGHFTXCR9Mvpkjrm/3Xf2/r2KJXsSC+0mFGaXo5W9We
	yCQX1376TIrLaq8ljEFTP/bBlHny4KTBgKcMiQtF4ExfQ8iKDka1L0BVUQ0fjnXaHQY4LW
	12CexWMG0H50ZXw/q3EctaA0SU8bOtY=
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 6/7] PCI: xilinx-nwl: Add phy support
Date: Mon,  6 May 2024 12:15:09 -0400
Message-Id: <20240506161510.2841755-7-sean.anderson@linux.dev>
In-Reply-To: <20240506161510.2841755-1-sean.anderson@linux.dev>
References: <20240506161510.2841755-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add support for enabling/disabling PCIe phys. We can't really do
anything about failures in the disable/remove path, so just warn.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Get phys by index and not by name

 drivers/pci/controller/pcie-xilinx-nwl.c | 68 ++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 424cc5a1b4d1..d32cf4247836 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -19,6 +19,7 @@
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/irqchip/chained_irq.h>
 
@@ -157,6 +158,7 @@ struct nwl_pcie {
 	void __iomem *breg_base;
 	void __iomem *pcireg_base;
 	void __iomem *ecam_base;
+	struct phy *phy[4];
 	phys_addr_t phys_breg_base;	/* Physical Bridge Register Base */
 	phys_addr_t phys_pcie_reg_base;	/* Physical PCIe Controller Base */
 	phys_addr_t phys_ecam_base;	/* Physical Configuration Base */
@@ -521,6 +523,43 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 	return 0;
 }
 
+static int nwl_pcie_phy_enable(struct nwl_pcie *pcie)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(pcie->phy); i++) {
+		ret = phy_init(pcie->phy[i]);
+		if (ret)
+			goto err;
+
+		ret = phy_power_on(pcie->phy[i]);
+		if (ret) {
+			WARN_ON(phy_exit(pcie->phy[i]));
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	while (--i) {
+		WARN_ON(phy_power_off(pcie->phy[i]));
+		WARN_ON(phy_exit(pcie->phy[i]));
+	}
+
+	return ret;
+}
+
+static void nwl_pcie_phy_disable(struct nwl_pcie *pcie)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pcie->phy); i++) {
+		WARN_ON(phy_power_off(pcie->phy[i]));
+		WARN_ON(phy_exit(pcie->phy[i]));
+	}
+}
+
 static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -732,6 +771,7 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 {
 	struct device *dev = pcie->dev;
 	struct resource *res;
+	int i;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
 	pcie->breg_base = devm_ioremap_resource(dev, res);
@@ -759,6 +799,18 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 	irq_set_chained_handler_and_data(pcie->irq_intx,
 					 nwl_pcie_leg_handler, pcie);
 
+
+	for (i = 0; i < ARRAY_SIZE(pcie->phy); i++) {
+		pcie->phy[i] = devm_of_phy_get_by_index(dev, dev->of_node, i);
+		if (PTR_ERR(pcie->phy[i]) == -ENODEV) {
+			pcie->phy[i] = NULL;
+			break;
+		}
+
+		if (IS_ERR(pcie->phy[i]))
+			return PTR_ERR(pcie->phy[i]);
+	}
+
 	return 0;
 }
 
@@ -799,16 +851,22 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = nwl_pcie_phy_enable(pcie);
+	if (err) {
+		dev_err(dev, "could not enable PHYs\n");
+		goto err_clk;
+	}
+
 	err = nwl_pcie_bridge_init(pcie);
 	if (err) {
 		dev_err(dev, "HW Initialization failed\n");
-		goto err_clk;
+		goto err_phy;
 	}
 
 	err = nwl_pcie_init_irq_domain(pcie);
 	if (err) {
 		dev_err(dev, "Failed creating IRQ Domain\n");
-		goto err_clk;
+		goto err_phy;
 	}
 
 	bridge->sysdata = pcie;
@@ -818,12 +876,15 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		err = nwl_pcie_enable_msi(pcie);
 		if (err < 0) {
 			dev_err(dev, "failed to enable MSI support: %d\n", err);
-			goto err_clk;
+			goto err_phy;
 		}
 	}
 
 	err = pci_host_probe(bridge);
 
+err_phy:
+	if (err)
+		nwl_pcie_phy_disable(pcie);
 err_clk:
 	if (err)
 		clk_disable_unprepare(pcie->clk);
@@ -834,6 +895,7 @@ static void nwl_pcie_remove(struct platform_device *pdev)
 {
 	struct nwl_pcie *pcie = platform_get_drvdata(pdev);
 
+	nwl_pcie_phy_disable(pcie);
 	clk_disable_unprepare(pcie->clk);
 }
 
-- 
2.35.1.1320.gc452695387.dirty


