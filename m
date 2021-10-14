Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D93442DE6F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 17:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhJNPm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 11:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230241AbhJNPm7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 11:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634226054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9JDac1wEp+fYRfH6OmAxrcNM4fsNcB/PjA/kFxBK8FY=;
        b=S1KWmS3k42FTbizjNI7CHnDNyvWcLGNNj5/T1affZR6+3n/qHUWz83QD+Qfk4FU1UryZAm
        bj3Xf8YhSsBk1Tc5efKhDjY7EGVvGVRpHiszL/E6mTD6AfdRskVu41HLdZY3ARgeelsFtR
        WeGaYlW3HVf5yhp/h4WUOqTAbGhuawM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-nLrb-TXrOxS8o9kFSgxOzw-1; Thu, 14 Oct 2021 11:40:51 -0400
X-MC-Unique: nLrb-TXrOxS8o9kFSgxOzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1886F10A8E00;
        Thu, 14 Oct 2021 15:40:49 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C73960657;
        Thu, 14 Oct 2021 15:40:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/PCI/ACPI: Replace printk calls with pr_info/pr_warn calls
Date:   Thu, 14 Oct 2021 17:40:32 +0200
Message-Id: <20211014154032.10103-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The direct use of printk is deprecated, replace the printk calls
in arch/x86/pci/acpi.c with pr_info/pr_warn calls.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note this applies on top of my:
"x86/PCI: Ignore E820 reservations for bridge windows on newer systems"
patch and was requested by several people during review of that patch.
---
 arch/x86/pci/acpi.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 4537e3561c91..98fbdf4fa698 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "PCI: " fmt
+
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/init.h>
@@ -38,7 +41,7 @@ static int __init set_nouse_crs(const struct dmi_system_id *id)
 
 static int __init set_ignore_seg(const struct dmi_system_id *id)
 {
-	printk(KERN_INFO "PCI: %s detected: ignoring ACPI _SEG\n", id->ident);
+	pr_info("%s detected: ignoring ACPI _SEG\n", id->ident);
 	pci_ignore_seg = true;
 	return 0;
 }
@@ -158,10 +161,9 @@ void __init pci_acpi_crs_quirks(void)
 	else if (pci_probe & PCI_USE__CRS)
 		pci_use_crs = true;
 
-	printk(KERN_INFO "PCI: %s host bridge windows from ACPI; "
-	       "if necessary, use \"pci=%s\" and report a bug\n",
-	       pci_use_crs ? "Using" : "Ignoring",
-	       pci_use_crs ? "nocrs" : "use_crs");
+	pr_info("%s host bridge windows from ACPI; if necessary, use \"pci=%s\" and report a bug\n",
+		pci_use_crs ? "Using" : "Ignoring",
+		pci_use_crs ? "nocrs" : "use_crs");
 
 	/*
 	 * Some BIOS-es contain a bug where they add addresses which map to
@@ -189,8 +191,8 @@ void __init pci_acpi_crs_quirks(void)
 	else if (pci_probe & PCI_USE_E820)
 		pci_use_e820 = true;
 
-	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
-	       pci_use_e820 ? "Honoring" : "Ignoring");
+	pr_info("%s E820 reservations for host bridge windows\n",
+		pci_use_e820 ? "Honoring" : "Ignoring");
 }
 
 #ifdef	CONFIG_PCI_MMCONFIG
@@ -365,9 +367,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		root->segment = domain = 0;
 
 	if (domain && !pci_domains_supported) {
-		printk(KERN_WARNING "pci_bus %04x:%02x: "
-		       "ignored (multiple domains not supported)\n",
-		       domain, busnum);
+		pr_warn("pci_bus %04x:%02x: ignored (multiple domains not supported)\n",
+			domain, busnum);
 		return NULL;
 	}
 
@@ -435,7 +436,7 @@ int __init pci_acpi_init(void)
 	if (acpi_noirq)
 		return -ENODEV;
 
-	printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
+	pr_info("Using ACPI for IRQ routing\n");
 	acpi_irq_penalty_init();
 	pcibios_enable_irq = acpi_pci_irq_enable;
 	pcibios_disable_irq = acpi_pci_irq_disable;
@@ -447,7 +448,7 @@ int __init pci_acpi_init(void)
 		 * also do it here in case there are still broken drivers that
 		 * don't use pci_enable_device().
 		 */
-		printk(KERN_INFO "PCI: Routing PCI interrupts for all devices because \"pci=routeirq\" specified\n");
+		pr_info("Routing PCI interrupts for all devices because \"pci=routeirq\" specified\n");
 		for_each_pci_dev(dev)
 			acpi_pci_irq_enable(dev);
 	}
-- 
2.31.1

