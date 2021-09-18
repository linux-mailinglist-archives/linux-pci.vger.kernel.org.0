Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3EA410695
	for <lists+linux-pci@lfdr.de>; Sat, 18 Sep 2021 15:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbhIRND7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Sep 2021 09:03:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52750 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbhIRND7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Sep 2021 09:03:59 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 8011dc6e58fefd45; Sat, 18 Sep 2021 15:02:34 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 571D566A568;
        Sat, 18 Sep 2021 15:02:33 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] ACPI: glue: Look for ACPI bus type only if ACPI companion is not known
Date:   Sat, 18 Sep 2021 15:02:23 +0200
Message-ID: <21197831.EfDdHjke4D@kreacher>
In-Reply-To: <1794818.tdWV9SEqCh@kreacher>
References: <1794818.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhn
 uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that it is not necessary to look for the "ACPI bus type" of
the device in acpi_device_notify() if the device's ACPI companion
is set upfront, so modify the code to do that lookup only if it is
necessary to find the ACPI companion.

Also notice that if the device's ACPI companion is not set upfront
in acpi_device_notify(), the device cannot be either a PCI one or a
platform one, so check for these bus types only if the device's
ACPI companion is set.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -289,12 +289,13 @@ EXPORT_SYMBOL_GPL(acpi_unbind_one);
 
 void acpi_device_notify(struct device *dev)
 {
-	struct acpi_bus_type *type = acpi_get_bus_type(dev);
 	struct acpi_device *adev;
 	int ret;
 
 	ret = acpi_bind_one(dev, NULL);
 	if (ret) {
+		struct acpi_bus_type *type = acpi_get_bus_type(dev);
+
 		if (!type)
 			goto err;
 
@@ -306,21 +307,26 @@ void acpi_device_notify(struct device *d
 		ret = acpi_bind_one(dev, adev);
 		if (ret)
 			goto err;
-	}
-	adev = ACPI_COMPANION(dev);
 
-	if (dev_is_pci(dev)) {
-		pci_acpi_setup(dev, adev);
+		if (type->setup) {
+			type->setup(dev);
+			goto done;
+		}
 	} else {
-		if (dev_is_platform(dev))
-			acpi_configure_pmsi_domain(dev);
+		adev = ACPI_COMPANION(dev);
 
-		if (type && type->setup)
-			type->setup(dev);
-		else if (adev->handler && adev->handler->bind)
-			adev->handler->bind(dev);
+		if (dev_is_pci(dev)) {
+			pci_acpi_setup(dev, adev);
+			goto done;
+		} else if (dev_is_platform(dev)) {
+			acpi_configure_pmsi_domain(dev);
+		}
 	}
 
+	if (adev->handler && adev->handler->bind)
+		adev->handler->bind(dev);
+
+done:
 	acpi_handle_debug(ACPI_HANDLE(dev), "Bound to device %s\n",
 			  dev_name(dev));
 



