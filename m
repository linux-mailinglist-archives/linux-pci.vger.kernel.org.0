Return-Path: <linux-pci+bounces-11949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6FD959CB3
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 15:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68ED281CCD
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868A9199939;
	Wed, 21 Aug 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kpsBQNCy"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244C613D;
	Wed, 21 Aug 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245376; cv=none; b=keG2RZFDYrffQSqQlwpQroqUYRZx7h4NdpYX8J5Ugvvv+SHZ5gI77amDZMTC20BwpQhD2NhoZSOcBzJ1XtqUa667UB8rBT7x5hlMPcYgrAxFHEboZrVLEWiE+Pgnqhtog/AhAqLnwshZ7Q1dCCh/zxR+6MIHg58vJN3Sdwe1mUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245376; c=relaxed/simple;
	bh=ITGSnwUlbEDRh69Ym2WWBpy0Jt4APraANaGuUfDwMiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhmTwrZvCRVYJ9bkXYWUfat1XQuoxnY4RQ/5ZVbP1OWrsbe3UIrL4N0tZ6zoXIIV0v2nG6mblwWyXM1pJ1WK9Ekct7n1Xc0tuzIDJCBggzYgfs3qU07JGRFk8DB21wxNRwTxQJpDguJVR8nKbQEj/5nHMh0xXPdSEkfvUxbRqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kpsBQNCy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724245374; x=1755781374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ITGSnwUlbEDRh69Ym2WWBpy0Jt4APraANaGuUfDwMiA=;
  b=kpsBQNCy6n33+t+bKc9NDJgc9T8HIzH7evZWgeb9BJVF4qO90CLJ9iBh
   SGtbYytbPLBmjsuow3Oqmvx+AIsPk6G90ww3Jzm7csJRMDqdW5TcSjSKM
   UoSowrmBRSNEt+jLTTbha5Fyxnze5Y/0uYAPq7d+rEgfxBdECObBHsiNY
   PGIlgFk6UYKvyEpiTHyMnMFJIlkKdNHvIxDqELM0uQV+SvDW33l911GhQ
   KAnUg6ptyFjLVgr0Md4vyZUuvHTDNJvmqRxOSO5NDQ1zSJG8z/j/1NIl9
   pqTMv/OOA32Q75EeVW8lytk0R60ESP14oZoBISKuWxr8gRKuQP0wQddky
   A==;
X-CSE-ConnectionGUID: hYt9Btb/Rtq04w/yiOUfIw==
X-CSE-MsgGUID: cwDKoYQDQBCF1aifJpkXLQ==
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="30743853"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2024 06:02:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Aug 2024 06:02:32 -0700
Received: from daire-X570.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 21 Aug 2024 06:02:30 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>,
	<ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v8 1/3] PCI: microchip: Fix outbound address translation tables
Date: Wed, 21 Aug 2024 14:02:15 +0100
Message-ID: <20240821130217.957424-2-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821130217.957424-1-daire.mcnamara@microchip.com>
References: <20240821130217.957424-1-daire.mcnamara@microchip.com>
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

This necessitates changing a size_t in mc_pcie_setup_window
to a u64 to avoid a compile error on 32-bit platforms.

Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 48f60a04b740..da766de347bd 100644
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
 
+int mc_pcie_setup_iomems(struct pci_host_bridge *bridge,
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
2.34.1


