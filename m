Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56870EC9DE
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 21:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfKAUrP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 16:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbfKAUrP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 16:47:15 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92699217D9;
        Fri,  1 Nov 2019 20:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572641234;
        bh=SSkz3soRV0jdoMV7GQDwd9LGZExhDp/y3PEYxGNxQLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVoqK4iZZstPIyuKWWbEFzDm5toz63GhaArRo3fr0RbJXH38Yu90S9QnQSeUZp6GA
         MgdvB+9y8GOV1FAak3eTcsrCsba1SSCPxlKZi7t+7jD/9iLHwppKo5bZr51OX1xpy6
         Fu+YQ3KiBQrIL4hnYEg/sHXAI7x9oRodQwIWxgyY=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6/6] PCI/PM: Remove unused pci_driver.suspend_late() hook
Date:   Fri,  1 Nov 2019 15:45:58 -0500
Message-Id: <20191101204558.210235-7-helgaas@kernel.org>
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

The struct pci_driver.suspend_late() hook is one of the legacy PCI power
management callbacks, and there are no remaining users of it.  Remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/power/pci.rst | 10 +++++-----
 drivers/pci/pci-driver.c    | 22 +---------------------
 include/linux/pci.h         |  2 --
 3 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index ff7029b94068..0924d29636ad 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -692,11 +692,11 @@ controlling the runtime power management of their devices.
 At the time of this writing there are two ways to define power management
 callbacks for a PCI device driver, the recommended one, based on using a
 dev_pm_ops structure described in Documentation/driver-api/pm/devices.rst, and
-the "legacy" one, in which the .suspend(), .suspend_late(), and
-.resume() callbacks from struct pci_driver are used.  The legacy approach,
-however, doesn't allow one to define runtime power management callbacks and is
-not really suitable for any new drivers.  Therefore it is not covered by this
-document (refer to the source code to learn more about it).
+the "legacy" one, in which the .suspend() and .resume() callbacks from struct
+pci_driver are used.  The legacy approach, however, doesn't allow one to define
+runtime power management callbacks and is not really suitable for any new
+drivers.  Therefore it is not covered by this document (refer to the source code
+to learn more about it).
 
 It is recommended that all PCI device drivers define a struct dev_pm_ops object
 containing pointers to power management (PM) callbacks that will be executed by
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index fc372c2d529a..e89fd90eaa93 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -599,32 +599,12 @@ static int pci_legacy_suspend(struct device *dev, pm_message_t state)
 static int pci_legacy_suspend_late(struct device *dev, pm_message_t state)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct pci_driver *drv = pci_dev->driver;
-
-	if (drv && drv->suspend_late) {
-		pci_power_t prev = pci_dev->current_state;
-		int error;
-
-		error = drv->suspend_late(pci_dev, state);
-		suspend_report_result(drv->suspend_late, error);
-		if (error)
-			return error;
-
-		if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
-		    && pci_dev->current_state != PCI_UNKNOWN) {
-			pci_WARN_ONCE(pci_dev, pci_dev->current_state != prev,
-				      "PCI PM: Device state not saved by %pS\n",
-				      drv->suspend_late);
-			goto Fixup;
-		}
-	}
 
 	if (!pci_dev->state_saved)
 		pci_save_state(pci_dev);
 
 	pci_pm_set_unknown_state(pci_dev);
 
-Fixup:
 	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
 
 	return 0;
@@ -653,7 +633,7 @@ static void pci_pm_default_suspend(struct pci_dev *pci_dev)
 static bool pci_has_legacy_pm_support(struct pci_dev *pci_dev)
 {
 	struct pci_driver *drv = pci_dev->driver;
-	bool ret = drv && (drv->suspend || drv->suspend_late || drv->resume);
+	bool ret = drv && (drv->suspend || drv->resume);
 
 	/*
 	 * Legacy PM support is used by default, so warn if the new framework is
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dd4596fc1208..9b0e35e09874 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -805,7 +805,6 @@ struct module;
  *		The remove function always gets called from process
  *		context, so it can sleep.
  * @suspend:	Put device into low power state.
- * @suspend_late: Put device into low power state.
  * @resume:	Wake device from low power state.
  *		(Please see Documentation/power/pci.rst for descriptions
  *		of PCI Power Management and the related functions.)
@@ -828,7 +827,6 @@ struct pci_driver {
 	int  (*probe)(struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove)(struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
-	int  (*suspend_late)(struct pci_dev *dev, pm_message_t state);
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

