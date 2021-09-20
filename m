Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9A4126AE
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 21:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhITTVg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 15:21:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42334 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347793AbhITTTf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 15:19:35 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 77bde04b42c00814; Mon, 20 Sep 2021 21:18:07 +0200
Received: from kreacher.localnet (unknown [213.134.187.25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9FF4F66A65F;
        Mon, 20 Sep 2021 21:18:06 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 6/7] PCI: PM: Do not call platform_pci_power_manageable() unnecessarily
Date:   Mon, 20 Sep 2021 21:17:33 +0200
Message-ID: <2014133.KlZ2vcFHjT@kreacher>
In-Reply-To: <1800633.tdWV9SEqCh@kreacher>
References: <1800633.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.25
X-CLIENT-HOSTNAME: 213.134.187.25
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeivddgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddukeejrddvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrddvhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgt
 hhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop two invocations of platform_pci_power_manageable() that are not
necessary, because the functions called when it returns 'true' do the
requisite "power manageable" checks themselves.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rebase on top of the new [1-5/7].
   * Move the acpi_pci_power_manageable() simplification to a separate
     patch.
   * Change the subject.

---
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1191,9 +1191,7 @@ void pci_update_current_state(struct pci
  */
 void pci_refresh_power_state(struct pci_dev *dev)
 {
-	if (platform_pci_power_manageable(dev))
-		platform_pci_refresh_power_state(dev);
-
+	platform_pci_refresh_power_state(dev);
 	pci_update_current_state(dev, dev->current_state);
 }
 
@@ -1206,14 +1204,10 @@ int pci_platform_power_transition(struct
 {
 	int error;
 
-	if (platform_pci_power_manageable(dev)) {
-		error = platform_pci_set_power_state(dev, state);
-		if (!error)
-			pci_update_current_state(dev, state);
-	} else
-		error = -ENODEV;
-
-	if (error && !dev->pm_cap) /* Fall back to PCI_D0 */
+	error = acpi_pci_set_power_state(dev, state);
+	if (!error)
+		pci_update_current_state(dev, state);
+	else if (!dev->pm_cap) /* Fall back to PCI_D0 */
 		dev->current_state = PCI_D0;
 
 	return error;



