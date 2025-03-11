Return-Path: <linux-pci+bounces-23403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB6A5B93E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 07:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB79E170314
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 06:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E3A2080FD;
	Tue, 11 Mar 2025 06:27:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906721D59F
	for <linux-pci@vger.kernel.org>; Tue, 11 Mar 2025 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674464; cv=none; b=duOeMuKQejaO6i/J+Ew7bwX6gbKHyoQTZO6vlOgf9FYsZckRfEQLhoB5Tc+lJERJSMvJVoqlVyQb2k/7QGIdaYsTln47hv9EbYoU5ZW2oyxjHt3Tk0YNQBQKfKWMIM87iErjcFDmviW6xPAZa7TNH625MqACmeaG1iyvPYkHhXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674464; c=relaxed/simple;
	bh=etQ7nqteBR9fW0XXFOwpxv0CxLF+Gq8liW+SyNVS+zE=;
	h=Message-Id:From:Date:Subject:To:Cc; b=Q4/GDTljqv+Ul9Gb/vgcavgFvCrSRchSvkITSj6Uj2paffjlW2GusCSkV7XnfWTB2VQW1cVVXmN9YHY2gfhKiqbrR7Am/FofkO6AXIRUZ+zzOVh9TAL/ZZec9WYtXp9OjmQIxEzuaKxw3wodsH0ADHFNnsVDrP2GfZOf2+ZWkPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0ABB430011DF4;
	Tue, 11 Mar 2025 07:27:32 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EACF976A1C; Tue, 11 Mar 2025 07:27:31 +0100 (CET)
Message-Id: <02f166e24c87d6cde4085865cce9adfdfd969688.1741674172.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 11 Mar 2025 07:27:32 +0100
Subject: [PATCH] PCI: pciehp: Avoid unnecessary device replacement check
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Kenneth Crudup <kenny@panix.com>, "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ricky Wu <ricky_wu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Hot-removal of nested PCI hotplug ports suffers from a long-standing
race condition which can lead to a deadlock:  A parent hotplug port
acquires pci_lock_rescan_remove(), then waits for pciehp to unbind
from a child hotplug port.  Meanwhile that child hotplug port tries to
acquire pci_lock_rescan_remove() as well in order to remove its own
children.

The deadlock only occurs if the parent acquires pci_lock_rescan_remove()
first, not if the child happens to acquire it first.

Several workarounds to avoid the issue have been proposed and discarded
over the years, e.g.:

https://lore.kernel.org/r/4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de/

A proper fix is being worked on, but needs more time as it is nontrivial
and necessarily intrusive.

Recent commit 9d573d19547b ("PCI: pciehp: Detect device replacement
during system sleep") provokes more frequent occurrence of the deadlock
when removing more than one Thunderbolt device during system sleep.
The commit sought to detect device replacement, but also triggered on
device removal.  Differentiating reliably between replacement and
removal is impossible because pci_get_dsn() returns 0 both if the device
was removed, as well as if it was replaced with one lacking a Device
Serial Number.

Avoid the more frequent occurrence of the deadlock by checking whether
the hotplug port itself was hot-removed.  If so, there's no sense in
checking whether its child device was replaced.

This works because the ->resume_noirq() callback is invoked in top-down
order for the entire hierarchy:  A parent hotplug port detecting device
replacement (or removal) marks all children as removed using
pci_dev_set_disconnected() and a child hotplug port can then reliably
detect being removed.

Fixes: 9d573d19547b ("PCI: pciehp: Detect device replacement during system sleep")
Reported-by: Kenneth Crudup <kenny@panix.com>
Closes: https://lore.kernel.org/r/83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com/
Reported-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Closes: https://lore.kernel.org/r/20240926125909.2362244-1-acelan.kao@canonical.com/
Tested-by: Kenneth Crudup <kenny@panix.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.11+
---
 drivers/pci/hotplug/pciehp_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ff458e6..997841c 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -286,9 +286,12 @@ static int pciehp_suspend(struct pcie_device *dev)
 
 static bool pciehp_device_replaced(struct controller *ctrl)
 {
-	struct pci_dev *pdev __free(pci_dev_put);
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
 	u32 reg;
 
+	if (pci_dev_is_disconnected(ctrl->pcie->port))
+		return false;
+
 	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
 	if (!pdev)
 		return true;
-- 
2.43.0


