Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6DA1C20D3
	for <lists+linux-pci@lfdr.de>; Sat,  2 May 2020 00:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgEAWlZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 18:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgEAWlZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 18:41:25 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C72E82166E;
        Fri,  1 May 2020 22:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588372884;
        bh=2Rzwabl4WPMkIvoQi8BMthTxuqjdUuAlNljzQi4IsIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZ4WAOsMCK42L2fdFojVCjplvhG+1DBwPv8WjUcUCq5ISB9tcW5zM7WootBn0VY5e
         UtnXJomgGyhiT9Ii+KBsfnLSk5qDNTqaqD/XvEHNcnBhBRfa+DS2l9dy9qGHHeJ2Sv
         XbzcRld6sB1x33vonyCoUSpM6/Xgbn2ReyGUlBSo=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Aman Sharma <amanharitsh123@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v2 2/2] PCI: Check for platform_get_irq() failure consistently
Date:   Fri,  1 May 2020 17:40:42 -0500
Message-Id: <20200501224042.141366-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200501224042.141366-1-helgaas@kernel.org>
References: <20200501224042.141366-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Aman Sharma <amanharitsh123@gmail.com>

The platform_get_irq*() interfaces return either a negative error number or
a valid IRQ.  0 is not a valid return value, so check for "< 0" to detect
failure as recommended by the function documentation.

On failure, return the error number from platform_get_irq*() instead of
making up a new one.

Link: https://lore.kernel.org/r/cover.1583952275.git.amanharitsh123@gmail.com
[bhelgaas: commit log, squash into one patch]
Signed-off-by: Aman Sharma <amanharitsh123@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/pci/controller/dwc/pci-imx6.c                | 4 ++--
 drivers/pci/controller/dwc/pcie-tegra194.c           | 4 ++--
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 4 ++--
 drivers/pci/controller/pci-aardvark.c                | 3 +++
 drivers/pci/controller/pci-v3-semi.c                 | 4 ++--
 drivers/pci/controller/pcie-mediatek.c               | 3 +++
 drivers/pci/controller/pcie-tango.c                  | 4 ++--
 7 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index acfbd34032a8..8f08ae53f53e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -868,9 +868,9 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
-		if (pp->msi_irq <= 0) {
+		if (pp->msi_irq < 0) {
 			dev_err(dev, "failed to get MSI irq\n");
-			return -ENODEV;
+			return pp->msi_irq;
 		}
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index ae30a2fd3716..f1f945cc7bcb 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2190,9 +2190,9 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	}
 
 	pp->irq = platform_get_irq_byname(pdev, "intr");
-	if (!pp->irq) {
+	if (pp->irq < 0) {
 		dev_err(dev, "Failed to get \"intr\" interrupt\n");
-		return -ENODEV;
+		return pp->irq;
 	}
 
 	pcie->bpmp = tegra_bpmp_get(dev);
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index a94be264240f..5907baa9b1f2 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -522,9 +522,9 @@ static int mobiveil_pcie_integrated_interrupt_init(struct mobiveil_pcie *pcie)
 	mobiveil_pcie_enable_msi(pcie);
 
 	rp->irq = platform_get_irq(pdev, 0);
-	if (rp->irq <= 0) {
+	if (rp->irq < 0) {
 		dev_err(dev, "failed to map IRQ: %d\n", rp->irq);
-		return -ENODEV;
+		return rp->irq;
 	}
 
 	/* initialize the IRQ domains */
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 2a20b649f40c..40a4257f0df1 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -973,6 +973,9 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->base);
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = devm_request_irq(dev, irq, advk_pcie_irq_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD, "advk-pcie",
 			       pcie);
diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index bd05221f5a22..a5bf945d2eda 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -777,9 +777,9 @@ static int v3_pci_probe(struct platform_device *pdev)
 
 	/* Get and request error IRQ resource */
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
+	if (irq < 0) {
 		dev_err(dev, "unable to obtain PCIv3 error IRQ\n");
-		return -ENODEV;
+		return irq;
 	}
 	ret = devm_request_irq(dev, irq, v3_irq, 0,
 			"PCIv3 error", v3);
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index cb982891b22b..ebfa7d5a4e2d 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -651,6 +651,9 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 	}
 
 	port->irq = platform_get_irq(pdev, port->slot);
+	if (port->irq < 0)
+		return port->irq;
+
 	irq_set_chained_handler_and_data(port->irq,
 					 mtk_pcie_intr_handler, port);
 
diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
index 21a208da3f59..18c2c4313eb5 100644
--- a/drivers/pci/controller/pcie-tango.c
+++ b/drivers/pci/controller/pcie-tango.c
@@ -273,9 +273,9 @@ static int tango_pcie_probe(struct platform_device *pdev)
 		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
 
 	virq = platform_get_irq(pdev, 1);
-	if (virq <= 0) {
+	if (virq < 0) {
 		dev_err(dev, "Failed to map IRQ\n");
-		return -ENXIO;
+		return virq;
 	}
 
 	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);
-- 
2.25.1

