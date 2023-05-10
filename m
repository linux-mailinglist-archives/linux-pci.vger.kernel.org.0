Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B76FD6C7
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 08:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbjEJGWq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 02:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbjEJGWm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 02:22:42 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B91582D57;
        Tue,  9 May 2023 23:22:40 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,263,1677510000"; 
   d="scan'208";a="158801581"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 May 2023 15:22:37 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 298584010E3C;
        Wed, 10 May 2023 15:22:37 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v16 08/22] PCI: designware-ep: Add INTx IRQs support
Date:   Wed, 10 May 2023 15:22:20 +0900
Message-Id: <20230510062234.201499-9-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for triggering INTx IRQs by using outbound iATU.
Outbound iATU is utilized to send assert and de-assert INTx TLPs.
The message is generated based on the payloadless Msg TLP with type
0x14, where 0x4 is the routing code implying the Terminate at
Receiver message. The message code is specified as b1000xx for
the INTx assertion and b1001xx for the INTx de-assertion.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 66 +++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index fe2e0d765be9..0abc0073b1cf 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -6,9 +6,11 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
@@ -484,14 +486,57 @@ static const struct pci_epc_ops epc_ops = {
 	.get_features		= dw_pcie_ep_get_features,
 };
 
+static int dw_pcie_ep_send_msg(struct dw_pcie_ep *ep, u8 func_no, u8 code,
+			       u8 routing)
+{
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
+	struct pci_epc *epc = ep->epc;
+	int ret;
+
+	atu.func_no = func_no;
+	atu.code = code;
+	atu.routing = routing;
+	atu.type = PCIE_ATU_TYPE_MSG;
+	atu.cpu_addr = ep->intx_mem_phys;
+	atu.size = epc->mem->window.page_size;
+
+	ret = dw_pcie_ep_outbound_atu(ep, &atu);
+	if (ret)
+		return ret;
+
+	writel(0, ep->intx_mem);
+
+	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->intx_mem_phys);
+
+	return 0;
+}
+
 int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct device *dev = pci->dev;
+	int ret;
 
-	dev_err(dev, "EP cannot trigger INTx IRQs\n");
+	if (!ep->intx_mem) {
+		dev_err(dev, "INTx not supported\n");
+		return -EOPNOTSUPP;
+	}
 
-	return -EINVAL;
+	/*
+	 * According to the document of PCIe, the INTx emulation should be
+	 * level-triggered. However, the Linux PCIe Endpoint framework only
+	 * supports edge-triggered for now. So, this function asserts INTx for
+	 * 50 usec, and then deasserts it.
+	 */
+	ret = dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_ASSERT_INTA,
+				  PCI_MSG_ROUTING_LOCAL);
+	if (ret)
+		return ret;
+
+	usleep_range(50, 100);
+
+	return dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_DEASSERT_INTA,
+				   PCI_MSG_ROUTING_LOCAL);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
 
@@ -622,6 +667,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 
 	dw_pcie_edma_remove(pci);
 
+	if (ep->intx_mem)
+		pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep->intx_mem,
+				      epc->mem->window.page_size);
+
 	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
 			      epc->mem->window.page_size);
 
@@ -793,9 +842,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		goto err_exit_epc_mem;
 	}
 
+	ep->intx_mem = pci_epc_mem_alloc_addr(epc, &ep->intx_mem_phys,
+					      epc->mem->window.page_size);
+	if (!ep->intx_mem)
+		dev_warn(dev, "Failed to reserve memory for INTx\n");
+
 	ret = dw_pcie_edma_detect(pci);
 	if (ret)
-		goto err_free_epc_mem;
+		goto err_free_epc_mem_intx;
 
 	if (ep->ops->get_features) {
 		epc_features = ep->ops->get_features(ep);
@@ -812,7 +866,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 err_remove_edma:
 	dw_pcie_edma_remove(pci);
 
-err_free_epc_mem:
+err_free_epc_mem_intx:
+	if (ep->intx_mem)
+		pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep->intx_mem,
+				      epc->mem->window.page_size);
+
 	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
 			      epc->mem->window.page_size);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index c83d1d176e62..06e044e2163a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -369,6 +369,8 @@ struct dw_pcie_ep {
 	unsigned long		*ob_window_map;
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
+	void __iomem		*intx_mem;
+	phys_addr_t		intx_mem_phys;
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
 };
 
-- 
2.25.1

