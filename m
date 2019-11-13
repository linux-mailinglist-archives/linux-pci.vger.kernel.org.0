Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F38DFB3EB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 16:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfKMPl0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 10:41:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:14518 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfKMPl0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 10:41:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 07:41:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="194705733"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2019 07:41:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 33DD5FD; Wed, 13 Nov 2019 17:41:23 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] ACPI / hotplug / PCI: Take runtime PM autosuspend into account
Date:   Wed, 13 Nov 2019 18:41:23 +0300
Message-Id: <20191113154123.75345-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe ports (the only ones we do runtime PM) are using runtime PM
autosuspend to keep the port powered on for a while after it becomes
idle. However, ACPI hotplug does not take this into account so if we get
multiple hotplug events in a short period of time we may be powering
ports on and off and then back on unnecessarily.

For this reason call pm_runtime_put_autosuspend() for them (with the
accompanying pm_runtime_mark_last_busy()).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index b3869951c0eb..c8264af40643 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -672,7 +672,8 @@ static void trim_stale_devices(struct pci_dev *dev)
 		list_for_each_entry_safe_reverse(child, tmp, &bus->devices, bus_list)
 			trim_stale_devices(child);
 
-		pm_runtime_put(&dev->dev);
+		pm_runtime_mark_last_busy(&dev->dev);
+		pm_runtime_put_autosuspend(&dev->dev);
 	}
 }
 
@@ -714,8 +715,10 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
 		}
 	}
 
-	if (bridge->pci_dev)
-		pm_runtime_put(&bridge->pci_dev->dev);
+	if (bridge->pci_dev) {
+		pm_runtime_mark_last_busy(&bridge->pci_dev->dev);
+		pm_runtime_put_autosuspend(&bridge->pci_dev->dev);
+	}
 }
 
 /*
-- 
2.24.0

