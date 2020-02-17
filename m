Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A72061611BA
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 13:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgBQMLR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 07:11:17 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4054 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbgBQMLQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 07:11:16 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4a82c50000>; Mon, 17 Feb 2020 04:10:45 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Feb 2020 04:11:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Feb 2020 04:11:16 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Feb
 2020 12:11:15 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Feb 2020 12:11:15 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4a82df000a>; Mon, 17 Feb 2020 04:11:15 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 4/5] PCI: dwc: Add API to notify core initialization completion
Date:   Mon, 17 Feb 2020 17:40:35 +0530
Message-ID: <20200217121036.3057-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217121036.3057-1-vidyas@nvidia.com>
References: <20200217121036.3057-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581941445; bh=Ew+YAoC78lbCbOK4T6Zy3U26kqQBW/J/VlNdCnqGl2M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=MLP6lwmlWrd3mlR5Q1XXGf3rtgiZa3HMBlzjNGkGYo/pqPbW8ydkq2ulRWgtKFxd/
         dUo2Mh07g78u6X4B8vQq3HDJKZUy79QBzYrv/iNgQBdf0X0fuYzAa57a0xZP/1qqdm
         hCKBoIF333JU0HYg9HcolFZhAlwerFkvE43orKOogB2hgRTYzX8e8tVUxnTRA9/kdk
         TY1LFjLtcESoxijnCxsf2DTC9FEIKezAOzx1uo/d9Xnii/+dVGArP/3uyG7XBvGcgE
         bfZwx1+R36SHJFWwLwfkfgMb8Ou0iMjcmwyrQryUYboHYM9mSz98uLR5lwCgV8aFgM
         5B+4+EClGRc8A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new API dw_pcie_ep_init_notify() to let platform drivers
call it when the core is available for initialization.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
V3:
* Added Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

V2:
* None

 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 +++++++
 drivers/pci/controller/dwc/pcie-designware.h    | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 84a102df9f62..dfbb806c25bf 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -19,6 +19,13 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 	pci_epc_linkup(epc);
 }
 
+void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
+{
+	struct pci_epc *epc = ep->epc;
+
+	pci_epc_init_notify(epc);
+}
+
 static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
 				   int flags)
 {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index b67b7f756bc2..aa98fbd50807 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -412,6 +412,7 @@ static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
+void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -434,6 +435,10 @@ static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	return 0;
 }
 
+static inline void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
+{
+}
+
 static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 }
-- 
2.17.1

