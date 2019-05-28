Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBDAC2BE14
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2019 06:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfE1EDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 May 2019 00:03:23 -0400
Received: from alpha.anastas.io ([104.248.188.109]:38347 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfE1EDX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2019 00:03:23 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id 440827F8F8;
        Mon, 27 May 2019 23:03:21 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1559016202; bh=EGTrKlRnXu1zsiLLv/Fv7FG8sil5S0AhH+klcU6GwLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYKBGgsqdfiMi1eoJOtniAmEda6YnvbaZ/xR0B+e1QfXDskdOBl9uKEbG/HJ5rd02
         Eojzh34WnSaWRbdicp15KcL1bEIzo2zeHzY2QAej2d8C2Mc7BcC5yDwbh4xpT9Dr+j
         TLQj7Jv1GMFXtuSdQGtOaGcUYRgEdmaLsYzND1BxwXSNfBUOanTOguLFLwF6Ic58MT
         DLivhV6IUEvLEK+d7DA5CDOlgePmaYfTVNi0KAGktNmY7/OyhnFZJr0jOBacDWeXY1
         /ljrUZOTUTpgPpU7VhV/Xk24WcDJpR/w9P7nM5wqJVnEWcNssHybcvOZjd2ldctfts
         gQdSuZNgFSGOw==
From:   Shawn Anastasio <shawn@anastas.io>
To:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, sbobroff@linux.ibm.com,
        xyjxie@linux.vnet.ibm.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] powerpc/64: Enable pcibios_after_init hook on ppc64
Date:   Mon, 27 May 2019 23:03:12 -0500
Message-Id: <20190528040313.35582-3-shawn@anastas.io>
In-Reply-To: <20190528040313.35582-1-shawn@anastas.io>
References: <20190528040313.35582-1-shawn@anastas.io>
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

