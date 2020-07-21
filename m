Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77963227EB8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 13:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgGULYy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 07:24:54 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:46827 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgGULYy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 07:24:54 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id C0FA03000225E;
        Tue, 21 Jul 2020 13:24:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 902012E581; Tue, 21 Jul 2020 13:24:50 +0200 (CEST)
Message-Id: <c6aab5af096f7b1b3db57f6335cebba8f0fcca89.1595330431.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 21 Jul 2020 13:24:51 +0200
Subject: [PATCH] PCI: Simplify pci_dev_reset_slot_function()
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_dev_reset_slot_function() refuses to reset a hotplug slot if it is
shared by multiple pci_devs.  That's the case if and only if the slot is
occupied by a multifunction device.

Simplify the function to check the device's multifunction flag instead
of iterating over the devices on the bus.  (Iterating over the devices
requires holding pci_bus_sem, which the function erroneously does not
acquire.)

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 455da72..b406611 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4914,16 +4914,10 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
 
 static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
 {
-	struct pci_dev *pdev;
-
-	if (dev->subordinate || !dev->slot ||
+	if (dev->multifunction || dev->subordinate || !dev->slot ||
 	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
 		return -ENOTTY;
 
-	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
-		if (pdev != dev && pdev->slot == dev->slot)
-			return -ENOTTY;
-
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
 
-- 
2.27.0

