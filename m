Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945DC672E50
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 02:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjASBej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 20:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjASBak (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 20:30:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E91539BA;
        Wed, 18 Jan 2023 17:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091741; x=1705627741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zpGmqtftN4NRkVDaDuKNzSeyqodohwPhHO6gHRCoQQ8=;
  b=eCRmFJu3Fpngkiuls/smB6SlNrCX4ZUVKx6WKs1oj7R1XupkDL+ug/GS
   ekANAraZkSoAINb/aVmmnRaYVjUuxxhumcymUX6MzcWKCqP1OFRC3ahkO
   m6d7pnEvVF/WjUI90KDsOGy5CevarhY74hkbwn7A09eho2pmOigqkMMO7
   wQYREyOUCUFeAiCT0R0WXr/w82fnpzg9j+/FZKB0Ze2HFvs916KeRTf+P
   LMhVD++7yfma1M9BtDiHpVJsFZpui9CubWXoCpC3Ra/vbrDR9c0Metjk0
   Hcc7wOgMUJs+lSTfnFgDdC63S8rGrtBaJ3vYgYP7vR/IkGLULsBAngS1F
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322847597"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322847597"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:29:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767995700"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767995700"
Received: from unknown (HELO fedora.sh.intel.com) ([10.238.175.104])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:28:55 -0800
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
Subject: [PATCH v1 10/12] PCI: hotplug: implement the hotplug_slot_ops callback for fpgahp
Date:   Wed, 18 Jan 2023 20:36:00 -0500
Message-Id: <20230119013602.607466-11-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230119013602.607466-1-tianfei.zhang@intel.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement the image_load and available_images callback functions
for fpgahp driver. This patch leverages some APIs from pciehp
driver to implement the device reconfiguration below the PCI hotplug
bridge.

Here are the steps for a process of image load.
1. remove all PFs and VFs except the PF0.
2. remove all non-reserved devices of PF0.
3. trigger a image load via BMC.
4. disable the link of the hotplug bridge.
5. remove all reserved devices under PF0 and PCI devices
   below the hotplug bridge.
6. wait for image load done via BMC, e.g. 10s.
7. re-enable the link of the hotplug bridge.
8. re-enumerate PCI devices below the hotplug bridge.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 Documentation/ABI/testing/sysfs-driver-fpgahp |  21 ++
 MAINTAINERS                                   |   1 +
 drivers/pci/hotplug/fpgahp.c                  | 179 ++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-fpgahp

diff --git a/Documentation/ABI/testing/sysfs-driver-fpgahp b/Documentation/ABI/testing/sysfs-driver-fpgahp
new file mode 100644
index 000000000000..8d4b1bfc4012
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-fpgahp
@@ -0,0 +1,21 @@
+What:		/sys/bus/pci/slots/X-X/available_images
+Date:		May 2023
+KernelVersion:	6.3
+Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
+Description:	Read-only. This file returns a space separated list of
+		key words that may be written into the image_load file
+		described below. These keywords decribe an FPGA, BMC,
+		or firmware image in FLASH or EEPROM storage that may
+		be loaded.
+
+What:		/sys/bus/pci/slots/X-X/image_load
+Date:		May 2023
+KernelVersion:	6.3
+Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
+Description:	Write-only. A key word may be written to this file to
+		trigger a new image loading of an FPGA, BMC, or firmware
+		image from FLASH or EEPROM. Refer to the available_images
+		file for a list of supported key words for the underlying
+		device.
+		Writing an unsupported string to this file will result in
+		EINVAL being returned.
diff --git a/MAINTAINERS b/MAINTAINERS
index 7ac38b7cc44c..85d4e3a0e986 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8168,6 +8168,7 @@ M:	Tianfei Zhang <tianfei.zhang@intel.com>
 L:	linux-fpga@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-fpgahp
 F:	drivers/pci/hotplug/fpgahp.c
 F:	include/linux/fpga/fpgahp_manager.h
 
diff --git a/drivers/pci/hotplug/fpgahp.c b/drivers/pci/hotplug/fpgahp.c
index 79bae97a1d39..3fdf37b238c6 100644
--- a/drivers/pci/hotplug/fpgahp.c
+++ b/drivers/pci/hotplug/fpgahp.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
+#include <linux/pm_runtime.h>
 
 #include "pciehp.h"
 
@@ -25,8 +26,182 @@ struct fpgahp_controller {
 	struct pcie_device *pcie;
 	struct controller ctrl;
 	struct pci_dev *hotplug_bridge;
+	struct mutex lock;  /* parallel access into image_load callback */
 };
 
+static inline struct fpgahp_controller *to_fhpc(struct controller *ctrl)
+{
+	return container_of(ctrl, struct fpgahp_controller, ctrl);
+}
+
+static int fpgahp_available_images(struct hotplug_slot *slot, char *buf)
+{
+	struct controller *ctrl = to_ctrl(slot);
+	struct fpgahp_controller *fhpc = to_fhpc(ctrl);
+	struct fpgahp_manager *mgr = &fhpc->mgr;
+	struct fpgahp_bmc_device *bmc = &mgr->bmc;
+	ssize_t count;
+
+	mutex_lock(&mgr->lock);
+
+	if (!mgr->registered || !bmc->registered)
+		goto err_unlock;
+
+	if (!bmc->ops->available_images)
+		goto err_unlock;
+
+	count = bmc->ops->available_images(bmc, buf);
+
+	mutex_unlock(&mgr->lock);
+
+	return count;
+
+err_unlock:
+	mutex_unlock(&mgr->lock);
+	return -EINVAL;
+}
+
+static void fpgahp_remove_sibling_pci_dev(struct pci_dev *pcidev)
+{
+	struct pci_bus *bus = pcidev->bus;
+	struct pci_dev *sibling, *tmp;
+
+	if (!bus)
+		return;
+
+	list_for_each_entry_safe_reverse(sibling, tmp, &bus->devices, bus_list)
+		if (sibling != pcidev)
+			pci_stop_and_remove_bus_device_locked(sibling);
+}
+
+static int fpgahp_link_enable(struct controller *ctrl)
+{
+	int retval;
+
+	retval = pciehp_link_enable(ctrl);
+	if (retval) {
+		ctrl_err(ctrl, "Can not enable the link!\n");
+		return retval;
+	}
+
+	retval = pciehp_check_link_status(ctrl);
+	if (retval) {
+		ctrl_err(ctrl, "Check link status fail!\n");
+		return retval;
+	}
+
+	retval = pciehp_query_power_fault(ctrl);
+	if (retval)
+		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
+
+	return retval;
+}
+
+static int fpgahp_rescan_slot(struct controller *ctrl)
+{
+	int retval;
+	struct pci_bus *parent = ctrl->pcie->port->subordinate;
+
+	retval = pciehp_configure_device(ctrl);
+	if (retval && retval != -EEXIST)
+		ctrl_err(ctrl, "Cannot add device at %04x:%02x:00\n",
+			 pci_domain_nr(parent), parent->number);
+
+	return retval;
+}
+
+static int __fpgahp_image_load(struct fpgahp_controller *fhpc, const char *buf)
+{
+	struct pci_dev *hotplug_bridge = fhpc->hotplug_bridge;
+	struct fpgahp_manager *mgr = &fhpc->mgr;
+	struct fpgahp_bmc_device *bmc = &mgr->bmc;
+	struct controller *ctrl = &fhpc->ctrl;
+	struct pci_dev *pcidev = mgr->priv;
+	u32 wait_time_msec;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(&hotplug_bridge->dev);
+	if (ret)
+		return ret;
+
+	mutex_lock(&mgr->lock);
+
+	if (!pcidev || !mgr->registered || !bmc->registered || !bmc->ops->image_trigger) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	mgr->state = FPGAHP_MGR_LOADING;
+
+	/* 1. remove all PFs and VFs except the PF0 */
+	fpgahp_remove_sibling_pci_dev(pcidev);
+
+	/* 2. remove all non-reserved devices */
+	if (mgr->ops->hotplug_prepare) {
+		ret = mgr->ops->hotplug_prepare(mgr);
+		if (ret) {
+			ctrl_err(ctrl, "Prepare hotplug failed\n");
+			goto out_unlock;
+		}
+	}
+
+	/* 3. trigger loading a new image of BMC */
+	ret = bmc->ops->image_trigger(bmc, buf, &wait_time_msec);
+	if (ret) {
+		ctrl_err(ctrl, "Image trigger failed\n");
+		goto out_unlock;
+	}
+
+	/* 4. disable link of hotplug bridge */
+	pciehp_link_disable(ctrl);
+
+	/*
+	 * unlock the mrg->lock temporarily to avoid the dead lock while re-gain
+	 * the same lock on fpgahp_unregister() during remove PCI devices below the
+	 * hotplug bridge
+	 */
+	mutex_unlock(&mgr->lock);
+
+	/* 5. remove PCI devices below hotplug bridge */
+	pciehp_unconfigure_device(ctrl, true);
+
+	/* 6. wait for FPGA/BMC load done */
+	msleep(wait_time_msec);
+
+	mutex_lock(&mgr->lock);
+
+	/* 7. re-enable link */
+	ret = fpgahp_link_enable(ctrl);
+
+out_unlock:
+	if (ret)
+		mgr->state = FPGAHP_MGR_HP_FAIL;
+	else
+		mgr->state = FPGAHP_MGR_LOAD_DONE;
+
+	mutex_unlock(&mgr->lock);
+
+	/* re-enumerate PCI devices below hotplug bridge */
+	if (!ret)
+		ret = fpgahp_rescan_slot(ctrl);
+
+	pm_runtime_put(&hotplug_bridge->dev);
+	return ret;
+}
+
+static int fpgahp_image_load(struct hotplug_slot *slot, const char *buf)
+{
+	struct controller *ctrl = to_ctrl(slot);
+	struct fpgahp_controller *fhpc = to_fhpc(ctrl);
+	int ret;
+
+	mutex_lock(&fhpc->lock);
+	ret = __fpgahp_image_load(fhpc, buf);
+	mutex_unlock(&fhpc->lock);
+
+	return ret;
+}
+
 static void fpgahp_add_fhpc(struct fpgahp_controller *fhpc)
 {
 	mutex_lock(&fhpc_lock);
@@ -128,6 +303,8 @@ static int fpgahp_init_controller(struct controller *ctrl, struct pcie_device *d
 }
 
 static const struct hotplug_slot_ops fpgahp_slot_ops = {
+	.available_images	= fpgahp_available_images,
+	.image_load		= fpgahp_image_load,
 };
 
 static int fpgahp_init_slot(struct controller *ctrl)
@@ -183,6 +360,7 @@ fpgahp_create_new_fhpc(struct fpgahp_controller *fhpc, struct pci_dev *hotplug_b
 	}
 
 	mutex_init(&mgr->lock);
+	mutex_init(&fhpc->lock);
 
 	fpgahp_add_fhpc(fhpc);
 
@@ -345,3 +523,4 @@ module_exit(fpgahp_exit);
 MODULE_DESCRIPTION("FPGA PCI Hotplug Manager Driver");
 MODULE_AUTHOR("Tianfei Zhang <tianfei.zhang@intel.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PCIEHP);
-- 
2.38.1

