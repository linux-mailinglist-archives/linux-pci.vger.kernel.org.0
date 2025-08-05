Return-Path: <linux-pci+bounces-33431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA94BB1B6FF
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 17:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F137C165E2A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E081823F295;
	Tue,  5 Aug 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0feD8YrT"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E721CA1C
	for <linux-pci@vger.kernel.org>; Tue,  5 Aug 2025 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406166; cv=none; b=g+eSp+kszQSUy7SQaYBozf63GnJWmoUCjbghS8LIrJzg2Ghmpw1UZkm5OrOPr0RT1d73EArDzmHjSBTxqwH2v0mFwPvrn9x8KU6/50rIHJ1gv0UAroUvM0UZ0Pv1hPqp7URMA+2oRqWpqhf4RB6te0b5bO0+fnYJHN7Qm1aI54U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406166; c=relaxed/simple;
	bh=fxsUVqwtcAhWsMF47kgqOMpQO1Lf6oJgkSF6nvRjzaY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lop283ubSWXk6Apxf99CBFEj2ByNRacsyalnc90e1kXlJUdaVLCi5pN4KZXzBErXoebSxurpECBTvwi4Ob1UnDZn1VR2v1jTeWSf/OKiH9EPOqG7sg+dZszCkEsYGR9QjHkDiVr2L8Tnf1GF4iV+ceW10NMDvIImTejhHWvPLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0feD8YrT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754406165; x=1785942165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fxsUVqwtcAhWsMF47kgqOMpQO1Lf6oJgkSF6nvRjzaY=;
  b=0feD8YrTjAQqw8da8S4Cf4+WJzMBObHQ8rpPN/eR3UjAUaENMTWVN4Bz
   omIcJfy/txvsIH/tPLtSjA56sOkWkGDdHYhkfCaXsf7jJFT2pVcEcdxaU
   5xLF/w9aJsT36C3bHAfBxZA3oKbDzPh34J/pLWA4HNKn4eIUeblfkg2vz
   2nIO8n0lxQquL4xurDscz2Zf8j1nJG7SZyD3X/28NOBnDF5LDXqhrRWNw
   hFcJ7sXGZ9cU8ZCjTGmzC7K5zj6JJ1mzta9bNV6F6JZ6gx+aQssuMx2QU
   vwP70fHTfLKZpRrI7lcSih23eFOBH/vSfcAAhrR6YbqVPbeKD4+ZHgGGj
   g==;
X-CSE-ConnectionGUID: hAhaCuRAT6GXvPnvGDgxiw==
X-CSE-MsgGUID: 12KQ15gMQ8qIWr2asiSWqQ==
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="45433149"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Aug 2025 08:02:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 5 Aug 2025 08:02:02 -0700
Received: from IRD-LT-X61553C.mchp-main.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 5 Aug 2025 08:02:00 -0700
From: <daire.mcnamara@microchip.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Daire McNamara <daire.mcnamara@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v11 resend 1/1] PCI: microchip: fix outbound address translation tables
Date: Tue, 5 Aug 2025 16:01:56 +0100
Message-ID: <20250805150156.12392-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.43.0
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
This patch was previously part of the linked series here:
https://lore.kernel.org/linux-pci/20241011140043.1250030-2-daire.mcnamara@microchip.com/
The rest of the linked series has been applied but we've recently
noticed that this one hasn't been applied.

PolarFire SoC PCIe is currently broken in mainline. Can we get this
fixed up and come up with something cross platform later?

V11:
   rebased on mainline

 .../pci/controller/plda/pcie-microchip-host.c | 31 ++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 24bbf93b8051..db7a2f8452e5 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -26,6 +26,8 @@
 #include "../pci-host-common.h"
 #include "pcie-plda.h"
 
+#define MC_OUTBOUND_TRANS_TBL_MASK		GENMASK(31, 0)
+
 #define MC_MAX_NUM_INBOUND_WINDOWS		8
 #define MPFS_NC_BOUNCE_ADDR			0x80000000
 
@@ -700,6 +702,27 @@ static int mc_pcie_setup_inbound_ranges(struct platform_device *pdev,
 	return 0;
 }
 
+static int mc_pcie_setup_iomems(struct pci_host_bridge *bridge,
+				struct plda_pcie_rp *port)
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
@@ -708,15 +731,15 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	int ret;
 
 	/* Configure address translation table 0 for PCIe config space */
-	plda_pcie_setup_window(port->bridge_base_addr, 0, cfg->res.start,
-			       cfg->res.start,
-			       resource_size(&cfg->res));
+	plda_pcie_setup_window(port->bridge_base_addr, 0,
+			       cfg->res.start & MC_OUTBOUND_TRANS_TBL_MASK,
+			       0, resource_size(&cfg->res));
 
 	/* Need some fixups in config space */
 	mc_pcie_enable_msi(port, cfg->win);
 
 	/* Configure non-config space outbound ranges */
-	ret = plda_pcie_setup_iomems(bridge, &port->plda);
+	ret = mc_pcie_setup_iomems(bridge, &port->plda);
 	if (ret)
 		return ret;
 
-- 
2.45.2


