Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E57A7177710
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgCCNat (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:30:49 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:31467 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgCCNat (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583242248; x=1614778248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m9UC6YMrCEkdQKApcmjI1lOwtfkDHyrdWMSJSbIlTXI=;
  b=CP9ng6IPINxn/+NRTGoRXKs8x0N5sGvks0jZF8wIkPna8SHjnoX4qSVj
   GG1MyIkcvSDIduwJwrxdOP3Pwhi2bZLECeprvKFMNZW3rilE/vTACmLYG
   0XyZ9v5odiCSK3q409lK5FQakFkDKOj24a7mazqWf5UkoxgO24NQzf/df
   s=;
IronPort-SDR: VT0rCqnUvfwE/Cq6jTl9TgJjfOlKwfQKuSOQX1Fyv/VI5ahEKIBJDbjAYbD7CcZWUbyYVjBvJE
 euQGgxZlUsFQ==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="20496287"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Mar 2020 13:30:47 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 63879A2F96;
        Tue,  3 Mar 2020 13:30:45 +0000 (UTC)
Received: from EX13D12EUC004.ant.amazon.com (10.43.164.129) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 13:30:16 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D12EUC004.ant.amazon.com (10.43.164.129) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Mar 2020 13:30:13 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Mar 2020 13:30:09 +0000
From:   Stanislav Spassov <stanspas@amazon.com>
To:     <linux-pci@vger.kernel.org>
CC:     Stanislav Spassov <stanspas@amazon.de>,
        <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>, Rajat Jain <rajatja@google.com>,
        kbuild test robot <lkp@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v3 07/17] PCI: Clean up and document PM/reset delays
Date:   Tue, 3 Mar 2020 14:28:42 +0100
Message-ID: <20200303132852.13184-8-stanspas@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303132852.13184-1-stanspas@amazon.com>
References: <20200303132852.13184-1-stanspas@amazon.com>
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
 drivers/pci/controller/pci-aardvark.c |  2 +-
 drivers/pci/controller/pci-mvebu.c    |  2 +-
 drivers/pci/iov.c                     |  4 +-
 drivers/pci/pci-acpi.c                |  4 +-
 drivers/pci/pci.c                     | 21 ++------
 drivers/pci/pci.h                     | 72 +++++++++++++++++++++++++--
 6 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 2a20b649f40c..2ece24abf751 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -344,7 +344,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	 * fundamental reset. As required by PCI Express spec a delay for at
 	 * least 100ms after such a reset before link training is needed.
 	 */
-	msleep(PCI_PM_D3COLD_WAIT);
+	msleep(PCI_RESET_DELAY);
 
 	/* Start link training */
 	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 153a64676bc9..c1cd1b7cf7ee 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -927,7 +927,7 @@ static int mvebu_pcie_powerup(struct mvebu_pcie_port *port)
 		return ret;
 
 	if (port->reset_gpio) {
-		u32 reset_udelay = PCI_PM_D3COLD_WAIT * 1000;
+		u32 reset_udelay = PCI_RESET_DELAY * 1000;
 
 		of_property_read_u32(port->dn, "reset-delay-us",
 				     &reset_udelay);
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
index b147b61c6668..0ece144ac9c5 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1242,7 +1242,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 			value = (int)value_us / 1000;
 			if ((int)value_us % 1000 > 0)
 				value++;
-			if (value < PCI_PM_D3COLD_WAIT)
+			if (value < PCI_RESET_DELAY)
 				pdev->d3cold_delay = value;
 		}
 		if (elements[3].type == ACPI_TYPE_INTEGER) {
@@ -1250,7 +1250,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 			value = (int)value_us / 1000;
 			if ((int)value_us % 1000 > 0)
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



