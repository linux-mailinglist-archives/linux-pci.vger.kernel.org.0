Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B174E7D93BE
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 11:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345588AbjJ0Jcd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 05:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345511AbjJ0Jcc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 05:32:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD19D6;
        Fri, 27 Oct 2023 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698399150; x=1729935150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E5RwqO+lO0TO4TDIUVo/1+XGPWCyYovWfbx2RtbtqoA=;
  b=JiZGn+7Xc/3Oh3tyWrcUQM3XVQNTkM7lsXECospTDbAPWWZ5vUZAW6I6
   R3NcT9+/F9L0eIlW+0rWxN+ynDyWwswqTOe0xJvx0VaTWhYRilMLGTBnH
   upl67LDl+5jJH7A68DuXfcZM6eXQuMh6SX8c3xdmYXGyJm/1wNcq9YHuk
   Qgfvl4SMlxMa2diZNh0bk0/vS0KF716toG61fhbaKZazhNINHlrlywmcu
   7C3vPLz5vlG4ovEARXcPR/bo3+4d74oX4BlHf2HBUEseFHwS2slFC4Whp
   7rjtR2YIfosAP8vuRd4ORZDORCWfVjVB3/fagLY4W/7Dy+2MeXesX3poi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="372791950"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="372791950"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 02:32:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="781882"
Received: from amyachev-mobl3.ccr.corp.intel.com (HELO localhost) ([10.252.49.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 02:31:54 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/1] x86/PCI: Clean up open-coded return code mangling
Date:   Fri, 27 Oct 2023 12:31:58 +0300
Message-Id: <20231027093158.19171-1-ilpo.jarvinen@linux.intel.com>
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

PCI BIOS gives a return code in 8 bits of eax register which is
extracted by open-coded masks and shifting.

Name the return code bits with a define and introduce
pcibios_get_return_code() helper to extract the return code to improve
code readability. In addition, replace a zero test with
PCIBIOS_SUCCESSFUL.

No function changes intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:
- Improve changelog
- Add helper to avoid repeating FIELD_GET()
- Reuse existing ret variable in pcibios_get_irq_routing_table()

 arch/x86/pci/pcbios.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index 4f15280732ed..01c94ac2fb70 100644
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
@@ -29,8 +31,19 @@
 #define PCIBIOS_HW_TYPE1_SPEC		0x10
 #define PCIBIOS_HW_TYPE2_SPEC		0x20
 
+/*
+ * Returned in EAX:
+ * - AH: return code
+ */
+#define PCIBIOS_RETURN_CODE			GENMASK(15, 8)
+
 int pcibios_enabled;
 
+static u8 pcibios_get_return_code(u32 eax)
+{
+	return FIELD_GET(PCIBIOS_RETURN_CODE, eax);
+}
+
 /* According to the BIOS specification at:
  * http://members.datafast.net.au/dft0802/specs/bios21.pdf, we could
  * restrict the x zone to some pages and make it ro. But this may be
@@ -154,7 +167,7 @@ static int __init check_pcibios(void)
 			: "memory");
 		local_irq_restore(flags);
 
-		status = (eax >> 8) & 0xff;
+		status = pcibios_get_return_code(eax);
 		hw_mech = eax & 0xff;
 		major_ver = (ebx >> 8) & 0xff;
 		minor_ver = ebx & 0xff;
@@ -227,7 +240,7 @@ static int pci_bios_read(unsigned int seg, unsigned int bus,
 
 	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
 
-	return (int)((result & 0xff00) >> 8);
+	return pcibios_get_return_code(result);
 }
 
 static int pci_bios_write(unsigned int seg, unsigned int bus,
@@ -269,7 +282,7 @@ static int pci_bios_write(unsigned int seg, unsigned int bus,
 
 	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
 
-	return (int)((result & 0xff00) >> 8);
+	return pcibios_get_return_code(result);
 }
 
 
@@ -385,8 +398,9 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
 		  "m" (opt)
 		: "memory");
 	DBG("OK  ret=%d, size=%d, map=%x\n", ret, opt.size, map);
-	if (ret & 0xff00)
-		printk(KERN_ERR "PCI: Error %02x when fetching IRQ routing table.\n", (ret >> 8) & 0xff);
+	ret = pcibios_get_return_code(ret);
+	if (ret)
+		printk(KERN_ERR "PCI: Error %02x when fetching IRQ routing table.\n", ret);
 	else if (opt.size) {
 		rt = kmalloc(sizeof(struct irq_routing_table) + opt.size, GFP_KERNEL);
 		if (rt) {
@@ -415,7 +429,7 @@ int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq)
 		  "b" ((dev->bus->number << 8) | dev->devfn),
 		  "c" ((irq << 8) | (pin + 10)),
 		  "S" (&pci_indirect));
-	return !(ret & 0xff00);
+	return pcibios_get_return_code(ret) == PCIBIOS_SUCCESSFUL;
 }
 EXPORT_SYMBOL(pcibios_set_irq_routing);
 
-- 
2.30.2

