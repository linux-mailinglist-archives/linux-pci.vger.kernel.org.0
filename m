Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B1A08F4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 19:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfH1RvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 13:51:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41827 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfH1RvZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 13:51:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so670070wrr.8;
        Wed, 28 Aug 2019 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+L/L1oviegCq0SEoQs5dxf3RE/Q9qKwwJ9SUpVknSA=;
        b=f4fD/NzkApqP6ivRI9YR83TuPET49XoCIQhc50e2vdDr1OJvTpDvOT44PALvTY7m5c
         2mX5P6DhR35z4u0OpGpfzJ+Q0D2Sa+6hsfiM47YeWui2O3tLnqcqLxRcSafLqSO4Wy2L
         1Xk+VU57K7VUj4SgIyT5bmwR6Zz3x4PfUO9P6BgmjPdthNpe4uM33tlALSUtt5aUxSe9
         VUcENcVhtqLwJFWd5kL+nNnnaqkuacF7y48b2zIUitPC6ytfDhLeH58tGv7pZVNA6Qq7
         i8vQnGNjQnxmMql+GQyeBtONBw/uNpcPFHq+t3fkRTlBLrTni/xX+MtLuJ0iNWKpdboJ
         YYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=S+L/L1oviegCq0SEoQs5dxf3RE/Q9qKwwJ9SUpVknSA=;
        b=CsfQhPg8TNSXLRIIDbj5M/4RvklHvLqX/SSnxGmdIXUsotBjhs17Y1AnNG+43U4rK+
         hNvoZbZG/j7fowKeCC58T4nk2KkrENKejZoX3PLi2+3C6GtKHoDMQ1jVsXa2Z2s8HEWy
         8PpqASIUAhA7FKEKQbZCvislTcQvSBXppQmwJQoBZYy4OVIPh2qQLyDByQbLR37AxYPk
         /V1nr39bgTFjWmIufdh+W3xTxi5usNSG8BpjDr616tkZigIY6vEM3ftLwrtJdDsJyghr
         CjDPm18QcI9ijakgeBc8JIrzePg2wRV5rpYh/ZkpzTAnSOL3QfPXHiZStMGq5VSIf1gg
         uj1Q==
X-Gm-Message-State: APjAAAXoNNfp31jchnI5KsDF1NL8ORts/ghC8jaXr16ZoBsFQ6k1PzEl
        6lMnVJaSQpIZGKHnKCRaJNg=
X-Google-Smtp-Source: APXvYqw/SCzGBcopmvEQlDRIiVbzGRPhwwTlvsSne8NWA4bBf7lxZerjYU3UTwVx/hXdsSWUbkMxWQ==
X-Received: by 2002:adf:fa0a:: with SMTP id m10mr5266855wrr.174.1567014682368;
        Wed, 28 Aug 2019 10:51:22 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id i93sm5241437wri.57.2019.08.28.10.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:51:21 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/PCI: Add missing log facility and move to use pr_ macros in pcbios.c
Date:   Wed, 28 Aug 2019 19:51:20 +0200
Message-Id: <20190828175120.22164-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190825182557.23260-1-kw@linux.com>
References: <20190825182557.23260-1-kw@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing log facility where two instances of printk() that did not
use any (so it would be using MESSAGE_LOGLEVEL_DEFAULT set in Kconfig)
to make all the warnings in the arch/x86/pci/pcbios.c to be printed
consistently at the same log facility.  Also resolve the following
checkpatch.pl script warning:

WARNING: printk() should include KERN_<LEVEL> facility level

While adding the missing log facility move over to using pr_ macros
over using printk(KERN_<level> ...) and DBG().

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Changes in v2:
  Change wording and include checkpatch.pl script warning.
  Leverage pr_fmt and remove "PCI: " prefix used throught.
  Move to pr_debug() over using DBG() from arch/x86/include/asm/pci_x86.h.

 arch/x86/pci/pcbios.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index 9c97d814125e..ddcefb25c55e 100644
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
@@ -47,7 +49,7 @@ static inline void set_bios_x(void)
 	pcibios_enabled = 1;
 	set_memory_x(PAGE_OFFSET + BIOS_BEGIN, (BIOS_END - BIOS_BEGIN) >> PAGE_SHIFT);
 	if (__supported_pte_mask & _PAGE_NX)
-		printk(KERN_INFO "PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.\n");
+		pr_info("PCI BIOS area is rw and x. Use pci=nobios if you want it NX.\n");
 }
 
 /*
@@ -111,10 +113,10 @@ static unsigned long __init bios32_service(unsigned long service)
 		case 0:
 			return address + entry;
 		case 0x80:	/* Not present */
-			printk(KERN_WARNING "bios32_service(0x%lx): not present\n", service);
+			pr_warn("bios32_service(0x%lx): not present\n", service);
 			return 0;
 		default: /* Shouldn't happen */
-			printk(KERN_WARNING "bios32_service(0x%lx): returned 0x%x -- BIOS bug!\n",
+			pr_warn("bios32_service(0x%lx): returned 0x%x -- BIOS bug!\n",
 				service, return_code);
 			return 0;
 	}
@@ -160,14 +162,14 @@ static int __init check_pcibios(void)
 		minor_ver = ebx & 0xff;
 		if (pcibios_last_bus < 0)
 			pcibios_last_bus = ecx & 0xff;
-		DBG("PCI: BIOS probe returned s=%02x hw=%02x ver=%02x.%02x l=%02x\n",
+		pr_debug("BIOS probe returned s=%02x hw=%02x ver=%02x.%02x l=%02x\n",
 			status, hw_mech, major_ver, minor_ver, pcibios_last_bus);
 		if (status || signature != PCI_SIGNATURE) {
-			printk (KERN_ERR "PCI: BIOS BUG #%x[%08x] found\n",
+			pr_err("BIOS BUG #%x[%08x] found\n",
 				status, signature);
 			return 0;
 		}
-		printk(KERN_INFO "PCI: PCI BIOS revision %x.%02x entry at 0x%lx, last bus=%d\n",
+		pr_info("PCI BIOS revision %x.%02x entry at 0x%lx, last bus=%d\n",
 			major_ver, minor_ver, pcibios_entry, pcibios_last_bus);
 #ifdef CONFIG_PCI_DIRECT
 		if (!(hw_mech & PCIBIOS_HW_TYPE1))
@@ -316,18 +318,18 @@ static const struct pci_raw_ops *__init pci_find_bios(void)
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
+			pr_warn("BIOS32 entry (0x%p) in high memory, "
 					"cannot use.\n", check);
 			return NULL;
 		} else {
 			unsigned long bios32_entry = check->fields.entry;
-			DBG("PCI: BIOS32 Service Directory entry at 0x%lx\n",
+			pr_debug("BIOS32 Service Directory entry at 0x%lx\n",
 					bios32_entry);
 			bios32_indirect.address = bios32_entry + PAGE_OFFSET;
 			set_bios_x();
@@ -366,7 +368,7 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
 	opt.size = PAGE_SIZE;
 	opt.segment = __KERNEL_DS;
 
-	DBG("PCI: Fetching IRQ routing table... ");
+	pr_debug("Fetching IRQ routing table... ");
 	__asm__("push %%es\n\t"
 		"push %%ds\n\t"
 		"pop  %%es\n\t"
@@ -384,9 +386,9 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
 		  "S" (&pci_indirect),
 		  "m" (opt)
 		: "memory");
-	DBG("OK  ret=%d, size=%d, map=%x\n", ret, opt.size, map);
+	pr_debug("OK  ret=%d, size=%d, map=%x\n", ret, opt.size, map);
 	if (ret & 0xff00)
-		printk(KERN_ERR "PCI: Error %02x when fetching IRQ routing table.\n", (ret >> 8) & 0xff);
+		pr_err("Error %02x when fetching IRQ routing table.\n", (ret >> 8) & 0xff);
 	else if (opt.size) {
 		rt = kmalloc(sizeof(struct irq_routing_table) + opt.size, GFP_KERNEL);
 		if (rt) {
@@ -394,7 +396,7 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
 			rt->size = opt.size + sizeof(struct irq_routing_table);
 			rt->exclusive_irqs = map;
 			memcpy(rt->slots, (void *) page, opt.size);
-			printk(KERN_INFO "PCI: Using BIOS Interrupt Routing Table\n");
+			pr_info("Using BIOS Interrupt Routing Table\n");
 		}
 	}
 	free_page(page);
-- 
2.22.1

