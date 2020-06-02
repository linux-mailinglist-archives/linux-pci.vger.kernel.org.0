Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB2E1EB92E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 12:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgFBKKD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 06:10:03 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5289 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgFBKKA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 06:10:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed625210000>; Tue, 02 Jun 2020 03:08:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Jun 2020 03:09:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Jun 2020 03:09:59 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Jun
 2020 10:09:54 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 2 Jun 2020 10:09:54 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ed6256e0001>; Tue, 02 Jun 2020 03:09:53 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 1/2] PCI: dwc: Add support to handle prefetchable memory separately
Date:   Tue, 2 Jun 2020 15:39:39 +0530
Message-ID: <20200602100940.10575-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602100940.10575-1-vidyas@nvidia.com>
References: <20200602100940.10575-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591092513; bh=cT5G8s0tuAY7ryjlQpRrXd7Ziy0127lhAECR/SIk7dQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=IdyNqTNSFDTXb0+FTNTNin7kRwm1M7ulsVP17ymj3nbxjfsY750b6Vik1Lw0+jk9T
         B5ZIoESMII0KUyLDk/YRdvXVTI+S/qmDyfIvPoYkH5Yps+Lkq8WNRQ4W2HoK/VkuB/
         Z0nIKG0e/xUV70+PJHG0kb70wWX8cXL4cUii0qSqiFs+dCPN3ArT1xv4QDF5m2CIRa
         4Km5zlDG6Afv7QvVPWPpXnKNa55qlECb0iam2/Jd/5Pw1o8LNQKyDCRhtridjOjpUj
         8aKxcSfZoGmImMhbF8yOC9To8uV+KkDGjVJwsC9fO1KGm7Zt4ZhzX7QvmgHNeVd1PG
         aPZXCZqRG6tSg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add required structure members to struct pcie_port to handle prefetchable
memory aperture separately from non-prefetchable memory aperture so that
any dependency on the order of their appearance in the 'ranges' property
of the respective PCIe device tree node can be removed.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 26 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 42fbfe2a1b8f..6f06d6bd9f00 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -363,13 +363,23 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->io_base = pci_pio_to_address(pp->io->start);
 			break;
 		case IORESOURCE_MEM:
-			pp->mem = win->res;
-			pp->mem->name = "MEM";
-			mem_size = resource_size(pp->mem);
-			if (upper_32_bits(mem_size))
-				dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
-			pp->mem_size = mem_size;
-			pp->mem_bus_addr = pp->mem->start - win->offset;
+			if (win->res->flags & IORESOURCE_PREFETCH) {
+				pp->prefetch = win->res;
+				pp->prefetch->name = "PREFETCH";
+				pp->prefetch_base = pp->prefetch->start;
+				pp->prefetch_size = resource_size(pp->prefetch);
+				pp->perfetch_bus_addr = pp->prefetch->start -
+							win->offset;
+			} else {
+				pp->mem = win->res;
+				pp->mem->name = "MEM";
+				pp->mem_base = pp->mem->start;
+				mem_size = resource_size(pp->mem);
+				if (upper_32_bits(mem_size))
+					dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
+				pp->mem_size = mem_size;
+				pp->mem_bus_addr = pp->mem->start - win->offset;
+			}
 			break;
 		case 0:
 			pp->cfg = win->res;
@@ -394,8 +404,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
-	pp->mem_base = pp->mem->start;
-
 	if (!pp->va_cfg0_base) {
 		pp->va_cfg0_base = devm_pci_remap_cfgspace(dev,
 					pp->cfg0_base, pp->cfg0_size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 656e00f8fbeb..c87c1b2a1177 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -186,9 +186,13 @@ struct pcie_port {
 	u64			mem_base;
 	phys_addr_t		mem_bus_addr;
 	u32			mem_size;
+	u64			prefetch_base;
+	phys_addr_t		perfetch_bus_addr;
+	u64			prefetch_size;
 	struct resource		*cfg;
 	struct resource		*io;
 	struct resource		*mem;
+	struct resource		*prefetch;
 	struct resource		*busn;
 	int			irq;
 	const struct dw_pcie_host_ops *ops;
-- 
2.17.1

