Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500DC177721
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgCCNbH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:31:07 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:31561 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbgCCNbG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583242266; x=1614778266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j4m+zq3gvOi1+9w1LAeWgb10VdG3HMJ9oTkeRMpYQqM=;
  b=Zd7OCKNgGyFMB7kRyrlfKSZfVSZAsEInkHgsYUgCpo62tYZj6o0q/XzJ
   mlJFG9AyyL7yD78I4W6J09za5WAogQbmZbWJAieVYXC8UGVwfB7mzYqDp
   mrwwGZt81VI59opay6ETaSyrYepEe/fkbjGpKqmnR1CEoHQqSgFPT2SH5
   E=;
IronPort-SDR: Dc1bk1pyjzKQGu6X0PdY6Fk7iS1GxR3Pu664xP/NBSQFYBZjfN9oJx2FfeMV0EgRZL0SFn6HHr
 Wt+WE3UiseYw==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="20496357"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Mar 2020 13:31:01 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id EAAAAA18EA;
        Tue,  3 Mar 2020 13:30:59 +0000 (UTC)
Received: from EX13D12EUC001.ant.amazon.com (10.43.164.45) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 13:30:37 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D12EUC001.ant.amazon.com (10.43.164.45) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Mar 2020 13:30:35 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Mar 2020 13:30:33 +0000
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
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v3 15/17] PCI: Refactor polling loop out of pci_dev_wait
Date:   Tue, 3 Mar 2020 14:28:50 +0100
Message-ID: <20200303132852.13184-16-stanspas@amazon.com>
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

This patch does not (intentionally) introduce any observable difference
in runtime behavior.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci.c | 71 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e81fd3b53bd0..f1ba931b0ead 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1027,27 +1027,28 @@ void pci_wakeup_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_wakeup, NULL);
 }
 
-static int pci_dev_wait(struct pci_dev *dev, enum pci_init_event event)
+/*
+ * Performs DWORD Configuration Reads at a specific offset until the value read
+ * (with mask applied) is not equal to bad_value.
+ */
+static inline int pci_dev_poll_until_not_equal(struct pci_dev *dev, int where,
+					       u32 mask, u32 bad_value,
+					       const char *event_name,
+					       int timeout, int *waited,
+					       u32 *final_value)
 {
-	const char *event_name = pci_init_event_name(event);
-	int timeout = dev->reset_ready_poll_ms;
 	int delay = 1;
-	u32 id;
+	u32 value;
 
-	/*
-	 * After reset, the device should not silently discard config
-	 * requests, but it may still indicate that it needs more time by
-	 * responding to them with CRS completions.  The Root Port will
-	 * generally synthesize ~0 data to complete the read (except when
-	 * CRS SV is enabled and the read was for the Vendor ID; in that
-	 * case it synthesizes 0x0001 data).
-	 *
-	 * Wait for the device to return a non-CRS completion.  Read the
-	 * Command register instead of Vendor ID so we don't have to
-	 * contend with the CRS SV value.
-	 */
-	pci_read_config_dword(dev, PCI_COMMAND, &id);
-	while (id == ~0) {
+	if (!event_name)
+		event_name = "<unknown event>";
+
+	if (waited)
+		delay = *waited + 1;
+
+	pci_read_config_dword(dev, where, &value);
+
+	while ((value & mask) == bad_value) {
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
 				 delay - 1, event_name);
@@ -1060,16 +1061,44 @@ static int pci_dev_wait(struct pci_dev *dev, enum pci_init_event event)
 
 		msleep(delay);
 		delay *= 2;
-		pci_read_config_dword(dev, PCI_COMMAND, &id);
+
+		pci_read_config_dword(dev, where, &value);
 	}
 
 	if (delay > 1000)
-		pci_info(dev, "ready %dms after %s\n", delay - 1,
-			 event_name);
+		pci_info(dev, "ready %dms after %s\n", delay - 1, event_name);
+
+	if (waited)
+		*waited = delay - 1;
+
+	if (final_value)
+		*final_value = value;
 
 	return 0;
 }
 
+static int pci_dev_wait(struct pci_dev *dev, enum pci_init_event event)
+{
+	const char *event_name = pci_init_event_name(event);
+	int timeout = dev->reset_ready_poll_ms;
+
+	/*
+	 * After reset, the device should not silently discard config
+	 * requests, but it may still indicate that it needs more time by
+	 * responding to them with CRS completions.  The Root Port will
+	 * generally synthesize ~0 data to complete the read (except when
+	 * CRS SV is enabled and the read was for the Vendor ID; in that
+	 * case it synthesizes 0x0001 data).
+	 *
+	 * Wait for the device to return a non-CRS completion.  Read the
+	 * Command register instead of Vendor ID so we don't have to
+	 * contend with the CRS SV value.
+	 */
+	return pci_dev_poll_until_not_equal(dev, PCI_COMMAND, ~0, ~0,
+					    event_name, timeout, NULL,
+					    NULL);
+}
+
 /**
  * pci_power_up - Put the given device into D0
  * @dev: PCI device to power up
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



