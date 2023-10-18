Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43B97CD730
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 10:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjJRI5K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 04:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjJRI5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 04:57:07 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9B34FA;
        Wed, 18 Oct 2023 01:57:04 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,234,1694703600"; 
   d="scan'208";a="179708488"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Oct 2023 17:57:01 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 500BB40116BA;
        Wed, 18 Oct 2023 17:57:01 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v25 08/15] PCI: dwc: endpoint: Introduce .pre_init() and .deinit()
Date:   Wed, 18 Oct 2023 17:56:24 +0900
Message-Id: <20231018085631.1121289-9-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018085631.1121289-1-yoshihiro.shimoda.uh@renesas.com>
References: <20231018085631.1121289-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Renesas R-Car Gen4 PCIe controllers require vendor-specific
initialization before .init().

To use dw->dbi and dw->num-lanes in the initialization code,
introduce .pre_init() into struct dw_pcie_ep_ops. While at it,
also introduce .deinit() to disable the controller by using
vendor-specific de-initialization.

Note that the ep_init in the struct dw_pcie_ep_ops should be
renamed to init later.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 +++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h    |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index a8bcbc57ef86..d34a5e87ad18 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -637,6 +637,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 			      epc->mem->window.page_size);
 
 	pci_epc_mem_exit(epc);
+
+	if (ep->ops->deinit)
+		ep->ops->deinit(ep);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_exit);
 
@@ -740,6 +743,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
+	if (ep->ops->pre_init)
+		ep->ops->pre_init(ep);
+
 	dw_pcie_version_detect(pci);
 
 	dw_pcie_iatu_detect(pci);
@@ -794,7 +800,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 			       ep->page_size);
 	if (ret < 0) {
 		dev_err(dev, "Failed to initialize address space\n");
-		return ret;
+		goto err_ep_deinit;
 	}
 
 	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
@@ -831,6 +837,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 err_exit_epc_mem:
 	pci_epc_mem_exit(epc);
 
+err_ep_deinit:
+	if (ep->ops->deinit)
+		ep->ops->deinit(ep);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 85522256a8e5..55ff76e3d384 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -331,7 +331,9 @@ struct dw_pcie_rp {
 };
 
 struct dw_pcie_ep_ops {
+	void	(*pre_init)(struct dw_pcie_ep *ep);
 	void	(*ep_init)(struct dw_pcie_ep *ep);
+	void	(*deinit)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
 	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
-- 
2.25.1

