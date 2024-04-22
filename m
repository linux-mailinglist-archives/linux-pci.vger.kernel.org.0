Return-Path: <linux-pci+bounces-6537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F3A8AD56D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 22:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F3FB2422F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 20:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11417153BCC;
	Mon, 22 Apr 2024 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pSBfgAL1"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4E15666B
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815967; cv=none; b=hvxYGcU/Fp4IZZZYI03/b5XkqPfgrzJDyO9BMsij0rtdI7JR6UPtVvf1as4dujd/EC/y0yoCox5TvdD3AZzI5HtW3GdJLvs+2sS9+3XN/G8m1Y0jvBNxzA1NKuTxtNc59cHFWRMbhldny1WLI31GJvx2Uhidxb+CQ6vZ2TiC1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815967; c=relaxed/simple;
	bh=bKIRdcv+IsQ1KdaKP2rdYU5S61mJTyYBq22uBE/yjnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SM0H7MGdTZjUxfnt/h8PbcVp5SCdupiPRScdDMDVxe0xzAQhvfeFFTFfARQHGzx++6ANtsEiogdFLHFtsv6a5ofOOKkrg64t+c+3KQhVIeq5FcEFxUYuSBfKEiXHnMAwyNrgQTmEjRtqG3ayRW8/JoLzrLm5xIwnpqwFGoVpbO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pSBfgAL1; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713815963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztQEUQ1VXVN/3kCcl2i+7uwX3vjmlv6H5lsYtuFHU80=;
	b=pSBfgAL127YmQuamNHkZgu6BDxmwJA8i/SI74qw8qczqUNhRfh6G+lQ2cRcZbQxaOFwPiD
	qJtXG8VTT0+2Po5SddgGQ+ljgrnKEmcYBCXFcX4ZqXx5BZx7KGhKDiNYRoIOMnyvKviuiu
	7LpggJ864j7Gz0KmV/7omj+9wKMwgRE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 6/7] PCI: xilinx-nwl: Add phy support
Date: Mon, 22 Apr 2024 15:59:03 -0400
Message-Id: <20240422195904.3591683-7-sean.anderson@linux.dev>
In-Reply-To: <20240422195904.3591683-1-sean.anderson@linux.dev>
References: <20240422195904.3591683-1-sean.anderson@linux.dev>
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

 drivers/pci/controller/pcie-xilinx-nwl.c | 70 +++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 424cc5a1b4d1..19a0ff105401 100644
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
@@ -759,6 +799,20 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 	irq_set_chained_handler_and_data(pcie->irq_intx,
 					 nwl_pcie_leg_handler, pcie);
 
+	for (i = 0; i < ARRAY_SIZE(pcie->phy); i++) {
+		char name[16];
+
+		snprintf(name, sizeof(name), "pcie-phy%d", i);
+		pcie->phy[i] = devm_phy_get(dev, name);
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
 
@@ -799,16 +853,22 @@ static int nwl_pcie_probe(struct platform_device *pdev)
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
@@ -818,12 +878,15 @@ static int nwl_pcie_probe(struct platform_device *pdev)
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
@@ -834,6 +897,7 @@ static void nwl_pcie_remove(struct platform_device *pdev)
 {
 	struct nwl_pcie *pcie = platform_get_drvdata(pdev);
 
+	nwl_pcie_phy_disable(pcie);
 	clk_disable_unprepare(pcie->clk);
 }
 
-- 
2.35.1.1320.gc452695387.dirty


