Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 936EA1A62AC
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 07:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgDMFmc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 01:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbgDMFmb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Apr 2020 01:42:31 -0400
X-Greylist: delayed 500 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Apr 2020 22:42:30 PDT
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [149.28.68.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7A5C008676;
        Sun, 12 Apr 2020 22:42:30 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id B468220D27;
        Mon, 13 Apr 2020 05:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586756096; bh=7NNuWcwkDjGKg8HCsYjOihJ+QtbEgxncuKYITSJXorg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKBE5Rge5lTVMtaSEEo9wS76tW7hLJVoEclBjzgfPg5lUIPM84TVnLROuGKab0Bvm
         k5bE6v6oX1gFFB+bspWhAHTkScwbFRjZy/DH0ILXzVZZp4w9R+8e4QtwGs1FvGB0dK
         TycpL9rBiD7iMrp8m/bLDrhXE4gw+avwNZde1BTBCpLE7T8tsjqszae0dxurXjmneF
         9+egEyIF4jjkSvNFv+uFXqQOZn7VvGilMoKgW5J8mYZoA1XvePyOgJMODIVDm+b+jP
         tpOEf2XCSLVA5tnD5kG75GHMsVMcyGNU5SQOwtGniHWrLzX6avTALSPnBsh/tVvJXG
         kUw0mZ9MQrcHw==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] MIPS: Loongson64: Switch to generic PCI driver
Date:   Mon, 13 Apr 2020 13:32:13 +0800
Message-Id: <20200413053222.3976680-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200413053222.3976680-1-jiaxun.yang@flygoat.com>
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
 <20200413053222.3976680-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We can now enable generic PCI driver in Kconfig, and remove legacy
PCI driver code.

Radeon vbios quirk is moved to the platform folder to fit the
new structure.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig                  |   1 +
 arch/mips/loongson64/Makefile      |   2 +-
 arch/mips/loongson64/vbios_quirk.c |  29 ++++++++
 arch/mips/pci/Makefile             |   1 -
 arch/mips/pci/fixup-loongson3.c    |  71 ------------------
 arch/mips/pci/ops-loongson3.c      | 116 -----------------------------
 6 files changed, 31 insertions(+), 189 deletions(-)
 create mode 100644 arch/mips/loongson64/vbios_quirk.c
 delete mode 100644 arch/mips/pci/fixup-loongson3.c
 delete mode 100644 arch/mips/pci/ops-loongson3.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 690718b3701a..345a988fa637 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -477,6 +477,7 @@ config MACH_LOONGSON64
 	select IRQ_MIPS_CPU
 	select NR_CPUS_DEFAULT_4
 	select USE_GENERIC_EARLY_PRINTK_8250
+	select PCI_DRIVERS_GENERIC
 	select SYS_HAS_CPU_LOONGSON64
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_SMP
diff --git a/arch/mips/loongson64/Makefile b/arch/mips/loongson64/Makefile
index b7f40b179c71..f04461839540 100644
--- a/arch/mips/loongson64/Makefile
+++ b/arch/mips/loongson64/Makefile
@@ -8,6 +8,6 @@ obj-$(CONFIG_MACH_LOONGSON64) += cop2-ex.o platform.o acpi_init.o dma.o \
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_NUMA)	+= numa.o
 obj-$(CONFIG_RS780_HPET) += hpet.o
-obj-$(CONFIG_PCI) += pci.o
 obj-$(CONFIG_LOONGSON_MC146818) += rtc.o
 obj-$(CONFIG_SUSPEND) += pm.o
+obj-$(CONFIG_PCI_QUIRKS) += vbios_quirk.o
diff --git a/arch/mips/loongson64/vbios_quirk.c b/arch/mips/loongson64/vbios_quirk.c
new file mode 100644
index 000000000000..1f0a462aeddd
--- /dev/null
+++ b/arch/mips/loongson64/vbios_quirk.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/pci.h>
+#include <loongson.h>
+
+static void pci_fixup_radeon(struct pci_dev *pdev)
+{
+	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
+
+	if (res->start)
+		return;
+
+	if (!loongson_sysconf.vgabios_addr)
+		return;
+
+	pci_disable_rom(pdev);
+	if (res->parent)
+		release_resource(res);
+
+	res->start = virt_to_phys((void *) loongson_sysconf.vgabios_addr);
+	res->end   = res->start + 256*1024 - 1;
+	res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
+		     IORESOURCE_PCI_FIXED;
+
+	dev_info(&pdev->dev, "BAR %d: assigned %pR for Radeon ROM\n",
+		 PCI_ROM_RESOURCE, res);
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, 0x9615,
+				PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_radeon);
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 342ce10ef593..438f10955d89 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -35,7 +35,6 @@ obj-$(CONFIG_LASAT)		+= pci-lasat.o
 obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
 obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
 obj-$(CONFIG_LEMOTE_MACH2F)	+= fixup-lemote2f.o ops-loongson2.o
-obj-$(CONFIG_MACH_LOONGSON64)	+= fixup-loongson3.o ops-loongson3.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o pci-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/fixup-loongson3.c b/arch/mips/pci/fixup-loongson3.c
deleted file mode 100644
index 8a741c2c6685..000000000000
--- a/arch/mips/pci/fixup-loongson3.c
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * fixup-loongson3.c
- *
- * Copyright (C) 2012 Lemote, Inc.
- * Author: Xiang Yu, xiangy@lemote.com
- *         Chen Huacai, chenhc@lemote.com
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- * WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- * NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- * USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-#include <linux/pci.h>
-#include <boot_param.h>
-
-static void print_fixup_info(const struct pci_dev *pdev)
-{
-	dev_info(&pdev->dev, "Device %x:%x, irq %d\n",
-			pdev->vendor, pdev->device, pdev->irq);
-}
-
-int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	print_fixup_info(dev);
-	return dev->irq;
-}
-
-static void pci_fixup_radeon(struct pci_dev *pdev)
-{
-	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
-
-	if (res->start)
-		return;
-
-	if (!loongson_sysconf.vgabios_addr)
-		return;
-
-	pci_disable_rom(pdev);
-	if (res->parent)
-		release_resource(res);
-
-	res->start = virt_to_phys((void *) loongson_sysconf.vgabios_addr);
-	res->end   = res->start + 256*1024 - 1;
-	res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
-		     IORESOURCE_PCI_FIXED;
-
-	dev_info(&pdev->dev, "BAR %d: assigned %pR for Radeon ROM\n",
-		 PCI_ROM_RESOURCE, res);
-}
-
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
-				PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_radeon);
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
diff --git a/arch/mips/pci/ops-loongson3.c b/arch/mips/pci/ops-loongson3.c
deleted file mode 100644
index 2f6ad36bdea6..000000000000
--- a/arch/mips/pci/ops-loongson3.c
+++ /dev/null
@@ -1,116 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-
-#include <asm/mips-boards/bonito64.h>
-
-#include <loongson.h>
-
-#define PCI_ACCESS_READ  0
-#define PCI_ACCESS_WRITE 1
-
-#define HT1LO_PCICFG_BASE      0x1a000000
-#define HT1LO_PCICFG_BASE_TP1  0x1b000000
-
-static int loongson3_pci_config_access(unsigned char access_type,
-		struct pci_bus *bus, unsigned int devfn,
-		int where, u32 *data)
-{
-	unsigned char busnum = bus->number;
-	int function = PCI_FUNC(devfn);
-	int device = PCI_SLOT(devfn);
-	int reg = where & ~3;
-	void *addrp;
-	u64 addr;
-
-	if (where < PCI_CFG_SPACE_SIZE) { /* standard config */
-		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
-		if (busnum == 0) {
-			if (device > 31)
-				return PCIBIOS_DEVICE_NOT_FOUND;
-			addrp = (void *)TO_UNCAC(HT1LO_PCICFG_BASE | addr);
-		} else {
-			addrp = (void *)TO_UNCAC(HT1LO_PCICFG_BASE_TP1 | addr);
-		}
-	} else if (where < PCI_CFG_SPACE_EXP_SIZE) {  /* extended config */
-		struct pci_dev *rootdev;
-
-		rootdev = pci_get_domain_bus_and_slot(0, 0, 0);
-		if (!rootdev)
-			return PCIBIOS_DEVICE_NOT_FOUND;
-
-		addr = pci_resource_start(rootdev, 3);
-		if (!addr)
-			return PCIBIOS_DEVICE_NOT_FOUND;
-
-		addr |= busnum << 20 | device << 15 | function << 12 | reg;
-		addrp = (void *)TO_UNCAC(addr);
-	} else {
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
-	if (access_type == PCI_ACCESS_WRITE)
-		writel(*data, addrp);
-	else {
-		*data = readl(addrp);
-		if (*data == 0xffffffff) {
-			*data = -1;
-			return PCIBIOS_DEVICE_NOT_FOUND;
-		}
-	}
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int loongson3_pci_pcibios_read(struct pci_bus *bus, unsigned int devfn,
-				 int where, int size, u32 *val)
-{
-	u32 data = 0;
-	int ret = loongson3_pci_config_access(PCI_ACCESS_READ,
-			bus, devfn, where, &data);
-
-	if (ret != PCIBIOS_SUCCESSFUL)
-		return ret;
-
-	if (size == 1)
-		*val = (data >> ((where & 3) << 3)) & 0xff;
-	else if (size == 2)
-		*val = (data >> ((where & 3) << 3)) & 0xffff;
-	else
-		*val = data;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int loongson3_pci_pcibios_write(struct pci_bus *bus, unsigned int devfn,
-				  int where, int size, u32 val)
-{
-	u32 data = 0;
-	int ret;
-
-	if (size == 4)
-		data = val;
-	else {
-		ret = loongson3_pci_config_access(PCI_ACCESS_READ,
-				bus, devfn, where, &data);
-		if (ret != PCIBIOS_SUCCESSFUL)
-			return ret;
-
-		if (size == 1)
-			data = (data & ~(0xff << ((where & 3) << 3))) |
-			    (val << ((where & 3) << 3));
-		else if (size == 2)
-			data = (data & ~(0xffff << ((where & 3) << 3))) |
-			    (val << ((where & 3) << 3));
-	}
-
-	ret = loongson3_pci_config_access(PCI_ACCESS_WRITE,
-			bus, devfn, where, &data);
-
-	return ret;
-}
-
-struct pci_ops loongson_pci_ops = {
-	.read = loongson3_pci_pcibios_read,
-	.write = loongson3_pci_pcibios_write
-};
-- 
2.26.0.rc2

