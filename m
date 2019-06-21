Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810B64E35C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfFUJVk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 05:21:40 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14710 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJVj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 05:21:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0ca1a10000>; Fri, 21 Jun 2019 02:21:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Jun 2019 02:21:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Jun 2019 02:21:38 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Jun
 2019 09:21:38 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Jun
 2019 09:21:38 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 21 Jun 2019 09:21:38 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0ca19f0000>; Fri, 21 Jun 2019 02:21:37 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>,
        <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V5 1/3] PCI: dwc: Add API support to de-initialize host
Date:   Fri, 21 Jun 2019 14:51:25 +0530
Message-ID: <20190621092127.17930-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561108898; bh=fN2JTX+5AuNYUERGSOTuFE9qCq3O4/KmTsAayCd2QBQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=V3nO6VlQmL4cptg8jWGkYe8PQetrxgCipi0fEsJ6+84s+2fXT3Rl3a8V5UWkVxgLu
         uE5GCy3Rd8thzJ1CJtz+XvvEhhrlHT7+HFKR3wU7WXoeMNgdajlxDc7rVZTtiwUJHF
         iBCaIeiO2l8jPFBc1MAAoSclo+ny0a4Wszx4Jafbh5ur0Pr3jOx+MDJ2Xmiruf0Dw/
         DXIn92PRuq0og8PeHzIITPkW4BLAI8CnxaJyxwAwbCqDQgufdA7KeUQZHw2E6YuLj1
         FlT3AR4MMW21MQe9B2YDZoVqrnbxpWuDetwA9SdedhO6nRh3WkCBR1M3LZwBJWRuHv
         6tnMCHD7A19+w==
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

