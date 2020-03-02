Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAE7176306
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgCBSqK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:46:10 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:56169 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBSqK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174769; x=1614710769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KYFiznVd4GCcTMs7pWxyPrB6Z/Apm+l21BN4Ow2lEUM=;
  b=dJvrESnfUHGzyGe8JyArK0ptoGI0P/VC2NSJ07gCEZI6HsdEUlyLStDa
   0x3XqwIXimfYYIr/GQ46VOA6VG2UM54nF3C/uRv6prgMe0gPKFNq+R9g+
   Pv+LZHqkpUIUYPjT+GxFGRl+CxomKNKGmFRxTUEcBwnwml3jBGiE4IyU8
   8=;
IronPort-SDR: ciTfSjOJpvQcJeKfMANr2WgiWQxTHYrJ1xEoIVfrSI5VeBG2AUnBYIe/T+uWGUVkaLV84yT6gl
 FsW7YasdpxKA==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="19142040"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 02 Mar 2020 18:46:08 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 5C77CA187F;
        Mon,  2 Mar 2020 18:46:06 +0000 (UTC)
Received: from EX13D12EUA001.ant.amazon.com (10.43.165.48) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:45:44 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D12EUA001.ant.amazon.com (10.43.165.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:45:42 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:45:39 +0000
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
Subject: [PATCH v2 07/17] PCI: Clean up and document PM/reset delays
Date:   Mon, 2 Mar 2020 19:44:19 +0100
Message-ID: <20200302184429.12880-8-stanspas@amazon.com>
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

...and replace several "magic numbers" scattered throughout the code.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/iov.c      |  4 +--
 drivers/pci/pci-acpi.c |  4 +--
 drivers/pci/pci.c      | 21 +++---------
 drivers/pci/pci.h      | 72 ++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 78 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4d1f392b05f9..d4e4a0c0a97f 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -524,7 +524,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-	msleep(100);
+	msleep(PCI_VF_ENABLE_DELAY);
 	pci_cfg_access_unlock(dev);
 
 	rc = sriov_add_vfs(dev, initial);
@@ -735,7 +735,7 @@ static void sriov_restore_state(struct pci_dev *dev)
 	pci_iov_set_numvfs(dev, iov->num_VFs);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	if (iov->ctrl & PCI_SRIOV_CTRL_VFE)
-		msleep(100);
+		msleep(PCI_VF_ENABLE_DELAY);
 }
 
 /**
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 508924377bff..66e8f8199ce0 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1242,7 +1242,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 			value = (int)(value_us / 1000);
 			if (value_us % 1000 > 0)
 				value++;
-			if (value < PCI_PM_D3COLD_WAIT)
+			if (value < PCI_RESET_DELAY)
 				pdev->d3cold_delay = value;
 		}
 		if (elements[3].type == ACPI_TYPE_INTEGER) {
@@ -1250,7 +1250,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 			value = (int)(value_us / 1000);
 			if (value_us % 1000 > 0)
 				value++;
-			if (value < PCI_PM_D3_WAIT)
+			if (value < PCI_PM_D3HOT_DELAY)
 				pdev->d3_delay = value;
 		}
 	}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4899b12b5a38..aaef00578487 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2844,8 +2844,8 @@ void pci_pm_init(struct pci_dev *dev)
 
 	dev->pm_cap = pm;
 	dev->ignore_reset_delay_on_sx_resume = 0;
-	dev->d3_delay = PCI_PM_D3_WAIT;
-	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
+	dev->d3_delay = PCI_PM_D3HOT_DELAY;
+	dev->d3cold_delay = PCI_RESET_DELAY;
 	dev->bridge_d3 = pci_bridge_d3_possible(dev);
 	dev->d3cold_allowed = true;
 
@@ -4500,12 +4500,7 @@ int pcie_flr(struct pci_dev *dev)
 	if (dev->imm_ready)
 		return 0;
 
-	/*
-	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
-	 * 100ms, but may silently discard requests while the FLR is in
-	 * progress.  Wait 100ms before trying to access the device.
-	 */
-	msleep(100);
+	msleep(PCI_FLR_DELAY);
 
 	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 }
@@ -4544,13 +4539,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 	if (dev->imm_ready)
 		return 0;
 
-	/*
-	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
-	 * updated 27 July 2006; a device must complete an FLR within
-	 * 100ms, but may silently discard requests while the FLR is in
-	 * progress.  Wait 100ms before trying to access the device.
-	 */
-	msleep(100);
+	msleep(PCI_FLR_DELAY);
 
 	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 }
@@ -4590,7 +4579,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	csr &= ~PCI_PM_CTRL_STATE_MASK;
 	csr |= PCI_D3hot;
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
-	msleep(PCI_PM_D3_WAIT);
+	msleep(PCI_PM_D3HOT_DELAY);
 
 	csr &= ~PCI_PM_CTRL_STATE_MASK;
 	csr |= PCI_D0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c4c3ba926f45..9b5dd6ea2f52 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -43,9 +43,75 @@ int pci_probe_reset_function(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 
-#define PCI_PM_D2_DELAY         200
-#define PCI_PM_D3_WAIT          10
-#define PCI_PM_D3COLD_WAIT      100
+/*
+ * These constants represent the minimum amounts of time mandated by the
+ * PCI Express Base specification that software needs to wait after
+ * various PCI device events involving (re-)initialization. Only after
+ * the appropriate delay has elapsed, is software permitted to issue
+ * Configuration Requests targeting the affected device.
+ *
+ * Relevant sections in PCI Express Base Specification r5.0 (May 22, 2019):
+ * - 6.6.1 "Conventional Reset" for PCI_RESET_DELAY and PCI_DL_UP_DELAY
+ * - 6.6.2 "Function Level Reset" for PCI_FLR_DELAY
+ * - 5.9 "State Transition Recovery Time Requirements" for PCI_PM_D3HOT_DELAY
+ *        and PCI_PM_D2_DELAY
+ * - 9.3.3.3.1 "VF Enable" for PCI_VF_ENABLE_DELAY
+ *
+ * There are mechanisms to reduce some of the delay values for specific devices:
+ * - a device may expose the Readiness Time Reporting Extended Capability from:
+ *   PCI Express Base Specification r4.0 (September 27, 2017), sec 7.9.17
+ *   (This is currently not supported by the kernel.)
+ * - system firmware may provide overrides using an ACPI _DSM Function 9:
+ *   PCI Firmware Specification r3.2 (January 26, 2015), sec 4.6.9
+ *   (see pci_acpi_optimize_delay)
+ *
+ * Unless overridden by _DSM Function 9, other mechanisms may be used to reduce
+ * or completely avoid some of the delays:
+ * - Readiness Notifications (DRS and FRS)
+ * - the Immediate Readiness bit of the Status Register in the PCI header
+ * - the Immediate_Readiness_on_Return_to_D0 in the Power Management
+ *   Capabilities Register in the PCI Power Management Capability
+ * (None of these are currently supported by the kernel.)
+ *
+ * Note: While devices are required to be responsive to Configuration
+ * Requests after these delays, they may not respond with Successful
+ * Completion status until they complete potentially lengthy internal
+ * initialization sequences. Instead, devices respond with Configuration
+ * Request Retry Status (CRS) Completions. Therefore, additional waiting
+ * is necessary as handled by pci_dev_wait().
+ */
+/*
+ * Conventional (non-FLR) reset delay, including D3cold->D0 transitions,
+ * Secondary Bus Reset, and any platform-specific means of triggering
+ * a Conventional Reset.
+ *
+ * According to PCI Firmware spec r3.2, sec 4.6.9, for devices beneath
+ * downstream ports supporting the Data Link Layer Active Reporting
+ * capability, this delay should not be used (see PCI_DL_UP_DELAY).
+ */
+#define PCI_RESET_DELAY		100
+/*
+ * Post-DL_Up (Data Link Layer Active) delay applicable for devices immediately
+ * under a Downstream Port that is capable of reporting Data Link Layer Ready.
+ * Not to be confused with how much time it takes for the link itself to become
+ * active (see pcie_wait_for_link_delay).
+ */
+#define PCI_DL_UP_DELAY		100
+/*
+ * Post-FLR delay
+ * Also applies to legacy devices supporting AF_FLR per Advanced Capabilities
+ * for Conventional PCI ECN, 13 April 2006, updated 27 July 2006)
+ */
+#define PCI_FLR_DELAY		100
+/*
+ * D0/D1/D2->D3hot and D3hot->D0 delay
+ * The specifications do *not* mention overridability of the ->D3hot direction
+ */
+#define PCI_PM_D3HOT_DELAY	10
+/* Post-VF_Enable delay */
+#define PCI_VF_ENABLE_DELAY	100
+/* D0/D1->D2 and D2->D0 delay */
+#define PCI_PM_D2_DELAY		200
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



