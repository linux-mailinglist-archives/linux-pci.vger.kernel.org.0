Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4803DB651
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 11:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhG3Juf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 05:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238268AbhG3Jub (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 05:50:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E19761050;
        Fri, 30 Jul 2021 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627638627;
        bh=9wQvNNuV8XRlFJv8fGt0HOdtFjEXmFaSpuPiJvhTIsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iXQUbsJDyHCtAPZx3hoYm0x6MQmt8+S8fyHf44xPOOqWfMjIkW00DWDMa9Di43w44
         6nAXCKRnjq6m2/xJvItd+HbtExsiJOoynzS6AOpMUzspvHzxUV5tg1Mqp2OkyH1v90
         ev8NKBJQUq7TRW/r4we83SErRxplucRUKPKnMe+c96igYzwIFt6dhsEilW9hXtFNVh
         mJAqz7ezjh0qdcliy+Ywsvhh4Zes/FxhlLZ/OsmQUApne0gle0OCcctRCwy6O/jAOr
         a2jO00BoC4hLzGx4V6mZR5VcEemoRDGDzUCOsghcvTE6QU4TxyfCij40QMGt+PQ/uU
         OjsFN9fBvmiXQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m9P9t-006s4Q-Ho; Fri, 30 Jul 2021 11:50:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v8 09/11] PCI: kirin: Add power_off support for Kirin 960 PHY
Date:   Fri, 30 Jul 2021 11:50:12 +0200
Message-Id: <b57d7009e564df5edb638f0ecedd535e9d55d68d.1627637745.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627637745.git.mchehab+huawei@kernel.org>
References: <cover.1627637745.git.mchehab+huawei@kernel.org>
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
index dc6e38ee02b3..58a993a998f3 100644
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
@@ -563,7 +575,6 @@ static int kirin_pcie_add_bus(struct pci_bus *bus)
 	return 0;
 }
 
-
 static struct pci_ops kirin_pci_ops = {
 	.read = kirin_pcie_rd_own_conf,
 	.write = kirin_pcie_wr_own_conf,
@@ -717,8 +728,12 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 
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
@@ -728,7 +743,7 @@ static int __exit kirin_pcie_remove(struct platform_device *pdev)
 	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
 
 	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
-		return 0;
+		return hi3660_pcie_phy_power_off(kirin_pcie);
 
 	phy_power_off(kirin_pcie->phy);
 	phy_exit(kirin_pcie->phy);
-- 
2.31.1

