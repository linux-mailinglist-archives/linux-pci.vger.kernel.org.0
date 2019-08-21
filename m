Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C34BF979CA
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 14:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfHUMpZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 08:45:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:58834 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfHUMpZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Aug 2019 08:45:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="178492476"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 21 Aug 2019 05:45:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1A64A1987; Wed, 21 Aug 2019 15:45:20 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Andree <matthias.andree@gmx.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Add missing link delays required by the PCIe spec
Date:   Wed, 21 Aug 2019 15:45:19 +0300
Message-Id: <20190821124519.71594-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently Linux does not follow PCIe spec regarding the required delays
after reset. A concrete example is a Thunderbolt add-in-card that
consists of a PCIe switch and two PCIe endpoints:

  +-1b.0-[01-6b]----00.0-[02-6b]--+-00.0-[03]----00.0 TBT controller
                                  +-01.0-[04-36]-- DS hotplug port
                                  +-02.0-[37]----00.0 xHCI controller
                                  \-04.0-[38-6b]-- DS hotplug port

The root port (1b.0) and the PCIe switch downstream ports are all PCIe
gen3 so they support 8GT/s link speeds.

We wait for the PCIe hierarchy to enter D3cold (runtime):

  pcieport 0000:00:1b.0: power state changed by ACPI to D3cold

When it wakes up from D3cold, according to the PCIe 4.0 section 5.8 the
PCIe switch is put to reset and its power is re-applied. This means that
we must follow the rules in PCIe 4.0 section 6.6.1.

For the PCIe gen3 ports we are dealing with here, the following applies:

  With a Downstream Port that supports Link speeds greater than 5.0
  GT/s, software must wait a minimum of 100 ms after Link training
  completes before sending a Configuration Request to the device
  immediately below that Port. Software can determine when Link training
  completes by polling the Data Link Layer Link Active bit or by setting
  up an associated interrupt (see Section 6.7.3.3).

Translating this into the above topology we would need to do this (DLLLA
stands for Data Link Layer Link Active):

  pcieport 0000:00:1b.0: wait for 100ms after DLLLA is set before access to 0000:01:00.0
  pcieport 0000:02:00.0: wait for 100ms after DLLLA is set before access to 0000:03:00.0
  pcieport 0000:02:02.0: wait for 100ms after DLLLA is set before access to 0000:37:00.0

I've instrumented the kernel with additional logging so we can see the
actual delays the kernel performs:

  pcieport 0000:00:1b.0: power state changed by ACPI to D0
  pcieport 0000:00:1b.0: waiting for D3cold delay of 100 ms
  pcieport 0000:00:1b.0: waking up bus
  pcieport 0000:00:1b.0: waiting for D3hot delay of 10 ms
  pcieport 0000:00:1b.0: restoring config space at offset 0x2c (was 0x60, writing 0x60)
  ...
  pcieport 0000:00:1b.0: PME# disabled
  pcieport 0000:01:00.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
  ...
  pcieport 0000:01:00.0: PME# disabled
  pcieport 0000:02:00.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
  ...
  pcieport 0000:02:00.0: PME# disabled
  pcieport 0000:02:01.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
  ...
  pcieport 0000:02:01.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100407)
  pcieport 0000:02:01.0: PME# disabled
  pcieport 0000:02:02.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
  ...
  pcieport 0000:02:02.0: PME# disabled
  pcieport 0000:02:04.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
  ...
  pcieport 0000:02:04.0: PME# disabled
  pcieport 0000:02:01.0: PME# enabled
  pcieport 0000:02:01.0: waiting for D3hot delay of 10 ms
  pcieport 0000:02:04.0: PME# enabled
  pcieport 0000:02:04.0: waiting for D3hot delay of 10 ms
  thunderbolt 0000:03:00.0: restoring config space at offset 0x14 (was 0x0, writing 0x8a040000)
  ...
  thunderbolt 0000:03:00.0: PME# disabled
  xhci_hcd 0000:37:00.0: restoring config space at offset 0x10 (was 0x0, writing 0x73f00000)
  ...
  xhci_hcd 0000:37:00.0: PME# disabled

For the switch upstream port (01:00.0) we wait for 100ms but not taking
into account the DLLLA requirement. We then wait 10ms for D3hot -> D0
transition of the root port and the two downstream hotplug ports. This
means that we deviate from what the spec requires.

Performing the same check for system sleep (s2idle) transitions we can
see following when resuming from s2idle:

  pcieport 0000:00:1b.0: power state changed by ACPI to D0
  pcieport 0000:00:1b.0: restoring config space at offset 0x2c (was 0x60, writing 0x60)
  ...
  pcieport 0000:01:00.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
  ...
  pcieport 0000:02:02.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
  pcieport 0000:02:02.0: restoring config space at offset 0x2c (was 0x0, writing 0x0)
  pcieport 0000:02:01.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
  pcieport 0000:02:04.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
  pcieport 0000:02:02.0: restoring config space at offset 0x28 (was 0x0, writing 0x0)
  pcieport 0000:02:00.0: restoring config space at offset 0x3c (was 0x1ff, writing 0x201ff)
  pcieport 0000:02:02.0: restoring config space at offset 0x24 (was 0x10001, writing 0x1fff1)
  pcieport 0000:02:01.0: restoring config space at offset 0x2c (was 0x0, writing 0x60)
  pcieport 0000:02:02.0: restoring config space at offset 0x20 (was 0x0, writing 0x73f073f0)
  pcieport 0000:02:04.0: restoring config space at offset 0x2c (was 0x0, writing 0x60)
  pcieport 0000:02:01.0: restoring config space at offset 0x28 (was 0x0, writing 0x60)
  pcieport 0000:02:00.0: restoring config space at offset 0x2c (was 0x0, writing 0x0)
  pcieport 0000:02:02.0: restoring config space at offset 0x1c (was 0x101, writing 0x1f1)
  pcieport 0000:02:04.0: restoring config space at offset 0x28 (was 0x0, writing 0x60)
  pcieport 0000:02:01.0: restoring config space at offset 0x24 (was 0x10001, writing 0x1ff10001)
  pcieport 0000:02:00.0: restoring config space at offset 0x28 (was 0x0, writing 0x0)
  pcieport 0000:02:02.0: restoring config space at offset 0x18 (was 0x0, writing 0x373702)
  pcieport 0000:02:04.0: restoring config space at offset 0x24 (was 0x10001, writing 0x49f12001)
  pcieport 0000:02:01.0: restoring config space at offset 0x20 (was 0x0, writing 0x73e05c00)
  pcieport 0000:02:00.0: restoring config space at offset 0x24 (was 0x10001, writing 0x1fff1)
  pcieport 0000:02:04.0: restoring config space at offset 0x20 (was 0x0, writing 0x89f07400)
  pcieport 0000:02:01.0: restoring config space at offset 0x1c (was 0x101, writing 0x5151)
  pcieport 0000:02:00.0: restoring config space at offset 0x20 (was 0x0, writing 0x8a008a00)
  pcieport 0000:02:02.0: restoring config space at offset 0xc (was 0x10000, writing 0x10020)
  pcieport 0000:02:04.0: restoring config space at offset 0x1c (was 0x101, writing 0x6161)
  pcieport 0000:02:01.0: restoring config space at offset 0x18 (was 0x0, writing 0x360402)
  pcieport 0000:02:00.0: restoring config space at offset 0x1c (was 0x101, writing 0x1f1)
  pcieport 0000:02:04.0: restoring config space at offset 0x18 (was 0x0, writing 0x6b3802)
  pcieport 0000:02:02.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100407)
  pcieport 0000:02:00.0: restoring config space at offset 0x18 (was 0x0, writing 0x30302)
  pcieport 0000:02:01.0: restoring config space at offset 0xc (was 0x10000, writing 0x10020)
  pcieport 0000:02:04.0: restoring config space at offset 0xc (was 0x10000, writing 0x10020)
  pcieport 0000:02:00.0: restoring config space at offset 0xc (was 0x10000, writing 0x10020)
  pcieport 0000:02:01.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100407)
  pcieport 0000:02:04.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100407)
  pcieport 0000:02:00.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100407)
  xhci_hcd 0000:37:00.0: restoring config space at offset 0x10 (was 0x0, writing 0x73f00000)
  ...
  thunderbolt 0000:03:00.0: restoring config space at offset 0x14 (was 0x0, writing 0x8a040000)

This is even worse. None of the mandatory delays are performed. If this
would be S3 instead of s2idle then according to PCI FW spec 3.2 section
4.6.8.  there is a specific _DSM that allows the OS to skip the delays
but this platform does not provide the _DSM and does not go to S3 anyway
so no firmware is involved that could already handle these delays.

In this particular Intel Coffee Lake platform these delays are not
actually needed because there is an additional delay as part of the ACPI
power resource that is used to turn on power to the hierarchy but since
that additional delay is not required by any of standards (PCIe, ACPI)
it is not present in the Intel Ice Lake, for example where missing the
mandatory delays causes pciehp to start tearing down the stack too early
(links are not yet trained).

There is also one reported case (see the bugzilla link below) where the
missing delay causes xHCI on a Titan Ridge controller fail to runtime
resume when USB-C dock is plugged.

For this reason, introduce a new function pcie_wait_downstream_accessible()
that is called on PCI core resume and runtime resume paths accordingly
if downstream/root port with device below entered D3cold.

This is second attempt to add the missing delays. The previous solution
in commit c2bf1fc212f7 ("PCI: Add missing link delays required by the
PCIe spec") was reverted because of two issues it caused:

  1. One system become unresponsive after S3 resume due to PME service
     spinning in pcie_pme_work_fn(). The root port in question reports
     that the xHCI sent PME but the xHCI device itself does not have PME
     status set. The PME status bit is never cleared in the root port
     resulting the indefinite loop in pcie_pme_work_fn().

  2. Slows down resume if the root/downstream port does not support
     Data Link Layer Active Reporting because pcie_wait_for_link_delay()
     waits 1100ms in that case.

This version should avoid the above issues because we restrict the delay
to happen only if the port went into D3cold (so it goes through reset)
and only when there is no firmware involved on resume path (so the
kernel is responsible for all the delays).

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203885
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Hi all,

As the changelog says this is reworked version that tries to avoid reported
issues while at the same time fix the missing delays so we can get ICL
systems and at least the one system with Titan Ridge controller working
properly.

@Matthias, @Paul and @Nicholas: it would be great if you could try the
patch on top of v5.4-rc5+ and verify that it does not cause any issues on
your systems.

 drivers/pci/pci-driver.c |  19 ++++++
 drivers/pci/pci.c        | 127 ++++++++++++++++++++++++++++++++++++---
 drivers/pci/pci.h        |   1 +
 3 files changed, 137 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a8124e47bf6e..9aec78ed8907 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -918,6 +918,7 @@ static int pci_pm_resume_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct device_driver *drv = dev->driver;
+	pci_power_t state = pci_dev->current_state;
 	int error = 0;
 
 	if (dev_pm_may_skip_resume(dev))
@@ -947,6 +948,15 @@ static int pci_pm_resume_noirq(struct device *dev)
 
 	pcie_pme_root_status_cleanup(pci_dev);
 
+	/*
+	 * If resume involves firmware assume it takes care of any delays
+	 * for now. For suspend-to-idle case we need to do that here before
+	 * resuming PCIe port services to keep pciehp from tearing down the
+	 * downstream devices too early.
+	 */
+	if (state == PCI_D3cold && pm_suspend_no_platform())
+		pcie_wait_downstream_accessible(pci_dev);
+
 	if (drv && drv->pm && drv->pm->resume_noirq)
 		error = drv->pm->resume_noirq(dev);
 
@@ -1329,6 +1339,7 @@ static int pci_pm_runtime_resume(struct device *dev)
 	int rc = 0;
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	pci_power_t state = pci_dev->current_state;
 
 	/*
 	 * Restoring config space is necessary even if the device is not bound
@@ -1344,6 +1355,14 @@ static int pci_pm_runtime_resume(struct device *dev)
 	pci_enable_wake(pci_dev, PCI_D0, false);
 	pci_fixup_device(pci_fixup_resume, pci_dev);
 
+	/*
+	 * If the hierarcy went into D3cold wait for the link to be
+	 * reactivated before resuming PCIe port services to keep pciehp
+	 * from tearing down the downstream devices too early.
+	 */
+	if (state == PCI_D3cold)
+		pcie_wait_downstream_accessible(pci_dev);
+
 	if (pm && pm->runtime_resume)
 		rc = pm->runtime_resume(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1b27b5af3d55..9ac50710f1d4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1025,15 +1025,11 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
 	if (state == PCI_D0) {
 		pci_platform_power_transition(dev, PCI_D0);
 		/*
-		 * Mandatory power management transition delays, see
-		 * PCI Express Base Specification Revision 2.0 Section
-		 * 6.6.1: Conventional Reset.  Do not delay for
-		 * devices powered on/off by corresponding bridge,
-		 * because have already delayed for the bridge.
+		 * Mandatory power management transition delays are handled
+		 * in pci_pm_runtime_resume() of the corresponding
+		 * downstream/root port.
 		 */
 		if (dev->runtime_d3cold) {
-			if (dev->d3cold_delay && !dev->imm_ready)
-				msleep(dev->d3cold_delay);
 			/*
 			 * When powering on a bridge from D3cold, the
 			 * whole hierarchy may be powered on into
@@ -4607,14 +4603,17 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 
 	return pci_dev_wait(dev, "PM D3->D0", PCIE_RESET_READY_POLL_MS);
 }
+
 /**
- * pcie_wait_for_link - Wait until link is active or inactive
+ * pcie_wait_for_link_delay - Wait until link is active or inactive
  * @pdev: Bridge device
  * @active: waiting for active or inactive?
+ * @delay: Delay to wait after link has become active (in ms)
  *
  * Use this to wait till link becomes active or inactive.
  */
-bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
+static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
+				     int delay)
 {
 	int timeout = 1000;
 	bool ret;
@@ -4651,13 +4650,121 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
 		timeout -= 10;
 	}
 	if (active && ret)
-		msleep(100);
+		msleep(delay);
 	else if (ret != active)
 		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
 			active ? "set" : "cleared");
 	return ret == active;
 }
 
+/**
+ * pcie_wait_for_link - Wait until link is active or inactive
+ * @pdev: Bridge device
+ * @active: waiting for active or inactive?
+ *
+ * Use this to wait till link becomes active or inactive.
+ */
+bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
+{
+	return pcie_wait_for_link_delay(pdev, active, 100);
+}
+
+static int pcie_get_downstream_delay(struct pci_bus *bus)
+{
+	struct pci_dev *pdev;
+	int min_delay = 100;
+	int max_delay = 0;
+
+	list_for_each_entry(pdev, &bus->devices, bus_list) {
+		if (pdev->imm_ready)
+			min_delay = 0;
+		else if (pdev->d3cold_delay < min_delay)
+			min_delay = pdev->d3cold_delay;
+		if (pdev->d3cold_delay > max_delay)
+			max_delay = pdev->d3cold_delay;
+	}
+
+	return max(min_delay, max_delay);
+}
+
+/**
+ * pcie_wait_downstream_accessible - Wait downstream device to be accessible
+ * @pdev: PCIe port whose downstream device is waited
+ *
+ * Handle delays according to PCIe 4.0 section 6.6.1 before configuration
+ * access to the downstream device is permitted. If the port does not have
+ * any devices connected, does nothing.
+ *
+ * This is needed if the hierarchy below @pdev went through reset (after
+ * exit from D3cold back to D0uninitialized).
+ */
+void pcie_wait_downstream_accessible(struct pci_dev *pdev)
+{
+	struct pci_dev *child;
+	struct pci_bus *bus;
+	int delay;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
+	    pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
+		return;
+
+	if (pci_dev_is_disconnected(pdev))
+		return;
+
+	if (!pdev->bridge_d3)
+		return;
+
+	bus = pdev->subordinate;
+	if (!bus)
+		return;
+
+	child = list_first_entry_or_null(&bus->devices, struct pci_dev,
+					 bus_list);
+	if (!child)
+		return;
+
+	delay = pcie_get_downstream_delay(bus);
+	if (!delay)
+		return;
+
+	/*
+	 * If downstream port does not support speeds greater than 5 GT/s
+	 * need to wait minimum 100ms. For higher speeds (gen3) we need to
+	 * wait first for the data link layer to become active.
+	 *
+	 * However, 100ms is the minimum and the spec says that the
+	 * software must allow at least 1s before it can determine that the
+	 * device that did not respond is a broken device. Also there is
+	 * evidence that the 100ms is not always enough so what we do here
+	 * is that we wait for the minimum 100ms (possibly after link
+	 * training completes) and then probe for the device presence once.
+	 * If we still don't get response we wait for another 100ms just to
+	 * give it some additional time to complete its initialization.
+	 */
+	if (pcie_get_speed_cap(pdev) <= PCIE_SPEED_5_0GT) {
+		dev_dbg(&pdev->dev, "waiting downstream link for %d ms\n",
+			delay);
+		msleep(delay);
+	} else {
+		dev_dbg(&pdev->dev,
+			"waiting downstream link for %d ms after activation\n",
+			delay);
+		if (!pcie_wait_for_link_delay(pdev, true, delay)) {
+			/*
+			 * If the link did not train, no need to wait
+			 * further the device is probably gone.
+			 */
+			return;
+		}
+	}
+
+	if (!pci_device_is_present(child)) {
+		dev_dbg(&child->dev,
+			"waiting for additional 100 ms for the device to become accessible\n");
+		msleep(100);
+	}
+}
+
 void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d22d1b807701..9a83fcf612ca 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -498,6 +498,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 		      u32 service);
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
+void pcie_wait_downstream_accessible(struct pci_dev *pdev);
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
-- 
2.23.0.rc1

