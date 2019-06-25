Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 918F5527EF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 11:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfFYJXJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 05:23:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7095 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfFYJXI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 05:23:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d11e7fa0001>; Tue, 25 Jun 2019 02:23:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 25 Jun 2019 02:23:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 25 Jun 2019 02:23:07 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Jun
 2019 09:23:06 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Jun
 2019 09:22:43 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 25 Jun 2019 09:22:43 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d11e7e00001>; Tue, 25 Jun 2019 02:22:43 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>,
        <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V9 1/3] PCI: dwc: Add API support to de-initialize host
Date:   Tue, 25 Jun 2019 14:52:36 +0530
Message-ID: <20190625092238.13207-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561454586; bh=pKDb0lhCcGoJ6FcXLGVKpyAC603cvlAqnZyOBCd3oO8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=U9oq345/IQbV6JNCyoor0+fpjN9QRYHZgJyq5Z+v9ZjGC+QNpOI1dI1MAFJ3QMwoa
         d0MvcQw7PqdSNfJMXexGyKMZuFfRK/z24kPL0f7sr+FsoIgXYIZRnjMAaNp6jqDEhd
         khkrSWG5JCQO3+f+H8xhTYzC1+20ylHPkB9tlgIC7oHeGqpT+uM3iNnb+P11l+h00E
         /fHeZzxMA8uY5G4Cserb+HuydjCRUYQkRH+u7wS1YWR8TWizhzle35Jz5WEaLHdzVw
         LkieiWgvyfWwle2PZdMT4rOlXPxDRcJMmHu8ffiq03/Nuswr0AZCQAAiIVsZnkWKQM
         z+yImgqSaRMug==
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
Changes from v8:
* None

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

