Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454B245FF21
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245464AbhK0OTz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343515AbhK0ORy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CE5C0613F9
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:48 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c4so25146745wrd.9
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W1ucDj9vJAFoVvso9iUaodUIPODzZVXYrphoOb8WCVM=;
        b=ZLSoIpXw4N3OumU1Kq6UX6xp0lU7xYtBYtzzAXLlIXggkCuqy0sVz5DhodmrVofh86
         qMGm0eVY+gFjZm4txnlLcmKJw082SeqOk8C8r2xwvZW0NovlgdyqpDzaVgz0POuJR4DR
         zFtNacAutj2d1WwMT4FClu+8TTfWoBvCceeh/RFGO2cNejdhBMznCbK82BsI3kuXpg8R
         7rM6bLvT06OAhIxXQwyKMKAJVigJtu6ZI0b54TtWpZ7p0KXtYoLtNhlBJ+UkoIAkf1b1
         6xAxq98jFuUXOKmWXrYUH2LQIyoWs14P7zjZ3CemTASrUE5LOU4aDW6M3n4/FU/efXmS
         lAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1ucDj9vJAFoVvso9iUaodUIPODzZVXYrphoOb8WCVM=;
        b=yMG/3c3GJG5UHr3bna+a9iIP+ApNyliWnmD1SOHD92ZtDIf2CaeIdjWj4fZuMCp6KU
         a/RUXYYvu6kE5cX41g+7i4AUjwPtMu2I3hi8C2CfmitCA1yqC5ByM/XoyaiZbqdhhdxR
         HWpiupxm4nuLcNWsoOlYXKGKRJ6Bx3CGzYrw+8IV/5JETku5p3ouWesVi5Rk3aXXat+5
         QULvA9yKzJezODqY13eAQMk0Zs1nrLHMelN7fRCD6ZBatNWHGgMC8roLfp3e1rxxC65U
         JOeLodvjQ+W3jIMQjc+4/ysKd+ewqotTN2eF+N2MRUecuNwsgmYjv7ySED36z2XJJAQ1
         HDaQ==
X-Gm-Message-State: AOAM531h1de1ygksnMkLmSLfz1Zw4nP78wYGgeqsZg3pLJYUUrjoHWdY
        fDdATv4llpTNXDrh5zPwyzdz1wIuqu/q/Q==
X-Google-Smtp-Source: ABdhPJxfpKdDx+ZQQUwFaTDpk2dmpJ9xfWw1bt/hUu7o3rWAWdVzzK/jOXOdRR54NRxGCv9Aqp/L4Q==
X-Received: by 2002:a5d:5504:: with SMTP id b4mr20893188wrv.307.1638022307352;
        Sat, 27 Nov 2021 06:11:47 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:47 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 13/13] PCI: rcar: Replace device * with platform_device *
Date:   Sat, 27 Nov 2021 15:11:21 +0100
Message-Id: <7b7de38c0b3eb0b497f3eed2a3a62739b351d1e7.1638022050.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638022048.git.ffclaire1224@gmail.com>
References: <cover.1638022048.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCI controller struct contain "device *", while others contain
"platform_device *". Unify "device *dev" to "platform_device *pdev" in
struct rcar_pcie, because PCI controllers interact with platform_device
directly, not device, to enumerate the controlled device. Modify rcar host
and endpoint file in this patch, because both struct include member
rcar_pcie.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pcie-rcar-ep.c   | 40 ++++++++++++++-----------
 drivers/pci/controller/pcie-rcar-host.c | 27 +++++++++--------
 drivers/pci/controller/pcie-rcar.h      |  2 +-
 3 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index f9682df1da61..1a471220f560 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -87,10 +87,11 @@ static int rcar_pcie_ep_get_window(struct rcar_pcie_endpoint *ep,
 	return -EINVAL;
 }
 
-static int rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep,
-					   struct platform_device *pdev)
+static int rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep)
 {
 	struct rcar_pcie *pcie = &ep->pcie;
+	struct platform_device *pdev = pcie->pdev;
+	struct device *dev = &pdev->dev;
 	char outbound_name[10];
 	struct resource *res;
 	unsigned int i = 0;
@@ -102,13 +103,13 @@ static int rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep,
 						   IORESOURCE_MEM,
 						   outbound_name);
 		if (!res) {
-			dev_err(pcie->dev, "missing outbound window %u\n", i);
+			dev_err(dev, "missing outbound window %u\n", i);
 			return -EINVAL;
 		}
-		if (!devm_request_mem_region(&pdev->dev, res->start,
+		if (!devm_request_mem_region(dev, res->start,
 					     resource_size(res),
 					     outbound_name)) {
-			dev_err(pcie->dev, "Cannot request memory region %s.\n",
+			dev_err(dev, "Cannot request memory region %s.\n",
 				outbound_name);
 			return -EIO;
 		}
@@ -125,12 +126,12 @@ static int rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep,
 	return 0;
 }
 
-static int rcar_pcie_ep_get_pdata(struct rcar_pcie_endpoint *ep,
-				  struct platform_device *pdev)
+static int rcar_pcie_ep_get_pdata(struct rcar_pcie_endpoint *ep)
 {
 	struct rcar_pcie *pcie = &ep->pcie;
 	struct pci_epc_mem_window *window;
-	struct device *dev = pcie->dev;
+	struct platform_device *pdev = pcie->pdev;
+	struct device *dev = &pdev->dev;
 	struct resource res;
 	int err;
 
@@ -146,7 +147,7 @@ static int rcar_pcie_ep_get_pdata(struct rcar_pcie_endpoint *ep,
 	if (!ep->ob_window)
 		return -ENOMEM;
 
-	rcar_pcie_parse_outbound_ranges(ep, pdev);
+	rcar_pcie_parse_outbound_ranges(ep);
 
 	err = of_property_read_u8(dev->of_node, "max-functions",
 				  &ep->max_functions);
@@ -201,13 +202,14 @@ static int rcar_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	dma_addr_t cpu_addr = epf_bar->phys_addr;
 	enum pci_barno bar = epf_bar->barno;
 	struct rcar_pcie *pcie = &ep->pcie;
+	struct device *dev = &pcie->pdev->dev;
 	u32 mask;
 	int idx;
 	int err;
 
 	idx = find_first_zero_bit(ep->ib_window_map, ep->num_ib_windows);
 	if (idx >= ep->num_ib_windows) {
-		dev_err(pcie->dev, "no free inbound window\n");
+		dev_err(dev, "no free inbound window\n");
 		return -EINVAL;
 	}
 
@@ -236,7 +238,7 @@ static int rcar_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	err = rcar_pcie_wait_for_phyrdy(pcie);
 	if (err) {
-		dev_err(pcie->dev, "phy not ready\n");
+		dev_err(dev, "phy not ready\n");
 		return -EINVAL;
 	}
 
@@ -288,6 +290,7 @@ static int rcar_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 {
 	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
 	struct rcar_pcie *pcie = &ep->pcie;
+	struct device *dev = &pcie->pdev->dev;
 	struct resource_entry win;
 	struct resource res;
 	int window;
@@ -296,13 +299,13 @@ static int rcar_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 	/* check if we have a link. */
 	err = rcar_pcie_wait_for_dl(pcie);
 	if (err) {
-		dev_err(pcie->dev, "link not up\n");
+		dev_err(dev, "link not up\n");
 		return err;
 	}
 
 	window = rcar_pcie_ep_get_window(ep, addr);
 	if (window < 0) {
-		dev_err(pcie->dev, "failed to get corresponding window\n");
+		dev_err(dev, "failed to get corresponding window\n");
 		return -EINVAL;
 	}
 
@@ -347,23 +350,24 @@ static int rcar_pcie_ep_assert_intx(struct rcar_pcie_endpoint *ep,
 				    u8 fn, u8 intx)
 {
 	struct rcar_pcie *pcie = &ep->pcie;
+	struct device *dev = &pcie->pdev->dev;
 	u32 val;
 
 	val = rcar_pci_read_reg(pcie, PCIEMSITXR);
 	if ((val & PCI_MSI_FLAGS_ENABLE)) {
-		dev_err(pcie->dev, "MSI is enabled, cannot assert INTx\n");
+		dev_err(dev, "MSI is enabled, cannot assert INTx\n");
 		return -EINVAL;
 	}
 
 	val = rcar_pci_read_reg(pcie, PCICONF(1));
 	if ((val & INTDIS)) {
-		dev_err(pcie->dev, "INTx message transmission is disabled\n");
+		dev_err(dev, "INTx message transmission is disabled\n");
 		return -EINVAL;
 	}
 
 	val = rcar_pci_read_reg(pcie, PCIEINTXR);
 	if ((val & ASTINTX)) {
-		dev_err(pcie->dev, "INTx is already asserted\n");
+		dev_err(dev, "INTx is already asserted\n");
 		return -EINVAL;
 	}
 
@@ -487,7 +491,7 @@ static int rcar_pcie_ep_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pcie = &ep->pcie;
-	pcie->dev = dev;
+	pcie->pdev = pdev;
 
 	pm_runtime_enable(dev);
 	err = pm_runtime_resume_and_get(dev);
@@ -496,7 +500,7 @@ static int rcar_pcie_ep_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
-	err = rcar_pcie_ep_get_pdata(ep, pdev);
+	err = rcar_pcie_ep_get_pdata(ep);
 	if (err < 0) {
 		dev_err(dev, "failed to request resources: %d\n", err);
 		goto err_pm_put;
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index e12c2d8be05a..4984e4d0078d 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -216,7 +216,7 @@ static struct pci_ops rcar_pcie_ops = {
 
 static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	unsigned int timeout = 1000;
 	u32 macsr;
 
@@ -312,7 +312,7 @@ static int rcar_pcie_enable(struct rcar_pcie_host *host)
 
 static int phy_wait_for_ack(struct rcar_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	unsigned int timeout = 100;
 
 	while (timeout--) {
@@ -490,7 +490,7 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 	struct rcar_pcie_host *host = data;
 	struct rcar_pcie *pcie = &host->pcie;
 	struct rcar_msi *msi = &host->msi;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	unsigned long reg;
 
 	reg = rcar_pci_read_reg(pcie, PCIEMSIFR);
@@ -653,20 +653,21 @@ static struct msi_domain_info rcar_msi_info = {
 static int rcar_allocate_domains(struct rcar_msi *msi)
 {
 	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
-	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
+	struct device *dev = &pcie->pdev->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct irq_domain *parent;
 
 	parent = irq_domain_create_linear(fwnode, INT_PCI_MSI_NR,
 					  &rcar_msi_domain_ops, msi);
 	if (!parent) {
-		dev_err(pcie->dev, "failed to create IRQ domain\n");
+		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
 	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
 
 	msi->domain = pci_msi_create_irq_domain(fwnode, &rcar_msi_info, parent);
 	if (!msi->domain) {
-		dev_err(pcie->dev, "failed to create MSI domain\n");
+		dev_err(dev, "failed to create MSI domain\n");
 		irq_domain_remove(parent);
 		return -ENOMEM;
 	}
@@ -685,7 +686,7 @@ static void rcar_free_domains(struct rcar_msi *msi)
 static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 {
 	struct rcar_pcie *pcie = &host->pcie;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct rcar_msi *msi = &host->msi;
 	struct resource res;
 	int err;
@@ -751,7 +752,7 @@ static void rcar_pcie_teardown_msi(struct rcar_pcie_host *host)
 static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
 {
 	struct rcar_pcie *pcie = &host->pcie;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct resource res;
 	int err, i;
 
@@ -821,7 +822,7 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 
 	while (cpu_addr < cpu_end) {
 		if (idx >= MAX_NR_INBOUND_MAPS - 1) {
-			dev_err(pcie->dev, "Failed to map inbound regions!\n");
+			dev_err(&pcie->pdev->dev, "Failed to map inbound regions!\n");
 			return -EINVAL;
 		}
 		/*
@@ -899,13 +900,13 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 	host = pci_host_bridge_priv(bridge);
 	pcie = &host->pcie;
-	pcie->dev = dev;
+	pcie->pdev = pdev;
 	platform_set_drvdata(pdev, host);
 
-	pm_runtime_enable(pcie->dev);
-	err = pm_runtime_get_sync(pcie->dev);
+	pm_runtime_enable(dev);
+	err = pm_runtime_get_sync(dev);
 	if (err < 0) {
-		dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
+		dev_err(dev, "pm_runtime_get_sync failed\n");
 		goto err_pm_put;
 	}
 
diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
index 9bb125db85c6..1f33ceb51b83 100644
--- a/drivers/pci/controller/pcie-rcar.h
+++ b/drivers/pci/controller/pcie-rcar.h
@@ -125,7 +125,7 @@
 #define MAX_NR_INBOUND_MAPS	6
 
 struct rcar_pcie {
-	struct device		*dev;
+	struct platform_device		*pdev;
 	void __iomem		*base;
 };
 
-- 
2.25.1

