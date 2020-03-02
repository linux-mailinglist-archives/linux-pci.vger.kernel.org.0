Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 259DA17630A
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgCBSqW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:46:22 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:52790 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBSqV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174781; x=1614710781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=boi/zS9lyKDU1FKDZKAWPh9nzOZgJ/80+f/6R2sG+NE=;
  b=UHQDXTTGR2HVCCG+SEAVqlFlL41TZssT6vt7ifvmKYUafAB4HIM16LSJ
   R21HHYnMZbXXclFpwUUo92pGDeTxN/kfqJyoNj4+Y/aSM8RxYBhZT1dc4
   YjEYCGhCuxUq6zpQL0Bhf2g9L7F4pATE7Ob2XO7AUBZtSok7Mju6/VNHN
   g=;
IronPort-SDR: fos/NqpK5c3g5RO2Kjrji5filQUsg2iLwvOVjiYcfYnbG4a/tcCqkK6p/wLYSGRvnoSqK22Hbo
 X3n7rNsQAwYA==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="28691747"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 02 Mar 2020 18:46:20 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 0AA16A18ED;
        Mon,  2 Mar 2020 18:46:18 +0000 (UTC)
Received: from EX13D04EUA003.ant.amazon.com (10.43.165.148) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:46:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D04EUA003.ant.amazon.com (10.43.165.148) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:46:04 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:46:00 +0000
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
Subject: [PATCH v2 12/17] PCI: Refactor pci_dev_wait to take pci_init_event
Date:   Mon, 2 Mar 2020 19:44:24 +0100
Message-ID: <20200302184429.12880-13-stanspas@amazon.com>
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



