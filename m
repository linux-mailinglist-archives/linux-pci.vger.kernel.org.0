Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01446265BF3
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 10:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgIKIuW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 04:50:22 -0400
Received: from mx.socionext.com ([202.248.49.38]:29490 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgIKIuR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Sep 2020 04:50:17 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Sep 2020 17:50:15 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 392C960060;
        Fri, 11 Sep 2020 17:50:15 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 11 Sep 2020 17:50:15 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 8AA521A0508;
        Fri, 11 Sep 2020 17:50:14 +0900 (JST)
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
Subject: [PATCH 2/3] PCI: dwc: Add common iATU register support
Date:   Fri, 11 Sep 2020 17:50:02 +0900
Message-Id: <1599814203-14441-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599814203-14441-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1599814203-14441-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This gets iATU register area from reg property that has reg-names "atu".
In Synopsys DWC version 4.80 or later, since iATU register area is
separated from core register area, this area is necessary to get from
DT independently.

Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4d105ef..4a360bc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -10,6 +10,7 @@
 
 #include <linux/delay.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/types.h>
 
 #include "../../pci.h"
@@ -526,11 +527,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	u32 val;
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
+	struct platform_device *pdev;
 
 	if (pci->version >= 0x480A || (!pci->version &&
 				       dw_pcie_iatu_unroll_enabled(pci))) {
 		pci->iatu_unroll_enabled = true;
-		if (!pci->atu_base)
+		pdev = of_find_device_by_node(np);
+		if (!pci->atu_base && pdev)
+			pci->atu_base =
+			    devm_platform_ioremap_resource_byname(pdev, "atu");
+		if (IS_ERR_OR_NULL(pci->atu_base))
 			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
 	}
 	dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
-- 
2.7.4

