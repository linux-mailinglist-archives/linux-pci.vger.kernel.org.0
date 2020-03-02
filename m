Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C02617630D
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCBSqa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:46:30 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:47672 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgCBSqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174788; x=1614710788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hin5pnYLRZeeL4R19g+s7EtcXGJQv8ECPkAJzZhQii0=;
  b=iaLZ8YO9yi3EyEzGjcj6jkH75QaLaaUJR5VUCkIUq4qKtnOq4DtgSvy/
   NSJ5I6rf/k07kMNuLBbki/9yXE7uqdWlNehpBWiZjLssHoLt3z0AfxMGZ
   oZGTYIoPwufjAtt3+rslJ3ssa//h6dy4W+Lj+JifUVgdqpwfxNiU+yznO
   Q=;
IronPort-SDR: 27xnXP7QY/NNUZkoRY+upazzb2xDuwAwFj4CUT5r+SxptPa1Hlbs7KGcU+S8hc0OuVoziZ633k
 acE+vVzcbqcQ==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="20582195"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 02 Mar 2020 18:46:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 41592A2CB5;
        Mon,  2 Mar 2020 18:46:03 +0000 (UTC)
Received: from EX13D12EUA004.ant.amazon.com (10.43.165.162) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:45:35 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D12EUA004.ant.amazon.com (10.43.165.162) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:45:34 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:45:30 +0000
From:   Stanislav Spassov <stanspas@amazon.com>
To:     <linux-pci@vger.kernel.org>
CC:     Stanislav Spassov <stanspas@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Sinan Kaya" <okaya@kernel.org>, Rajat Jain <rajatja@google.com>
Subject: [PATCH v2 05/17] PCI: Fix handling of _DSM 8 (avoiding reset delays)
Date:   Mon, 2 Mar 2020 19:44:17 +0100
Message-ID: <20200302184429.12880-6-stanspas@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302184429.12880-1-stanspas@amazon.com>
References: <20200302184429.12880-1-stanspas@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Stanislav Spassov <stanspas@amazon.de>

On Sx Resume (boot from ACPI S5, resume from ACPI S4 or S3), platform
firmware may enforce that sufficient time has passed to cover the
mandatory (per PCI Express Specification) power-on reset delays of
all PCI devices before control is handed over to the operating system.
To avoid duplicated waiting by the OS, the firmware uses _DSM 8 in the
ACPI scope of a PCI host bus to inform the OS that for the whole PCI
subsystem underneath that host bridge, power-on reset delays are being
covered by firmware.

Previously, the kernel used _DSM 8 to override the d3cold_delay value
stored in struct pci_dev to 0. However, the assumption that the delay
is covered by firmware when _DSM 8 returns 1 only holds for the
firmware-initiated resets as part of Sx Resume flows. If an OS has the
ability to apply Conventional Reset to devices without system firmware
involvement, then it still needs to adhere to the usual reset delays.

Runtime Device Power Management triggering a D3cold->D0 transition
is an existing example of the kernel not involving system firmware.
Another example is the OS triggering Secondary Bus Reset by setting
the SBR bit in the Bridge Control register of any Port device.

In preparation for future work to improve post-reset delays, this patch
preserves the value of d3cold_delay even when _DSM 8 returns 1.
The decision not to wait after resume is instead taken at a higher level
in pci_bridge_wait_for_secondary_bus based on a new parameter that
indicates whether the waiting is due to an Sx Resume event.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci-acpi.c   | 65 ++++++++++++++++++++++++++++++----------
 drivers/pci/pci-driver.c |  4 +--
 drivers/pci/pci.c        | 11 +++++--
 drivers/pci/pci.h        |  2 +-
 include/linux/pci-acpi.h |  8 ++---
 include/linux/pci.h      |  4 ++-
 6 files changed, 67 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0c02d500158f..a8fa13d6089d 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1120,21 +1120,35 @@ void acpi_pci_add_bus(struct pci_bus *bus)
 	acpi_pci_slot_enumerate(bus);
 	acpiphp_enumerate_slots(bus);
 
-	/*
-	 * For a host bridge, check its _DSM for function 8 and if
-	 * that is available, mark it in pci_host_bridge.
+	/* For a host bridge, check _DSM function 8 and if that returns 1,
+	 * mark it in the pci_host_bridge.
+	 *
+	 * Function 8, "Avoid Power-On Reset Delay Duplication on Sx Resume"
+	 * applies to the entire hierarchy below a PCI host bridge.
+	 * If it returns one, the OS may assume that all devices in the
+	 * hierarchy have already completed power-on reset delays
+	 * before FW handed over control to the OS on Sx Resume (such as boot
+	 * from ACPI S5, or resume from ACPI S4 or S3 states).
+	 * This _DSM is applicable whether reductions in device readiness
+	 * timing, via Readiness Notification or _DSM function 9, are available
+	 * or not.
+	 *
+	 * This _DSM function is defined by the PCI Firmware Specification
+	 * Revision 3.2 (January 26, 2015), after originally introduced by a
+	 * draft ECN of January 28, 2014, titled "ACPI additions for FW latency
+	 * optimizations."
 	 */
 	if (!pci_is_root_bus(bus))
 		return;
 
 	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
-				RESET_DELAY_DSM, NULL);
+				IGNORE_RESET_DELAY_ON_SX_RESUME_DSM, NULL);
 	if (!obj)
 		return;
 
 	if (obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 1) {
 		bridge = pci_find_host_bridge(bus);
-		bridge->ignore_reset_delay = 1;
+		bridge->ignore_reset_delay_on_sx_resume = 1;
 	}
 	ACPI_FREE(obj);
 }
@@ -1168,19 +1182,38 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev)
  * @handle: ACPI handle of this device
  *
  * Update the d3_delay and d3cold_delay of a PCI device from the ACPI _DSM
- * control method of either the device itself or the PCI host bridge.
- *
- * Function 8, "Reset Delay," applies to the entire hierarchy below a PCI
- * host bridge.  If it returns one, the OS may assume that all devices in
- * the hierarchy have already completed power-on reset delays.
+ * Function 9 of the device, and cache the parent host bridge's flag for
+ * ignoring reset delay upon Sx Resume (the flag is originally set in
+ * acpi_pci_add_bus through _DSM Function 8).
  *
  * Function 9, "Device Readiness Durations," applies only to the object
  * where it is located.  It returns delay durations required after various
- * events if the device requires less time than the spec requires.  Delays
- * from this function take precedence over the Reset Delay function.
+ * events if the device requires less time than the spec requires.
+ * Values provided by this function can only be used to lower (reduce) the
+ * latency required by specification or values discovered from device.
+ *
+ * This _DSM function is defined by the PCI Firmware Specification Rev 3.2
+ * (January 26, 2015), after originally introduced by a draft ECN of
+ * January 28, 2014, titled "ACPI additions for FW latency optimizations."
  *
- * These _DSM functions are defined by the draft ECN of January 28, 2014,
- * titled "ACPI additions for FW latency optimizations."
+ * XXX The PCI Firmware Specification contradicts itself by stating, in addition
+ * to the above "can only be used to lower (reduce)", that also:
+ * Values must be interpreted as overriding any Configuration Ready indicator
+ * from hardware, whether increasing or decreasing required delays. This
+ * includes ignoring FRS and DRS notifications where overridden by this
+ * _DSM function, as well as ignoring values specified in the Readiness Time
+ * Reporting Extended Capability, if present.
+ * Meanwhile, the PCI Express Base Specification Revision 5.0 Version 1.0
+ * (22 May 2019) states in section 7.9.17 Readiness Time Reporting Extended
+ * Capability:
+ * Software is permitted to issue requests upon the earliest of:
+ * - Receiving a Readiness Notification messages
+ * - Waiting the appropriate time as per relevant specifications
+ * - Waiting the time indicated in the associated field of this capability
+ * - Waiting the time defined by system software or firmware
+ * The kernel does not yet support Readiness Notifications, and does not yet
+ * use a Readiness Time Reporting capability if present, so we do not need to
+ * worry about the prioritization for now.
  */
 static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 				    acpi_handle handle)
@@ -1189,8 +1222,8 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	int value;
 	union acpi_object *obj, *elements;
 
-	if (bridge->ignore_reset_delay)
-		pdev->d3cold_delay = 0;
+	pdev->ignore_reset_delay_on_sx_resume =
+		bridge->ignore_reset_delay_on_sx_resume;
 
 	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 3,
 				FUNCTION_DELAY_DSM, NULL);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0454ca0e4e3f..7e8ca8115c4f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -917,7 +917,7 @@ static int pci_pm_resume_noirq(struct device *dev)
 	pcie_pme_root_status_cleanup(pci_dev);
 
 	if (!skip_bus_pm && prev_state == PCI_D3cold)
-		pci_bridge_wait_for_secondary_bus(pci_dev);
+		pci_bridge_wait_for_secondary_bus(pci_dev, true);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return 0;
@@ -1321,7 +1321,7 @@ static int pci_pm_runtime_resume(struct device *dev)
 	pci_pm_default_resume(pci_dev);
 
 	if (prev_state == PCI_D3cold)
-		pci_bridge_wait_for_secondary_bus(pci_dev);
+		pci_bridge_wait_for_secondary_bus(pci_dev, false);
 
 	if (pm && pm->runtime_resume)
 		error = pm->runtime_resume(dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 03103bb15b42..4899b12b5a38 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2843,6 +2843,7 @@ void pci_pm_init(struct pci_dev *dev)
 	}
 
 	dev->pm_cap = pm;
+	dev->ignore_reset_delay_on_sx_resume = 0;
 	dev->d3_delay = PCI_PM_D3_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
 	dev->bridge_d3 = pci_bridge_d3_possible(dev);
@@ -4698,7 +4699,7 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
  * conventional PCI it means Tpvrh + Trhfa specified in PCI 3.0 section
  * 4.3.2.
  */
-void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
+void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, bool sx_resume)
 {
 	struct pci_dev *child;
 	int delay;
@@ -4723,7 +4724,11 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 	}
 
 	/* Take d3cold_delay requirements into account */
-	delay = pci_bus_max_d3cold_delay(dev->subordinate);
+	if (sx_resume && dev->ignore_reset_delay_on_sx_resume)
+		delay = 0;
+	else
+		delay = pci_bus_max_d3cold_delay(dev->subordinate);
+
 	if (!delay) {
 		up_read(&pci_bus_sem);
 		return;
@@ -4800,7 +4805,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
 
-	pci_bridge_wait_for_secondary_bus(dev);
+	pci_bridge_wait_for_secondary_bus(dev, false);
 }
 
 void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 659ab3f9042a..c4c3ba926f45 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -107,7 +107,7 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev);
 void pci_free_cap_save_buffers(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
-void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
+void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, bool sx_resume);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 62b7fdcc661c..99865773d65e 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -107,10 +107,10 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
 #endif
 
 extern const guid_t pci_acpi_dsm_guid;
-#define IGNORE_PCI_BOOT_CONFIG_DSM	0x05
-#define DEVICE_LABEL_DSM		0x07
-#define RESET_DELAY_DSM			0x08
-#define FUNCTION_DELAY_DSM		0x09
+#define IGNORE_PCI_BOOT_CONFIG_DSM		0x05
+#define DEVICE_LABEL_DSM			0x07
+#define IGNORE_RESET_DELAY_ON_SX_RESUME_DSM	0x08
+#define FUNCTION_DELAY_DSM			0x09
 
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a541a9de..22a5b7164c32 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -354,6 +354,8 @@ struct pci_dev {
 						      user sysfs */
 	unsigned int	clear_retrain_link:1;	/* Need to clear Retrain Link
 						   bit manually */
+	unsigned int    ignore_reset_delay_on_sx_resume:1; /* Cached value from
+							      pci_host_bridge */
 	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 
@@ -503,7 +505,7 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	void		*release_data;
 	struct msi_controller *msi;
-	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
+	unsigned int	ignore_reset_delay_on_sx_resume:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
 	unsigned int	native_aer:1;		/* OS may use PCIe AER */
 	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



