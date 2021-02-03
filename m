Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ABD30D3A4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 08:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhBCHCo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 02:02:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231659AbhBCHCl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 02:02:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59F6B64F58;
        Wed,  3 Feb 2021 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612335720;
        bh=aiSfGloGjZNBvqVkuwBAlS4U5H6KEaC6gLpGGLAMPa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tj73VGPQysEec8IsoH6FwOU1UcsJVNL1MG8RzNtmfxB6fB9eDdqcEepaT0+oVSgvw
         wvJnWmhAG94UIWr2RFQJ+5x2W9jE8AX2P0KLg57/3XBdqiy6emkS2mYPu7+MIjDqL/
         mIsbx0141Vpfq9zd8ERJGQmhxhNG8Sztp2xO2yXOPbszlltznt9l0OtcUazx/xDYxy
         BdfDjQhlwC1NtcniAXH63QpQ6dvOGF2s2kucTroJQjCIsra3S6+7alr91lqrHTTafq
         jLsSOi2/BqR9rGHeL/8gnF7qcWSPqyJap47+BsgdJa8/S2RUwJ1dB3Y/HHWAxJOu9b
         3C1pKwFxb07RA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l7CAo-001CAd-73; Wed, 03 Feb 2021 08:01:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 07/11] PCI: dwc: pcie-kirin: place common init code altogether
Date:   Wed,  3 Feb 2021 08:01:51 +0100
Message-Id: <768a60e538735a426c18c4fd1b3f95d53f678eac.1612335031.git.mchehab+huawei@kernel.org>
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

Both Kirin 960 and Kirin 970 need to do ioremap for apb, phy and dbi.

So, use a shared code for those.

It should be noticed that the dbi remap is now done by dwc core, so it
can simply be removed from kirin970_pcie_get_resource().

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

