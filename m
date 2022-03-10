Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BDF4D5250
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 20:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiCJTmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 14:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiCJTmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 14:42:24 -0500
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 11:41:22 PST
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDA4188A0C
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 11:41:22 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 1020 invoked from network); 10 Mar 2022 20:34:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1646940879; bh=KwMNW8ZZRm1bCxcewtu3qgqq9p7UkivlaK57PWEd+VI=;
          h=From:To:Cc:Subject;
          b=t7iQGjweFAFWzLObngYK05fl5xaHmC2DwsEpO48JX6uFDAA1Pir4tDBTv59+ls9ca
           w3Lg2TG4DSM7adH81pfd4xNkRLK8S9KplbisYgSxAa54SFymkEyIVUKXeHVdfj5hOC
           BGFSSUxM2bmGSCB1cbev8vbWmj/UimYtOagvTapI=
Received: from aafb37.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.131.37])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 10 Mar 2022 20:34:39 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Ira W . Snyder" <ira.snyder@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] x86/pci: drop ServerWorks / Broadcom CNB20LE PCI host bridge driver
Date:   Thu, 10 Mar 2022 20:34:19 +0100
Message-Id: <20220310193419.457395-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 2263c2956a1c45f2a759a573378416d0
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000001 [geLs]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ServerWorks / Broadcom CNB20LE chipset was probably designed
for Intel Pentium III processors only. The dedicated driver for it
(implemented in arch/x86/pci/broadcom_bus.c) reads PCI windows
from this chipset, which is (if I understand correctly) needed mostly
for PCI hotplug and "option ROM mapping" [2]. This driver was written
without access to the documentation of CNB20LE and caused problems on
some servers, so it was soon disabled for all systems with ACPI enabled.
It appears that most systems with CNB20LE support ACPI and it is not
known whether the driver works correctly on most of those that don't.

On such old platforms, PCI hotplug is typically not used and
"reliability" (i.e. that the system boots at all) is more important.
So, delete this driver as it can cause more harm then good and there is
little benefit in keeping it in the kernel.

Details:

I was unable to find a description of this chipset. However, it was
almost exclusively used with the Pentium III processor (this CPU model
was used in all references to it that I examined where the CPU model
was provided: dmesgs in [1] and [2]; [3] page 2; [4]-[7]).

The CNB20LE driver was added to the kernel in 2010 (many years after
the introduction of Pentium III) in Linux 2.6.35 in
commit 3f6ea84a3035 ("PCI: read memory ranges out of Broadcom CNB20LE host bridge")
Soon, it caused problems on some Compaq Proliant DL320 servers [2] and
it was decided to disable the driver on all systems with ACPI enabled.
This went in
commit 30e664afb5cb ("x86/PCI: don't use native Broadcom CNB20LE driver when ACPI is available")

However, most of these systems mentioned (all except for [3], where it is not
known and [7]) support ACPI. I think that dmesg from the original system
on which the driver was developed can be found in [7]. It is possible
that CNB30LE used the same PCI ID and was also detected by this driver
[7], but it probably also was used with Pentium III.

[1] Jim Studt, Re: Problem with ServerWorks CNB20LE and lost interrupts
Linux Kernel Mailing List, https://lkml.org/lkml/2002/1/11/111

[2] RedHat Bug 665109 - e100 problems on old Compaq Proliant DL320
https://bugzilla.redhat.com/show_bug.cgi?id=665109

[3] R. Hughes-Jones, S. Dallison, G. Fairey, Performance Measurements on
Gigabit Ethernet NICs and Server Quality Motherboards,
http://datatag.web.cern.ch/papers/pfldnet2003-rhj.doc

[4] "Hardware for Linux",
Probe #d6b5151873 of Intel STL2-bd A28808-302 Desktop Computer (STL2)
https://linux-hardware.org/?probe=d6b5151873

[5] "Hardware for Linux", Probe #0b5d843f10 of Compaq ProLiant DL380
https://linux-hardware.org/?probe=0b5d843f10

[6] Ubuntu Forums, Dell Poweredge 2400 - Adaptec SCSI Bus AIC-7880
https://ubuntuforums.org/showthread.php?t=1689552

[7] Ira W. Snyder, "BISECTED: 2.6.35 (and -git) fail to boot: APIC problems"
https://lkml.org/lkml/2010/8/13/220

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-pci@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ira W. Snyder <ira.snyder@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>

---

Hello,

When trying to document CONFIG_PCI_CNB20LE_QUIRK for Kconfig I realised
that this driver probably may be removed from the kernel.

I am not sure what exactly the drawbacks of missing PCI bus window
information for this chipset are. In [2] there is a comment by Mr Bjorn
Helgaas:
        I think the possibilities are:
        [...]
        2) Ignore _CRS and make broadcom_bus.c do nothing.  This gets us
        back to the working situation of F13 [Fedora 13].  Since we
        don't have any host bridge information, things like PCI hotplug
        and option ROM mapping may not work, but that's the way it's
        always been on these boxes.

I understand how host bridge windows are required for PCI hotplug, but I
don't know why they may be necessary for option ROM mapping.

Greetings,
Mateusz
---
 arch/x86/Kconfig            |  13 -----
 arch/x86/pci/Makefile       |   1 -
 arch/x86/pci/broadcom_bus.c | 112 ------------------------------------
 arch/x86/pci/bus_numa.c     |   2 +-
 4 files changed, 1 insertion(+), 127 deletions(-)
 delete mode 100644 arch/x86/pci/broadcom_bus.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660..577a588fe1ae 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2656,19 +2656,6 @@ config MMCONF_FAM10H
 	def_bool y
 	depends on X86_64 && PCI_MMCONFIG && ACPI
 
-config PCI_CNB20LE_QUIRK
-	bool "Read CNB20LE Host Bridge Windows" if EXPERT
-	depends on PCI
-	help
-	  Read the PCI windows out of the CNB20LE host bridge. This allows
-	  PCI hotplug to work on systems with the CNB20LE chipset which do
-	  not have ACPI.
-
-	  There's no public spec for this chipset, and this functionality
-	  is known to be incomplete.
-
-	  You should say N unless you know you need this.
-
 config ISA_BUS
 	bool "ISA bus support on modern systems" if EXPERT
 	help
diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
index 48bcada5cabe..ca343d8c7964 100644
--- a/arch/x86/pci/Makefile
+++ b/arch/x86/pci/Makefile
@@ -22,6 +22,5 @@ obj-y				+= common.o early.o
 obj-y				+= bus_numa.o
 
 obj-$(CONFIG_AMD_NB)		+= amd_bus.o
-obj-$(CONFIG_PCI_CNB20LE_QUIRK)	+= broadcom_bus.o
 
 ccflags-$(CONFIG_PCI_DEBUG)	+= -DDEBUG
diff --git a/arch/x86/pci/broadcom_bus.c b/arch/x86/pci/broadcom_bus.c
deleted file mode 100644
index 2db73613cada..000000000000
--- a/arch/x86/pci/broadcom_bus.c
+++ /dev/null
@@ -1,112 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Read address ranges from a Broadcom CNB20LE Host Bridge
- *
- * Copyright (c) 2010 Ira W. Snyder <iws@ovro.caltech.edu>
- */
-
-#include <linux/acpi.h>
-#include <linux/delay.h>
-#include <linux/dmi.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <asm/pci_x86.h>
-#include <asm/pci-direct.h>
-
-#include "bus_numa.h"
-
-static void __init cnb20le_res(u8 bus, u8 slot, u8 func)
-{
-	struct pci_root_info *info;
-	struct pci_root_res *root_res;
-	struct resource res;
-	u16 word1, word2;
-	u8 fbus, lbus;
-
-	/* read the PCI bus numbers */
-	fbus = read_pci_config_byte(bus, slot, func, 0x44);
-	lbus = read_pci_config_byte(bus, slot, func, 0x45);
-	info = alloc_pci_root_info(fbus, lbus, 0, 0);
-
-	/*
-	 * Add the legacy IDE ports on bus 0
-	 *
-	 * These do not exist anywhere in the bridge registers, AFAICT. I do
-	 * not have the datasheet, so this is the best I can do.
-	 */
-	if (fbus == 0) {
-		update_res(info, 0x01f0, 0x01f7, IORESOURCE_IO, 0);
-		update_res(info, 0x03f6, 0x03f6, IORESOURCE_IO, 0);
-		update_res(info, 0x0170, 0x0177, IORESOURCE_IO, 0);
-		update_res(info, 0x0376, 0x0376, IORESOURCE_IO, 0);
-		update_res(info, 0xffa0, 0xffaf, IORESOURCE_IO, 0);
-	}
-
-	/* read the non-prefetchable memory window */
-	word1 = read_pci_config_16(bus, slot, func, 0xc0);
-	word2 = read_pci_config_16(bus, slot, func, 0xc2);
-	if (word1 != word2) {
-		res.start = ((resource_size_t) word1 << 16) | 0x0000;
-		res.end   = ((resource_size_t) word2 << 16) | 0xffff;
-		res.flags = IORESOURCE_MEM;
-		update_res(info, res.start, res.end, res.flags, 0);
-	}
-
-	/* read the prefetchable memory window */
-	word1 = read_pci_config_16(bus, slot, func, 0xc4);
-	word2 = read_pci_config_16(bus, slot, func, 0xc6);
-	if (word1 != word2) {
-		res.start = ((resource_size_t) word1 << 16) | 0x0000;
-		res.end   = ((resource_size_t) word2 << 16) | 0xffff;
-		res.flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
-		update_res(info, res.start, res.end, res.flags, 0);
-	}
-
-	/* read the IO port window */
-	word1 = read_pci_config_16(bus, slot, func, 0xd0);
-	word2 = read_pci_config_16(bus, slot, func, 0xd2);
-	if (word1 != word2) {
-		res.start = word1;
-		res.end   = word2;
-		res.flags = IORESOURCE_IO;
-		update_res(info, res.start, res.end, res.flags, 0);
-	}
-
-	/* print information about this host bridge */
-	res.start = fbus;
-	res.end   = lbus;
-	res.flags = IORESOURCE_BUS;
-	printk(KERN_INFO "CNB20LE PCI Host Bridge (domain 0000 %pR)\n", &res);
-
-	list_for_each_entry(root_res, &info->resources, list)
-		printk(KERN_INFO "host bridge window %pR\n", &root_res->res);
-}
-
-static int __init broadcom_postcore_init(void)
-{
-	u8 bus = 0, slot = 0;
-	u32 id;
-	u16 vendor, device;
-
-#ifdef CONFIG_ACPI
-	/*
-	 * We should get host bridge information from ACPI unless the BIOS
-	 * doesn't support it.
-	 */
-	if (!acpi_disabled && acpi_os_get_root_pointer())
-		return 0;
-#endif
-
-	id = read_pci_config(bus, slot, 0, PCI_VENDOR_ID);
-	vendor = id & 0xffff;
-	device = (id >> 16) & 0xffff;
-
-	if (vendor == PCI_VENDOR_ID_SERVERWORKS &&
-	    device == PCI_DEVICE_ID_SERVERWORKS_LE) {
-		cnb20le_res(bus, slot, 0);
-		cnb20le_res(bus, slot, 1);
-	}
-	return 0;
-}
-
-postcore_initcall(broadcom_postcore_init);
diff --git a/arch/x86/pci/bus_numa.c b/arch/x86/pci/bus_numa.c
index 2752c02e3f0e..b4f5e668812e 100644
--- a/arch/x86/pci/bus_numa.c
+++ b/arch/x86/pci/bus_numa.c
@@ -59,7 +59,7 @@ void x86_pci_root_bus_resources(int bus, struct list_head *resources)
 default_resources:
 	/*
 	 * We don't have any host bridge aperture information from the
-	 * "native host bridge drivers," e.g., amd_bus or broadcom_bus,
+	 * "native host bridge drivers", e.g. amd_bus,
 	 * so fall back to the defaults historically used by pci_create_bus().
 	 */
 	printk(KERN_DEBUG "PCI: root bus %02x: using default resources\n", bus);

base-commit: ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2
-- 
2.25.1

