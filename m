Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29226672E39
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 02:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjASBbo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 20:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjASBaj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 20:30:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB0753B05;
        Wed, 18 Jan 2023 17:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091724; x=1705627724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jZ/NDvb0qS7gU99iyUtOq4wnLW3cht+LjwWtMVC1BoY=;
  b=LWDfzwKb/IBvb2e7gjemYOw/VFRZPxq++nEjhEJQoK5X0hIj2C3yX1CT
   M2bRPdFQYTxJUbQWY6iuko9/S1jrGIz/bBVDxA5sHfzh5nWjLL9loOZNP
   IwPc8mlxYB95Zis+gbL//6Co6tAIS2ISMHMBly2wJdJUF2BupyYbK5zF2
   DrzKTSThl7b3PefIRK3dS598eb6j3Etk7BxbM9keDgU/m3iLC1hh0hykQ
   /wepMyUdcVoOsT0FhpkW33pPMhxiliFx3yP+xSeRVu3612QveDHXQDb8u
   U74TVjjPLIoJUG74LIZeyvZ4Kxq0k5mpdujwFofJX41g75kDJ1LIYjY3G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322847541"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322847541"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:28:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767995666"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767995666"
Received: from unknown (HELO fedora.sh.intel.com) ([10.238.175.104])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:28:38 -0800
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
Subject: [PATCH v1 07/12] PCI: hotplug: add register/unregister function for BMC device
Date:   Wed, 18 Jan 2023 20:35:57 -0500
Message-Id: <20230119013602.607466-8-tianfei.zhang@intel.com>
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

Introduce new APIs to register/unregister a BMC device instance
for fpgahp driver.

The fpgahp_bmc_device data structure represents a FPGA BMC device
which has some specific callbacks for FPGA hotplug operations.
The first one is available_images, which will return a list of
available images for FPGA. The second one is the image_load,
which will provide a reload trigger operation to BMC via secure
update driver for Intel PAC N3000 Card.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/pci/hotplug/fpgahp.c        | 78 +++++++++++++++++++++++++++++
 include/linux/fpga/fpgahp_manager.h | 38 ++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/pci/hotplug/fpgahp.c b/drivers/pci/hotplug/fpgahp.c
index 71cee65383e2..79bae97a1d39 100644
--- a/drivers/pci/hotplug/fpgahp.c
+++ b/drivers/pci/hotplug/fpgahp.c
@@ -34,6 +34,84 @@ static void fpgahp_add_fhpc(struct fpgahp_controller *fhpc)
 	mutex_unlock(&fhpc_lock);
 }
 
+static struct fpgahp_bmc_device *fpgahp_find_bmc(struct device *bmc_device)
+{
+	struct fpgahp_bmc_device *bmc = NULL;
+	struct fpgahp_controller *fhpc;
+
+	mutex_lock(&fhpc_lock);
+
+	list_for_each_entry(fhpc, &fhpc_list, node) {
+		struct fpgahp_manager *mgr = &fhpc->mgr;
+		struct pci_dev *pcidev = mgr->priv;
+
+		if (!mgr->registered)
+			continue;
+
+		/*
+		 * BMC device (like security dev) is a subordinate device under
+		 * PCI device, so check if the parent device of BMC device recursively
+		 */
+		if (device_is_ancestor(&pcidev->dev, bmc_device)) {
+			bmc = &mgr->bmc;
+			break;
+		}
+	}
+
+	mutex_unlock(&fhpc_lock);
+
+	return bmc;
+}
+
+/**
+ * fpgahp_bmc_device_register - register FPGA BMC device into fpgahp driver
+ * @ops: pointer to structure of fpgahp manager ops
+ * @dev: device struct of BMC device
+ * @priv: private data for FPGA device
+ *
+ * Return: pointer to struct fpgahp_manager pointer or ERR_PTR()
+ */
+struct fpgahp_bmc_device *
+fpgahp_bmc_device_register(const struct fpgahp_bmc_ops *ops,
+			   struct device *dev, void *priv)
+{
+	struct fpgahp_manager *mgr;
+	struct fpgahp_bmc_device *bmc;
+
+	if (!ops)
+		return ERR_PTR(-EINVAL);
+
+	bmc = fpgahp_find_bmc(dev);
+	if (!bmc)
+		return ERR_PTR(-EINVAL);
+
+	mgr = to_fpgahp_mgr(bmc);
+
+	mutex_lock(&mgr->lock);
+	bmc->priv = priv;
+	bmc->device = dev;
+	bmc->ops = ops;
+	bmc->registered = true;
+	mutex_unlock(&mgr->lock);
+
+	return bmc;
+}
+EXPORT_SYMBOL_NS_GPL(fpgahp_bmc_device_register, FPGAHP);
+
+/**
+ * fpgahp_bmc_device_unregister - unregister FPGA BMC device from fpgahp driver
+ * @bmc: point to the fpgahp_bmc_device
+ */
+void fpgahp_bmc_device_unregister(struct fpgahp_bmc_device *bmc)
+{
+	struct fpgahp_manager *mgr = to_fpgahp_mgr(bmc);
+
+	mutex_lock(&mgr->lock);
+	bmc->registered = false;
+	mutex_unlock(&mgr->lock);
+}
+EXPORT_SYMBOL_NS_GPL(fpgahp_bmc_device_unregister, FPGAHP);
+
 static int fpgahp_init_controller(struct controller *ctrl, struct pcie_device *dev)
 {
 	struct pci_dev *hotplug_bridge = dev->port;
diff --git a/include/linux/fpga/fpgahp_manager.h b/include/linux/fpga/fpgahp_manager.h
index 5e31877f03de..982fbc661f55 100644
--- a/include/linux/fpga/fpgahp_manager.h
+++ b/include/linux/fpga/fpgahp_manager.h
@@ -11,6 +11,33 @@
 
 struct pci_dev;
 struct fpgahp_manager;
+struct fpgahp_bmc_device;
+
+/**
+ * struct fpgahp_bmc_ops - fpga hotplug BMC specific operations
+ * @available_images: Required: available images for fpgahp trigger
+ * @image_trigger: Required: trigger the image reload on BMC
+ */
+struct fpgahp_bmc_ops {
+	ssize_t (*available_images)(struct fpgahp_bmc_device *bmc, char *buf);
+	int (*image_trigger)(struct fpgahp_bmc_device *bmc, const char *buf,
+			     u32 *wait_time_msec);
+};
+
+/**
+ * struct fpgahp_bmc_device - represent a fpga hotplug BMC device
+ *
+ * @ops: ops of this fpgahp_bmc_device
+ * @priv: private data for fpgahp_bmc_device
+ * @device: device of BMC device
+ * @registered: register status
+ */
+struct fpgahp_bmc_device {
+	const struct fpgahp_bmc_ops *ops;
+	void *priv;
+	struct device *device;
+	bool registered;
+};
 
 /**
  * struct fpgahp_manager_ops - fpgahp manager specific operations
@@ -43,6 +70,7 @@ enum fpgahp_manager_states {
  * @ops: ops of this fpgahp_manager
  * @state: the status of fpgahp_manager
  * @name: name of the fpgahp_manager
+ * @bmc: fpgahp BMC device
  * @registered: register status
  */
 struct fpgahp_manager {
@@ -51,12 +79,22 @@ struct fpgahp_manager {
 	const struct fpgahp_manager_ops *ops;
 	enum fpgahp_manager_states state;
 	const char *name;
+	struct fpgahp_bmc_device bmc;
 	bool registered;
 };
 
+static inline struct fpgahp_manager *to_fpgahp_mgr(struct fpgahp_bmc_device *bmc)
+{
+	return container_of(bmc, struct fpgahp_manager, bmc);
+}
+
 struct fpgahp_manager *fpgahp_register(struct pci_dev *hotplug_bridge,
 				       const char *name, const struct fpgahp_manager_ops *ops,
 				       void *priv);
 void fpgahp_unregister(struct fpgahp_manager *mgr);
 
+struct fpgahp_bmc_device *fpgahp_bmc_device_register(const struct fpgahp_bmc_ops *ops,
+						     struct device *dev, void *priv);
+void fpgahp_bmc_device_unregister(struct fpgahp_bmc_device *bmc);
+
 #endif
-- 
2.38.1

