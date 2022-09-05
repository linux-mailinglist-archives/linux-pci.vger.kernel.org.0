Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A6E5ACC96
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 09:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbiIEHTj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 03:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbiIEHTJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 03:19:09 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16A5541D30;
        Mon,  5 Sep 2022 00:14:12 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,290,1654527600"; 
   d="scan'208";a="133728196"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Sep 2022 16:13:09 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7D6BA4004465;
        Mon,  5 Sep 2022 16:13:09 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v5 05/12] PCI: dwc: Add ep_pre_init() callback to dw_pcie_ep_ops
Date:   Mon,  5 Sep 2022 16:12:50 +0900
Message-Id: <20220905071257.1059436-6-yoshihiro.shimoda.uh@renesas.com>
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

Some PCIe endpoint controller needs vendor-specific initialization
before the common code initialization. Add a nwe callback function
ep_pre_init() for it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 3 +++
 drivers/pci/controller/dwc/pcie-designware.h    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index ca8f1804ee10..1b7e9e1b8d52 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -709,6 +709,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	dw_pcie_version_detect(pci);
 
+	if (ep->ops->ep_pre_init)
+		ep->ops->ep_pre_init(ep);
+
 	dw_pcie_iatu_detect(pci);
 
 	ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index b541f653c209..9ed9621a12e4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -317,6 +317,7 @@ struct dw_pcie_rp {
 };
 
 struct dw_pcie_ep_ops {
+	void	(*ep_pre_init)(struct dw_pcie_ep *ep);
 	void	(*ep_init)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
-- 
2.25.1

