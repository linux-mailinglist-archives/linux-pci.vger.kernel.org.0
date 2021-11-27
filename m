Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8162245FF17
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbhK0OT1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355256AbhK0OR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:27 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943BDC0613DD
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 133so10513099wme.0
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LmWjHjdGbQoIJfyKhc/exaHghcRqYp973teYZWWGz8M=;
        b=XflV2PrRsGZW06woAOgpKprsZHn/64NG+PmhffRkptVWjQV/qYz+bMOUxVBEBPCDWU
         7FToM+kbDiA0oG0IjGjp5ojZL3j1+5v7JhvqOV3FETlUIUV7NRIoLIvtUqocj9J1Lpw2
         Dy59Kg7rj7fR6gNMDrOe/1y9KoJRxbJZtClJYXmHw/wF071EEGPkf8S5J4e+/RZstdXT
         7GJDErzS/xUcYfebfFgSL526KWOUGoZdDz2YVNfBP+fMRLFB+lOYzUVn0wGj5c18za0S
         ysg+B+SLqzVWLnvv73KZh35nnclkne2/DgsNCGA19ov20YxRs5X/49sNxxjh4MF5ix6A
         vMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LmWjHjdGbQoIJfyKhc/exaHghcRqYp973teYZWWGz8M=;
        b=oDKxR2VdJ5YItjSQlSfquEhWPK492qnG6b2KTo+Hx0OZ5Xhl6779erojSU6nUlCmZg
         oIyB6J1y7zYan5IVvXzYoSDzrwD0ojfnDeQPYMjcjOvaDp1CYu9A5UI1v79M/mWoQmqC
         ox2SVsKrLA3dCBR9A5To5aXsfgBeTOlfjU9TlSdqmvA/lPGQG+2jCfG4xiDyrXHitgxb
         iBo6Cebd/ymA+qSKV+Wv/AGSh3eXlla5T8UfmBal7elrbTt3VZeYlac7x265mFnfSOO3
         fcPAZMUASG1QHciKkfJCIBt48PwSarK7RAxFeNwMXHsjHyly3GFXEQ9pFTgcDlzUzFCA
         DXYA==
X-Gm-Message-State: AOAM531K5K9HA3z2u2ejGW1wdlYwx1rdPfS+/u6lQn7E2AzXSI2UFYZt
        VmdgcBai81RxSMeVSaHHPQ3IpPXE969kcQ==
X-Google-Smtp-Source: ABdhPJyslNT+I+sJlkbEkCguIK7n7Vwea0YGiB9RpRvyv9lVWnQXa8gSwBiHYA4DaeK7Aq3hhF4lPg==
X-Received: by 2002:a1c:9d48:: with SMTP id g69mr23642406wme.188.1638022289115;
        Sat, 27 Nov 2021 06:11:29 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:28 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 02/13] PCI: mediatek: Replace device * with platform_device *
Date:   Sat, 27 Nov 2021 15:11:10 +0100
Message-Id: <30848bb62fc3854bf5d800fba51bb60f8897dc79.1638022049.git.ffclaire1224@gmail.com>
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
struct mediatek_pcie, because PCI controllers interact with platform_device
directly, not device, to enumerate the controlled device.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 31 +++++++++++++-------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 2f3f974977a3..9e49d3ee9cff 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -216,7 +216,7 @@ struct mtk_pcie_port {
  * @soc: pointer to SoC-dependent operations
  */
 struct mtk_pcie {
-	struct device *dev;
+	struct platform_device *pdev;
 	void __iomem *base;
 	struct regmap *cfg;
 	struct clk *free_ck;
@@ -227,7 +227,7 @@ struct mtk_pcie {
 
 static void mtk_pcie_subsys_powerdown(struct mtk_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 
 	clk_disable_unprepare(pcie->free_ck);
 
@@ -238,7 +238,7 @@ static void mtk_pcie_subsys_powerdown(struct mtk_pcie *pcie)
 static void mtk_pcie_port_free(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 
 	devm_iounmap(dev, port->base);
 	list_del(&port->list);
@@ -410,7 +410,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 	msg->data = data->hwirq;
 
-	dev_dbg(port->pcie->dev, "msi#%d address_hi %#x address_lo %#x\n",
+	dev_dbg(&port->pcie->pdev->dev, "msi#%d address_hi %#x address_lo %#x\n",
 		(int)data->hwirq, msg->address_hi, msg->address_lo);
 }
 
@@ -470,7 +470,7 @@ static void mtk_pcie_irq_domain_free(struct irq_domain *domain,
 	mutex_lock(&port->lock);
 
 	if (!test_bit(d->hwirq, port->msi_irq_in_use))
-		dev_err(port->pcie->dev, "trying to free unused MSI#%lu\n",
+		dev_err(&port->pcie->pdev->dev, "trying to free unused MSI#%lu\n",
 			d->hwirq);
 	else
 		__clear_bit(d->hwirq, port->msi_irq_in_use);
@@ -500,21 +500,22 @@ static struct msi_domain_info mtk_msi_domain_info = {
 
 static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 {
-	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
+	struct device *dev = &port->pcie->pdev->dev;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
 
 	mutex_init(&port->lock);
 
 	port->inner_domain = irq_domain_create_linear(fwnode, MTK_MSI_IRQS_NUM,
 						      &msi_domain_ops, port);
 	if (!port->inner_domain) {
-		dev_err(port->pcie->dev, "failed to create IRQ domain\n");
+		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
 
 	port->msi_domain = pci_msi_create_irq_domain(fwnode, &mtk_msi_domain_info,
 						     port->inner_domain);
 	if (!port->msi_domain) {
-		dev_err(port->pcie->dev, "failed to create MSI domain\n");
+		dev_err(dev, "failed to create MSI domain\n");
 		irq_domain_remove(port->inner_domain);
 		return -ENOMEM;
 	}
@@ -573,7 +574,7 @@ static const struct irq_domain_ops intx_domain_ops = {
 static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 				    struct device_node *node)
 {
-	struct device *dev = port->pcie->dev;
+	struct device *dev = &port->pcie->pdev->dev;
 	struct device_node *pcie_intc_node;
 	int ret;
 
@@ -640,7 +641,7 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 			      struct device_node *node)
 {
 	struct mtk_pcie *pcie = port->pcie;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	int err;
 
@@ -830,7 +831,7 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	int err;
 
 	err = clk_prepare_enable(port->sys_ck);
@@ -913,7 +914,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 			       int slot)
 {
 	struct mtk_pcie_port *port;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	char name[10];
 	int err;
@@ -990,7 +991,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 
 static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *regs;
 	struct device_node *cfg_node;
@@ -1041,7 +1042,7 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 
 static int mtk_pcie_setup(struct mtk_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct device_node *node = dev->of_node, *child;
 	struct mtk_pcie_port *port, *tmp;
 	int err, slot;
@@ -1098,7 +1099,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 
 	pcie = pci_host_bridge_priv(host);
 
-	pcie->dev = dev;
+	pcie->pdev = pdev;
 	pcie->soc = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, pcie);
 	INIT_LIST_HEAD(&pcie->ports);
-- 
2.25.1

