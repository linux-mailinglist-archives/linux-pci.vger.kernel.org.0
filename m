Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52853197B1E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgC3LpP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 07:45:15 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17820 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728764AbgC3LpO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 07:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585568663;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=6zR1IDvkP0LMZ6Y1QTmVvc1RpE6FI+SEHibXscQB6uE=;
        b=B1jPz2rC3/6+GcAcBe4V/pXtMIAY5vYVA4tll9Qu9bktGWC7Y6HbbYAFcN3AXpga
        VM95OTegAedTlIqdkJRssbYZMm5Sv5lLbE7eD3sVbGnyOR5faFpGmboq9kj8ZNiylVl
        LNX56+aQUKeBbgf2r3uERBpatmnpc3JSTaNFr6t4=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by mx.zoho.com.cn
        with SMTPS id 1585568661292641.3282127841759; Mon, 30 Mar 2020 19:44:21 +0800 (CST)
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
Message-ID: <20200330114239.1112759-6-jiaxun.yang@flygoat.com>
Subject: [PATCH 5/5] MIPS: Loongson64: Switch to generic PCI driver
Date:   Mon, 30 Mar 2020 19:42:30 +0800
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
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
 =09select IRQ_MIPS_CPU
 =09select NR_CPUS_DEFAULT_4
 =09select USE_GENERIC_EARLY_PRINTK_8250
+=09select PCI_DRIVERS_GENERIC
 =09select SYS_HAS_CPU_LOONGSON64
 =09select SYS_HAS_EARLY_PRINTK
 =09select SYS_SUPPORTS_SMP
diff --git a/arch/mips/loongson64/Makefile b/arch/mips/loongson64/Makefile
index b7f40b179c71..f04461839540 100644
--- a/arch/mips/loongson64/Makefile
+++ b/arch/mips/loongson64/Makefile
@@ -8,6 +8,6 @@ obj-$(CONFIG_MACH_LOONGSON64) +=3D cop2-ex.o platform.o acp=
i_init.o dma.o \
 obj-$(CONFIG_SMP)=09+=3D smp.o
 obj-$(CONFIG_NUMA)=09+=3D numa.o
 obj-$(CONFIG_RS780_HPET) +=3D hpet.o
-obj-$(CONFIG_PCI) +=3D pci.o
 obj-$(CONFIG_LOONGSON_MC146818) +=3D rtc.o
 obj-$(CONFIG_SUSPEND) +=3D pm.o
+obj-$(CONFIG_PCI_QUIRKS) +=3D vbios_quirk.o
diff --git a/arch/mips/loongson64/vbios_quirk.c b/arch/mips/loongson64/vbio=
s_quirk.c
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
+=09struct resource *res =3D &pdev->resource[PCI_ROM_RESOURCE];
+
+=09if (res->start)
+=09=09return;
+
+=09if (!loongson_sysconf.vgabios_addr)
+=09=09return;
+
+=09pci_disable_rom(pdev);
+=09if (res->parent)
+=09=09release_resource(res);
+
+=09res->start =3D virt_to_phys((void *) loongson_sysconf.vgabios_addr);
+=09res->end   =3D res->start + 256*1024 - 1;
+=09res->flags =3D IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
+=09=09     IORESOURCE_PCI_FIXED;
+
+=09dev_info(&pdev->dev, "BAR %d: assigned %pR for Radeon ROM\n",
+=09=09 PCI_ROM_RESOURCE, res);
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, 0x9615,
+=09=09=09=09PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_radeon);
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 342ce10ef593..438f10955d89 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -35,7 +35,6 @@ obj-$(CONFIG_LASAT)=09=09+=3D pci-lasat.o
 obj-$(CONFIG_MIPS_COBALT)=09+=3D fixup-cobalt.o
 obj-$(CONFIG_LEMOTE_FULOONG2E)=09+=3D fixup-fuloong2e.o ops-loongson2.o
 obj-$(CONFIG_LEMOTE_MACH2F)=09+=3D fixup-lemote2f.o ops-loongson2.o
-obj-$(CONFIG_MACH_LOONGSON64)=09+=3D fixup-loongson3.o ops-loongson3.o
 obj-$(CONFIG_MIPS_MALTA)=09+=3D fixup-malta.o pci-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)=09+=3D fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)=09+=3D fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/fixup-loongson3.c b/arch/mips/pci/fixup-loongson=
3.c
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
- * This program is free software; you can redistribute  it and/or modify i=
t
- * under  the terms of  the GNU General  Public License as published by th=
e
- * Free Software Foundation;  either version 2 of the  License, or (at you=
r
- * option) any later version.
- *
- * THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- * WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES O=
F
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  I=
N
- * NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BU=
T
- * NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS O=
F
- * USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND O=
N
- * ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TOR=
T
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE O=
F
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-#include <linux/pci.h>
-#include <boot_param.h>
-
-static void print_fixup_info(const struct pci_dev *pdev)
-{
-=09dev_info(&pdev->dev, "Device %x:%x, irq %d\n",
-=09=09=09pdev->vendor, pdev->device, pdev->irq);
-}
-
-int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-=09print_fixup_info(dev);
-=09return dev->irq;
-}
-
-static void pci_fixup_radeon(struct pci_dev *pdev)
-{
-=09struct resource *res =3D &pdev->resource[PCI_ROM_RESOURCE];
-
-=09if (res->start)
-=09=09return;
-
-=09if (!loongson_sysconf.vgabios_addr)
-=09=09return;
-
-=09pci_disable_rom(pdev);
-=09if (res->parent)
-=09=09release_resource(res);
-
-=09res->start =3D virt_to_phys((void *) loongson_sysconf.vgabios_addr);
-=09res->end   =3D res->start + 256*1024 - 1;
-=09res->flags =3D IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
-=09=09     IORESOURCE_PCI_FIXED;
-
-=09dev_info(&pdev->dev, "BAR %d: assigned %pR for Radeon ROM\n",
-=09=09 PCI_ROM_RESOURCE, res);
-}
-
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
-=09=09=09=09PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_radeon);
-
-/* Do platform specific device initialization at pci_enable_device() time =
*/
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-=09return 0;
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
-=09=09struct pci_bus *bus, unsigned int devfn,
-=09=09int where, u32 *data)
-{
-=09unsigned char busnum =3D bus->number;
-=09int function =3D PCI_FUNC(devfn);
-=09int device =3D PCI_SLOT(devfn);
-=09int reg =3D where & ~3;
-=09void *addrp;
-=09u64 addr;
-
-=09if (where < PCI_CFG_SPACE_SIZE) { /* standard config */
-=09=09addr =3D (busnum << 16) | (device << 11) | (function << 8) | reg;
-=09=09if (busnum =3D=3D 0) {
-=09=09=09if (device > 31)
-=09=09=09=09return PCIBIOS_DEVICE_NOT_FOUND;
-=09=09=09addrp =3D (void *)TO_UNCAC(HT1LO_PCICFG_BASE | addr);
-=09=09} else {
-=09=09=09addrp =3D (void *)TO_UNCAC(HT1LO_PCICFG_BASE_TP1 | addr);
-=09=09}
-=09} else if (where < PCI_CFG_SPACE_EXP_SIZE) {  /* extended config */
-=09=09struct pci_dev *rootdev;
-
-=09=09rootdev =3D pci_get_domain_bus_and_slot(0, 0, 0);
-=09=09if (!rootdev)
-=09=09=09return PCIBIOS_DEVICE_NOT_FOUND;
-
-=09=09addr =3D pci_resource_start(rootdev, 3);
-=09=09if (!addr)
-=09=09=09return PCIBIOS_DEVICE_NOT_FOUND;
-
-=09=09addr |=3D busnum << 20 | device << 15 | function << 12 | reg;
-=09=09addrp =3D (void *)TO_UNCAC(addr);
-=09} else {
-=09=09return PCIBIOS_DEVICE_NOT_FOUND;
-=09}
-
-=09if (access_type =3D=3D PCI_ACCESS_WRITE)
-=09=09writel(*data, addrp);
-=09else {
-=09=09*data =3D readl(addrp);
-=09=09if (*data =3D=3D 0xffffffff) {
-=09=09=09*data =3D -1;
-=09=09=09return PCIBIOS_DEVICE_NOT_FOUND;
-=09=09}
-=09}
-=09return PCIBIOS_SUCCESSFUL;
-}
-
-static int loongson3_pci_pcibios_read(struct pci_bus *bus, unsigned int de=
vfn,
-=09=09=09=09 int where, int size, u32 *val)
-{
-=09u32 data =3D 0;
-=09int ret =3D loongson3_pci_config_access(PCI_ACCESS_READ,
-=09=09=09bus, devfn, where, &data);
-
-=09if (ret !=3D PCIBIOS_SUCCESSFUL)
-=09=09return ret;
-
-=09if (size =3D=3D 1)
-=09=09*val =3D (data >> ((where & 3) << 3)) & 0xff;
-=09else if (size =3D=3D 2)
-=09=09*val =3D (data >> ((where & 3) << 3)) & 0xffff;
-=09else
-=09=09*val =3D data;
-
-=09return PCIBIOS_SUCCESSFUL;
-}
-
-static int loongson3_pci_pcibios_write(struct pci_bus *bus, unsigned int d=
evfn,
-=09=09=09=09  int where, int size, u32 val)
-{
-=09u32 data =3D 0;
-=09int ret;
-
-=09if (size =3D=3D 4)
-=09=09data =3D val;
-=09else {
-=09=09ret =3D loongson3_pci_config_access(PCI_ACCESS_READ,
-=09=09=09=09bus, devfn, where, &data);
-=09=09if (ret !=3D PCIBIOS_SUCCESSFUL)
-=09=09=09return ret;
-
-=09=09if (size =3D=3D 1)
-=09=09=09data =3D (data & ~(0xff << ((where & 3) << 3))) |
-=09=09=09    (val << ((where & 3) << 3));
-=09=09else if (size =3D=3D 2)
-=09=09=09data =3D (data & ~(0xffff << ((where & 3) << 3))) |
-=09=09=09    (val << ((where & 3) << 3));
-=09}
-
-=09ret =3D loongson3_pci_config_access(PCI_ACCESS_WRITE,
-=09=09=09bus, devfn, where, &data);
-
-=09return ret;
-}
-
-struct pci_ops loongson_pci_ops =3D {
-=09.read =3D loongson3_pci_pcibios_read,
-=09.write =3D loongson3_pci_pcibios_write
-};
--=20
2.26.0.rc2


