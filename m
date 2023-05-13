Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F968701958
	for <lists+linux-pci@lfdr.de>; Sat, 13 May 2023 20:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjEMSql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 May 2023 14:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjEMSqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 May 2023 14:46:39 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB9E1FE7;
        Sat, 13 May 2023 11:46:37 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34DIkNLB051180;
        Sat, 13 May 2023 13:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684003583;
        bh=SmklqMHmFqNtXZFpw2ey0bDKvXCNmYP4xor9MZB4SQ8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GSIiiECxB+ivPPy1Dhi6O2dFcLaXrk+c/reEVLzNtZQGaIS3tYCHgRbFuhYY/M81d
         MgQrMk6rl1QF+i399Fovu0kTIzb2RVrTeljzt9+ljSmNlz50SAGaGfCGwf41oEAx/M
         tZqW0pap6Cka19uG0tcWNx1w9YU5iqnd7Jp39ENQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34DIkN2T011327
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 May 2023 13:46:23 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 13
 May 2023 13:46:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 13 May 2023 13:46:22 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34DIkMjl089171;
        Sat, 13 May 2023 13:46:22 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH v2 1/2] PCI: cadence: Add support to build pcie-cadence library as a kernel module.
Date:   Sun, 14 May 2023 00:16:19 +0530
Message-ID: <20230513184620.2200916-2-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230513184620.2200916-1-a-verma1@ti.com>
References: <20230513184620.2200916-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

Cadence PCIe controller driver can be build as kernel built-in driver only,
which is not required since its not required at boot time.
Thus, this change adds support to build Cadence PCIe driver as kernel
module as well.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 drivers/pci/controller/cadence/Kconfig             | 6 +++---
 drivers/pci/controller/cadence/pcie-cadence-ep.c   | 4 ++++
 drivers/pci/controller/cadence/pcie-cadence-host.c | 5 +++++
 drivers/pci/controller/cadence/pcie-cadence.c      | 9 +++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      | 4 ++--
 5 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 291d12711363..abc245dbedab 100644
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
index b8b655d4047e..598b2b9c5969 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -5,6 +5,7 @@
 
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pci-epc.h>
 #include <linux/platform_device.h>
@@ -741,3 +742,6 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_ep_setup);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 940c7dd701d6..84754c63df34 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -5,6 +5,7 @@
 
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/list_sort.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -70,6 +71,7 @@ void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 
 	return rc->cfg_base + (where & 0xfff);
 }
+EXPORT_SYMBOL_GPL(cdns_pci_map_bus);
 
 static struct pci_ops cdns_pcie_host_ops = {
 	.map_bus	= cdns_pci_map_bus,
@@ -542,3 +544,6 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_host_setup);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 13c4032ca379..8e3a86578284 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -4,6 +4,7 @@
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 
 #include "pcie-cadence.h"
 
@@ -22,6 +23,7 @@ void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
 
 	cdns_pcie_writel(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP, ltssm_control_cap);
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_detect_quiet_min_delay_set);
 
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 				   u32 r, bool is_io,
@@ -99,6 +101,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), addr0);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), addr1);
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_set_outbound_region);
 
 void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
 						  u8 busnr, u8 fn,
@@ -133,6 +136,7 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), addr0);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), addr1);
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_set_outbound_region_for_normal_msg);
 
 void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
 {
@@ -145,6 +149,7 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), 0);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), 0);
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_reset_outbound_region);
 
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
 {
@@ -155,6 +160,7 @@ void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
 		phy_exit(pcie->phy[i]);
 	}
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_disable_phy);
 
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
 {
@@ -242,6 +248,7 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cdns_pcie_init_phy);
 
 static int cdns_pcie_suspend_noirq(struct device *dev)
 {
@@ -270,3 +277,5 @@ const struct dev_pm_ops cdns_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
 				  cdns_pcie_resume_noirq)
 };
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 190786e47df9..65b330c28299 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -514,7 +514,7 @@ static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
 	return true;
 }
 
-#ifdef CONFIG_PCIE_CADENCE_HOST
+#if IS_ENABLED(CONFIG_PCIE_CADENCE_HOST)
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
 void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
@@ -531,7 +531,7 @@ static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int d
 }
 #endif
 
-#ifdef CONFIG_PCIE_CADENCE_EP
+#if IS_ENABLED(CONFIG_PCIE_CADENCE_EP)
 int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep);
 #else
 static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
-- 
2.25.1

