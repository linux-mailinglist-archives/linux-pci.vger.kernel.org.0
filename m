Return-Path: <linux-pci+bounces-8129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF458D6683
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 18:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617F91C21F4D
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6C517CA18;
	Fri, 31 May 2024 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rZ4p2XbX"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C717CA08
	for <linux-pci@vger.kernel.org>; Fri, 31 May 2024 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172044; cv=none; b=oqZ4nBoI5Mzybk7xTsIV86ei7YSbQ7KR7p46vIXfFs9EKM10ZcaHB9atWzvGvf2PcN7H2a9osFivHlhUIytOd1pFRbhgyOk1ojYRyrOdYiUlwb9UHsyNpvTi0QWaqCB4bibcDKKbmqAWGXj02KeNbEeZV93LXWrwPFAx7mwn/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172044; c=relaxed/simple;
	bh=2l9zp1lSuKaBEcfHbqQfVQR7MVZPRLOP1jCdbene7bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EIQExFkXrIsemOI1hx8l3zUQq+StqJm8z7OmDK7+g/q3QaoCKOEBEQiz73Nbj87p9CllvdbHq3rJl3YPeSLi1QT0SO/667T9CFuc2Gdx9BzDzfrZvH19GE+t4MsVjbbVDjDLQq8UEs67Q16/gk7wbF5bDUI649H/sYrLTsc3VYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rZ4p2XbX; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lpieralisi@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717172041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAKHPqA4epbor9JfZuDlNMJ6vBVPbm1X5M+Qr5HTDRA=;
	b=rZ4p2XbXpUpU9CqKxSLTexO18UPbiRw0/2Ft5Yz2sCbnPDOv2o5cV5/Dd2B6x8opTpeh5o
	YlutR0uSjQXo+i0uI+YBnBbJXlJ9ebUIxjXPnc8SMU7wSFNIgVaSs3F0y3udEFt5RMljJp
	QDmN1W8RO0Dl6Z2Oxz9K7ssEpi3K4zs=
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: markus.elfring@web.de
X-Envelope-To: dan.carpenter@linaro.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v4 6/7] PCI: xilinx-nwl: Add phy support
Date: Fri, 31 May 2024 12:13:36 -0400
Message-Id: <20240531161337.864994-7-sean.anderson@linux.dev>
In-Reply-To: <20240531161337.864994-1-sean.anderson@linux.dev>
References: <20240531161337.864994-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add support for enabling/disabling PCIe phys. We can't really do
anything about failures in the disable/remove path, so just print an
error.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v4:
- Remove if in err_phy
- Fix error path in phy_enable skipping the first phy
- Disable phys in reverse order
- Use dev_err instead of WARN for errors

Changes in v2:
- Get phys by index and not by name

 drivers/pci/controller/pcie-xilinx-nwl.c | 84 +++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index e85158dc4e6c..d17630357999 100644
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
@@ -521,6 +523,60 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 	return 0;
 }
 
+static void nwl_pcie_phy_power_off(struct nwl_pcie *pcie, int i)
+{
+	int err = phy_power_off(pcie->phy[i]);
+
+	if (err)
+		dev_err(pcie->dev, "could not power off phy %d (err=%d)\n", i,
+			err);
+}
+
+static void nwl_pcie_phy_exit(struct nwl_pcie *pcie, int i)
+{
+	int err = phy_exit(pcie->phy[i]);
+
+	if (err)
+		dev_err(pcie->dev, "could not exit phy %d (err=%d)\n", i, err);
+}
+
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
+			nwl_pcie_phy_exit(pcie, i);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	while (i--) {
+		nwl_pcie_phy_power_off(pcie, i);
+		nwl_pcie_phy_exit(pcie, i);
+	}
+
+	return ret;
+}
+
+static void nwl_pcie_phy_disable(struct nwl_pcie *pcie)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(pcie->phy); i--;) {
+		nwl_pcie_phy_power_off(pcie, i);
+		nwl_pcie_phy_exit(pcie, i);
+	}
+}
+
 static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -732,6 +788,7 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 {
 	struct device *dev = pcie->dev;
 	struct resource *res;
+	int i;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
 	pcie->breg_base = devm_ioremap_resource(dev, res);
@@ -759,6 +816,18 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
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
 
@@ -799,16 +868,22 @@ static int nwl_pcie_probe(struct platform_device *pdev)
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
@@ -818,7 +893,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		err = nwl_pcie_enable_msi(pcie);
 		if (err < 0) {
 			dev_err(dev, "failed to enable MSI support: %d\n", err);
-			goto err_clk;
+			goto err_phy;
 		}
 	}
 
@@ -826,6 +901,8 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	if (!err)
 		return 0;
 
+err_phy:
+	nwl_pcie_phy_disable(pcie);
 err_clk:
 	clk_disable_unprepare(pcie->clk);
 	return err;
@@ -835,6 +912,7 @@ static void nwl_pcie_remove(struct platform_device *pdev)
 {
 	struct nwl_pcie *pcie = platform_get_drvdata(pdev);
 
+	nwl_pcie_phy_disable(pcie);
 	clk_disable_unprepare(pcie->clk);
 }
 
-- 
2.35.1.1320.gc452695387.dirty


