Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABAF5DB905
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 23:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503629AbfJQV3G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 17:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbfJQV3E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 17:29:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EC5521D7A;
        Thu, 17 Oct 2019 21:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571347743;
        bh=j7zh1mvjgnbLlrLEg0jZQ1d4/6qSUS30PoJk196vWi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTFb6uHfG/KwbOLYb7b2V7owWfoakFzhRsPcayuF4R2WuhjG0PQBYXwDlVzxDrq19
         MkdHjK99NHU7BBuCEAC/8oUtNJvjnsPZFZjBG4ft6j1/EH2Tq9BztVQOd9eOMhySO+
         4cDtH+ciNok+U8bCACILfuTEhAQxWCIxGroN56Ek=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI/PM: Use pci_WARN() to include device information
Date:   Thu, 17 Oct 2019 16:28:51 -0500
Message-Id: <20191017212851.54237-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191017212851.54237-1-helgaas@kernel.org>
References: <20191017212851.54237-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Add and use pci_WARN() wrappers so warnings include device information.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c | 34 +++++++++++++++++-----------------
 include/linux/pci.h      |  8 ++++++++
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 407b1df5ea7c..5337cbbd69de 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -585,9 +585,9 @@ static int pci_legacy_suspend(struct device *dev, pm_message_t state)
 
 		if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
 		    && pci_dev->current_state != PCI_UNKNOWN) {
-			WARN_ONCE(pci_dev->current_state != prev,
-				"PCI PM: Device state not saved by %pS\n",
-				drv->suspend);
+			pci_WARN_ONCE(pci_dev, pci_dev->current_state != prev,
+				      "PCI PM: Device state not saved by %pS\n",
+				      drv->suspend);
 		}
 	}
 
@@ -612,9 +612,9 @@ static int pci_legacy_suspend_late(struct device *dev, pm_message_t state)
 
 		if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
 		    && pci_dev->current_state != PCI_UNKNOWN) {
-			WARN_ONCE(pci_dev->current_state != prev,
-				"PCI PM: Device state not saved by %pS\n",
-				drv->suspend_late);
+			pci_WARN_ONCE(pci_dev, pci_dev->current_state != prev,
+				      "PCI PM: Device state not saved by %pS\n",
+				      drv->suspend_late);
 			goto Fixup;
 		}
 	}
@@ -670,8 +670,8 @@ static bool pci_has_legacy_pm_support(struct pci_dev *pci_dev)
 	 * supported as well.  Drivers are supposed to support either the
 	 * former, or the latter, but not both at the same time.
 	 */
-	WARN(ret && drv->driver.pm, "driver %s device %04x:%04x\n",
-		drv->name, pci_dev->vendor, pci_dev->device);
+	pci_WARN(pci_dev, ret && drv->driver.pm, "device %04x:%04x\n",
+		 pci_dev->vendor, pci_dev->device);
 
 	return ret;
 }
@@ -794,9 +794,9 @@ static int pci_pm_suspend(struct device *dev)
 
 		if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
 		    && pci_dev->current_state != PCI_UNKNOWN) {
-			WARN_ONCE(pci_dev->current_state != prev,
-				"PCI PM: State of device not saved by %pS\n",
-				pm->suspend);
+			pci_WARN_ONCE(pci_dev, pci_dev->current_state != prev,
+				      "PCI PM: State of device not saved by %pS\n",
+				      pm->suspend);
 		}
 	}
 
@@ -842,9 +842,9 @@ static int pci_pm_suspend_noirq(struct device *dev)
 
 		if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
 		    && pci_dev->current_state != PCI_UNKNOWN) {
-			WARN_ONCE(pci_dev->current_state != prev,
-				"PCI PM: State of device not saved by %pS\n",
-				pm->suspend_noirq);
+			pci_WARN_ONCE(pci_dev, pci_dev->current_state != prev,
+				      "PCI PM: State of device not saved by %pS\n",
+				      pm->suspend_noirq);
 			goto Fixup;
 		}
 	}
@@ -1311,9 +1311,9 @@ static int pci_pm_runtime_suspend(struct device *dev)
 	if (pm && pm->runtime_suspend
 	    && !pci_dev->state_saved && pci_dev->current_state != PCI_D0
 	    && pci_dev->current_state != PCI_UNKNOWN) {
-		WARN_ONCE(pci_dev->current_state != prev,
-			"PCI PM: State of device not saved by %pS\n",
-			pm->runtime_suspend);
+		pci_WARN_ONCE(pci_dev, pci_dev->current_state != prev,
+			      "PCI PM: State of device not saved by %pS\n",
+			      pm->runtime_suspend);
 		return 0;
 	}
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f9088c89a534..4846306d521c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2400,4 +2400,12 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #define pci_info_ratelimited(pdev, fmt, arg...) \
 	dev_info_ratelimited(&(pdev)->dev, fmt, ##arg)
 
+#define pci_WARN(pdev, condition, fmt, arg...) \
+	WARN(condition, "%s %s: " fmt, \
+	     dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
+
+#define pci_WARN_ONCE(pdev, condition, fmt, arg...) \
+	WARN_ONCE(condition, "%s %s: " fmt, \
+		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
+
 #endif /* LINUX_PCI_H */
-- 
2.23.0.866.gb869b98d4c-goog

