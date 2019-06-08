Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0076439DDC
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jun 2019 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfFHLof (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Jun 2019 07:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbfFHLna (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Jun 2019 07:43:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ABF1216C4;
        Sat,  8 Jun 2019 11:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994209;
        bh=ZLLShTtUBrOnW/b5fc8VWjR98PKOGJuRSeWTS8qGz3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3XijrGrmOSsLvMksGbJ7O0D6bRA7/lAhfmRWECrFeq2sN1akY4b9He6YvconEtZI
         1p7D+3znX2MhSqYJb8yiVQhKtf2SdQW/JUKWGnBvq37kumvLLTW3KtzXGKe1BNEaFE
         NBvLCs67iW5Q1oCLrkl8wP4oqr2iELaPa2b+RmN8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 21/49] PCI: PM: Avoid possible suspend-to-idle issue
Date:   Sat,  8 Jun 2019 07:42:02 -0400
Message-Id: <20190608114232.8731-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608114232.8731-1-sashal@kernel.org>
References: <20190608114232.8731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit d491f2b75237ef37d8867830ab7fad8d9659e853 ]

If a PCI driver leaves the device handled by it in D0 and calls
pci_save_state() on the device in its ->suspend() or ->suspend_late()
callback, it can expect the device to stay in D0 over the whole
s2idle cycle.  However, that may not be the case if there is a
spurious wakeup while the system is suspended, because in that case
pci_pm_suspend_noirq() will run again after pci_pm_resume_noirq()
which calls pci_restore_state(), via pci_pm_default_resume_early(),
so state_saved is cleared and the second iteration of
pci_pm_suspend_noirq() will invoke pci_prepare_to_sleep() which
may change the power state of the device.

To avoid that, add a new internal flag, skip_bus_pm, that will be set
by pci_pm_suspend_noirq() when it runs for the first time during the
given system suspend-resume cycle if the state of the device has
been saved already and the device is still in D0.  Setting that flag
will cause the next iterations of pci_pm_suspend_noirq() to set
state_saved for pci_pm_resume_noirq(), so that it always restores the
device state from the originally saved data, and avoid calling
pci_prepare_to_sleep() for the device.

Fixes: 33e4f80ee69b ("ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-driver.c | 17 ++++++++++++++++-
 include/linux/pci.h      |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 33f3f475e5c6..7430f993567f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -734,6 +734,8 @@ static int pci_pm_suspend(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	pci_dev->skip_bus_pm = false;
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_SUSPEND);
 
@@ -827,7 +829,20 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		}
 	}
 
-	if (!pci_dev->state_saved) {
+	if (pci_dev->skip_bus_pm) {
+		/*
+		 * The function is running for the second time in a row without
+		 * going through full resume, which is possible only during
+		 * suspend-to-idle in a spurious wakeup case.  Moreover, the
+		 * device was originally left in D0, so its power state should
+		 * not be changed here and the device register values saved
+		 * originally should be restored on resume again.
+		 */
+		pci_dev->state_saved = true;
+	} else if (pci_dev->state_saved) {
+		if (pci_dev->current_state == PCI_D0)
+			pci_dev->skip_bus_pm = true;
+	} else {
 		pci_save_state(pci_dev);
 		if (pci_power_manageable(pci_dev))
 			pci_prepare_to_sleep(pci_dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b1f297f4b7b0..94853094b6ef 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -342,6 +342,7 @@ struct pci_dev {
 						   D3cold, not set for devices
 						   powered on/off by the
 						   corresponding bridge */
+	unsigned int	skip_bus_pm:1;	/* Internal: Skip bus-level PM */
 	unsigned int	ignore_hotplug:1;	/* Ignore hotplug events */
 	unsigned int	hotplug_user_indicators:1; /* SlotCtl indicators
 						      controlled exclusively by
-- 
2.20.1

