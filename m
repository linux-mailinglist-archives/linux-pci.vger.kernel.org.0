Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B453D843D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 01:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhG0Xpy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 19:45:54 -0400
Received: from mx.socionext.com ([202.248.49.38]:36672 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233081AbhG0Xpw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 19:45:52 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Jul 2021 08:45:51 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 30D9D205902A;
        Wed, 28 Jul 2021 08:45:51 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 28 Jul 2021 08:45:51 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id AE83BB633F;
        Wed, 28 Jul 2021 08:45:50 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vidya Sagar <vidyas@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH 2/2] PCI: designware-ep: Fix the access to DBI/iATU registers before enabling controller
Date:   Wed, 28 Jul 2021 08:45:37 +0900
Message-Id: <1627429537-4554-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627429537-4554-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1627429537-4554-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The driver using core_init_notifier, e.g. pcie-tegra194.c, runs according
to the following sequence:

    probe()
        dw_pcie_ep_init()

    bind()
        dw_pcie_ep_start()
            enable_irq()

    (interrupt occurred)
    handler()
        [enable controller]
        dw_pcie_ep_init_complete()
        dw_pcie_ep_init_notify()

After receiving an interrupt from RC, the handler enables the controller
and the controller registers can be accessed.
So accessing the registers should do in dw_pcie_ep_init_complete().

Currently dw_pcie_ep_init() has functions dw_iatu_detect() and
dw_pcie_ep_find_capability() that include accesses to DWC registers.
As a result, accessing the registers before enabling the controller,
the access will fail.

The function dw_pcie_ep_init() shouldn't have any access to DWC registers
if the controller is enabled after calling bind(). This moves access codes
to DBI/iATU registers and depending variables from dw_pcie_ep_init() to
dw_pcie_ep_init_complete().

Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
Fixes: 6bfc9c3a2c70 ("PCI: designware-ep: Move the function of getting MSI capability forward")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 81 +++++++++++++------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8d028a8..f0c93d7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -636,16 +636,56 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *ep_func;
+	struct device *dev = pci->dev;
 	unsigned int offset;
 	unsigned int nbars;
 	u8 hdr_type;
+	u8 func_no;
+	void *addr;
 	u32 reg;
 	int i;
 
+	dw_pcie_iatu_detect(pci);
+
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
+	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
+			    GFP_KERNEL);
+	if (!addr)
+		return -ENOMEM;
+	ep->outbound_addr = addr;
+
+	for (func_no = 0; func_no < ep->epc->max_functions; func_no++) {
+		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
+		if (!ep_func)
+			return -ENOMEM;
+
+		ep_func->func_no = func_no;
+		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
+							      PCI_CAP_ID_MSI);
+		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
+							       PCI_CAP_ID_MSIX);
+
+		list_add_tail(&ep_func->list, &ep->func_list);
+	}
+
 	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
 		   PCI_HEADER_TYPE_MASK;
 	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
-		dev_err(pci->dev,
+		dev_err(dev,
 			"PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
 			hdr_type);
 		return -EIO;
@@ -674,8 +714,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	int ret;
-	void *addr;
-	u8 func_no;
 	struct resource *res;
 	struct pci_epc *epc;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -683,7 +721,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
 	const struct pci_epc_features *epc_features;
-	struct dw_pcie_ep_func *ep_func;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -705,8 +742,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		}
 	}
 
-	dw_pcie_iatu_detect(pci);
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
 		return -EINVAL;
@@ -714,26 +749,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
 
@@ -750,20 +765,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ret < 0)
 		epc->max_functions = 1;
 
-	for (func_no = 0; func_no < epc->max_functions; func_no++) {
-		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
-		if (!ep_func)
-			return -ENOMEM;
-
-		ep_func->func_no = func_no;
-		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
-							      PCI_CAP_ID_MSI);
-		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
-							       PCI_CAP_ID_MSIX);
-
-		list_add_tail(&ep_func->list, &ep->func_list);
-	}
-
 	if (ep->ops->ep_init)
 		ep->ops->ep_init(ep);
 
-- 
2.7.4

