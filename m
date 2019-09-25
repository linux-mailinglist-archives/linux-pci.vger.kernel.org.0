Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A45BD607
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2019 03:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbfIYBRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 21:17:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:38474 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389624AbfIYBRM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Sep 2019 21:17:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x8P1Gvcf031238;
        Tue, 24 Sep 2019 20:16:58 -0500
Message-ID: <7339fd73ccaf58552737ab10008333fd9f7723f2.camel@kernel.crashing.org>
Subject: [PATCH v2] PCI: Protect pci_reassign_bridge_resources() against
 concurrent addition/removal
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Wed, 25 Sep 2019 11:16:55 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_reassign_bridge_resources() can be called by pci_resize_resource()
at runtime.

It will walk the PCI tree up and down, and isn't currently protected
against any changes or hotplug operation.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2: Fix a missing exit case
    Reported by: Dan Carpenter <dan.carpenter@oracle.com>

---
 drivers/pci/setup-bus.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 79b1fa6519be..871dad7d02ea 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2066,6 +2066,8 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 	unsigned int i;
 	int ret;
 
+	down_read(&pci_bus_sem);
+
 	/* Walk to the root hub, releasing bridge BARs when possible */
 	next = bridge;
 	do {
@@ -2100,8 +2102,10 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		next = bridge->bus ? bridge->bus->self : NULL;
 	} while (next);
 
-	if (list_empty(&saved))
+	if (list_empty(&saved)) {
+		up_read(&pci_bus_sem);
 		return -ENOENT;
+	}
 
 	__pci_bus_size_bridges(bridge->subordinate, &added);
 	__pci_bridge_assign_resources(bridge, &added, &failed);
@@ -2122,6 +2126,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 	}
 
 	free_list(&saved);
+	up_read(&pci_bus_sem);
 	return 0;
 
 cleanup:
@@ -2150,6 +2155,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		pci_setup_bridge(bridge->subordinate);
 	}
 	free_list(&saved);
+	up_read(&pci_bus_sem);
 
 	return ret;
 }


