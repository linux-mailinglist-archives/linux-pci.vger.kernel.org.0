Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32645FF16
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbhK0OT1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355255AbhK0OR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAA2C0613D7
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:28 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q3so2334140wru.5
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DU0NAGk/HARgZbacO/zBQEe/KDrwhSU3OnAthCrWpLo=;
        b=IO72eua2LtzV2gYO9JeclUgkQ1b6tcLbTRthI2maRBR9UjvnPrWs/+0h9F72YEmhIL
         OC4Wv3AlAqMC17QFNHhypybv/2mslEFi0FDoquxI1EbO5jx1RXh1HssO6veQLjPTREay
         a09iC48sta2AXJ6JDABvSek2vLLQn7XP2SeV94Z3J4M7W9rV9X4IPfdxjlGHSx4mYSZb
         r+KHGwvlvTRjVIGUOX6mof17qmtnkgrkt7G5d3Xw5zSp2ddHTQAbjjU9z8Li9zCE6AoI
         Qtg+NhvSmGsWHJwVboWQXFwMjKYqhLivoX8kxnT6UzspwGrvjLe4Pb18ebqF+duCuweh
         2DVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DU0NAGk/HARgZbacO/zBQEe/KDrwhSU3OnAthCrWpLo=;
        b=adBFVjhUvyqkMdik8e68qh/pn0KjutFpxbHfb3HLflIFyBytO/KpnAHKGwVHx4oeMl
         ZtQ53wwYGXDYRbVUyIZ9bSNeDPXxKkDJAIjEPofUBrEj1fhavHrUXqPKjdYfo+GeQIaf
         6LTRXexAx0Ed9rp4XlgHr0LHA9N/fKfykw/9qTUMYEPvtSfkAeqbeUdeLLJVA4LciKxN
         VBBlwiNWYG4+/RdEjTYKR+KvHLXl8k3lHT5w7CG8hVh/Hz/4G8QBeSZKcc1xldg9EjDF
         OyI2CbLle7PL1hxSLivTjTKmSS/9liKmURke0e6MHIGFvpqTxKhsJH+cMseCZfmEOzaA
         SCjw==
X-Gm-Message-State: AOAM533+trJogWU//5zUVNuK+7RxwEQuVO8CLUXAi1kKf21Slgk9g4Df
        J0NUUeAYS33RCxq7OWfZG9U=
X-Google-Smtp-Source: ABdhPJzUP45ypnoWx3yzVVmcfkNkzrrvxWaN8QwVzgYyvefbVTR2u3KC3o5Z7D4kyesbtuol7aIt1Q==
X-Received: by 2002:a05:6000:1681:: with SMTP id y1mr20965337wrd.52.1638022287369;
        Sat, 27 Nov 2021 06:11:27 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:27 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 01/13] PCI: xilinx: Replace device * with platform_device *
Date:   Sat, 27 Nov 2021 15:11:09 +0100
Message-Id: <d9b8c6e01647d7832a5ed424a8781b75f9e87228.1638022049.git.ffclaire1224@gmail.com>
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
"struct xilinx_pcie", because PCI controllers interact with platform_device
directly, not device, to enumerate the controlled device.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pcie-xilinx.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 1e7928d81a05..9137e440b4d3 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -101,8 +101,8 @@
  * @resources: Bus Resources
  */
 struct xilinx_pcie {
+	struct platform_device *pdev;
 	void __iomem *reg_base;
-	struct device *dev;
 	unsigned long msi_map[BITS_TO_LONGS(XILINX_NUM_MSI_IRQS)];
 	struct mutex map_lock;
 	struct irq_domain *msi_domain;
@@ -132,7 +132,7 @@ static inline bool xilinx_pcie_link_up(struct xilinx_pcie *pcie)
  */
 static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	unsigned long val = pcie_read(pcie, XILINX_PCIE_REG_RPEFR);
 
 	if (val & XILINX_PCIE_RPEFR_ERR_VALID) {
@@ -277,20 +277,21 @@ static struct msi_domain_info xilinx_msi_info = {
 
 static int xilinx_allocate_msi_domains(struct xilinx_pcie *pcie)
 {
-	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
+	struct device *dev = &pcie->pdev->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct irq_domain *parent;
 
 	parent = irq_domain_create_linear(fwnode, XILINX_NUM_MSI_IRQS,
 					  &xilinx_msi_domain_ops, pcie);
 	if (!parent) {
-		dev_err(pcie->dev, "failed to create IRQ domain\n");
+		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
 	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
 
 	pcie->msi_domain = pci_msi_create_irq_domain(fwnode, &xilinx_msi_info, parent);
 	if (!pcie->msi_domain) {
-		dev_err(pcie->dev, "failed to create MSI domain\n");
+		dev_err(dev, "failed to create MSI domain\n");
 		irq_domain_remove(parent);
 		return -ENOMEM;
 	}
@@ -343,7 +344,7 @@ static const struct irq_domain_ops intx_domain_ops = {
 static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 {
 	struct xilinx_pcie *pcie = (struct xilinx_pcie *)data;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	u32 val, mask, status;
 
 	/* Read interrupt decode and mask registers */
@@ -455,7 +456,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
  */
 static int xilinx_pcie_init_irq_domain(struct xilinx_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct device_node *pcie_intc_node;
 	int ret;
 
@@ -496,7 +497,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie *pcie)
  */
 static void xilinx_pcie_init_port(struct xilinx_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 
 	if (xilinx_pcie_link_up(pcie))
 		dev_info(dev, "PCIe Link is UP\n");
@@ -529,7 +530,7 @@ static void xilinx_pcie_init_port(struct xilinx_pcie *pcie)
  */
 static int xilinx_pcie_parse_dt(struct xilinx_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct resource regs;
 	unsigned int irq;
@@ -579,7 +580,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 
 	pcie = pci_host_bridge_priv(bridge);
 	mutex_init(&pcie->map_lock);
-	pcie->dev = dev;
+	pcie->pdev = pdev;
 
 	err = xilinx_pcie_parse_dt(pcie);
 	if (err) {
-- 
2.25.1

