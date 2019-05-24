Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AA329DB8
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 20:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfEXSH0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 14:07:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55576 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfEXSH0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2019 14:07:26 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hUEbA-0004vM-1b; Fri, 24 May 2019 18:07:20 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com, rafael.j.wysocki@intel.com
Cc:     stern@rowland.harvard.edu, lukas@wunner.de,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v3] PCI / PM: Don't runtime suspend when device only supports wakeup from D0
Date:   Sat, 25 May 2019 02:07:16 +0800
Message-Id: <20190524180716.13124-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There's an xHCI device that doesn't wake when a USB device gets plugged
to its USB port. The driver's own runtime suspend callback was called,
PME signaling was enabled, but it stays at PCI D0:
  Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-

A PCI device can be runtime suspended while still stays at D0 when it
supports D0 PME and its _S0W reports D0. Theoretically this should work,
but as [1] specifies, D0 doesn't have wakeup capability.

To avoid this problematic situation, we should avoid runtime suspend if
D0 is the only state that can wake up the device. If the deivce doesn't
require wakeup capability, carry out driver's runtime suspend as usual,
which may have logic to save its power internally.

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/device-working-state-d0

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203673
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Add Bugzilla link
v2:
 - Changes wording
 - Keep old behaviour for devices can't wakeup.

 drivers/pci/pci-driver.c | 6 ++++++
 drivers/pci/pci.c        | 2 +-
 include/linux/pci.h      | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index cae630fe6387..e3fac1d2a265 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1239,6 +1239,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	pci_power_t prev = pci_dev->current_state;
+	bool wakeup = device_can_wakeup(dev);
 	int error;
 
 	/*
@@ -1251,6 +1252,11 @@ static int pci_pm_runtime_suspend(struct device *dev)
 		return 0;
 	}
 
+	if (wakeup && pci_target_state(pci_dev, wakeup) == PCI_D0) {
+		dev_dbg(dev, "D0 doesn't have wakeup capability\n");
+		return -EBUSY;
+	}
+
 	pci_dev->state_saved = false;
 	if (pm && pm->runtime_suspend) {
 		error = pm->runtime_suspend(dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8abc843b1615..ceee6efbbcfe 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2294,7 +2294,7 @@ EXPORT_SYMBOL(pci_wake_from_d3);
  * If the platform can't manage @dev, return the deepest state from which it
  * can generate wake events, based on any available PME info.
  */
-static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
+pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 {
 	pci_power_t target_state = PCI_D3hot;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4a5a84d7bdd4..91e8dc4d04aa 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1188,6 +1188,7 @@ bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 void pci_pme_active(struct pci_dev *dev, bool enable);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable);
 int pci_wake_from_d3(struct pci_dev *dev, bool enable);
+pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup);
 int pci_prepare_to_sleep(struct pci_dev *dev);
 int pci_back_from_sleep(struct pci_dev *dev);
 bool pci_dev_run_wake(struct pci_dev *dev);
@@ -1672,6 +1673,8 @@ static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 { return 0; }
 static inline int pci_wake_from_d3(struct pci_dev *dev, bool enable)
 { return 0; }
+pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
+{ return PCI_D0; }
 static inline pci_power_t pci_choose_state(struct pci_dev *dev,
 					   pm_message_t state)
 { return PCI_D0; }
-- 
2.17.1

