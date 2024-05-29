Return-Path: <linux-pci+bounces-8030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822448D3944
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C0A287FCE
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 14:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF63158DCE;
	Wed, 29 May 2024 14:32:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3F54669
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993140; cv=none; b=MS6JIjP3VPKEr+SWM4FpMZW/FIl3rEFscaUTpA4VuKM9SLoVnIyh2gu5LsdkOFxXfom9vgxM6ASNN2xehOwBmRGATnSKE6wXZAVnVMD/aFmVuj1aq2H8+JkE4UpJspLdutKWGsznqf9ec69Q0jMEv4Surf8SDVWlZnoU77JdoSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993140; c=relaxed/simple;
	bh=/N/z6qcOhas0MX07CoXscaTO03/MW6B7t4d0caCZpMs=;
	h=Message-Id:From:Date:Subject:To:Cc; b=pI3ApeilaYs6KBOR92ErhB3GLQDuhYCGRsVO8vscEMmn+vY0p2g1+3PmjfKk7CjniJQmX8ZgrRUU5esG2qvKJ7l+aDkfOdHuo6E9lfLWtY8P93hFy2mvVJ7kASpgLxlrshiTqYQZrKdXrxfmO2GMsI6bqnsuqa0m0vSiYTfU050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 39E2D10195455;
	Wed, 29 May 2024 16:32:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E4FC6230885; Wed, 29 May 2024 16:32:08 +0200 (CEST)
Message-Id: <a1afaa12f341d146ecbea27c1743661c71683833.1716992815.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 29 May 2024 16:32:09 +0200
Subject: [PATCH] PCI: pciehp: Detect device replacement during system sleep
To: Bjorn Helgaas <helgaas@kernel.org>, Ricky Wu <ricky_wu@realtek.com>
Cc: Scott Murray <scott@spiteful.org>, Keith Busch <kbusch@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aapo Vienamo <aapo.vienamo@linux.intel.com>, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Ricky reports that replacing a device in a hotplug slot during ACPI
sleep state S3 does not cause re-enumeration on resume, as one would
expect.  Instead, the new device is treated as if it was the old one.

There is no bulletproof way to detect device replacement, but as a
heuristic, check whether the device identity in config space matches
cached data in struct pci_dev (Vendor ID, Device ID, Class Code,
Revision ID, Subsystem Vendor ID, Subsystem ID).  Additionally, cache
and compare the Device Serial Number (PCIe r6.2 sec 7.9.3).  If a
mismatch is detected, mark the old device disconnected (to prevent its
driver from accessing the new device) and synthesize a Presence Detect
Changed event.

The device identity in config space which is compared here is the same
as the one included in the signed Subject Alternative Name per PCIe r6.1
sec 6.31.3.  Thus, the present commit prevents attacks where a valid
device is replaced with a malicious device during system sleep and the
valid device's driver obliviously accesses the malicious device.

This is about as much as can be done at the PCI layer.  Drivers may have
additional ways to identify devices (such as reading a WWID from some
register) and may trigger re-enumeration when detecting an identity
change on resume.

Reported-by: Ricky Wu <ricky_wu@realtek.com>
Closes: https://lore.kernel.org/r/a608b5930d0a48f092f717c0e137454b@realtek.com
Tested-by: Ricky Wu <ricky_wu@realtek.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      |  4 ++++
 drivers/pci/hotplug/pciehp_core.c | 42 ++++++++++++++++++++++++++++++++++++++-
 drivers/pci/hotplug/pciehp_hpc.c  |  5 +++++
 drivers/pci/hotplug/pciehp_pci.c  |  4 ++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index e0a614a..273dd8c 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -46,6 +46,9 @@
 /**
  * struct controller - PCIe hotplug controller
  * @pcie: pointer to the controller's PCIe port service device
+ * @dsn: cached copy of Device Serial Number of Function 0 in the hotplug slot
+ *	(PCIe r6.2 sec 7.9.3); used to determine whether a hotplugged device
+ *	was replaced with a different one during system sleep
  * @slot_cap: cached copy of the Slot Capabilities register
  * @inband_presence_disabled: In-Band Presence Detect Disable supported by
  *	controller and disabled per spec recommendation (PCIe r5.0, appendix I
@@ -87,6 +90,7 @@
  */
 struct controller {
 	struct pcie_device *pcie;
+	u64 dsn;
 
 	u32 slot_cap;				/* capabilities and quirks */
 	unsigned int inband_presence_disabled:1;
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ddd55ad..ff458e6 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -284,6 +284,32 @@ static int pciehp_suspend(struct pcie_device *dev)
 	return 0;
 }
 
+static bool pciehp_device_replaced(struct controller *ctrl)
+{
+	struct pci_dev *pdev __free(pci_dev_put);
+	u32 reg;
+
+	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
+	if (!pdev)
+		return true;
+
+	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
+	    reg != (pdev->vendor | (pdev->device << 16)) ||
+	    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
+	    reg != (pdev->revision | (pdev->class << 8)))
+		return true;
+
+	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
+	    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
+	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
+		return true;
+
+	if (pci_get_dsn(pdev) != ctrl->dsn)
+		return true;
+
+	return false;
+}
+
 static int pciehp_resume_noirq(struct pcie_device *dev)
 {
 	struct controller *ctrl = get_service_data(dev);
@@ -293,9 +319,23 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
 	ctrl->cmd_busy = true;
 
 	/* clear spurious events from rediscovery of inserted card */
-	if (ctrl->state == ON_STATE || ctrl->state == BLINKINGOFF_STATE)
+	if (ctrl->state == ON_STATE || ctrl->state == BLINKINGOFF_STATE) {
 		pcie_clear_hotplug_events(ctrl);
 
+		/*
+		 * If hotplugged device was replaced with a different one
+		 * during system sleep, mark the old device disconnected
+		 * (to prevent its driver from accessing the new device)
+		 * and synthesize a Presence Detect Changed event.
+		 */
+		if (pciehp_device_replaced(ctrl)) {
+			ctrl_dbg(ctrl, "device replaced during system sleep\n");
+			pci_walk_bus(ctrl->pcie->port->subordinate,
+				     pci_dev_set_disconnected, NULL);
+			pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
+		}
+	}
+
 	return 0;
 }
 #endif
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b1d0a1b3..061f01f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -1055,6 +1055,11 @@ struct controller *pcie_init(struct pcie_device *dev)
 		}
 	}
 
+	pdev = pci_get_slot(subordinate, PCI_DEVFN(0, 0));
+	if (pdev)
+		ctrl->dsn = pci_get_dsn(pdev);
+	pci_dev_put(pdev);
+
 	return ctrl;
 }
 
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index ad12515..65e50be 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -72,6 +72,10 @@ int pciehp_configure_device(struct controller *ctrl)
 	pci_bus_add_devices(parent);
 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 
+	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
+	ctrl->dsn = pci_get_dsn(dev);
+	pci_dev_put(dev);
+
  out:
 	pci_unlock_rescan_remove();
 	return ret;
-- 
2.43.0


