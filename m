Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EC2386DD8
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 01:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbhEQXmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 19:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbhEQXmj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 19:42:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEFBC061573;
        Mon, 17 May 2021 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MnMj74KXhV3+TXnR+Dv4oyS7SdPdtspG4Ki9oO0f748=; b=ZVmVK7qxd+9Kq864/jPrSthfUH
        xD7ZYoLiCm7EwyfZi2mTRV65en7zjx1hfYqtojgkAnFzuIrTIQLwc5gW6b937uMCmIEHQoykOa0sB
        l+GXZO480y9QDNPC9/xYanYkBdkyeuYUzJvHGdg/8OI5qrwkgd2/KnDFfWFHI0wIJtIVKbJVylkX7
        0OvD5F3TWQnKxCnW2ZphyOS/gQFXTjrWrRSmpjoEGcFreo+UTP7fhm1gmlIgf/qCF9udmpfaycEu6
        dLs7RPgK6QJB6oSaiBiUIvlvEc0/LNLM6x+Z0PHt160VIoNbJLkClLwb8qxltbTWhmjqwYzcpo01A
        G7ryYOpA==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1limrQ-00EDHU-JI; Mon, 17 May 2021 23:41:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-pci@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH v2] PCI: ftpci100: rename macro name collision
Date:   Mon, 17 May 2021 16:41:17 -0700
Message-Id: <20210517234117.3660-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI_IOSIZE is defined in mach-loongson64/spaces.h, so change the name
of the PCI_* macros in pci-ftpci100.c to use FTPCI_* so that they are
more localized and won't conflict with other drivers or arches.

../drivers/pci/controller/pci-ftpci100.c:37: warning: "PCI_IOSIZE" redefined
   37 | #define PCI_IOSIZE 0x00
      | 
In file included from ../arch/mips/include/asm/addrspace.h:13,
...              from ../drivers/pci/controller/pci-ftpci100.c:15:
arch/mips/include/asm/mach-loongson64/spaces.h:11: note: this is the location of the previous definition
   11 | #define PCI_IOSIZE SZ_16M

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Wilczyński <kw@linux.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
v2: prefix PCI_ macro names with "FT", thus use FTPCI_ for these macro names.
    (suggested by Linus Walleij)

 drivers/pci/controller/pci-ftpci100.c |   30 ++++++++++++------------
 1 file changed, 15 insertions(+), 15 deletions(-)

--- linux-next-20210514.orig/drivers/pci/controller/pci-ftpci100.c
+++ linux-next-20210514/drivers/pci/controller/pci-ftpci100.c
@@ -34,12 +34,12 @@
  * Special configuration registers directly in the first few words
  * in I/O space.
  */
-#define PCI_IOSIZE	0x00
-#define PCI_PROT	0x04 /* AHB protection */
-#define PCI_CTRL	0x08 /* PCI control signal */
-#define PCI_SOFTRST	0x10 /* Soft reset counter and response error enable */
-#define PCI_CONFIG	0x28 /* PCI configuration command register */
-#define PCI_DATA	0x2C
+#define FTPCI_IOSIZE	0x00
+#define FTPCI_PROT	0x04 /* AHB protection */
+#define FTPCI_CTRL	0x08 /* PCI control signal */
+#define FTPCI_SOFTRST	0x10 /* Soft reset counter and response error enable */
+#define FTPCI_CONFIG	0x28 /* PCI configuration command register */
+#define FTPCI_DATA	0x2C
 
 #define FARADAY_PCI_STATUS_CMD		0x04 /* Status and command */
 #define FARADAY_PCI_PMC			0x40 /* Power management control */
@@ -195,9 +195,9 @@ static int faraday_raw_pci_read_config(s
 			PCI_CONF_FUNCTION(PCI_FUNC(fn)) |
 			PCI_CONF_WHERE(config) |
 			PCI_CONF_ENABLE,
-			p->base + PCI_CONFIG);
+			p->base + FTPCI_CONFIG);
 
-	*value = readl(p->base + PCI_DATA);
+	*value = readl(p->base + FTPCI_DATA);
 
 	if (size == 1)
 		*value = (*value >> (8 * (config & 3))) & 0xFF;
@@ -230,17 +230,17 @@ static int faraday_raw_pci_write_config(
 			PCI_CONF_FUNCTION(PCI_FUNC(fn)) |
 			PCI_CONF_WHERE(config) |
 			PCI_CONF_ENABLE,
-			p->base + PCI_CONFIG);
+			p->base + FTPCI_CONFIG);
 
 	switch (size) {
 	case 4:
-		writel(value, p->base + PCI_DATA);
+		writel(value, p->base + FTPCI_DATA);
 		break;
 	case 2:
-		writew(value, p->base + PCI_DATA + (config & 3));
+		writew(value, p->base + FTPCI_DATA + (config & 3));
 		break;
 	case 1:
-		writeb(value, p->base + PCI_DATA + (config & 3));
+		writeb(value, p->base + FTPCI_DATA + (config & 3));
 		break;
 	default:
 		ret = PCIBIOS_BAD_REGISTER_NUMBER;
@@ -469,7 +469,7 @@ static int faraday_pci_probe(struct plat
 		if (!faraday_res_to_memcfg(io->start - win->offset,
 					   resource_size(io), &val)) {
 			/* setup I/O space size */
-			writel(val, p->base + PCI_IOSIZE);
+			writel(val, p->base + FTPCI_IOSIZE);
 		} else {
 			dev_err(dev, "illegal IO mem size\n");
 			return -EINVAL;
@@ -477,11 +477,11 @@ static int faraday_pci_probe(struct plat
 	}
 
 	/* Setup hostbridge */
-	val = readl(p->base + PCI_CTRL);
+	val = readl(p->base + FTPCI_CTRL);
 	val |= PCI_COMMAND_IO;
 	val |= PCI_COMMAND_MEMORY;
 	val |= PCI_COMMAND_MASTER;
-	writel(val, p->base + PCI_CTRL);
+	writel(val, p->base + FTPCI_CTRL);
 	/* Mask and clear all interrupts */
 	faraday_raw_pci_write_config(p, 0, 0, FARADAY_PCI_CTRL2 + 2, 2, 0xF000);
 	if (variant->cascaded_irq) {
