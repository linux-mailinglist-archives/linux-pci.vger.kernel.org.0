Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A9627E075
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 07:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgI3FgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 01:36:24 -0400
Received: from mx.socionext.com ([202.248.49.38]:57202 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgI3FgV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 01:36:21 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Sep 2020 14:36:12 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 58A90180BE3;
        Wed, 30 Sep 2020 14:36:12 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Sep 2020 14:36:12 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id DE2F61A0509;
        Wed, 30 Sep 2020 14:36:11 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 3/4] PCI: dwc: Add common iATU register support
Date:   Wed, 30 Sep 2020 14:36:06 +0900
Message-Id: <1601444167-11316-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601444167-11316-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1601444167-11316-1-git-send-email-hayashi.kunihiko@socionext.com>
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
 drivers/pci/controller/dwc/pcie-designware.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 3fe859f..b6b39af 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -10,6 +10,7 @@
 
 #include <linux/delay.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/types.h>
 
 #include "../../pci.h"
@@ -548,11 +549,15 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	u32 val;
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
+	struct platform_device *pdev = to_platform_device(dev);
 
 	if (pci->version >= 0x480A || (!pci->version &&
 				       dw_pcie_iatu_unroll_enabled(pci))) {
 		pci->iatu_unroll_enabled = true;
 		if (!pci->atu_base)
+			pci->atu_base =
+			    devm_platform_ioremap_resource_byname(pdev, "atu");
+		if (IS_ERR(pci->atu_base))
 			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
 	}
 	dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
-- 
2.7.4

