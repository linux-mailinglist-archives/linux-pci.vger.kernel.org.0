Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CAE6EED59
	for <lists+linux-pci@lfdr.de>; Wed, 26 Apr 2023 06:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbjDZE44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 00:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239394AbjDZE4y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 00:56:54 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DD70359D;
        Tue, 25 Apr 2023 21:56:30 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,227,1677510000"; 
   d="scan'208";a="157312805"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Apr 2023 13:56:07 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id E2C6441763FC;
        Wed, 26 Apr 2023 13:56:06 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v14 14/21] PCI: dwc: Introduce .ep_pre_init() and .ep_deinit()
Date:   Wed, 26 Apr 2023 13:55:50 +0900
Message-Id: <20230426045557.3613826-15-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
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

Renesas R-Car Gen4 PCIe controllers require vender-specific
initialization before .ep_init(). To use dw->dbi and dw->num-lanes
in the initialization code, introduce .ep_pre_init() into struct
dw_pcie_ep_ops. Also introduce .ep_deinit() to disable the controller
by using vender-specific de-initialization.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 6 ++++++
 drivers/pci/controller/dwc/pcie-designware.h    | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index bd63d224ed7f..66ca9a1640ac 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -671,6 +671,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct pci_epc *epc = ep->epc;
 
+	if (ep->ops->ep_deinit)
+		ep->ops->ep_deinit(ep);
+
 	dw_pcie_edma_remove(pci);
 
 	if (ep->intx_mem)
@@ -784,6 +787,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
+	if (ep->ops->ep_pre_init)
+		ep->ops->ep_pre_init(ep);
+
 	dw_pcie_version_detect(pci);
 
 	dw_pcie_iatu_detect(pci);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index c4bdfed7b2e2..ae8ac15e53dc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -336,7 +336,9 @@ struct dw_pcie_rp {
 };
 
 struct dw_pcie_ep_ops {
+	void	(*ep_pre_init)(struct dw_pcie_ep *ep);
 	void	(*ep_init)(struct dw_pcie_ep *ep);
+	void	(*ep_deinit)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
 	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
-- 
2.25.1

