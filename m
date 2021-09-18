Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317294106CC
	for <lists+linux-pci@lfdr.de>; Sat, 18 Sep 2021 15:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbhIRNbB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Sep 2021 09:31:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60360 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbhIRNbB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Sep 2021 09:31:01 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 14d4b4462a90a26d; Sat, 18 Sep 2021 15:29:36 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7531B66A51F;
        Sat, 18 Sep 2021 15:29:35 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        x86 Maintainers <x86@kernel.org>
Subject: [PATCH v1 3/5] PCI: PM: Rearrange code in  pci_target_state()
Date:   Sat, 18 Sep 2021 15:24:46 +0200
Message-ID: <2085010.Mh6RI2rZIc@kreacher>
In-Reply-To: <8003272.NyiUUSuA9g@kreacher>
References: <8003272.NyiUUSuA9g@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdejjedrhedurdekgeenucfuphgrmhfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghr
 nhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make pci_target_state() return D3cold or D0 without checking PME
support if the current power state of the device is D3cold or if it
does not support the standard PCI PM, respectively.

Next, drop the tergat_state local variable that has become redundant
from that function.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -2520,8 +2520,6 @@ EXPORT_SYMBOL(pci_wake_from_d3);
  */
 static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 {
-	pci_power_t target_state = PCI_D3hot;
-
 	if (acpi_pci_power_manageable(dev)) {
 		/*
 		 * Use ACPI to find the target state for the device.  If it
@@ -2533,32 +2531,29 @@ static pci_power_t pci_target_state(stru
 		switch (state) {
 		case PCI_POWER_ERROR:
 		case PCI_UNKNOWN:
-			break;
+			return PCI_D3hot;
+
 		case PCI_D1:
 		case PCI_D2:
 			if (pci_no_d1d2(dev))
-				break;
-			fallthrough;
-		default:
-			target_state = state;
+				return PCI_D3hot;
 		}
 
-		return target_state;
+		return state;
 	}
 
-	if (!dev->pm_cap)
-		target_state = PCI_D0;
-
 	/*
 	 * If the device is in D3cold even though it's not power-manageable by
 	 * the platform, it may have been powered down by non-standard means.
 	 * Best to let it slumber.
 	 */
 	if (dev->current_state == PCI_D3cold)
-		target_state = PCI_D3cold;
+		return PCI_D3cold;
+	else if (!dev->pm_cap)
+		return PCI_D0;
 
 	if (wakeup && dev->pme_support) {
-		pci_power_t state = target_state;
+		pci_power_t state = PCI_D3hot;
 
 		/*
 		 * Find the deepest state from which the device can generate
@@ -2573,7 +2568,7 @@ static pci_power_t pci_target_state(stru
 			return PCI_D0;
 	}
 
-	return target_state;
+	return PCI_D3hot;
 }
 
 /**



