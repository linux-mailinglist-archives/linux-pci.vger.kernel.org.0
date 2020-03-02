Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B39D17630C
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgCBSq3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:46:29 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:60001 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgCBSq3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174789; x=1614710789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KTszniR1B8GtjTWJyYnBLjmuCmS7g4iBL/oem8tvWpM=;
  b=R7Xhc8a0BVfVrJgcIwPCUMdXkuCnN6IOZLiT7nYHDoYXT/AcTFbeX5Mw
   KCBd0TAy5q7/rwYcbMeRjqTCYJoQuuo7AhVggN/cmHy4KDwq8npjsDEY6
   vMbDDB9g1Rgl+SPf+6cBtT1YoWDHXtuuoPIZ392TPaDjvwGFRp65CgoOI
   Y=;
IronPort-SDR: CsBh9RpLxJSDTeJxmQhYUyM9m+zUrLKDcODM49vr0zRg2/Sl1rpsHprDpARYMM/1BCn34wRz93
 +HKsndJKn+0w==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="20320689"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 02 Mar 2020 18:46:29 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 66B9FA22E6;
        Mon,  2 Mar 2020 18:46:27 +0000 (UTC)
Received: from EX13D04EUA001.ant.amazon.com (10.43.165.136) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:46:14 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D04EUA001.ant.amazon.com (10.43.165.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:46:13 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:46:09 +0000
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
Subject: [PATCH v2 14/17] PCI: Introduce per-device reset_ready_poll override
Date:   Mon, 2 Mar 2020 19:44:26 +0100
Message-ID: <20200302184429.12880-15-stanspas@amazon.com>
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

A broken device may never become responsive after reset, hence the need
for a timeout. However, waiting for too long can have unintended side
effects such as triggering hung task timeouts for processes waiting on
a lock held during the reset. Locks that are shared across multiple
devices, such as VFIO's per-bus reflck, are especially problematic,
because a single broken VF can cause hangs for processes working with
other VFs on the same bus.

To allow lowering the global default post-reset timeout, while still
accommodating devices that require more time, this patch introduces
a per-device override that can be configured via a quirk.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci.c   | 5 +----
 drivers/pci/pci.h   | 3 +++
 drivers/pci/probe.c | 2 ++
 include/linux/pci.h | 3 +++
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5d62d4841d68..e81fd3b53bd0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -157,9 +157,6 @@ static int __init pcie_port_pm_setup(char *str)
 }
 __setup("pcie_port_pm=", pcie_port_pm_setup);
 
-/* Time to wait after a reset for device to become responsive */
-#define PCIE_RESET_READY_POLL_MS 60000
-
 /**
  * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
  * @bus: pointer to PCI bus structure to search
@@ -1033,7 +1030,7 @@ void pci_wakeup_bus(struct pci_bus *bus)
 static int pci_dev_wait(struct pci_dev *dev, enum pci_init_event event)
 {
 	const char *event_name = pci_init_event_name(event);
-	int timeout = PCIE_RESET_READY_POLL_MS;
+	int timeout = dev->reset_ready_poll_ms;
 	int delay = 1;
 	u32 id;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9b5dd6ea2f52..d8043d4dbe2f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -113,6 +113,9 @@ int pci_bus_error_reset(struct pci_dev *dev);
 /* D0/D1->D2 and D2->D0 delay */
 #define PCI_PM_D2_DELAY		200
 
+/* Time to wait after a reset for device to become responsive */
+#define PCIE_RESET_READY_POLL_MS 60000
+
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
  *
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index eeff8a07f330..50b7219406ed 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2168,6 +2168,8 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	if (!dev)
 		return NULL;
 
+	dev->reset_ready_poll_ms = PCIE_RESET_READY_POLL_MS;
+
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1763e98625b9..978ede89741e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -392,6 +392,9 @@ struct pci_dev {
 	unsigned int    delay[PCI_INIT_EVENT_COUNT]; /* minimum waiting time
 							after various events
 							in ms */
+	unsigned int	reset_ready_poll_ms;	/* Timeout for polling after
+						   reset before the device is
+						   deemed broken. */
 
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state */
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



