Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB8A7DCB64
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 12:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343970AbjJaLGM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 07:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjJaLGL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 07:06:11 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 04:06:06 PDT
Received: from smtp.missinglinkelectronics.com (smtp.missinglinkelectronics.com [162.55.135.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E14CA1;
        Tue, 31 Oct 2023 04:06:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.missinglinkelectronics.com (Postfix) with ESMTP id A1EC020230;
        Tue, 31 Oct 2023 11:58:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at missinglinkelectronics.com
Received: from smtp.missinglinkelectronics.com ([127.0.0.1])
        by localhost (mail.missinglinkelectronics.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y36R_lier1a7; Tue, 31 Oct 2023 11:58:33 +0100 (CET)
Received: from nucnuc.mle (ppp-88-217-64-136.dynamic.mnet-online.de [88.217.64.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: david)
        by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id C2B0620028;
        Tue, 31 Oct 2023 11:58:32 +0100 (CET)
Date:   Tue, 31 Oct 2023 11:58:27 +0100
From:   David Epping <david.epping@missinglinkelectronics.com>
To:     linux-arm-kernel@lists.infradead.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: arm: mach-socfpga: PCIe Root IO TLP support for Cyclone V
Message-ID: <ZUDd04c7FXUeusxK@nucnuc.mle>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello ARM PCIe and especially Intel Altera SOCFPGA maintainers,

the Intel Altera Cyclone V PCIe Root Complex drivers afaik currently don’t support sending IO TLPs.
The Root Complex IP Core, seemingly unlike many other ARM Root Complexes, does not offer a memory mapping for the IO address space, but instead relies on indirect addressing via address and data registers. To my knowledge this IO space access has not been implemented in Linux, yet, and is currently only used for PCIe Configuration TLPs on this hardware, which use the same mechanism.

To support an AX99100 endpoint (which requires IO BARs for some of its features) connected to a Cyclone V PCIe root, we added support for IO TLPs to Kernels 4.14, 5.4, and 5.15.
For your reference the 4.14 patches are attached. They do _not_ apply to current mainline Linux and are meant to give you an idea of our current approach.
As you can see, in order to implement our own inb() and outb() family of functions, we had to remove multi-platform support for ARCH_SOCFPGA.

I would like to get some feedback on:
a) Are you interested in adding IO TLP support for this FPGA/CPU to mainline? We would implement patches for the current mainline in that case and post them for discussion.
b) Do you see an option to implement the IO space access functions without dropping multi-platform support? Is that a prerequisite for going mainline?

Thanks for your comments,
David


Signed-off-by: David Epping <david.epping@missinglinkelectronics.com>
---
 arch/arm/Kconfig                              |  28 ++
 arch/arm/configs/socfpga_defconfig            |   2 -
 arch/arm/mach-socfpga/Kconfig                 |  13 -
 arch/arm/mach-socfpga/Makefile                |   1 +
 arch/arm/mach-socfpga/Makefile.boot           |   1 +
 arch/arm/mach-socfpga/include/mach/io.h       | 269 ++++++++++++++++++
 arch/arm/mach-socfpga/include/mach/pcie.h     |  23 ++
 .../mach-socfpga/include/mach/uncompress.h    |   8 +
 arch/arm/mach-socfpga/pcie.c                  |  17 ++
 drivers/pci/host/pcie-altera.c                | 230 ++++++++++++++-
 10 files changed, 574 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/Makefile.boot
 create mode 100644 arch/arm/mach-socfpga/include/mach/io.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/pcie.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-socfpga/pcie.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 133128677d9d..6136337c6942 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -644,6 +644,34 @@ config ARCH_OMAP1
 	help
 	  Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
 
+config ARCH_SOCFPGA
+	bool "Altera SOCFPGA family"
+	depends on MMU
+	select ARM_HAS_SG_CHAIN
+	select ARM_PATCH_PHYS_VIRT
+	select AUTO_ZRELADDR
+	select TIMER_OF
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select MIGHT_HAVE_PCI
+	select MULTI_IRQ_HANDLER
+	select PCI_DOMAINS if PCI
+	select SPARSE_IRQ
+	select USE_OF
+	select MIGHT_HAVE_CACHE_L2X0
+	select CPU_V7
+	select HAVE_SMP
+	select ARCH_SUPPORTS_BIG_ENDIAN
+	select ARM_AMBA
+	select ARM_GIC
+	select CACHE_L2X0
+	select DW_APB_TIMER_OF
+	select GPIO_PL061 if GPIOLIB
+	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD if SMP
+	select MFD_SYSCON
+	select NEED_MACH_IO_H if PCI
+
 endchoice
 
 menu "Multiple platform selection"
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 371fca4e1ab7..fc3c096f695c 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -24,7 +24,6 @@ CONFIG_PCIE_ALTERA=y
 CONFIG_PCIE_ALTERA_MSI=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -60,7 +59,6 @@ CONFIG_MTD_SPI_NOR=y
 # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
 CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_OF_OVERLAY=y
-CONFIG_OF_CONFIGFS=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_BLK_DEV_RAM_SIZE=8192
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index d0f62eacf59d..a528c832fff2 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -1,16 +1,3 @@
-menuconfig ARCH_SOCFPGA
-	bool "Altera SOCFPGA family"
-	depends on ARCH_MULTI_V7
-	select ARCH_SUPPORTS_BIG_ENDIAN
-	select ARM_AMBA
-	select ARM_GIC
-	select CACHE_L2X0
-	select DW_APB_TIMER_OF
-	select GPIO_PL061 if GPIOLIB
-	select HAVE_ARM_SCU
-	select HAVE_ARM_TWD if SMP
-	select MFD_SYSCON
-
 if ARCH_SOCFPGA
 config SOCFPGA_SUSPEND
 	bool "Suspend to RAM on SOCFPGA"
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 9ec31fad7136..d1a060108a05 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-y					:= socfpga.o
+obj-$(CONFIG_PCI)	+= pcie.o
 obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o
 obj-$(CONFIG_SOCFPGA_SUSPEND)	+= pm.o self-refresh.o
 obj-$(CONFIG_EDAC_ALTERA_L2C)	+= l2_cache.o
diff --git a/arch/arm/mach-socfpga/Makefile.boot b/arch/arm/mach-socfpga/Makefile.boot
new file mode 100644
index 000000000000..fdffa2a0fd7b
--- /dev/null
+++ b/arch/arm/mach-socfpga/Makefile.boot
@@ -0,0 +1 @@
+# placeholder
diff --git a/arch/arm/mach-socfpga/include/mach/io.h b/arch/arm/mach-socfpga/include/mach/io.h
new file mode 100644
index 000000000000..aebb39cc8e7d
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/io.h
@@ -0,0 +1,269 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * arch/arm/mach-socfpga/include/mach/io.h
+ *
+ * based on arch/arm/mach-ixp4xx/include/mach/io.h
+ */
+
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#include <mach/pcie.h>
+
+
+#ifndef CONFIG_PCI
+
+#define __io(v)		__typesafe_io(v)
+
+#else
+
+/*
+ * Altera SOCFPGA does not have a transparent cpu -> PCI I/O translation
+ * window.  Instead, it has a set of registers that must be tweaked
+ * with the proper byte lanes, command types, and address for the
+ * transaction.  This means that we need to override the default
+ * I/O functions.
+ */
+
+#define outb outb
+static inline void outb(u8 value, u32 addr)
+{
+	if (mach_socfpga_pci_io_ops && mach_socfpga_pci_io_priv)
+		mach_socfpga_pci_io_ops->outb(value, addr, mach_socfpga_pci_io_priv);
+}
+
+#define outsb outsb
+static inline void outsb(u32 io_addr, const void *p, u32 count)
+{
+	const u8 *vaddr = p;
+	while (count--)
+		outb(*vaddr++, io_addr);
+}
+
+#define outw outw
+static inline void outw(u16 value, u32 addr)
+{
+	if (mach_socfpga_pci_io_ops && mach_socfpga_pci_io_priv)
+		mach_socfpga_pci_io_ops->outw(value, addr, mach_socfpga_pci_io_priv);
+}
+
+#define outsw outsw
+static inline void outsw(u32 io_addr, const void *p, u32 count)
+{
+	const u16 *vaddr = p;
+	while (count--)
+		outw(cpu_to_le16(*vaddr++), io_addr);
+}
+
+#define outl outl
+static inline void outl(u32 value, u32 addr)
+{
+	if (mach_socfpga_pci_io_ops && mach_socfpga_pci_io_priv)
+		mach_socfpga_pci_io_ops->outl(value, addr, mach_socfpga_pci_io_priv);
+}
+
+#define outsl outsl
+static inline void outsl(u32 io_addr, const void *p, u32 count)
+{
+	const u32 *vaddr = p;
+	while (count--)
+		outl(cpu_to_le32(*vaddr++), io_addr);
+}
+
+#define inb inb
+static inline u8 inb(u32 addr)
+{
+	if (mach_socfpga_pci_io_ops && mach_socfpga_pci_io_priv)
+		return mach_socfpga_pci_io_ops->inb(addr, mach_socfpga_pci_io_priv);
+	else
+		return 0xff;
+}
+
+#define insb insb
+static inline void insb(u32 io_addr, void *p, u32 count)
+{
+	u8 *vaddr = p;
+	while (count--)
+		*vaddr++ = inb(io_addr);
+}
+
+#define inw inw
+static inline u16 inw(u32 addr)
+{
+	if (mach_socfpga_pci_io_ops && mach_socfpga_pci_io_priv)
+		return mach_socfpga_pci_io_ops->inw(addr, mach_socfpga_pci_io_priv);
+	else
+		return 0xffff;
+}
+
+#define insw insw
+static inline void insw(u32 io_addr, void *p, u32 count)
+{
+	u16 *vaddr = p;
+	while (count--)
+		*vaddr++ = le16_to_cpu(inw(io_addr));
+}
+
+#define inl inl
+static inline u32 inl(u32 addr)
+{
+	if (mach_socfpga_pci_io_ops && mach_socfpga_pci_io_priv)
+		return mach_socfpga_pci_io_ops->inl(addr, mach_socfpga_pci_io_priv);
+	else
+		return 0xffffffff;
+}
+
+#define insl insl
+static inline void insl(u32 io_addr, void *p, u32 count)
+{
+	u32 *vaddr = p;
+	while (count--)
+		*vaddr++ = le32_to_cpu(inl(io_addr));
+}
+
+
+#define PIO_OFFSET      0x10000UL /* FIXME */
+#define PIO_MASK        0x0ffffUL
+
+#define	__is_io_address(p)	(((unsigned long)p >= PIO_OFFSET) && \
+					((unsigned long)p <= (PIO_MASK + PIO_OFFSET)))
+
+#define	ioread8(p)			ioread8(p)
+static inline u8 ioread8(const void __iomem *addr)
+{
+	unsigned long port = (unsigned long __force)addr;
+	if (__is_io_address(port))
+		return (unsigned int)inb(port & PIO_MASK);
+	else
+		return (unsigned int)__raw_readb(addr);
+}
+
+#define	ioread8_rep(p, v, c)		ioread8_rep(p, v, c)
+static inline void ioread8_rep(const void __iomem *addr, void *vaddr, u32 count)
+{
+	unsigned long port = (unsigned long __force)addr;
+	if (__is_io_address(port))
+		insb(port & PIO_MASK, vaddr, count);
+	else
+		__raw_readsb(addr, vaddr, count);
+}
+
+#define	ioread16(p)			ioread16(p)
+static inline u16 ioread16(const void __iomem *addr)
+{
+	unsigned long port = (unsigned long __force)addr;
+	if (__is_io_address(port))
+		return	(unsigned int)inw(port & PIO_MASK);
+	else
+		return le16_to_cpu((__force __le16)__raw_readw(addr));
+}
+
+#define	ioread16_rep(p, v, c)		ioread16_rep(p, v, c)
+static inline void ioread16_rep(const void __iomem *addr, void *vaddr,
+				u32 count)
+{
+	unsigned long port = (unsigned long __force)addr;
+	if (__is_io_address(port))
+		insw(port & PIO_MASK, vaddr, count);
+	else
+		__raw_readsw(addr, vaddr, count);
+}
+
+#define	ioread32(p)			ioread32(p)
+static inline u32 ioread32(const void __iomem *addr)
+{
+	unsigned long port = (unsigned long __force)addr;
+	if (__is_io_address(port))
+		return	(unsigned int)inl(port & PIO_MASK);
+	else
+		return le32_to_cpu((__force __le32)__raw_readl(addr));
+}
+
+#define	ioread32_rep(p, v, c)		ioread32_rep(p, v, c)
+static inline void ioread32_rep(const void __iomem *addr, void *vaddr,
+				u32 count)
+{
+	unsigned long port = (unsigned long __force)addr;
+	if (__is_io_address(port))
+		insl(port & PIO_MASK, vaddr, count);
+	else
+		__raw_readsl(addr, vaddr, count);
+}
+
+#define	iowrite8(v, p)			iowrite8(v, p)
+static inline void iowrite8(u8 value, void __iomem *addr)
+{
+	unsigned long port = (unsigned long __force)addr;
+	if (__is_io_address(port))
+		outb(value, port & PIO_MASK);
+	else
+		__raw_writeb(value, addr);
+}
+
+#define	iowrite8_rep(p, v, c)		iowrite8_rep(p, v, c)
+static inline void iowrite8_rep(void __iomem *addr, const void *vaddr,
+				u32 count)
+{
+	unsigned long port = (unsigned long __force)addr;
+	if (__is_io_address(port))
+		outsb(port & PIO_MASK, vaddr, count);
+	else
+		__raw_writesb(addr, vaddr, count);
+}
+
+#define	iowrite16(v, p)			iowrite16(v, p)
+static inline void iowrite16(u16 value, void __iomem *addr)
+{
+	unsigned long port = (unsigned long __force)addr;
+	if (__is_io_address(port))
+		outw(value, port & PIO_MASK);
+	else
+		__raw_writew(cpu_to_le16(value), addr);
+}
+
+#define	iowrite16_rep(p, v, c)		iowrite16_rep(p, v, c)
+static inline void iowrite16_rep(void __iomem *addr, const void *vaddr,
+				 u32 count)
+{
+	unsigned long port = (unsigned long __force)addr;
+	if (__is_io_address(port))
+		outsw(port & PIO_MASK, vaddr, count);
+	else
+		__raw_writesw(addr, vaddr, count);
+}
+
+#define	iowrite32(v, p)			iowrite32(v, p)
+static inline void iowrite32(u32 value, void __iomem *addr)
+{
+	unsigned long port = (unsigned long __force)addr;
+	if (__is_io_address(port))
+		outl(value, port & PIO_MASK);
+	else
+		__raw_writel((u32 __force)cpu_to_le32(value), addr);
+}
+
+#define	iowrite32_rep(p, v, c)		iowrite32_rep(p, v, c)
+static inline void iowrite32_rep(void __iomem *addr, const void *vaddr,
+				 u32 count)
+{
+	unsigned long port = (unsigned long __force)addr;
+	if (__is_io_address(port))
+		outsl(port & PIO_MASK, vaddr, count);
+	else
+		__raw_writesl(addr, vaddr, count);
+}
+
+#define ioport_map(port, nr) ioport_map(port, nr)
+static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
+{
+	return ((void __iomem*)((port) + PIO_OFFSET));
+}
+
+#define	ioport_unmap(addr) ioport_unmap(addr)
+static inline void ioport_unmap(void __iomem *addr)
+{
+}
+
+#endif /* CONFIG_PCI */
+
+#endif /* __ASM_ARM_ARCH_IO_H */
diff --git a/arch/arm/mach-socfpga/include/mach/pcie.h b/arch/arm/mach-socfpga/include/mach/pcie.h
new file mode 100644
index 000000000000..9eb9e6f4fa94
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/pcie.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __MACH_SOCFPGA_PCIE_H
+#define __MACH_SOCFPGA_PCIE_H
+
+#include <linux/types.h>
+
+
+struct pci_io_ops {
+	void (*outb)(u8 value, u32 addr, void *priv);
+	void (*outw)(u16 value, u32 addr, void *priv);
+	void (*outl)(u32 value, u32 addr, void *priv);
+	u8 (*inb)(u32 addr, void *priv);
+	u16 (*inw)(u32 addr, void *priv);
+	u32 (*inl)(u32 addr, void *priv);
+};
+
+extern struct pci_io_ops *mach_socfpga_pci_io_ops;
+extern void *mach_socfpga_pci_io_priv;
+
+extern void mach_socfpga_set_pci_io_ops(struct pci_io_ops *ops, void *priv);
+
+#endif /* __MACH_SOCFPGA_PCIE_H */
diff --git a/arch/arm/mach-socfpga/include/mach/uncompress.h b/arch/arm/mach-socfpga/include/mach/uncompress.h
new file mode 100644
index 000000000000..ff0b227290cb
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/uncompress.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifdef CONFIG_DEBUG_UNCOMPRESS
+extern void putc(int c);
+#else
+static inline void putc(int c) {}
+#endif
+static inline void flush(void) {}
+static inline void arch_decomp_setup(void) {}
diff --git a/arch/arm/mach-socfpga/pcie.c b/arch/arm/mach-socfpga/pcie.c
new file mode 100644
index 000000000000..dd944b1a31ae
--- /dev/null
+++ b/arch/arm/mach-socfpga/pcie.c
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/module.h>
+#include <mach/pcie.h>
+
+
+struct pci_io_ops *mach_socfpga_pci_io_ops = NULL;
+EXPORT_SYMBOL(mach_socfpga_pci_io_ops);
+void *mach_socfpga_pci_io_priv = NULL;
+EXPORT_SYMBOL(mach_socfpga_pci_io_priv);
+
+void mach_socfpga_set_pci_io_ops(struct pci_io_ops *ops, void *priv)
+{
+	mach_socfpga_pci_io_ops = ops;
+	mach_socfpga_pci_io_priv = priv;
+}
+EXPORT_SYMBOL(mach_socfpga_set_pci_io_ops);
diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index b468b8cccf8d..3f46b6212595 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
@@ -28,6 +29,9 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include <mach/pcie.h>
+
+
 #define RP_TX_REG0			0x2000
 #define RP_TX_REG1			0x2004
 #define RP_TX_CNTRL			0x2008
@@ -47,11 +51,14 @@
 #define LTSSM_L0			0xf
 
 #define PCIE_CAP_OFFSET			0x80
-/* TLP configuration type 0 and 1 */
+#define DWORD_MASK			3
+/* TLP IO and configuration type 0 and 1 */
 #define TLP_FMTTYPE_CFGRD0		0x04	/* Configuration Read Type 0 */
 #define TLP_FMTTYPE_CFGWR0		0x44	/* Configuration Write Type 0 */
 #define TLP_FMTTYPE_CFGRD1		0x05	/* Configuration Read Type 1 */
 #define TLP_FMTTYPE_CFGWR1		0x45	/* Configuration Write Type 1 */
+#define TLP_FMTTYPE_IORD		0x02	/* I/O Read */
+#define TLP_FMTTYPE_IOWR		0x42	/* I/O Write */
 #define TLP_PAYLOAD_SIZE		0x01
 #define TLP_READ_TAG			0x1d
 #define TLP_WRITE_TAG			0x10
@@ -69,6 +76,11 @@
     (((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
 #define TLP_CFG_DW2(bus, devfn, offset)	\
 				(((bus) << 24) | ((devfn) << 16) | (offset))
+#define TLP_IO_DW0(fmt_type) (((fmt_type) << 24) | TLP_PAYLOAD_SIZE)
+#define TLP_IO_DW1(pcie, tag, be)	\
+		(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | \
+		(tag << 8) | (be))
+#define TLP_IO_DW2(addr) (addr & ~DWORD_MASK)
 #define TLP_COMP_STATUS(s)		(((s) >> 13) & 7)
 #define TLP_HDR_SIZE			3
 #define TLP_LOOP			500
@@ -76,10 +88,10 @@
 #define LINK_UP_TIMEOUT			HZ
 #define LINK_RETRAIN_TIMEOUT		HZ
 
-#define DWORD_MASK			3
 
 struct altera_pcie {
 	struct platform_device	*pdev;
+	struct mutex		lock;	/* protect Cra TLP interface */
 	void __iomem		*cra_base;	/* DT Cra */
 	int			irq;
 	u8			root_bus_nr;
@@ -129,6 +141,20 @@ static bool altera_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
 	return false;
 }
 
+/*
+ * Altera PCIe port does not implement IO base and limit registers.
+ * Fake at least IO base to enumerate devices correctly.
+ */
+static u32 altera_pcie_read_io_base(struct pci_bus *bus, unsigned int  devfn,
+				     int offset)
+{
+	if (pci_is_root_bus(bus) && (devfn == 0) &&
+	    (offset == PCI_IO_BASE))
+		return 0xf0;
+
+	return 0;
+}
+
 static void tlp_write_tx(struct altera_pcie *pcie,
 			 struct tlp_rp_regpair_t *tlp_rp_regdata)
 {
@@ -223,14 +249,18 @@ static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
 			      int where, u8 byte_en, u32 *value)
 {
 	u32 headers[TLP_HDR_SIZE];
+	int ret;
 
 	headers[0] = TLP_CFGRD_DW0(pcie, bus);
 	headers[1] = TLP_CFG_DW1(pcie, TLP_READ_TAG, byte_en);
 	headers[2] = TLP_CFG_DW2(bus, devfn, where);
 
+	mutex_lock(&pcie->lock);
 	tlp_write_packet(pcie, headers, 0, false);
+	ret = tlp_read_packet(pcie, value);
+	mutex_unlock(&pcie->lock);
 
-	return tlp_read_packet(pcie, value);
+	return ret;
 }
 
 static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
@@ -243,6 +273,7 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 	headers[1] = TLP_CFG_DW1(pcie, TLP_WRITE_TAG, byte_en);
 	headers[2] = TLP_CFG_DW2(bus, devfn, where);
 
+	mutex_lock(&pcie->lock);
 	/* check alignment to Qword */
 	if ((where & 0x7) == 0)
 		tlp_write_packet(pcie, headers, value, true);
@@ -250,6 +281,7 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 		tlp_write_packet(pcie, headers, value, false);
 
 	ret = tlp_read_packet(pcie, NULL);
+	mutex_unlock(&pcie->lock);
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
 
@@ -338,6 +370,10 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
 	if (altera_pcie_hide_rc_bar(bus, devfn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
+	*value = altera_pcie_read_io_base(bus, devfn, where);
+	if (*value)
+		return PCIBIOS_SUCCESSFUL;
+
 	if (!altera_pcie_valid_device(pcie, bus, PCI_SLOT(devfn))) {
 		*value = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -367,6 +403,168 @@ static struct pci_ops altera_pcie_ops = {
 	.write = altera_pcie_cfg_write,
 };
 
+static void get_tlp_io_header(struct altera_pcie *pcie, u32 addr, u8 byte_en,
+			      bool read, u32 *headers)
+{
+	u8 io = read ? TLP_FMTTYPE_IORD : TLP_FMTTYPE_IOWR;
+	u8 tag = read ? TLP_READ_TAG : TLP_WRITE_TAG;
+
+	headers[0] = TLP_IO_DW0(io);
+	headers[1] = TLP_IO_DW1(pcie, tag, byte_en);
+	headers[2] = TLP_IO_DW2(addr);
+}
+
+static int tlp_io_dword_read(struct altera_pcie *pcie, u32 addr, u8 byte_en,
+			     u32 *value)
+{
+	u32 headers[TLP_HDR_SIZE];
+	int ret;
+
+	addr &= ~DWORD_MASK;
+
+	get_tlp_io_header(pcie, addr, byte_en, true, headers);
+
+	mutex_lock(&pcie->lock);
+	tlp_write_packet(pcie, headers, 0, false);
+	ret = tlp_read_packet(pcie, value);
+	mutex_unlock(&pcie->lock);
+
+	return ret;
+}
+
+static int tlp_io_dword_write(struct altera_pcie *pcie, u32 addr, u8 byte_en,
+			      u32 value)
+{
+	u32 headers[TLP_HDR_SIZE];
+	int ret;
+
+	addr &= ~DWORD_MASK;
+
+	get_tlp_io_header(pcie, addr, byte_en, false, headers);
+
+	mutex_lock(&pcie->lock);
+	/* FIXME necessary to check alignment to Qword ? */
+	if ((addr & 0x7) == 0)
+		tlp_write_packet(pcie, headers, value, true);
+	else
+		tlp_write_packet(pcie, headers, value, false);
+	ret = tlp_read_packet(pcie, NULL);
+	mutex_unlock(&pcie->lock);
+
+	return ret;
+}
+
+static void altera_pcie_outb(u8 value, u32 addr, void *priv)
+{
+	struct altera_pcie *pcie = (struct altera_pcie *)priv;
+	u32 val;
+	u8 be = ((0x1 << (addr & 0x3)) & 0xf);
+	u32 shift = 8 * (addr & 0x3);
+
+	val = value << shift;
+	if (tlp_io_dword_write(pcie, addr, be, val) != PCIBIOS_SUCCESSFUL) {
+		dev_err(&pcie->pdev->dev, "%s: failed to write 0x%02x to 0x%08x (0x%x)\n",
+				__func__, value, addr, be);
+	}
+	dev_dbg(&pcie->pdev->dev, "%s: wrote 0x%02x to 0x%08x (0x%x)\n",
+			__func__, value, addr, be);
+}
+
+static void altera_pcie_outw(u16 value, u32 addr, void *priv)
+{
+	struct altera_pcie *pcie = (struct altera_pcie *)priv;
+	u32 val;
+	u8 be = ((0x3 << (addr & 0x3)) & 0xf);
+	u32 shift = 8 * (addr & 0x3);
+
+	val = value << shift;
+	if (tlp_io_dword_write(pcie, addr, be, val) != PCIBIOS_SUCCESSFUL) {
+		dev_err(&pcie->pdev->dev, "%s: failed to write 0x%04x to 0x%08x (0x%x)\n",
+				__func__, value, addr, be);
+	}
+	dev_dbg(&pcie->pdev->dev, "%s: wrote 0x%04x to 0x%08x (0x%x)\n",
+			__func__, value, addr, be);
+}
+
+static void altera_pcie_outl(u32 value, u32 addr, void *priv)
+{
+	struct altera_pcie *pcie = (struct altera_pcie *)priv;
+	u32 val;
+	u8 be = 0xf;
+
+	val = value;
+	if (tlp_io_dword_write(pcie, addr, be, val) != PCIBIOS_SUCCESSFUL) {
+		dev_err(&pcie->pdev->dev, "%s: failed to write 0x%08x to 0x%08x (0x%x)\n",
+				__func__, value, addr, be);
+	}
+	dev_dbg(&pcie->pdev->dev, "%s: wrote 0x%08x to 0x%08x (0x%x)\n",
+			__func__, value, addr, be);
+}
+
+static u8 altera_pcie_inb(u32 addr, void *priv)
+{
+	struct altera_pcie *pcie = (struct altera_pcie *)priv;
+	u32 val;
+	u32 mask = 0xff;
+	u8 be = ((0x1 << (addr & 0x3)) & 0xf);
+	u32 shift = 8 * (addr & 0x3);
+
+	if (tlp_io_dword_read(pcie, addr, be, &val) != PCIBIOS_SUCCESSFUL) {
+		dev_err(&pcie->pdev->dev, "%s: failed to read from 0x%08x (0x%x)\n",
+				__func__, addr, be);
+		return mask;
+	}
+	val = (val >> shift) & mask;
+	dev_dbg(&pcie->pdev->dev, "%s: read 0x%02x from 0x%08x (0x%x)\n",
+			__func__, val, addr, be);
+	return val;
+}
+
+static u16 altera_pcie_inw(u32 addr, void *priv)
+{
+	struct altera_pcie *pcie = (struct altera_pcie *)priv;
+	u32 val;
+	u32 mask = 0xffff;
+	u8 be = ((0x3 << (addr & 0x3)) & 0xf);
+	u32 shift = 8 * (addr & 0x3);
+
+	if (tlp_io_dword_read(pcie, addr, be, &val) != PCIBIOS_SUCCESSFUL) {
+		dev_err(&pcie->pdev->dev, "%s: failed to read from 0x%08x (0x%x)\n",
+				__func__, addr, be);
+		return mask;
+	}
+	val = (val >> shift) & mask;
+	dev_dbg(&pcie->pdev->dev, "%s: read 0x%04x from 0x%08x (0x%x)\n",
+			__func__, val, addr, be);
+	return val;
+}
+
+static u32 altera_pcie_inl(u32 addr, void *priv)
+{
+	struct altera_pcie *pcie = (struct altera_pcie *)priv;
+	u32 val;
+	u32 mask = 0xffffffff;
+	u8 be = 0xf;
+
+	if (tlp_io_dword_read(pcie, addr, be, &val) != PCIBIOS_SUCCESSFUL) {
+		dev_err(&pcie->pdev->dev, "%s: failed to read from 0x%08x (0x%x)\n",
+				__func__, addr, be);
+		return mask;
+	}
+	dev_dbg(&pcie->pdev->dev, "%s: read 0x%08x from 0x%08x (0x%x)\n",
+			__func__, val, addr, be);
+	return val;
+}
+
+static struct pci_io_ops altera_pcie_io_ops = {
+	.outb = altera_pcie_outb,
+	.outw = altera_pcie_outw,
+	.outl = altera_pcie_outl,
+	.inb = altera_pcie_inb,
+	.inw = altera_pcie_inw,
+	.inl = altera_pcie_inl,
+};
+
 static int altera_read_cap_word(struct altera_pcie *pcie, u8 busno,
 				unsigned int devfn, int offset, u16 *value)
 {
@@ -501,12 +699,26 @@ static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
 	struct device *dev = &pcie->pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct resource_entry *win;
+	struct resource *res_io;
 
 	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
 					       NULL);
 	if (err)
 		return err;
 
+	/* add I/O space with indirect adressing (no memory mapping) */
+	res_io = devm_kzalloc(dev, sizeof(*res_io), GFP_KERNEL);
+	if (!res_io) {
+		err = -ENOMEM;
+		goto out_release_res;
+	}
+	res_io->name = "PCI I/O Space";
+	res_io->start = 0x00000000;
+	res_io->end = 0x0000ffff;
+	res_io->flags = IORESOURCE_IO;
+	dev_info(dev, "adding indirect (not memory mapped) I/O space\n");
+	pci_add_resource(&pcie->resources, res_io);
+
 	err = devm_request_pci_bus_resources(dev, &pcie->resources);
 	if (err)
 		goto out_release_res;
@@ -586,6 +798,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pcie = pci_host_bridge_priv(bridge);
+	mutex_init(&pcie->lock);
 	pcie->pdev = pdev;
 
 	ret = altera_pcie_parse_dt(pcie);
@@ -594,6 +807,9 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* register IO port functions with architecture code */
+	mach_socfpga_set_pci_io_ops(&altera_pcie_io_ops, (void *)pcie);
+
 	INIT_LIST_HEAD(&pcie->resources);
 
 	ret = altera_pcie_parse_request_of_pci_ranges(pcie);
@@ -638,6 +854,13 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int altera_pcie_remove(struct platform_device *pdev)
+{
+	mach_socfpga_set_pci_io_ops(NULL, NULL);
+
+	return 0;
+}
+
 static const struct of_device_id altera_pcie_of_match[] = {
 	{ .compatible = "altr,pcie-root-port-1.0", },
 	{},
@@ -645,6 +868,7 @@ static const struct of_device_id altera_pcie_of_match[] = {
 
 static struct platform_driver altera_pcie_driver = {
 	.probe		= altera_pcie_probe,
+	.remove		= altera_pcie_remove,
 	.driver = {
 		.name	= "altera-pcie",
 		.of_match_table = altera_pcie_of_match,
-- 
2.34.1

