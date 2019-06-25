Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCDE52987
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 12:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfFYKaF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 06:30:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:62003 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731984AbfFYK3r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 06:29:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 03:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,415,1557212400"; 
   d="scan'208";a="166635608"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 25 Jun 2019 03:29:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 387E5130; Tue, 25 Jun 2019 13:29:43 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 1/3] PCI / ACPI: Use cached ACPI device state to get PCI device power state
Date:   Tue, 25 Jun 2019 13:29:40 +0300
Message-Id: <20190625102942.27740-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625102942.27740-1-mika.westerberg@linux.intel.com>
References: <20190625102942.27740-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ACPI power state returned by acpi_device_get_power() may depend on
the configuration of ACPI power resources in the system which may change
any time after acpi_device_get_power() has returned, unless the
reference counters of the ACPI power resources in question are set to
prevent that from happening. Thus it is invalid to use acpi_device_get_power()
in acpi_pci_get_power_state() the way it is done now and the value of
the ->power.state field in the corresponding struct acpi_device objects
(which reflects the ACPI power resources reference counting, among other
things) should be used instead.

As an example where this becomes an issue is Intel Ice Lake where the
Thunderbolt controller (NHI), two PCIe root ports (RP0 and RP1) and xHCI
all share the same power resources. The following picture with power
resources marked with [] shows the topology:

  Host bridge
    |
    +- RP0 ---\
    +- RP1 ---|--+--> [TBT]
    +- NHI --/   |
    |            |
    |            v
    +- xHCI --> [D3C]

Here TBT and D3C are the shared ACPI power resources. ACPI _PR3() method
of the devices in question returns either TBT or D3C or both.

Say we runtime suspend first the root ports RP0 and RP1, then NHI. Now
since the TBT power resource is still on when the root ports are runtime
suspended their dev->current_state is set to D3hot. When NHI is runtime
suspended TBT is finally turned off but state of the root ports remain
to be D3hot. Now when the xHCI is runtime suspended D3C gets also turned
off. PCI core thus has power states of these devices cached in their
dev->current_state as follows:

  RP0 -> D3hot
  RP1 -> D3hot
  NHI -> D3cold
  xHCI -> D3cold

If the user now runs lspci for instance, the result is all 1's like in
the below output (00:07.0 is the first root port, RP0):

00:07.0 PCI bridge: Intel Corporation Device 8a1d (rev ff) (prog-if ff)
    !!! Unknown header type 7f
    Kernel driver in use: pcieport

In short the hardware state is not in sync with the software state
anymore. The exact same thing happens with the PME polling thread which
ends up bringing the root ports back into D0 after they are runtime
suspended.

For this reason, modify acpi_pci_get_power_state() so that it uses the
ACPI device power state that was cached by the ACPI core. This makes the
PCI device power state match the ACPI device power state regardless of
state of the shared power resources which may still be on at this point.

Link: https://lore.kernel.org/r/20190618161858.77834-2-mika.westerberg@linux.intel.com
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

