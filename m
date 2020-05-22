Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793701DDE1C
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 05:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgEVDhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 23:37:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50092 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgEVDhU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 23:37:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04M3b6Lg038256;
        Thu, 21 May 2020 22:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590118626;
        bh=SygTkP2yXS1UJ38coFdpTsVvGlEb1ajfW+y3Zbdf7Io=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mDFCbgmtISezB7UqjgF+L2SGlgyfkominycaFTgBhVVoKBOD1AagFQcLi+WhUimhI
         wBlxboS6k0K9DsLgCnTpH/BjSeoyEHbp8qb2luX0r2mYo39Fa3fA/9orPUIFto1GPY
         w8zMhXXZ87gu8PfPZcIDblw481VZVFfkou2XADmA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04M3b5n1027038
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 22:37:05 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 22:37:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 22:37:04 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04M3aYc3062596;
        Thu, 21 May 2020 22:37:01 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 07/14] PCI: cadence: Add new *ops* for CPU addr fixup
Date:   Fri, 22 May 2020 09:06:24 +0530
Message-ID: <20200522033631.32574-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522033631.32574-1-kishon@ti.com>
References: <20200522033631.32574-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence driver uses "mem" memory resource to obtain the offset of
configuration space address region, memory space address region and
message space address region. The obtained offset is used to program
the Address Translation Unit (ATU). However certain platforms like TI's
J721E SoC require the absolute address to be programmed in the ATU and not
just the offset.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/cadence/pcie-cadence-host.c    | 15 ++++-----------
 .../pci/controller/cadence/pcie-cadence-plat.c    | 13 +++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.c     |  8 ++++++--
 drivers/pci/controller/cadence/pcie-cadence.h     |  1 +
 4 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 62796791f02c..3003fafa3bfa 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -330,15 +330,14 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
 static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
-	struct resource *mem_res = pcie->mem_res;
 	struct resource *bus_range = rc->bus_range;
 	struct resource *cfg_res = rc->cfg_res;
 	struct device *dev = pcie->dev;
 	struct device_node *np = dev->of_node;
 	struct of_pci_range_parser parser;
+	u64 cpu_addr = cfg_res->start;
 	struct of_pci_range range;
 	u32 addr0, addr1, desc1;
-	u64 cpu_addr;
 	int r, err;
 
 	/*
@@ -351,7 +350,9 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
 
-	cpu_addr = cfg_res->start - mem_res->start;
+	if (pcie->ops->cpu_addr_fixup)
+		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
+
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
 		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
 	addr1 = upper_32_bits(cpu_addr);
@@ -480,14 +481,6 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	}
 	rc->cfg_res = res;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem");
-	if (!res) {
-		dev_err(dev, "missing \"mem\"\n");
-		return -EINVAL;
-	}
-
-	pcie->mem_res = res;
-
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to start link\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index f5c6bf6dfcb8..6f5f07b3eed1 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -13,6 +13,8 @@
 #include <linux/of_device.h>
 #include "pcie-cadence.h"
 
+#define CDNS_PLAT_CPU_TO_BUS_ADDR	0x0FFFFFFF
+
 /**
  * struct cdns_plat_pcie - private data for this PCIe platform driver
  * @pcie: Cadence PCIe controller
@@ -30,6 +32,15 @@ struct cdns_plat_pcie_of_data {
 
 static const struct of_device_id cdns_plat_pcie_of_match[];
 
+static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
+{
+	return cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR;
+}
+
+static const struct cdns_pcie_ops cdns_plat_ops = {
+	.cpu_addr_fixup = cdns_plat_cpu_addr_fixup,
+};
+
 static int cdns_plat_pcie_probe(struct platform_device *pdev)
 {
 	const struct cdns_plat_pcie_of_data *data;
@@ -66,6 +77,7 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 
 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
+		rc->pcie.ops = &cdns_plat_ops;
 		cdns_plat_pcie->pcie = &rc->pcie;
 		cdns_plat_pcie->is_rc = is_rc;
 
@@ -93,6 +105,7 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 			return -ENOMEM;
 
 		ep->pcie.dev = dev;
+		ep->pcie.ops = &cdns_plat_ops;
 		cdns_plat_pcie->pcie = &ep->pcie;
 		cdns_plat_pcie->is_rc = is_rc;
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index cd795f6fc1e2..8a02981fd456 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -73,7 +73,9 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
 
 	/* Set the CPU address */
-	cpu_addr -= pcie->mem_res->start;
+	if (pcie->ops->cpu_addr_fixup)
+		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
+
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
 		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
 	addr1 = upper_32_bits(cpu_addr);
@@ -100,7 +102,9 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie, u8 fn,
 	}
 
 	/* Set the CPU address */
-	cpu_addr -= pcie->mem_res->start;
+	if (pcie->ops->cpu_addr_fixup)
+		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
+
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
 		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
 	addr1 = upper_32_bits(cpu_addr);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index c013e629e9fa..3490723169c6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -254,6 +254,7 @@ struct cdns_pcie_ops {
 	int	(*start_link)(struct cdns_pcie *pcie);
 	void	(*stop_link)(struct cdns_pcie *pcie);
 	bool	(*link_up)(struct cdns_pcie *pcie);
+	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
 };
 
 /**
-- 
2.17.1

