Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4198672E2D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 02:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjASBbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 20:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjASBai (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 20:30:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D0649014;
        Wed, 18 Jan 2023 17:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091712; x=1705627712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GvU06Z85RmPFE/pi869emfsoWw0RS0LLYaPIuGFx11Q=;
  b=eR8wII3cosr/5+alDuR9kxOBLjt3BdeKpfKgPCZ5ypCO0qXyYfxusEIx
   7NufkMssC6tRILX5DoHYoE+9EhdoR7cu0Y1x/QU4VRXKiycg8+of4qgWd
   ca6jDk8eWR1cyG2rJo04h0scR1WuqfiRlh5usEQ2xp0H1v4dGOmqmIRLL
   F1RUP2OciVC3FqQPmUKl8lv7Dxu3CCnTEaJv+Duf1sHhsYWFQp27/CDE6
   aWfWQ1QiJdo+34pZt3WzUAUO6QkuzbJCi/rgrdQ5tidOK2J86WMVait5z
   6mf72wk3M7YZzK5+pz2Y0Q3xddn8VKG9OrzBlYhvh53I6Vn2BUY5peSzG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322847496"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322847496"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:28:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767995647"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767995647"
Received: from unknown (HELO fedora.sh.intel.com) ([10.238.175.104])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:28:26 -0800
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, lukas@wunner.de, kabel@kernel.org,
        mani@kernel.org, pali@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        russell.h.weight@intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        lee@kernel.org, gregkh@linuxfoundation.org,
        matthew.gerlach@linux.intel.com
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 05/12] fpga: dfl: register dfl-pci device into fpgahph driver
Date:   Wed, 18 Jan 2023 20:35:55 -0500
Message-Id: <20230119013602.607466-6-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230119013602.607466-1-tianfei.zhang@intel.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a registration of dfl-pci device into fpgahp driver by
fpgahp_register() API.

For Intel N3000 Card, FPGA devices like PFs/VFs and some ethernet
controllers are connected with a PCI switch, so the hotplug bridge
is the root hub of PCI device. This patch instances this hotplug
bridge as a hotplug controller.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/fpga/Kconfig   |  1 +
 drivers/fpga/dfl-pci.c | 77 ++++++++++++++++++++++++++++++++++++++----
 drivers/fpga/dfl.h     |  2 ++
 3 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 6ce143dafd04..2188c5658e06 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -213,6 +213,7 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
 config FPGA_DFL_PCI
 	tristate "FPGA DFL PCIe Device Driver"
 	depends on PCI && FPGA_DFL
+	depends on HOTPLUG_PCI_FPGA
 	help
 	  Select this option to enable PCIe driver for PCIe-based
 	  Field-Programmable Gate Array (FPGA) solutions which implement
diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 0914e7328b1a..0409cb30e563 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -23,6 +23,8 @@
 #include <linux/errno.h>
 #include <linux/aer.h>
 
+#include <linux/fpga/fpgahp_manager.h>
+
 #include "dfl.h"
 
 #define DRV_VERSION	"0.8"
@@ -40,6 +42,9 @@ struct cci_drvdata {
 	struct dfl_fpga_cdev *cdev;	/* container device */
 };
 
+static const struct fpgahp_manager_ops fpgahp_ops = {
+};
+
 static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
 {
 	if (pcim_iomap_regions(pcidev, BIT(0), DRV_NAME))
@@ -118,6 +123,15 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
 
+/*
+ * List the FPGA cards which have some ethernet controllers connected to a PCI
+ * switch like PAC N3000, used to find hotplug bridge for fpgahp driver.
+ */
+static const struct pci_device_id has_pci_switch_devids[] = {
+	{ PCI_VDEVICE(INTEL, PCIE_DEVICE_ID_INTEL_PAC_N3000) },
+	{}
+};
+
 static int cci_init_drvdata(struct pci_dev *pcidev)
 {
 	struct cci_drvdata *drvdata;
@@ -306,12 +320,33 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	return ret;
 }
 
+/*
+ * On N3000 Card, FPGA devices like PFs/VFs and some ethernet controllers
+ * are connected to a PCI switch, so the hotplug bridge on the root port of
+ * FPGA PF0 PCI device.
+ */
+static struct pci_dev *cci_find_hotplug_bridge(struct pci_dev *pcidev)
+{
+	struct pci_dev *hotplug_bridge;
+
+	if (!pci_match_id(has_pci_switch_devids, pcidev))
+		return pcidev;
+
+	hotplug_bridge = pcie_find_root_port(pcidev);
+	if (!hotplug_bridge)
+		return NULL;
+
+	return hotplug_bridge;
+}
+
 /* enumerate feature devices under pci device */
 static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 {
 	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
 	struct dfl_fpga_enum_info *info;
+	struct pci_dev *hotplug_bridge;
 	struct dfl_fpga_cdev *cdev;
+	struct fpgahp_manager *mgr;
 	int nvec, ret = 0;
 	int *irq_table;
 
@@ -346,23 +381,47 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 	if (ret)
 		goto irq_free_exit;
 
+	/* register hotplug bridge of PF0 device into fpgahp driver */
+	if (dev_is_pf(&pcidev->dev)) {
+		hotplug_bridge = cci_find_hotplug_bridge(pcidev);
+		if (!hotplug_bridge) {
+			dev_err(&pcidev->dev, "Hotplug bridge not found\n");
+			ret = -ENODEV;
+			goto irq_free_exit;
+		}
+
+		mgr = fpgahp_register(hotplug_bridge, dev_name(&pcidev->dev),
+				      &fpgahp_ops, pcidev);
+		if (IS_ERR(mgr)) {
+			dev_err(&pcidev->dev, "Registering fpga hotplug failed\n");
+			ret = PTR_ERR(mgr);
+			goto irq_free_exit;
+		}
+	}
+
 	/* start enumeration with prepared enumeration information */
 	cdev = dfl_fpga_feature_devs_enumerate(info);
 	if (IS_ERR(cdev)) {
 		dev_err(&pcidev->dev, "Enumeration failure\n");
 		ret = PTR_ERR(cdev);
-		goto irq_free_exit;
+		goto free_register;
 	}
 
+	if (dev_is_pf(&pcidev->dev))
+		cdev->fpgahp_mgr = mgr;
+
 	drvdata->cdev = cdev;
 
-irq_free_exit:
-	if (ret)
-		cci_pci_free_irq(pcidev);
 enum_info_free_exit:
 	dfl_fpga_enum_info_free(info);
-
 	return ret;
+
+free_register:
+	if (dev_is_pf(&pcidev->dev))
+		fpgahp_unregister(mgr);
+irq_free_exit:
+	cci_pci_free_irq(pcidev);
+	goto enum_info_free_exit;
 }
 
 static
@@ -444,8 +503,13 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
 
 static void cci_pci_remove(struct pci_dev *pcidev)
 {
-	if (dev_is_pf(&pcidev->dev))
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+	struct dfl_fpga_cdev *cdev = drvdata->cdev;
+
+	if (dev_is_pf(&pcidev->dev)) {
 		cci_pci_sriov_configure(pcidev, 0);
+		fpgahp_unregister(cdev->fpgahp_mgr);
+	}
 
 	cci_remove_feature_devs(pcidev);
 	pci_disable_pcie_error_reporting(pcidev);
@@ -464,3 +528,4 @@ module_pci_driver(cci_pci_driver);
 MODULE_DESCRIPTION("FPGA DFL PCIe Device Driver");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(FPGAHP);
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 06cfcd5e84bb..898c05c269fb 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -469,6 +469,7 @@ void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
  * @fme_dev: FME feature device under this container device.
  * @lock: mutex lock to protect the port device list.
  * @port_dev_list: list of all port feature devices under this container device.
+ * @fpgahp_mgr: fpga hotplug manager.
  * @released_port_num: released port number under this container device.
  */
 struct dfl_fpga_cdev {
@@ -477,6 +478,7 @@ struct dfl_fpga_cdev {
 	struct device *fme_dev;
 	struct mutex lock;
 	struct list_head port_dev_list;
+	struct fpgahp_manager *fpgahp_mgr;
 	int released_port_num;
 };
 
-- 
2.38.1

