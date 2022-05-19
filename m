Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4A252D759
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbiESPWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 11:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiESPWJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 11:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E197760BB0
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652973725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cnHThqQ82zUOTwQcaOOSceqH/BBsaIZ9ekeI9RMRKmA=;
        b=Gdvaswdba1QsbGV4C3becTRukQU2h6ISgSIsVedWU0iUcxsH/EYlkfVuS+24FOPIPKl4Fd
        dVl/1Cu7JwhdBS9PVjNR6a5vaNv7AUPJwTLPj9kCYPWFeSy6BAlN1mezZYx1okfV3/+WEG
        +ENWHEkP8MwTEASqpEp3Mrvn361FMGA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-nTXZEp17Pe6SwCGKtjJnEQ-1; Thu, 19 May 2022 11:22:01 -0400
X-MC-Unique: nTXZEp17Pe6SwCGKtjJnEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18C9038332A1;
        Thu, 19 May 2022 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC9111121314;
        Thu, 19 May 2022 15:21:58 +0000 (UTC)
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
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v9 1/3] x86/PCI: Add kernel cmdline options to use/ignore E820 reserved regions
Date:   Thu, 19 May 2022 17:21:48 +0200
Message-Id: <20220519152150.6135-2-hdegoede@redhat.com>
In-Reply-To: <20220519152150.6135-1-hdegoede@redhat.com>
References: <20220519152150.6135-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
E820 reserved regions when allocating addresses since 2010, see:
commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
space").

Recently (2019) some systems have shown-up with E820 reserved regions
which cover the entire _CRS returned PCI bridge memory window, causing
all attempts to assign memory to PCI BARs which have not been setup by
the BIOS to fail. For example here are the relevant dmesg bits from
a Lenovo IdeaPad 3 15IIL 81WE:

 [mem 0x000000004bc50000-0x00000000cfffffff] reserved
 pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
 pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
 pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]

Add a pci=no_e820 kernel cmdline option for debugging/workaround
purposes. Also add a matching pci=use_e820 option to re-enable
the use of E820 reserved regions when they end up being disabled
by default by further patches in this patch-set.

Cc: Benoit Grégoire <benoitg@coeus.ca>
Cc: Hui Wang <hui.wang@canonical.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v9:
- Split making use_e820=false the default for BIOS year >= 2023 out into
  a separate patch
- Split the addition of DMI quirks out into a separate patch
  (leaving just the kernel cmdline option)

Changes in v8:
- Change the cut-off for no longer excluding E820 reservations from
  the bridge window to BIOS year >= 2023 so that this only applies to
  upcoming systems.
- Use DMI quirks for existing systems on which excluding E820
  reservations from the _CRS returned bridge window is an issue.

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
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 arch/x86/include/asm/pci_x86.h                  |  2 ++
 arch/x86/pci/acpi.c                             | 16 ++++++++++++++--
 arch/x86/pci/common.c                           |  8 ++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

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
index 562c81a51ea0..7bde3df68e4c 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -20,6 +20,7 @@ struct pci_root_info {
 #endif
 };
 
+static bool pci_use_e820 = true;
 static bool pci_use_crs = true;
 static bool pci_ignore_seg;
 
@@ -161,6 +162,15 @@ void __init pci_acpi_crs_quirks(void)
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
@@ -301,8 +311,10 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 
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
index 9e1e6b8d8876..ddb798603201 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -595,6 +595,14 @@ char *__init pcibios_setup(char *str)
 	} else if (!strcmp(str, "nocrs")) {
 		pci_probe |= PCI_ROOT_NO_CRS;
 		return NULL;
+	} else if (!strcmp(str, "use_e820")) {
+		pci_probe |= PCI_USE_E820;
+		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+		return NULL;
+	} else if (!strcmp(str, "no_e820")) {
+		pci_probe |= PCI_NO_E820;
+		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+		return NULL;
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 	} else if (!strcmp(str, "big_root_window")) {
 		pci_probe |= PCI_BIG_ROOT_WINDOW;
-- 
2.36.0

