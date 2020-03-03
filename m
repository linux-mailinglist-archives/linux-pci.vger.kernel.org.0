Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB4F17771D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgCCNbF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:31:05 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:31533 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbgCCNbF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583242264; x=1614778264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=boi/zS9lyKDU1FKDZKAWPh9nzOZgJ/80+f/6R2sG+NE=;
  b=P2FGXDZED0ac5+03mV3JTTGOiucIaekkaCQVxJblm7ZLRw1GKR8vFQq9
   rfdLWDImAG6cChUEqqM8pqlGKYpF8XPDfM9nN5nZx8pe10eoJXqxsZJIv
   +SuCue7ehkrdaHfJk6es99jUqtBvzBc0CGIffh7OEIs1tMax4D0u6zeoE
   0=;
IronPort-SDR: jrV2DrcuNPLZWeYiENljQ7/td2WFpkEfdAeSmx0K6UisKqnzFBQSVTx2luIYTaoMqWMiYw5rwl
 HfrSh1IV1zmA==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="20496345"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Mar 2020 13:30:57 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id B58C3A18F5;
        Tue,  3 Mar 2020 13:30:55 +0000 (UTC)
Received: from EX13D04EUB004.ant.amazon.com (10.43.166.59) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 13:30:29 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D04EUB004.ant.amazon.com (10.43.166.59) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Mar 2020 13:30:28 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Mar 2020 13:30:25 +0000
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
Subject: [PATCH v3 12/17] PCI: Refactor pci_dev_wait to take pci_init_event
Date:   Tue, 3 Mar 2020 14:28:47 +0100
Message-ID: <20200303132852.13184-13-stanspas@amazon.com>
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

Knowing what kind of event knocked the device out could be useful not
only for log output, but also to use different timeout/waiting behavior.

Note: we do lose some specificity in log output due to the aliasing of
FLR and AF_FLR, but it is doubtful the distinction is worthwhile.

Also, "bus reset" does not exactly match the more generic name for
PCI_INIT_EVENT_RESET, which could break programs that scrape kernel
output for overly specific patterns.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9435e2b19f7b..5d62d4841d68 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1030,8 +1030,9 @@ void pci_wakeup_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_wakeup, NULL);
 }
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type)
+static int pci_dev_wait(struct pci_dev *dev, enum pci_init_event event)
 {
+	const char *event_name = pci_init_event_name(event);
 	int timeout = PCIE_RESET_READY_POLL_MS;
 	int delay = 1;
 	u32 id;
@@ -1052,13 +1053,13 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type)
 	while (id == ~0) {
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
-				 delay - 1, reset_type);
+				 delay - 1, event_name);
 			return -ETIMEDOUT;
 		}
 
 		if (delay > 1000)
 			pci_info(dev, "not ready %dms after %s; waiting\n",
-				 delay - 1, reset_type);
+				 delay - 1, event_name);
 
 		msleep(delay);
 		delay *= 2;
@@ -1067,7 +1068,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type)
 
 	if (delay > 1000)
 		pci_info(dev, "ready %dms after %s\n", delay - 1,
-			 reset_type);
+			 event_name);
 
 	return 0;
 }
@@ -4515,7 +4516,7 @@ int pcie_flr(struct pci_dev *dev)
 
 	msleep(dev->delay[PCI_INIT_EVENT_FLR]);
 
-	return pci_dev_wait(dev, "FLR");
+	return pci_dev_wait(dev, PCI_INIT_EVENT_FLR);
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -4554,7 +4555,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 
 	msleep(dev->delay[PCI_INIT_EVENT_FLR]);
 
-	return pci_dev_wait(dev, "AF_FLR");
+	return pci_dev_wait(dev, PCI_INIT_EVENT_FLR);
 }
 
 /**
@@ -4601,7 +4602,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return pci_dev_wait(dev, "PM D3hot->D0");
+	return pci_dev_wait(dev, PCI_INIT_EVENT_D3HOT_TO_D0);
 }
 
 /**
@@ -4843,7 +4844,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
 
-	return pci_dev_wait(dev, "bus reset");
+	return pci_dev_wait(dev, PCI_INIT_EVENT_RESET);
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



