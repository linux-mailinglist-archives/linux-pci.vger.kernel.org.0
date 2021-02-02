Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311B830BF70
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 14:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhBBNbB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 08:31:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231713AbhBBNan (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 08:30:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D15B164F5F;
        Tue,  2 Feb 2021 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612272602;
        bh=Kq8Ew8T+rpiYwjmx29cnowJ2F9DKPIXYcwC0xRArm8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzzZJpCMHKf6jBeFAhaJLL2a+bvIfWpjjB2JnCRtm2CnmUGQHUCNtAIQttHhk/qle
         +fuRf7hb2c/IAK4qHixnckJv6q244xOFqlrrv3QeONhujIGS1d6rqwjM0+1uF+2qLi
         eKxOgf6qy7Lh42YBO2Tf8orNjD5swiZvZyDAYqB1/tOmnknDcL1KmhTSekefoBXziA
         MmwRJSTvdb7W8ObCub8LJ0C1ZY1fC9SmnrS16rw1kFK2HpoPNNFWy3gqaTlgyeoYGA
         4RKfBLB/oBDXFKnnNc8srdZYtKDVbH+zk1SZcgtUOnIFsrEG8irLL2T8YKuqU/ZZrF
         oy2crB4xkRITw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l6vkl-0011yz-MY; Tue, 02 Feb 2021 14:29:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 07/13] pci: dwc: pcie-kirin: simplify kirin 970 get resource logic
Date:   Tue,  2 Feb 2021 14:29:52 +0100
Message-Id: <c0877e7db4ae5d286be0a9e2114b23ea0aaf27f5.1612271903.git.mchehab+huawei@kernel.org>
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

Use devm_platform_ioremap_resource_byname() in order to
simplify the logic and to make the logic for Kirin 970
similar to the one for Kirin 960.

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

