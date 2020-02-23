Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55FE16978B
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2020 13:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgBWMWO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Feb 2020 07:22:14 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:59592 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBWMWO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Feb 2020 07:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582460534; x=1613996534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/5T9tN3oKmZA5iIMakG8TApXvG1ETaZYfCRIH79dVuo=;
  b=pX8BwdUNJctw1P5vpYTrQjhslIRv56QVmjGIPBEu1c8Y1BBA3H7vy3al
   oEwhYSyd1c8KxQofbWypST+36yphgYAlEjcY/MOKoeSFwLIPx7YWohPVa
   p/2I2/ctjpNU/spHP9Qij0/u0uO3Ng6w/MjS9iaaNis9HXA8PQxvAHgGL
   k=;
IronPort-SDR: TI5SQvWH5ze2em/PV0bWW4zmHeGbOk0coTOZET/4fV6wr65b6w4TKf1pSkeQHPf5/pTL4yI89Y
 V73o5SEwKEvw==
X-IronPort-AV: E=Sophos;i="5.70,476,1574121600"; 
   d="scan'208";a="17759520"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 23 Feb 2020 12:22:01 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id A3BF0A1E36;
        Sun, 23 Feb 2020 12:22:00 +0000 (UTC)
Received: from EX13D09EUA001.ant.amazon.com (10.43.165.9) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sun, 23 Feb 2020 12:22:00 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D09EUA001.ant.amazon.com (10.43.165.9) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 23 Feb 2020 12:21:58 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 23 Feb 2020 12:21:57 +0000
From:   Stanislav Spassov <stanspas@amazon.com>
To:     <linux-pci@vger.kernel.org>
CC:     Stanislav Spassov <stanspas@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Wei Wang <wawei@amazon.de>
Subject: [PATCH 2/3] PCI: Introduce per-device reset_ready_poll override
Date:   Sun, 23 Feb 2020 13:20:56 +0100
Message-ID: <20200223122057.6504-3-stanspas@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200223122057.6504-1-stanspas@amazon.com>
References: <20200223122057.6504-1-stanspas@amazon.com>
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
 drivers/pci/pci.c   | 19 ++++++++++++++-----
 drivers/pci/probe.c |  2 ++
 include/linux/pci.h |  1 +
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index db9b58ab6c68..a554818968ed 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1033,8 +1033,17 @@ void pci_wakeup_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_wakeup, NULL);
 }
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
+static int pci_dev_get_reset_ready_poll_ms(struct pci_dev *dev)
 {
+	if (dev->reset_ready_poll_ms >= 0)
+		return dev->reset_ready_poll_ms;
+
+	return pcie_reset_ready_poll_ms;
+}
+
+static int pci_dev_wait(struct pci_dev *dev, char *reset_type)
+{
+	int timeout = pci_dev_get_reset_ready_poll_ms(dev);
 	int delay = 1;
 	u32 id;
 
@@ -4518,7 +4527,7 @@ int pcie_flr(struct pci_dev *dev)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "FLR", pcie_reset_ready_poll_ms);
+	return pci_dev_wait(dev, "FLR");
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -4563,7 +4572,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "AF_FLR", pcie_reset_ready_poll_ms);
+	return pci_dev_wait(dev, "AF_FLR");
 }
 
 /**
@@ -4608,7 +4617,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return pci_dev_wait(dev, "PM D3hot->D0", pcie_reset_ready_poll_ms);
+	return pci_dev_wait(dev, "PM D3hot->D0");
 }
 
 /**
@@ -4838,7 +4847,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
 
-	return pci_dev_wait(dev, "bus reset", pcie_reset_ready_poll_ms);
+	return pci_dev_wait(dev, "bus reset");
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb4312ddd..eeb79a45d504 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2166,6 +2166,8 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	if (!dev)
 		return NULL;
 
+	dev->reset_ready_poll_ms = -1;
+
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a541a9de..049a41b9412b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -468,6 +468,7 @@ struct pci_dev {
 	size_t		romlen;		/* Length if not from BAR */
 	char		*driver_override; /* Driver name to force a match */
 
+	int		reset_ready_poll_ms;
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
 };
 
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



