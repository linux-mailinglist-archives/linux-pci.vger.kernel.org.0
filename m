Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 592AD16F3C
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2019 04:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEHCvB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 22:51:01 -0400
Received: from alpha.anastas.io ([104.248.188.109]:58029 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfEHCvA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 22:51:00 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id BA4827F8E7;
        Tue,  7 May 2019 21:41:56 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1557283317; bh=EGTrKlRnXu1zsiLLv/Fv7FG8sil5S0AhH+klcU6GwLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlDGly5XpDrBjpNOi9Nf7fW+YeMrjdtv20gQQUn+rtuu5/tvQln3k5As3jyUWvgl/
         HbQtmxPs8UXfoFVnO5Dq/k8um/OvYxaenLK3OCuMOf8pyW6Xqlm3BJlk21iSK8clGB
         GH5inQEprc53R4qVnZeIfbhG9S7mGlco0B7aFP5dCxko5NpyHJCFDT8ZK4th+osGEN
         6BFtGnErEwRNn+E3qq25XiHQuopNJdAMYKgivrOSlAmlEoiYv3quLYH4IbhTbYnPTV
         +QPgONSh8FuZKvrPqCLdaXE8IB3gFL4hQHBGzqxKyHO4J7SdR6zs3MzyewG/QrDFP1
         /UEm+XMDaPZFQ==
From:   Shawn Anastasio <shawn@anastas.io>
To:     bhelgaas@google.com
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        sbobroff@linux.ibm.com, xyjxie@linux.vnet.ibm.com,
        rppt@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/64: Enable pcibios_after_init hook on ppc64
Date:   Tue,  7 May 2019 21:41:50 -0500
Message-Id: <20190508024151.5690-3-shawn@anastas.io>
In-Reply-To: <20190508024151.5690-1-shawn@anastas.io>
References: <20190508024151.5690-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable the pcibios_after_init hook on all powerpc platforms.
This hook is executed at the end of pcibios_init and was previously
only available on CONFIG_PPC32.

Since it is useful and not inherently limited to 32-bit mode,
remove the limitation and allow it on all powerpc platforms.

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 arch/powerpc/include/asm/machdep.h | 3 +--
 arch/powerpc/kernel/pci_64.c       | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 2f0ca6560e47..2fbfaa9176ed 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -150,6 +150,7 @@ struct machdep_calls {
 	void		(*init)(void);
 
 	void		(*kgdb_map_scc)(void);
+#endif /* CONFIG_PPC32 */
 
 	/*
 	 * optional PCI "hooks"
@@ -157,8 +158,6 @@ struct machdep_calls {
 	/* Called at then very end of pcibios_init() */
 	void (*pcibios_after_init)(void);
 
-#endif /* CONFIG_PPC32 */
-
 	/* Called in indirect_* to avoid touching devices */
 	int (*pci_exclude_device)(struct pci_controller *, unsigned char, unsigned char);
 
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 9d8c10d55407..fba7fe6e4a50 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -68,6 +68,10 @@ static int __init pcibios_init(void)
 
 	printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
 
+	/* Call machine dependent post-init code */
+	if (ppc_md.pcibios_after_init)
+		ppc_md.pcibios_after_init();
+
 	return 0;
 }
 
-- 
2.20.1

