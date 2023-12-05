Return-Path: <linux-pci+bounces-475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F418E804F60
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 10:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE559281584
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABC35B5DD;
	Tue,  5 Dec 2023 09:55:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F44818B;
	Tue,  5 Dec 2023 01:55:37 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by sakura.ysato.name (Postfix) with ESMTPSA id 365251C0546;
	Tue,  5 Dec 2023 18:46:21 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lee Jones <lee@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Guo Ren <guoren@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Bin Meng <bmeng@tinylab.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Tom Rix <trix@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [DO NOT MERGE v5 10/37] sh: Common PCI Framework driver support.
Date: Tue,  5 Dec 2023 18:45:29 +0900
Message-Id: <ec01fdf9a91d9d1da9da08be83d5821353ac5a9d.1701768028.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1701768028.git.ysato@users.sourceforge.jp>
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add New OF based PCI Host driver.
This driver conflicts some point in legacy PCI driver.
To resolve the conflict, I made some changes to the legacy driver.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/drivers/pci/pci.c |  6 ------
 arch/sh/include/asm/io.h  |  6 ++++++
 arch/sh/include/asm/pci.h |  4 ++++
 arch/sh/kernel/iomap.c    | 24 ++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index a3903304f33f..61a19c2c9014 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -286,12 +286,6 @@ void __iomem *__pci_ioport_map(struct pci_dev *dev,
 	return (void __iomem *)(chan->io_map_base + port);
 }
 
-void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
-{
-	iounmap(addr);
-}
-EXPORT_SYMBOL(pci_iounmap);
-
 #endif /* CONFIG_GENERIC_IOMAP */
 
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index ac521f287fa5..efea1bd0a681 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -20,6 +20,7 @@
 #include <asm/page.h>
 #include <linux/pgtable.h>
 #include <asm-generic/iomap.h>
+#include <linux/ioport.h>
 
 #define __IO_PREFIX     generic
 #include <asm/io_generic.h>
@@ -317,4 +318,9 @@ unsigned long long poke_real_address_q(unsigned long long addr,
 int valid_phys_addr_range(phys_addr_t addr, size_t size);
 int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 
+#if defined(CONFIG_PCI) && !defined(CONFIG_GENERIC_IOMAP)
+#define pci_remap_iospace pci_remap_iospace
+int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
+#endif
+
 #endif /* __ASM_SH_IO_H */
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index 54c30126ea17..92b3bd604319 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_SH_PCI_H
 #define __ASM_SH_PCI_H
 
+#ifndef CONFIG_SH_DEVICE_TREE
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
    or architectures with incomplete PCI setup by the loader */
@@ -88,4 +89,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 	return hose->need_domain_info;
 }
 
+#else /* CONFIG_SH_DEVICE_TREE */
+#include <asm-generic/pci.h>
+#endif
 #endif /* __ASM_SH_PCI_H */
diff --git a/arch/sh/kernel/iomap.c b/arch/sh/kernel/iomap.c
index 0a0dff4e66de..ec68ce4e4a17 100644
--- a/arch/sh/kernel/iomap.c
+++ b/arch/sh/kernel/iomap.c
@@ -160,3 +160,27 @@ void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
 	mmio_outsl(addr, src, count);
 }
 EXPORT_SYMBOL(iowrite32_rep);
+
+#if defined(CONFIG_PCI) && !defined(CONFIG_GENERIC_IOMAP)
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+	iounmap(addr);
+}
+EXPORT_SYMBOL(pci_iounmap);
+
+int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
+{
+	unsigned long vaddr = res->start;
+
+	if (!(res->flags & IORESOURCE_IO))
+		return -EINVAL;
+
+	if (res->end > IO_SPACE_LIMIT)
+		return -EINVAL;
+
+	__set_io_port_base(phys_addr);
+	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
+				  pgprot_device(PAGE_KERNEL));
+}
+EXPORT_SYMBOL(pci_remap_iospace);
+#endif
-- 
2.39.2


