Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B80B5ACCAF
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 09:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiIEHTj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 03:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbiIEHTI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 03:19:08 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDCE441D18;
        Mon,  5 Sep 2022 00:14:12 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,290,1654527600"; 
   d="scan'208";a="131687304"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Sep 2022 16:13:09 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 98E2F4004465;
        Mon,  5 Sep 2022 16:13:09 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v5 06/12] PCI: dwc: Add reset_all_bars flag
Date:   Mon,  5 Sep 2022 16:12:51 +0900
Message-Id: <20220905071257.1059436-7-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905071257.1059436-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220905071257.1059436-1-yoshihiro.shimoda.uh@renesas.com>
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
index 1b7e9e1b8d52..a79482824e74 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -83,6 +83,14 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
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
@@ -759,6 +767,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	if (ep->ops->ep_init)
 		ep->ops->ep_init(ep);
+	if (ep->reset_all_bars)
+		dw_pcie_ep_reset_all_bars(pci);
 
 	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
 			       ep->page_size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9ed9621a12e4..0ad9ed77affb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -353,6 +353,7 @@ struct dw_pcie_ep {
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
+	bool			reset_all_bars;
 };
 
 struct dw_pcie_ops {
-- 
2.25.1

