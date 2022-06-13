Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101C854A04A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351095AbiFMUyq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351439AbiFMUxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:53:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10360B91;
        Mon, 13 Jun 2022 13:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655151406; x=1686687406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rtqhOIKVfrnY98rdPBZfGpki572ZKantyZmrTYaiCUk=;
  b=EFSppI991TrHlQTLJe4TbPuC0YFST+UK9izwZzQt/4XfT2fsBjIHHTur
   DvxP2pjD2RCZGAW0D/Z+NDFQl64mqOtrIyDdLrl7A/0cThG+3ln2A/Rh+
   0m01UqGSxm8ohp0Q7nFupwv7N7GeCV6AVqch5O658XHAhvStYs3r79DzO
   Uku6SJWyxBlN8Ij+DrtM8TdJU5a2nvrMx5jsgZY4b2iZp4e2t9bZTQYnY
   JShwB0n0TIoQGGlhVKNJz4lBYznzS2IECtO24bXhQ7E+rvIvbPL1xoJoq
   xOOJQNwkdLPktNic83CDCrMixBYChH0IjtQJ6uAqtivFafONKG86SybDb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279445859"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="279445859"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 13:16:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="557942595"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 13 Jun 2022 13:16:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4190F18F; Mon, 13 Jun 2022 23:16:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 1/1] x86/PCI: Disable e820 usage for the resource allocation
Date:   Mon, 13 Jun 2022 23:16:41 +0300
Message-Id: <20220613201641.67640-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The resource management improve for PCI on x86 broke booting of Intel MID
platforms. It seems that the current code removes all available resources
from the list and none of the PCI device may be initialized. Restore the
old behaviour by force disabling the e820 usage for the resource allocation.

Fixes: 4c5e242d3e93 ("x86/PCI: Clip only host bridge windows for E820 regions")
Depends-on: fa6dae5d8208 ("x86/PCI: Add kernel cmdline options to use/ignore E820 reserved regions")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/pci_x86.h | 1 +
 arch/x86/pci/acpi.c            | 2 +-
 arch/x86/pci/intel_mid_pci.c   | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index f52a886d35cf..503f83fbc686 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -126,6 +126,7 @@ extern const struct pci_raw_ops *raw_pci_ext_ops;
 extern const struct pci_raw_ops pci_mmcfg;
 extern const struct pci_raw_ops pci_direct_conf1;
 extern bool port_cf9_safe;
+extern bool pci_use_e820;
 
 /* arch_initcall level */
 #ifdef CONFIG_PCI_DIRECT
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index a4f43054bc79..ac2f220d50fc 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -20,7 +20,7 @@ struct pci_root_info {
 #endif
 };
 
-static bool pci_use_e820 = true;
+bool pci_use_e820 = true;
 static bool pci_use_crs = true;
 static bool pci_ignore_seg;
 
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 8edd62206604..7869b86bff04 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -313,6 +313,7 @@ int __init intel_mid_pci_init(void)
 	pcibios_enable_irq = intel_mid_pci_irq_enable;
 	pcibios_disable_irq = intel_mid_pci_irq_disable;
 	pci_root_ops = intel_mid_pci_ops;
+	pci_use_e820 = false;
 	pci_soc_mode = 1;
 	/* Continue with standard init */
 	acpi_noirq_set();
-- 
2.35.1

