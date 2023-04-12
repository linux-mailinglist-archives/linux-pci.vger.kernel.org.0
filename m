Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73946DF6D4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDLNUG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 09:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjDLNT7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 09:19:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891789EC2;
        Wed, 12 Apr 2023 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305580; x=1712841580;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JYAs2/Rz4YUIstRy5EIsBG2WbHJqPyfD3jBpMgyj1MQ=;
  b=kqycX832qBMuSH6jqZx5cr8R/Qc5+yMS/RAlkD9m+UuxlZGXXKNKaBjo
   rKUUBLSZQzzHOmEKKP4Rlh4+2GomYvmOO6ZlqGWpjO7kSPHzKtkxP+uRn
   TqQosw8FZvGYJq9dff8y/gHRXtu/+x2Xqy61jO8TdY/LgWe0Xm9Qmad6M
   USRkWpwn/vdgpd7PkVptWGBJQPunT/akCmC8O6kRmS4FnPyLCX7Bjt0hF
   Jg/OoCOTIgutnR+sag9w4talka8FdMwETzZRGKObt0LZG0D2NpvsxdqdS
   4qpxmRD5IqkXso12JITzSqGjz/QWCZT4tEcLBOJ149Srefx9hq6+EtVht
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="343896511"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="343896511"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935111585"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935111585"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 06:15:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B08E8172; Wed, 12 Apr 2023 16:15:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PCI: of: Propagate firmware node
Date:   Wed, 12 Apr 2023 16:15:20 +0300
Message-Id: <20230412131520.52840-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Propagate firmware node by using a specific API call, i.e. device_set_node().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/of.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 196834ed44fe..4bba00dfbfc5 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -18,19 +18,18 @@
 #ifdef CONFIG_PCI
 void pci_set_of_node(struct pci_dev *dev)
 {
+	struct device_node *node;
+
 	if (!dev->bus->dev.of_node)
 		return;
-	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
-						    dev->devfn);
-	if (dev->dev.of_node)
-		dev->dev.fwnode = &dev->dev.of_node->fwnode;
+	node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
+	device_set_node(&dev->dev, of_fwnode_handle(node));
 }
 
 void pci_release_of_node(struct pci_dev *dev)
 {
 	of_node_put(dev->dev.of_node);
-	dev->dev.of_node = NULL;
-	dev->dev.fwnode = NULL;
+	device_set_node(&dev->dev, NULL);
 }
 
 void pci_set_bus_of_node(struct pci_bus *bus)
@@ -45,17 +44,13 @@ void pci_set_bus_of_node(struct pci_bus *bus)
 			bus->self->external_facing = true;
 	}
 
-	bus->dev.of_node = node;
-
-	if (bus->dev.of_node)
-		bus->dev.fwnode = &bus->dev.of_node->fwnode;
+	device_set_node(&bus->dev, of_fwnode_handle(node));
 }
 
 void pci_release_bus_of_node(struct pci_bus *bus)
 {
 	of_node_put(bus->dev.of_node);
-	bus->dev.of_node = NULL;
-	bus->dev.fwnode = NULL;
+	device_set_node(&bus->dev, NULL);
 }
 
 struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
-- 
2.40.0.1.gaa8946217a0b

