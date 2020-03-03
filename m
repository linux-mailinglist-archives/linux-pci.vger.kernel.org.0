Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1FC177719
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgCCNa4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:30:56 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:61783 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbgCCNa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583242256; x=1614778256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JNPVRg0IXhKYsKVgVhd2+6miS3vS/5AexheE4GJwtE0=;
  b=vLyGIpi8Q3XL5TKo2lSMWpfDwb5ZYBf4vX2NsDVAjs2U9/CNISyxf4o9
   GI8aHnZD95/jtCi/b7Ch8FlomXfZcRv33mGVmZiUxvksAiPZPNHfaHeu4
   3nFYa1ooQjsmHYAbH1R4BIpQOppYNB/IwRlPO0aqflFI3oojTEOBUGz4U
   g=;
IronPort-SDR: jVg/e8oI4DlucrkV6r/lIpmtz56apX5RpLNM1aN8MgrRlvxPI1rCcCA/GZy6pyMkW/AlaA27pO
 sZuNxmc698gA==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="30249779"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 03 Mar 2020 13:30:55 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id 39E60A2E10;
        Tue,  3 Mar 2020 13:30:54 +0000 (UTC)
Received: from EX13D12EUC001.ant.amazon.com (10.43.164.45) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 13:30:27 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D12EUC001.ant.amazon.com (10.43.164.45) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Mar 2020 13:30:25 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Mar 2020 13:30:23 +0000
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
Subject: [PATCH v3 11/17] PCI: Refactor pci_dev_wait to remove timeout parameter
Date:   Tue, 3 Mar 2020 14:28:46 +0100
Message-ID: <20200303132852.13184-12-stanspas@amazon.com>
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



