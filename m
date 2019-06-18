Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D22824A6A1
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 18:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfFRQTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 12:19:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:30536 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbfFRQTC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jun 2019 12:19:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 09:19:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,389,1557212400"; 
   d="scan'208";a="170272850"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 18 Jun 2019 09:18:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7F2488D; Tue, 18 Jun 2019 19:18:58 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 1/3] PCI / ACPI: Use cached ACPI device state to get PCI device power state
Date:   Tue, 18 Jun 2019 19:18:56 +0300
Message-Id: <20190618161858.77834-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel Ice Lake has an integrated Thunderbolt controller which means that
the PCIe topology is extended directly from the two root ports (RP0 and
RP1). Power management is handled by ACPI power resources that are
shared between the root ports, Thunderbolt controller (NHI) and xHCI
controller.

The topology with the power resources (marked with []) looks like:

  Host bridge
    |
    +- RP0 ---\
    +- RP1 ---|--+--> [TBT]
    +- NHI --/   |
    |            |
    |            v
    +- xHCI --> [D3C]

Here TBT and D3C are the shared ACPI power resources. ACPI _PR3() method
returns either TBT or D3C or both.

Say we runtime suspend first the root ports RP0 and RP1, then NHI. Now
since the TBT power resource is still on when the root ports are runtime
suspended their dev->current_state is set to D3hot. When NHI is runtime
suspended TBT is finally turned off but state of the root ports remain
to be D3hot.

If the user now runs lspci for instance, the result is all 1's like in
the below output (07.0 is the first root port, RP0):

00:07.0 PCI bridge: Intel Corporation Device 8a1d (rev ff) (prog-if ff)
    !!! Unknown header type 7f
    Kernel driver in use: pcieport

I short the hardware state is not in sync with the software state
anymore. The exact same thing happens with the PME polling thread which
ends up bringing the root ports back into D0 after they are runtime
suspended.

ACPI core already sets the device state to be D3cold when it drops its
references to the power resources returned by _PR3 even if these power
resources are still physically on (other devices still reference them).
However, in PCI core we call acpi_device_get_power() to figure out the
power state and that returns the "real" power state based on the state
of its power resources.

To make it work with the shared power resources modify
acpi_pci_get_power_state() so that it reads the ACPI device power state
that was cached by the ACPI core. This makes the PCI device power state
match the ACPI device power state regardless of state of the shared
power resources that may still be on at this point.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci-acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1897847ceb0c..b782acac26c5 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -685,7 +685,8 @@ static pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
 	if (!adev || !acpi_device_power_manageable(adev))
 		return PCI_UNKNOWN;
 
-	if (acpi_device_get_power(adev, &state) || state == ACPI_STATE_UNKNOWN)
+	state = adev->power.state;
+	if (state == ACPI_STATE_UNKNOWN)
 		return PCI_UNKNOWN;
 
 	return state_conv[state];
-- 
2.20.1

