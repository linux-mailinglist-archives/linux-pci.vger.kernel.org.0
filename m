Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D680B45FF20
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355192AbhK0OTz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245464AbhK0ORy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642CEC0613F8
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o13so25094659wrs.12
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHywpbLnmqNH2SDUPxzDEczWXjY+h2wyoTkPOSA5iA0=;
        b=Sj9JlaYfs3Up3ii5b+IYCXappenSIjrHp9tQEO79CUJ3Ygn9A7RRFoc1IWUMCmO9Kj
         qtiBVuvz5AkE0JsnQIjeheCGHOFK4eZJiwmqxf78a4Q78kaIOzGIQD6hywRAmt/im+bP
         dtWfo+qfxdiup0Dz+2o5h8zTTjpWR5jO4LUw4hKouGXLNlY9N00xjRI0ybJON8sq0pUE
         lSvVGH+qZXeXtpWc6M0R8rufJFNzLbzcPkvvr9oKwXn7kOreiKyokvh3QYQyDNwXqZGW
         NflTOTeqICwr3VFs6kC6kbZTgbg073qxz8gkhqON0vbMpjFCAvPz8+/lgIzRTMUkECML
         SOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHywpbLnmqNH2SDUPxzDEczWXjY+h2wyoTkPOSA5iA0=;
        b=rTnodWaBJTq05C+64OBiuQ4p5KiBEuWfW1b+AZq4nfIOgGutjTwOoUbRKs9Httfky6
         ys8RD+egIc/sWoXSMzjXBpbbyJ+5YcNqxi7RtYJ4hhpNyqHxES4xveLKT45RnWxI3cpf
         kpLFI6b2CJNlOi8RJz0ZdgnQHHW2QbG5g9z1nju0sI1OGhV6qbFX441O1K/PxOcTVam8
         dAkTpZDlGm3YOg1dnY4wvBWxkUo2L4qc7qM9fuZhAK4oBXFHOo2yP5rcyUHfyio2u1ym
         ZlHmWoCMOOR+kp9tNE0CQOnx9m7Ty/wKjmEyU1GnkDhrURVcHf3oxHoC44BYzs+Tinx3
         zF7A==
X-Gm-Message-State: AOAM530oX6Rr6RXgnfq4MT0vt3F1VG6QkUGDLblMBkfMeS3jGLxx6L2i
        MWYa9SJm6V3OO/nwyllaz98=
X-Google-Smtp-Source: ABdhPJwIKpJDan/LACavqmOX1dGvhNrRrXmoP8KNTSQyAAzVtTIXuI+/LBMHBrEvVcjwCZOXFi5R6A==
X-Received: by 2002:a5d:6902:: with SMTP id t2mr20636150wru.317.1638022305884;
        Sat, 27 Nov 2021 06:11:45 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:45 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 12/13] PCI: xilinx-nwl: Replace device * with platform_device *
Date:   Sat, 27 Nov 2021 15:11:20 +0100
Message-Id: <5e0d29625125ca307768749c055e76feb552b9c8.1638022049.git.ffclaire1224@gmail.com>
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
struct nwl_pcie, because PCI controllers interact with platform_device
directly, not device, to enumerate the controlled device.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 28 ++++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index a72b4f9a2b00..2e17fe41a9bd 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -154,7 +154,7 @@ struct nwl_msi {			/* MSI information */
 };
 
 struct nwl_pcie {
-	struct device *dev;
+	struct platform_device *pdev;
 	void __iomem *breg_base;
 	void __iomem *pcireg_base;
 	void __iomem *ecam_base;
@@ -200,7 +200,7 @@ static bool nwl_phy_link_up(struct nwl_pcie *pcie)
 
 static int nwl_wait_for_link(struct nwl_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	int retries;
 
 	/* check if the link is up or not */
@@ -260,7 +260,7 @@ static struct pci_ops nwl_pcie_ops = {
 static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
 {
 	struct nwl_pcie *pcie = data;
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	u32 misc_stat;
 
 	/* Checking for misc interrupts */
@@ -504,7 +504,7 @@ static const struct irq_domain_ops dev_msi_domain_ops = {
 static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 {
 #ifdef CONFIG_PCI_MSI
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
 	struct nwl_msi *msi = &pcie->msi;
 
@@ -528,7 +528,7 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 
 static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = &pcie->pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *legacy_intc_node;
 
@@ -555,8 +555,8 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 
 static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
-	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *pdev = pcie->pdev;
+	struct device *dev = &pdev->dev;
 	struct nwl_msi *msi = &pcie->msi;
 	unsigned long base;
 	int ret;
@@ -640,8 +640,8 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 
 static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
-	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *pdev = pcie->pdev;
+	struct device *dev = &pdev->dev;
 	u32 breg_val, ecam_val, first_busno = 0;
 	int err;
 
@@ -756,10 +756,10 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	return 0;
 }
 
-static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
-			     struct platform_device *pdev)
+static int nwl_pcie_parse_dt(struct nwl_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct platform_device *pdev = pcie->pdev;
+	struct device *dev = &pdev->dev;
 	struct resource *res;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
@@ -809,10 +809,10 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 
 	pcie = pci_host_bridge_priv(bridge);
 
-	pcie->dev = dev;
+	pcie->pdev = pdev;
 	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
 
-	err = nwl_pcie_parse_dt(pcie, pdev);
+	err = nwl_pcie_parse_dt(pcie);
 	if (err) {
 		dev_err(dev, "Parsing DT failed\n");
 		return err;
-- 
2.25.1

