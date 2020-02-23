Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34FAD169789
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2020 13:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgBWMWH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Feb 2020 07:22:07 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:1449 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgBWMWH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Feb 2020 07:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582460527; x=1613996527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lcnFscn91LfowQE1gEh7+eQLC7A7aDyLt4mHbYDGrHA=;
  b=O+aizZUKCk2eEzQvzG5zk5oscFFqeifYNncIfWVpfGipu8gvDABCxbM3
   rwwUj/xdYplE0EyAEmdkIpQua/aSfx4sqdJ1SnVVo5Q/MAWaffQzSccFx
   L4Y+KwZ5EH5iCS+gGLwJ+0W5h+xCrnSYIFsoHVcyLQsCg2Nd9t4Pql/qI
   4=;
IronPort-SDR: TFIxAe00BbZavzHlPTEmqgSi2DF904VMgNoZ2FtfNhN1GWI//hLEJJBGYdSFBnFskiLYt8LpHW
 svwjO7/zbhAQ==
X-IronPort-AV: E=Sophos;i="5.70,476,1574121600"; 
   d="scan'208";a="18479465"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 23 Feb 2020 12:21:54 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id CBA09A1BEC;
        Sun, 23 Feb 2020 12:21:52 +0000 (UTC)
Received: from EX13D12EUC002.ant.amazon.com (10.43.164.134) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sun, 23 Feb 2020 12:21:52 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D12EUC002.ant.amazon.com (10.43.164.134) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 23 Feb 2020 12:21:51 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 23 Feb 2020 12:21:49 +0000
From:   Stanislav Spassov <stanspas@amazon.com>
To:     <linux-pci@vger.kernel.org>
CC:     Stanislav Spassov <stanspas@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Wei Wang <wawei@amazon.de>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 1/3] PCI: Make PCIE_RESET_READY_POLL_MS configurable
Date:   Sun, 23 Feb 2020 13:20:55 +0100
Message-ID: <20200223122057.6504-2-stanspas@amazon.com>
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

From: Wei Wang <wawei@amazon.de>

The resonable value for the maximum time to wait for a PCI device to be
ready after reset varies depending on the platform and the reliability
of its set of devices.

Signed-off-by: Wei Wang <wawei@amazon.de>
Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++++
 drivers/pci/pci.c                             | 22 ++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dbc22d684627..5e4dade9acc8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3653,6 +3653,11 @@
 		nomsi	Do not use MSI for native PCIe PME signaling (this makes
 			all PCIe root ports use INTx for all services).
 
+	pcie_reset_ready_poll_ms= [PCI,PCIE]
+			Specifies timeout for PCI(e) device readiness polling
+			after device reset (in milliseconds).
+			Default: 60000 = 60 seconds
+
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
 	pd_ignore_unused
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d828ca835a98..db9b58ab6c68 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -149,7 +149,19 @@ static int __init pcie_port_pm_setup(char *str)
 __setup("pcie_port_pm=", pcie_port_pm_setup);
 
 /* Time to wait after a reset for device to become responsive */
-#define PCIE_RESET_READY_POLL_MS 60000
+#define PCIE_RESET_READY_POLL_MS_DEFAULT 60000
+
+int __read_mostly pcie_reset_ready_poll_ms = PCIE_RESET_READY_POLL_MS_DEFAULT;
+
+static int __init pcie_reset_ready_poll_ms_setup(char *str)
+{
+	int timeout;
+
+	if (!kstrtoint(str, 0, &timeout))
+		pcie_reset_ready_poll_ms = timeout;
+	return 1;
+}
+__setup("pcie_reset_ready_poll_ms=", pcie_reset_ready_poll_ms_setup);
 
 /**
  * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
@@ -4506,7 +4518,7 @@ int pcie_flr(struct pci_dev *dev)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "FLR", pcie_reset_ready_poll_ms);
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -4551,7 +4563,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "AF_FLR", pcie_reset_ready_poll_ms);
 }
 
 /**
@@ -4596,7 +4608,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "PM D3hot->D0", pcie_reset_ready_poll_ms);
 }
 
 /**
@@ -4826,7 +4838,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
 
-	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "bus reset", pcie_reset_ready_poll_ms);
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



