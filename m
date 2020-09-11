Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FAA265BEE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 10:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgIKIuU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 04:50:20 -0400
Received: from mx.socionext.com ([202.248.49.38]:29476 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgIKIuR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Sep 2020 04:50:17 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 11 Sep 2020 17:50:16 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 252741800EE;
        Fri, 11 Sep 2020 17:50:16 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 11 Sep 2020 17:50:16 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 6316D1A0508;
        Fri, 11 Sep 2020 17:50:15 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 3/3] PCI: keystone: Remove iATU register mapping
Date:   Fri, 11 Sep 2020 17:50:03 +0900
Message-Id: <1599814203-14441-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599814203-14441-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1599814203-14441-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After applying "PCI: dwc: Add common iATU register support",
there is no need to set own iATU in the Keystone driver itself.

Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index b554812..a222728 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1154,7 +1154,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct keystone_pcie *ks_pcie;
 	struct device_link **link;
 	struct gpio_desc *gpiod;
-	void __iomem *atu_base;
 	struct resource *res;
 	unsigned int version;
 	void __iomem *base;
@@ -1275,23 +1274,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	if (pci->version >= 0x480A) {
-		atu_base = devm_platform_ioremap_resource_byname(pdev, "atu");
-		if (IS_ERR(atu_base)) {
-			ret = PTR_ERR(atu_base);
-			goto err_get_sync;
-		}
-
-		pci->atu_base = atu_base;
-
+	if (pci->version >= 0x480A)
 		ret = ks_pcie_am654_set_mode(dev, mode);
-		if (ret < 0)
-			goto err_get_sync;
-	} else {
+	else
 		ret = ks_pcie_set_mode(dev);
-		if (ret < 0)
-			goto err_get_sync;
-	}
+	if (ret < 0)
+		goto err_get_sync;
 
 	switch (mode) {
 	case DW_PCIE_RC_TYPE:
-- 
2.7.4

