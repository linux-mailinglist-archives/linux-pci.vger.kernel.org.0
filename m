Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E077141069B
	for <lists+linux-pci@lfdr.de>; Sat, 18 Sep 2021 15:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhIRNEE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Sep 2021 09:04:04 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41912 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbhIRNEC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Sep 2021 09:04:02 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id e093aa76f8b5b6c0; Sat, 18 Sep 2021 15:02:37 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D869966A568;
        Sat, 18 Sep 2021 15:02:36 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] PCI: ACPI: Drop acpi_pci_bus
Date:   Sat, 18 Sep 2021 14:53:44 +0200
Message-ID: <2793105.e9J7NaK4W3@kreacher>
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

The acpi_pci_bus structure was used primarily for running
acpi_pci_find_companion() during PCI device objects registration,
but after commit 375553a93201 ("PCI: Setup ACPI fwnode early and at
the same time with OF") that function is called by pci_setup_device()
via pci_set_acpi_fwnode(), which happens before calling
pci_device_add() on the new PCI device object, so its ACPI companion
has been set already when acpi_device_notify() runs and it will never
call ->find_companion() from acpi_pci_bus.

For this reason, modify acpi_device_notify() and
acpi_device_notify_remove() to call pci_acpi_setup() and
pci_acpi_cleanup(), respectively, directly on PCI device objects
and drop acpi_pci_bus altogether.

While at it, notice that pci_acpi_setup() and pci_acpi_cleanup()
can obtain the ACPI companion pointer, which is guaranteed to not
be NULL, from their callers and modify them to work that way so
as to reduce the number of redundant checks somewhat.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c      |   36 +++++++++++++++++++++++-------------
 drivers/pci/pci-acpi.c   |   31 +++----------------------------
 include/linux/pci-acpi.h |    8 ++++++++
 3 files changed, 34 insertions(+), 41 deletions(-)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -1353,13 +1353,9 @@ static void pci_acpi_set_external_facing
 		dev->external_facing = 1;
 }
 
-static void pci_acpi_setup(struct device *dev)
+void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-
-	if (!adev)
-		return;
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
@@ -1383,14 +1379,10 @@ static void pci_acpi_setup(struct device
 	acpi_device_power_add_dependent(adev, dev);
 }
 
-static void pci_acpi_cleanup(struct device *dev)
+void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
-	if (!adev)
-		return;
-
 	pci_acpi_remove_edr_notifier(pci_dev);
 	pci_acpi_remove_pm_notifier(adev);
 	if (adev->wakeup.flags.valid) {
@@ -1402,20 +1394,6 @@ static void pci_acpi_cleanup(struct devi
 	}
 }
 
-static bool pci_acpi_bus_match(struct device *dev)
-{
-	return dev_is_pci(dev);
-}
-
-static struct acpi_bus_type acpi_pci_bus = {
-	.name = "PCI",
-	.match = pci_acpi_bus_match,
-	.find_companion = acpi_pci_find_companion,
-	.setup = pci_acpi_setup,
-	.cleanup = pci_acpi_cleanup,
-};
-
-
 static struct fwnode_handle *(*pci_msi_get_fwnode_cb)(struct device *dev);
 
 /**
@@ -1457,8 +1435,6 @@ struct irq_domain *pci_host_bridge_acpi_
 
 static int __init acpi_pci_init(void)
 {
-	int ret;
-
 	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_MSI) {
 		pr_info("ACPI FADT declares the system doesn't support MSI, so disable it\n");
 		pci_no_msi();
@@ -1469,8 +1445,7 @@ static int __init acpi_pci_init(void)
 		pcie_no_aspm();
 	}
 
-	ret = register_acpi_bus_type(&acpi_pci_bus);
-	if (ret)
+	if (acpi_pci_disabled)
 		return 0;
 
 	pci_set_platform_pm(&acpi_pci_platform_pm);
Index: linux-pm/include/linux/pci-acpi.h
===================================================================
--- linux-pm.orig/include/linux/pci-acpi.h
+++ linux-pm/include/linux/pci-acpi.h
@@ -84,6 +84,14 @@ extern struct pci_bus *acpi_pci_root_cre
 void acpi_pci_add_bus(struct pci_bus *bus);
 void acpi_pci_remove_bus(struct pci_bus *bus);
 
+#ifdef CONFIG_PCI
+void pci_acpi_setup(struct device *dev, struct acpi_device *adev);
+void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev);
+#else
+static inline void pci_acpi_setup(struct device *dev, struct acpi_device *adev) {}
+static inline void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev) {}
+#endif
+
 #ifdef	CONFIG_ACPI_PCI_SLOT
 void acpi_pci_slot_init(void);
 void acpi_pci_slot_enumerate(struct pci_bus *bus);
Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -17,6 +17,8 @@
 #include <linux/rwsem.h>
 #include <linux/acpi.h>
 #include <linux/dma-mapping.h>
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
 #include <linux/platform_device.h>
 
 #include "internal.h"
@@ -307,13 +309,17 @@ void acpi_device_notify(struct device *d
 	}
 	adev = ACPI_COMPANION(dev);
 
-	if (dev_is_platform(dev))
-		acpi_configure_pmsi_domain(dev);
-
-	if (type && type->setup)
-		type->setup(dev);
-	else if (adev->handler && adev->handler->bind)
-		adev->handler->bind(dev);
+	if (dev_is_pci(dev)) {
+		pci_acpi_setup(dev, adev);
+	} else {
+		if (dev_is_platform(dev))
+			acpi_configure_pmsi_domain(dev);
+
+		if (type && type->setup)
+			type->setup(dev);
+		else if (adev->handler && adev->handler->bind)
+			adev->handler->bind(dev);
+	}
 
 	acpi_handle_debug(ACPI_HANDLE(dev), "Bound to device %s\n",
 			  dev_name(dev));
@@ -327,16 +333,20 @@ err:
 void acpi_device_notify_remove(struct device *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	struct acpi_bus_type *type;
 
 	if (!adev)
 		return;
 
-	type = acpi_get_bus_type(dev);
-	if (type && type->cleanup)
-		type->cleanup(dev);
-	else if (adev->handler && adev->handler->unbind)
-		adev->handler->unbind(dev);
+	if (dev_is_pci(dev)) {
+		pci_acpi_cleanup(dev, adev);
+	} else {
+		struct acpi_bus_type *type = acpi_get_bus_type(dev);
+
+		if (type && type->cleanup)
+			type->cleanup(dev);
+		else if (adev->handler && adev->handler->unbind)
+			adev->handler->unbind(dev);
+	}
 
 	acpi_unbind_one(dev);
 }



