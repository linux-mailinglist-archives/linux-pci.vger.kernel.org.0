Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 292F63A529
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2019 13:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfFILje (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jun 2019 07:39:34 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:49679 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfFILje (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jun 2019 07:39:34 -0400
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jun 2019 07:39:33 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 1A331101817B7;
        Sun,  9 Jun 2019 13:30:05 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id B7CC860DAED6;
        Sun,  9 Jun 2019 13:30:04 +0200 (CEST)
X-Mailbox-Line: From 0113014581dbe2d1f938813f1783905bd81b79db Mon Sep 17 00:00:00 2001
Message-Id: <0113014581dbe2d1f938813f1783905bd81b79db.1560079442.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 9 Jun 2019 13:29:33 +0200
Subject: [PATCH] PCI/PME: Fix race on PME polling
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit df17e62e5bff ("PCI: Add support for polling PME state on
suspended legacy PCI devices"), the work item pci_pme_list_scan() polls
the PME status flag of devices and wakes them up if the bit is set.

The function performs a check whether a device's upstream bridge is in
D0 for otherwise the device is inaccessible, rendering PME polling
impossible.  However the check is racy because it is performed before
polling the device.  If the upstream bridge runtime suspends to D3hot
after pci_pme_list_scan() checks its power state and before it invokes
pci_pme_wakeup(), the latter will read the PMCSR as "all ones" and
mistake it for a set PME status flag.  I am seeing this race play out as
a Thunderbolt controller going to D3cold and occasionally immediately
going to D0 again because PM polling was performed at just the wrong
time.

Avoid by checking for an "all ones" PMCSR in pci_check_pme_status().

Fixes: 58ff463396ad ("PCI PM: Add function for checking PME status of devices")
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v2.6.34+
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8abc843b1615..eed5db9f152f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1989,6 +1989,8 @@ bool pci_check_pme_status(struct pci_dev *dev)
 	pci_read_config_word(dev, pmcsr_pos, &pmcsr);
 	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
 		return false;
+	if (pmcsr == 0xffff)
+		return false;
 
 	/* Clear PME status. */
 	pmcsr |= PCI_PM_CTRL_PME_STATUS;
-- 
2.20.1

