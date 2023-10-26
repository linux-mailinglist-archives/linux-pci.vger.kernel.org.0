Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422A37D8331
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 14:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjJZMzI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 08:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZMzH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 08:55:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2ACAC;
        Thu, 26 Oct 2023 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698324905; x=1729860905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hl8FaZTzUfLxFUNddJbFTntXpEPXqgat3oylaxVt9p8=;
  b=Xps6oZCLu7ph7/3onDHo+dwF5amXGj5CYYC4qMJVfUFr20GuphDrySxF
   wYRlJpMFq00T6Ku4qeAsQOv+5DZMLYlEOQ2wP7mqwQSgg2+okCDnKE/a4
   I3XUkWQDry53x804NsiUDY6/MNYkjEQ903vQXh9tXA+rm2/0kMCCDxZF5
   N7SPMhCrATtxr0l11o08yo8MUJAAjQ2rfLAdy5yFhorcjxrwMn7dAVkWK
   lo4H9YA4I2y1uVz8e7xNN9kbSEKV2vLKxyg/P3H+pLeFl4e1gFzNtsRr7
   6iZ+a9bYx24BXo0c/RVQEpu9LTq8ul5devrVbMcTDtlTWqWyPnLXEehTk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="366879697"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="366879697"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="709062075"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="709062075"
Received: from ialvarez-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.120])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:55:00 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] x86/PCI: Name PCI BIOS error code & use FIELD_GET()
Date:   Thu, 26 Oct 2023 15:54:52 +0300
Message-Id: <20231026125453.25767-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI BIOS returns error code in AH register when carry flag is set. The
extraction of the error code is currently set of masking and shifting
which makes the code harder to understand than it needs to be.

Name the PCI BIOS error code with a define and use FIELD_GET() to
access it to improve code readability.

In addition, rely on implicit cast to int and replace zero test
with PCIBIOS_SUCCESSFUL.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/x86/pci/pcbios.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index 4f15280732ed..0515e0c05e10 100644
--- a/arch/x86/pci/pcbios.c
+++ b/arch/x86/pci/pcbios.c
@@ -3,6 +3,8 @@
  * BIOS32 and PCI BIOS handling.
  */
 
+#include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -29,6 +31,12 @@
 #define PCIBIOS_HW_TYPE1_SPEC		0x10
 #define PCIBIOS_HW_TYPE2_SPEC		0x20
 
+/*
+ * Returned in EAX:
+ * - AH: return code
+ */
+#define PCIBIOS_RETURN_CODE			GENMASK(15, 8)
+
 int pcibios_enabled;
 
 /* According to the BIOS specification at:
@@ -154,7 +162,7 @@ static int __init check_pcibios(void)
 			: "memory");
 		local_irq_restore(flags);
 
-		status = (eax >> 8) & 0xff;
+		status = FIELD_GET(PCIBIOS_RETURN_CODE, eax);
 		hw_mech = eax & 0xff;
 		major_ver = (ebx >> 8) & 0xff;
 		minor_ver = ebx & 0xff;
@@ -227,7 +235,7 @@ static int pci_bios_read(unsigned int seg, unsigned int bus,
 
 	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
 
-	return (int)((result & 0xff00) >> 8);
+	return FIELD_GET(PCIBIOS_RETURN_CODE, result);
 }
 
 static int pci_bios_write(unsigned int seg, unsigned int bus,
@@ -269,7 +277,7 @@ static int pci_bios_write(unsigned int seg, unsigned int bus,
 
 	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
 
-	return (int)((result & 0xff00) >> 8);
+	return FIELD_GET(PCIBIOS_RETURN_CODE, result);
 }
 
 
@@ -354,6 +362,7 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
 {
 	struct irq_routing_options opt;
 	struct irq_routing_table *rt = NULL;
+	unsigned int error_code;
 	int ret, map;
 	unsigned long page;
 
@@ -385,8 +394,9 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
 		  "m" (opt)
 		: "memory");
 	DBG("OK  ret=%d, size=%d, map=%x\n", ret, opt.size, map);
-	if (ret & 0xff00)
-		printk(KERN_ERR "PCI: Error %02x when fetching IRQ routing table.\n", (ret >> 8) & 0xff);
+	error_code = FIELD_GET(PCIBIOS_RETURN_CODE, ret);
+	if (error_code)
+		printk(KERN_ERR "PCI: Error %02x when fetching IRQ routing table.\n", error_code);
 	else if (opt.size) {
 		rt = kmalloc(sizeof(struct irq_routing_table) + opt.size, GFP_KERNEL);
 		if (rt) {
@@ -415,7 +425,7 @@ int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq)
 		  "b" ((dev->bus->number << 8) | dev->devfn),
 		  "c" ((irq << 8) | (pin + 10)),
 		  "S" (&pci_indirect));
-	return !(ret & 0xff00);
+	return FIELD_GET(PCIBIOS_RETURN_CODE, ret) == PCIBIOS_SUCCESSFUL;
 }
 EXPORT_SYMBOL(pcibios_set_irq_routing);
 
-- 
2.30.2

