Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CF255D5D5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbiF0MYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 08:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbiF0MYd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 08:24:33 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F05B0BF4C;
        Mon, 27 Jun 2022 05:24:31 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,226,1650898800"; 
   d="scan'208";a="124258812"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 27 Jun 2022 21:24:29 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id F211D4290415;
        Mon, 27 Jun 2022 21:24:28 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 04/13] PCI: dwc: Add reset_all_bars flag
Date:   Mon, 27 Jun 2022 21:24:08 +0900
Message-Id: <20220627122417.809615-5-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627122417.809615-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220627122417.809615-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCIe endpoint drivers reset all BARs in each ep_init() ops.
So, we can reset the BARs into the common code if the flag is set.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 10 ++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 72158e6af378..439f92d7d284 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -85,6 +85,14 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_reset_bar);
 
+static void dw_pcie_ep_reset_all_bars(struct dw_pcie *pci)
+{
+	enum pci_barno bar;
+
+	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+}
+
 static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
 		u8 cap_ptr, u8 cap)
 {
@@ -773,6 +781,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	if (ep->ops->ep_init)
 		ep->ops->ep_init(ep);
+	if (ep->reset_all_bars)
+		dw_pcie_ep_reset_all_bars(pci);
 
 	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
 			       ep->page_size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 02dcc47749de..7018c2a7ca3b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -243,6 +243,7 @@ struct dw_pcie_ep {
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
+	bool			reset_all_bars;
 };
 
 struct dw_pcie_ops {
-- 
2.25.1

