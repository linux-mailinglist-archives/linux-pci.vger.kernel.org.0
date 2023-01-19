Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C78672E29
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 02:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjASBbi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 20:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjASBai (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 20:30:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB94743B;
        Wed, 18 Jan 2023 17:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091706; x=1705627706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KPGjabqA2xbyaF9SYja3ZNMTTS1jWgIeumEfuSq6gFg=;
  b=iju031K4Q2uddBw4xo2pPG6/1Cjt07E8yHy2ddzzEXC8YNeVEjidaNco
   TOKMyObUhCkmgfQZoMV6DaaoKUtkhMhbjgt10og/TbuxyAELhnHgoI2hg
   fgGnvEuDUa3roM2SeEnuemqf9XIHUXRbM17TEsS7T8Wmebck35MoWWdXO
   zoSFPpO4kpmqoQnwt9NMrKEgZaAefY65f8JxfH7KdswoAd16Uh2XiTHqx
   BBEr2hMSGakAjNh92LIWh5u2a93HSQ5bho5TG2wfUu73bLgJE5ZUWZ9ze
   k5+UGnAj/Ef3xUH4SnpmaJmr9+DaPLq57vqwCDDrxJLd1EjyROO7WUmsd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322847477"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322847477"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:28:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767995634"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767995634"
Received: from unknown (HELO fedora.sh.intel.com) ([10.238.175.104])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:28:20 -0800
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
Subject: [PATCH v1 04/12] PCI: hotplug: add FPGA PCI hotplug manager driver
Date:   Wed, 18 Jan 2023 20:35:54 -0500
Message-Id: <20230119013602.607466-5-tianfei.zhang@intel.com>
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

After burning a new FPGA/BMC image, the driver should stop the
current running FPGA image and load a new image from the flash
to FPGA. Before reloading a new image, the driver needs to remove
all of PCI devices like PFs/VFs and as well as any other types of
devices (platform, etc.) defined within the FPGA which are running
in the old image. To help manage the PCIe-based FPGA card, leverage
the PCIe hotplug framework to implement the card management during
loading the new FPGA image.

Introduce new APIs to register/unregister a PCI device into PCI
hotplug core. The fpgahp driver instances a hotplug controller and
then registers into pci hotplug core which leverages the hotplug_slot_ops
callbacks to manage the FPGA card.

The new data structure fpgahp_manager is used for a fpga hotplug manager
instance. The fpgahp_manager has some callbacks in fpgahp_manager_ops.
The hotplug_prepare callback does some preparations, like removing
sub-devices below the PCI device to avoid data corruption during the
hotplug.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 MAINTAINERS                         |   8 +
 drivers/pci/hotplug/Kconfig         |  14 ++
 drivers/pci/hotplug/Makefile        |   1 +
 drivers/pci/hotplug/fpgahp.c        | 269 ++++++++++++++++++++++++++++
 include/linux/fpga/fpgahp_manager.h |  62 +++++++
 5 files changed, 354 insertions(+)
 create mode 100644 drivers/pci/hotplug/fpgahp.c
 create mode 100644 include/linux/fpga/fpgahp_manager.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 42fc47c6edfd..7ac38b7cc44c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8163,6 +8163,14 @@ F:	drivers/uio/uio_dfl.c
 F:	include/linux/dfl.h
 F:	include/uapi/linux/fpga-dfl.h
 
+FPGA PCI Hotplug Driver
+M:	Tianfei Zhang <tianfei.zhang@intel.com>
+L:	linux-fpga@vger.kernel.org
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	drivers/pci/hotplug/fpgahp.c
+F:	include/linux/fpga/fpgahp_manager.h
+
 FPGA MANAGER FRAMEWORK
 M:	Moritz Fischer <mdf@kernel.org>
 M:	Wu Hao <hao.wu@intel.com>
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 48113b210cf9..57a20e60afd4 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -61,6 +61,20 @@ config HOTPLUG_PCI_ACPI
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_FPGA
+	tristate "FPGA PCI Hotplug Manager Driver"
+	depends on HOTPLUG_PCI_PCIE
+	help
+          Select this option to enable FPGA hotplug driver for PCIe-based
+          Field-Programmable Gate Array (FPGA) solutions. This driver provides
+          sysfs files for userspace applications to manager the FPGA card like
+          load a new FPGA image, reset the FPGA card.
+
+          To compile this driver as a module, choose M here: the
+          module will be called fpgahp.
+
+          When in doubt, say N.
+
 config HOTPLUG_PCI_ACPI_IBM
 	tristate "ACPI PCI Hotplug driver IBM extensions"
 	depends on HOTPLUG_PCI_ACPI
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 5196983220df..b055592924ea 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_HOTPLUG_PCI_POWERNV)	+= pnv-php.o
 obj-$(CONFIG_HOTPLUG_PCI_RPA)		+= rpaphp.o
 obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
+obj-$(CONFIG_HOTPLUG_PCI_FPGA)	        += fpgahp.o
 obj-$(CONFIG_HOTPLUG_PCI_S390)		+= s390_pci_hpc.o
 
 # acpiphp_ibm extends acpiphp, so should be linked afterwards.
diff --git a/drivers/pci/hotplug/fpgahp.c b/drivers/pci/hotplug/fpgahp.c
new file mode 100644
index 000000000000..71cee65383e2
--- /dev/null
+++ b/drivers/pci/hotplug/fpgahp.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA PCI Hotplug Manager Driver
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+
+#include <linux/fpga/fpgahp_manager.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+
+#include "pciehp.h"
+
+/*
+ * a global fhpc_list is used to manage all
+ * registered FPGA hotplug controllers.
+ */
+static LIST_HEAD(fhpc_list);
+static DEFINE_MUTEX(fhpc_lock);
+
+struct fpgahp_controller {
+	struct list_head node;
+	struct fpgahp_manager mgr;
+	struct pcie_device *pcie;
+	struct controller ctrl;
+	struct pci_dev *hotplug_bridge;
+};
+
+static void fpgahp_add_fhpc(struct fpgahp_controller *fhpc)
+{
+	mutex_lock(&fhpc_lock);
+	list_add_tail(&fhpc->node, &fhpc_list);
+	mutex_unlock(&fhpc_lock);
+}
+
+static int fpgahp_init_controller(struct controller *ctrl, struct pcie_device *dev)
+{
+	struct pci_dev *hotplug_bridge = dev->port;
+	u32 slot_cap;
+
+	ctrl->pcie = dev;
+
+	if (pcie_capability_read_dword(hotplug_bridge, PCI_EXP_SLTCAP, &slot_cap))
+		return -EINVAL;
+
+	ctrl->slot_cap = slot_cap;
+
+	return 0;
+}
+
+static const struct hotplug_slot_ops fpgahp_slot_ops = {
+};
+
+static int fpgahp_init_slot(struct controller *ctrl)
+{
+	char name[SLOT_NAME_SIZE];
+	struct pci_dev *hotplug_bridge = ctrl->pcie->port;
+	int ret;
+
+	snprintf(name, sizeof(name), "%u", PSN(ctrl));
+
+	ctrl->hotplug_slot.ops = &fpgahp_slot_ops;
+
+	ret = pci_hp_register(&ctrl->hotplug_slot, hotplug_bridge->subordinate,
+			      PCI_SLOT(hotplug_bridge->devfn), name);
+	if (ret) {
+		ctrl_err(ctrl, "Register PCI hotplug core failed with error %d\n", ret);
+		return ret;
+	}
+
+	ctrl_info(ctrl, "Slot [%s] registered\n", hotplug_slot_name(&ctrl->hotplug_slot));
+
+	return 0;
+}
+
+static int
+fpgahp_create_new_fhpc(struct fpgahp_controller *fhpc, struct pci_dev *hotplug_bridge,
+		       const char *name, const struct fpgahp_manager_ops *ops)
+{
+	struct fpgahp_manager *mgr = &fhpc->mgr;
+	struct controller *ctrl = &fhpc->ctrl;
+	struct pcie_device *pcie;
+	int ret;
+
+	pcie = kzalloc(sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->port = hotplug_bridge;
+	fhpc->hotplug_bridge = hotplug_bridge;
+	fhpc->pcie = pcie;
+
+	ret = fpgahp_init_controller(ctrl, pcie);
+	if (ret)
+		goto free_pcie;
+
+	ret = fpgahp_init_slot(ctrl);
+	if (ret) {
+		if (ret == -EBUSY)
+			ctrl_warn(ctrl, "Slot already registered by another hotplug driver\n");
+		else
+			ctrl_err(ctrl, "Slot initialization failed (%d)\n", ret);
+		goto free_pcie;
+	}
+
+	mutex_init(&mgr->lock);
+
+	fpgahp_add_fhpc(fhpc);
+
+	return 0;
+
+free_pcie:
+	kfree(pcie);
+	return ret;
+}
+
+static struct fpgahp_controller *
+fpgahp_find_exist_fhpc(struct pci_dev *hotplug_bridge,
+		       struct pci_dev *pcidev, const struct fpgahp_manager_ops *ops)
+{
+	struct fpgahp_controller *iter, *fhpc = NULL;
+
+	mutex_lock(&fhpc_lock);
+
+	list_for_each_entry(iter, &fhpc_list, node) {
+		struct controller *ctrl = &iter->ctrl;
+
+		if (!iter->mgr.registered)
+			continue;
+
+		if (iter->hotplug_bridge == hotplug_bridge &&
+		    iter->mgr.priv == pcidev && iter->mgr.ops == ops) {
+			fhpc = iter;
+			ctrl_dbg(ctrl, "Found existing fhpc slot(%s)\n", slot_name(ctrl));
+			break;
+		}
+	}
+
+	mutex_unlock(&fhpc_lock);
+
+	return fhpc;
+}
+
+static struct fpgahp_controller *fpgahp_reclaim_fhpc(struct pci_dev *hotplug_bridge)
+{
+	struct fpgahp_controller *iter, *fhpc = NULL;
+
+	mutex_lock(&fhpc_lock);
+
+	list_for_each_entry(iter, &fhpc_list, node) {
+		struct controller *ctrl = &iter->ctrl;
+
+		if (iter->mgr.registered)
+			continue;
+
+		/* reclaim unused fhpc, will reuse it later */
+		if (iter->hotplug_bridge == hotplug_bridge) {
+			fhpc = iter;
+			ctrl_dbg(ctrl, "Found unused fhpc, reuse slot(%s)\n", slot_name(ctrl));
+			break;
+		}
+	}
+
+	mutex_unlock(&fhpc_lock);
+
+	return fhpc;
+}
+
+static void fpgahp_remove_fhpc(void)
+{
+	struct fpgahp_controller *fhpc, *tmp;
+
+	mutex_lock(&fhpc_lock);
+
+	list_for_each_entry_safe(fhpc, tmp, &fhpc_list, node) {
+		struct controller *ctrl = &fhpc->ctrl;
+
+		list_del(&fhpc->node);
+		pci_hp_deregister(&ctrl->hotplug_slot);
+		kfree(fhpc);
+	}
+
+	mutex_unlock(&fhpc_lock);
+}
+
+/**
+ * fpgahp_register - register FPGA device into fpgahp driver
+ * @hotplug_bridge: the hotplug bridge of the FPGA device
+ * @name: the name of the FPGA device
+ * @ops: pointer to structure of fpgahp manager ops
+ * @priv: private data for FPGA device
+ *
+ * Return: pointer to struct fpgahp_manager pointer or ERR_PTR()
+ */
+struct fpgahp_manager *fpgahp_register(struct pci_dev *hotplug_bridge, const char *name,
+				       const struct fpgahp_manager_ops *ops, void *priv)
+{
+	struct fpgahp_controller *fhpc;
+	struct pci_dev *pcidev = priv;
+	int ret;
+
+	if (!hotplug_bridge || !ops || !pcidev)
+		return ERR_PTR(-EINVAL);
+
+	dev_dbg(&pcidev->dev, "Register hotplug bridge: %04x:%02x:%02x\n",
+		pci_domain_nr(hotplug_bridge->bus), hotplug_bridge->bus->number,
+		PCI_SLOT(hotplug_bridge->devfn));
+
+	/* find existing matching fpgahp_controller */
+	fhpc = fpgahp_find_exist_fhpc(hotplug_bridge, pcidev, ops);
+	if (fhpc)
+		return &fhpc->mgr;
+
+	/* can it reuse the free fpgahp_controller? */
+	fhpc = fpgahp_reclaim_fhpc(hotplug_bridge);
+	if (fhpc)
+		goto reuse;
+
+	fhpc = kzalloc(sizeof(*fhpc), GFP_KERNEL);
+	if (!fhpc)
+		return ERR_PTR(-ENOMEM);
+
+	ret = fpgahp_create_new_fhpc(fhpc, hotplug_bridge, name, ops);
+	if (ret) {
+		kfree(fhpc);
+		return ERR_PTR(ret);
+	}
+
+reuse:
+	mutex_lock(&fhpc->mgr.lock);
+	fhpc->mgr.ops = ops;
+	fhpc->mgr.name = name;
+	fhpc->mgr.priv = pcidev;
+	fhpc->mgr.registered = true;
+	fhpc->mgr.state = FPGAHP_MGR_UNKNOWN;
+	mutex_unlock(&fhpc->mgr.lock);
+
+	return &fhpc->mgr;
+}
+EXPORT_SYMBOL_NS_GPL(fpgahp_register, FPGAHP);
+
+/**
+ * fpgahp_unregister - unregister FPGA device from fpgahp driver
+ * @mgr: point to the fpgahp_manager
+ */
+void fpgahp_unregister(struct fpgahp_manager *mgr)
+{
+	mutex_lock(&mgr->lock);
+	mgr->registered = false;
+	mutex_unlock(&mgr->lock);
+}
+EXPORT_SYMBOL_NS_GPL(fpgahp_unregister, FPGAHP);
+
+static int __init fpgahp_init(void)
+{
+	return 0;
+}
+module_init(fpgahp_init);
+
+static void __exit fpgahp_exit(void)
+{
+	fpgahp_remove_fhpc();
+}
+module_exit(fpgahp_exit);
+
+MODULE_DESCRIPTION("FPGA PCI Hotplug Manager Driver");
+MODULE_AUTHOR("Tianfei Zhang <tianfei.zhang@intel.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/fpga/fpgahp_manager.h b/include/linux/fpga/fpgahp_manager.h
new file mode 100644
index 000000000000..5e31877f03de
--- /dev/null
+++ b/include/linux/fpga/fpgahp_manager.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver Header File for FPGA PCI Hotplug Driver
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+#ifndef _LINUX_FPGAHP_MANAGER_H
+#define _LINUX_FPGAHP_MANAGER_H
+
+#include <linux/mutex.h>
+
+struct pci_dev;
+struct fpgahp_manager;
+
+/**
+ * struct fpgahp_manager_ops - fpgahp manager specific operations
+ * @hotplug_prepare: Required: hotplug prepare like removing subdevices
+ *                   below the PCI device.
+ */
+struct fpgahp_manager_ops {
+	int (*hotplug_prepare)(struct fpgahp_manager *mgr);
+};
+
+/**
+ * enum fpgahp_manager_states - FPGA hotplug states
+ * @FPGAHP_MGR_UNKNOWN: can't determine state
+ * @FPGAHP_MGR_LOADING: image loading
+ * @FPGAHP_MGR_LOAD_DONE: image load done
+ * @FPGAHP_MGR_HP_FAIL: hotplug failed
+ */
+enum fpgahp_manager_states {
+	FPGAHP_MGR_UNKNOWN,
+	FPGAHP_MGR_LOADING,
+	FPGAHP_MGR_LOAD_DONE,
+	FPGAHP_MGR_HP_FAIL,
+};
+
+/**
+ * struct fpgahp_manager - represent a FPGA hotplug manager instance
+ *
+ * @lock: mutex to protect fpgahp manager data
+ * @priv: private data for fpgahp manager
+ * @ops: ops of this fpgahp_manager
+ * @state: the status of fpgahp_manager
+ * @name: name of the fpgahp_manager
+ * @registered: register status
+ */
+struct fpgahp_manager {
+	struct mutex lock; /* protect registered state of fpgahp_manager */
+	void *priv;
+	const struct fpgahp_manager_ops *ops;
+	enum fpgahp_manager_states state;
+	const char *name;
+	bool registered;
+};
+
+struct fpgahp_manager *fpgahp_register(struct pci_dev *hotplug_bridge,
+				       const char *name, const struct fpgahp_manager_ops *ops,
+				       void *priv);
+void fpgahp_unregister(struct fpgahp_manager *mgr);
+
+#endif
-- 
2.38.1

