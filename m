Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228E331FEBF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Feb 2021 19:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBSSZj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Feb 2021 13:25:39 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42070 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhBSSZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Feb 2021 13:25:37 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Feb 2021 13:25:35 EST
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id 816e0173f029b67d; Fri, 19 Feb 2021 19:18:13 +0100
Received: from kreacher.localnet (89-64-81-29.dynamic.chello.pl [89.64.81.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AB2AD661E07;
        Fri, 19 Feb 2021 19:18:12 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v1 4/4] ACPI: PCI: Replace direct printk() invocations in pci_link.c
Date:   Fri, 19 Feb 2021 19:17:44 +0100
Message-ID: <2246899.HyxBmBtjVt@kreacher>
In-Reply-To: <4822757.tvZ08WQ2Gl@kreacher>
References: <4822757.tvZ08WQ2Gl@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgleehfffhtefflefhleetjeffteettefgteekjedvhfeffedtueefveegveeiveenucfkphepkeelrdeigedrkedurddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrvdelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehguhhohhgrnhhjuhhnsehhuhgrfigvihdrtgho
 mh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the direct printk() invocations in pci_link.c with (mostly
corresponding) acpi_handle_*() calls relative to the ACPI handle of
the given link device, which allows the AML corresponding to those
messages to be identified more easily, or with pr_*() calls.

While at it, add a pr_fmt() definition ot pci_link.c, make
acpi_pci_link_check_possible() print all messages with
acpi_handle_debug() for consistency and replace the (not-so-
reliable) KERN_CONT-based message line composition in
acpi_pci_link_add() with two pr_info() and a series of
acpi_handle_debug() calls (the latter for the possible IRQs).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_link.c |   86 +++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 48 deletions(-)

Index: linux-pm/drivers/acpi/pci_link.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_link.c
+++ linux-pm/drivers/acpi/pci_link.c
@@ -12,6 +12,8 @@
  *	   for IRQ management (e.g. start()->_SRS).
  */
 
+#define pr_fmt(fmt) "ACPI: PCI: " fmt
+
 #include <linux/syscore_ops.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -102,9 +104,9 @@ static acpi_status acpi_pci_link_check_p
 			     (i < p->interrupt_count
 			      && i < ACPI_PCI_LINK_MAX_POSSIBLE); i++) {
 				if (!p->interrupts[i]) {
-					printk(KERN_WARNING PREFIX
-					       "Invalid _PRS IRQ %d\n",
-					       p->interrupts[i]);
+					acpi_handle_debug(handle,
+							  "Invalid _PRS IRQ %d\n",
+							  p->interrupts[i]);
 					continue;
 				}
 				link->irq.possible[i] = p->interrupts[i];
@@ -120,17 +122,17 @@ static acpi_status acpi_pci_link_check_p
 			struct acpi_resource_extended_irq *p =
 			    &resource->data.extended_irq;
 			if (!p || !p->interrupt_count) {
-				printk(KERN_WARNING PREFIX
-					      "Blank _PRS EXT IRQ resource\n");
+				acpi_handle_debug(handle,
+						  "Blank _PRS EXT IRQ resource\n");
 				return AE_OK;
 			}
 			for (i = 0;
 			     (i < p->interrupt_count
 			      && i < ACPI_PCI_LINK_MAX_POSSIBLE); i++) {
 				if (!p->interrupts[i]) {
-					printk(KERN_WARNING PREFIX
-					       "Invalid _PRS IRQ %d\n",
-					       p->interrupts[i]);
+					acpi_handle_debug(handle,
+							  "Invalid _PRS IRQ %d\n",
+							  p->interrupts[i]);
 					continue;
 				}
 				link->irq.possible[i] = p->interrupts[i];
@@ -142,8 +144,8 @@ static acpi_status acpi_pci_link_check_p
 			break;
 		}
 	default:
-		printk(KERN_ERR PREFIX "_PRS resource type 0x%x isn't an IRQ\n",
-		       resource->type);
+		acpi_handle_debug(handle, "_PRS resource type 0x%x is not IRQ\n",
+				  resource->type);
 		return AE_OK;
 	}
 
@@ -527,6 +529,7 @@ static int acpi_irq_balance = -1;	/* 0:
 
 static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 {
+	acpi_handle handle = link->device->handle;
 	int irq;
 	int i;
 
@@ -549,8 +552,8 @@ static int acpi_pci_link_allocate(struct
 	 */
 	if (i == link->irq.possible_count) {
 		if (acpi_strict)
-			printk(KERN_WARNING PREFIX "_CRS %d not found"
-				      " in _PRS\n", link->irq.active);
+			acpi_handle_warn(handle, "_CRS %d not found in _PRS\n",
+					 link->irq.active);
 		link->irq.active = 0;
 	}
 
@@ -574,28 +577,23 @@ static int acpi_pci_link_allocate(struct
 		}
 	}
 	if (acpi_irq_get_penalty(irq) >= PIRQ_PENALTY_ISA_ALWAYS) {
-		printk(KERN_ERR PREFIX "No IRQ available for %s [%s]. "
-			    "Try pci=noacpi or acpi=off\n",
-			    acpi_device_name(link->device),
-			    acpi_device_bid(link->device));
+		acpi_handle_err(handle,
+				"No IRQ available. Try pci=noacpi or acpi=off\n");
 		return -ENODEV;
 	}
 
 	/* Attempt to enable the link device at this IRQ. */
 	if (acpi_pci_link_set(link, irq)) {
-		printk(KERN_ERR PREFIX "Unable to set IRQ for %s [%s]. "
-			    "Try pci=noacpi or acpi=off\n",
-			    acpi_device_name(link->device),
-			    acpi_device_bid(link->device));
+		acpi_handle_err(handle,
+				"Unable to set IRQ. Try pci=noacpi or acpi=off\n");
 		return -ENODEV;
 	} else {
 		if (link->irq.active < ACPI_MAX_ISA_IRQS)
 			acpi_isa_irq_penalty[link->irq.active] +=
 				PIRQ_PENALTY_PCI_USING;
 
-		pr_info("%s [%s] enabled at IRQ %d\n",
-		       acpi_device_name(link->device),
-		       acpi_device_bid(link->device), link->irq.active);
+		acpi_handle_info(handle, "Enabled at IRQ %d\n",
+				 link->irq.active);
 	}
 
 	link->irq.initialized = 1;
@@ -616,19 +614,19 @@ int acpi_pci_link_allocate_irq(acpi_hand
 
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
-		printk(KERN_ERR PREFIX "Invalid link device\n");
+		acpi_handle_err(handle, "Invalid link device\n");
 		return -1;
 	}
 
 	link = acpi_driver_data(device);
 	if (!link) {
-		printk(KERN_ERR PREFIX "Invalid link context\n");
+		acpi_handle_err(handle, "Invalid link context\n");
 		return -1;
 	}
 
 	/* TBD: Support multiple index (IRQ) entries per Link Device */
 	if (index) {
-		printk(KERN_ERR PREFIX "Invalid index %d\n", index);
+		acpi_handle_err(handle, "Invalid index %d\n", index);
 		return -1;
 	}
 
@@ -640,7 +638,7 @@ int acpi_pci_link_allocate_irq(acpi_hand
 
 	if (!link->irq.active) {
 		mutex_unlock(&acpi_link_lock);
-		printk(KERN_ERR PREFIX "Link active IRQ is 0!\n");
+		acpi_handle_err(handle, "Link active IRQ is 0!\n");
 		return -1;
 	}
 	link->refcnt++;
@@ -668,20 +666,20 @@ int acpi_pci_link_free_irq(acpi_handle h
 
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
-		printk(KERN_ERR PREFIX "Invalid link device\n");
+		acpi_handle_err(handle, "Invalid link device\n");
 		return -1;
 	}
 
 	link = acpi_driver_data(device);
 	if (!link) {
-		printk(KERN_ERR PREFIX "Invalid link context\n");
+		acpi_handle_err(handle, "Invalid link context\n");
 		return -1;
 	}
 
 	mutex_lock(&acpi_link_lock);
 	if (!link->irq.initialized) {
 		mutex_unlock(&acpi_link_lock);
-		printk(KERN_ERR PREFIX "Link isn't initialized\n");
+		acpi_handle_err(handle, "Link isn't initialized\n");
 		return -1;
 	}
 #ifdef	FUTURE_USE
@@ -712,10 +710,10 @@ int acpi_pci_link_free_irq(acpi_handle h
 static int acpi_pci_link_add(struct acpi_device *device,
 			     const struct acpi_device_id *not_used)
 {
-	int result;
+	acpi_handle handle = device->handle;
 	struct acpi_pci_link *link;
+	int result;
 	int i;
-	int found = 0;
 
 	link = kzalloc(sizeof(struct acpi_pci_link), GFP_KERNEL);
 	if (!link)
@@ -734,31 +732,23 @@ static int acpi_pci_link_add(struct acpi
 	/* query and set link->irq.active */
 	acpi_pci_link_get_current(link);
 
-	printk(KERN_INFO PREFIX "%s [%s] (IRQs", acpi_device_name(device),
-	       acpi_device_bid(device));
+	pr_info("Interrupt link %s configured for IRQ %d\n",
+		acpi_device_bid(device), link->irq.active);
+
 	for (i = 0; i < link->irq.possible_count; i++) {
-		if (link->irq.active == link->irq.possible[i]) {
-			printk(KERN_CONT " *%d", link->irq.possible[i]);
-			found = 1;
-		} else
-			printk(KERN_CONT " %d", link->irq.possible[i]);
+		if (link->irq.active != link->irq.possible[i])
+			acpi_handle_debug(handle, "Possible IRQ %d\n",
+					  link->irq.possible[i]);
 	}
 
-	printk(KERN_CONT ")");
-
-	if (!found)
-		printk(KERN_CONT " *%d", link->irq.active);
-
 	if (!link->device->status.enabled)
-		printk(KERN_CONT ", disabled.");
-
-	printk(KERN_CONT "\n");
+		pr_info("Interrupt link %s disabled\n", acpi_device_bid(device));
 
 	list_add_tail(&link->list, &acpi_link_list);
 
       end:
 	/* disable all links -- to be activated on use */
-	acpi_evaluate_object(device->handle, "_DIS", NULL, NULL);
+	acpi_evaluate_object(handle, "_DIS", NULL, NULL);
 	mutex_unlock(&acpi_link_lock);
 
 	if (result)



