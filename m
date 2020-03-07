Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8498617CF64
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 18:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgCGRV0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Mar 2020 12:21:26 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:57793 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCGRVZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Mar 2020 12:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583601685; x=1615137685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HwpeeEBSuhzWpYTsEXe5OdgJRbOFyg3rXVY6QJ+/f1k=;
  b=SRO8NdflkqhmHcHP4dctI4GBuhdpTPXzAojp4DSoVn+4emK2mN9KGxLj
   Uv4S7T09SfSx8NpmIPi6W/tD2hpaYAid7pgM9W5kRPSU0lQSJIrZQeNJd
   xnRzJQghkRLbn7w3WflMaELd9SNaPS7Lz2rn/wMOTm0PQpTTvEPAGN/VF
   k=;
IronPort-SDR: wMduy1ZCjnBvKGNYu5p/CFPI+IVJYmmp2HoOh4iXPZkY1B4JjqsWRBPh2QjbYC8zOqTBORfq4u
 G8mjLKIZoRQw==
X-IronPort-AV: E=Sophos;i="5.70,526,1574121600"; 
   d="scan'208";a="20226469"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 07 Mar 2020 17:21:13 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id DC2BBA281B;
        Sat,  7 Mar 2020 17:21:09 +0000 (UTC)
Received: from EX13D04EUA002.ant.amazon.com (10.43.165.75) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sat, 7 Mar 2020 17:21:09 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D04EUA002.ant.amazon.com (10.43.165.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 7 Mar 2020 17:21:08 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 7 Mar 2020 17:21:05 +0000
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
Subject: [PATCH v4 1/3] PCI: Refactor polling loop out of pci_dev_wait
Date:   Sat, 7 Mar 2020 18:20:42 +0100
Message-ID: <20200307172044.29645-2-stanspas@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200307172044.29645-1-stanspas@amazon.com>
References: <20200307172044.29645-1-stanspas@amazon.com>
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
 drivers/pci/pci.c | 70 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d828ca835a98..44f5d4907db6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1021,47 +1021,75 @@ void pci_wakeup_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_wakeup, NULL);
 }
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
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
-				 delay - 1, reset_type);
+				 delay - 1, event_name);
 			return -ENOTTY;
 		}
 
 		if (delay > 1000)
 			pci_info(dev, "not ready %dms after %s; waiting\n",
-				 delay - 1, reset_type);
+				 delay - 1, event_name);
 
 		msleep(delay);
 		delay *= 2;
-		pci_read_config_dword(dev, PCI_COMMAND, &id);
+
+		pci_read_config_dword(dev, where, &value);
 	}
 
 	if (delay > 1000)
-		pci_info(dev, "ready %dms after %s\n", delay - 1,
-			 reset_type);
+		pci_info(dev, "ready %dms after %s\n", delay - 1, event_name);
+
+	if (waited)
+		*waited = delay - 1;
+
+	if (final_value)
+		*final_value = value;
 
 	return 0;
 }
 
+static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
+{
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
+					    reset_type, timeout, NULL,
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



