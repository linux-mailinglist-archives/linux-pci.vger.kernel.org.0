Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619D7F2E0B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 13:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbfKGMSy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 07:18:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:62176 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfKGMSy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 07:18:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 04:18:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="213008221"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Nov 2019 04:18:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 184A1115; Thu,  7 Nov 2019 14:18:47 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] PCI: Add missing link delays
Date:   Thu,  7 Nov 2019 15:18:45 +0300
Message-Id: <20191107121847.24781-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This is third version of the reworked PCIe link delay patch posted earlier
here:

  v2: https://lore.kernel.org/linux-pci/20191004123947.11087-1-mika.westerberg@linux.intel.com/
  v1: https://patchwork.kernel.org/patch/11106611/

Changes from v2:

  * Rebased on top of pci.git/pci/pm.
  * Update references to PCIe 5.0 spec.
  * Take d3cold_delay if child devices into account. This allows ACPI _DSM
    to lower the delay.
  * Check for pci_dev->skip_bus_pm in pci_pm_resume_noirq().
  * Drop comment that mentions pciehp where
    pci_bridge_wait_for_secondary_bus() is called.
  * Use pcie_downstream_port() in pci_bridge_wait_for_secondary_bus().

Based on the discussion around v2 there is a potential issue when restoring
PCI_EXP_LNKCTL2 (regardless these patches) that we may need to retrain the
link. This series does not include fix for that since it is not yet clear
how we solve it. I can do that as a separate patch once we agree on the
solution.

I'm submitting these two now in hopes that we can get them included for
v5.5 because there are systems out there that need them in order to
function properly.

Changes from v1:

  * Introduce pcie_wait_for_link_delay() in a separate patch
  * Tidy up changelog, remove some debug output
  * Rename pcie_wait_downstream_accessible() to
    pci_bridge_wait_for_secondary_bus() and make it generic to all PCI
    bridges.
  * Handle Tpvrh + Trhfa for conventional PCI even though we don't do PM
    for them right now.
  * Use pci_dbg() instead of dev_dbg().
  * Dropped check for pm_suspend_no_platform() and only check for D3cold.
  * Drop pcie_get_downstream_delay(), same delay applies equally to all
    devices (it is not entirely clear from the spec).

Mika Westerberg (2):
  PCI: Introduce pcie_wait_for_link_delay()
  PCI: Add missing link delays required by the PCIe spec

 drivers/pci/pci-driver.c |  11 +++-
 drivers/pci/pci.c        | 139 ++++++++++++++++++++++++++++++++++++---
 drivers/pci/pci.h        |   1 +
 3 files changed, 141 insertions(+), 10 deletions(-)

-- 
2.24.0.rc1

