Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29693C6184
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 19:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhGLRJj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 13:09:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62342 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhGLRJj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 13:09:39 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id 1126075ed0e12430; Mon, 12 Jul 2021 19:06:48 +0200
Received: from kreacher.localnet (89-64-82-45.dynamic.chello.pl [89.64.82.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9E3C7669C07;
        Mon, 12 Jul 2021 19:06:47 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>
Subject: [RFT][PATCH] PCI: PM: Add special case handling for PCIe device wakeup
Date:   Mon, 12 Jul 2021 19:06:47 +0200
Message-ID: <5475468.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.82.45
X-CLIENT-HOSTNAME: 89-64-82-45.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddruddvgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvvefgteeuteehkeduuedvudetleevffdtffdtjeejueekffetieekgfeigfehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekledrieegrdekvddrgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedvrdeghedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghirdhhvghnghdrfhgvnhhgsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtohepuhhtkhgrrhhshhdrhhdrphgrthgvlhesihhnthgvlhdrtghomhdprhgtphhtthhopehkohgsrgdrkhhosegtrghnohhnihgtrghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some PCIe devices only support PME (Power Management Event) from
D3cold.  One example is the ASMedia xHCI controller:

 11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
   ...
   Capabilities: [78] Power Management version 3
           Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
           Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

In those cases, if the device is expected to generate wakeup events
from its final power state, pci_target_state() returns D0, which
prevents the PCIe port the device is connected to from entering any
low-power states too.  However, if the device were allowed to go into
D3hot, its parent PCIe port would also be able to go into D3 and if
it goes into D3cold, it would cause the endpoint device to end up in
D3cold too (as per the PCI PM spec v1.2, Table 6-1), in which case
the endpoint would be able to signal PME.  This means that the system
could be put into a lower-power configuration without sacrificing the
the given device's ability to generate PME.

In order to avoid missing that opportunity, extend pci_pme_capable()
to check the device's parent in the special case when the target
state is D3hot and the device can only signal PME from D3cold and
update pci_target_state() to return the current target state if
pci_pme_capable() returns 'true' for it.

Link: https://lore.kernel.org/linux-pm/20210617123653.58640-1-mika.westerberg@linux.intel.com
Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
Reported-by: Koba Ko <koba.ko@canonical.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Hi,

Anyone who can reproduce the problem described in the changelog,
please test the patch and let me know the result.

Thanks!

---
 drivers/pci/pci.c |   38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -2298,10 +2298,29 @@ void pci_pme_wakeup_bus(struct pci_bus *
  */
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state)
 {
+	struct pci_dev *parent;
+
 	if (!dev->pm_cap)
 		return false;
 
-	return !!(dev->pme_support & (1 << state));
+	if (dev->pme_support & (1 << state))
+		return true;
+
+	/*
+	 * Special case: The target state is D3hot and the device only supports
+	 * signaling PME from D3cold, but it is a PCIe device whose parent port
+	 * can go into D3cold.  In that case, if the device is allowed to go
+	 * into D3hot, the parent port can go into D3cold which will cause the
+	 * device to end up in D3cold, so it will be able to signal PME from the
+	 * final state.
+	 */
+	if (state != PCI_D3hot || !(dev->pme_support & (1 << PCI_D3cold)))
+		return false;
+
+	parent = dev->bus->self;
+	return pci_bridge_d3_possible(parent) &&
+		platform_pci_power_manageable(parent) &&
+		platform_pci_choose_state(parent) == PCI_D3cold;
 }
 EXPORT_SYMBOL(pci_pme_capable);
 
@@ -2595,17 +2614,12 @@ static pci_power_t pci_target_state(stru
 	if (dev->current_state == PCI_D3cold)
 		target_state = PCI_D3cold;
 
-	if (wakeup) {
-		/*
-		 * Find the deepest state from which the device can generate
-		 * PME#.
-		 */
-		if (dev->pme_support) {
-			while (target_state
-			      && !(dev->pme_support & (1 << target_state)))
-				target_state--;
-		}
-	}
+	if (!wakeup || !dev->pme_support || pci_pme_capable(dev, target_state))
+		return target_state;
+
+	/* Find the deepest state from which the device can generate PME#. */
+	while (target_state && !(dev->pme_support & (1 << target_state)))
+		target_state--;
 
 	return target_state;
 }



