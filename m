Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2BE605173
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 22:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiJSUln (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 16:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiJSUlj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 16:41:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5229824970;
        Wed, 19 Oct 2022 13:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4BB1619D6;
        Wed, 19 Oct 2022 20:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B70C433D6;
        Wed, 19 Oct 2022 20:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666212096;
        bh=lUWk0vsnUCKbFjFFTfyN/ZPpqIw6YT7KHZr833O+NQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XxJfWPM4XRoSUCQS73X82fu4kF4xNImv8OKii8rPc5zLIiAe96oPNrPbNXeHuF8px
         JJDShX793FVRgdNfEl+rj2K++vS0EreNkw/HIu2l68eFdXMGWYTbAmONnmweSraex8
         /4X53TMj7/oSZxryOoAx3AQnbmorQWoDuLqe2NpY3sQ69OSGenHkGHdhfv8/rM3MdT
         oUR0vKskby0JUrXmhALMGgqaiDivyJl9EB65hlBoLdRJNzFboAdt0+Q0g2/Ke3xNaS
         nuMrrhxIYl11G+WWuFWlgsMsYFQt8+XFiZ9NWWCn12Bxpda6dRJD9AptnOTp4hV/e4
         /L5TErntJ+5hQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Stefan Roese <sr@denx.de>, Lukas Wunner <lukas@wunner.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/3] PCI/portdrv: Squash into portdrv.c
Date:   Wed, 19 Oct 2022 15:41:25 -0500
Message-Id: <20221019204127.44463-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019204127.44463-1-helgaas@kernel.org>
References: <20221019204127.44463-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Squash portdrv_core.c and portdrv_pci.c into portdrv.c to make it easier to
find things.  The whole thing is less than 1000 lines, and it's a pain to
bounce back and forth between two files.

Several portdrv_core.c functions were non-static because they were
referenced from portdrv_pci.c.  Make them static since they're now all in
portdrv.c.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/Makefile                     |   2 +-
 .../pci/pcie/{portdrv_core.c => portdrv.c}    | 252 +++++++++++++++++-
 drivers/pci/pcie/portdrv.h                    |  10 -
 drivers/pci/pcie/portdrv_pci.c                | 252 ------------------
 4 files changed, 244 insertions(+), 272 deletions(-)
 rename drivers/pci/pcie/{portdrv_core.c => portdrv.c} (70%)
 delete mode 100644 drivers/pci/pcie/portdrv_pci.c

diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 5783a2f79e6a..8de4ed5f98f1 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for PCI Express features and port driver
 
-pcieportdrv-y			:= portdrv_core.o portdrv_pci.o rcec.o
+pcieportdrv-y			:= portdrv.o rcec.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv.c
similarity index 70%
rename from drivers/pci/pcie/portdrv_core.c
rename to drivers/pci/pcie/portdrv.c
index 1ac7fec47d6f..0b4a1f9c2a6b 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Purpose:	PCI Express Port Bus Driver's Core Functions
+ * Purpose:	PCI Express Port Bus Driver
  *
  * Copyright (C) 2004 Intel
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
  */
 
+#include <linux/dmi.h>
+#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
@@ -308,7 +310,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
  * Allocate the port extension structure and register services associated with
  * the port.
  */
-int pcie_port_device_register(struct pci_dev *dev)
+static int pcie_port_device_register(struct pci_dev *dev)
 {
 	int status, capabilities, i, nr_service;
 	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
@@ -362,7 +364,7 @@ int pcie_port_device_register(struct pci_dev *dev)
 
 typedef int (*pcie_callback_t)(struct pcie_device *);
 
-int pcie_port_device_iter(struct device *dev, void *data)
+static int pcie_port_device_iter(struct device *dev, void *data)
 {
 	struct pcie_port_service_driver *service_driver;
 	size_t offset = *(size_t *)data;
@@ -382,13 +384,13 @@ int pcie_port_device_iter(struct device *dev, void *data)
  * pcie_port_device_suspend - suspend port services associated with a PCIe port
  * @dev: PCI Express port to handle
  */
-int pcie_port_device_suspend(struct device *dev)
+static int pcie_port_device_suspend(struct device *dev)
 {
 	size_t off = offsetof(struct pcie_port_service_driver, suspend);
 	return device_for_each_child(dev, &off, pcie_port_device_iter);
 }
 
-int pcie_port_device_resume_noirq(struct device *dev)
+static int pcie_port_device_resume_noirq(struct device *dev)
 {
 	size_t off = offsetof(struct pcie_port_service_driver, resume_noirq);
 	return device_for_each_child(dev, &off, pcie_port_device_iter);
@@ -398,7 +400,7 @@ int pcie_port_device_resume_noirq(struct device *dev)
  * pcie_port_device_resume - resume port services associated with a PCIe port
  * @dev: PCI Express port to handle
  */
-int pcie_port_device_resume(struct device *dev)
+static int pcie_port_device_resume(struct device *dev)
 {
 	size_t off = offsetof(struct pcie_port_service_driver, resume);
 	return device_for_each_child(dev, &off, pcie_port_device_iter);
@@ -408,7 +410,7 @@ int pcie_port_device_resume(struct device *dev)
  * pcie_port_device_runtime_suspend - runtime suspend port services
  * @dev: PCI Express port to handle
  */
-int pcie_port_device_runtime_suspend(struct device *dev)
+static int pcie_port_device_runtime_suspend(struct device *dev)
 {
 	size_t off = offsetof(struct pcie_port_service_driver, runtime_suspend);
 	return device_for_each_child(dev, &off, pcie_port_device_iter);
@@ -418,7 +420,7 @@ int pcie_port_device_runtime_suspend(struct device *dev)
  * pcie_port_device_runtime_resume - runtime resume port services
  * @dev: PCI Express port to handle
  */
-int pcie_port_device_runtime_resume(struct device *dev)
+static int pcie_port_device_runtime_resume(struct device *dev)
 {
 	size_t off = offsetof(struct pcie_port_service_driver, runtime_resume);
 	return device_for_each_child(dev, &off, pcie_port_device_iter);
@@ -482,7 +484,7 @@ EXPORT_SYMBOL_GPL(pcie_port_find_device);
  * Remove PCI Express port service devices associated with given port and
  * disable MSI-X or MSI for the port.
  */
-void pcie_port_device_remove(struct pci_dev *dev)
+static void pcie_port_device_remove(struct pci_dev *dev)
 {
 	device_for_each_child(&dev->dev, NULL, remove_iter);
 	pci_free_irq_vectors(dev);
@@ -584,3 +586,235 @@ void pcie_port_service_unregister(struct pcie_port_service_driver *drv)
 	driver_unregister(&drv->driver);
 }
 EXPORT_SYMBOL(pcie_port_service_unregister);
+
+/* If this switch is set, PCIe port native services should not be enabled. */
+bool pcie_ports_disabled;
+
+/*
+ * If the user specified "pcie_ports=native", use the PCIe services regardless
+ * of whether the platform has given us permission.  On ACPI systems, this
+ * means we ignore _OSC.
+ */
+bool pcie_ports_native;
+
+/*
+ * If the user specified "pcie_ports=dpc-native", use the Linux DPC PCIe
+ * service even if the platform hasn't given us permission.
+ */
+bool pcie_ports_dpc_native;
+
+static int __init pcie_port_setup(char *str)
+{
+	if (!strncmp(str, "compat", 6))
+		pcie_ports_disabled = true;
+	else if (!strncmp(str, "native", 6))
+		pcie_ports_native = true;
+	else if (!strncmp(str, "dpc-native", 10))
+		pcie_ports_dpc_native = true;
+
+	return 1;
+}
+__setup("pcie_ports=", pcie_port_setup);
+
+/* global data */
+
+#ifdef CONFIG_PM
+static int pcie_port_runtime_suspend(struct device *dev)
+{
+	if (!to_pci_dev(dev)->bridge_d3)
+		return -EBUSY;
+
+	return pcie_port_device_runtime_suspend(dev);
+}
+
+static int pcie_port_runtime_idle(struct device *dev)
+{
+	/*
+	 * Assume the PCI core has set bridge_d3 whenever it thinks the port
+	 * should be good to go to D3.  Everything else, including moving
+	 * the port to D3, is handled by the PCI core.
+	 */
+	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
+}
+
+static const struct dev_pm_ops pcie_portdrv_pm_ops = {
+	.suspend	= pcie_port_device_suspend,
+	.resume_noirq	= pcie_port_device_resume_noirq,
+	.resume		= pcie_port_device_resume,
+	.freeze		= pcie_port_device_suspend,
+	.thaw		= pcie_port_device_resume,
+	.poweroff	= pcie_port_device_suspend,
+	.restore_noirq	= pcie_port_device_resume_noirq,
+	.restore	= pcie_port_device_resume,
+	.runtime_suspend = pcie_port_runtime_suspend,
+	.runtime_resume	= pcie_port_device_runtime_resume,
+	.runtime_idle	= pcie_port_runtime_idle,
+};
+
+#define PCIE_PORTDRV_PM_OPS	(&pcie_portdrv_pm_ops)
+
+#else /* !PM */
+
+#define PCIE_PORTDRV_PM_OPS	NULL
+#endif /* !PM */
+
+/*
+ * pcie_portdrv_probe - Probe PCI-Express port devices
+ * @dev: PCI-Express port device being probed
+ *
+ * If detected invokes the pcie_port_device_register() method for
+ * this port device.
+ *
+ */
+static int pcie_portdrv_probe(struct pci_dev *dev,
+					const struct pci_device_id *id)
+{
+	int type = pci_pcie_type(dev);
+	int status;
+
+	if (!pci_is_pcie(dev) ||
+	    ((type != PCI_EXP_TYPE_ROOT_PORT) &&
+	     (type != PCI_EXP_TYPE_UPSTREAM) &&
+	     (type != PCI_EXP_TYPE_DOWNSTREAM) &&
+	     (type != PCI_EXP_TYPE_RC_EC)))
+		return -ENODEV;
+
+	if (type == PCI_EXP_TYPE_RC_EC)
+		pcie_link_rcec(dev);
+
+	status = pcie_port_device_register(dev);
+	if (status)
+		return status;
+
+	pci_save_state(dev);
+
+	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
+					   DPM_FLAG_SMART_SUSPEND);
+
+	if (pci_bridge_d3_possible(dev)) {
+		/*
+		 * Keep the port resumed 100ms to make sure things like
+		 * config space accesses from userspace (lspci) will not
+		 * cause the port to repeatedly suspend and resume.
+		 */
+		pm_runtime_set_autosuspend_delay(&dev->dev, 100);
+		pm_runtime_use_autosuspend(&dev->dev);
+		pm_runtime_mark_last_busy(&dev->dev);
+		pm_runtime_put_autosuspend(&dev->dev);
+		pm_runtime_allow(&dev->dev);
+	}
+
+	return 0;
+}
+
+static void pcie_portdrv_remove(struct pci_dev *dev)
+{
+	if (pci_bridge_d3_possible(dev)) {
+		pm_runtime_forbid(&dev->dev);
+		pm_runtime_get_noresume(&dev->dev);
+		pm_runtime_dont_use_autosuspend(&dev->dev);
+	}
+
+	pcie_port_device_remove(dev);
+}
+
+static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
+					pci_channel_state_t error)
+{
+	if (error == pci_channel_io_frozen)
+		return PCI_ERS_RESULT_NEED_RESET;
+	return PCI_ERS_RESULT_CAN_RECOVER;
+}
+
+static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
+{
+	size_t off = offsetof(struct pcie_port_service_driver, slot_reset);
+	device_for_each_child(&dev->dev, &off, pcie_port_device_iter);
+
+	pci_restore_state(dev);
+	pci_save_state(dev);
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
+{
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+/*
+ * LINUX Device Driver Model
+ */
+static const struct pci_device_id port_pci_ids[] = {
+	/* handle any PCI-Express port */
+	{ PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI_NORMAL, ~0) },
+	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
+	{ PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI_SUBTRACTIVE, ~0) },
+	/* handle any Root Complex Event Collector */
+	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0) },
+	{ },
+};
+
+static const struct pci_error_handlers pcie_portdrv_err_handler = {
+	.error_detected = pcie_portdrv_error_detected,
+	.slot_reset = pcie_portdrv_slot_reset,
+	.mmio_enabled = pcie_portdrv_mmio_enabled,
+};
+
+static struct pci_driver pcie_portdriver = {
+	.name		= "pcieport",
+	.id_table	= &port_pci_ids[0],
+
+	.probe		= pcie_portdrv_probe,
+	.remove		= pcie_portdrv_remove,
+	.shutdown	= pcie_portdrv_remove,
+
+	.err_handler	= &pcie_portdrv_err_handler,
+
+	.driver_managed_dma = true,
+
+	.driver.pm	= PCIE_PORTDRV_PM_OPS,
+};
+
+static int __init dmi_pcie_pme_disable_msi(const struct dmi_system_id *d)
+{
+	pr_notice("%s detected: will not use MSI for PCIe PME signaling\n",
+		  d->ident);
+	pcie_pme_disable_msi();
+	return 0;
+}
+
+static const struct dmi_system_id pcie_portdrv_dmi_table[] __initconst = {
+	/*
+	 * Boxes that should not use MSI for PCIe PME signaling.
+	 */
+	{
+	 .callback = dmi_pcie_pme_disable_msi,
+	 .ident = "MSI Wind U-100",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR,
+				"MICRO-STAR INTERNATIONAL CO., LTD"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "U-100"),
+		     },
+	 },
+	 {}
+};
+
+static void __init pcie_init_services(void)
+{
+	pcie_aer_init();
+	pcie_pme_init();
+	pcie_dpc_init();
+	pcie_hp_init();
+}
+
+static int __init pcie_portdrv_init(void)
+{
+	if (pcie_ports_disabled)
+		return -EACCES;
+
+	pcie_init_services();
+	dmi_check_system(pcie_portdrv_dmi_table);
+
+	return pci_register_driver(&pcie_portdriver);
+}
+device_initcall(pcie_portdrv_init);
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 0ef4bf5f811d..bf380bcea6a5 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -108,16 +108,6 @@ void pcie_port_service_unregister(struct pcie_port_service_driver *new);
 #define get_descriptor_id(type, service) (((type - 4) << 8) | service)
 
 extern struct bus_type pcie_port_bus_type;
-int pcie_port_device_register(struct pci_dev *dev);
-int pcie_port_device_iter(struct device *dev, void *data);
-#ifdef CONFIG_PM
-int pcie_port_device_suspend(struct device *dev);
-int pcie_port_device_resume_noirq(struct device *dev);
-int pcie_port_device_resume(struct device *dev);
-int pcie_port_device_runtime_suspend(struct device *dev);
-int pcie_port_device_runtime_resume(struct device *dev);
-#endif
-void pcie_port_device_remove(struct pci_dev *dev);
 
 struct pci_dev;
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
deleted file mode 100644
index 7f8788a970ae..000000000000
--- a/drivers/pci/pcie/portdrv_pci.c
+++ /dev/null
@@ -1,252 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Purpose:	PCI Express Port Bus Driver
- * Author:	Tom Nguyen <tom.l.nguyen@intel.com>
- *
- * Copyright (C) 2004 Intel
- * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
- */
-
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/pm.h>
-#include <linux/pm_runtime.h>
-#include <linux/init.h>
-#include <linux/aer.h>
-#include <linux/dmi.h>
-
-#include "../pci.h"
-#include "portdrv.h"
-
-/* If this switch is set, PCIe port native services should not be enabled. */
-bool pcie_ports_disabled;
-
-/*
- * If the user specified "pcie_ports=native", use the PCIe services regardless
- * of whether the platform has given us permission.  On ACPI systems, this
- * means we ignore _OSC.
- */
-bool pcie_ports_native;
-
-/*
- * If the user specified "pcie_ports=dpc-native", use the Linux DPC PCIe
- * service even if the platform hasn't given us permission.
- */
-bool pcie_ports_dpc_native;
-
-static int __init pcie_port_setup(char *str)
-{
-	if (!strncmp(str, "compat", 6))
-		pcie_ports_disabled = true;
-	else if (!strncmp(str, "native", 6))
-		pcie_ports_native = true;
-	else if (!strncmp(str, "dpc-native", 10))
-		pcie_ports_dpc_native = true;
-
-	return 1;
-}
-__setup("pcie_ports=", pcie_port_setup);
-
-/* global data */
-
-#ifdef CONFIG_PM
-static int pcie_port_runtime_suspend(struct device *dev)
-{
-	if (!to_pci_dev(dev)->bridge_d3)
-		return -EBUSY;
-
-	return pcie_port_device_runtime_suspend(dev);
-}
-
-static int pcie_port_runtime_idle(struct device *dev)
-{
-	/*
-	 * Assume the PCI core has set bridge_d3 whenever it thinks the port
-	 * should be good to go to D3.  Everything else, including moving
-	 * the port to D3, is handled by the PCI core.
-	 */
-	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
-}
-
-static const struct dev_pm_ops pcie_portdrv_pm_ops = {
-	.suspend	= pcie_port_device_suspend,
-	.resume_noirq	= pcie_port_device_resume_noirq,
-	.resume		= pcie_port_device_resume,
-	.freeze		= pcie_port_device_suspend,
-	.thaw		= pcie_port_device_resume,
-	.poweroff	= pcie_port_device_suspend,
-	.restore_noirq	= pcie_port_device_resume_noirq,
-	.restore	= pcie_port_device_resume,
-	.runtime_suspend = pcie_port_runtime_suspend,
-	.runtime_resume	= pcie_port_device_runtime_resume,
-	.runtime_idle	= pcie_port_runtime_idle,
-};
-
-#define PCIE_PORTDRV_PM_OPS	(&pcie_portdrv_pm_ops)
-
-#else /* !PM */
-
-#define PCIE_PORTDRV_PM_OPS	NULL
-#endif /* !PM */
-
-/*
- * pcie_portdrv_probe - Probe PCI-Express port devices
- * @dev: PCI-Express port device being probed
- *
- * If detected invokes the pcie_port_device_register() method for
- * this port device.
- *
- */
-static int pcie_portdrv_probe(struct pci_dev *dev,
-					const struct pci_device_id *id)
-{
-	int type = pci_pcie_type(dev);
-	int status;
-
-	if (!pci_is_pcie(dev) ||
-	    ((type != PCI_EXP_TYPE_ROOT_PORT) &&
-	     (type != PCI_EXP_TYPE_UPSTREAM) &&
-	     (type != PCI_EXP_TYPE_DOWNSTREAM) &&
-	     (type != PCI_EXP_TYPE_RC_EC)))
-		return -ENODEV;
-
-	if (type == PCI_EXP_TYPE_RC_EC)
-		pcie_link_rcec(dev);
-
-	status = pcie_port_device_register(dev);
-	if (status)
-		return status;
-
-	pci_save_state(dev);
-
-	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
-					   DPM_FLAG_SMART_SUSPEND);
-
-	if (pci_bridge_d3_possible(dev)) {
-		/*
-		 * Keep the port resumed 100ms to make sure things like
-		 * config space accesses from userspace (lspci) will not
-		 * cause the port to repeatedly suspend and resume.
-		 */
-		pm_runtime_set_autosuspend_delay(&dev->dev, 100);
-		pm_runtime_use_autosuspend(&dev->dev);
-		pm_runtime_mark_last_busy(&dev->dev);
-		pm_runtime_put_autosuspend(&dev->dev);
-		pm_runtime_allow(&dev->dev);
-	}
-
-	return 0;
-}
-
-static void pcie_portdrv_remove(struct pci_dev *dev)
-{
-	if (pci_bridge_d3_possible(dev)) {
-		pm_runtime_forbid(&dev->dev);
-		pm_runtime_get_noresume(&dev->dev);
-		pm_runtime_dont_use_autosuspend(&dev->dev);
-	}
-
-	pcie_port_device_remove(dev);
-}
-
-static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
-					pci_channel_state_t error)
-{
-	if (error == pci_channel_io_frozen)
-		return PCI_ERS_RESULT_NEED_RESET;
-	return PCI_ERS_RESULT_CAN_RECOVER;
-}
-
-static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
-{
-	size_t off = offsetof(struct pcie_port_service_driver, slot_reset);
-	device_for_each_child(&dev->dev, &off, pcie_port_device_iter);
-
-	pci_restore_state(dev);
-	pci_save_state(dev);
-	return PCI_ERS_RESULT_RECOVERED;
-}
-
-static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
-{
-	return PCI_ERS_RESULT_RECOVERED;
-}
-
-/*
- * LINUX Device Driver Model
- */
-static const struct pci_device_id port_pci_ids[] = {
-	/* handle any PCI-Express port */
-	{ PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI_NORMAL, ~0) },
-	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
-	{ PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI_SUBTRACTIVE, ~0) },
-	/* handle any Root Complex Event Collector */
-	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0) },
-	{ },
-};
-
-static const struct pci_error_handlers pcie_portdrv_err_handler = {
-	.error_detected = pcie_portdrv_error_detected,
-	.slot_reset = pcie_portdrv_slot_reset,
-	.mmio_enabled = pcie_portdrv_mmio_enabled,
-};
-
-static struct pci_driver pcie_portdriver = {
-	.name		= "pcieport",
-	.id_table	= &port_pci_ids[0],
-
-	.probe		= pcie_portdrv_probe,
-	.remove		= pcie_portdrv_remove,
-	.shutdown	= pcie_portdrv_remove,
-
-	.err_handler	= &pcie_portdrv_err_handler,
-
-	.driver_managed_dma = true,
-
-	.driver.pm	= PCIE_PORTDRV_PM_OPS,
-};
-
-static int __init dmi_pcie_pme_disable_msi(const struct dmi_system_id *d)
-{
-	pr_notice("%s detected: will not use MSI for PCIe PME signaling\n",
-		  d->ident);
-	pcie_pme_disable_msi();
-	return 0;
-}
-
-static const struct dmi_system_id pcie_portdrv_dmi_table[] __initconst = {
-	/*
-	 * Boxes that should not use MSI for PCIe PME signaling.
-	 */
-	{
-	 .callback = dmi_pcie_pme_disable_msi,
-	 .ident = "MSI Wind U-100",
-	 .matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR,
-				"MICRO-STAR INTERNATIONAL CO., LTD"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "U-100"),
-		     },
-	 },
-	 {}
-};
-
-static void __init pcie_init_services(void)
-{
-	pcie_aer_init();
-	pcie_pme_init();
-	pcie_dpc_init();
-	pcie_hp_init();
-}
-
-static int __init pcie_portdrv_init(void)
-{
-	if (pcie_ports_disabled)
-		return -EACCES;
-
-	pcie_init_services();
-	dmi_check_system(pcie_portdrv_dmi_table);
-
-	return pci_register_driver(&pcie_portdriver);
-}
-device_initcall(pcie_portdrv_init);
-- 
2.25.1

