Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AAF6EA6F3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 11:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjDUJ3r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 05:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDUJ3q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 05:29:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0669213D;
        Fri, 21 Apr 2023 02:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682069384; x=1713605384;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zp2e5dMArkvPTnl7T3iiTEMKwSfJ7vHlEh8MtJDUXIE=;
  b=iPpUjYTmmI2XATz7gO5jetgpcEdIXJWFrNwwg/Uc9IwFj+VryYjtVQls
   fePhUTm+VnuYiaBAZZtbcAwLRRb0ji3ATJUGWkVhoowVFKNkbdynRmmVk
   i+pGp4iFyTUJCmQnuCybm4OsNsnW9P0qVXKnOrMyuqbqQ9raiGY8OX5LW
   eYysslAu36jtjAZlsNAQrnk8D8Ewo2d4gcK1kRcB3d+O6irupWYleftij
   NRO38mK4zB8Rsjj3cR/4AQ8ESYu3ILoHG49qUL2uIswwe9wutrmz8iRKS
   KPCzGGVtdmNYGIL6HbBKjUTiuWzlCevwHWCXQ3iFsQmLF7F5PT3jl5jXh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="343442494"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="343442494"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 02:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="938419536"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="938419536"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 21 Apr 2023 02:29:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 294F5C06; Fri, 21 Apr 2023 12:29:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] PCI: of: Propagate firmware node by calling device_set_node()
Date:   Fri, 21 Apr 2023 12:29:45 +0300
Message-Id: <20230421092945.66176-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Insulate pci_set_of_node() and pci_set_bus_of_node() from possible
changes to fwnode_handle implementation by using device_set_node()
instead of open-coding dev->dev.fwnode assignments.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rewritten commit message as suggested (Bjorn), rebased on the latest code
 drivers/pci/of.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 4c2ef2e28fb5..2679d6e6da30 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -39,16 +39,14 @@ int pci_set_of_node(struct pci_dev *dev)
 		return -ENODEV;
 	}
 
-	dev->dev.of_node = node;
-	dev->dev.fwnode = &node->fwnode;
+	device_set_node(&dev->dev, node);
 	return 0;
 }
 
 void pci_release_of_node(struct pci_dev *dev)
 {
 	of_node_put(dev->dev.of_node);
-	dev->dev.of_node = NULL;
-	dev->dev.fwnode = NULL;
+	device_set_node(&dev->dev, NULL);
 }
 
 void pci_set_bus_of_node(struct pci_bus *bus)
@@ -63,17 +61,13 @@ void pci_set_bus_of_node(struct pci_bus *bus)
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

