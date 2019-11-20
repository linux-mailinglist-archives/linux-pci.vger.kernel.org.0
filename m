Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9FB81033A3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 06:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfKTFRw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 00:17:52 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8357 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfKTFRw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 00:17:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd4cc820000>; Tue, 19 Nov 2019 21:17:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 Nov 2019 21:17:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 Nov 2019 21:17:51 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Nov
 2019 05:17:51 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Nov
 2019 05:17:50 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 20 Nov 2019 05:17:50 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd4cc7a0003>; Tue, 19 Nov 2019 21:17:49 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <rjw@rjwysocki.net>, <okaya@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 1/2] PCI: Move the definition of pci_dev_wait()
Date:   Wed, 20 Nov 2019 10:47:42 +0530
Message-ID: <20191120051743.23124-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118172310.21373-1-vidyas@nvidia.com>
References: <20191118172310.21373-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574227074; bh=b6q8dQLvbvfzSyLQrEbGr/padE6lF7nxbuX1hwZDhdw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Oq+4VMm/11a2LYHu+IcbdpKGvFRyIriE79RKBjsSoVJVD7T+lVwEhySsMdrI5JAu/
         63pUBmbTQZuKov+vfAOOyrWAWrreMbfp8dATnxbc9N3o7dBdfQPN9T1HxDXrW2tILw
         GWtde0wGFcNwaGOsFqs+BRnIuZ05bxFyRa1k0I7uHZ3WJpjwS0JpBQqaSF5od/z/Ik
         nOjszBibbmAtp77fOIyvAYlHmDD7263lkjwsfpbXdihUMogHMKsMHwjxe24m8eZds6
         vO/Xf4l72iVomQrUBiBEw1zo/K/xoqVna7MV76B3nXBv7OF2ynzE1h2wAtBjZEfaZ2
         kAF/V/0ViYFqA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the definition of pci_dev_wait() above pci_power_up() so that it
can be called from the latter with no change in functionality.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.c | 82 +++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 599b2fc99234..71b45ce73bf6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1020,6 +1020,47 @@ void pci_wakeup_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_wakeup, NULL);
 }
 
+static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
+{
+	int delay = 1;
+	u32 id;
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
+	pci_read_config_dword(dev, PCI_COMMAND, &id);
+	while (id == ~0) {
+		if (delay > timeout) {
+			pci_warn(dev, "not ready %dms after %s; giving up\n",
+				 delay - 1, reset_type);
+			return -ENOTTY;
+		}
+
+		if (delay > 1000)
+			pci_info(dev, "not ready %dms after %s; waiting\n",
+				 delay - 1, reset_type);
+
+		msleep(delay);
+		delay *= 2;
+		pci_read_config_dword(dev, PCI_COMMAND, &id);
+	}
+
+	if (delay > 1000)
+		pci_info(dev, "ready %dms after %s\n", delay - 1,
+			 reset_type);
+
+	return 0;
+}
+
 /**
  * pci_power_up - Put the given device into D0
  * @dev: PCI device to power up
@@ -4420,47 +4461,6 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
-{
-	int delay = 1;
-	u32 id;
-
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
-		if (delay > timeout) {
-			pci_warn(dev, "not ready %dms after %s; giving up\n",
-				 delay - 1, reset_type);
-			return -ENOTTY;
-		}
-
-		if (delay > 1000)
-			pci_info(dev, "not ready %dms after %s; waiting\n",
-				 delay - 1, reset_type);
-
-		msleep(delay);
-		delay *= 2;
-		pci_read_config_dword(dev, PCI_COMMAND, &id);
-	}
-
-	if (delay > 1000)
-		pci_info(dev, "ready %dms after %s\n", delay - 1,
-			 reset_type);
-
-	return 0;
-}
-
 /**
  * pcie_has_flr - check if a device supports function level resets
  * @dev: device to check
-- 
2.17.1

