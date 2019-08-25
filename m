Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 173669C586
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2019 20:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfHYS0D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Aug 2019 14:26:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53155 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbfHYS0C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Aug 2019 14:26:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id o4so13371163wmh.2;
        Sun, 25 Aug 2019 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zinVPTRrFMWmbFpflRee4MjyqNNUGw02xWqZXy1/69k=;
        b=csQfjGHjdjnGbhjHhjzMwxabrS1hMS6BHP5atjIfqCe0UGW4wPPbrtwswiFFIcREZZ
         d0EqHBI6eKyAq7LkddEew2gHfb7kc6VdFglxNVvZEFC8ilhl7lD2RnD2pBrAyauDHJnr
         YolIBjTCofwDtHHk8wS3k/D82270rcATpYWA8vGale8Mh4pglPsnK+94lmn+CrINXG2z
         Ga1VzLiul6ieyhb5n556irDCMekBoWXnY9RThjnKR9pJUdxuU4bB0lY1dACrT7waXFjO
         m66EJ55HIFKLKNkdCzqy341uXtnFTbh94r5AKqMlmbIG7BxmhoKvQzJxcMS9HK4pAMFe
         q+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=zinVPTRrFMWmbFpflRee4MjyqNNUGw02xWqZXy1/69k=;
        b=bnG9lsu7+kxGwt0kfLnfMa1Zacg+ySOovhnGkDKSji6VacSFigM/ARXw8dlB40H1xm
         1OHFRIr6l5Yjnk+vagMkBvHtQvcrp5rEVHO2xyB4kxyjEms43XThpuiJE1DAMpooP5op
         HpaHbjJMygLppNhBMQUGU2w8UL4+46tjTS4hunAwVifpV+xYNKjzIHyy8wZEtiFeypsb
         yKEKR71jtvFsjT/3B3jvUo0HnTpllP6yCKQdrgUFanU5g97DngSdqKWYdWfG0FdZtwVp
         PsdxrcZw/2k0qqnnp3mC386ArSFtLDGxNh9p+/uJ6DTLhuaYw7GvQA+rxa4jBNWfO+pL
         ejiQ==
X-Gm-Message-State: APjAAAXUlVCiC2A4raFZpua7UbnbIUlD4aQSYeXMGmbUvwta6Iw3rWFW
        dAD4JOcmo1phSrJ5gtgoIsQ=
X-Google-Smtp-Source: APXvYqyoT+gPy9NIIqEMHJwXvzYdZxId7ZhBTB32X9r2FSRXKkQTVRC2K4EpGRAb3l1AgGUdklypuA==
X-Received: by 2002:a1c:7d08:: with SMTP id y8mr18308715wmc.50.1566757560333;
        Sun, 25 Aug 2019 11:26:00 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id t14sm9167100wrv.12.2019.08.25.11.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 11:25:59 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/PCI: Add missing log facility and move to use pr_ macros in pcbios.c
Date:   Sun, 25 Aug 2019 20:25:57 +0200
Message-Id: <20190825182557.23260-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make the log facility used to print warnings to be KERN_WARNING
explicitly, rather than rely on the current (or default) value
of the MESSAGE_LOGLEVEL_DEFAULT set in Kconfig.  This will make
all the warnings in the arch/x86/pci/pcbios.c to be printed
consistently at the same log facility.

Replace printk(KERN_<level> ...) with corresponding pr_ macros,
while adding the missing log facility.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 arch/x86/pci/pcbios.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index 9c97d814125e..0c3673f50bce 100644
--- a/arch/x86/pci/pcbios.c
+++ b/arch/x86/pci/pcbios.c
@@ -47,7 +47,7 @@ static inline void set_bios_x(void)
 	pcibios_enabled = 1;
 	set_memory_x(PAGE_OFFSET + BIOS_BEGIN, (BIOS_END - BIOS_BEGIN) >> PAGE_SHIFT);
 	if (__supported_pte_mask & _PAGE_NX)
-		printk(KERN_INFO "PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.\n");
+		pr_info("PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.\n");
 }
 
 /*
@@ -111,10 +111,10 @@ static unsigned long __init bios32_service(unsigned long service)
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
@@ -163,11 +163,11 @@ static int __init check_pcibios(void)
 		DBG("PCI: BIOS probe returned s=%02x hw=%02x ver=%02x.%02x l=%02x\n",
 			status, hw_mech, major_ver, minor_ver, pcibios_last_bus);
 		if (status || signature != PCI_SIGNATURE) {
-			printk (KERN_ERR "PCI: BIOS BUG #%x[%08x] found\n",
+			pr_err("PCI: BIOS BUG #%x[%08x] found\n",
 				status, signature);
 			return 0;
 		}
-		printk(KERN_INFO "PCI: PCI BIOS revision %x.%02x entry at 0x%lx, last bus=%d\n",
+		pr_info("PCI: PCI BIOS revision %x.%02x entry at 0x%lx, last bus=%d\n",
 			major_ver, minor_ver, pcibios_entry, pcibios_last_bus);
 #ifdef CONFIG_PCI_DIRECT
 		if (!(hw_mech & PCIBIOS_HW_TYPE1))
@@ -316,13 +316,13 @@ static const struct pci_raw_ops *__init pci_find_bios(void)
 		if (sum != 0)
 			continue;
 		if (check->fields.revision != 0) {
-			printk("PCI: unsupported BIOS32 revision %d at 0x%p\n",
+			pr_warn("PCI: unsupported BIOS32 revision %d at 0x%p\n",
 				check->fields.revision, check);
 			continue;
 		}
 		DBG("PCI: BIOS32 Service Directory structure at 0x%p\n", check);
 		if (check->fields.entry >= 0x100000) {
-			printk("PCI: BIOS32 entry (0x%p) in high memory, "
+			pr_warn("PCI: BIOS32 entry (0x%p) in high memory, "
 					"cannot use.\n", check);
 			return NULL;
 		} else {
@@ -386,7 +386,7 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
 		: "memory");
 	DBG("OK  ret=%d, size=%d, map=%x\n", ret, opt.size, map);
 	if (ret & 0xff00)
-		printk(KERN_ERR "PCI: Error %02x when fetching IRQ routing table.\n", (ret >> 8) & 0xff);
+		pr_err("PCI: Error %02x when fetching IRQ routing table.\n", (ret >> 8) & 0xff);
 	else if (opt.size) {
 		rt = kmalloc(sizeof(struct irq_routing_table) + opt.size, GFP_KERNEL);
 		if (rt) {
@@ -394,7 +394,7 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
 			rt->size = opt.size + sizeof(struct irq_routing_table);
 			rt->exclusive_irqs = map;
 			memcpy(rt->slots, (void *) page, opt.size);
-			printk(KERN_INFO "PCI: Using BIOS Interrupt Routing Table\n");
+			pr_info("PCI: Using BIOS Interrupt Routing Table\n");
 		}
 	}
 	free_page(page);
-- 
2.22.1

