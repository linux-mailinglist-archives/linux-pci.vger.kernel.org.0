Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877AD2C3B97
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 10:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgKYJHq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 04:07:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:25668 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgKYJHp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 04:07:45 -0500
IronPort-SDR: QRB5odxTFJXJfJqucA8rlT71oKwuHzoEh8KVICPE/bNvv8aVmlm3dV6ec9/QHSQDnOxnthVYup
 eGG9SX+BlclQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="169534680"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="169534680"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 01:07:40 -0800
IronPort-SDR: r/2wKhWq1n7vFGX5CNljc9nmohQC6sOuejI+sx9rlhYOmxt0J6akTmBFi5FtYAh/7AYgCb+JOb
 iqKYU0aAq4tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="403208407"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 25 Nov 2020 01:07:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7F61F76; Wed, 25 Nov 2020 11:07:33 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lukas Wunner <lukas@wunner.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: Rename pci_wakeup_bus() to pci_resume_bus()
Date:   Wed, 25 Nov 2020 12:07:33 +0300
Message-Id: <20201125090733.77782-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125090733.77782-1-mika.westerberg@linux.intel.com>
References: <20201125090733.77782-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The previous commit changed the pci_wakeup_bus() to not to signal wakeup
event anymore so rename the function to better match what it does.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
This is new patch as suggested by Bjorn. This one only does the rename. I
added Rafael's tag here too as there are no other changes than the split.
Let me know if it's not OK.

 drivers/gpu/vga/vga_switcheroo.c |  2 +-
 drivers/pci/pci.c                | 15 +++++----------
 include/linux/pci.h              |  2 +-
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 087304b1a5d7..8843b078ad4e 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -1039,7 +1039,7 @@ static int vga_switcheroo_runtime_resume(struct device *dev)
 	mutex_lock(&vgasr_mutex);
 	vga_switcheroo_power_switch(pdev, VGA_SWITCHEROO_ON);
 	mutex_unlock(&vgasr_mutex);
-	pci_wakeup_bus(pdev->bus);
+	pci_resume_bus(pdev->bus);
 	ret = dev->bus->pm->runtime_resume(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6f7b33998fbe..0102cc973783 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1174,25 +1174,20 @@ int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state)
 }
 EXPORT_SYMBOL_GPL(pci_platform_power_transition);
 
-/**
- * pci_wakeup - Wake up a PCI device
- * @pci_dev: Device to handle.
- * @ign: ignored parameter
- */
-static int pci_wakeup(struct pci_dev *pci_dev, void *ign)
+static int pci_resume_one(struct pci_dev *pci_dev, void *ign)
 {
 	pm_request_resume(&pci_dev->dev);
 	return 0;
 }
 
 /**
- * pci_wakeup_bus - Walk given bus and wake up devices on it
+ * pci_resume_bus - Walk given bus and runtime resume devices on it
  * @bus: Top bus of the subtree to walk.
  */
-void pci_wakeup_bus(struct pci_bus *bus)
+void pci_resume_bus(struct pci_bus *bus)
 {
 	if (bus)
-		pci_walk_bus(bus, pci_wakeup, NULL);
+		pci_walk_bus(bus, pci_resume_one, NULL);
 }
 
 static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
@@ -1255,7 +1250,7 @@ int pci_power_up(struct pci_dev *dev)
 		 * may be powered on into D0uninitialized state, resume them to
 		 * give them a chance to suspend again
 		 */
-		pci_wakeup_bus(dev->subordinate);
+		pci_resume_bus(dev->subordinate);
 	}
 
 	return pci_raw_set_power_state(dev, PCI_D0);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22207a79762c..9256ef2e4327 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1271,7 +1271,7 @@ bool pci_dev_run_wake(struct pci_dev *dev);
 void pci_d3cold_enable(struct pci_dev *dev);
 void pci_d3cold_disable(struct pci_dev *dev);
 bool pcie_relaxed_ordering_enabled(struct pci_dev *dev);
-void pci_wakeup_bus(struct pci_bus *bus);
+void pci_resume_bus(struct pci_bus *bus);
 void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state);
 
 /* For use by arch with custom probe code */
-- 
2.29.2

