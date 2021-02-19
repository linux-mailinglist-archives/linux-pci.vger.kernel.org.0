Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930E831FEC0
	for <lists+linux-pci@lfdr.de>; Fri, 19 Feb 2021 19:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhBSSZm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Feb 2021 13:25:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47436 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBSSZk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Feb 2021 13:25:40 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id ad559b126ce7d5d3; Fri, 19 Feb 2021 19:18:16 +0100
Received: from kreacher.localnet (89-64-81-29.dynamic.chello.pl [89.64.81.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id DC040661E07;
        Fri, 19 Feb 2021 19:18:15 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v1 2/4] ACPI: PCI: Replace ACPI_DEBUG_PRINT() and ACPI_EXCEPTION()
Date:   Fri, 19 Feb 2021 19:16:10 +0100
Message-ID: <3010705.Er5mbVqhuS@kreacher>
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

The ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() macros are used for
message printing in the ACPICA code and they should not be used
elsewhere.  Special configuration (either kernel command line or
sysfs-based) is needed to see the messages printed by them and
the format of those messages is also special and convoluted.

For this reason, replace all of the ACPI_DEBUG_PRINT() and
ACPI_EXCEPTION() instances in pci_link.c with acpi_handle_*() calls
relative to the ACPI handle of the given link device (wherever that
handle is readily available) or pr_debug() invocations.

While at it, make acpi_pci_link_check_current() print all messages
with pr_debug(), because all of them are in the same category (_CRS
return buffer issues) and they all should be printed at the same log
level.

Also make acpi_pci_link_set() use acpi_handle_*() for printing all
messages for consistency.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_link.c |   80 +++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

Index: linux-pm/drivers/acpi/pci_link.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_link.c
+++ linux-pm/drivers/acpi/pci_link.c
@@ -27,8 +27,6 @@
 
 #include "internal.h"
 
-#define _COMPONENT			ACPI_PCI_COMPONENT
-ACPI_MODULE_NAME("pci_link");
 #define ACPI_PCI_LINK_CLASS		"pci_irq_routing"
 #define ACPI_PCI_LINK_DEVICE_NAME	"PCI Interrupt Link"
 #define ACPI_PCI_LINK_MAX_POSSIBLE	16
@@ -85,6 +83,7 @@ static acpi_status acpi_pci_link_check_p
 						void *context)
 {
 	struct acpi_pci_link *link = context;
+	acpi_handle handle = link->device->handle;
 	u32 i;
 
 	switch (resource->type) {
@@ -95,8 +94,8 @@ static acpi_status acpi_pci_link_check_p
 		{
 			struct acpi_resource_irq *p = &resource->data.irq;
 			if (!p || !p->interrupt_count) {
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "Blank _PRS IRQ resource\n"));
+				acpi_handle_debug(handle,
+						  "Blank _PRS IRQ resource\n");
 				return AE_OK;
 			}
 			for (i = 0;
@@ -153,18 +152,18 @@ static acpi_status acpi_pci_link_check_p
 
 static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
 {
+	acpi_handle handle = link->device->handle;
 	acpi_status status;
 
-	status = acpi_walk_resources(link->device->handle, METHOD_NAME__PRS,
+	status = acpi_walk_resources(handle, METHOD_NAME__PRS,
 				     acpi_pci_link_check_possible, link);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_debug(link->device->handle, "_PRS not present or invalid");
+		acpi_handle_debug(handle, "_PRS not present or invalid");
 		return 0;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Found %d possible IRQs\n",
-			  link->irq.possible_count));
+	acpi_handle_debug(handle, "Found %d possible IRQs\n",
+			  link->irq.possible_count);
 
 	return 0;
 }
@@ -186,8 +185,7 @@ static acpi_status acpi_pci_link_check_c
 				 * IRQ descriptors may have no IRQ# bits set,
 				 * particularly those those w/ _STA disabled
 				 */
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "Blank _CRS IRQ resource\n"));
+				pr_debug("Blank _CRS IRQ resource\n");
 				return AE_OK;
 			}
 			*irq = p->interrupts[0];
@@ -202,8 +200,7 @@ static acpi_status acpi_pci_link_check_c
 				 * extended IRQ descriptors must
 				 * return at least 1 IRQ
 				 */
-				printk(KERN_WARNING PREFIX
-					      "Blank _CRS EXT IRQ resource\n");
+				pr_debug("Blank _CRS EXT IRQ resource\n");
 				return AE_OK;
 			}
 			*irq = p->interrupts[0];
@@ -211,8 +208,8 @@ static acpi_status acpi_pci_link_check_c
 		}
 		break;
 	default:
-		printk(KERN_ERR PREFIX "_CRS resource type 0x%x isn't an IRQ\n",
-		       resource->type);
+		pr_debug("_CRS resource type 0x%x is not IRQ\n",
+			 resource->type);
 		return AE_OK;
 	}
 
@@ -228,8 +225,9 @@ static acpi_status acpi_pci_link_check_c
  */
 static int acpi_pci_link_get_current(struct acpi_pci_link *link)
 {
-	int result = 0;
+	acpi_handle handle = link->device->handle;
 	acpi_status status;
+	int result = 0;
 	int irq = 0;
 
 	link->irq.active = 0;
@@ -239,12 +237,12 @@ static int acpi_pci_link_get_current(str
 		/* Query _STA, set link->device->status */
 		result = acpi_bus_get_status(link->device);
 		if (result) {
-			printk(KERN_ERR PREFIX "Unable to read status\n");
+			acpi_handle_err(handle, "Unable to read status\n");
 			goto end;
 		}
 
 		if (!link->device->status.enabled) {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link disabled\n"));
+			acpi_handle_debug(handle, "Link disabled\n");
 			return 0;
 		}
 	}
@@ -253,22 +251,23 @@ static int acpi_pci_link_get_current(str
 	 * Query and parse _CRS to get the current IRQ assignment.
 	 */
 
-	status = acpi_walk_resources(link->device->handle, METHOD_NAME__CRS,
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
 				     acpi_pci_link_check_current, &irq);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _CRS"));
+		acpi_handle_warn(handle, "_CRS evaluation failed: %s\n",
+				 acpi_format_exception(status));
 		result = -ENODEV;
 		goto end;
 	}
 
 	if (acpi_strict && !irq) {
-		printk(KERN_ERR PREFIX "_CRS returned 0\n");
+		acpi_handle_err(handle, "_CRS returned 0\n");
 		result = -ENODEV;
 	}
 
 	link->irq.active = irq;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link at IRQ %d \n", link->irq.active));
+	acpi_handle_debug(handle, "Link at IRQ %d \n", link->irq.active);
 
       end:
 	return result;
@@ -276,13 +275,14 @@ static int acpi_pci_link_get_current(str
 
 static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 {
-	int result;
-	acpi_status status;
 	struct {
 		struct acpi_resource res;
 		struct acpi_resource end;
 	} *resource;
 	struct acpi_buffer buffer = { 0, NULL };
+	acpi_handle handle = link->device->handle;
+	acpi_status status;
+	int result;
 
 	if (!irq)
 		return -EINVAL;
@@ -329,7 +329,8 @@ static int acpi_pci_link_set(struct acpi
 		/* ignore resource_source, it's optional */
 		break;
 	default:
-		printk(KERN_ERR PREFIX "Invalid Resource_type %d\n", link->irq.resource_type);
+		acpi_handle_err(handle, "Invalid resource type %d\n",
+				link->irq.resource_type);
 		result = -EINVAL;
 		goto end;
 
@@ -342,7 +343,8 @@ static int acpi_pci_link_set(struct acpi
 
 	/* check for total failure */
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _SRS"));
+		acpi_handle_warn(handle, "_SRS evaluation failed: %s",
+				 acpi_format_exception(status));
 		result = -ENODEV;
 		goto end;
 	}
@@ -350,15 +352,11 @@ static int acpi_pci_link_set(struct acpi
 	/* Query _STA, set device->status */
 	result = acpi_bus_get_status(link->device);
 	if (result) {
-		printk(KERN_ERR PREFIX "Unable to read status\n");
+		acpi_handle_err(handle, "Unable to read status\n");
 		goto end;
 	}
-	if (!link->device->status.enabled) {
-		printk(KERN_WARNING PREFIX
-			      "%s [%s] disabled and referenced, BIOS bug\n",
-			      acpi_device_name(link->device),
-			      acpi_device_bid(link->device));
-	}
+	if (!link->device->status.enabled)
+		acpi_handle_warn(handle, "Disabled and referenced, BIOS bug\n");
 
 	/* Query _CRS, set link->irq.active */
 	result = acpi_pci_link_get_current(link);
@@ -375,14 +373,12 @@ static int acpi_pci_link_set(struct acpi
 		 * policy: when _CRS doesn't return what we just _SRS
 		 * assume _SRS worked and override _CRS value.
 		 */
-		printk(KERN_WARNING PREFIX
-			      "%s [%s] BIOS reported IRQ %d, using IRQ %d\n",
-			      acpi_device_name(link->device),
-			      acpi_device_bid(link->device), link->irq.active, irq);
+		acpi_handle_warn(handle, "BIOS reported IRQ %d, using IRQ %d\n",
+				 link->irq.active, irq);
 		link->irq.active = irq;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Set IRQ %d\n", link->irq.active));
+	acpi_handle_debug(handle, "Set IRQ %d\n", link->irq.active);
 
       end:
 	kfree(resource);
@@ -656,9 +652,7 @@ int acpi_pci_link_allocate_irq(acpi_hand
 		*polarity = link->irq.polarity;
 	if (name)
 		*name = acpi_device_bid(link->device);
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Link %s is referenced\n",
-			  acpi_device_bid(link->device)));
+	acpi_handle_debug(handle, "Link is referenced\n");
 	return link->irq.active;
 }
 
@@ -702,9 +696,7 @@ int acpi_pci_link_free_irq(acpi_handle h
 	 */
 	link->refcnt--;
 #endif
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Link %s is dereferenced\n",
-			  acpi_device_bid(link->device)));
+	acpi_handle_debug(handle, "Link is dereferenced\n");
 
 	if (link->refcnt == 0)
 		acpi_evaluate_object(link->device->handle, "_DIS", NULL, NULL);



