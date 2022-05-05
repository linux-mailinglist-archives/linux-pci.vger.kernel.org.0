Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C6551C3BD
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 17:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381306AbiEEPYc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381303AbiEEPYb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 11:24:31 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A3E3562E6
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651764050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWxWKOjA+mrwfwmaVyLWfuQsGzTpskPFIs1iDrrl94A=;
        b=XOB9k3vP2pk2CapQ9a8hKyb8eqnKHdQCypXcqXaqWtpoi6tjDlKqotX+ZJmAhN8TGIeJ0m
        htgsNoLEKiis78vJ9FwCPN/fAfU15D3BLkZBk+u9aNOLq4xXlV+jNZi7fWRK6eXpdw19m1
        +DUM4899xyHIkZMbFZ5E8N78nk50SKA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-v-yKP7oTPuCZfFLQz7DH1Q-1; Thu, 05 May 2022 11:20:45 -0400
X-MC-Unique: v-yKP7oTPuCZfFLQz7DH1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9F39804189;
        Thu,  5 May 2022 15:20:44 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4B7E7B64;
        Thu,  5 May 2022 15:20:40 +0000 (UTC)
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
Subject: [PATCH v7 1/1] x86/PCI: Ignore E820 reservations for bridge windows on newer systems
Date:   Thu,  5 May 2022 17:20:16 +0200
Message-Id: <20220505152016.5059-2-hdegoede@redhat.com>
In-Reply-To: <20220505152016.5059-1-hdegoede@redhat.com>
References: <20220505152016.5059-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some BIOS-es contain bugs where they add addresses which are already
used in some other manner to the PCI host bridge window returned by
the ACPI _CRS method. To avoid this Linux by default excludes
E820 reservations when allocating addresses since 2010, see:
commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
space").

Recently (2019) some systems have shown-up with E820 reservations which
cover the entire _CRS returned PCI bridge memory window, causing all
attempts to assign memory to PCI BARs which have not been setup by the
BIOS to fail. For example here are the relevant dmesg bits from a
Lenovo IdeaPad 3 15IIL 81WE:

 [mem 0x000000004bc50000-0x00000000cfffffff] reserved
 pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]

The ACPI specifications appear to allow this new behavior:

The relationship between E820 and ACPI _CRS is not really very clear.
ACPI v6.3, sec 15, table 15-374, says AddressRangeReserved means:

  This range of addresses is in use or reserved by the system and is
  not to be included in the allocatable memory pool of the operating
  system's memory manager.

and it may be used when:

  The address range is in use by a memory-mapped system device.

Furthermore, sec 15.2 says:

  Address ranges defined for baseboard memory-mapped I/O devices, such
  as APICs, are returned as reserved.

A PCI host bridge qualifies as a baseboard memory-mapped I/O device,
and its apertures are in use and certainly should not be included in
the general allocatable pool, so the fact that some BIOS-es reports
the PCI aperture as "reserved" in E820 doesn't seem like a BIOS bug.

So it seems that the excluding of E820 reserved addresses is a mistake.

Ideally Linux would fully stop excluding E820 reserved addresses,
but then various old systems will regress.
Instead keep the old behavior for old systems, while ignoring
the E820 reservations for any systems from now on.

Old systems are defined here as BIOS year < 2018, this was chosen to
make sure that pci_use_e820 will not be set on the currently affected
systems, the oldest known one is from 2019.

Testing has shown that some newer systems also have a bad _CRS return.
The pci_crs_quirks DMI table is used to keep excluding E820 reservations
from the bridge window on these systems.

Also add pci=no_e820 and pci=use_e820 options to allow overriding
the BIOS year + DMI matching logic.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
BugLink: https://bugs.launchpad.net/bugs/1878279
BugLink: https://bugs.launchpad.net/bugs/1931715
BugLink: https://bugs.launchpad.net/bugs/1932069
BugLink: https://bugs.launchpad.net/bugs/1921649
Cc: Benoit Grégoire <benoitg@coeus.ca>
Cc: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v7:
- Re-add the pci=use_e820 and pci=no_e820 kernel cmdline options since it
  turns out that some newer laptops still need pci=use_e820
- Add DMI quirks for known newer laptops which need pci=use_e820

Changes in v6:
- Remove the possibility to change the behavior from the commandline
  because of worries that users may use this to paper over other problems

Changes in v5:
- Drop mention of Windows behavior from the commit msg, replace with a
  reference to the specs
- Improve documentation in Documentation/admin-guide/kernel-parameters.txt
- Reword the big comment added, use "PCI host bridge window" in it and drop
  all refences to Windows

Changes in v4:
- Rewrap the big comment block to fit in 80 columns
- Add Rafael's Acked-by
- Add Cc: stable@vger.kernel.org

Changes in v3:
- Commit msg tweaks (drop dmesg timestamps, typo fix)
- Use "defined(CONFIG_...)" instead of "defined CONFIG_..."
- Add Mika's Reviewed-by

Changes in v2:
- Replace the per model DMI quirk approach with disabling E820 reservations
  checking for all systems with a BIOS year >= 2018
- Add documentation for the new kernel-parameters to
  Documentation/admin-guide/kernel-parameters.txt
---
 .../admin-guide/kernel-parameters.txt         |  9 +++
 arch/x86/include/asm/pci_x86.h                |  2 +
 arch/x86/pci/acpi.c                           | 74 ++++++++++++++++++-
 arch/x86/pci/common.c                         |  6 ++
 4 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..2477b639d5c4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4066,6 +4066,15 @@
 				please report a bug.
 		nocrs		[X86] Ignore PCI host bridge windows from ACPI.
 				If you need to use this, please report a bug.
+		use_e820	[X86] Use E820 reservations to exclude parts of
+				PCI host bridge windows. This is a workaround
+				for BIOS defects in host bridge _CRS methods.
+				If you need to use this, please report a bug to
+				<linux-pci@vger.kernel.org>.
+		no_e820		[X86] Ignore E820 reservations for PCI host
+				bridge windows. This is the default on modern
+				hardware. If you need to use this, please report
+				a bug to <linux-pci@vger.kernel.org>.
 		routeirq	Do IRQ routing for all PCI devices.
 				This is normally done in pci_enable_device(),
 				so this option is a temporary workaround
diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index a0627dfae541..ce3fd3311772 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -42,6 +42,8 @@ do {						\
 #define PCI_ROOT_NO_CRS		0x100000
 #define PCI_NOASSIGN_BARS	0x200000
 #define PCI_BIG_ROOT_WINDOW	0x400000
+#define PCI_USE_E820		0x800000
+#define PCI_NO_E820		0x1000000
 
 extern unsigned int pci_probe;
 extern unsigned long pirq_table_addr;
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 562c81a51ea0..749f175c0fb7 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -22,6 +22,7 @@ struct pci_root_info {
 
 static bool pci_use_crs = true;
 static bool pci_ignore_seg;
+static bool pci_use_e820;
 
 static int __init set_use_crs(const struct dmi_system_id *id)
 {
@@ -42,6 +43,12 @@ static int __init set_ignore_seg(const struct dmi_system_id *id)
 	return 0;
 }
 
+static int __init set_use_e820(const struct dmi_system_id *id)
+{
+	pci_use_e820 = true;
+	return 0;
+}
+
 static const struct dmi_system_id pci_crs_quirks[] __initconst = {
 	/* http://bugzilla.kernel.org/show_bug.cgi?id=14183 */
 	{
@@ -136,6 +143,42 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP xw9300 Workstation"),
 		},
 	},
+
+	/*
+	 * Asus-C523NA / Google Coral Chromebook needs the following E820 clips:
+	 * clipped [mem 0x000a0000-0x000bffff window] to [mem 0x00100000-0x000bffff window]
+	 *  for e820 entry [mem 0x000a0000-0x000fffff]
+	 * clipped [mem 0x7b800000-0x7fffffff window] to [mem 0x80000000-0x7fffffff window]
+	 *  for e820 entry [mem 0x7b000000-0x7fffffff]
+	 * clipped [mem 0x80000000-0xe0000000 window] to [mem 0x80000000-0xcfffffff window]
+	 *  for e820 entry [mem 0xd0000000-0xd0ffffff]
+	 * Otherwise the system does not boot. Note the first 2 clips completely cover
+	 * the windows.
+	 */
+	{
+		.callback = set_use_e820,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Coral"),
+		},
+	},
+
+	/*
+	 * Lenovo ThinkPad X1 Carbon 2nd needs the following E820 clips:
+	 * clipped [mem 0xdfa00000-0xfebfffff window] to [mem 0xdfa10000-0xfebfffff window]
+	 *  for e820 entry [mem 0xdceff000-0xdfa0ffff]
+	 * clipped [mem 0xdfa10000-0xfebfffff window] to [mem 0xdfa10000-0xf7ffffff window]
+	 *  for e820 entry [mem 0xf8000000-0xfbffffff]
+	 * Otherwise the system does not resume from suspend.
+	 * https://bugzilla.redhat.com/show_bug.cgi?id=2029207
+	 */
+	{
+		.callback = set_use_e820,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X1 Carbon 2nd"),
+		},
+	},
 	{}
 };
 
@@ -146,6 +189,22 @@ void __init pci_acpi_crs_quirks(void)
 	if (year >= 0 && year < 2008 && iomem_resource.end <= 0xffffffff)
 		pci_use_crs = false;
 
+	/*
+	 * Some BIOS-es contain bugs where they add addresses which are already
+	 * used in some other manner to the PCI host bridge window returned by
+	 * the ACPI _CRS method. To avoid this Linux by default excludes
+	 * E820 reservations when allocating addresses since 2010.
+	 * In 2019 some systems have shown-up with E820 reservations which cover
+	 * the entire _CRS returned PCI host bridge window, causing all attempts
+	 * to assign memory to PCI BARs to fail if Linux uses E820 reservations.
+	 *
+	 * Ideally Linux would fully stop using E820 reservations, but then
+	 * various old systems will regress. Instead keep the old behavior for
+	 * old systems + known to be broken newer systems in pci_crs_quirks.
+	 */
+	if (year >= 0 && year < 2018)
+		pci_use_e820 = true;
+
 	dmi_check_system(pci_crs_quirks);
 
 	/*
@@ -161,6 +220,15 @@ void __init pci_acpi_crs_quirks(void)
 	       "if necessary, use \"pci=%s\" and report a bug\n",
 	       pci_use_crs ? "Using" : "Ignoring",
 	       pci_use_crs ? "nocrs" : "use_crs");
+
+	/* "pci=use_e820"/"pci=no_e820" on the kernel cmdline takes precedence */
+	if (pci_probe & PCI_NO_E820)
+		pci_use_e820 = false;
+	else if (pci_probe & PCI_USE_E820)
+		pci_use_e820 = true;
+
+	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
+	       pci_use_e820 ? "Using" : "Ignoring");
 }
 
 #ifdef	CONFIG_PCI_MMCONFIG
@@ -301,8 +369,10 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 
 	status = acpi_pci_probe_root_resources(ci);
 
-	resource_list_for_each_entry(entry, &ci->resources)
-		remove_e820_regions(&device->dev, entry->res);
+	if (pci_use_e820) {
+		resource_list_for_each_entry(entry, &ci->resources)
+			remove_e820_regions(&device->dev, entry->res);
+	}
 
 	if (pci_use_crs) {
 		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 9e1e6b8d8876..7e6f79aab6a8 100644
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
2.36.0

