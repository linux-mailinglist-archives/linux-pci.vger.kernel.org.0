Return-Path: <linux-pci+bounces-14322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21C99A5A6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 16:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9D41C24DD7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF131E87B;
	Fri, 11 Oct 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2eRr9dWy"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48CFD517;
	Fri, 11 Oct 2024 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655298; cv=none; b=f7SkHGZDYvsLHEumwSNBWRHFCjgwaeA3yPhCgtr8LE0RHDgJW+AF8hA8b3CC+imYwUKkNZbiryC9KdqafT8Eu2k8FljPZNeE+FnDWjxtoVb65FLX7fbiGzbdqQJ2BKPGcRkWmucoO3fj8Of3Vdc4ssOvBD2z9s561WvPrJfrPoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655298; c=relaxed/simple;
	bh=dtxRXnBlCg/paGRmarwBeClVGbQZHAcN/95Mp8JrAzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+qwqOPZrS1cIMYSnwlyrhTumwX5nuf3+zlQhRSqMCGabPuyjdzg6xlGsSAYg5T62+1WIPQjRblSKcauN+MNKnyyHcskA5B9O3et25uLBK+OXKYZugLIar+r1DYW7OWFpSbYGZBQLSV1QflUbghJe0XMHld4zYAs7T1ZL2ezFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2eRr9dWy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728655297; x=1760191297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dtxRXnBlCg/paGRmarwBeClVGbQZHAcN/95Mp8JrAzw=;
  b=2eRr9dWyYXtrGCZd+JNVhWkWZDxKR6TH5qi72y8anYODGbEfIZkXqPdh
   UuXtoRDAOGFm5hEv1BJZlGhfpclxfWo3sEeWHjv+Nfi1UiwmEu3IWQuyf
   CiO/upc9UgR9bDgqeXN7AU/aBE8uKEFaqxbn0zBA9xYzCrcl5rBwTJqzf
   dTPfy4yEu+MmYwy7huW5nfqjLgCcgAoCHElYL1dgfd83E2yTZoKpkZzXE
   sjwdVC0VlQ2JsUWRznVESVp/JPMsnKtw9FX9AsCkrJmdt4k1sXL4MZh1V
   l4R7ktAZHWaLmr0XKszpceiuCzMPdEl08DumUaWjSu/1IZB5rfwHfNPhK
   w==;
X-CSE-ConnectionGUID: sEVvj1ptTw6T+pKPr7BM0w==
X-CSE-MsgGUID: oB0LVEhBTS+CKBZj4qXJ+Q==
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="33475205"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2024 07:01:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 11 Oct 2024 07:01:31 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 11 Oct 2024 07:01:29 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>,
	<ilpo.jarvinen@linux.intel.com>, <kevin.xie@starfivetech.com>
Subject: [PATCH v10 1/3] PCI: microchip: Fix outbound address translation tables
Date: Fri, 11 Oct 2024 15:00:41 +0100
Message-ID: <20241011140043.1250030-2-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241011140043.1250030-1-daire.mcnamara@microchip.com>
References: <20241011140043.1250030-1-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Daire McNamara <daire.mcnamara@microchip.com>

On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be behind one of
three general-purpose Fabric Interface Controller (FIC) buses that
encapsulate an AXI-M interface. That FIC is responsible for managing
the translations of the upper 32-bits of the AXI-M address. On MPFS,
the Root Port driver needs to take account of that outbound address
translation done by the parent FIC bus before setting up its own
outbound address translation tables.  In all cases on MPFS,
the remaining outbound address translation tables are 32-bit only.

Limit the outbound address translation tables to 32-bit only.

Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 48f60a04b740..fa4c85be21f0 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -21,6 +21,8 @@
 #include "../../pci.h"
 #include "pcie-plda.h"
 
+#define MC_OUTBOUND_TRANS_TBL_MASK		GENMASK(31, 0)
+
 /* PCIe Bridge Phy and Controller Phy offsets */
 #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
 #define MC_PCIE1_CTRL_ADDR			0x0000a000u
@@ -612,6 +614,27 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
+static int mc_pcie_setup_iomems(struct pci_host_bridge *bridge,
+			   struct plda_pcie_rp *port)
+{
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	struct resource_entry *entry;
+	u64 pci_addr;
+	u32 index = 1;
+
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		if (resource_type(entry->res) == IORESOURCE_MEM) {
+			pci_addr = entry->res->start - entry->offset;
+			plda_pcie_setup_window(bridge_base_addr, index,
+					       entry->res->start & MC_OUTBOUND_TRANS_TBL_MASK,
+					       pci_addr, resource_size(entry->res));
+			index++;
+		}
+	}
+
+	return 0;
+}
+
 static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -622,15 +645,14 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	int ret;
 
 	/* Configure address translation table 0 for PCIe config space */
-	plda_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
-			       cfg->res.start,
-			       resource_size(&cfg->res));
+	plda_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & MC_OUTBOUND_TRANS_TBL_MASK,
+			       0, resource_size(&cfg->res));
 
 	/* Need some fixups in config space */
 	mc_pcie_enable_msi(port, cfg->win);
 
 	/* Configure non-config space outbound ranges */
-	ret = plda_pcie_setup_iomems(bridge, &port->plda);
+	ret = mc_pcie_setup_iomems(bridge, &port->plda);
 	if (ret)
 		return ret;
 
-- 
2.43.0


