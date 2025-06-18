Return-Path: <linux-pci+bounces-30102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E36D2ADF347
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE271885E21
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493CA2FEE1B;
	Wed, 18 Jun 2025 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="s/sJ8shh"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D192FEE06;
	Wed, 18 Jun 2025 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265907; cv=none; b=O26iaKTsrj0h11A+4QFKRUdZlP+cqxHW/QRIpJaNQYWplrz0uFLQ2Ce+6bFSY5Cs4AscbL/U61zhxEVoEw5khiKM0USMTufVPsr+pb88gMQtOTsxj+qJOYdY8krqEYqei3/YGaWN/ttblkF6lYKK9zeX/b3sy5LjLcQLzBoSYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265907; c=relaxed/simple;
	bh=K4xO/NvLZLmHFsh6LT2gQUQ/7RWKduLSHNDL1emCB0I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YiUDfcm9s2vSUCQ3AbAulz6RoVgkW2dXIFxbEtxuKJveUn5YCBmDDL6uR2JI0d7gvfNjXDr6hn6XYqiBjUXVWQE0F8iYtUowJOhmcHn/4J8De/70ijJgzSsPM0dNxb90CJMqJRedph4WTpVoddh6W5pY8t/76Hc0n5nUtI6jb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=s/sJ8shh; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id C8AEC8287715;
	Wed, 18 Jun 2025 11:58:24 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id uziop6L64xOS; Wed, 18 Jun 2025 11:58:23 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 9B45B82879FF;
	Wed, 18 Jun 2025 11:58:23 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 9B45B82879FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750265903; bh=Pcx4Y/gSefDYdeUAyqXJQfazbp0AxfDxq+BYdkzSYrU=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=s/sJ8shhbgmPauWxMst2O7Uqt7RZgWFL216oq1FVlmrHdRbspHHw9wQnZR0oBUjPe
	 XwabUIPp/CKySuMeXD0meGlnXOI9BozdFqAoyuVq/mJxxcX6G6LSVoMAmEUcaKLo9/
	 I/ua3xdbAn2q3vscvWAjrgYxGyGYXzg92alTPp0c=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rOwciQdemcmg; Wed, 18 Jun 2025 11:58:23 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 619338287715;
	Wed, 18 Jun 2025 11:58:23 -0500 (CDT)
Date: Wed, 18 Jun 2025 11:58:23 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <317515920.1310655.1750265903281.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <581463409.1310624.1750265668004.JavaMail.zimbra@raptorengineeringinc.com>
References: <581463409.1310624.1750265668004.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v2 5/6] pci/hotplug/pnv_php: Fix surprise plug detection and
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Topic: pci/hotplug/pnv_php: Fix surprise plug detection and
Thread-Index: 7ViWVrejj338yZQm64sXoMCfdWvE4Nfh1kgU

 recovery

The existing PowerNV hotplug code did not handle suprise plug events
correctly, leading to a complete failure of the hotplug system after
device removal and a required reboot to detect new devices.

This comes down to two issues:
1.) When a device is suprise removed, oftentimes the bridge upstream
    port will cause a PE freeze on the PHB.  If this freeze is not
    cleared, the MSI interrupts from the bridge hotplug notification
    logic will not be received by the kernel, stalling all plug events
    on all slots associated with the PE.
2.) When a device is removed from a slot, regardless of suprise or
    programmatic removal, the associated PHB/PE ls left frozen.
    If this freeze is not cleared via a fundamental reset, skiboot
    is unable to clear the freeze and cannot retrain / rescan the
    slot.  This also requires a reboot to clear the freeze and redetect
    the device in the slot.

Issue the appropriate unfreeze and rescan commands on hotplug events,
and don't oops on hotplug if pci_bus_to_OF_node() returns NULL.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 arch/powerpc/kernel/pci-hotplug.c |  3 ++
 drivers/pci/hotplug/pnv_php.c     | 53 ++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 9ea74973d78d..6f444d0822d8 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -141,6 +141,9 @@ void pci_hp_add_devices(struct pci_bus *bus)
 	struct pci_controller *phb;
 	struct device_node *dn = pci_bus_to_OF_node(bus);
 
+	if (!dn)
+		return;
+
 	phb = pci_bus_to_host(bus);
 
 	mode = PCI_PROBE_NORMAL;
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index bac8af3df41a..0ceb4a2c3c79 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -10,6 +10,7 @@
 #include <linux/libfdt.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include <linux/pci_hotplug.h>
 #include <linux/of_fdt.h>
 
@@ -474,7 +475,7 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 	struct hotplug_slot *slot = &php_slot->slot;
 	uint8_t presence = OPAL_PCI_SLOT_EMPTY;
 	uint8_t power_status = OPAL_PCI_SLOT_POWER_ON;
-	int ret;
+	int ret, i;
 
 	/* Check if the slot has been configured */
 	if (php_slot->state != PNV_PHP_STATE_REGISTERED)
@@ -532,6 +533,27 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 
 	/* Power is off, turn it on and then scan the slot */
 	ret = pnv_php_set_slot_power_state(slot, OPAL_PCI_SLOT_POWER_ON);
+	if (ret) {
+		SLOT_WARN(php_slot, "PCI slot activation failed with error code %d, possible frozen PHB", ret);
+		SLOT_WARN(php_slot, "Attempting complete PHB reset before retrying slot activation\n");
+		for (i = 0; i < 3; i++) {
+			/* Slot activation failed, PHB may be fenced from a prior device failure
+			 * Use the OPAL fundamental reset call to both try a device reset and clear
+			 * any potentially active PHB fence / freeze
+			 */
+			SLOT_WARN(php_slot, "Try %d...\n", i + 1);
+			pci_set_pcie_reset_state(php_slot->pdev, pcie_warm_reset);
+			msleep(250);
+			pci_set_pcie_reset_state(php_slot->pdev, pcie_deassert_reset);
+
+			ret = pnv_php_set_slot_power_state(slot, OPAL_PCI_SLOT_POWER_ON);
+			if (!ret)
+				break;
+		}
+
+		if (i >= 3)
+			SLOT_WARN(php_slot, "Failed to bring slot online, aborting!\n");
+	}
 	if (ret)
 		return ret;
 
@@ -841,12 +863,41 @@ static void pnv_php_event_handler(struct work_struct *work)
 	struct pnv_php_event *event =
 		container_of(work, struct pnv_php_event, work);
 	struct pnv_php_slot *php_slot = event->php_slot;
+	struct pci_dev *pdev = php_slot->pdev;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	int i, rc;
 
 	if (event->added)
 		pnv_php_enable_slot(&php_slot->slot);
 	else
 		pnv_php_disable_slot(&php_slot->slot);
 
+	if (!event->added) {
+		/* When a device is surprise removed from a downstream bridge slot, the upstream bridge port
+		 * can still end up frozen due to related EEH events, which will in turn block the MSI interrupts
+		 * for slot hotplug detection.  Detect and thaw any frozen upstream PE after slot deactivation...
+		 */
+		edev = pci_dev_to_eeh_dev(pdev);
+		pe = edev ? edev->pe : NULL;
+		rc = eeh_pe_get_state(pe);
+		if ((rc == -ENODEV) || (rc == -ENOENT)) {
+			SLOT_WARN(php_slot, "Upstream bridge PE state unknown, hotplug detect may fail\n");
+		}
+		else {
+			if (pe->state & EEH_PE_ISOLATED) {
+				SLOT_WARN(php_slot, "Upstream bridge PE %02x frozen, thawing...\n", pe->addr);
+				for (i = 0; i < 3; i++)
+					if (!eeh_unfreeze_pe(pe))
+						break;
+				if (i >= 3)
+					SLOT_WARN(php_slot, "Unable to thaw PE %02x, hotplug detect will fail!\n", pe->addr);
+				else
+					SLOT_WARN(php_slot, "PE %02x thawed successfully\n", pe->addr);
+			}
+		}
+	}
+
 	kfree(event);
 }
 
-- 
2.39.5

