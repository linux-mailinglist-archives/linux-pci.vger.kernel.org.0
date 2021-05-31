Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B37395DA5
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 15:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhEaNs3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 09:48:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:64675 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232211AbhEaNq1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 May 2021 09:46:27 -0400
IronPort-SDR: rWIiFXlmH4zdN3MQHcGuH9XDSdfOgk73Sjb4KfLor2/0vDNIiNEf5VZ8+rjl7jpxS4SrdZ9IZA
 NAyH1zFDHpPA==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="203364532"
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="203364532"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 06:34:15 -0700
IronPort-SDR: uur1sQVNisXsHxx4ZLLEnPKTrgJXKdL2G2SyRHCCUtZDYUL8ROPLb+j5XnVHubbratyEjtJWHK
 o4jVMcFUPSug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="616538368"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 31 May 2021 06:34:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0CEF312A; Mon, 31 May 2021 16:34:35 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI/PM: Target PM state is D3cold if the upstream bridge is power manageable
Date:   Mon, 31 May 2021 16:34:35 +0300
Message-Id: <20210531133435.53259-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCIe devices only support PME (Power Management Event) from D3cold.
One example is ASMedia xHCI controller:

11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
  ...
  Capabilities: [78] Power Management version 3
  	  Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
	  Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

With such devices, if it has wake enabled, the kernel selects lowest
possible power state to be D0 in pci_target_state(). This is problematic
because it prevents the root port it is connected to enter low power
state too which makes the system consume more energy than necessary.

The problem in pci_target_state() is that it only accounts the "current"
device state, so when the bridge above it (a root port for instance) is
transitioned into D3hot the device transitions into D3cold. This is
because when the root port is first transitioned into D3hot then the
ACPI power resource is turned off which puts the PCIe link to L2/L3 (and
the root port and the device are in D3cold). If the root port is kept in
D3hot it still means that the device below it is still effectively in
D3cold as no configuration messages pass through. Furthermore the
implementation note of PCIe 5.0 sec 5.3.1.4 says that the device should
expect to be transitioned into D3cold soon after its link transitions
into L2/L3 Ready state.

Taking the above into consideration, instead of forcing the device stay
in D0 we look at the upstream bridge and whether it is allowed to enter
D3 (hot/cold). If this is the case we conclude that the actual target
state of the device is D3cold. This also follows the logic in
pci_set_power_state() that sets power state of the subordinate devices
to D3cold after the bridge itself is transitioned into D3cold.

Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
Reported-by: Koba Ko <koba.ko@canonical.com>
Tested-by: Koba Ko <koba.ko@canonical.com>
Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Previous version of the patch can be found here:

  https://patchwork.kernel.org/project/linux-pci/patch/20210510102647.40322-1-mika.westerberg@linux.intel.com/

Changes from the previous version:

  * Added Ack from Kai-Heng
  * Reworked the commit log according to Bjorn's comments (I tried my best
    to answer the questions and explain the issue).
  * Expanded the comment to mention why the target state is D3cold.

 drivers/pci/pci.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b717680377a9..71c6a6437406 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2578,8 +2578,21 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 		return target_state;
 	}
 
-	if (!dev->pm_cap)
+	if (!dev->pm_cap) {
 		target_state = PCI_D0;
+	} else {
+		struct pci_dev *bridge;
+
+		/*
+		 * Look at the upstream bridge and whether it is allowed to
+		 * enter D3hot (or D3cold). In both cases this device is
+		 * not accessible anymore and its effective power state
+		 * becomes D3cold.
+		 */
+		bridge = pci_upstream_bridge(dev);
+		if (bridge && pci_bridge_d3_possible(bridge))
+			target_state = PCI_D3cold;
+	}
 
 	/*
 	 * If the device is in D3cold even though it's not power-manageable by
-- 
2.30.2

