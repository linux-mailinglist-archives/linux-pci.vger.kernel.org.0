Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC17176308
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCBSqP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:46:15 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:56169 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBSqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174774; x=1614710774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f1H7XOSMeRzetd59oqKV+/fQ2SI/DghKGu3MCc/evPI=;
  b=SeVtVykV3Se9bO7q9/pPOpSrUiVjXXVN15Aqa8tkSXagcE8/frsWKwrQ
   RVLv/WQQBZKJYFw7v5uO8z4oRbggCWuVA5ELdk4uGya6+kwhf7cwZMT1t
   blhRgH829pQFb2E+MGBI7Fo2z5Hm9Q0sdpGuXrjvdIPLmoQ11H56sO1fm
   s=;
IronPort-SDR: OvBufc5a0yvD6kkq3CEIV1a6yG1A8jMz8YtYtEmb7c7x3pfoUTdi73owiBfMlN3EN/emwADcu7
 KrUq0V3tmtKQ==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="19142063"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 02 Mar 2020 18:46:12 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 470E6A2279;
        Mon,  2 Mar 2020 18:46:11 +0000 (UTC)
Received: from EX13D12EUC001.ant.amazon.com (10.43.164.45) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:45:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D12EUC001.ant.amazon.com (10.43.164.45) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:45:51 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:45:48 +0000
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
Subject: [PATCH v2 09/17] PCI: Generalize pci_bus_max_d3cold_delay to pci_bus_max_delay
Date:   Mon, 2 Mar 2020 19:44:21 +0100
Message-ID: <20200302184429.12880-10-stanspas@amazon.com>
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

This allows determining the maximum of any of the several delay values
stored in struct pci_dev.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ba54164652cc..e4840dbf2d1c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4669,21 +4669,26 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
 }
 
 /*
- * Find maximum D3cold delay required by all the devices on the bus.  The
- * spec says 100 ms, but firmware can lower it and we allow drivers to
- * increase it as well.
+ * Find maximum delay required by all the devices on the bus after the
+ * given initialization event.
  *
  * Called with @pci_bus_sem locked for reading.
+ *
+ * XXX: It is not clear if this should descend down across bridges (if any)
  */
-static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
+static int pci_bus_max_delay(const struct pci_bus *bus,
+			     enum pci_init_event event, int default_delay)
 {
 	const struct pci_dev *pdev;
-	int min_delay = 100;
+	int min_delay = default_delay;
 	int max_delay = 0;
 	int delay;
 
+	if (event >= PCI_INIT_EVENT_COUNT)
+		return default_delay;
+
 	list_for_each_entry(pdev, &bus->devices, bus_list) {
-		delay = pdev->delay[PCI_INIT_EVENT_RESET];
+		delay = pdev->delay[event];
 		if (delay < min_delay)
 			min_delay = delay;
 		if (delay > max_delay)
@@ -4728,11 +4733,13 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, bool sx_resume)
 		return;
 	}
 
-	/* Take d3cold_delay requirements into account */
+	/* Take delay requirements into account */
 	if (sx_resume && dev->ignore_reset_delay_on_sx_resume)
 		delay = 0;
 	else
-		delay = pci_bus_max_d3cold_delay(dev->subordinate);
+		delay = pci_bus_max_delay(dev->subordinate,
+					  PCI_INIT_EVENT_RESET,
+					  PCI_RESET_DELAY);
 
 	if (!delay) {
 		up_read(&pci_bus_sem);
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



