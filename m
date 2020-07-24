Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA64A22CBF8
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 19:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgGXRWk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 13:22:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:2758 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgGXRWh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 13:22:37 -0400
IronPort-SDR: 92Z/9Mh9e4GNIOh056J6ha1enG+vZgPG6nmR5LxYnez/Ob1b1VrmEiclU0LjYhynP1rnJcMM9P
 XjJzTBMZHqWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="130823260"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="130823260"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:22:37 -0700
IronPort-SDR: MjE3N+hZwFGldvcFNdC7MJypotw+sxNsYrqtTAYs0DEC1XUDLeOKE5LkXfMMJmTN/lG97xpDqY
 dLc/uhuzeTZQ==
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="302730297"
Received: from seokjaeb-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.24.239])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:22:36 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@kernel.org, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [RFC PATCH 4/9] PCI/AER: Extend AER error handling to RCECs
Date:   Fri, 24 Jul 2020 10:22:18 -0700
Message-Id: <20200724172223.145608-5-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724172223.145608-1-sean.v.kelley@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Currently the kernel does not handle AER errors for Root Complex integrated
End Points (RCiEPs)[0]. These devices sit on a root bus within the Root Complex
(RC). AER handling is performed by a Root Complex Event Collector (RCEC) [1]
which is a effectively a type of RCiEP on the same root bus.

For an RCEC (technically not a Bridge), error messages "received" from
associated RCiEPs must be enabled for "transmission" in order to cause a
System Error via the Root Control register or (when the Advanced Error
Reporting Capability is present) reporting via the Root Error Command
register and logging in the Root Error Status register and Error Source
Identification register.

In addition to the defined OS level handling of the reset flow for the
associated RCiEPs of an RCEC, it is possible to also have a firmware first
model. In that case there is no need to take any actions on the RCEC because
the firmware is responsible for them. This is true where APEI [2] is used
to report the AER errors via a GHES[v2] HEST entry [3] and relevant
AER CPER record [4] and Firmware First handling is in use.

We effectively end up with two different types of discovery for
purposes of handling AER errors:

1) Normal bus walk - we pass the downstream port above a bus to which
the device is attached and it walks everything below that point.

2) An RCiEP with no visible association with an RCEC as there is no need to
walk devices. In that case, the flow is to just call the callbacks for the actual
device.

A new walk function, similar to pci_bus_walk is provided that takes a pci_dev
instead of a bus. If that dev corresponds to a downstream port it will walk
the subordinate bus of that downstream port. If the dev does not then it
will call the function on that device alone.

[0] ACPI PCI Express Base Specification 5.0-1 1.3.2.3 Root Complex Integrated
    Endpoint Rules.
[1] ACPI PCI Express Base Specification 5.0-1 6.2 Error Signalling and Logging
[2] ACPI Specification 6.3 Chapter 18 ACPI Platform Error Interface (APEI)
[3] ACPI Specification 6.3 18.2.3.7 Generic Hardware Error Source
[4] UEFI Specification 2.8, N.2.7 PCI Express Error Section

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
Changes since v2 [1]:

- Renamed to pci_walk_dev_affected() to reflect the aer affected devices
- Localized to err.c and made static
- Added check for RCEC to reflect
- Tightened up commit log from earlier inquiry focused RFC

[1] https://lore.kernel.org/linux-pci/20200622114402.892798-1-Jonathan.Cameron@huawei.com/
---
 drivers/pci/pcie/err.c | 55 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 14bb8f54723e..044df004f20b 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -146,38 +146,69 @@ static int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+/** pci_walk_dev_affected - walk devices potentially AER affected
+ *  @dev      device which may be an RCEC with associated RCiEPs,
+ *            an RCiEP associated with an RCEC, or a Port.
+ *  @cb       callback to be called for each device found
+ *  @userdata arbitrary pointer to be passed to callback.
+ *
+ *  If the device provided is a port, walk the subordinate bus,
+ *  including any bridged devices on buses under this bus.
+ *  Call the provided callback on each device found.
+ *
+ *  If the device provided has no subordinate bus, call the provided
+ *  callback on the device itself.
+ *
+ */
+static void pci_walk_dev_affected(struct pci_dev *dev, int (*cb)(struct pci_dev *, void *),
+				  void *userdata)
+{
+	if (dev->subordinate) {
+		pci_walk_bus(dev->subordinate, cb, userdata);
+	} else {
+		cb(dev, userdata);
+	}
+}
+
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			enum pci_channel_state state,
 			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
-	struct pci_bus *bus;
 
 	/*
 	 * Error recovery runs on all subordinates of the first downstream port.
 	 * If the downstream port detected the error, it is cleared at the end.
+	 * For RCiEPs we should reset just the RCiEP itself.
 	 */
 	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
+	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
+	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END ||
+	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC))
 		dev = dev->bus->self;
-	bus = dev->subordinate;
 
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
-		pci_walk_bus(bus, report_frozen_detected, &status);
+		pci_walk_dev_affected(dev, report_frozen_detected, &status);
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
+			pci_warn(dev, "link reset not possible for RCiEP\n");
+			status = PCI_ERS_RESULT_NONE;
+			goto failed;
+		}
+
 		status = reset_link(dev);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(dev, "link reset failed\n");
 			goto failed;
 		}
 	} else {
-		pci_walk_bus(bus, report_normal_detected, &status);
+		pci_walk_dev_affected(dev, report_normal_detected, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast mmio_enabled message\n");
-		pci_walk_bus(bus, report_mmio_enabled, &status);
+		pci_walk_dev_affected(dev, report_mmio_enabled, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
@@ -188,17 +219,21 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		 */
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast slot_reset message\n");
-		pci_walk_bus(bus, report_slot_reset, &status);
+		pci_walk_dev_affected(dev, report_slot_reset, &status);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
 	pci_dbg(dev, "broadcast resume message\n");
-	pci_walk_bus(bus, report_resume, &status);
+	pci_walk_dev_affected(dev, report_resume, &status);
 
-	pci_aer_clear_device_status(dev);
-	pci_aer_clear_nonfatal_status(dev);
+	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
+	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
+		pci_aer_clear_device_status(dev);
+		pci_aer_clear_nonfatal_status(dev);
+	}
 	pci_info(dev, "device recovery successful\n");
 	return status;
 
-- 
2.27.0

