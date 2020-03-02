Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F183176307
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgCBSqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:46:12 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:59922 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBSqM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174772; x=1614710772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+4JurlrGb3t9r87PNaUmllkXZG1O6GKaNJNLth7Yflg=;
  b=JU/ZRLQEdlDWgf8kfJhCv9Zf03rB/GoP5XUszCbFy/QFyrPYxxKtquKK
   gLeqyi2T72uygkuiUt9ys/Y01acozf43gS/SV58SNro9poQMucSIDTqJM
   BmO9Z06R9gep0lyTywYsr6q0Kr0v5OgUVztmBiKzLFohsG3MREJRPxBCA
   A=;
IronPort-SDR: b4/wf/BUbq/dEooBe1eRIsHhTCa2DwbQ6ATFygt3ABE7nDwTymPKobmyyelsvzXx5lrlHIID15
 0Jy6NzlCM/6Q==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="20320602"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 02 Mar 2020 18:46:11 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id E2537A2362;
        Mon,  2 Mar 2020 18:46:09 +0000 (UTC)
Received: from EX13D04EUA001.ant.amazon.com (10.43.165.136) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:45:48 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D04EUA001.ant.amazon.com (10.43.165.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:45:47 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:45:43 +0000
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
Subject: [PATCH v2 08/17] PCI: Add more delay overrides to struct pci_dev
Date:   Mon, 2 Mar 2020 19:44:20 +0100
Message-ID: <20200302184429.12880-9-stanspas@amazon.com>
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

Almost all of the PCI_*_DELAY constants declared in drivers/pci/pci.h
can be overridden on a per-device basis, as explained in the constants'
comments. To allow storing per-device values, this patch introduces
a type to describe the various "initialization events":
    enum pci_init_event
and an array in struct pci_dev, with an override for each event.

This array is initially populated with the PCI_*_DELAY constants,
but can be later overridden by pci_acpi_optimize_delay. Quirks and
drivers may also end up tweaking the values.

The new array replaces two previous members: d3_delay and d3cold_delay
Direct mentions of PCI_*_DELAY are replaced with the per-device
override where applicable.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 Documentation/power/pci.rst         |  4 ++-
 arch/x86/pci/intel_mid_pci.c        |  2 +-
 drivers/hid/intel-ish-hid/ipc/ipc.c |  2 +-
 drivers/mfd/intel-lpss-pci.c        |  2 +-
 drivers/net/ethernet/marvell/sky2.c |  2 +-
 drivers/pci/iov.c                   |  4 +--
 drivers/pci/pci-acpi.c              | 42 ++++++++++++++++-------------
 drivers/pci/pci.c                   | 36 ++++++++++++++++++-------
 drivers/pci/quirks.c                |  9 ++++---
 include/linux/pci.h                 | 35 ++++++++++++++++++++++--
 10 files changed, 97 insertions(+), 41 deletions(-)

diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index 0924d29636ad..8136c8a4b150 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -320,7 +320,9 @@ that these callbacks operate on::
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	wakeup_prepared:1;  /* Device prepared for wake up */
-	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
+	unsigned int    delay[PCI_INIT_EVENT_COUNT]; /* minimum waiting time
+							after various events
+							in ms */
 	...
   };
 
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 00c62115f39c..b42b14cd0e00 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -322,7 +322,7 @@ static void pci_d3delay_fixup(struct pci_dev *dev)
 	 */
 	if (type1_access_ok(dev->bus->number, dev->devfn, PCI_DEVICE_ID))
 		return;
-	dev->d3_delay = 0;
+	dev->delay[PCI_INIT_EVENT_D3HOT_TO_D0] = 0;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_d3delay_fixup);
 
diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 8f8dfdf64833..a209b954fbe8 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -755,7 +755,7 @@ static int _ish_hw_reset(struct ishtp_device *dev)
 	csr |= PCI_D3hot;
 	pci_write_config_word(pdev, pdev->pm_cap + PCI_PM_CTRL, csr);
 
-	mdelay(pdev->d3_delay);
+	mdelay(pdev->delay[PCI_INIT_EVENT_D3HOT_TO_D0]);
 
 	csr &= ~PCI_PM_CTRL_STATE_MASK;
 	csr |= PCI_D0;
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index c40a6c7d0cf8..5b9e458d0ab1 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -35,7 +35,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	info->mem = &pdev->resource[0];
 	info->irq = pdev->irq;
 
-	pdev->d3cold_delay = 0;
+	pdev->delay[PCI_INIT_EVENT_RESET] = 0;
 
 	/* Probably it is enough to set this for iDMA capable devices only */
 	pci_set_master(pdev);
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index ebfd0ceac884..f808562e389d 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -5100,7 +5100,7 @@ static int sky2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&hw->restart_work, sky2_restart);
 
 	pci_set_drvdata(pdev, hw);
-	pdev->d3_delay = 300;
+	pdev->delay[PCI_INIT_EVENT_D3HOT_TO_D0] = 300;
 
 	return 0;
 
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index d4e4a0c0a97f..f71fc28b69e6 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -524,7 +524,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-	msleep(PCI_VF_ENABLE_DELAY);
+	msleep(dev->delay[PCI_INIT_EVENT_VF_ENABLE]);
 	pci_cfg_access_unlock(dev);
 
 	rc = sriov_add_vfs(dev, initial);
@@ -735,7 +735,7 @@ static void sriov_restore_state(struct pci_dev *dev)
 	pci_iov_set_numvfs(dev, iov->num_VFs);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	if (iov->ctrl & PCI_SRIOV_CTRL_VFE)
-		msleep(PCI_VF_ENABLE_DELAY);
+		msleep(dev->delay[PCI_INIT_EVENT_VF_ENABLE]);
 }
 
 /**
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 66e8f8199ce0..4b5c29d2a5ab 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1177,11 +1177,11 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev)
 }
 
 /**
- * pci_acpi_optimize_delay - optimize PCI D3 and D3cold delay from ACPI
- * @pdev: the PCI device whose delay is to be updated
+ * pci_acpi_optimize_delay - optimize PCI readiness delays from ACPI
+ * @pdev: the PCI device whose delays are to be updated
  * @handle: ACPI handle of this device
  *
- * Update the d3_delay and d3cold_delay of a PCI device from the ACPI _DSM
+ * Update the readiness delays of a PCI device from the ACPI _DSM
  * Function 9 of the device, and cache the parent host bridge's flag for
  * ignoring reset delay upon Sx Resume (the flag is originally set in
  * acpi_pci_add_bus through _DSM Function 8).
@@ -1226,6 +1226,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	u64 value_us;
 	int value;
 	union acpi_object *obj, *elements;
+	int i;
 
 	pdev->ignore_reset_delay_on_sx_resume =
 		bridge->ignore_reset_delay_on_sx_resume;
@@ -1237,21 +1238,26 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 
 	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 5) {
 		elements = obj->package.elements;
-		if (elements[0].type == ACPI_TYPE_INTEGER) {
-			value_us = elements[0].integer.value;
-			value = (int)(value_us / 1000);
-			if (value_us % 1000 > 0)
-				value++;
-			if (value < PCI_RESET_DELAY)
-				pdev->d3cold_delay = value;
-		}
-		if (elements[3].type == ACPI_TYPE_INTEGER) {
-			value_us = elements[3].integer.value;
-			value = (int)(value_us / 1000);
-			if (value_us % 1000 > 0)
-				value++;
-			if (value < PCI_PM_D3HOT_DELAY)
-				pdev->d3_delay = value;
+		for (i = 0; i < 5; i++) {
+			if (elements[i].type == ACPI_TYPE_INTEGER) {
+				value_us = elements[i].integer.value;
+				value = (int)(value_us / 1000);
+				if (value_us % 1000 > 0)
+					value++;
+				/*
+				 * XXX This relies on the initial values in the
+				 * delay array being set using the PCI_*_DELAY
+				 * macros in drivers/pci/pci.h
+				 * Once the kernel has support for Readiness
+				 * Time Reporting Extended Capability, this
+				 * needs fixing to honor prioritization of
+				 * overrides. Also, a flag would need to be
+				 * set to disable the use of Readiness
+				 * Notifications at some point.
+				 */
+				if (value < pdev->delay[i])
+					pdev->delay[i] = value;
+			}
 		}
 	}
 	ACPI_FREE(obj);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aaef00578487..ba54164652cc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -43,6 +43,15 @@ const char *pci_power_names[] = {
 };
 EXPORT_SYMBOL_GPL(pci_power_names);
 
+const char *pci_init_event_names[] = {
+	[PCI_INIT_EVENT_RESET] = "conventional reset",
+	[PCI_INIT_EVENT_DL_UP] = "DL Up",
+	[PCI_INIT_EVENT_FLR] = "FLR",
+	[PCI_INIT_EVENT_D3HOT_TO_D0] = "PM D3hot->D0",
+	[PCI_INIT_EVENT_VF_ENABLE] = "VF Enable",
+};
+EXPORT_SYMBOL_GPL(pci_init_event_names);
+
 int isa_dma_bridge_buggy;
 EXPORT_SYMBOL(isa_dma_bridge_buggy);
 
@@ -66,7 +75,7 @@ struct pci_pme_device {
 
 static void pci_dev_d3_sleep(struct pci_dev *dev)
 {
-	unsigned int delay = dev->d3_delay;
+	unsigned int delay = dev->delay[PCI_INIT_EVENT_D3HOT_TO_D0];
 
 	if (delay < pci_pm_d3_delay)
 		delay = pci_pm_d3_delay;
@@ -2844,8 +2853,11 @@ void pci_pm_init(struct pci_dev *dev)
 
 	dev->pm_cap = pm;
 	dev->ignore_reset_delay_on_sx_resume = 0;
-	dev->d3_delay = PCI_PM_D3HOT_DELAY;
-	dev->d3cold_delay = PCI_RESET_DELAY;
+	dev->delay[PCI_INIT_EVENT_RESET] = PCI_RESET_DELAY;
+	dev->delay[PCI_INIT_EVENT_DL_UP] = PCI_DL_UP_DELAY;
+	dev->delay[PCI_INIT_EVENT_FLR] = PCI_FLR_DELAY;
+	dev->delay[PCI_INIT_EVENT_D3HOT_TO_D0] = PCI_PM_D3HOT_DELAY;
+	dev->delay[PCI_INIT_EVENT_VF_ENABLE] = PCI_VF_ENABLE_DELAY;
 	dev->bridge_d3 = pci_bridge_d3_possible(dev);
 	dev->d3cold_allowed = true;
 
@@ -4500,7 +4512,7 @@ int pcie_flr(struct pci_dev *dev)
 	if (dev->imm_ready)
 		return 0;
 
-	msleep(PCI_FLR_DELAY);
+	msleep(dev->delay[PCI_INIT_EVENT_FLR]);
 
 	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 }
@@ -4539,7 +4551,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 	if (dev->imm_ready)
 		return 0;
 
-	msleep(PCI_FLR_DELAY);
+	msleep(dev->delay[PCI_INIT_EVENT_FLR]);
 
 	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 }
@@ -4556,7 +4568,9 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
  *
  * NOTE: This causes the caller to sleep for twice the device power transition
  * cooldown period, which for the D0->D3hot and D3hot->D0 transitions is 10 ms
- * by default (i.e. unless the @dev's d3_delay field has a different value).
+ * by default (i.e. unless the @dev's delay[PCI_INIT_EVENT_D3HOT_TO_D0] field
+ * has a different value).
+ *
  * Moreover, only devices in D0 can be reset by this function.
  */
 static int pci_pm_reset(struct pci_dev *dev, int probe)
@@ -4666,12 +4680,14 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
 	const struct pci_dev *pdev;
 	int min_delay = 100;
 	int max_delay = 0;
+	int delay;
 
 	list_for_each_entry(pdev, &bus->devices, bus_list) {
-		if (pdev->d3cold_delay < min_delay)
-			min_delay = pdev->d3cold_delay;
-		if (pdev->d3cold_delay > max_delay)
-			max_delay = pdev->d3cold_delay;
+		delay = pdev->delay[PCI_INIT_EVENT_RESET];
+		if (delay < min_delay)
+			min_delay = delay;
+		if (delay > max_delay)
+			max_delay = delay;
 	}
 
 	return max(min_delay, max_delay);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 29f473ebf20f..12f22af0cbef 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1873,12 +1873,13 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260b, quirk_intel_pcie_pm);
 
 static void quirk_d3hot_delay(struct pci_dev *dev, unsigned int delay)
 {
-	if (dev->d3_delay >= delay)
+
+	if (dev->delay[PCI_INIT_EVENT_D3HOT_TO_D0] >= delay)
 		return;
 
-	dev->d3_delay = delay;
+	dev->delay[PCI_INIT_EVENT_D3HOT_TO_D0] = delay;
 	pci_info(dev, "extending delay after power-on from D3hot to %d msec\n",
-		 dev->d3_delay);
+		 dev->delay[PCI_INIT_EVENT_D3HOT_TO_D0]);
 }
 
 static void quirk_radeon_pm(struct pci_dev *dev)
@@ -3310,7 +3311,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
  */
 static void quirk_remove_d3_delay(struct pci_dev *dev)
 {
-	dev->d3_delay = 0;
+	dev->delay[PCI_INIT_EVENT_D3HOT_TO_D0] = 0;
 }
 /* C600 Series devices do not need 10ms d3_delay */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0412, quirk_remove_d3_delay);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22a5b7164c32..16dbfff2092e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -268,6 +268,36 @@ enum pci_bus_speed {
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 
+/*
+ * The first five constants correspond to delays specified in both:
+ * PCI Firmware Specification Rev. 3.2 (January 26, 2015),
+ * Section 4.6.9. "_DSM for Specifying Device Readiness Durations", and
+ * PCI Express Base Specification  Revision 5.0 Version 1.0 (May 22, 2019)
+ * Section 7.9.17 "Readiness Time Reporting Extended Capability"
+ *
+ * The code assumes these constants are in the same order as in the
+ * PCI Firmware Specification.
+ */
+enum pci_init_event {
+	PCI_INIT_EVENT_RESET		= 0, /* D3cold->D0, SBR */
+	PCI_INIT_EVENT_DL_UP		= 1,
+	PCI_INIT_EVENT_FLR		= 2,
+	PCI_INIT_EVENT_D3HOT_TO_D0	= 3,
+	PCI_INIT_EVENT_VF_ENABLE	= 4,
+	PCI_INIT_EVENT_COUNT  /* Keep this as last element */
+};
+
+/* Remember to update this when the list above changes! */
+extern const char *pci_init_event_names[];
+
+static inline const char *pci_init_event_name(enum pci_init_event event)
+{
+	if (event >= PCI_INIT_EVENT_COUNT)
+		return "<unknown>";
+	else
+		return pci_init_event_names[event];
+}
+
 struct pci_cap_saved_data {
 	u16		cap_nr;
 	bool		cap_extended;
@@ -356,8 +386,9 @@ struct pci_dev {
 						   bit manually */
 	unsigned int    ignore_reset_delay_on_sx_resume:1; /* Cached value from
 							      pci_host_bridge */
-	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
-	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
+	unsigned int    delay[PCI_INIT_EVENT_COUNT]; /* minimum waiting time
+							after various events
+							in ms */
 
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state */
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



