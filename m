Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12B94106C6
	for <lists+linux-pci@lfdr.de>; Sat, 18 Sep 2021 15:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbhIRN3u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Sep 2021 09:29:50 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55028 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbhIRN3u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Sep 2021 09:29:50 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 5f1cbb66e24808ce; Sat, 18 Sep 2021 15:28:25 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2442D66A51F;
        Sat, 18 Sep 2021 15:28:24 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        x86 Maintainers <x86@kernel.org>
Subject: [PATCH v1 5/5] PCI: PM: ACPI: Drop unnecessary acpi_pci_power_manageable() calls
Date:   Sat, 18 Sep 2021 15:27:37 +0200
Message-ID: <1769617.atdPhlSkOF@kreacher>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Simplify acpi_pci_power_manageable() and drop two invocations of it
that are not necessary, because the functions called when it returns
'true' do the requisite "power manageable" checks themselves.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-acpi.c |    4 +---
 drivers/pci/pci.c      |   16 +++++-----------
 2 files changed, 6 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1128,9 +1128,7 @@ void pci_update_current_state(struct pci
  */
 void pci_refresh_power_state(struct pci_dev *dev)
 {
-	if (acpi_pci_power_manageable(dev))
-		acpi_pci_refresh_power_state(dev);
-
+	acpi_pci_refresh_power_state(dev);
 	pci_update_current_state(dev, dev->current_state);
 }
 
@@ -1143,14 +1141,10 @@ int pci_platform_power_transition(struct
 {
 	int error;
 
-	if (acpi_pci_power_manageable(dev)) {
-		error = acpi_pci_set_power_state(dev, state);
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
Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -969,9 +969,7 @@ bool acpi_pci_power_manageable(struct pc
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
 
-	if (!adev)
-		return false;
-	return acpi_device_power_manageable(adev);
+	return adev && acpi_device_power_manageable(adev);
 }
 
 bool acpi_pci_bridge_d3(struct pci_dev *dev)



