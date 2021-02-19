Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30131FEC1
	for <lists+linux-pci@lfdr.de>; Fri, 19 Feb 2021 19:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBSSZm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Feb 2021 13:25:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55476 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhBSSZk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Feb 2021 13:25:40 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id 3f2ee5d30b85ca5d; Fri, 19 Feb 2021 19:18:17 +0100
Received: from kreacher.localnet (89-64-81-29.dynamic.chello.pl [89.64.81.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3CB16661E07;
        Fri, 19 Feb 2021 19:18:17 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v1 1/4] ACPI: PCI: IRQ: Consolidate printing diagnostic messages
Date:   Fri, 19 Feb 2021 19:15:27 +0100
Message-ID: <2764129.qbnaYOMr8f@kreacher>
In-Reply-To: <4822757.tvZ08WQ2Gl@kreacher>
References: <4822757.tvZ08WQ2Gl@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgleehfffhtefflefhleetjeffteettefgteekjedvhfeffedtueefveegveeiveenucfkphepkeelrdeigedrkedurddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrvdelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehguhhohhgrnhhjuhhnsehhuhgrfigvihdrtgho
 mh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The code in pci_irq.c prints diagnostic messages using different
and inconsistent methods.  The majority of them are printed with
the help of the dev_*() familiy of logging functions, but
ACPI_DEBUG_PRINT() and ACPI_DEBUG_PRINT_RAW() are still used in
some places which requires the ACPICA debug to be enabled
additionally which is a nuisance and one message is printed
using the raw printk().

To consolidate the printing of messages in that code, convert all of
the ACPI_DEBUG_PRINT() instances in it into dev_dbg(), which is
consistent with the way the other messages are printed by it,
replace the only ACPI_DEBUG_PRINT_RAW() instance with pr_debug() and
make it use pr_warn() istead of printk(KERN_WARNING ).

Also add a pr_fmt() definition to that file and drop the
_COMPONENT and ACPI_MODULE_NAME() definitions that are not used
any more after the above changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_irq.c |   34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

Index: linux-pm/drivers/acpi/pci_irq.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_irq.c
+++ linux-pm/drivers/acpi/pci_irq.c
@@ -9,6 +9,7 @@
  *	Bjorn Helgaas <bjorn.helgaas@hp.com>
  */
 
+#define pr_fmt(fmt) "ACPI: PCI: " fmt
 
 #include <linux/dmi.h>
 #include <linux/kernel.h>
@@ -22,11 +23,6 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 
-#define PREFIX "ACPI: "
-
-#define _COMPONENT		ACPI_PCI_COMPONENT
-ACPI_MODULE_NAME("pci_irq");
-
 struct acpi_prt_entry {
 	struct acpi_pci_id	id;
 	u8			pin;
@@ -126,7 +122,7 @@ static void do_prt_fixups(struct acpi_pr
 		    entry->pin == quirk->pin &&
 		    !strcmp(prt->source, quirk->source) &&
 		    strlen(prt->source) >= strlen(quirk->actual_source)) {
-			printk(KERN_WARNING PREFIX "firmware reports "
+			pr_warn("Firmware reports "
 				"%04x:%02x:%02x PCI INT %c connected to %s; "
 				"changing to %s\n",
 				entry->id.segment, entry->id.bus,
@@ -191,12 +187,9 @@ static int acpi_pci_irq_check_entry(acpi
 	 * the IRQ value, which is hardwired to specific interrupt inputs on
 	 * the interrupt controller.
 	 */
-
-	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INFO,
-			      "      %04x:%02x:%02x[%c] -> %s[%d]\n",
-			      entry->id.segment, entry->id.bus,
-			      entry->id.device, pin_name(entry->pin),
-			      prt->source, entry->index));
+	pr_debug("%04x:%02x:%02x[%c] -> %s[%d]\n",
+		 entry->id.segment, entry->id.bus, entry->id.device,
+		 pin_name(entry->pin), prt->source, entry->index);
 
 	*entry_ptr = entry;
 
@@ -307,8 +300,7 @@ static struct acpi_prt_entry *acpi_pci_i
 #ifdef CONFIG_X86_IO_APIC
 		acpi_reroute_boot_interrupt(dev, entry);
 #endif /* CONFIG_X86_IO_APIC */
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %s[%c] _PRT entry\n",
-				  pci_name(dev), pin_name(pin)));
+		dev_dbg(&dev->dev, "Found [%c] _PRT entry\n", pin_name(pin));
 		return entry;
 	}
 
@@ -324,9 +316,7 @@ static struct acpi_prt_entry *acpi_pci_i
 			/* PC card has the same IRQ as its cardbridge */
 			bridge_pin = bridge->pin;
 			if (!bridge_pin) {
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "No interrupt pin configured for device %s\n",
-						  pci_name(bridge)));
+				dev_dbg(&bridge->dev, "No interrupt pin configured\n");
 				return NULL;
 			}
 			pin = bridge_pin;
@@ -334,10 +324,8 @@ static struct acpi_prt_entry *acpi_pci_i
 
 		ret = acpi_pci_irq_find_prt_entry(bridge, pin, &entry);
 		if (!ret && entry) {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					 "Derived GSI for %s INT %c from %s\n",
-					 pci_name(dev), pin_name(orig_pin),
-					 pci_name(bridge)));
+			dev_dbg(&dev->dev, "Derived GSI INT %c from %s\n",
+				pin_name(orig_pin), pci_name(bridge));
 			return entry;
 		}
 
@@ -413,9 +401,7 @@ int acpi_pci_irq_enable(struct pci_dev *
 
 	pin = dev->pin;
 	if (!pin) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "No interrupt pin configured for device %s\n",
-				  pci_name(dev)));
+		dev_dbg(&dev->dev, "No interrupt pin configured\n");
 		return 0;
 	}
 



