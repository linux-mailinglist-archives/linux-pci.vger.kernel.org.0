Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46034B8BF7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Feb 2022 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiBPPCU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Feb 2022 10:02:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiBPPCU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 10:02:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 033A225D7
        for <linux-pci@vger.kernel.org>; Wed, 16 Feb 2022 07:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645023727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+nm87YpVQyYQx/nBav8k08YPbJjNF9pgzQUjlbc+NM=;
        b=Bi5YyKmOhGt+C4yys3ZlwKrq38Qpw60JL34cC/ox4er+iEm/XMCjvGJDYPY/mWQmc9eqa6
        oIS6yCWgPdHgi/w2TR3KzcExNOIP6Yoi+QV14nC1+Ga0cf+dvtKZARw4yGiZ034UduPnlh
        0zNUDcsyfBTZ6nAjx/IWKJPJEQSZ3po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-CYNmtKA0NJek_ds8aGNsjg-1; Wed, 16 Feb 2022 10:01:59 -0500
X-MC-Unique: CYNmtKA0NJek_ds8aGNsjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FF1F189DF41;
        Wed, 16 Feb 2022 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E979F6E216;
        Wed, 16 Feb 2022 15:01:48 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/PCI: Disable exclusion of E820 reserved addresses in some cases
Date:   Wed, 16 Feb 2022 16:01:21 +0100
Message-Id: <20220216150121.9400-2-hdegoede@redhat.com>
In-Reply-To: <20220216150121.9400-1-hdegoede@redhat.com>
References: <20220216150121.9400-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some fw has a bug where the PCI bridge window returned by the ACPI
resources partly overlaps with some other address range, causing issues.
To workaround this Linux excludes E820 reserved addresses when allocating
addresses from the PCI bridge window. 2 known examples of such fw bugs are:

1. The returned window contains addresses which map to system RAM,
see commit 4dc2287c1805 ("x86: avoid E820 regions when allocating
address space").

2. The Lenovo X1 carbon gen 2 BIOS has an overlap between an EFI/E820
reserved range and the ACPI provided PCI bridge window:
 efi: mem46: [MMIO] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
 BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
 pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
If Linux assigns the overlapping 0xdfa00000-0xdfa0ffff range to a PCI BAR
then the system fails to resume after a suspend.

Recently (2019) some systems have shown-up with EFI memmap MMIO entries
covering the entire ACPI provided PCI bridge window. These memmap entries
get converted into e820_table entries, causing all attempts to assign
memory to PCI BARs which have not been setup by the BIOS to fail.
For example see these dmesg snippets from a Lenovo IdeaPad 3 15IIL 81WE:
 efi: mem63: [MMIO] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)
 BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
 pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
 pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
 pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]

To fix this, check if the ACPI provided PCI bridge window is fully
contained within in EFI memmap MMIO region and in that case disable
the "exclude E820 reserved addresses" workaround, fixing the problem
of not being able to find free space for unassigned BARs.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2029207
BugLink: https://bugs.launchpad.net/bugs/1878279
BugLink: https://bugs.launchpad.net/bugs/1931715
BugLink: https://bugs.launchpad.net/bugs/1932069
BugLink: https://bugs.launchpad.net/bugs/1921649
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/include/asm/pci_x86.h |  8 +++++
 arch/x86/kernel/resource.c     |  4 +++
 arch/x86/pci/acpi.c            | 65 +++++++++++++++++++++++++++++++++-
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 490411dba438..997379b022ee 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -64,6 +64,8 @@ void pcibios_scan_specific_bus(int busn);
 
 /* pci-irq.c */
 
+struct pci_dev;
+
 struct irq_info {
 	u8 bus, devfn;			/* Bus, device and function */
 	struct {
@@ -232,3 +234,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
 # define x86_default_pci_init_irq	NULL
 # define x86_default_pci_fixup_irqs	NULL
 #endif
+
+#if defined CONFIG_PCI && defined CONFIG_ACPI
+extern bool pci_use_e820;
+#else
+#define pci_use_e820 true
+#endif
diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index 9b9fb7882c20..e8dc9bc327bd 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/ioport.h>
 #include <asm/e820/api.h>
+#include <asm/pci_x86.h>
 
 static void resource_clip(struct resource *res, resource_size_t start,
 			  resource_size_t end)
@@ -28,6 +29,9 @@ static void remove_e820_regions(struct resource *avail)
 	int i;
 	struct e820_entry *entry;
 
+	if (!pci_use_e820)
+		return;
+
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		entry = &e820_table->entries[i];
 
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 052f1d78a562..e4617df661a9 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/init.h>
@@ -21,6 +22,7 @@ struct pci_root_info {
 
 static bool pci_use_crs = true;
 static bool pci_ignore_seg;
+bool pci_use_e820 = true;
 
 static int __init set_use_crs(const struct dmi_system_id *id)
 {
@@ -291,6 +293,60 @@ static bool resource_is_pcicfg_ioport(struct resource *res)
 		res->start == 0xCF8 && res->end == 0xCFF;
 }
 
+/*
+ * Some fw has a bug where the PCI bridge window returned by the ACPI resources
+ * partly overlaps with some other address range, causing issues. To workaround
+ * this Linux excludes E820 reserved addresses when allocating addresses from
+ * the PCI bridge window. 2 known examples of such firmware bugs are:
+ *
+ * 1. The returned window contains addresses which map to system RAM, see
+ * commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address space").
+ *
+ * 2. The Lenovo X1 carbon gen 2 BIOS has an overlap between an EFI/E820
+ * reserved range and the ACPI provided PCI bridge window:
+ *  efi: mem46: [MMIO] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
+ *  BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
+ *  pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
+ * If Linux assigns the overlapping 0xdfa00000-0xdfa0ffff range to a PCI BAR
+ * then the system fails to resume after a suspend.
+ *
+ * Recently (2019) some systems have shown-up with EFI memmap MMIO entries
+ * covering the entire ACPI provided PCI bridge window. These memmap entries
+ * get converted into e820_table entries, causing all attempts to assign
+ * memory to PCI BARs which have not been setup by the BIOS to fail.
+ * For example see these dmesg snippets from a Lenovo IdeaPad 3 15IIL 81WE:
+ *  efi: mem63: [MMIO] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)
+ *  BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
+ *  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
+ *  pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
+ *  pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
+ *
+ * To code below checks if the ACPI provided PCI bridge window is fully
+ * contained within in EFI memmap MMIO region and in that case disables
+ * the "exclude E820 reserved addresses" workaround to avoid this issue.
+ */
+static bool resource_is_efi_mmio_region(const struct resource *res)
+{
+	unsigned long long start, end;
+	efi_memory_desc_t *md;
+
+	if (!efi_enabled(EFI_MEMMAP))
+		return false;
+
+	for_each_efi_memory_desc(md) {
+		if (md->type != EFI_MEMORY_MAPPED_IO)
+			continue;
+
+		start = md->phys_addr;
+		end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+
+		if (res->start >= start && res->end <= end)
+			return true;
+	}
+
+	return false;
+}
+
 static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 {
 	struct acpi_device *device = ci->bridge;
@@ -300,9 +356,16 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 
 	status = acpi_pci_probe_root_resources(ci);
 	if (pci_use_crs) {
-		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
+		resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
 			if (resource_is_pcicfg_ioport(entry->res))
 				resource_list_destroy_entry(entry);
+			if (resource_is_efi_mmio_region(entry->res)) {
+				dev_info(&device->dev,
+					"host bridge window %pR is marked by EFI as MMIO\n",
+					entry->res);
+				pci_use_e820 = false;
+			}
+		}
 		return status;
 	}
 
-- 
2.33.1

