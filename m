Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F198B30BF79
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 14:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhBBNb5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 08:31:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232332AbhBBNbZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 08:31:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDAE164F65;
        Tue,  2 Feb 2021 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612272602;
        bh=pfDNid8GVXG6AUlZB+EoyM5rAGYDRiXG0+Zst8HO5jU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUnMslDEY8EJtGiSDmGcVE0lyThkGx+ZVx8kXbLtc5K8Y8/Yj+VpiVDr60xozI1Yb
         xCZo4esS2qRv8P5NdOP/pgd9wWLk7vNMXy3ExnepmEg6A1s2DF8HICR18pc4O8ODNi
         0cTkVMVag6HWv9neotjl2YF6UsHktfWgxSDKGd/9+BuUaNBhJ7eTF/G4crBFhdNT9j
         zxC+ywhF2477e6h7r+v1OV70rv92fCMJ83rKPzmcscNlAmqMTGQeUoXofUI/TpQHcb
         rFh0tGrVA4dmATea4EuhOzg0e2x7d55vQnAm12gUFoaDs61ZzXmzgYm69tIw5ORXV6
         YFazci9YHM/DA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l6vkl-0011z2-O4; Tue, 02 Feb 2021 14:29:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 08/13] pci: dwc: pcie-kirin: place common init code altogether
Date:   Tue,  2 Feb 2021 14:29:53 +0100
Message-Id: <4a4d899b8be44ffd3b4f431085828dcf22c9244f.1612271903.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612271903.git.mchehab+huawei@kernel.org>
References: <cover.1612271903.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both Kirin 960 and Kirin 970 need to do ioremap for apb, phy
and dbi.

So, use a shared code for those.

It should be noticed that the dbi remap is now done by dwc core,
so it can simply be removed from kirin970_pcie_get_resource().

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 45 +++++++++++--------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index e1ebe0747978..2bce6e3750d4 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -292,21 +292,27 @@ static void kirin970_pcie_set_eyeparam(struct kirin_pcie *kirin_pcie)
 	kirin_apb_natural_phy_writel(kirin_pcie, val, LANEN_DIG_ASIC_TX_OVRD_IN_1);
 }
 
+static long kirin_common_pcie_get_resource(struct kirin_pcie *kirin_pcie,
+					   struct platform_device *pdev)
+{
+	kirin_pcie->apb_base = devm_platform_ioremap_resource_byname(pdev,
+								     "apb");
+	if (IS_ERR(kirin_pcie->apb_base))
+		return PTR_ERR(kirin_pcie->apb_base);
+
+	kirin_pcie->phy_base = devm_platform_ioremap_resource_byname(pdev,
+								     "phy");
+	if (IS_ERR(kirin_pcie->phy_base))
+		return PTR_ERR(kirin_pcie->phy_base);
+
+	return 0;
+}
+
 static long kirin960_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 				       struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	kirin_pcie->apb_base = devm_platform_ioremap_resource_byname(pdev,
-								     "apb");
-	if (IS_ERR(kirin_pcie->apb_base))
-		return PTR_ERR(kirin_pcie->apb_base);
-
-	kirin_pcie->phy_base = devm_platform_ioremap_resource_byname(pdev,
-								     "phy");
-	if (IS_ERR(kirin_pcie->phy_base))
-		return PTR_ERR(kirin_pcie->phy_base);
-
 	kirin_pcie->crgctrl =
 		syscon_regmap_lookup_by_compatible("hisilicon,hi3660-crgctrl");
 	if (IS_ERR(kirin_pcie->crgctrl))
@@ -331,21 +337,6 @@ static long kirin970_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	kirin_pcie->apb_base = devm_platform_ioremap_resource_byname(pdev,
-								     "apb");
-	if (IS_ERR(kirin_pcie->apb_base))
-		return PTR_ERR(kirin_pcie->apb_base);
-
-	kirin_pcie->phy_base = devm_platform_ioremap_resource_byname(pdev,
-								     "phy");
-	if (IS_ERR(kirin_pcie->phy_base))
-		return PTR_ERR(kirin_pcie->phy_base);
-
-	kirin_pcie->pci->dbi_base = devm_platform_ioremap_resource_byname(pdev,
-									  "dbi");
-	if (IS_ERR(kirin_pcie->pci->dbi_base))
-		return PTR_ERR(kirin_pcie->pci->dbi_base);
-
 	kirin970_pcie_get_eyeparam(kirin_pcie);
 
 	kirin_pcie->gpio_id_reset[0] = of_get_named_gpio(dev->of_node,
@@ -1141,6 +1132,10 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = kirin_common_pcie_get_resource(kirin_pcie, pdev);
+	if (ret)
+		return ret;
+
 	ret = ops->get_resource(kirin_pcie, pdev);
 	if (ret)
 		return ret;
-- 
2.29.2

