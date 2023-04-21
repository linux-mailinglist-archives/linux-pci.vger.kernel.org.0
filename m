Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620CD6EA7F1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 12:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjDUKKA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 06:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjDUKJn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 06:09:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680B0C145;
        Fri, 21 Apr 2023 03:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682071778; x=1713607778;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GLPpA5lDZ0mZwbKjbwTkAID/m0yPy1TX9T+nWpkCkQI=;
  b=MrxTDsH3ESd2/6xOpMYn/2qmdMY7TDKbjsOUk1E0FmYSuc1+a91trNcj
   IDLYRL6n9jBHZKRxvGrtTPf7pIq/hO3881+VG9yLqTYjIuPQNSLeZf4X9
   ubIoZOJ1StJD8BCGtU3k3qgVQhED9k4mwSDdTlVrEEi31X/sjQMkzqFR4
   hevkboWRyUFvSMa/Z/GSemrwbdtdLDTyyedYtRMHKFbHanbd3bECJz0d5
   W87gsNVxJKUSRfJLylE3c2WJYAq3dwgQc+oph8gioHRnIhNR9Ow7ReOlY
   pqVj0zHrSqSBy46PxJ15TLZhtJYaK5hd4jMzJfWUg7E8qLsmxv6EPLQDH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="411228614"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="411228614"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 03:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="816371086"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="816371086"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2023 03:09:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 192B3C06; Fri, 21 Apr 2023 13:09:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/1] PCI: of: Propagate firmware node by calling device_set_node()
Date:   Fri, 21 Apr 2023 13:09:39 +0300
Message-Id: <20230421100939.68225-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
v3: fixed compilation issue
v2: rewritten commit message as suggested (Bjorn), rebased on the latest code

 drivers/pci/of.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 4c2ef2e28fb5..82bff748cd4d 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -39,16 +39,14 @@ int pci_set_of_node(struct pci_dev *dev)
 		return -ENODEV;
 	}
 
-	dev->dev.of_node = node;
-	dev->dev.fwnode = &node->fwnode;
+	device_set_node(&dev->dev, of_fwnode_handle(node));
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

