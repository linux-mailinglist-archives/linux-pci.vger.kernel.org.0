Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA815B3F29
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 20:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIIS7S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiIIS7Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 14:59:16 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Sep 2022 11:59:14 PDT
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4893A134C25
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 11:59:13 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 30323 invoked from network); 9 Sep 2022 20:52:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1662749551; bh=rhc+jh270C6y48dYxDcsrTYB2Su6SjfOeGKqnqcbuxM=;
          h=From:To:Cc:Subject;
          b=EcMbmoAfRb0BLxxLWXTvPuBPCFAcDSLnwUK9esK3ofezJyq5X4mf7l40X6QBtA0eG
           jRr8r0IZggaIw4u56Cbx7wDxg77rZWkUpbM2n6pcB22niYgcZQEH+Y9Fxri2tUA7af
           +v3BAwqW3OOt0y2/6B9oCPDIptGcaZzjdq0b7EhQ=
Received: from aafh243.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.243])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 9 Sep 2022 20:52:30 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@suse.de>
Subject: [PATCH] acpi,pci: handle duplicate IRQ routing entries returned from _PRT
Date:   Fri,  9 Sep 2022 20:51:52 +0200
Message-Id: <20220909185152.1102948-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 81955f944ecd7771366ceed4b99a02a3
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [AXMU]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On some platforms, the ACPI _PRT function returns duplicate interrupt
routing entries. Linux uses the first matching entry, but sometimes the
second matching entry contains the correct interrupt vector.

This happens on a Dell Latitude E6500 laptop with the i2c-i801 Intel
SMBus controller. This controller was nonfunctional unless its interrupt
usage was disabled (using the "disable_features=0x10" module parameter).

After investigation, it turned out that the driver was using an
incorrect interrupt vector: in lspci output for this device there was:
        Interrupt: pin B routed to IRQ 19
but after running i2cdetect (without using any i2c-i801 module
parameters) the following was logged to dmesg:

        [...]
        [  132.248657] i801_smbus 0000:00:1f.3: Timeout waiting for interrupt!
        [  132.248669] i801_smbus 0000:00:1f.3: Transaction timeout
        [  132.452649] i801_smbus 0000:00:1f.3: Timeout waiting for interrupt!
        [  132.452662] i801_smbus 0000:00:1f.3: Transaction timeout
        [  132.467682] irq 17: nobody cared (try booting with the "irqpoll" option)

The existence of duplicate entries returned from _PRT was confirmed in
the ACPI DSTD table, which contains:

	Name (API0, Package (0x1D)
	{
		Package (0x04)
		{
		0x001FFFFF,
		0x01,
		0x00,
		0x13
		},

		Package (0x04)
		{
		0x001FFFFF,
		0x00,
		0x00,
		0x10
		},

		Package (0x04)
		{
		0x001FFFFF,
		0x01,
		0x00,
		0x11
		},

		[...]
	})
	Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
	{
		Local0 = API0 /* \_SB_.PCI0.API0 */
		If (!GPIC)
		{
		Local0 = PIC0 /* \_SB_.PCI0.PIC0 */
		}

		Return (Local0)
	}

Linux used the first matching entry, which was incorrect. In order not
to disrupt existing systems, use the first matching entry unless the
pci=prtlast kernel parameter is used or a Dell Latitude E6500 laptop is
detected.

Disclaimer: there is nothing really interesting connected to the SMBus
controller on this laptop, but this change may help other systems.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++
 drivers/acpi/pci_irq.c                        | 89 ++++++++++++++++++-
 drivers/pci/pci.c                             |  9 ++
 3 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 426fa892d311..2ff351db10b8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4190,6 +4190,14 @@
 				bridge windows. This is the default on modern
 				hardware. If you need to use this, please report
 				a bug to <linux-pci@vger.kernel.org>.
+		prtlast		If the _PRT ACPI method returns duplicate
+				IRQ routing entries, use the last matching entry
+				for a given device. If the platform may be
+				affected by this problem, an error message is
+				printed to dmesg - this parameter is
+				ineffective otherwise. If you need to use this,
+				please report a bug to
+				<linux-pci@vger.kernel.org>.
 		routeirq	Do IRQ routing for all PCI devices.
 				This is normally done in pci_enable_device(),
 				so this option is a temporary workaround
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 08e15774fb9f..5cead840de0b 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -196,12 +196,73 @@ static int acpi_pci_irq_check_entry(acpi_handle handle, struct pci_dev *dev,
 	return 0;
 }
 
+extern bool pci_prtlast;
+
+static const struct dmi_system_id pci_prtlast_dmi[] = {
+	{
+		.ident = "Dell Latitude E6500",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude E6500"),
+		},
+	},
+	{ }
+};
+
+static bool acpi_pci_prt_use_last(struct acpi_prt_entry *curr,
+				  const char *current_source,
+				  const char *previous_match_source,
+				  int previous_match_index)
+{
+	bool ret;
+	const struct dmi_system_id *id;
+	const int msg_bufsize = 512;
+	char *msg = kmalloc(msg_bufsize, GFP_KERNEL);
+
+	if (!msg)
+		return false;
+
+	snprintf(msg, msg_bufsize,
+		 FW_BUG
+		 "ACPI _PRT returned duplicate IRQ routing entries for PCI device "
+		 "%04x:%02x:%02x[INT%c]: %s[%d] and %s[%d]. ",
+		 curr->id.segment, curr->id.bus, curr->id.device,
+		 pin_name(curr->pin),
+		 previous_match_source, previous_match_index,
+		 current_source, curr->index);
+
+	id = dmi_first_match(pci_prtlast_dmi);
+
+	if (id) {
+		pr_warn("%s%s detected, using last entry.\n",
+			msg, id->ident);
+
+		ret = true;
+	} else if (pci_prtlast) {
+		pr_err(
+"%sUsing last entry, as directed on the command line. If this helps, report a bug.\n",
+		       msg);
+
+		ret = true;
+	} else {
+		pr_err("%sIf necessary, use \"pci=prtlast\" and report a bug.\n",
+		       msg);
+
+		ret = false;
+	}
+
+	kfree(msg);
+	return ret;
+}
+
 static int acpi_pci_irq_find_prt_entry(struct pci_dev *dev,
-			  int pin, struct acpi_prt_entry **entry_ptr)
+			  int pin, struct acpi_prt_entry **entry_ptr_out)
 {
 	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_pci_routing_table *entry;
+	struct acpi_prt_entry *match = NULL;
+	const char *match_source = NULL;
 	acpi_handle handle = NULL;
 
 	if (dev->bus->bridge)
@@ -219,13 +280,33 @@ static int acpi_pci_irq_find_prt_entry(struct pci_dev *dev,
 
 	entry = buffer.pointer;
 	while (entry && (entry->length > 0)) {
-		if (!acpi_pci_irq_check_entry(handle, dev, pin,
-						 entry, entry_ptr))
-			break;
+		struct acpi_prt_entry *curr;
+
+		if (!acpi_pci_irq_check_entry(handle, dev, pin, entry, &curr)) {
+			if (!match) {
+				// first match
+				match = curr;
+				match_source = entry->source;
+			} else if (!acpi_pci_prt_use_last(curr,
+							  entry->source,
+							  match_source,
+							  match->index)) {
+				// duplicates found, use first entry
+				kfree(curr);
+			} else {
+				// duplicates found, use last entry
+				kfree(match);
+				match = curr;
+				match_source = entry->source;
+			}
+		}
+
 		entry = (struct acpi_pci_routing_table *)
 		    ((unsigned long)entry + entry->length);
 	}
 
+	*entry_ptr_out = match;
+
 	kfree(buffer.pointer);
 	return 0;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..a14a2e4e4197 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -155,6 +155,11 @@ static bool pci_bridge_d3_disable;
 /* Force bridge_d3 for all PCIe ports */
 static bool pci_bridge_d3_force;
 
+#ifdef CONFIG_ACPI
+/* Use the last matching entry from the table returned by the _PRT ACPI method. */
+bool pci_prtlast;
+#endif
+
 static int __init pcie_port_pm_setup(char *str)
 {
 	if (!strcmp(str, "off"))
@@ -6896,6 +6901,10 @@ static int __init pci_setup(char *str)
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
+#ifdef CONFIG_ACPI
+			} else if (!strncmp(str, "prtlast", 7)) {
+				pci_prtlast = true;
+#endif
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}

base-commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
-- 
2.25.1

