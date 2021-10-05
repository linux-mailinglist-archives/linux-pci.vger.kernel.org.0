Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC50C422BEA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 17:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhJEPMF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 11:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbhJEPME (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 11:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633446613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0OwdoLnukRcDnr5f8N5G60U0CJNS0NMG5GG625pv56Q=;
        b=CzujdKegaUBzW4gBw1Z4Gb8HR6RJLnpMNHHaaL1uGIc+xPcMDKAdo6OUxrfIaqpQtFS15L
        yUbNXXYH2RievnFisXEG+GylNrdWvJnr53ZztBFvHf4Q26lmjQP+gVLUkb8I0Zu6smKFJ/
        xfMDZybsCjhZAvytHE2at8X9rnKUu/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-bOPZ7l1HMP6aCh_QyAcvyQ-1; Tue, 05 Oct 2021 11:10:12 -0400
X-MC-Unique: bOPZ7l1HMP6aCh_QyAcvyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 541491922962;
        Tue,  5 Oct 2021 15:10:11 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 985B160C81;
        Tue,  5 Oct 2021 15:09:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/PCI: Add pci=no_e820 cmdline option to ignore E820 reservations for bridge windows
Date:   Tue,  5 Oct 2021 17:09:56 +0200
Message-Id: <20211005150956.303707-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some BIOS-es contain a bug where they add addresses which map to system RAM
in the PCI bridge memory window returned by the ACPI _CRS method, see
commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
space").

To avoid this Linux by default excludes E820 reservations when allocating
addresses since 2010. Windows however ignores E820 reserved regions for PCI
mem allocations, instead it avoids these BIOS bugs by allocates addresses
top-down.

Recently (2020) some systems have shown-up with E820 reservations which
cover the entire _CRS returned PCI bridge memory window, causing all
attempts to assign memory to PCI bars which have not been setup by the BIOS
to fail. For example here are the relevant dmesg bits from a
Lenovo IdeaPad 3 15IIL 81WE:

[    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
[    0.557473] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]

Add a pci=no_e820 option which allows disabling the E820 reservations
check, while still honoring the _CRS provided resources.

And automatically enable this on the "Lenovo IdeaPad 3 15IIL05" to fix
the touchpad not working on this laptop.

Also add a pci=use_e820 option to allow overruling the results of
DMI quirks defaulting to no_e820 on some systems.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
BugLink: https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1878279
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/include/asm/pci_x86.h | 10 ++++++++++
 arch/x86/kernel/resource.c     | 17 +++++++++++++++++
 arch/x86/pci/acpi.c            | 26 ++++++++++++++++++++++++++
 arch/x86/pci/common.c          |  6 ++++++
 4 files changed, 59 insertions(+)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 490411dba438..e45d661f81de 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -39,6 +39,8 @@ do {						\
 #define PCI_ROOT_NO_CRS		0x100000
 #define PCI_NOASSIGN_BARS	0x200000
 #define PCI_BIG_ROOT_WINDOW	0x400000
+#define PCI_USE_E820		0x800000
+#define PCI_NO_E820		0x1000000
 
 extern unsigned int pci_probe;
 extern unsigned long pirq_table_addr;
@@ -64,6 +66,8 @@ void pcibios_scan_specific_bus(int busn);
 
 /* pci-irq.c */
 
+struct pci_dev;
+
 struct irq_info {
 	u8 bus, devfn;			/* Bus, device and function */
 	struct {
@@ -232,3 +236,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
 # define x86_default_pci_init_irq	NULL
 # define x86_default_pci_fixup_irqs	NULL
 #endif
+
+#if defined CONFIG_PCI && defined CONFIG_ACPI
+extern bool pci_use_e820;
+#else
+#define pci_use_e820 false
+#endif
diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index 9b9fb7882c20..6069d86021f0 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/ioport.h>
 #include <asm/e820/api.h>
+#include <asm/pci_x86.h>
 
 static void resource_clip(struct resource *res, resource_size_t start,
 			  resource_size_t end)
@@ -23,11 +24,27 @@ static void resource_clip(struct resource *res, resource_size_t start,
 		res->start = end + 1;
 }
 
+/*
+ * Some BIOS-es contain a bug where they add addresses which map to system RAM
+ * in the PCI bridge memory window returned by the ACPI _CRS method, see
+ * commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address space").
+ * To avoid this Linux by default excludes E820 reservations when allocating
+ * addresses since 2010. Windows however ignores E820 reserved regions for PCI
+ * mem allocations, instead it avoids these BIOS bugs by allocates addresses
+ * top-down.
+ * Recently (2020) some systems have shown-up with E820 reservations which
+ * cover the entire _CRS returned PCI bridge memory window, causing all
+ * attempts to assign memory to PCI bars which have not been setup by the BIOS
+ * to fail. The pci_use_e820 check is there as a workaround for these systems.
+ */
 static void remove_e820_regions(struct resource *avail)
 {
 	int i;
 	struct e820_entry *entry;
 
+	if (!pci_use_e820)
+		return;
+
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		entry = &e820_table->entries[i];
 
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 948656069cdd..4fc95f5308e3 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -21,6 +21,8 @@ struct pci_root_info {
 
 static bool pci_use_crs = true;
 static bool pci_ignore_seg = false;
+/* Consumed in arch/x86/kernel/resource.c */
+bool pci_use_e820 = true;
 
 static int __init set_use_crs(const struct dmi_system_id *id)
 {
@@ -34,6 +36,12 @@ static int __init set_nouse_crs(const struct dmi_system_id *id)
 	return 0;
 }
 
+static int __init set_no_e820(const struct dmi_system_id *id)
+{
+	pci_use_e820 = false;
+	return 0;
+}
+
 static int __init set_ignore_seg(const struct dmi_system_id *id)
 {
 	printk(KERN_INFO "PCI: %s detected: ignoring ACPI _SEG\n", id->ident);
@@ -135,6 +143,16 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP xw9300 Workstation"),
 		},
 	},
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1868899 */
+	{
+		.callback = set_no_e820,
+		.ident = "Lenovo IdeaPad 3 15IIL05",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "81WE"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad 3 15IIL05"),
+		},
+	},
 	{}
 };
 
@@ -160,6 +178,14 @@ void __init pci_acpi_crs_quirks(void)
 	       "if necessary, use \"pci=%s\" and report a bug\n",
 	       pci_use_crs ? "Using" : "Ignoring",
 	       pci_use_crs ? "nocrs" : "use_crs");
+
+	if (pci_probe & PCI_NO_E820)
+		pci_use_e820 = false;
+	else if (pci_probe & PCI_USE_E820)
+		pci_use_e820 = true;
+
+	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
+	       pci_use_e820 ? "Honoring" : "Ignoring");
 }
 
 #ifdef	CONFIG_PCI_MMCONFIG
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 3507f456fcd0..091ec7e94fcb 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -595,6 +595,12 @@ char *__init pcibios_setup(char *str)
 	} else if (!strcmp(str, "nocrs")) {
 		pci_probe |= PCI_ROOT_NO_CRS;
 		return NULL;
+	} else if (!strcmp(str, "use_e820")) {
+		pci_probe |= PCI_USE_E820;
+		return NULL;
+	} else if (!strcmp(str, "no_e820")) {
+		pci_probe |= PCI_NO_E820;
+		return NULL;
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 	} else if (!strcmp(str, "big_root_window")) {
 		pci_probe |= PCI_BIG_ROOT_WINDOW;
-- 
2.31.1

