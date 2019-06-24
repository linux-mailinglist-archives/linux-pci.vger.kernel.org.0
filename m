Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8257500F8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 07:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfFXF0T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 01:26:19 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3420 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFXF0S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2019 01:26:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d105ef80000>; Sun, 23 Jun 2019 22:26:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 23 Jun 2019 22:26:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 23 Jun 2019 22:26:17 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 05:26:17 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 24 Jun 2019 05:26:17 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d105ef60000>; Sun, 23 Jun 2019 22:26:17 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>,
        <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V8 1/3] PCI: dwc: Add API support to de-initialize host
Date:   Mon, 24 Jun 2019 10:56:09 +0530
Message-ID: <20190624052611.11279-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561353976; bh=dzve3ASwEKO4Dcux6cF7QV4x5EvgKnFRmP/2xPrYdWs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=qeef3+LasOVux4RgBLarlrCsiyHDzV8Kdgz+nfW+ViH66Z4dbUdgoRm3m7X0/kwkj
         DZv+JA1KVoRvsYrTcHH+30XbDIuWifTToXxoyrRabAs/AR6xoR3PI7Q8skXjj20pYj
         qY8PnIDPFu/xUOlzZgipBJa3BBXIG82a2r2IX6RDBgr3jCQAUsM1WKmDa0Rv04u9xZ
         zUyVvLymZo6mddhh30J5kDjci3gS9PchKZv2nYiTQIRVZ/LnfHOlBw0F5rQc2672uH
         cnuWJ5KcDd+GEcCxqyTuwGn4OOcY68NqX3fFPOk3rA3OCl0878fRC34FLcHNKvlyKJ
         aCmXqUNOh6aFA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add an API to group all the tasks to be done to de-initialize host which
can then be called by any DesignWare core based driver implementations
while adding .remove() support in their respective drivers.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Changes from v7:
* None

Changes from v6:
* None

Changes from v5:
* None

Changes from v4:
* None

Changes from v3:
* Added check if (pci_msi_enabled() && !pp->ops->msi_host_init) before calling
  dw_pcie_free_msi() API to mimic init path

Changes from v2:
* Rebased on top of linux-next top of the tree branch

Changes from v1:
* s/Designware/DesignWare

 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
 drivers/pci/controller/dwc/pcie-designware.h      | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 77db32529319..d069e4290180 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -496,6 +496,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return ret;
 }
 
+void dw_pcie_host_deinit(struct pcie_port *pp)
+{
+	pci_stop_root_bus(pp->root_bus);
+	pci_remove_root_bus(pp->root_bus);
+	if (pci_msi_enabled() && !pp->ops->msi_host_init)
+		dw_pcie_free_msi(pp);
+}
+
 static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				     u32 devfn, int where, int size, u32 *val,
 				     bool write)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index b8993f2b78df..14762e262758 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -351,6 +351,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
 void dw_pcie_free_msi(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
+void dw_pcie_host_deinit(struct pcie_port *pp);
 int dw_pcie_allocate_domains(struct pcie_port *pp);
 #else
 static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
@@ -375,6 +376,10 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
+static inline void dw_pcie_host_deinit(struct pcie_port *pp)
+{
+}
+
 static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
 {
 	return 0;
-- 
2.17.1

