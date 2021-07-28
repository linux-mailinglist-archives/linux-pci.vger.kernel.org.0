Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0ADE3D943B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 19:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhG1RZL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 13:25:11 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53084 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhG1RZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 13:25:10 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id d053bcc70460610a; Wed, 28 Jul 2021 19:25:06 +0200
Received: from kreacher.localnet (89-64-80-148.dynamic.chello.pl [89.64.80.148])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 5E854669F32;
        Wed, 28 Jul 2021 19:25:05 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>
Subject: [PATCH v2] PCI: PM: Add special case handling for PCIe device wakeup
Date:   Wed, 28 Jul 2021 19:25:04 +0200
Message-ID: <3149540.aeNJFYEL58@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.148
X-CLIENT-HOSTNAME: 89-64-80-148.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrgeelgdelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdevgfetueetheekudeuvdduteelvefftdfftdejjeeukeffteeikefgiefghedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeelrdeigedrkedtrddugeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrddugeekpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
 pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrihdrhhgvnhhgrdhfvghnghestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopehuthhkrghrshhhrdhhrdhprghtvghlsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhosggrrdhkohestggrnhhonhhitggrlhdrtghomh
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
prevents the PCIe hierarchy above the device from entering any
low-power states too, but the device cannot signal PME from D0
either.  However, if the device were allowed to go into D3hot, its
parent PCIe port and its ancestors would also be able to go into D3
and if any of them goes into D3cold, the device would end up in
D3cold too (as per the PCI PM spec v1.2, Table 6-1), in which case
it would be able to signal PME.

This means that the system could be put into a lower-power
configuration while meeting the requirement to enable the device to
generate PME from the final state (which is not the case if the
device stays in D0 along with the entire hierarchy above it).

In order to avoid missing that opportunity, extend pci_pme_capable()
to return 'true' in the special case when the target state is D3hot
and the device can only signal PME from D3cold and update
pci_target_state() to return the current target state if
pci_pme_capable() returns 'true' for it.

This change can be regarded as a pci_target_state() fix, because that
function should ignore its 'wakeup' argument if signaling PME from
any power states shallower than the current candidate one (including
D0) is not supported.

Link: https://lore.kernel.org/linux-pm/20210617123653.58640-1-mika.westerberg@linux.intel.com
Fixes: 666ff6f83e1d ("PCI/PM: Avoid using device_may_wakeup() for runtime PM")
Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
Reported-by: Koba Ko <koba.ko@canonical.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Hi Mika,

IMO it is better to address the case in which the device cannot signal PME from
D0 (as well as from any power states shallower than D3cold), which appears to be
the one at hand, to start with and then, if need be, take care of the case in
which signaling PME from both D0 and D3cold is supported separately.

If the device cannot signal PME from D0, then there is no point returning D0
from pci_target_state() just because 'wakeup' is set, so this is a bug, and
then enabling PME in case the device ends up in D3cold can be regarded as "best
effort" (we cannot guarantee that this will always happen, but then it is the
only way to enable it to signal wakeup anyway).

The case when signaling PME from D0 and D3cold (if we need to worry about it at
all) is more controversial, because in that case leaving the device in D0 really
allows it to signal wakeup, while putting it into D3hot in hope that it will end
up in D3cold may not work.

Cheers!

-> v2:
   * Instead of checking the direct parent of the device in question, which
     doesn't work, check if the device can signal PME from any power states
     shallower than D3cold, including D0.  If not, return 'true' from
     pci_pme_capable() for D3hot as a way to indicate that the device should
     be able to signal wakeup from the final state conditional on getting
     one of its ancestors into D3cold.

---
 drivers/pci/pci.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -2301,7 +2300,21 @@ bool pci_pme_capable(struct pci_dev *dev
 	if (!dev->pm_cap)
 		return false;
 
-	return !!(dev->pme_support & (1 << state));
+	if (dev->pme_support & (1 << state))
+		return true;
+
+	/*
+	 * Special case: The target state is D3hot and the device (which is a
+	 * PCIe one) only supports signaling PME from D3cold.  In that case, if
+	 * the device is allowed to go into D3hot, its ancestor PCIe port may go
+	 * into D3cold which will cause the device to end up in D3cold too
+	 * (along the lines of the PCI PM spec v1.2, Table 6-1), so it will be
+	 * able to signal PME from the final state.  It will not be able to
+	 * signal PME if left in D0, however.
+	 */
+	return state == PCI_D3hot && pci_is_pcie(dev) &&
+		(dev->pme_support & (1 << PCI_D3cold)) &&
+		!(dev->pme_support ^ (1 << PCI_D3cold));
 }
 EXPORT_SYMBOL(pci_pme_capable);
 
@@ -2595,17 +2608,12 @@ static pci_power_t pci_target_state(stru
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



