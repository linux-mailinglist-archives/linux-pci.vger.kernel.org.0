Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D446142E17A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 20:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhJNSmK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 14:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233976AbhJNSmJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 14:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634236804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJWeI237I8vJJhqiJWMB6c2JMjtxXJ/9AbonOkMBp6s=;
        b=D1qzBd4n1f8+DJOLhDhbn3Xlyem5cqOKOmzdTNzvWTuo0Il9pQ1GNeJ1tzUAtp8LfR7dYy
        XCBU50TMaOPC3wDKlDkogrwi4hLs0w+TnyOsuTGFMdERJ26+wlwQvaH1nlIfKsD+seHze2
        e5ch3WQorDK9yOHHb8eM3V3HAlJWrnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-3FPBGYrzPP2tjFPWdQCfmQ-1; Thu, 14 Oct 2021 14:40:02 -0400
X-MC-Unique: 3FPBGYrzPP2tjFPWdQCfmQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 373491006AA2;
        Thu, 14 Oct 2021 18:40:00 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C39A60583;
        Thu, 14 Oct 2021 18:39:57 +0000 (UTC)
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
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 2/2] x86/PCI/ACPI: Replace printk calls with pr_info/pr_warn calls
Date:   Thu, 14 Oct 2021 20:39:43 +0200
Message-Id: <20211014183943.27717-3-hdegoede@redhat.com>
In-Reply-To: <20211014183943.27717-1-hdegoede@redhat.com>
References: <20211014183943.27717-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The direct use of printk is deprecated, replace the printk calls
in arch/x86/pci/acpi.c with pr_info/pr_warn calls.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v5:
- Rebase on v5 of:
  "x86/PCI: Ignore E820 reservations for bridge windows on newer systems"
  and send it out as part of a series instead of as a stand-alone patch
- Add Rafael's Acked-by
---
 arch/x86/pci/acpi.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 72d473054262..f357dac92610 100644
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
@@ -186,8 +188,8 @@ void __init pci_acpi_crs_quirks(void)
 	else if (pci_probe & PCI_USE_E820)
 		pci_use_e820 = true;
 
-	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
-	       pci_use_e820 ? "Using" : "Ignoring");
+	pr_info("%s E820 reservations for host bridge windows\n",
+		pci_use_e820 ? "Using" : "Ignoring");
 }
 
 #ifdef	CONFIG_PCI_MMCONFIG
@@ -362,9 +364,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		root->segment = domain = 0;
 
 	if (domain && !pci_domains_supported) {
-		printk(KERN_WARNING "pci_bus %04x:%02x: "
-		       "ignored (multiple domains not supported)\n",
-		       domain, busnum);
+		pr_warn("pci_bus %04x:%02x: ignored (multiple domains not supported)\n",
+			domain, busnum);
 		return NULL;
 	}
 
@@ -432,7 +433,7 @@ int __init pci_acpi_init(void)
 	if (acpi_noirq)
 		return -ENODEV;
 
-	printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
+	pr_info("Using ACPI for IRQ routing\n");
 	acpi_irq_penalty_init();
 	pcibios_enable_irq = acpi_pci_irq_enable;
 	pcibios_disable_irq = acpi_pci_irq_disable;
@@ -444,7 +445,7 @@ int __init pci_acpi_init(void)
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

