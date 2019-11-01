Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38005EC9DA
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 21:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfKAUrF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 16:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbfKAUrF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 16:47:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA452217D9;
        Fri,  1 Nov 2019 20:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572641223;
        bh=F7PH70pV5iRcDB3FWGQpi2C/PscRlDn66LS+BKMC4sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4tkuro0wOn5dPQ8WBjCh2r44pELA50BZy/uS36TXmatniQIZwi0bCllaOZ67hkGq
         ywdYWBhJ4ADTy/X0htOsuScHqSNrPYkes7Urq+B6bAtgKXh3NXrgG4s6F6VnjFOIXl
         QKYyHTrhfXTG4Vt6SOGLHDCMJ6d7jEdce8GNK3uA=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/6] PCI/PM: Remove unused pci_driver.resume_early() hook
Date:   Fri,  1 Nov 2019 15:45:57 -0500
Message-Id: <20191101204558.210235-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191101204558.210235-1-helgaas@kernel.org>
References: <20191101204558.210235-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The struct pci_driver.resume_early() hook is one of the legacy PCI power
management callbacks, and there are no remaining users of it.  Remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/power/pci.rst |  2 +-
 drivers/pci/pci-driver.c    | 23 ++++++-----------------
 include/linux/pci.h         |  2 --
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index a90e82c70a3b..ff7029b94068 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -692,7 +692,7 @@ controlling the runtime power management of their devices.
 At the time of this writing there are two ways to define power management
 callbacks for a PCI device driver, the recommended one, based on using a
 dev_pm_ops structure described in Documentation/driver-api/pm/devices.rst, and
-the "legacy" one, in which the .suspend(), .suspend_late(), .resume_early(), and
+the "legacy" one, in which the .suspend(), .suspend_late(), and
 .resume() callbacks from struct pci_driver are used.  The legacy approach,
 however, doesn't allow one to define runtime power management callbacks and is
 not really suitable for any new drivers.  Therefore it is not covered by this
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 5337cbbd69de..fc372c2d529a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -630,15 +630,6 @@ static int pci_legacy_suspend_late(struct device *dev, pm_message_t state)
 	return 0;
 }
 
-static int pci_legacy_resume_early(struct device *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct pci_driver *drv = pci_dev->driver;
-
-	return drv && drv->resume_early ?
-			drv->resume_early(pci_dev) : 0;
-}
-
 static int pci_legacy_resume(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -662,8 +653,7 @@ static void pci_pm_default_suspend(struct pci_dev *pci_dev)
 static bool pci_has_legacy_pm_support(struct pci_dev *pci_dev)
 {
 	struct pci_driver *drv = pci_dev->driver;
-	bool ret = drv && (drv->suspend || drv->suspend_late || drv->resume
-		|| drv->resume_early);
+	bool ret = drv && (drv->suspend || drv->suspend_late || drv->resume);
 
 	/*
 	 * Legacy PM support is used by default, so warn if the new framework is
@@ -944,7 +934,7 @@ static int pci_pm_resume_noirq(struct device *dev)
 	pcie_pme_root_status_cleanup(pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_resume_early(dev);
+		return 0;
 
 	if (pm && pm->resume_noirq)
 		return pm->resume_noirq(dev);
@@ -1074,9 +1064,8 @@ static int pci_pm_thaw_noirq(struct device *dev)
 	}
 
 	/*
-	 * Both the legacy ->resume_early() and the new pm->thaw_noirq()
-	 * callbacks assume the device has been returned to D0 and its
-	 * config state has been restored.
+	 * The pm->thaw_noirq() callback assumes the device has been
+	 * returned to D0 and its config state has been restored.
 	 *
 	 * In addition, pci_restore_state() restores MSI-X state in MMIO
 	 * space, which requires the device to be in D0, so return it to D0
@@ -1087,7 +1076,7 @@ static int pci_pm_thaw_noirq(struct device *dev)
 	pci_restore_state(pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_resume_early(dev);
+		return 0;
 
 	if (pm && pm->thaw_noirq)
 		return pm->thaw_noirq(dev);
@@ -1219,7 +1208,7 @@ static int pci_pm_restore_noirq(struct device *dev)
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_resume_early(dev);
+		return 0;
 
 	if (pm && pm->restore_noirq)
 		return pm->restore_noirq(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4846306d521c..dd4596fc1208 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -806,7 +806,6 @@ struct module;
  *		context, so it can sleep.
  * @suspend:	Put device into low power state.
  * @suspend_late: Put device into low power state.
- * @resume_early: Wake device from low power state.
  * @resume:	Wake device from low power state.
  *		(Please see Documentation/power/pci.rst for descriptions
  *		of PCI Power Management and the related functions.)
@@ -830,7 +829,6 @@ struct pci_driver {
 	void (*remove)(struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*suspend_late)(struct pci_dev *dev, pm_message_t state);
-	int  (*resume_early)(struct pci_dev *dev);
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

