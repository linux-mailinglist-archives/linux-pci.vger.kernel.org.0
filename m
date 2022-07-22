Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7249E57E095
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 13:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiGVLIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 07:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiGVLIA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 07:08:00 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88B129F063;
        Fri, 22 Jul 2022 04:07:59 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,185,1654527600"; 
   d="scan'208";a="128784526"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jul 2022 20:07:57 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7BD2541FFA2D;
        Fri, 22 Jul 2022 20:07:57 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 05/12] PCI: dwc: Add ep_pre_init() callback to dw_pcie_ep_ops
Date:   Fri, 22 Jul 2022 20:07:37 +0900
Message-Id: <20220722110744.2274466-6-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722110744.2274466-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220722110744.2274466-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
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
index 055058b6ff42..9a47448026d7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -701,6 +701,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	dw_pcie_version_detect(pci);
 
+	if (ep->ops->ep_pre_init)
+		ep->ops->ep_pre_init(ep);
+
 	dw_pcie_iatu_detect(pci);
 
 	ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 4b33a78c1c19..0fc96c7cb15c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -286,6 +286,7 @@ struct dw_pcie_rp {
 };
 
 struct dw_pcie_ep_ops {
+	void	(*ep_pre_init)(struct dw_pcie_ep *ep);
 	void	(*ep_init)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
-- 
2.25.1

