Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806E23EA01D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 10:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbhHLIC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 04:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234959AbhHLIC4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 04:02:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9434D6109D;
        Thu, 12 Aug 2021 08:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628755345;
        bh=QO6ks9o/w7e9RGBeirwIusqXEl5dEdnKfYYFLp5hQTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGb763e/zd9QJBRq3LtEh15AH1et0Wc4pcSQsHjs3lvqmp3KVLHitpoW17yqjdhaH
         DI7uh/ae5+66f1BGs5viDiEhpmw5Q1wYY0L2PjGrFi55nGq2YE1n8DGKAgT2fhmqr2
         LC1xYqrO/1Lc73SLygHUn51dFy95p9SRen0GCo308osvIcZtFDKOdmvrXoSKo7tAwI
         czNU8Z3p46Mmym26knGyzJ5uW1+n1VNmtuWi2HLOu8cUzhN6bjIYICU5Mb2rlV7sBt
         EWPfQTYfBFpiI2VMCnp4cGavS0Uv2f0xWBL+U09ALG0spNIlNN2gJ8MTQaQE1GNhxy
         027ugL5N7QOAg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mE5fT-00DZDF-Ub; Thu, 12 Aug 2021 10:02:23 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v11 09/11] PCI: kirin: Add power_off support for Kirin 960 PHY
Date:   Thu, 12 Aug 2021 10:02:20 +0200
Message-Id: <241c5c064907c3c32f5b8c232638fd47d2a53035.1628755058.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628755058.git.mchehab+huawei@kernel.org>
References: <cover.1628755058.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to prepare for module unload, add a power_off method
for HiKey 960.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d5c29a266756..b17a194cf78d 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -343,6 +343,18 @@ static int hi3660_pcie_phy_init(struct platform_device *pdev,
 	return hi3660_pcie_phy_get_resource(phy);
 }
 
+static int hi3660_pcie_phy_power_off(struct kirin_pcie *pcie)
+{
+	struct hi3660_pcie_phy *phy = pcie->phy_priv;
+
+	/* Drop power supply for Host */
+	regmap_write(phy->sysctrl, SCTRL_PCIE_CMOS_OFFSET, 0x00);
+
+	hi3660_pcie_phy_clk_ctrl(phy, false);
+
+	return 0;
+}
+
 /*
  * The non-PHY part starts here
  */
@@ -560,7 +572,6 @@ static int kirin_pcie_add_bus(struct pci_bus *bus)
 	return 0;
 }
 
-
 static struct pci_ops kirin_pci_ops = {
 	.read = kirin_pcie_rd_own_conf,
 	.write = kirin_pcie_wr_own_conf,
@@ -714,8 +725,12 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 
 	return 0;
 err:
-	if (kirin_pcie->type != PCIE_KIRIN_INTERNAL_PHY)
+	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY) {
+		hi3660_pcie_phy_power_off(kirin_pcie);
+	} else {
+		phy_power_off(kirin_pcie->phy);
 		phy_exit(kirin_pcie->phy);
+	}
 
 	return ret;
 }
@@ -725,7 +740,7 @@ static int __exit kirin_pcie_remove(struct platform_device *pdev)
 	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
 
 	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
-		return 0;
+		return hi3660_pcie_phy_power_off(kirin_pcie);
 
 	phy_power_off(kirin_pcie->phy);
 	phy_exit(kirin_pcie->phy);
-- 
2.31.1

