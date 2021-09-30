Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1031C41D96F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 14:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350708AbhI3MOn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 08:14:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:38148 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348765AbhI3MOm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 08:14:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="223283964"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="223283964"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 05:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="618097823"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Sep 2021 05:12:46 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/2] device property: Remove device_add_properties() API
Date:   Thu, 30 Sep 2021 15:12:46 +0300
Message-Id: <20210930121246.22833-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930121246.22833-1-heikki.krogerus@linux.intel.com>
References: <20210930121246.22833-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are no more users for it.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/core.c      |  1 -
 drivers/base/property.c  | 48 ----------------------------------------
 include/linux/property.h |  4 ----
 3 files changed, 53 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7758223f040c8..7935ee642fa3f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3573,7 +3573,6 @@ void device_del(struct device *dev)
 	device_pm_remove(dev);
 	driver_deferred_probe_del(dev);
 	device_platform_notify_remove(dev);
-	device_remove_properties(dev);
 	device_links_purge(dev);
 
 	if (dev->bus)
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 453918eb7390c..1f1eee37817e0 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -508,54 +508,6 @@ struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_find_reference);
 
-/**
- * device_remove_properties - Remove properties from a device object.
- * @dev: Device whose properties to remove.
- *
- * The function removes properties previously associated to the device
- * firmware node with device_add_properties(). Memory allocated to the
- * properties will also be released.
- */
-void device_remove_properties(struct device *dev)
-{
-	struct fwnode_handle *fwnode = dev_fwnode(dev);
-
-	if (!fwnode)
-		return;
-
-	if (is_software_node(fwnode->secondary)) {
-		fwnode_remove_software_node(fwnode->secondary);
-		set_secondary_fwnode(dev, NULL);
-	}
-}
-EXPORT_SYMBOL_GPL(device_remove_properties);
-
-/**
- * device_add_properties - Add a collection of properties to a device object.
- * @dev: Device to add properties to.
- * @properties: Collection of properties to add.
- *
- * Associate a collection of device properties represented by @properties with
- * @dev. The function takes a copy of @properties.
- *
- * WARNING: The callers should not use this function if it is known that there
- * is no real firmware node associated with @dev! In that case the callers
- * should create a software node and assign it to @dev directly.
- */
-int device_add_properties(struct device *dev,
-			  const struct property_entry *properties)
-{
-	struct fwnode_handle *fwnode;
-
-	fwnode = fwnode_create_software_node(properties, NULL);
-	if (IS_ERR(fwnode))
-		return PTR_ERR(fwnode);
-
-	set_secondary_fwnode(dev, fwnode);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(device_add_properties);
-
 /**
  * fwnode_get_name - Return the name of a node
  * @fwnode: The firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index 357513a977e5d..daf0b5841286f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -377,10 +377,6 @@ property_entries_dup(const struct property_entry *properties);
 
 void property_entries_free(const struct property_entry *properties);
 
-int device_add_properties(struct device *dev,
-			  const struct property_entry *properties);
-void device_remove_properties(struct device *dev);
-
 bool device_dma_supported(struct device *dev);
 
 enum dev_dma_attr device_get_dma_attr(struct device *dev);
-- 
2.33.0

