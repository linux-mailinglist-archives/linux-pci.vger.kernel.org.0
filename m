Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D85100A27
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 18:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfKRRXS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 12:23:18 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19132 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfKRRXS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 12:23:18 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd2d3870000>; Mon, 18 Nov 2019 09:23:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 09:23:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Nov 2019 09:23:16 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Nov
 2019 17:23:16 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 18 Nov 2019 17:23:16 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd2d3800001>; Mon, 18 Nov 2019 09:23:15 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <rjw@rjwysocki.net>, <okaya@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH] PCI: Introduce pci_dev_wait() in pci_power_up() API
Date:   Mon, 18 Nov 2019 22:53:10 +0530
Message-ID: <20191118172310.21373-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574097799; bh=ihVUQNLjAssKv4H0szqfWuePCcLyIfiH0WLfc8zuPF0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=ec/zw4B96PqTRoIxhe6UjyI64N+kMv5g1uPV2Em/24ri1HxT4DDrvSJCdm3qpuWiv
         nPEIz3E9RJne7IBZQv4aXYzeco4Y7rYlqluvXC4zFjUdsfOY+WQdmFDzilBtJJ+Kqg
         aM7OYTk3jJ4JaS0Jv0gufE/ltxoLfXXPPT6Y25tkNg1xz3bRTRJbqdlhz1KFtLLqL5
         v/wnA5u0nXnfc5IhWs/eLRgvrrV1N4M9fOQd8UuT2UHp+PVWBXGnSdAF85dDngQstu
         nt397Ad90/jzE2avvZZHUMhhAfsbgA6d4N+qqzEeA8X4AqoiOGJrMzkrYMfbg/Ry2t
         kr2NVdPlZ6tdw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pci_dev_wait() in pci_power_up() before accessing the configuration
space of a device for the first time in the system resume sequence.
This is  to accommodate devices (Ex:- Intel 750 NVMe) that respond with CRS
status while they get ready for configuration space access and before they
finally start responding with proper values. It also refactors code to move
pci_dev_wait() ahead of pci_power_up() to avoid build error.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.c | 89 +++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 599b2fc99234..7672b9a44bac 100644
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
@@ -1045,6 +1086,13 @@ int pci_power_up(struct pci_dev *dev)
 		pci_wakeup_bus(dev->subordinate);
 	}
 
+	/*
+	 * Wait for those devices (Ex: Intel 750 NVMe) that are not ready yet
+	 * and responding with CRS statuses for the configuration space
+	 * requests.
+	 */
+	pci_dev_wait(dev, "Switch to D0", PCIE_RESET_READY_POLL_MS);
+
 	return pci_raw_set_power_state(dev, PCI_D0);
 }
 
@@ -4420,47 +4468,6 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
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

