Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9B11DD8B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 06:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfLMFTv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 00:19:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:45304 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLMFTv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 00:19:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 21:19:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,308,1571727600"; 
   d="scan'208";a="388561205"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 12 Dec 2019 21:19:47 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH 1/1] PCI: dwc: intel: fix nitpicks
Date:   Fri, 13 Dec 2019 13:19:43 +0800
Message-Id: <457c714ba7a73075291778b3436fd96feca7c532.1576144419.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the minor nits pointed in review of
Intel PCIe driver and PCIe DesignWare core.
No functional change expected.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/pci/controller/dwc/pcie-designware.c |  3 +--
 drivers/pci/controller/dwc/pcie-intel-gw.c   | 30 ++++++++++++++--------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 479e250695a0..681548c88282 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -12,10 +12,9 @@
 #include <linux/of.h>
 #include <linux/types.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
-extern const unsigned char pcie_link_speed[];
-
 /*
  * These interfaces resemble the pci_find_*capability() interfaces, but these
  * are for configuring host controllers, which are bridges *to* PCI devices but
diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 8eada8f027bb..fc2a12212dec 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -57,9 +57,9 @@
 #define RESET_INTERVAL_MS		100
 
 struct intel_pcie_soc {
-	unsigned int pcie_ver;
-	unsigned int pcie_atu_offset;
-	u32 num_viewport;
+	unsigned int	pcie_ver;
+	unsigned int	pcie_atu_offset;
+	u32		num_viewport;
 };
 
 struct intel_pcie_port {
@@ -192,7 +192,7 @@ static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
 	if (IS_ERR(lpp->reset_gpio)) {
 		ret = PTR_ERR(lpp->reset_gpio);
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
+			dev_err(dev, "Failed to request PCIe GPIO: %d\n", ret);
 		return ret;
 	}
 
@@ -265,7 +265,7 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
 	if (IS_ERR(lpp->core_clk)) {
 		ret = PTR_ERR(lpp->core_clk);
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get clks: %d\n", ret);
+			dev_err(dev, "Failed to get clks: %d\n", ret);
 		return ret;
 	}
 
@@ -273,13 +273,13 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
 	if (IS_ERR(lpp->core_rst)) {
 		ret = PTR_ERR(lpp->core_rst);
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get resets: %d\n", ret);
+			dev_err(dev, "Failed to get resets: %d\n", ret);
 		return ret;
 	}
 
 	ret = device_property_match_string(dev, "device_type", "pci");
 	if (ret) {
-		dev_err(dev, "failed to find pci device type: %d\n", ret);
+		dev_err(dev, "Failed to find pci device type: %d\n", ret);
 		return ret;
 	}
 
@@ -300,7 +300,7 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
 	if (IS_ERR(lpp->phy)) {
 		ret = PTR_ERR(lpp->phy);
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "couldn't get pcie-phy: %d\n", ret);
+			dev_err(dev, "Couldn't get pcie-phy: %d\n", ret);
 		return ret;
 	}
 
@@ -445,9 +445,11 @@ static int intel_pcie_rc_init(struct pcie_port *pp)
 	return intel_pcie_host_setup(lpp);
 }
 
-int intel_pcie_msi_init(struct pcie_port *pp)
+/*
+ * Dummy function so that DW core doesn't configure MSI
+ */
+static int intel_pcie_msi_init(struct pcie_port *pp)
 {
-	/* PCIe MSI/MSIx is handled by MSI in x86 processor */
 	return 0;
 }
 
@@ -508,19 +510,17 @@ static int intel_pcie_probe(struct platform_device *pdev)
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(dev, "cannot initialize host\n");
+		dev_err(dev, "Cannot initialize host\n");
 		return ret;
 	}
 
 	/*
 	 * Intel PCIe doesn't configure IO region, so set viewport
-	 * to not to perform IO region access.
+	 * to not perform IO region access.
 	 */
 	pci->num_viewport = data->num_viewport;
 
-	dev_info(dev, "Intel PCIe Root Complex Port init done\n");
-
-	return ret;
+	return 0;
 }
 
 static const struct dev_pm_ops intel_pcie_pm_ops = {
-- 
2.11.0

