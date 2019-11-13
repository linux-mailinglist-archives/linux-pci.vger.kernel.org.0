Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E90FAC9A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 10:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfKMJJQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 04:09:16 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18397 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfKMJJP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 04:09:15 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcbc8030000>; Wed, 13 Nov 2019 01:08:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Nov 2019 01:09:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Nov 2019 01:09:15 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 09:09:14 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Nov 2019 09:09:15 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dcbc8370000>; Wed, 13 Nov 2019 01:09:14 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 3/4] PCI: dwc: Add API to notify core initialization completion
Date:   Wed, 13 Nov 2019 14:38:50 +0530
Message-ID: <20191113090851.26345-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113090851.26345-1-vidyas@nvidia.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573636099; bh=JkeNaPfCuo2cwfh+tW4stGIdSKJ0SABy1KQ6fcPdVVI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=R6khcFZu8N36RWzLvQ95VBTDFQ1aa1n0hCmBkWzEJJfNwWioMAyoU8ry5E7S68VfG
         Gs2TRbD+m/H5VPt7EDvM3psWm/KNErsev5Zk4KuibiPO2H69PXDi1GqM7ebhnKdfRo
         twFU9Eo+KfwQP3bHBjzlPMp6fpF668LBFBAmqrXMzlqFTFK03CROzN6EEkolJ33NAB
         tneW7AHTrxugdYnpNwr32hueewwiz4Kv0Y8in4aqi95/zbh3BvenhTmOhmB6uvbzjL
         /a7iGkkm6GpQ7fypp6wMjJDqRMY480LWo20GbX5zDGNG/a4RK4HYZ+Frb4q/xl5ZeX
         UzwS+uCptsukg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new API dw_pcie_ep_init_notify() to let platform drivers
call it when the core is available for initialization.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 +++++++
 drivers/pci/controller/dwc/pcie-designware.h    | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 06f4379be8a3..1355e1d4d426 100644
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
index 340783e9032e..f62c5bae6b2d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -400,6 +400,7 @@ static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
+void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -422,6 +423,10 @@ static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
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

