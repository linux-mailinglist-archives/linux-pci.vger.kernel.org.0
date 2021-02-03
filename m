Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B87330D3B2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 08:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhBCHD3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 02:03:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231733AbhBCHDY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 02:03:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E50E64F6C;
        Wed,  3 Feb 2021 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612335720;
        bh=zwb0Mth7eELiBcTxYlfdtlD0vrsPIqLk3jGGMShKrvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XdoNItloIeoArk4MUx2zYkCAhvcYhv947i1IzqdN+/ZNB5S2ahUwEU9r7jgdtMM0a
         B62L8211BpsLwv5gcJSH+gUgXk2MI6btRR/jnFSX/dXeDJzQ8DOOe+gcVz0ra1xwdI
         yMjV7YYTB2742Zif3tzBoi5oKTDOmfrWdJGVM+EIDqlxNNlpKoPLjpgqIzJn47vX9F
         MPdoz+OPj6iS6ZCCUF+JSJQJtoFXwJ19DxFa5MRw6RK08fRsxhixRpxhevT2eB+5ZV
         pCqGZ2sHwq7PQZS3b0HGoP7jcL5WrtPBPJLQZGGfh49f7PuiQ+uta7DyKnKBy42S4W
         pCa6F4i0ZWvVQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l7CAo-001CAb-6A; Wed, 03 Feb 2021 08:01:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 06/11] PCI: dwc: pcie-kirin: simplify Kirin 970 get resource logic
Date:   Wed,  3 Feb 2021 08:01:50 +0100
Message-Id: <360a7aec5005ccb0ce3bed3795b848288286e3f2.1612335031.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612335031.git.mchehab+huawei@kernel.org>
References: <cover.1612335031.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use devm_platform_ioremap_resource_byname() in order to simplify the
logic and to make the logic for Kirin 970 similar to the one for Kirin
960.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index f46a51ffd2c8..e1ebe0747978 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -297,13 +297,13 @@ static long kirin960_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 {
 	struct device *dev = &pdev->dev;
 
-	kirin_pcie->apb_base =
-		devm_platform_ioremap_resource_byname(pdev, "apb");
+	kirin_pcie->apb_base = devm_platform_ioremap_resource_byname(pdev,
+								     "apb");
 	if (IS_ERR(kirin_pcie->apb_base))
 		return PTR_ERR(kirin_pcie->apb_base);
 
-	kirin_pcie->phy_base =
-		devm_platform_ioremap_resource_byname(pdev, "phy");
+	kirin_pcie->phy_base = devm_platform_ioremap_resource_byname(pdev,
+								     "phy");
 	if (IS_ERR(kirin_pcie->phy_base))
 		return PTR_ERR(kirin_pcie->phy_base);
 
@@ -329,23 +329,20 @@ static long kirin970_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 				      struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *apb;
-	struct resource *phy;
-	struct resource *dbi;
 	int ret;
 
-	apb = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb");
-	kirin_pcie->apb_base = devm_ioremap_resource(dev, apb);
+	kirin_pcie->apb_base = devm_platform_ioremap_resource_byname(pdev,
+								     "apb");
 	if (IS_ERR(kirin_pcie->apb_base))
 		return PTR_ERR(kirin_pcie->apb_base);
 
-	phy = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
-	kirin_pcie->phy_base = devm_ioremap_resource(dev, phy);
+	kirin_pcie->phy_base = devm_platform_ioremap_resource_byname(pdev,
+								     "phy");
 	if (IS_ERR(kirin_pcie->phy_base))
 		return PTR_ERR(kirin_pcie->phy_base);
 
-	dbi = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-	kirin_pcie->pci->dbi_base = devm_ioremap_resource(dev, dbi);
+	kirin_pcie->pci->dbi_base = devm_platform_ioremap_resource_byname(pdev,
+									  "dbi");
 	if (IS_ERR(kirin_pcie->pci->dbi_base))
 		return PTR_ERR(kirin_pcie->pci->dbi_base);
 
-- 
2.29.2

