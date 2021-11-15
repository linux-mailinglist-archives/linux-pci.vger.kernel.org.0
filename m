Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1BF450422
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 13:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhKOMNH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 07:13:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:14027 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231374AbhKOMNE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 07:13:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233266358"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="233266358"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 04:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="644818670"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2021 04:10:06 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v4 3/3] device property: Remove device_add_properties() API
Date:   Mon, 15 Nov 2021 15:10:01 +0300
Message-Id: <20211115121001.77041-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115121001.77041-1-heikki.krogerus@linux.intel.com>
References: <20211115121001.77041-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are no more users for it.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/property.c  | 48 ----------------------------------------
 include/linux/property.h |  4 ----
 2 files changed, 52 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f1f35b48ab8b9..d0960a9e89741 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -507,54 +507,6 @@ struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
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
index 88fa726a76df7..16f736c698a2d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -378,10 +378,6 @@ property_entries_dup(const struct property_entry *properties);
 
 void property_entries_free(const struct property_entry *properties);
 
-int device_add_properties(struct device *dev,
-			  const struct property_entry *properties);
-void device_remove_properties(struct device *dev);
-
 bool device_dma_supported(struct device *dev);
 
 enum dev_dma_attr device_get_dma_attr(struct device *dev);
-- 
2.33.0

