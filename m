Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9532C65DA
	for <lists+linux-pci@lfdr.de>; Fri, 27 Nov 2020 13:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgK0Mn0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Nov 2020 07:43:26 -0500
Received: from mx.socionext.com ([202.248.49.38]:52991 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728013AbgK0Mn0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Nov 2020 07:43:26 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 Nov 2020 21:43:25 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 0A07E180B37;
        Fri, 27 Nov 2020 21:43:25 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 27 Nov 2020 21:43:43 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id BA8291A0506;
        Fri, 27 Nov 2020 21:43:24 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] PCI: designware-ep: Fix the pci->num_{ib,ob}_windows reference before they are set
Date:   Fri, 27 Nov 2020 21:43:22 +0900
Message-Id: <1606481002-17154-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The commit 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows") gets
the values of pci->num_ib_windows and pci->num_ob_windows from iATU
registers instead of DT properties.

However, before the values are set, the allocations in dw_pcie_ep_init()
refer them to determine the sizes of window_map. It's necessary to refer
the values after they are set in dw_pcie_setup().

Cc: Rob Herring <robh@kernel.org>
Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 41 ++++++++++++-------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index bcd1cd9..adc7ca5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -638,6 +638,7 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct device *dev = pci->dev;
 	unsigned int offset;
 	unsigned int nbars;
 	u8 hdr_type;
@@ -669,6 +670,25 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	dw_pcie_setup(pci);
 	dw_pcie_dbi_ro_wr_dis(pci);
 
+	ep->ib_window_map = devm_kcalloc(dev,
+					 BITS_TO_LONGS(pci->num_ib_windows),
+					 sizeof(long),
+					 GFP_KERNEL);
+	if (!ep->ib_window_map)
+		return -ENOMEM;
+
+	ep->ob_window_map = devm_kcalloc(dev,
+					 BITS_TO_LONGS(pci->num_ob_windows),
+					 sizeof(long),
+					 GFP_KERNEL);
+	if (!ep->ob_window_map)
+		return -ENOMEM;
+
+	ep->outbound_addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
+			    GFP_KERNEL);
+	if (!ep->outbound_addr)
+		return -ENOMEM;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
@@ -676,7 +696,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	int ret;
-	void *addr;
 	u8 func_no;
 	struct resource *res;
 	struct pci_epc *epc;
@@ -714,26 +733,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
-	ep->ib_window_map = devm_kcalloc(dev,
-					 BITS_TO_LONGS(pci->num_ib_windows),
-					 sizeof(long),
-					 GFP_KERNEL);
-	if (!ep->ib_window_map)
-		return -ENOMEM;
-
-	ep->ob_window_map = devm_kcalloc(dev,
-					 BITS_TO_LONGS(pci->num_ob_windows),
-					 sizeof(long),
-					 GFP_KERNEL);
-	if (!ep->ob_window_map)
-		return -ENOMEM;
-
-	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
-			    GFP_KERNEL);
-	if (!addr)
-		return -ENOMEM;
-	ep->outbound_addr = addr;
-
 	if (pci->link_gen < 1)
 		pci->link_gen = of_pci_get_max_link_speed(np);
 
-- 
2.7.4

