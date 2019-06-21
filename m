Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9374B4E6D0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 13:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfFULKm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 07:10:42 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15243 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFULKm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 07:10:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0cbb2f0000>; Fri, 21 Jun 2019 04:10:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 21 Jun 2019 04:10:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 21 Jun 2019 04:10:40 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Jun
 2019 11:10:39 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 21 Jun 2019 11:10:39 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0cbb2c000d>; Fri, 21 Jun 2019 04:10:39 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>,
        <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V6 3/3] PCI: dwc: Export APIs to support .remove() implementation
Date:   Fri, 21 Jun 2019 16:40:00 +0530
Message-ID: <20190621111000.23216-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621111000.23216-1-vidyas@nvidia.com>
References: <20190621111000.23216-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561115439; bh=y7TEAspofRBMIokrjXATOwSmhawYFwJQqnvJ7ZYiDZQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=sRxZksDqmOS1GxoJ0tynXwEQEL3c2oh3vI3UnHitzsOFcc1sbR+Ps5L1cSFxUC/cO
         wHezHGyBZ4rISu2YN/xcl5tDp8oFoXaffEMaW+kHKyAJL7id3WSJZPNccItjI0bfE2
         4c3dZAwdHXxTbcJ2jcBhLJOmhGV5QtcV0KHxhQW014jrENt240XgeronZp8R/ayoyT
         jGqwlzfrwWYb3ZMcDT92UemfsQdKkbd/hRuOuLLUJoo3AStTO2nhevq6jTlRT77LXT
         lNk+Nt8K7/ziHdtDCfsvq1nnodfxXC8eEMdjRkRyFkFEwP5SNS+/WR1GcB+A72DM6Y
         dE4wGb4rLwv7w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export all configuration space access APIs and also other APIs to
support host controller drivers of DesignWare core based implementations
while adding support for .remove() hook to build their respective drivers
as modules

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Changes from v5:
* None

Changes from v4:
* Removed __ (underscore) from dw_pcie_{write/read}_dbi API names

Changes from v3:
* Exported only __dw_pcie_{read/write}_dbi() APIs instead of
  dw_pcie_read{l/w/b}_dbi & dw_pcie_write{l/w/b}_dbi APIs.

Changes from v2:
* Rebased on top of linux-next top of the tree branch

Changes from v1:
* s/Designware/DesignWare

 drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
 drivers/pci/controller/dwc/pcie-designware.c      | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d069e4290180..f93252d0da5b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -311,6 +311,7 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
 			    upper_32_bits(msi_target));
 }
+EXPORT_SYMBOL_GPL(dw_pcie_msi_init);
 
 int dw_pcie_host_init(struct pcie_port *pp)
 {
@@ -495,6 +496,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		dw_pcie_free_msi(pp);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_host_init);
 
 void dw_pcie_host_deinit(struct pcie_port *pp)
 {
@@ -503,6 +505,7 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
 	if (pci_msi_enabled() && !pp->ops->msi_host_init)
 		dw_pcie_free_msi(pp);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
 
 static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				     u32 devfn, int where, int size, u32 *val,
@@ -695,3 +698,4 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	val |= PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 0b383feb13de..dc9cdcd72ffc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -34,6 +34,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_read);
 
 int dw_pcie_write(void __iomem *addr, int size, u32 val)
 {
@@ -51,6 +52,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_write);
 
 u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
 {
@@ -66,6 +68,7 @@ u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_read_dbi);
 
 void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
@@ -80,6 +83,7 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 	if (ret)
 		dev_err(pci->dev, "Write DBI address failed\n");
 }
+EXPORT_SYMBOL_GPL(dw_pcie_write_dbi);
 
 u32 dw_pcie_read_dbi2(struct dw_pcie *pci, u32 reg, size_t size)
 {
-- 
2.17.1

