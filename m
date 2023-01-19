Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DBD672E27
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 02:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjASBbf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 20:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjASBah (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 20:30:37 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F043A69B02;
        Wed, 18 Jan 2023 17:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091688; x=1705627688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ub1Nhg/YfNN8lF7oMoQzn6b0nSLrMDb9fAwsdQLvBdQ=;
  b=Oj/B38Zzzhbe0SSORq1UwOmgiRflzfoG4SxLkN5az/JUUKOGSVBsM8Mm
   eFW94H/QMzWt+kD6fRn75u7QMIiwRCB20DyWSv1hnZD3Y6jR+Hj8mSljo
   i879vWd0KUQXnbn8eehBvIQVOcdTe7gqLnE9BXxdDlfC9cyvBNMylwDDr
   NAPz8y/ewwT/Uj+q+qfPvwIBaoWlTyhNJvWDi7rvHqhDkUfVD1stb+5P8
   GjkNuJR3Pz09mk2gGnegnLYEZb5WHEAR2etfBnzgUZ606qW86qszdLjgN
   X0xK6MO3gQ+PVzWB+zEoEtA2LNlQjM3AoZDBjcZX4QUUALIa8nGgejna6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322847428"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322847428"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:28:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767995614"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767995614"
Received: from unknown (HELO fedora.sh.intel.com) ([10.238.175.104])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:28:02 -0800
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
Subject: [PATCH v1 01/12] PCI: hotplug: add new callbacks on hotplug_slot_ops
Date:   Wed, 18 Jan 2023 20:35:51 -0500
Message-Id: <20230119013602.607466-2-tianfei.zhang@intel.com>
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

To reprogram an PCIe-based FPGA card, a new image is
burned into FLASH on the card and then the card BMC is
triggered to reboot the card and load the new image.

Two new operation callbacks are defined in hotplug_slot_ops
to trigger the reprogramming of an FPGA-based PCIe card:

  - available_images: Optional: available FPGA images
  - image_load: Optional: trigger the FPGA to load a new image

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 88 ++++++++++++++++++++++++++
 include/linux/pci_hotplug.h            |  5 ++
 2 files changed, 93 insertions(+)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 058d5937d8a9..2b14b6513a03 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -231,6 +231,52 @@ static struct pci_slot_attribute hotplug_slot_attr_test = {
 	.store = test_write_file
 };
 
+static ssize_t available_images_read_file(struct pci_slot *pci_slot, char *buf)
+{
+	struct hotplug_slot *slot = pci_slot->hotplug;
+	ssize_t count = 0;
+
+	if (!try_module_get(slot->owner))
+		return -ENODEV;
+
+	if (slot->ops->available_images(slot, buf))
+		count = slot->ops->available_images(slot, buf);
+
+	module_put(slot->owner);
+
+	return count;
+}
+
+static struct pci_slot_attribute hotplug_slot_attr_available_images = {
+	.attr = { .name = "available_images", .mode = 0444 },
+	.show = available_images_read_file,
+};
+
+static ssize_t image_load_write_file(struct pci_slot *pci_slot,
+				     const char *buf, size_t count)
+{
+	struct hotplug_slot *slot = pci_slot->hotplug;
+	int retval = 0;
+
+	if (!try_module_get(slot->owner))
+		return -ENODEV;
+
+	if (slot->ops->image_load)
+		retval = slot->ops->image_load(slot, buf);
+
+	module_put(slot->owner);
+
+	if (retval)
+		return retval;
+
+	return count;
+}
+
+static struct pci_slot_attribute hotplug_slot_attr_image_load = {
+	.attr = { .name = "image_load", .mode = 0644 },
+	.store = image_load_write_file,
+};
+
 static bool has_power_file(struct pci_slot *pci_slot)
 {
 	struct hotplug_slot *slot = pci_slot->hotplug;
@@ -289,6 +335,20 @@ static bool has_test_file(struct pci_slot *pci_slot)
 	return false;
 }
 
+static bool has_available_images_file(struct pci_slot *pci_slot)
+{
+	struct hotplug_slot *slot = pci_slot->hotplug;
+
+	return slot && slot->ops && slot->ops->available_images;
+}
+
+static bool has_image_load_file(struct pci_slot *pci_slot)
+{
+	struct hotplug_slot *slot = pci_slot->hotplug;
+
+	return slot && slot->ops && slot->ops->image_load;
+}
+
 static int fs_add_slot(struct pci_slot *pci_slot)
 {
 	int retval = 0;
@@ -331,8 +391,30 @@ static int fs_add_slot(struct pci_slot *pci_slot)
 			goto exit_test;
 	}
 
+	if (has_available_images_file(pci_slot)) {
+		retval = sysfs_create_file(&pci_slot->kobj,
+					   &hotplug_slot_attr_available_images.attr);
+		if (retval)
+			goto exit_available_images;
+	}
+
+	if (has_image_load_file(pci_slot)) {
+		retval = sysfs_create_file(&pci_slot->kobj,
+					   &hotplug_slot_attr_image_load.attr);
+		if (retval)
+			goto exit_image_load;
+	}
+
 	goto exit;
 
+exit_image_load:
+	if (has_adapter_file(pci_slot))
+		sysfs_remove_file(&pci_slot->kobj,
+				  &hotplug_slot_attr_available_images.attr);
+exit_available_images:
+	if (has_adapter_file(pci_slot))
+		sysfs_remove_file(&pci_slot->kobj,
+				  &hotplug_slot_attr_test.attr);
 exit_test:
 	if (has_adapter_file(pci_slot))
 		sysfs_remove_file(&pci_slot->kobj,
@@ -372,6 +454,12 @@ static void fs_remove_slot(struct pci_slot *pci_slot)
 	if (has_test_file(pci_slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_test.attr);
 
+	if (has_available_images_file(pci_slot))
+		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_available_images.attr);
+
+	if (has_image_load_file(pci_slot))
+		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_image_load.attr);
+
 	pci_hp_remove_module_link(pci_slot);
 }
 
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 3a10d6ec3ee7..b7f39c20ad8b 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -29,6 +29,9 @@
  * @reset_slot: Optional interface to allow override of a bus reset for the
  *	slot for cases where a secondary bus reset can result in spurious
  *	hotplug events or where a slot can be reset independent of the bus.
+ * @available_images: Optional: called to get the available images for accelerator,
+ *	like FPGA.
+ * @image_load: Optional: called to load a new image for accelerator like FPGA.
  *
  * The table of function pointers that is passed to the hotplug pci core by a
  * hotplug pci driver.  These functions are called by the hotplug pci core when
@@ -45,6 +48,8 @@ struct hotplug_slot_ops {
 	int (*get_latch_status)		(struct hotplug_slot *slot, u8 *value);
 	int (*get_adapter_status)	(struct hotplug_slot *slot, u8 *value);
 	int (*reset_slot)		(struct hotplug_slot *slot, bool probe);
+	int (*available_images)		(struct hotplug_slot *slot, char *buf);
+	int (*image_load)		(struct hotplug_slot *slot, const char *buf);
 };
 
 /**
-- 
2.38.1

