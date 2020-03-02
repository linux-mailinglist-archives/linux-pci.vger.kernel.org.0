Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C38176312
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCBSqp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:46:45 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:28549 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgCBSqp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174805; x=1614710805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j4m+zq3gvOi1+9w1LAeWgb10VdG3HMJ9oTkeRMpYQqM=;
  b=XZ83bkh/UiSlgodKJr6iACXYlsvPllf7JHYQCXNunZLvxhGfEQX2X/QP
   Z1tpdzw862NqTEFcDNovAzDlHncD4pUU0PveLXXvC7kqtov1aKIqKj5YE
   bBM4CufEI8f/lFPYduVUQXI10iX0IoTCLJ0RdU+ygbnlaNmaF2/70P1Le
   w=;
IronPort-SDR: QYi+yVJYza5I0nW9OxccCu2TeKpOQTURYlJ1FqvP2FmlJlHIzLBrinx+nPnaWhNW3vzfRQyuL2
 aVCiRk6CwUDg==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="19428575"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 02 Mar 2020 18:46:32 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 4EFE1A36F9;
        Mon,  2 Mar 2020 18:46:30 +0000 (UTC)
Received: from EX13D04EUA002.ant.amazon.com (10.43.165.75) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:46:18 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D04EUA002.ant.amazon.com (10.43.165.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:46:17 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:46:13 +0000
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
Subject: [PATCH v2 15/17] PCI: Refactor polling loop out of pci_dev_wait
Date:   Mon, 2 Mar 2020 19:44:27 +0100
Message-ID: <20200302184429.12880-16-stanspas@amazon.com>
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



