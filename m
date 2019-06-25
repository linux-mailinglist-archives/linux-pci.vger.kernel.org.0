Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5752988
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 12:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfFYKaG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 06:30:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:58162 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731985AbfFYK3r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 06:29:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 03:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,415,1557212400"; 
   d="scan'208";a="188245039"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jun 2019 03:29:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5317E26A; Tue, 25 Jun 2019 13:29:43 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 3/3] PCI / ACPI: Add _PR0 dependent devices
Date:   Tue, 25 Jun 2019 13:29:42 +0300
Message-Id: <20190625102942.27740-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625102942.27740-1-mika.westerberg@linux.intel.com>
References: <20190625102942.27740-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If otherwise unrelated PCI devices share ACPI power resources turning
them on causes the devices to enter D0uninitialized power state which may
cause problems.

For example in Intel Ice Lake two root ports (RP0 and RP1), Thunderbolt
controller (NHI) and xHCI controller all share power resources as can be
ween in the topology below where power resources are marked with []:

  Host bridge
    |
    +- RP0 ---\
    +- RP1 ---|--+--> [TBT]
    +- NHI --/   |
    |            |
    |            v
    +- xHCI --> [D3C]

In a situation where all devices sharing the power resources are in
D3cold (the power resources are turned off) and for example the
Thunderbolt controller is runtime resumed resulting that the power
resources are turned on. This means that the other devices sharing them
(RP0, RP1 and xHCI) are transitioned into D0uninitialized state. If they
were configured to trigger wake (PME) on a certain event that
configuration gets lost after reset so we would need to re-initialize
them to get the wakeup working as expected again. To do so we would need
to runtime resume all of them to make sure their registers get restored
properly before we can runtime suspend them again.

Since we just added concept of "_PR0 dependent device" we can solve this
by calling the relevant add/remove functions when the PCI device is bind
to its ACPI representation. If it has power resources the PCI device
will be added as dependent device to them and runtime resumed whenever
they are physically turned on. This should make sure PCI core can
reconfigure wakes after the device is transitioned into D0uninitialized.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci-acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b782acac26c5..2abe0eeafb53 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -902,6 +902,7 @@ static void pci_acpi_setup(struct device *dev)
 		device_wakeup_enable(dev);
 
 	acpi_pci_wakeup(pci_dev, false);
+	acpi_device_power_add_dependent(adev, dev);
 }
 
 static void pci_acpi_cleanup(struct device *dev)
@@ -914,6 +915,7 @@ static void pci_acpi_cleanup(struct device *dev)
 
 	pci_acpi_remove_pm_notifier(adev);
 	if (adev->wakeup.flags.valid) {
+		acpi_device_power_remove_dependent(adev, dev);
 		if (pci_dev->bridge_d3)
 			device_wakeup_disable(dev);
 
-- 
2.20.1

