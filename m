Return-Path: <linux-pci+bounces-7844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FCA8CFF6C
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 13:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EC2284D25
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578AD15DBCC;
	Mon, 27 May 2024 11:54:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2815E5D2
	for <linux-pci@vger.kernel.org>; Mon, 27 May 2024 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810889; cv=none; b=PlDIcsfH5W0aXhGcNvCfmU7z8FjolLNHzvYLnJJgqrPooLevK0Lh65nYLNHItun0Wz7bpmA5YzuWbmdDVo2Una/2f+5EdZGp+41zjaa1giAhcsCPeBD7i38tUm77h9CrcxLeEBLLCl9VvxLLEQ5ZtObPra/LqIx9Z2FbBRC8X7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810889; c=relaxed/simple;
	bh=wAhHm1Hjr5KQc8bdFVrC224SdUc8Nnr8q2wVPYjM8Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlhacrA4OUlozJiWmqLXWuPF6NM4iziizQT7QhA4TD0lTPfCxAk2iyJqVtf4DVEvs55sI/bB9nqULImPGTFe2M0TJZZe8gX5WGY/PC1rGGDVgKRIYwBbaqIJRoH7mKDGAA+CGBvcJGFCx2w41o+Fepfpi13kmd1sjZTD49d92i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id E2A9210195B86;
	Mon, 27 May 2024 13:54:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B0A5B87C7BD; Mon, 27 May 2024 13:54:42 +0200 (CEST)
Date: Mon, 27 May 2024 13:54:42 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ricky WU <ricky_wu@realtek.com>
Cc: "scott@spiteful.org" <scott@spiteful.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [bug report] nvme not re-recognize when changed M.2 SSD in S3
 mode
Message-ID: <ZlR0grWLqO9nch8Q@wunner.de>
References: <a608b5930d0a48f092f717c0e137454b@realtek.com>
 <ZhZk7MMt_dm6avBJ@wunner.de>
 <ZhapFF3393xuIHwM@wunner.de>
 <8c3d00850e7449c184e4c45a3c9b9dfa@realtek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3d00850e7449c184e4c45a3c9b9dfa@realtek.com>

On Thu, Apr 25, 2024 at 06:02:36AM +0000, Ricky WU wrote:
> I tested this patch and the result looks good, but if the two SSD
> has same VID, PID and capacity it still has problem.
> So I think add S/N to compare is necessary if it can do
> 
> And I also tested SD7.0 card the result is same with M.2 SSD

Below please find a reworked patch which checks the Device Serial
Number in addition to various other device identity information
in config space.

I've moved the check for a replaced device to the ->resume_noirq
phase, i.e. before the device driver's first access to the device.
I'm also marking the device removed to prevent the driver from
accessing it.

Does this fix the issue for you?

If it does reliably detect a replaced device, could you also
double-check the opposite case, i.e. if the device is *not*
replaced during system sleep?

I think this is about as much as we can do at the PCI layer to
detect a replaced device.  Drivers may have additional ways
to identify a device (such as reading a WWID from some register)
and we could consider providing a library function which drivers
could call if they detect a replaced device on resume.

If you set CONFIG_DYNAMIC_DEBUG=y and add the following to the
command line...

pciehp.pciehp_debug=1 dyndbg="file pciehp* +p" log_buf_len=10M ignore_loglevel

...you should see "device replaced during system sleep" messages
on resume if a replaced device is detected.

-- >8 --

From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] PCI: pciehp: Detect device replacement during system sleep

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

Reported-by: Ricky Wu <ricky_wu@realtek.com>
Closes: https://lore.kernel.org/r/a608b5930d0a48f092f717c0e137454b@realtek.com
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


