Return-Path: <linux-pci+bounces-23100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EB0A56577
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 11:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40A23B6666
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 10:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6445214804;
	Fri,  7 Mar 2025 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lIbATAVU"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C443C213E9E;
	Fri,  7 Mar 2025 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343524; cv=none; b=Ou9XQQArrulPoaW0sVkT1yNnDoHiBuZF5roXluy8dh9NnWvIju62EYgMnGj2NwpU8n+i/63dmCkHDR+Go2ZKuP+9ifp1D4Wfjuqa1GS90SD/TNjz2DwISHvYdlTsKHLkC/yW6oe/rVfdEdXUF0A6pGjQkZOu/6HV+ilEd9xagW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343524; c=relaxed/simple;
	bh=QdA+IjL0G6AqIaW9zmGWmRUs7baWu3L22iGyBth09qE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpr2fFQUjieIGjOeA8VJLNLVB4GP2RzhhddohM+S0blnClKlcTQRNp9vvvdME3euMpqIoGyqDuYais3ciaPLFR+AOxvSmm/Pp4NUVU7fuEmZfibF3d+lKKt/yo6S4fiABRjTSu3PsJ945E0ylCXIydumq7MFSobq5lE6g3USN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lIbATAVU; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527AVdRf4039208
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 04:31:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741343499;
	bh=TZT3DrGgqt/15HlpyNZY5s4i01SLFcQbiUpvH5fmYOs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lIbATAVUzPEJ/XMLc1VwVN0041HgBZ6RAjbZK6QAj7ARfdefvjZxA2LD6HmPjgdQq
	 CWmswBfV+EWMALhoEJlMiAA0EolIduytLBB9TiWdhWvI2WLpTe6UJHjXjZ6STB2VQ+
	 +EUp1Wpzhb7K6OXtQFLbl/jLZ9RDYP2VaE9dtovI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 527AVdsG016663
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Mar 2025 04:31:39 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 04:31:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 04:31:38 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527AVSQ3016876;
	Fri, 7 Mar 2025 04:31:34 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <cassel@kernel.org>, <wojciech.jasko-EXT@continental-corporation.com>,
        <thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>
CC: <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 1/4] PCI: cadence: Add support to build pcie-cadence library as a kernel module
Date: Fri, 7 Mar 2025 16:01:25 +0530
Message-ID: <20250307103128.3287497-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307103128.3287497-1-s-vadapalli@ti.com>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Kishon Vijay Abraham I <kishon@ti.com>

Currently, the Cadence PCIe controller driver can be built as a built-in
module only. Since PCIe functionality is not a necessity for booting, add
support to build the Cadence PCIe driver as a loadable module as well.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/cadence/Kconfig             |  6 +++---
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |  6 ++++++
 drivers/pci/controller/cadence/pcie-cadence-host.c |  9 +++++++++
 drivers/pci/controller/cadence/pcie-cadence.c      | 12 ++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++--
 5 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 8a0044bb3989..82b58096eea0 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -4,16 +4,16 @@ menu "Cadence-based PCIe controllers"
 	depends on PCI
 
 config PCIE_CADENCE
-	bool
+	tristate
 
 config PCIE_CADENCE_HOST
-	bool
+	tristate
 	depends on OF
 	select IRQ_DOMAIN
 	select PCIE_CADENCE
 
 config PCIE_CADENCE_EP
-	bool
+	tristate
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index a4f7ed04d38b..eeb2afdd223e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -6,6 +6,7 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pci-epc.h>
 #include <linux/platform_device.h>
@@ -752,3 +753,8 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_ep_setup);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe endpoint controller driver");
+MODULE_AUTHOR("Cyrille Pitchen <cyrille.pitchen@free-electrons.com>");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 8af95e9da7ce..96055edeb099 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -5,6 +5,7 @@
 
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/list_sort.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -72,6 +73,7 @@ void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 
 	return rc->cfg_base + (where & 0xfff);
 }
+EXPORT_SYMBOL_GPL(cdns_pci_map_bus);
 
 static struct pci_ops cdns_pcie_host_ops = {
 	.map_bus	= cdns_pci_map_bus,
@@ -495,6 +497,7 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
 
 	return cdns_pcie_host_init_address_translation(rc);
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_host_init);
 
 int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 {
@@ -519,6 +522,7 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_host_link_setup);
 
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 {
@@ -581,3 +585,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_host_setup);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe host controller driver");
+MODULE_AUTHOR("Cyrille Pitchen <cyrille.pitchen@free-electrons.com>");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 204e045aed8c..70a19573440e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -4,6 +4,7 @@
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 
 #include "pcie-cadence.h"
@@ -23,6 +24,7 @@ void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
 
 	cdns_pcie_writel(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP, ltssm_control_cap);
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_detect_quiet_min_delay_set);
 
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 				   u32 r, bool is_io,
@@ -100,6 +102,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), addr0);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), addr1);
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_set_outbound_region);
 
 void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
 						  u8 busnr, u8 fn,
@@ -134,6 +137,7 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), addr0);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), addr1);
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_set_outbound_region_for_normal_msg);
 
 void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
 {
@@ -146,6 +150,7 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), 0);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), 0);
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_reset_outbound_region);
 
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
 {
@@ -156,6 +161,7 @@ void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
 		phy_exit(pcie->phy[i]);
 	}
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_disable_phy);
 
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
 {
@@ -184,6 +190,7 @@ int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_enable_phy);
 
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 {
@@ -243,6 +250,7 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_init_phy);
 
 static int cdns_pcie_suspend_noirq(struct device *dev)
 {
@@ -271,3 +279,7 @@ const struct dev_pm_ops cdns_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
 				  cdns_pcie_resume_noirq)
 };
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe controller driver");
+MODULE_AUTHOR("Cyrille Pitchen <cyrille.pitchen@free-electrons.com>");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index f5eeff834ec1..c671e25a481b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -519,7 +519,7 @@ static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
 	return true;
 }
 
-#ifdef CONFIG_PCIE_CADENCE_HOST
+#if IS_ENABLED(CONFIG_PCIE_CADENCE_HOST)
 int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc);
 int cdns_pcie_host_init(struct cdns_pcie_rc *rc);
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
@@ -548,7 +548,7 @@ static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int d
 }
 #endif
 
-#ifdef CONFIG_PCIE_CADENCE_EP
+#if IS_ENABLED(CONFIG_PCIE_CADENCE_EP)
 int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep);
 #else
 static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
-- 
2.34.1


