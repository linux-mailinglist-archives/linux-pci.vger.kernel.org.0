Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030B2120CF
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 19:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfEBREm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 13:04:42 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8683 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBREm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 May 2019 13:04:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ccb232f0000>; Thu, 02 May 2019 10:04:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 May 2019 10:04:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 02 May 2019 10:04:40 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 17:04:39 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 2 May 2019 17:04:39 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ccb23250000>; Thu, 02 May 2019 10:04:39 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <sagar.tv@gmail.com>, <vidyas@nvidia.com>
Subject: [PATCH V4 2/2] PCI: dwc: Export APIs to support .remove() implementation
Date:   Thu, 2 May 2019 22:34:26 +0530
Message-ID: <20190502170426.28688-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190502170426.28688-1-vidyas@nvidia.com>
References: <20190502170426.28688-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556816687; bh=CABm7QowZQs/WeIjPZOwoztxpp2+1uL3QkThwCWUKHo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=T8AaziKjkZC9wZKfLltS3VenvU5rlA6nO1dwva3hvYeJ+07EbEL9A7F2MtDMAE0zl
         AcxJ8Wj41z7Im/2J51ftZXUt5DbADy1smE2tqLrnMpGhjD5v18OV7D3PB9NpeRE275
         8eq2GuWhnNKSnkphqSeyR/nyqKXz1pTD1c0NV7LEIhpYDRmd4949Qz4yxU7dO0lIUI
         2GJawn2oUHjD4ZIwUiJlagmdAci/yylnSGEGpKP7bhjs+rzqF+HUmR3wcU3M0Or3IW
         C0P27+sDss65ewHMC/RxuENUYRxNGq9EGEC/1f/gNweADQjv2u3eJ8DIR3eyA0aSaX
         z1ZVfmo194Rdg==
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
index d7cc1a0c1de6..6401e1c5b398 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -40,6 +40,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_read);
 
 int dw_pcie_write(void __iomem *addr, int size, u32 val)
 {
@@ -57,6 +58,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_write);
 
 u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 		       size_t size)
@@ -73,6 +75,7 @@ u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(__dw_pcie_read_dbi);
 
 void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 			 size_t size, u32 val)
@@ -88,6 +91,7 @@ void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 	if (ret)
 		dev_err(pci->dev, "Write DBI address failed\n");
 }
+EXPORT_SYMBOL_GPL(__dw_pcie_write_dbi);
 
 u32 __dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
 			size_t size)
-- 
2.17.1

