Return-Path: <linux-pci+bounces-28004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A3BABC56F
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4877A4CDC
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 17:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F55286417;
	Mon, 19 May 2025 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKInvJ2/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0361DE2DF;
	Mon, 19 May 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675094; cv=none; b=pVQvNsmPEmvw7xcG7Hj3sqJZ3N4MOH2tZZB9ZZPObYeTC6wBSDEwsgSg3mrqlKY5Qp1w9Obe2ZZL8ncgt1oryRT5Mj1kSVepfG16BMIfll+4EhG8qWSEFYH1zwdpBlzJo+M781dUy5k6VTwMm54zYYjx9mVMmOzDRWmH59R01zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675094; c=relaxed/simple;
	bh=o1b8ZpuHylDEUQhB51yWwq+Qm0qMzMaYJwNO1AH/1gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cg1XfOJy65LGjYJkhEp48coqqkdP9TASJ/nc5ojkKPDV8st85+0W2wujvaALHljOIFmCQdmz6vNSj4Qukm1FJdR2AYskz8EtWYlZH2iUbLtk1+l4z+nKE6ebxAuSwhNYIdWWCxgSnxdpFPF8U/TiJSKQpV8akpUUJ7cLeVukaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKInvJ2/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747675091; x=1779211091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o1b8ZpuHylDEUQhB51yWwq+Qm0qMzMaYJwNO1AH/1gc=;
  b=RKInvJ2/rDbjLtrbdrKauepCHtDxhUUyunjK7vQ4DWvqe1rKQ1oY72uL
   sXtk810pvYj2xz2yTGpdTG0aaC20+0nQujJ2OPeAK5xnww5R3EEMXaVdT
   HjQkMkTgxuQHxtQsFvGaRzqg0Sgijy19ioDx1RY/xzpySG/4PVRgPH3zy
   DfEL70J0SK67YCivfx7oU7d7+PTr0NiB6GtrN1RakKw6nGzAl59c0lcuV
   Qopy+k0kd2PuhqR2J6p1rWnAIKt2gEuygYyvRXKYmLLAgeP/RYTpHYQF4
   Qth5lOtrgjf8X/0d3gZ0u3zbAD7uPVihmBZUxi8OOZH+Q+QahEioWukIw
   w==;
X-CSE-ConnectionGUID: z+iw3RC3Tgy5XYddPRbBtg==
X-CSE-MsgGUID: 9WMjEjKHQ/Wl09Js+qnVuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="66998495"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="66998495"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 10:18:10 -0700
X-CSE-ConnectionGUID: etApBOBoSPWBv6LHL7bclQ==
X-CSE-MsgGUID: 8g3UOpXyQBK5ODNtsrwhAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="139318306"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 10:18:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/2] PCI: Move reset and restore related code to reset.c
Date: Mon, 19 May 2025 20:17:38 +0300
Message-Id: <20250519171739.3575-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519171739.3575-1-ilpo.jarvinen@linux.intel.com>
References: <20250519171739.3575-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are quite many reset and restore related functions in pci.c that
barely depend on the other functions in pci.c. Create reset.c for reset
and restore related logic to keep those 1k lines in one place.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/Makefile |    4 +-
 drivers/pci/pci.c    | 1277 +-----------------------------------------
 drivers/pci/pci.h    |    2 +
 drivers/pci/reset.c  | 1253 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1275 insertions(+), 1261 deletions(-)
 create mode 100644 drivers/pci/reset.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 67647f1880fb..62c68c9cbb9e 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -3,8 +3,8 @@
 # Makefile for the PCI bus specific drivers.
 
 obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
-				   remove.o pci.o pci-driver.o search.o \
-				   rom.o setup-res.o irq.o vpd.o \
+				   remove.o reset.o pci.o pci-driver.o \
+				   search.o rom.o setup-res.o irq.o vpd.o \
 				   setup-bus.o vc.o mmap.o devres.o
 
 obj-$(CONFIG_PCI)		+= msi/
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 26507aa906d7..48c0b9f7fc89 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -62,22 +62,7 @@ struct pci_pme_device {
 
 #define PME_TIMEOUT 1000 /* How long between PME checks */
 
-/*
- * Following exit from Conventional Reset, devices must be ready within 1 sec
- * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
- * Reset (PCIe r6.0 sec 5.8).
- */
-#define PCI_RESET_WAIT 1000 /* msec */
-
-/*
- * Devices may extend the 1 sec period through Request Retry Status
- * completions (PCIe r6.0 sec 2.3.1).  The spec does not provide an upper
- * limit, but 60 sec ought to be enough for any device to become
- * responsive.
- */
-#define PCIE_RESET_READY_POLL_MS 60000 /* msec */
-
-static void pci_dev_d3_sleep(struct pci_dev *dev)
+void pci_dev_d3_sleep(struct pci_dev *dev)
 {
 	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
 	unsigned int upper;
@@ -90,11 +75,6 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
 	}
 }
 
-bool pci_reset_supported(struct pci_dev *dev)
-{
-	return dev->reset_methods[0] != 0;
-}
-
 #ifdef CONFIG_PCI_DOMAINS
 int pci_domains_supported = 1;
 #endif
@@ -1262,89 +1242,6 @@ void pci_resume_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_resume_one, NULL);
 }
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
-{
-	int delay = 1;
-	bool retrain = false;
-	struct pci_dev *root, *bridge;
-
-	root = pcie_find_root_port(dev);
-
-	if (pci_is_pcie(dev)) {
-		bridge = pci_upstream_bridge(dev);
-		if (bridge)
-			retrain = true;
-	}
-
-	/*
-	 * The caller has already waited long enough after a reset that the
-	 * device should respond to config requests, but it may respond
-	 * with Request Retry Status (RRS) if it needs more time to
-	 * initialize.
-	 *
-	 * If the device is below a Root Port with Configuration RRS
-	 * Software Visibility enabled, reading the Vendor ID returns a
-	 * special data value if the device responded with RRS.  Read the
-	 * Vendor ID until we get non-RRS status.
-	 *
-	 * If there's no Root Port or Configuration RRS Software Visibility
-	 * is not enabled, the device may still respond with RRS, but
-	 * hardware may retry the config request.  If no retries receive
-	 * Successful Completion, hardware generally synthesizes ~0
-	 * (PCI_ERROR_RESPONSE) data to complete the read.  Reading Vendor
-	 * ID for VFs and non-existent devices also returns ~0, so read the
-	 * Command register until it returns something other than ~0.
-	 */
-	for (;;) {
-		u32 id;
-
-		if (pci_dev_is_disconnected(dev)) {
-			pci_dbg(dev, "disconnected; not waiting\n");
-			return -ENOTTY;
-		}
-
-		if (root && root->config_rrs_sv) {
-			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
-			if (!pci_bus_rrs_vendor_id(id))
-				break;
-		} else {
-			pci_read_config_dword(dev, PCI_COMMAND, &id);
-			if (!PCI_POSSIBLE_ERROR(id))
-				break;
-		}
-
-		if (delay > timeout) {
-			pci_warn(dev, "not ready %dms after %s; giving up\n",
-				 delay - 1, reset_type);
-			return -ENOTTY;
-		}
-
-		if (delay > PCI_RESET_WAIT) {
-			if (retrain) {
-				retrain = false;
-				if (pcie_failed_link_retrain(bridge) == 0) {
-					delay = 1;
-					continue;
-				}
-			}
-			pci_info(dev, "not ready %dms after %s; waiting\n",
-				 delay - 1, reset_type);
-		}
-
-		msleep(delay);
-		delay *= 2;
-	}
-
-	if (delay > PCI_RESET_WAIT)
-		pci_info(dev, "ready %dms after %s\n", delay - 1,
-			 reset_type);
-	else
-		pci_dbg(dev, "ready %dms after %s\n", delay - 1,
-			reset_type);
-
-	return 0;
-}
-
 /**
  * pci_power_up - Put the given device into D0
  * @dev: PCI device to power up
@@ -2293,33 +2190,6 @@ void pci_disable_device(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_disable_device);
 
-/**
- * pcibios_set_pcie_reset_state - set reset state for device dev
- * @dev: the PCIe device reset
- * @state: Reset state to enter into
- *
- * Set the PCIe reset state for the device. This is the default
- * implementation. Architecture implementations can override this.
- */
-int __weak pcibios_set_pcie_reset_state(struct pci_dev *dev,
-					enum pcie_reset_state state)
-{
-	return -EINVAL;
-}
-
-/**
- * pci_set_pcie_reset_state - set reset state for device dev
- * @dev: the PCIe device reset
- * @state: Reset state to enter into
- *
- * Sets the PCI reset state for the device.
- */
-int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
-{
-	return pcibios_set_pcie_reset_state(dev, state);
-}
-EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
-
 #ifdef CONFIG_PCIEAER
 void pcie_clear_device_status(struct pci_dev *dev)
 {
@@ -4544,145 +4414,6 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
-/**
- * pcie_flr - initiate a PCIe function level reset
- * @dev: device to reset
- *
- * Initiate a function level reset unconditionally on @dev without
- * checking any flags and DEVCAP
- */
-int pcie_flr(struct pci_dev *dev)
-{
-	if (!pci_wait_for_pending_transaction(dev))
-		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
-
-	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
-
-	if (dev->imm_ready)
-		return 0;
-
-	/*
-	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
-	 * 100ms, but may silently discard requests while the FLR is in
-	 * progress.  Wait 100ms before trying to access the device.
-	 */
-	msleep(100);
-
-	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
-}
-EXPORT_SYMBOL_GPL(pcie_flr);
-
-/**
- * pcie_reset_flr - initiate a PCIe function level reset
- * @dev: device to reset
- * @probe: if true, return 0 if device can be reset this way
- *
- * Initiate a function level reset on @dev.
- */
-int pcie_reset_flr(struct pci_dev *dev, bool probe)
-{
-	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
-		return -ENOTTY;
-
-	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
-		return -ENOTTY;
-
-	if (probe)
-		return 0;
-
-	return pcie_flr(dev);
-}
-EXPORT_SYMBOL_GPL(pcie_reset_flr);
-
-static int pci_af_flr(struct pci_dev *dev, bool probe)
-{
-	int pos;
-	u8 cap;
-
-	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
-	if (!pos)
-		return -ENOTTY;
-
-	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
-		return -ENOTTY;
-
-	pci_read_config_byte(dev, pos + PCI_AF_CAP, &cap);
-	if (!(cap & PCI_AF_CAP_TP) || !(cap & PCI_AF_CAP_FLR))
-		return -ENOTTY;
-
-	if (probe)
-		return 0;
-
-	/*
-	 * Wait for Transaction Pending bit to clear.  A word-aligned test
-	 * is used, so we use the control offset rather than status and shift
-	 * the test bit to match.
-	 */
-	if (!pci_wait_for_pending(dev, pos + PCI_AF_CTRL,
-				 PCI_AF_STATUS_TP << 8))
-		pci_err(dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
-
-	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
-
-	if (dev->imm_ready)
-		return 0;
-
-	/*
-	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
-	 * updated 27 July 2006; a device must complete an FLR within
-	 * 100ms, but may silently discard requests while the FLR is in
-	 * progress.  Wait 100ms before trying to access the device.
-	 */
-	msleep(100);
-
-	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
-}
-
-/**
- * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
- * @dev: Device to reset.
- * @probe: if true, return 0 if the device can be reset this way.
- *
- * If @dev supports native PCI PM and its PCI_PM_CTRL_NO_SOFT_RESET flag is
- * unset, it will be reinitialized internally when going from PCI_D3hot to
- * PCI_D0.  If that's the case and the device is not in a low-power state
- * already, force it into PCI_D3hot and back to PCI_D0, causing it to be reset.
- *
- * NOTE: This causes the caller to sleep for twice the device power transition
- * cooldown period, which for the D0->D3hot and D3hot->D0 transitions is 10 ms
- * by default (i.e. unless the @dev's d3hot_delay field has a different value).
- * Moreover, only devices in D0 can be reset by this function.
- */
-static int pci_pm_reset(struct pci_dev *dev, bool probe)
-{
-	u16 csr;
-
-	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
-		return -ENOTTY;
-
-	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &csr);
-	if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
-		return -ENOTTY;
-
-	if (probe)
-		return 0;
-
-	if (dev->current_state != PCI_D0)
-		return -EINVAL;
-
-	csr &= ~PCI_PM_CTRL_STATE_MASK;
-	csr |= PCI_D3hot;
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
-	pci_dev_d3_sleep(dev);
-
-	csr &= ~PCI_PM_CTRL_STATE_MASK;
-	csr |= PCI_D0;
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
-	pci_dev_d3_sleep(dev);
-
-	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
-}
-
 /**
  * pcie_wait_for_link_status - Wait for link status change
  * @pdev: Device whose link to wait for.
@@ -4769,8 +4500,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
  *
  * Use this to wait till link becomes active or inactive.
  */
-static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
-				     int delay)
+bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active, int delay)
 {
 	int rc;
 
@@ -4823,1005 +4553,34 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
 	return pcie_wait_for_link_delay(pdev, active, 100);
 }
 
-/*
- * Find maximum D3cold delay required by all the devices on the bus.  The
- * spec says 100 ms, but firmware can lower it and we allow drivers to
- * increase it as well.
- *
- * Called with @pci_bus_sem locked for reading.
- */
-static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
+void pci_dev_lock(struct pci_dev *dev)
 {
-	const struct pci_dev *pdev;
-	int min_delay = 100;
-	int max_delay = 0;
-
-	list_for_each_entry(pdev, &bus->devices, bus_list) {
-		if (pdev->d3cold_delay < min_delay)
-			min_delay = pdev->d3cold_delay;
-		if (pdev->d3cold_delay > max_delay)
-			max_delay = pdev->d3cold_delay;
-	}
-
-	return max(min_delay, max_delay);
+	/* block PM suspend, driver probe, etc. */
+	device_lock(&dev->dev);
+	pci_cfg_access_lock(dev);
 }
+EXPORT_SYMBOL_GPL(pci_dev_lock);
 
-/**
- * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
- * @dev: PCI bridge
- * @reset_type: reset type in human-readable form
- *
- * Handle necessary delays before access to the devices on the secondary
- * side of the bridge are permitted after D3cold to D0 transition
- * or Conventional Reset.
- *
- * For PCIe this means the delays in PCIe 5.0 section 6.6.1. For
- * conventional PCI it means Tpvrh + Trhfa specified in PCI 3.0 section
- * 4.3.2.
- *
- * Return 0 on success or -ENOTTY if the first device on the secondary bus
- * failed to become accessible.
- */
-int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
+/* Return 1 on successful lock, 0 on contention */
+int pci_dev_trylock(struct pci_dev *dev)
 {
-	struct pci_dev *child __free(pci_dev_put) = NULL;
-	int delay;
-
-	if (pci_dev_is_disconnected(dev))
-		return 0;
-
-	if (!pci_is_bridge(dev))
-		return 0;
-
-	down_read(&pci_bus_sem);
-
-	/*
-	 * We only deal with devices that are present currently on the bus.
-	 * For any hot-added devices the access delay is handled in pciehp
-	 * board_added(). In case of ACPI hotplug the firmware is expected
-	 * to configure the devices before OS is notified.
-	 */
-	if (!dev->subordinate || list_empty(&dev->subordinate->devices)) {
-		up_read(&pci_bus_sem);
-		return 0;
-	}
-
-	/* Take d3cold_delay requirements into account */
-	delay = pci_bus_max_d3cold_delay(dev->subordinate);
-	if (!delay) {
-		up_read(&pci_bus_sem);
-		return 0;
-	}
-
-	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
-					     struct pci_dev, bus_list));
-	up_read(&pci_bus_sem);
-
-	/*
-	 * Conventional PCI and PCI-X we need to wait Tpvrh + Trhfa before
-	 * accessing the device after reset (that is 1000 ms + 100 ms).
-	 */
-	if (!pci_is_pcie(dev)) {
-		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
-		msleep(1000 + delay);
-		return 0;
-	}
-
-	/*
-	 * For PCIe downstream and root ports that do not support speeds
-	 * greater than 5 GT/s need to wait minimum 100 ms. For higher
-	 * speeds (gen3) we need to wait first for the data link layer to
-	 * become active.
-	 *
-	 * However, 100 ms is the minimum and the PCIe spec says the
-	 * software must allow at least 1s before it can determine that the
-	 * device that did not respond is a broken device. Also device can
-	 * take longer than that to respond if it indicates so through Request
-	 * Retry Status completions.
-	 *
-	 * Therefore we wait for 100 ms and check for the device presence
-	 * until the timeout expires.
-	 */
-	if (!pcie_downstream_port(dev))
-		return 0;
-
-	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
-		u16 status;
-
-		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
-		msleep(delay);
-
-		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
-			return 0;
-
-		/*
-		 * If the port supports active link reporting we now check
-		 * whether the link is active and if not bail out early with
-		 * the assumption that the device is not present anymore.
-		 */
-		if (!dev->link_active_reporting)
-			return -ENOTTY;
-
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
-		if (!(status & PCI_EXP_LNKSTA_DLLLA))
-			return -ENOTTY;
-
-		return pci_dev_wait(child, reset_type,
-				    PCIE_RESET_READY_POLL_MS - PCI_RESET_WAIT);
-	}
-
-	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
-		delay);
-	if (!pcie_wait_for_link_delay(dev, true, delay)) {
-		/* Did not train, no need to wait any further */
-		pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
-		return -ENOTTY;
+	if (device_trylock(&dev->dev)) {
+		if (pci_cfg_access_trylock(dev))
+			return 1;
+		device_unlock(&dev->dev);
 	}
 
-	return pci_dev_wait(child, reset_type,
-			    PCIE_RESET_READY_POLL_MS - delay);
-}
-
-void pci_reset_secondary_bus(struct pci_dev *dev)
-{
-	u16 ctrl;
-
-	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
-	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
-	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
-
-	/*
-	 * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
-	 * this to 2ms to ensure that we meet the minimum requirement.
-	 */
-	msleep(2);
-
-	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
-	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
-}
-
-void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
-{
-	pci_reset_secondary_bus(dev);
-}
-
-/**
- * pci_bridge_secondary_bus_reset - Reset the secondary bus on a PCI bridge.
- * @dev: Bridge device
- *
- * Use the bridge control register to assert reset on the secondary bus.
- * Devices on the secondary bus are left in power-on state.
- */
-int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
-{
-	if (!dev->block_cfg_access)
-		pci_warn_once(dev, "unlocked secondary bus reset via: %pS\n",
-			      __builtin_return_address(0));
-	pcibios_reset_secondary_bus(dev);
-
-	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
-}
-EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
-
-static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
-{
-	struct pci_dev *pdev;
-
-	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
-	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
-		return -ENOTTY;
-
-	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
-		if (pdev != dev)
-			return -ENOTTY;
-
-	if (probe)
-		return 0;
-
-	return pci_bridge_secondary_bus_reset(dev->bus->self);
-}
-
-static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
-{
-	int rc = -ENOTTY;
-
-	if (!hotplug || !try_module_get(hotplug->owner))
-		return rc;
-
-	if (hotplug->ops->reset_slot)
-		rc = hotplug->ops->reset_slot(hotplug, probe);
-
-	module_put(hotplug->owner);
-
-	return rc;
-}
-
-static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
-{
-	if (dev->multifunction || dev->subordinate || !dev->slot ||
-	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
-		return -ENOTTY;
-
-	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
-}
-
-static u16 cxl_port_dvsec(struct pci_dev *dev)
-{
-	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
-					 PCI_DVSEC_CXL_PORT);
-}
-
-static bool cxl_sbr_masked(struct pci_dev *dev)
-{
-	u16 dvsec, reg;
-	int rc;
-
-	dvsec = cxl_port_dvsec(dev);
-	if (!dvsec)
-		return false;
-
-	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
-	if (rc || PCI_POSSIBLE_ERROR(reg))
-		return false;
-
-	/*
-	 * Per CXL spec r3.1, sec 8.1.5.2, when "Unmask SBR" is 0, the SBR
-	 * bit in Bridge Control has no effect.  When 1, the Port generates
-	 * hot reset when the SBR bit is set to 1.
-	 */
-	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
-		return false;
-
-	return true;
+	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_dev_trylock);
 
-static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
+void pci_dev_unlock(struct pci_dev *dev)
 {
-	struct pci_dev *bridge = pci_upstream_bridge(dev);
-	int rc;
-
-	/*
-	 * If "dev" is below a CXL port that has SBR control masked, SBR
-	 * won't do anything, so return error.
-	 */
-	if (bridge && cxl_sbr_masked(bridge)) {
-		if (probe)
-			return 0;
-
-		return -ENOTTY;
-	}
-
-	rc = pci_dev_reset_slot_function(dev, probe);
-	if (rc != -ENOTTY)
-		return rc;
-	return pci_parent_bus_reset(dev, probe);
-}
-
-static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
-{
-	struct pci_dev *bridge;
-	u16 dvsec, reg, val;
-	int rc;
-
-	bridge = pci_upstream_bridge(dev);
-	if (!bridge)
-		return -ENOTTY;
-
-	dvsec = cxl_port_dvsec(bridge);
-	if (!dvsec)
-		return -ENOTTY;
-
-	if (probe)
-		return 0;
-
-	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
-	if (rc)
-		return -ENOTTY;
-
-	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
-		val = reg;
-	} else {
-		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
-		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
-				      val);
-	}
-
-	rc = pci_reset_bus_function(dev, probe);
-
-	if (reg != val)
-		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
-				      reg);
-
-	return rc;
-}
-
-void pci_dev_lock(struct pci_dev *dev)
-{
-	/* block PM suspend, driver probe, etc. */
-	device_lock(&dev->dev);
-	pci_cfg_access_lock(dev);
-}
-EXPORT_SYMBOL_GPL(pci_dev_lock);
-
-/* Return 1 on successful lock, 0 on contention */
-int pci_dev_trylock(struct pci_dev *dev)
-{
-	if (device_trylock(&dev->dev)) {
-		if (pci_cfg_access_trylock(dev))
-			return 1;
-		device_unlock(&dev->dev);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pci_dev_trylock);
-
-void pci_dev_unlock(struct pci_dev *dev)
-{
-	pci_cfg_access_unlock(dev);
-	device_unlock(&dev->dev);
+	pci_cfg_access_unlock(dev);
+	device_unlock(&dev->dev);
 }
 EXPORT_SYMBOL_GPL(pci_dev_unlock);
 
-static void pci_dev_save_and_disable(struct pci_dev *dev)
-{
-	const struct pci_error_handlers *err_handler =
-			dev->driver ? dev->driver->err_handler : NULL;
-
-	/*
-	 * dev->driver->err_handler->reset_prepare() is protected against
-	 * races with ->remove() by the device lock, which must be held by
-	 * the caller.
-	 */
-	if (err_handler && err_handler->reset_prepare)
-		err_handler->reset_prepare(dev);
-	else if (dev->driver)
-		pci_warn(dev, "resetting");
-
-	/*
-	 * Wake-up device prior to save.  PM registers default to D0 after
-	 * reset and a simple register restore doesn't reliably return
-	 * to a non-D0 state anyway.
-	 */
-	pci_set_power_state(dev, PCI_D0);
-
-	pci_save_state(dev);
-	/*
-	 * Disable the device by clearing the Command register, except for
-	 * INTx-disable which is set.  This not only disables MMIO and I/O port
-	 * BARs, but also prevents the device from being Bus Master, preventing
-	 * DMA from the device including MSI/MSI-X interrupts.  For PCI 2.3
-	 * compliant devices, INTx-disable prevents legacy interrupts.
-	 */
-	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
-}
-
-static void pci_dev_restore(struct pci_dev *dev)
-{
-	const struct pci_error_handlers *err_handler =
-			dev->driver ? dev->driver->err_handler : NULL;
-
-	pci_restore_state(dev);
-
-	/*
-	 * dev->driver->err_handler->reset_done() is protected against
-	 * races with ->remove() by the device lock, which must be held by
-	 * the caller.
-	 */
-	if (err_handler && err_handler->reset_done)
-		err_handler->reset_done(dev);
-	else if (dev->driver)
-		pci_warn(dev, "reset done");
-}
-
-/* dev->reset_methods[] is a 0-terminated list of indices into this array */
-const struct pci_reset_fn_method pci_reset_fn_methods[] = {
-	{ },
-	{ pci_dev_specific_reset, .name = "device_specific" },
-	{ pci_dev_acpi_reset, .name = "acpi" },
-	{ pcie_reset_flr, .name = "flr" },
-	{ pci_af_flr, .name = "af_flr" },
-	{ pci_pm_reset, .name = "pm" },
-	{ pci_reset_bus_function, .name = "bus" },
-	{ cxl_reset_bus_function, .name = "cxl_bus" },
-};
-
-/**
- * __pci_reset_function_locked - reset a PCI device function while holding
- * the @dev mutex lock.
- * @dev: PCI device to reset
- *
- * Some devices allow an individual function to be reset without affecting
- * other functions in the same device.  The PCI device must be responsive
- * to PCI config space in order to use this function.
- *
- * The device function is presumed to be unused and the caller is holding
- * the device mutex lock when this function is called.
- *
- * Resetting the device will make the contents of PCI configuration space
- * random, so any caller of this must be prepared to reinitialise the
- * device including MSI, bus mastering, BARs, decoding IO and memory spaces,
- * etc.
- *
- * Returns 0 if the device function was successfully reset or negative if the
- * device doesn't support resetting a single function.
- */
-int __pci_reset_function_locked(struct pci_dev *dev)
-{
-	int i, m, rc;
-	const struct pci_reset_fn_method *method;
-
-	might_sleep();
-
-	/*
-	 * A reset method returns -ENOTTY if it doesn't support this device and
-	 * we should try the next method.
-	 *
-	 * If it returns 0 (success), we're finished.  If it returns any other
-	 * error, we're also finished: this indicates that further reset
-	 * mechanisms might be broken on the device.
-	 */
-	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
-		m = dev->reset_methods[i];
-		if (!m)
-			return -ENOTTY;
-
-		method = &pci_reset_fn_methods[m];
-		pci_dbg(dev, "reset via %s\n", method->name);
-		rc = method->reset_fn(dev, PCI_RESET_DO_RESET);
-		if (!rc)
-			return 0;
-
-		pci_dbg(dev, "%s failed with %d\n", method->name, rc);
-		if (rc != -ENOTTY)
-			return rc;
-	}
-
-	return -ENOTTY;
-}
-EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
-
-/**
- * pci_init_reset_methods - check whether device can be safely reset
- * and store supported reset mechanisms.
- * @dev: PCI device to check for reset mechanisms
- *
- * Some devices allow an individual function to be reset without affecting
- * other functions in the same device.  The PCI device must be in D0-D3hot
- * state.
- *
- * Stores reset mechanisms supported by device in reset_methods byte array
- * which is a member of struct pci_dev.
- */
-void pci_init_reset_methods(struct pci_dev *dev)
-{
-	int m, i, rc;
-
-	BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_NUM_RESET_METHODS);
-
-	might_sleep();
-
-	i = 0;
-	for (m = 1; m < PCI_NUM_RESET_METHODS; m++) {
-		rc = pci_reset_fn_methods[m].reset_fn(dev, PCI_RESET_PROBE);
-		if (!rc)
-			dev->reset_methods[i++] = m;
-		else if (rc != -ENOTTY)
-			break;
-	}
-
-	dev->reset_methods[i] = 0;
-}
-
-/**
- * pci_reset_function - quiesce and reset a PCI device function
- * @dev: PCI device to reset
- *
- * Some devices allow an individual function to be reset without affecting
- * other functions in the same device.  The PCI device must be responsive
- * to PCI config space in order to use this function.
- *
- * This function does not just reset the PCI portion of a device, but
- * clears all the state associated with the device.  This function differs
- * from __pci_reset_function_locked() in that it saves and restores device state
- * over the reset and takes the PCI device lock.
- *
- * Returns 0 if the device function was successfully reset or negative if the
- * device doesn't support resetting a single function.
- */
-int pci_reset_function(struct pci_dev *dev)
-{
-	struct pci_dev *bridge;
-	int rc;
-
-	if (!pci_reset_supported(dev))
-		return -ENOTTY;
-
-	/*
-	 * If there's no upstream bridge, no locking is needed since there is
-	 * no upstream bridge configuration to hold consistent.
-	 */
-	bridge = pci_upstream_bridge(dev);
-	if (bridge)
-		pci_dev_lock(bridge);
-
-	pci_dev_lock(dev);
-	pci_dev_save_and_disable(dev);
-
-	rc = __pci_reset_function_locked(dev);
-
-	pci_dev_restore(dev);
-	pci_dev_unlock(dev);
-
-	if (bridge)
-		pci_dev_unlock(bridge);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(pci_reset_function);
-
-/**
- * pci_reset_function_locked - quiesce and reset a PCI device function
- * @dev: PCI device to reset
- *
- * Some devices allow an individual function to be reset without affecting
- * other functions in the same device.  The PCI device must be responsive
- * to PCI config space in order to use this function.
- *
- * This function does not just reset the PCI portion of a device, but
- * clears all the state associated with the device.  This function differs
- * from __pci_reset_function_locked() in that it saves and restores device state
- * over the reset.  It also differs from pci_reset_function() in that it
- * requires the PCI device lock to be held.
- *
- * Returns 0 if the device function was successfully reset or negative if the
- * device doesn't support resetting a single function.
- */
-int pci_reset_function_locked(struct pci_dev *dev)
-{
-	int rc;
-
-	if (!pci_reset_supported(dev))
-		return -ENOTTY;
-
-	pci_dev_save_and_disable(dev);
-
-	rc = __pci_reset_function_locked(dev);
-
-	pci_dev_restore(dev);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(pci_reset_function_locked);
-
-/**
- * pci_try_reset_function - quiesce and reset a PCI device function
- * @dev: PCI device to reset
- *
- * Same as above, except return -EAGAIN if unable to lock device.
- */
-int pci_try_reset_function(struct pci_dev *dev)
-{
-	int rc;
-
-	if (!pci_reset_supported(dev))
-		return -ENOTTY;
-
-	if (!pci_dev_trylock(dev))
-		return -EAGAIN;
-
-	pci_dev_save_and_disable(dev);
-	rc = __pci_reset_function_locked(dev);
-	pci_dev_restore(dev);
-	pci_dev_unlock(dev);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(pci_try_reset_function);
-
-/* Do any devices on or below this bus prevent a bus reset? */
-static bool pci_bus_resettable(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-
-	if (bus->self && (bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
-		return false;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (!pci_reset_supported(dev))
-			return false;
-		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
-		    (dev->subordinate && !pci_bus_resettable(dev->subordinate)))
-			return false;
-	}
-
-	return true;
-}
-
-/* Lock devices from the top of the tree down */
-static void pci_bus_lock(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	pci_dev_lock(bus->self);
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (dev->subordinate)
-			pci_bus_lock(dev->subordinate);
-		else
-			pci_dev_lock(dev);
-	}
-}
-
-/* Unlock devices from the bottom of the tree up */
-static void pci_bus_unlock(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		else
-			pci_dev_unlock(dev);
-	}
-	pci_dev_unlock(bus->self);
-}
-
-/* Return 1 on successful lock, 0 on contention */
-static int pci_bus_trylock(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	if (!pci_dev_trylock(bus->self))
-		return 0;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate))
-				goto unlock;
-		} else if (!pci_dev_trylock(dev))
-			goto unlock;
-	}
-	return 1;
-
-unlock:
-	list_for_each_entry_continue_reverse(dev, &bus->devices, bus_list) {
-		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		else
-			pci_dev_unlock(dev);
-	}
-	pci_dev_unlock(bus->self);
-	return 0;
-}
-
-/* Do any devices on or below this slot prevent a bus reset? */
-static bool pci_slot_resettable(struct pci_slot *slot)
-{
-	struct pci_dev *dev;
-
-	if (slot->bus->self &&
-	    (slot->bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
-		return false;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		if (!pci_reset_supported(dev))
-			return false;
-		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
-		    (dev->subordinate && !pci_bus_resettable(dev->subordinate)))
-			return false;
-	}
-
-	return true;
-}
-
-/* Lock devices from the top of the tree down */
-static void pci_slot_lock(struct pci_slot *slot)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		if (dev->subordinate)
-			pci_bus_lock(dev->subordinate);
-		else
-			pci_dev_lock(dev);
-	}
-}
-
-/* Unlock devices from the bottom of the tree up */
-static void pci_slot_unlock(struct pci_slot *slot)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		else
-			pci_dev_unlock(dev);
-	}
-}
-
-/* Return 1 on successful lock, 0 on contention */
-static int pci_slot_trylock(struct pci_slot *slot)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
-				goto unlock;
-			}
-		} else if (!pci_dev_trylock(dev))
-			goto unlock;
-	}
-	return 1;
-
-unlock:
-	list_for_each_entry_continue_reverse(dev,
-					     &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		else
-			pci_dev_unlock(dev);
-	}
-	return 0;
-}
-
-/*
- * Save and disable devices from the top of the tree down while holding
- * the @dev mutex lock for the entire tree.
- */
-static void pci_bus_save_and_disable_locked(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_save_and_disable(dev);
-		if (dev->subordinate)
-			pci_bus_save_and_disable_locked(dev->subordinate);
-	}
-}
-
-/*
- * Restore devices from top of the tree down while holding @dev mutex lock
- * for the entire tree.  Parent bridges need to be restored before we can
- * get to subordinate devices.
- */
-static void pci_bus_restore_locked(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_restore(dev);
-		if (dev->subordinate) {
-			pci_bridge_wait_for_secondary_bus(dev, "bus reset");
-			pci_bus_restore_locked(dev->subordinate);
-		}
-	}
-}
-
-/*
- * Save and disable devices from the top of the tree down while holding
- * the @dev mutex lock for the entire tree.
- */
-static void pci_slot_save_and_disable_locked(struct pci_slot *slot)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		pci_dev_save_and_disable(dev);
-		if (dev->subordinate)
-			pci_bus_save_and_disable_locked(dev->subordinate);
-	}
-}
-
-/*
- * Restore devices from top of the tree down while holding @dev mutex lock
- * for the entire tree.  Parent bridges need to be restored before we can
- * get to subordinate devices.
- */
-static void pci_slot_restore_locked(struct pci_slot *slot)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		pci_dev_restore(dev);
-		if (dev->subordinate) {
-			pci_bridge_wait_for_secondary_bus(dev, "slot reset");
-			pci_bus_restore_locked(dev->subordinate);
-		}
-	}
-}
-
-static int pci_slot_reset(struct pci_slot *slot, bool probe)
-{
-	int rc;
-
-	if (!slot || !pci_slot_resettable(slot))
-		return -ENOTTY;
-
-	if (!probe)
-		pci_slot_lock(slot);
-
-	might_sleep();
-
-	rc = pci_reset_hotplug_slot(slot->hotplug, probe);
-
-	if (!probe)
-		pci_slot_unlock(slot);
-
-	return rc;
-}
-
-/**
- * pci_probe_reset_slot - probe whether a PCI slot can be reset
- * @slot: PCI slot to probe
- *
- * Return 0 if slot can be reset, negative if a slot reset is not supported.
- */
-int pci_probe_reset_slot(struct pci_slot *slot)
-{
-	return pci_slot_reset(slot, PCI_RESET_PROBE);
-}
-EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
-
-/**
- * __pci_reset_slot - Try to reset a PCI slot
- * @slot: PCI slot to reset
- *
- * A PCI bus may host multiple slots, each slot may support a reset mechanism
- * independent of other slots.  For instance, some slots may support slot power
- * control.  In the case of a 1:1 bus to slot architecture, this function may
- * wrap the bus reset to avoid spurious slot related events such as hotplug.
- * Generally a slot reset should be attempted before a bus reset.  All of the
- * function of the slot and any subordinate buses behind the slot are reset
- * through this function.  PCI config space of all devices in the slot and
- * behind the slot is saved before and restored after reset.
- *
- * Same as above except return -EAGAIN if the slot cannot be locked
- */
-static int __pci_reset_slot(struct pci_slot *slot)
-{
-	int rc;
-
-	rc = pci_slot_reset(slot, PCI_RESET_PROBE);
-	if (rc)
-		return rc;
-
-	if (pci_slot_trylock(slot)) {
-		pci_slot_save_and_disable_locked(slot);
-		might_sleep();
-		rc = pci_reset_hotplug_slot(slot->hotplug, PCI_RESET_DO_RESET);
-		pci_slot_restore_locked(slot);
-		pci_slot_unlock(slot);
-	} else
-		rc = -EAGAIN;
-
-	return rc;
-}
-
-static int pci_bus_reset(struct pci_bus *bus, bool probe)
-{
-	int ret;
-
-	if (!bus->self || !pci_bus_resettable(bus))
-		return -ENOTTY;
-
-	if (probe)
-		return 0;
-
-	pci_bus_lock(bus);
-
-	might_sleep();
-
-	ret = pci_bridge_secondary_bus_reset(bus->self);
-
-	pci_bus_unlock(bus);
-
-	return ret;
-}
-
-/**
- * pci_bus_error_reset - reset the bridge's subordinate bus
- * @bridge: The parent device that connects to the bus to reset
- *
- * This function will first try to reset the slots on this bus if the method is
- * available. If slot reset fails or is not available, this will fall back to a
- * secondary bus reset.
- */
-int pci_bus_error_reset(struct pci_dev *bridge)
-{
-	struct pci_bus *bus = bridge->subordinate;
-	struct pci_slot *slot;
-
-	if (!bus)
-		return -ENOTTY;
-
-	mutex_lock(&pci_slot_mutex);
-	if (list_empty(&bus->slots))
-		goto bus_reset;
-
-	list_for_each_entry(slot, &bus->slots, list)
-		if (pci_probe_reset_slot(slot))
-			goto bus_reset;
-
-	list_for_each_entry(slot, &bus->slots, list)
-		if (pci_slot_reset(slot, PCI_RESET_DO_RESET))
-			goto bus_reset;
-
-	mutex_unlock(&pci_slot_mutex);
-	return 0;
-bus_reset:
-	mutex_unlock(&pci_slot_mutex);
-	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
-}
-
-/**
- * pci_probe_reset_bus - probe whether a PCI bus can be reset
- * @bus: PCI bus to probe
- *
- * Return 0 if bus can be reset, negative if a bus reset is not supported.
- */
-int pci_probe_reset_bus(struct pci_bus *bus)
-{
-	return pci_bus_reset(bus, PCI_RESET_PROBE);
-}
-EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
-
-/**
- * __pci_reset_bus - Try to reset a PCI bus
- * @bus: top level PCI bus to reset
- *
- * Same as above except return -EAGAIN if the bus cannot be locked
- */
-int __pci_reset_bus(struct pci_bus *bus)
-{
-	int rc;
-
-	rc = pci_bus_reset(bus, PCI_RESET_PROBE);
-	if (rc)
-		return rc;
-
-	if (pci_bus_trylock(bus)) {
-		pci_bus_save_and_disable_locked(bus);
-		might_sleep();
-		rc = pci_bridge_secondary_bus_reset(bus->self);
-		pci_bus_restore_locked(bus);
-		pci_bus_unlock(bus);
-	} else
-		rc = -EAGAIN;
-
-	return rc;
-}
-
-/**
- * pci_reset_bus - Try to reset a PCI bus
- * @pdev: top level PCI device to reset via slot/bus
- *
- * Same as above except return -EAGAIN if the bus cannot be locked
- */
-int pci_reset_bus(struct pci_dev *pdev)
-{
-	return (!pci_probe_reset_slot(pdev->slot)) ?
-	    __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
-}
-EXPORT_SYMBOL_GPL(pci_reset_bus);
-
 /**
  * pcix_get_max_mmrbc - get PCI-X maximum designed memory read byte count
  * @dev: PCI device to query
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62..fece1bbf690e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -154,6 +154,7 @@ void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
+void pci_dev_d3_sleep(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
 static inline bool pci_bus_rrs_vendor_id(u32 l)
@@ -789,6 +790,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
 
+bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active, int delay);
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 
diff --git a/drivers/pci/reset.c b/drivers/pci/reset.c
new file mode 100644
index 000000000000..ddaf213b2ec6
--- /dev/null
+++ b/drivers/pci/reset.c
@@ -0,0 +1,1253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Reset and Restore Logic
+ */
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/minmax.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+
+#include "pci.h"
+
+/*
+ * Following exit from Conventional Reset, devices must be ready within 1 sec
+ * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
+ * Reset (PCIe r6.0 sec 5.8).
+ */
+#define PCI_RESET_WAIT 1000 /* msec */
+
+/*
+ * Devices may extend the 1 sec period through Request Retry Status
+ * completions (PCIe r6.0 sec 2.3.1).  The spec does not provide an upper
+ * limit, but 60 sec ought to be enough for any device to become
+ * responsive.
+ */
+#define PCIE_RESET_READY_POLL_MS 60000 /* msec */
+
+bool pci_reset_supported(struct pci_dev *dev)
+{
+	return dev->reset_methods[0] != 0;
+}
+
+/**
+ * pcibios_set_pcie_reset_state - set reset state for device dev
+ * @dev: the PCIe device reset
+ * @state: Reset state to enter into
+ *
+ * Set the PCIe reset state for the device. This is the default
+ * implementation. Architecture implementations can override this.
+ */
+int __weak pcibios_set_pcie_reset_state(struct pci_dev *dev,
+					enum pcie_reset_state state)
+{
+	return -EINVAL;
+}
+
+/**
+ * pci_set_pcie_reset_state - set reset state for device dev
+ * @dev: the PCIe device reset
+ * @state: Reset state to enter into
+ *
+ * Sets the PCI reset state for the device.
+ */
+int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
+{
+	return pcibios_set_pcie_reset_state(dev, state);
+}
+EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
+
+static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
+{
+	int delay = 1;
+	bool retrain = false;
+	struct pci_dev *root, *bridge;
+
+	root = pcie_find_root_port(dev);
+
+	if (pci_is_pcie(dev)) {
+		bridge = pci_upstream_bridge(dev);
+		if (bridge)
+			retrain = true;
+	}
+
+	/*
+	 * The caller has already waited long enough after a reset that the
+	 * device should respond to config requests, but it may respond
+	 * with Request Retry Status (RRS) if it needs more time to
+	 * initialize.
+	 *
+	 * If the device is below a Root Port with Configuration RRS
+	 * Software Visibility enabled, reading the Vendor ID returns a
+	 * special data value if the device responded with RRS.  Read the
+	 * Vendor ID until we get non-RRS status.
+	 *
+	 * If there's no Root Port or Configuration RRS Software Visibility
+	 * is not enabled, the device may still respond with RRS, but
+	 * hardware may retry the config request.  If no retries receive
+	 * Successful Completion, hardware generally synthesizes ~0
+	 * (PCI_ERROR_RESPONSE) data to complete the read.  Reading Vendor
+	 * ID for VFs and non-existent devices also returns ~0, so read the
+	 * Command register until it returns something other than ~0.
+	 */
+	for (;;) {
+		u32 id;
+
+		if (pci_dev_is_disconnected(dev)) {
+			pci_dbg(dev, "disconnected; not waiting\n");
+			return -ENOTTY;
+		}
+
+		if (root && root->config_rrs_sv) {
+			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
+			if (!pci_bus_rrs_vendor_id(id))
+				break;
+		} else {
+			pci_read_config_dword(dev, PCI_COMMAND, &id);
+			if (!PCI_POSSIBLE_ERROR(id))
+				break;
+		}
+
+		if (delay > timeout) {
+			pci_warn(dev, "not ready %dms after %s; giving up\n",
+				 delay - 1, reset_type);
+			return -ENOTTY;
+		}
+
+		if (delay > PCI_RESET_WAIT) {
+			if (retrain) {
+				retrain = false;
+				if (pcie_failed_link_retrain(bridge) == 0) {
+					delay = 1;
+					continue;
+				}
+			}
+			pci_info(dev, "not ready %dms after %s; waiting\n",
+				 delay - 1, reset_type);
+		}
+
+		msleep(delay);
+		delay *= 2;
+	}
+
+	if (delay > PCI_RESET_WAIT)
+		pci_info(dev, "ready %dms after %s\n", delay - 1,
+			 reset_type);
+	else
+		pci_dbg(dev, "ready %dms after %s\n", delay - 1,
+			reset_type);
+
+	return 0;
+}
+
+/*
+ * Find maximum D3cold delay required by all the devices on the bus.  The
+ * spec says 100 ms, but firmware can lower it and we allow drivers to
+ * increase it as well.
+ *
+ * Called with @pci_bus_sem locked for reading.
+ */
+static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
+{
+	const struct pci_dev *pdev;
+	int min_delay = 100;
+	int max_delay = 0;
+
+	list_for_each_entry(pdev, &bus->devices, bus_list) {
+		if (pdev->d3cold_delay < min_delay)
+			min_delay = pdev->d3cold_delay;
+		if (pdev->d3cold_delay > max_delay)
+			max_delay = pdev->d3cold_delay;
+	}
+
+	return max(min_delay, max_delay);
+}
+
+/**
+ * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
+ * @dev: PCI bridge
+ * @reset_type: reset type in human-readable form
+ *
+ * Handle necessary delays before access to the devices on the secondary
+ * side of the bridge are permitted after D3cold to D0 transition
+ * or Conventional Reset.
+ *
+ * For PCIe this means the delays in PCIe 5.0 section 6.6.1. For
+ * conventional PCI it means Tpvrh + Trhfa specified in PCI 3.0 section
+ * 4.3.2.
+ *
+ * Return 0 on success or -ENOTTY if the first device on the secondary bus
+ * failed to become accessible.
+ */
+int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
+{
+	struct pci_dev *child __free(pci_dev_put) = NULL;
+	int delay;
+
+	if (pci_dev_is_disconnected(dev))
+		return 0;
+
+	if (!pci_is_bridge(dev))
+		return 0;
+
+	down_read(&pci_bus_sem);
+
+	/*
+	 * We only deal with devices that are present currently on the bus.
+	 * For any hot-added devices the access delay is handled in pciehp
+	 * board_added(). In case of ACPI hotplug the firmware is expected
+	 * to configure the devices before OS is notified.
+	 */
+	if (!dev->subordinate || list_empty(&dev->subordinate->devices)) {
+		up_read(&pci_bus_sem);
+		return 0;
+	}
+
+	/* Take d3cold_delay requirements into account */
+	delay = pci_bus_max_d3cold_delay(dev->subordinate);
+	if (!delay) {
+		up_read(&pci_bus_sem);
+		return 0;
+	}
+
+	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
+					     struct pci_dev, bus_list));
+	up_read(&pci_bus_sem);
+
+	/*
+	 * Conventional PCI and PCI-X we need to wait Tpvrh + Trhfa before
+	 * accessing the device after reset (that is 1000 ms + 100 ms).
+	 */
+	if (!pci_is_pcie(dev)) {
+		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
+		msleep(1000 + delay);
+		return 0;
+	}
+
+	/*
+	 * For PCIe downstream and root ports that do not support speeds
+	 * greater than 5 GT/s need to wait minimum 100 ms. For higher
+	 * speeds (gen3) we need to wait first for the data link layer to
+	 * become active.
+	 *
+	 * However, 100 ms is the minimum and the PCIe spec says the
+	 * software must allow at least 1s before it can determine that the
+	 * device that did not respond is a broken device. Also device can
+	 * take longer than that to respond if it indicates so through Request
+	 * Retry Status completions.
+	 *
+	 * Therefore we wait for 100 ms and check for the device presence
+	 * until the timeout expires.
+	 */
+	if (!pcie_downstream_port(dev))
+		return 0;
+
+	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
+		u16 status;
+
+		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
+		msleep(delay);
+
+		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
+			return 0;
+
+		/*
+		 * If the port supports active link reporting we now check
+		 * whether the link is active and if not bail out early with
+		 * the assumption that the device is not present anymore.
+		 */
+		if (!dev->link_active_reporting)
+			return -ENOTTY;
+
+		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
+		if (!(status & PCI_EXP_LNKSTA_DLLLA))
+			return -ENOTTY;
+
+		return pci_dev_wait(child, reset_type,
+				    PCIE_RESET_READY_POLL_MS - PCI_RESET_WAIT);
+	}
+
+	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
+		delay);
+	if (!pcie_wait_for_link_delay(dev, true, delay)) {
+		/* Did not train, no need to wait any further */
+		pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
+		return -ENOTTY;
+	}
+
+	return pci_dev_wait(child, reset_type,
+			    PCIE_RESET_READY_POLL_MS - delay);
+}
+
+/**
+ * pcie_flr - initiate a PCIe function level reset
+ * @dev: device to reset
+ *
+ * Initiate a function level reset unconditionally on @dev without
+ * checking any flags and DEVCAP
+ */
+int pcie_flr(struct pci_dev *dev)
+{
+	if (!pci_wait_for_pending_transaction(dev))
+		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
+
+	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
+
+	if (dev->imm_ready)
+		return 0;
+
+	/*
+	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
+	 * 100ms, but may silently discard requests while the FLR is in
+	 * progress.  Wait 100ms before trying to access the device.
+	 */
+	msleep(100);
+
+	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+}
+EXPORT_SYMBOL_GPL(pcie_flr);
+
+/**
+ * pcie_reset_flr - initiate a PCIe function level reset
+ * @dev: device to reset
+ * @probe: if true, return 0 if device can be reset this way
+ *
+ * Initiate a function level reset on @dev.
+ */
+int pcie_reset_flr(struct pci_dev *dev, bool probe)
+{
+	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
+		return -ENOTTY;
+
+	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	return pcie_flr(dev);
+}
+EXPORT_SYMBOL_GPL(pcie_reset_flr);
+
+static int pci_af_flr(struct pci_dev *dev, bool probe)
+{
+	int pos;
+	u8 cap;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
+	if (!pos)
+		return -ENOTTY;
+
+	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
+		return -ENOTTY;
+
+	pci_read_config_byte(dev, pos + PCI_AF_CAP, &cap);
+	if (!(cap & PCI_AF_CAP_TP) || !(cap & PCI_AF_CAP_FLR))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	/*
+	 * Wait for Transaction Pending bit to clear.  A word-aligned test
+	 * is used, so we use the control offset rather than status and shift
+	 * the test bit to match.
+	 */
+	if (!pci_wait_for_pending(dev, pos + PCI_AF_CTRL,
+				 PCI_AF_STATUS_TP << 8))
+		pci_err(dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
+
+	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
+
+	if (dev->imm_ready)
+		return 0;
+
+	/*
+	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
+	 * updated 27 July 2006; a device must complete an FLR within
+	 * 100ms, but may silently discard requests while the FLR is in
+	 * progress.  Wait 100ms before trying to access the device.
+	 */
+	msleep(100);
+
+	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+}
+
+/**
+ * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
+ * @dev: Device to reset.
+ * @probe: if true, return 0 if the device can be reset this way.
+ *
+ * If @dev supports native PCI PM and its PCI_PM_CTRL_NO_SOFT_RESET flag is
+ * unset, it will be reinitialized internally when going from PCI_D3hot to
+ * PCI_D0.  If that's the case and the device is not in a low-power state
+ * already, force it into PCI_D3hot and back to PCI_D0, causing it to be reset.
+ *
+ * NOTE: This causes the caller to sleep for twice the device power transition
+ * cooldown period, which for the D0->D3hot and D3hot->D0 transitions is 10 ms
+ * by default (i.e. unless the @dev's d3hot_delay field has a different value).
+ * Moreover, only devices in D0 can be reset by this function.
+ */
+static int pci_pm_reset(struct pci_dev *dev, bool probe)
+{
+	u16 csr;
+
+	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
+		return -ENOTTY;
+
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &csr);
+	if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	if (dev->current_state != PCI_D0)
+		return -EINVAL;
+
+	csr &= ~PCI_PM_CTRL_STATE_MASK;
+	csr |= PCI_D3hot;
+	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
+	pci_dev_d3_sleep(dev);
+
+	csr &= ~PCI_PM_CTRL_STATE_MASK;
+	csr |= PCI_D0;
+	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
+	pci_dev_d3_sleep(dev);
+
+	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
+}
+
+void pci_reset_secondary_bus(struct pci_dev *dev)
+{
+	u16 ctrl;
+
+	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
+	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
+
+	/*
+	 * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
+	 * this to 2ms to ensure that we meet the minimum requirement.
+	 */
+	msleep(2);
+
+	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
+}
+
+void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
+{
+	pci_reset_secondary_bus(dev);
+}
+
+/**
+ * pci_bridge_secondary_bus_reset - Reset the secondary bus on a PCI bridge.
+ * @dev: Bridge device
+ *
+ * Use the bridge control register to assert reset on the secondary bus.
+ * Devices on the secondary bus are left in power-on state.
+ */
+int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
+{
+	if (!dev->block_cfg_access)
+		pci_warn_once(dev, "unlocked secondary bus reset via: %pS\n",
+			      __builtin_return_address(0));
+	pcibios_reset_secondary_bus(dev);
+
+	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
+}
+EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
+
+static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
+{
+	struct pci_dev *pdev;
+
+	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
+	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
+		return -ENOTTY;
+
+	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
+		if (pdev != dev)
+			return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	return pci_bridge_secondary_bus_reset(dev->bus->self);
+}
+
+static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
+{
+	int rc = -ENOTTY;
+
+	if (!hotplug || !try_module_get(hotplug->owner))
+		return rc;
+
+	if (hotplug->ops->reset_slot)
+		rc = hotplug->ops->reset_slot(hotplug, probe);
+
+	module_put(hotplug->owner);
+
+	return rc;
+}
+
+static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
+{
+	if (dev->multifunction || dev->subordinate || !dev->slot ||
+	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
+		return -ENOTTY;
+
+	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
+}
+
+static u16 cxl_port_dvsec(struct pci_dev *dev)
+{
+	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					 PCI_DVSEC_CXL_PORT);
+}
+
+static bool cxl_sbr_masked(struct pci_dev *dev)
+{
+	u16 dvsec, reg;
+	int rc;
+
+	dvsec = cxl_port_dvsec(dev);
+	if (!dvsec)
+		return false;
+
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	if (rc || PCI_POSSIBLE_ERROR(reg))
+		return false;
+
+	/*
+	 * Per CXL spec r3.1, sec 8.1.5.2, when "Unmask SBR" is 0, the SBR
+	 * bit in Bridge Control has no effect.  When 1, the Port generates
+	 * hot reset when the SBR bit is set to 1.
+	 */
+	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
+		return false;
+
+	return true;
+}
+
+static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(dev);
+	int rc;
+
+	/*
+	 * If "dev" is below a CXL port that has SBR control masked, SBR
+	 * won't do anything, so return error.
+	 */
+	if (bridge && cxl_sbr_masked(bridge)) {
+		if (probe)
+			return 0;
+
+		return -ENOTTY;
+	}
+
+	rc = pci_dev_reset_slot_function(dev, probe);
+	if (rc != -ENOTTY)
+		return rc;
+	return pci_parent_bus_reset(dev, probe);
+}
+
+static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
+{
+	struct pci_dev *bridge;
+	u16 dvsec, reg, val;
+	int rc;
+
+	bridge = pci_upstream_bridge(dev);
+	if (!bridge)
+		return -ENOTTY;
+
+	dvsec = cxl_port_dvsec(bridge);
+	if (!dvsec)
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	if (rc)
+		return -ENOTTY;
+
+	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
+		val = reg;
+	} else {
+		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
+		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+				      val);
+	}
+
+	rc = pci_reset_bus_function(dev, probe);
+
+	if (reg != val)
+		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+				      reg);
+
+	return rc;
+}
+
+/* dev->reset_methods[] is a 0-terminated list of indices into this array */
+const struct pci_reset_fn_method pci_reset_fn_methods[] = {
+	{ },
+	{ pci_dev_specific_reset, .name = "device_specific" },
+	{ pci_dev_acpi_reset, .name = "acpi" },
+	{ pcie_reset_flr, .name = "flr" },
+	{ pci_af_flr, .name = "af_flr" },
+	{ pci_pm_reset, .name = "pm" },
+	{ pci_reset_bus_function, .name = "bus" },
+	{ cxl_reset_bus_function, .name = "cxl_bus" },
+};
+
+/**
+ * __pci_reset_function_locked - reset a PCI device function while holding
+ * the @dev mutex lock.
+ * @dev: PCI device to reset
+ *
+ * Some devices allow an individual function to be reset without affecting
+ * other functions in the same device.  The PCI device must be responsive
+ * to PCI config space in order to use this function.
+ *
+ * The device function is presumed to be unused and the caller is holding
+ * the device mutex lock when this function is called.
+ *
+ * Resetting the device will make the contents of PCI configuration space
+ * random, so any caller of this must be prepared to reinitialise the
+ * device including MSI, bus mastering, BARs, decoding IO and memory spaces,
+ * etc.
+ *
+ * Returns 0 if the device function was successfully reset or negative if the
+ * device doesn't support resetting a single function.
+ */
+int __pci_reset_function_locked(struct pci_dev *dev)
+{
+	int i, m, rc;
+	const struct pci_reset_fn_method *method;
+
+	might_sleep();
+
+	/*
+	 * A reset method returns -ENOTTY if it doesn't support this device and
+	 * we should try the next method.
+	 *
+	 * If it returns 0 (success), we're finished.  If it returns any other
+	 * error, we're also finished: this indicates that further reset
+	 * mechanisms might be broken on the device.
+	 */
+	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
+		m = dev->reset_methods[i];
+		if (!m)
+			return -ENOTTY;
+
+		method = &pci_reset_fn_methods[m];
+		pci_dbg(dev, "reset via %s\n", method->name);
+		rc = method->reset_fn(dev, PCI_RESET_DO_RESET);
+		if (!rc)
+			return 0;
+
+		pci_dbg(dev, "%s failed with %d\n", method->name, rc);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	return -ENOTTY;
+}
+EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
+
+/**
+ * pci_init_reset_methods - check whether device can be safely reset
+ * and store supported reset mechanisms.
+ * @dev: PCI device to check for reset mechanisms
+ *
+ * Some devices allow an individual function to be reset without affecting
+ * other functions in the same device.  The PCI device must be in D0-D3hot
+ * state.
+ *
+ * Stores reset mechanisms supported by device in reset_methods byte array
+ * which is a member of struct pci_dev.
+ */
+void pci_init_reset_methods(struct pci_dev *dev)
+{
+	int m, i, rc;
+
+	BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_NUM_RESET_METHODS);
+
+	might_sleep();
+
+	i = 0;
+	for (m = 1; m < PCI_NUM_RESET_METHODS; m++) {
+		rc = pci_reset_fn_methods[m].reset_fn(dev, PCI_RESET_PROBE);
+		if (!rc)
+			dev->reset_methods[i++] = m;
+		else if (rc != -ENOTTY)
+			break;
+	}
+
+	dev->reset_methods[i] = 0;
+}
+
+static void pci_dev_save_and_disable(struct pci_dev *dev)
+{
+	const struct pci_error_handlers *err_handler =
+			dev->driver ? dev->driver->err_handler : NULL;
+
+	/*
+	 * dev->driver->err_handler->reset_prepare() is protected against
+	 * races with ->remove() by the device lock, which must be held by
+	 * the caller.
+	 */
+	if (err_handler && err_handler->reset_prepare)
+		err_handler->reset_prepare(dev);
+	else if (dev->driver)
+		pci_warn(dev, "resetting");
+
+	/*
+	 * Wake-up device prior to save.  PM registers default to D0 after
+	 * reset and a simple register restore doesn't reliably return
+	 * to a non-D0 state anyway.
+	 */
+	pci_set_power_state(dev, PCI_D0);
+
+	pci_save_state(dev);
+	/*
+	 * Disable the device by clearing the Command register, except for
+	 * INTx-disable which is set.  This not only disables MMIO and I/O port
+	 * BARs, but also prevents the device from being Bus Master, preventing
+	 * DMA from the device including MSI/MSI-X interrupts.  For PCI 2.3
+	 * compliant devices, INTx-disable prevents legacy interrupts.
+	 */
+	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+}
+
+static void pci_dev_restore(struct pci_dev *dev)
+{
+	const struct pci_error_handlers *err_handler =
+			dev->driver ? dev->driver->err_handler : NULL;
+
+	pci_restore_state(dev);
+
+	/*
+	 * dev->driver->err_handler->reset_done() is protected against
+	 * races with ->remove() by the device lock, which must be held by
+	 * the caller.
+	 */
+	if (err_handler && err_handler->reset_done)
+		err_handler->reset_done(dev);
+	else if (dev->driver)
+		pci_warn(dev, "reset done");
+}
+
+/**
+ * pci_reset_function - quiesce and reset a PCI device function
+ * @dev: PCI device to reset
+ *
+ * Some devices allow an individual function to be reset without affecting
+ * other functions in the same device.  The PCI device must be responsive
+ * to PCI config space in order to use this function.
+ *
+ * This function does not just reset the PCI portion of a device, but
+ * clears all the state associated with the device.  This function differs
+ * from __pci_reset_function_locked() in that it saves and restores device state
+ * over the reset and takes the PCI device lock.
+ *
+ * Returns 0 if the device function was successfully reset or negative if the
+ * device doesn't support resetting a single function.
+ */
+int pci_reset_function(struct pci_dev *dev)
+{
+	struct pci_dev *bridge;
+	int rc;
+
+	if (!pci_reset_supported(dev))
+		return -ENOTTY;
+
+	/*
+	 * If there's no upstream bridge, no locking is needed since there is
+	 * no upstream bridge configuration to hold consistent.
+	 */
+	bridge = pci_upstream_bridge(dev);
+	if (bridge)
+		pci_dev_lock(bridge);
+
+	pci_dev_lock(dev);
+	pci_dev_save_and_disable(dev);
+
+	rc = __pci_reset_function_locked(dev);
+
+	pci_dev_restore(dev);
+	pci_dev_unlock(dev);
+
+	if (bridge)
+		pci_dev_unlock(bridge);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pci_reset_function);
+
+/**
+ * pci_reset_function_locked - quiesce and reset a PCI device function
+ * @dev: PCI device to reset
+ *
+ * Some devices allow an individual function to be reset without affecting
+ * other functions in the same device.  The PCI device must be responsive
+ * to PCI config space in order to use this function.
+ *
+ * This function does not just reset the PCI portion of a device, but
+ * clears all the state associated with the device.  This function differs
+ * from __pci_reset_function_locked() in that it saves and restores device state
+ * over the reset.  It also differs from pci_reset_function() in that it
+ * requires the PCI device lock to be held.
+ *
+ * Returns 0 if the device function was successfully reset or negative if the
+ * device doesn't support resetting a single function.
+ */
+int pci_reset_function_locked(struct pci_dev *dev)
+{
+	int rc;
+
+	if (!pci_reset_supported(dev))
+		return -ENOTTY;
+
+	pci_dev_save_and_disable(dev);
+
+	rc = __pci_reset_function_locked(dev);
+
+	pci_dev_restore(dev);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pci_reset_function_locked);
+
+/**
+ * pci_try_reset_function - quiesce and reset a PCI device function
+ * @dev: PCI device to reset
+ *
+ * Same as above, except return -EAGAIN if unable to lock device.
+ */
+int pci_try_reset_function(struct pci_dev *dev)
+{
+	int rc;
+
+	if (!pci_reset_supported(dev))
+		return -ENOTTY;
+
+	if (!pci_dev_trylock(dev))
+		return -EAGAIN;
+
+	pci_dev_save_and_disable(dev);
+	rc = __pci_reset_function_locked(dev);
+	pci_dev_restore(dev);
+	pci_dev_unlock(dev);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pci_try_reset_function);
+
+/* Do any devices on or below this bus prevent a bus reset? */
+static bool pci_bus_resettable(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	if (bus->self && (bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
+		return false;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (!pci_reset_supported(dev))
+			return false;
+		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
+		    (dev->subordinate && !pci_bus_resettable(dev->subordinate)))
+			return false;
+	}
+
+	return true;
+}
+
+/* Lock devices from the top of the tree down */
+static void pci_bus_lock(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	pci_dev_lock(bus->self);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (dev->subordinate)
+			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
+	}
+}
+
+/* Unlock devices from the bottom of the tree up */
+static void pci_bus_unlock(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (dev->subordinate)
+			pci_bus_unlock(dev->subordinate);
+		else
+			pci_dev_unlock(dev);
+	}
+	pci_dev_unlock(bus->self);
+}
+
+/* Return 1 on successful lock, 0 on contention */
+static int pci_bus_trylock(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	if (!pci_dev_trylock(bus->self))
+		return 0;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (dev->subordinate) {
+			if (!pci_bus_trylock(dev->subordinate))
+				goto unlock;
+		} else if (!pci_dev_trylock(dev))
+			goto unlock;
+	}
+	return 1;
+
+unlock:
+	list_for_each_entry_continue_reverse(dev, &bus->devices, bus_list) {
+		if (dev->subordinate)
+			pci_bus_unlock(dev->subordinate);
+		else
+			pci_dev_unlock(dev);
+	}
+	pci_dev_unlock(bus->self);
+	return 0;
+}
+
+/* Do any devices on or below this slot prevent a bus reset? */
+static bool pci_slot_resettable(struct pci_slot *slot)
+{
+	struct pci_dev *dev;
+
+	if (slot->bus->self &&
+	    (slot->bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
+		return false;
+
+	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
+		if (!dev->slot || dev->slot != slot)
+			continue;
+		if (!pci_reset_supported(dev))
+			return false;
+		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
+		    (dev->subordinate && !pci_bus_resettable(dev->subordinate)))
+			return false;
+	}
+
+	return true;
+}
+
+/* Lock devices from the top of the tree down */
+static void pci_slot_lock(struct pci_slot *slot)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
+		if (!dev->slot || dev->slot != slot)
+			continue;
+		if (dev->subordinate)
+			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
+	}
+}
+
+/* Unlock devices from the bottom of the tree up */
+static void pci_slot_unlock(struct pci_slot *slot)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
+		if (!dev->slot || dev->slot != slot)
+			continue;
+		if (dev->subordinate)
+			pci_bus_unlock(dev->subordinate);
+		else
+			pci_dev_unlock(dev);
+	}
+}
+
+/* Return 1 on successful lock, 0 on contention */
+static int pci_slot_trylock(struct pci_slot *slot)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
+		if (!dev->slot || dev->slot != slot)
+			continue;
+		if (dev->subordinate) {
+			if (!pci_bus_trylock(dev->subordinate)) {
+				pci_dev_unlock(dev);
+				goto unlock;
+			}
+		} else if (!pci_dev_trylock(dev))
+			goto unlock;
+	}
+	return 1;
+
+unlock:
+	list_for_each_entry_continue_reverse(dev,
+					     &slot->bus->devices, bus_list) {
+		if (!dev->slot || dev->slot != slot)
+			continue;
+		if (dev->subordinate)
+			pci_bus_unlock(dev->subordinate);
+		else
+			pci_dev_unlock(dev);
+	}
+	return 0;
+}
+
+/*
+ * Save and disable devices from the top of the tree down while holding
+ * the @dev mutex lock for the entire tree.
+ */
+static void pci_bus_save_and_disable_locked(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pci_dev_save_and_disable(dev);
+		if (dev->subordinate)
+			pci_bus_save_and_disable_locked(dev->subordinate);
+	}
+}
+
+/*
+ * Restore devices from top of the tree down while holding @dev mutex lock
+ * for the entire tree.  Parent bridges need to be restored before we can
+ * get to subordinate devices.
+ */
+static void pci_bus_restore_locked(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pci_dev_restore(dev);
+		if (dev->subordinate) {
+			pci_bridge_wait_for_secondary_bus(dev, "bus reset");
+			pci_bus_restore_locked(dev->subordinate);
+		}
+	}
+}
+
+/*
+ * Save and disable devices from the top of the tree down while holding
+ * the @dev mutex lock for the entire tree.
+ */
+static void pci_slot_save_and_disable_locked(struct pci_slot *slot)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
+		if (!dev->slot || dev->slot != slot)
+			continue;
+		pci_dev_save_and_disable(dev);
+		if (dev->subordinate)
+			pci_bus_save_and_disable_locked(dev->subordinate);
+	}
+}
+
+/*
+ * Restore devices from top of the tree down while holding @dev mutex lock
+ * for the entire tree.  Parent bridges need to be restored before we can
+ * get to subordinate devices.
+ */
+static void pci_slot_restore_locked(struct pci_slot *slot)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
+		if (!dev->slot || dev->slot != slot)
+			continue;
+		pci_dev_restore(dev);
+		if (dev->subordinate) {
+			pci_bridge_wait_for_secondary_bus(dev, "slot reset");
+			pci_bus_restore_locked(dev->subordinate);
+		}
+	}
+}
+
+static int pci_slot_reset(struct pci_slot *slot, bool probe)
+{
+	int rc;
+
+	if (!slot || !pci_slot_resettable(slot))
+		return -ENOTTY;
+
+	if (!probe)
+		pci_slot_lock(slot);
+
+	might_sleep();
+
+	rc = pci_reset_hotplug_slot(slot->hotplug, probe);
+
+	if (!probe)
+		pci_slot_unlock(slot);
+
+	return rc;
+}
+
+/**
+ * pci_probe_reset_slot - probe whether a PCI slot can be reset
+ * @slot: PCI slot to probe
+ *
+ * Return 0 if slot can be reset, negative if a slot reset is not supported.
+ */
+int pci_probe_reset_slot(struct pci_slot *slot)
+{
+	return pci_slot_reset(slot, PCI_RESET_PROBE);
+}
+EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
+
+/**
+ * __pci_reset_slot - Try to reset a PCI slot
+ * @slot: PCI slot to reset
+ *
+ * A PCI bus may host multiple slots, each slot may support a reset mechanism
+ * independent of other slots.  For instance, some slots may support slot power
+ * control.  In the case of a 1:1 bus to slot architecture, this function may
+ * wrap the bus reset to avoid spurious slot related events such as hotplug.
+ * Generally a slot reset should be attempted before a bus reset.  All of the
+ * function of the slot and any subordinate buses behind the slot are reset
+ * through this function.  PCI config space of all devices in the slot and
+ * behind the slot is saved before and restored after reset.
+ *
+ * Same as above except return -EAGAIN if the slot cannot be locked
+ */
+static int __pci_reset_slot(struct pci_slot *slot)
+{
+	int rc;
+
+	rc = pci_slot_reset(slot, PCI_RESET_PROBE);
+	if (rc)
+		return rc;
+
+	if (pci_slot_trylock(slot)) {
+		pci_slot_save_and_disable_locked(slot);
+		might_sleep();
+		rc = pci_reset_hotplug_slot(slot->hotplug, PCI_RESET_DO_RESET);
+		pci_slot_restore_locked(slot);
+		pci_slot_unlock(slot);
+	} else
+		rc = -EAGAIN;
+
+	return rc;
+}
+
+static int pci_bus_reset(struct pci_bus *bus, bool probe)
+{
+	int ret;
+
+	if (!bus->self || !pci_bus_resettable(bus))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	pci_bus_lock(bus);
+
+	might_sleep();
+
+	ret = pci_bridge_secondary_bus_reset(bus->self);
+
+	pci_bus_unlock(bus);
+
+	return ret;
+}
+
+/**
+ * pci_bus_error_reset - reset the bridge's subordinate bus
+ * @bridge: The parent device that connects to the bus to reset
+ *
+ * This function will first try to reset the slots on this bus if the method is
+ * available. If slot reset fails or is not available, this will fall back to a
+ * secondary bus reset.
+ */
+int pci_bus_error_reset(struct pci_dev *bridge)
+{
+	struct pci_bus *bus = bridge->subordinate;
+	struct pci_slot *slot;
+
+	if (!bus)
+		return -ENOTTY;
+
+	mutex_lock(&pci_slot_mutex);
+	if (list_empty(&bus->slots))
+		goto bus_reset;
+
+	list_for_each_entry(slot, &bus->slots, list)
+		if (pci_probe_reset_slot(slot))
+			goto bus_reset;
+
+	list_for_each_entry(slot, &bus->slots, list)
+		if (pci_slot_reset(slot, PCI_RESET_DO_RESET))
+			goto bus_reset;
+
+	mutex_unlock(&pci_slot_mutex);
+	return 0;
+bus_reset:
+	mutex_unlock(&pci_slot_mutex);
+	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
+}
+
+/**
+ * pci_probe_reset_bus - probe whether a PCI bus can be reset
+ * @bus: PCI bus to probe
+ *
+ * Return 0 if bus can be reset, negative if a bus reset is not supported.
+ */
+int pci_probe_reset_bus(struct pci_bus *bus)
+{
+	return pci_bus_reset(bus, PCI_RESET_PROBE);
+}
+EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
+
+/**
+ * __pci_reset_bus - Try to reset a PCI bus
+ * @bus: top level PCI bus to reset
+ *
+ * Same as above except return -EAGAIN if the bus cannot be locked
+ */
+int __pci_reset_bus(struct pci_bus *bus)
+{
+	int rc;
+
+	rc = pci_bus_reset(bus, PCI_RESET_PROBE);
+	if (rc)
+		return rc;
+
+	if (pci_bus_trylock(bus)) {
+		pci_bus_save_and_disable_locked(bus);
+		might_sleep();
+		rc = pci_bridge_secondary_bus_reset(bus->self);
+		pci_bus_restore_locked(bus);
+		pci_bus_unlock(bus);
+	} else
+		rc = -EAGAIN;
+
+	return rc;
+}
+
+/**
+ * pci_reset_bus - Try to reset a PCI bus
+ * @pdev: top level PCI device to reset via slot/bus
+ *
+ * Same as above except return -EAGAIN if the bus cannot be locked
+ */
+int pci_reset_bus(struct pci_dev *pdev)
+{
+	return (!pci_probe_reset_slot(pdev->slot)) ?
+	    __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
+}
+EXPORT_SYMBOL_GPL(pci_reset_bus);
-- 
2.39.5


