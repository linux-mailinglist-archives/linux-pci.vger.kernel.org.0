Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A463781FF
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 12:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhEJKbj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 06:31:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:31359 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231495AbhEJKaF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 May 2021 06:30:05 -0400
IronPort-SDR: OiGv3ZZMUx1QZbbjlS3L4w54r7uzFHBKcbKnxUeYyvhdTkhe7/8TMw6GFVN/ncCs1yAn24R0NQ
 ohU9MgEnJ/hw==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="196067025"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="196067025"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 03:26:29 -0700
IronPort-SDR: YR/nsUJwkcE9h57W6Us4z7c6btkeJa3+OZzUX1Q0/HfvDysq4GXtgfZI4zadaipYxnrAY0wd7h
 LNt7ijrfIwrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="398833774"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 10 May 2021 03:26:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id EF988D7; Mon, 10 May 2021 13:26:47 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/PM: Target PM state is D3cold if the upstream bridge is power manageable
Date:   Mon, 10 May 2021 13:26:47 +0300
Message-Id: <20210510102647.40322-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ASMedia xHCI controller only supports PME from D3cold:

11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
  ...
  Capabilities: [78] Power Management version 3
  	  Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
	  Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Now, if the controller is part of a Thunderbolt device for instance, it
is connected to a PCIe switch downstream port. When the hierarchy then
enters D3cold as a result of s2idle cycle pci_target_state() returns D0
because the device does not support PME from the default target_state
(D3hot). So what happens is that the whole hierarchy is left into D0
breaking power management.

For this reason choose target_state to be D3cold if there is a upstream
bridge that is power manageable. The reasoning here is that the upstream
bridge will be also placed into D3 making the effective power state of
the device in question to be D3cold.

Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
Reported-by: Koba Ko <koba.ko@canonical.com>
Tested-by: Koba Ko <koba.ko@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b717680377a9..e3f3b9010762 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2578,8 +2578,19 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 		return target_state;
 	}
 
-	if (!dev->pm_cap)
+	if (!dev->pm_cap) {
 		target_state = PCI_D0;
+	} else {
+		struct pci_dev *bridge;
+
+		/*
+		 * If the upstream bridge can be put to D3 then it means
+		 * that our target state is D3cold instead of D3hot.
+		 */
+		bridge = pci_upstream_bridge(dev);
+		if (bridge && pci_bridge_d3_possible(bridge))
+			target_state = PCI_D3cold;
+	}
 
 	/*
 	 * If the device is in D3cold even though it's not power-manageable by
-- 
2.30.2

