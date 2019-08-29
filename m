Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DAEA21EB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 19:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfH2RMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 13:12:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39615 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfH2RMG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 13:12:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id n2so3222746wmk.4;
        Thu, 29 Aug 2019 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sV+dOekBkFxZr+hFc3/RA8RiShlL0pkkBR29uK5vHNI=;
        b=iAecnhLoY3EqD9cUGIB6sa4i8HpoaYF7STxxOxBt6zdJfROfOBTpCg1NW0ah0xAoAB
         xAfuRqPIJmVJEIm+KT113W2GqdTFC8/m2PeP3r5PCtNRUH+2pAbFn3PRKex9AuANdO8x
         QGzGhpnGDGGMThFqwBOc7115MiTXqkHF8SBFSesYhwnm512QkLuEQYCsTZC4qH0HUe6v
         Kt+UzxLNEDSutNHp9vfjyt4s3TLDctMEQlQX9wpWyAVL7omjUnxEeoGdxQCa84GwV5YO
         FJjraT5y8nm4icN/fAOXPHelTFtoObgaIbZzyhbnsnwtYh6fOF8LGLziOxonhbDj59pM
         y6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sV+dOekBkFxZr+hFc3/RA8RiShlL0pkkBR29uK5vHNI=;
        b=GvU/fKuqatjGkIIN+lPUohstk8zqOWTNyIMP9wHYyJ3/cghMPI/E4gByvLpjA8myh2
         dL8OedvYCmp92Wzrn7M1oR14tub2ZcYyUKluMMPjvBDO5t7lqw05W1B+aM6rTReohHyq
         uUnQsFjRsPvcQHaTuOV/rVgeOLqV+Lwo06OKDtkO1XNScARzoKwEvNjqabutq85gDzTJ
         IAc5zOTsqIvLGm7Prr6Pt1cGuOC0uZdIgS8kmIEZxvxS+AetgGpF6M09aZEmAQh0A7Fi
         +6x7u95I9vdOjejZ7771En4jj2bVmVQxyZyqwMagEoedKfMr0mAiHpsAyKuL2lmbQDZd
         0ivw==
X-Gm-Message-State: APjAAAWLuuOp/17OQz9a9TduzzE5Z75tL2LEG4B16KH65hMagEoXNL3x
        WLuucvc37qZh81srfmS/Hw0=
X-Google-Smtp-Source: APXvYqwuPU1pcnomP9EBGIGmtCYdVMRzfBptAbh1+lsyl3+XSyCMa4IsK9zqtHAGer6igJYhWGeJoQ==
X-Received: by 2002:a05:600c:228e:: with SMTP id 14mr13514039wmf.101.1567098722950;
        Thu, 29 Aug 2019 10:12:02 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id 16sm4413308wmx.45.2019.08.29.10.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 10:12:01 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] x86/PCI: Add missing log facility and move to use pr_ macros
Date:   Thu, 29 Aug 2019 19:11:59 +0200
Message-Id: <20190829171159.18707-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190828175120.22164-1-kw@linux.com>
References: <20190828175120.22164-1-kw@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing log facility where two instances of printk() that did not
use any (so it would be using MESSAGE_LOGLEVEL_DEFAULT set in Kconfig)
to make all the warnings in the arch/x86/pci/pcbios.c to be printed
consistently at the same log facility.  This resolves the following
checkpatch.pl script warning:

WARNING: printk() should include KERN_<LEVEL> facility level

While adding the missing log facility move over to using pr_ macros
over using printk(KERN_<level> ...) and DBG().

Also resolve the additional errors and warnings reported by the
checkpatch.pl script:

ERROR: trailing whitespace
ERROR: "foo * bar" should be "foo *bar"
ERROR: switch and case should be at the same indent

WARNING: please, no space before tabs
WARNING: line over 80 characters
WARNING: quoted string split across lines
WARNING: __packed is preferred over __attribute__((packed))
WARNING: Prefer using '"%s...", __func__' to using 'bios32_service',
  this function's name, in a string

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Changes in v3:
  Remove name of the file from the subject.
  Address review feedback of v2, and resolve more checkpatch.pl
  script errors and warnings.

Changes in v2:
  Change wording and include checkpatch.pl script warning.
  Leverage pr_fmt and remove "PCI: " prefix used throught.
  Move to pr_debug() over using DBG() from arch/x86/include/asm/pci_x86.h.

 arch/x86/pci/pcbios.c | 77 +++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index 9c97d814125e..dd8ca5636953 100644
--- a/arch/x86/pci/pcbios.c
+++ b/arch/x86/pci/pcbios.c
@@ -3,6 +3,8 @@
  * BIOS32 and PCI BIOS handling.
  */
 
+#define pr_fmt(fmt) "PCI: " fmt
+
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -47,15 +49,15 @@ static inline void set_bios_x(void)
 	pcibios_enabled = 1;
 	set_memory_x(PAGE_OFFSET + BIOS_BEGIN, (BIOS_END - BIOS_BEGIN) >> PAGE_SHIFT);
 	if (__supported_pte_mask & _PAGE_NX)
-		printk(KERN_INFO "PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.\n");
+		pr_info("PCI BIOS area is rw and x. Use pci=nobios if you want it NX.\n");
 }
 
 /*
  * This is the standard structure used to identify the entry point
  * to the BIOS32 Service Directory, as documented in
- * 	Standard BIOS 32-bit Service Directory Proposal
- * 	Revision 0.4 May 24, 1993
- * 	Phoenix Technologies Ltd.
+ *	Standard BIOS 32-bit Service Directory Proposal
+ *	Revision 0.4 May 24, 1993
+ *	Phoenix Technologies Ltd.
  *	Norwood, MA
  * and the PCI BIOS specification.
  */
@@ -67,7 +69,7 @@ union bios32 {
 		unsigned char revision;		/* Revision level, 0 */
 		unsigned char length;		/* Length in paragraphs should be 01 */
 		unsigned char checksum;		/* All bytes must add up to zero */
-		unsigned char reserved[5]; 	/* Must be zero */
+		unsigned char reserved[5];	/* Must be zero */
 	} fields;
 	char chars[16];
 };
@@ -108,15 +110,16 @@ static unsigned long __init bios32_service(unsigned long service)
 	local_irq_restore(flags);
 
 	switch (return_code) {
-		case 0:
-			return address + entry;
-		case 0x80:	/* Not present */
-			printk(KERN_WARNING "bios32_service(0x%lx): not present\n", service);
-			return 0;
-		default: /* Shouldn't happen */
-			printk(KERN_WARNING "bios32_service(0x%lx): returned 0x%x -- BIOS bug!\n",
-				service, return_code);
-			return 0;
+	case 0:
+		return address + entry;
+	case 0x80:	/* Not present */
+		pr_warn("%s(0x%lx): not present\n",
+			__func__, service);
+		return 0;
+	default: /* Shouldn't happen */
+		pr_warn("%s(0x%lx): returned 0x%x -- BIOS bug!\n",
+			__func__, service, return_code);
+		return 0;
 	}
 }
 
@@ -140,8 +143,7 @@ static int __init check_pcibios(void)
 		pci_indirect.address = pcibios_entry + PAGE_OFFSET;
 
 		local_irq_save(flags);
-		__asm__(
-			"lcall *(%%edi); cld\n\t"
+		__asm__("lcall *(%%edi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -160,14 +162,15 @@ static int __init check_pcibios(void)
 		minor_ver = ebx & 0xff;
 		if (pcibios_last_bus < 0)
 			pcibios_last_bus = ecx & 0xff;
-		DBG("PCI: BIOS probe returned s=%02x hw=%02x ver=%02x.%02x l=%02x\n",
-			status, hw_mech, major_ver, minor_ver, pcibios_last_bus);
+		pr_debug("BIOS probe returned s=%02x hw=%02x ver=%02x.%02x l=%02x\n",
+			 status, hw_mech, major_ver, minor_ver,
+			 pcibios_last_bus);
 		if (status || signature != PCI_SIGNATURE) {
-			printk (KERN_ERR "PCI: BIOS BUG #%x[%08x] found\n",
-				status, signature);
+			pr_err("BIOS BUG #%x[%08x] found\n",
+			       status, signature);
 			return 0;
 		}
-		printk(KERN_INFO "PCI: PCI BIOS revision %x.%02x entry at 0x%lx, last bus=%d\n",
+		pr_info("PCI BIOS revision %x.%02x entry at 0x%lx, last bus=%d\n",
 			major_ver, minor_ver, pcibios_entry, pcibios_last_bus);
 #ifdef CONFIG_PCI_DIRECT
 		if (!(hw_mech & PCIBIOS_HW_TYPE1))
@@ -239,7 +242,7 @@ static int pci_bios_write(unsigned int seg, unsigned int bus,
 	u16 number = 0;
 
 	WARN_ON(seg);
-	if ((bus > 255) || (devfn > 255) || (reg > 255)) 
+	if ((bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&pci_config_lock, flags);
@@ -316,19 +319,19 @@ static const struct pci_raw_ops *__init pci_find_bios(void)
 		if (sum != 0)
 			continue;
 		if (check->fields.revision != 0) {
-			printk("PCI: unsupported BIOS32 revision %d at 0x%p\n",
+			pr_warn("unsupported BIOS32 revision %d at 0x%p\n",
 				check->fields.revision, check);
 			continue;
 		}
-		DBG("PCI: BIOS32 Service Directory structure at 0x%p\n", check);
+		pr_debug("BIOS32 Service Directory structure at 0x%p\n", check);
 		if (check->fields.entry >= 0x100000) {
-			printk("PCI: BIOS32 entry (0x%p) in high memory, "
-					"cannot use.\n", check);
+			pr_warn("BIOS32 entry (0x%p) in high memory, cannot use.\n",
+				check);
 			return NULL;
 		} else {
 			unsigned long bios32_entry = check->fields.entry;
-			DBG("PCI: BIOS32 Service Directory entry at 0x%lx\n",
-					bios32_entry);
+			pr_debug("BIOS32 Service Directory entry at 0x%lx\n",
+				 bios32_entry);
 			bios32_indirect.address = bios32_entry + PAGE_OFFSET;
 			set_bios_x();
 			if (check_pcibios())
@@ -348,9 +351,9 @@ struct irq_routing_options {
 	u16 size;
 	struct irq_info *table;
 	u16 segment;
-} __attribute__((packed));
+} __packed;
 
-struct irq_routing_table * pcibios_get_irq_routing_table(void)
+struct irq_routing_table *pcibios_get_irq_routing_table(void)
 {
 	struct irq_routing_options opt;
 	struct irq_routing_table *rt = NULL;
@@ -366,7 +369,7 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
 	opt.size = PAGE_SIZE;
 	opt.segment = __KERNEL_DS;
 
-	DBG("PCI: Fetching IRQ routing table... ");
+	pr_debug("Fetching IRQ routing table... ");
 	__asm__("push %%es\n\t"
 		"push %%ds\n\t"
 		"pop  %%es\n\t"
@@ -384,17 +387,19 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
 		  "S" (&pci_indirect),
 		  "m" (opt)
 		: "memory");
-	DBG("OK  ret=%d, size=%d, map=%x\n", ret, opt.size, map);
+	pr_debug("OK  ret=%d, size=%d, map=%x\n", ret, opt.size, map);
 	if (ret & 0xff00)
-		printk(KERN_ERR "PCI: Error %02x when fetching IRQ routing table.\n", (ret >> 8) & 0xff);
+		pr_err("Error %02x when fetching IRQ routing table.\n",
+		       (ret >> 8) & 0xff);
 	else if (opt.size) {
-		rt = kmalloc(sizeof(struct irq_routing_table) + opt.size, GFP_KERNEL);
+		rt = kmalloc(sizeof(struct irq_routing_table) + opt.size,
+			     GFP_KERNEL);
 		if (rt) {
 			memset(rt, 0, sizeof(struct irq_routing_table));
 			rt->size = opt.size + sizeof(struct irq_routing_table);
 			rt->exclusive_irqs = map;
 			memcpy(rt->slots, (void *) page, opt.size);
-			printk(KERN_INFO "PCI: Using BIOS Interrupt Routing Table\n");
+			pr_info("Using BIOS Interrupt Routing Table\n");
 		}
 	}
 	free_page(page);
@@ -421,7 +426,7 @@ EXPORT_SYMBOL(pcibios_set_irq_routing);
 
 void __init pci_pcbios_init(void)
 {
-	if ((pci_probe & PCI_PROBE_BIOS) 
+	if ((pci_probe & PCI_PROBE_BIOS)
 		&& ((raw_pci_ops = pci_find_bios()))) {
 		pci_bios_present = 1;
 	}
-- 
2.22.1

