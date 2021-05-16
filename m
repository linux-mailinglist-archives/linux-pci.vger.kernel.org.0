Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43366382089
	for <lists+linux-pci@lfdr.de>; Sun, 16 May 2021 21:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhEPTBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 May 2021 15:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhEPTBe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 May 2021 15:01:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D44EC061573;
        Sun, 16 May 2021 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mob4pLAxUlZWJpyMsqST56xNsVwCyajpK9tRejB2ttc=; b=Ymi+JuCnY08/4VSY+5UwjwnLUV
        ZWKKtnF8WQHyKhhjoky3d4n++nqx09aHsQzdFjmMuyhkN3b7VENtjrAptWZgf72UJKAt4aPDrqggN
        rmi52h3gAcOtGjmQggAiJfR5NDfRGkrXTIBFTyEFGIJ4iVEJ1yOJtEUhbFpt+3g/uTPkvZBjsdGqD
        kE57hvkHph6id9zsiUee/e4wATcGg6JvVpdJetFMzJPQS43LlRcKDO+F65OW7kbDdusB57lbInBys
        FxZBy0HepZ2osLXKvM2hCnc7HPB5N5NKeGv/YXWN+jv9kyd+vDTafrnWukSXoLJGrsFRHoYoyReUN
        Emz3AUgg==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1liLzr-00D9SZ-WA; Sun, 16 May 2021 19:00:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-pci@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH] PCI: ftpci100: rename macro name collision
Date:   Sun, 16 May 2021 12:00:14 -0700
Message-Id: <20210516190014.25664-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI_IOSIZE is defined in mach-loongson64/spaces.h, so change the name
of this macro in pci-ftpci100.c.

../drivers/pci/controller/pci-ftpci100.c:37: warning: "PCI_IOSIZE" redefined
   37 | #define PCI_IOSIZE 0x00
      | 
In file included from ../arch/mips/include/asm/addrspace.h:13,
...              from ../drivers/pci/controller/pci-ftpci100.c:15:
arch/mips/include/asm/mach-loongson64/spaces.h:11: note: this is the location of the previous definition
   11 | #define PCI_IOSIZE SZ_16M

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
 drivers/pci/controller/pci-ftpci100.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210514.orig/drivers/pci/controller/pci-ftpci100.c
+++ linux-next-20210514/drivers/pci/controller/pci-ftpci100.c
@@ -34,7 +34,7 @@
  * Special configuration registers directly in the first few words
  * in I/O space.
  */
-#define PCI_IOSIZE	0x00
+#define PCI_IOLIMIT	0x00
 #define PCI_PROT	0x04 /* AHB protection */
 #define PCI_CTRL	0x08 /* PCI control signal */
 #define PCI_SOFTRST	0x10 /* Soft reset counter and response error enable */
@@ -469,7 +469,7 @@ static int faraday_pci_probe(struct plat
 		if (!faraday_res_to_memcfg(io->start - win->offset,
 					   resource_size(io), &val)) {
 			/* setup I/O space size */
-			writel(val, p->base + PCI_IOSIZE);
+			writel(val, p->base + PCI_IOLIMIT);
 		} else {
 			dev_err(dev, "illegal IO mem size\n");
 			return -EINVAL;
