Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3E917630F
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCBSqc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:46:32 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:29635 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgCBSqc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174791; x=1614710791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JNPVRg0IXhKYsKVgVhd2+6miS3vS/5AexheE4GJwtE0=;
  b=CFvShSpUB6L2Vzn9WCH0wcg+AWdySCvbd1NjIW8bSkW7Olxn+08MyWtE
   d8tbi5CBw3nZPLK2JTvAQ4fadg7yKPSvDNYcw0muEUGz4cVNOrdO95VHt
   O4/7YxgbUDWzTDIrFJN4ZtLnAF+Amc4JEZrxH1mLJZQfsSkUc06LSlfK0
   M=;
IronPort-SDR: gmPq8usxjQZUxBcpQlmHbvtrPA4MqGtxcnJb/0gk8XT+ptiT2oj8HqgeIjiNx6hKu5glDVGdDG
 9TEjHhJ6vlqw==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="19686304"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 02 Mar 2020 18:46:15 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 6EB81A1ECE;
        Mon,  2 Mar 2020 18:46:14 +0000 (UTC)
Received: from EX13D12EUC002.ant.amazon.com (10.43.164.134) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:46:01 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D12EUC002.ant.amazon.com (10.43.164.134) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:46:00 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:45:56 +0000
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
Subject: [PATCH v2 11/17] PCI: Refactor pci_dev_wait to remove timeout parameter
Date:   Mon, 2 Mar 2020 19:44:23 +0100
Message-ID: <20200302184429.12880-12-stanspas@amazon.com>
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

Currently, all callers supply the same value, and in the future
pci_dev_wait itself could determine the appropriate timeout based on
values stored in struct pci_dev, and the reset type.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7e08c5f38190..9435e2b19f7b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1030,8 +1030,9 @@ void pci_wakeup_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_wakeup, NULL);
 }
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
+static int pci_dev_wait(struct pci_dev *dev, char *reset_type)
 {
+	int timeout = PCIE_RESET_READY_POLL_MS;
 	int delay = 1;
 	u32 id;
 
@@ -4514,7 +4515,7 @@ int pcie_flr(struct pci_dev *dev)
 
 	msleep(dev->delay[PCI_INIT_EVENT_FLR]);
 
-	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "FLR");
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -4553,7 +4554,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 
 	msleep(dev->delay[PCI_INIT_EVENT_FLR]);
 
-	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "AF_FLR");
 }
 
 /**
@@ -4600,7 +4601,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "PM D3hot->D0");
 }
 
 /**
@@ -4842,7 +4843,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
 
-	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "bus reset");
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



