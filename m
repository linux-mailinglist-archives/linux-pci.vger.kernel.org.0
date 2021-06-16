Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1D43A9E85
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 17:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhFPPHY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 11:07:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:37805 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234416AbhFPPHY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 11:07:24 -0400
IronPort-SDR: 06CKFcXiwGbOlw6MdLe1VpW3tZ9axn186oGYRxfMc2GQVOKC35GMB/iEBT1NTjOQjXQ/TTII6B
 WOecS+e+Setg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="193502320"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="193502320"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 08:04:54 -0700
IronPort-SDR: mLIl58gwUjR49jdfruxjRGKqoIPPsUvbfhumLQiciw9wgTtT6M1W5wkOx1DqkA8MNKZ5e12xZd
 ldDifm6+J9Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="479122147"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2021 08:04:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C70C82DA; Wed, 16 Jun 2021 18:05:16 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 RESEND] PCI/PM: Target PM state is D3hot if device can only generate PME from D3cold
Date:   Wed, 16 Jun 2021 18:05:16 +0300
Message-Id: <20210616150516.28242-1-mika.westerberg@linux.intel.com>
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
in D0 we modify pci_target_state() to return D3hot in this special case
and make __pci_enable_wake() to enable PME too in this case.

Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
Reported-by: Koba Ko <koba.ko@canonical.com>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Hi all,

This is third version of the patch. I changed this according to what Rafael
suggested, so that the pci_target_state() returns D3hot for these devices
and pci_enable_wake() then enables PME from D3cold. This solves the problem
in my test system.

@Utkarsh, @Koba, I appreciate if you could try this one too.

I also dropped the Tested-by tag from Koba Ko and Acked-by from Kai-Heng
Feng as this is not the same patch anymore.

The previous version can be seen here:

https://lore.kernel.org/linux-pci/20210531133435.53259-1-mika.westerberg@linux.intel.com/

Resending with linux-pm list included.

 drivers/pci/pci.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b717680377a9..6605f85a1d63 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2485,7 +2485,13 @@ static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable
 	if (enable) {
 		int error;
 
-		if (pci_pme_capable(dev, state))
+		/*
+		 * Enable PME if device is capable from given state.
+		 * Special case is device that can only generate PME
+		 * from D3cold then we enable PME too.
+		 */
+		if (pci_pme_capable(dev, state) ||
+		    (state == PCI_D3hot && pci_pme_capable(dev, PCI_D3cold)))
 			pci_pme_active(dev, true);
 		else
 			ret = 1;
@@ -2595,6 +2601,16 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 		 * PME#.
 		 */
 		if (dev->pme_support) {
+			/*
+			 * Special case if device supports only PME from
+			 * D3cold but not from D3hot we still return
+			 * D3hot.
+			 */
+			if (target_state == PCI_D3hot &&
+				!(dev->pme_support & (1 << PCI_D3hot)) &&
+				(dev->pme_support & (1 << PCI_D3cold)))
+				return target_state;
+
 			while (target_state
 			      && !(dev->pme_support & (1 << target_state)))
 				target_state--;
-- 
2.30.2

