Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EFA2FADB3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 00:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404117AbhARXLZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 18:11:25 -0500
Received: from mx.socionext.com ([202.248.49.38]:16450 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730151AbhARXLY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jan 2021 18:11:24 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Jan 2021 08:10:41 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id CA473205902B;
        Tue, 19 Jan 2021 08:10:41 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 19 Jan 2021 08:10:41 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 7D774B1D40;
        Tue, 19 Jan 2021 08:10:41 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2] PCI: designware-ep: Fix the reference to pci->num_{ib,ob}_windows before setting
Date:   Tue, 19 Jan 2021 08:10:39 +0900
Message-Id: <1611011439-29881-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The commit 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows") gets
the values of pci->num_ib_windows and pci->num_ob_windows from iATU
registers instead of DT properties in dw_pcie_iatu_detect_regions*() or its
unroll version.

However, before the values are set, the allocations in dw_pcie_ep_init()
refer them to determine the sizes of window_map. As a result, null pointer
dereference exception will occur when linking the EP function and the
controller.

  # ln -s functions/pci_epf_test/test controllers/66000000.pcie-ep/
  Unable to handle kernel NULL pointer dereference at virtual address
  0000000000000010

The call trace is as follows:

  Call trace:
   _find_next_bit.constprop.1+0xc/0x88
   dw_pcie_ep_set_bar+0x78/0x1f8
   pci_epc_set_bar+0x9c/0xe8
   pci_epf_test_core_init+0xe8/0x220
   pci_epf_test_bind+0x1e0/0x378
   pci_epf_bind+0x54/0xb0
   pci_epc_epf_link+0x58/0x80
   configfs_symlink+0x1c0/0x570
   vfs_symlink+0xdc/0x198
   do_symlinkat+0xa0/0x110
   __arm64_sys_symlinkat+0x28/0x38
   el0_svc_common+0x84/0x1a0
   do_el0_svc+0x38/0x88
   el0_svc+0x1c/0x28
   el0_sync_handler+0x88/0xb0
   el0_sync+0x140/0x180

The pci->num_{ib,ob}_windows should be referenced after they are set by
dw_pcie_iatu_detect_regions*() called from dw_pcie_setup().

Cc: Rob Herring <robh@kernel.org>
Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 41 ++++++++++++-------------
 1 file changed, 20 insertions(+), 21 deletions(-)

Changed since v1:
- Add description of exception to commit message
- Change the subject

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

