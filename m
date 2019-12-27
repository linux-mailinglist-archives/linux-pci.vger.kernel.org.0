Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7D12B388
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2019 10:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfL0JYR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Dec 2019 04:24:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44643 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfL0JYR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Dec 2019 04:24:17 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iklqv-000718-2j; Fri, 27 Dec 2019 09:24:13 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com, rafael.j.wysocki@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] PCI/PM: Report runtime wakeup is not supported if bridge isn't bound to driver
Date:   Fri, 27 Dec 2019 17:24:05 +0800
Message-Id: <20191227092405.29588-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have a Pericom USB add-on card that has three USB controller
functions 06:00.[0-2], connected to bridge device 05:03.0, which is
connected to another bridge device 04:00.0:

-[0000:00]-+-00.0
           +-1c.6-[04-06]----00.0-[05-06]----03.0-[06]--+-00.0
           |                                            +-00.1
           |                                            \-00.2

When bridge device (05:03.0) and all three USB controller functions
(06:00.[0-2]) are runtime suspended, they don't get woken up by plugging
USB devices into the add-on card.

This is because the pcieport driver failed to probe on 04:00.0, since
the device supports neither legacy IRQ, MSI nor MSI-X. Because of that,
there's no native PCIe PME can work for devices connected to it.

So let's correctly report runtime wakeup isn't supported when any of
PCIe bridges isn't bound to pcieport driver.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205981
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 951099279192..ca686cfbd65e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2493,6 +2493,18 @@ bool pci_dev_run_wake(struct pci_dev *dev)
 	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
 		return false;
 
+	/* If any upstream PCIe bridge isn't bound to pcieport driver, there's
+	 * no IRQ for PME.
+	 */
+	if (pci_is_pcie(dev)) {
+		while (bus->parent) {
+			if (!bus->self->driver)
+				return false;
+
+			bus = bus->parent;
+		}
+	}
+
 	if (device_can_wakeup(&dev->dev))
 		return true;
 
-- 
2.17.1

