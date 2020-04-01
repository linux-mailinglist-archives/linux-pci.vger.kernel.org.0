Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1AA19A3D5
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 05:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbgDADJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 23:09:51 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17843 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731611AbgDADJu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 23:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585710550;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=UUOHTIt8RICsb4LQMgVyqY+dOK3IXJ9oWavAhMjSnhU=;
        b=ACqb4fAewWbjpmupbq1onajrHrVqZt9Oe5/23hh+gnCnhh6hNUZPnzVp0yitPYwq
        PV4YG5djDZYXFOZ6tzfEVHE1kVaxnrw3xtOD2NtLSqjbgTU00sU0T52Sa+peduGqGGT
        dv2gs63MUiOhucOn7T+eT6oRKPbb042CuIWUcHy8=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by mx.zoho.com.cn
        with SMTPS id 1585710548036204.11125504076017; Wed, 1 Apr 2020 11:09:08 +0800 (CST)
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
Message-ID: <20200401030658.1174045-3-jiaxun.yang@flygoat.com>
Subject: [PATCH v2 2/5] PCI: Add Loongson PCI Controller support
Date:   Wed,  1 Apr 2020 11:06:46 +0800
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200401030658.1174045-1-jiaxun.yang@flygoat.com>
References: <20200401030658.1174045-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This controller can be found on Loongson-2K SoC, Loongson-3
systems with RS780E/LS7A PCH.

The RS780E part of code was previously located at
arch/mips/pci/ops-loongson3.c and now it can use generic PCI
driver implementation.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

--
v2:
=09- Clean up according to rob's suggestions
=09- Claim that it can't work as a module
---
 drivers/pci/controller/Kconfig        |   9 +
 drivers/pci/controller/Makefile       |   1 +
 drivers/pci/controller/pci-loongson.c | 257 ++++++++++++++++++++++++++
 3 files changed, 267 insertions(+)
 create mode 100644 drivers/pci/controller/pci-loongson.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfi=
g
index 91bfdb784829..7d7e70402ebd 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -258,6 +258,15 @@ config PCI_HYPERV_INTERFACE
 =09  The Hyper-V PCI Interface is a helper driver allows other drivers to
 =09  have a common interface with the Hyper-V PCI frontend driver.
=20
+config PCI_LOONGSON
+=09bool "LOONGSON PCI Controller"
+=09depends on MACH_LOONGSON64 || COMPILE_TEST
+=09depends on OF
+=09depends on PCI_QUIRKS
+=09help
+=09  Say Y here if you want to enable PCI controller support on
+=09  Loongson systems.
+
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/mobiveil/Kconfig"
 source "drivers/pci/controller/cadence/Kconfig"
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makef=
ile
index 158c59771824..fbac4b0190a0 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_MEDIATEK) +=3D pcie-mediatek.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) +=3D pcie-tango.o
 obj-$(CONFIG_VMD) +=3D vmd.o
 obj-$(CONFIG_PCIE_BRCMSTB) +=3D pcie-brcmstb.o
+obj-$(CONFIG_PCI_LOONGSON) +=3D pci-loongson.o
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y=09=09=09=09+=3D dwc/
 obj-y=09=09=09=09+=3D mobiveil/
diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller=
/pci-loongson.c
new file mode 100644
index 000000000000..c68f25dccf76
--- /dev/null
+++ b/drivers/pci/controller/pci-loongson.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Loongson PCI Host Controller Driver
+ *
+ * Copyright (C) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+
+#include "../pci.h"
+
+/* Device IDs */
+#define DEV_PCIE_PORT_0=090x7a09
+#define DEV_PCIE_PORT_1=090x7a19
+#define DEV_PCIE_PORT_2=090x7a29
+
+#define DEV_LS2K_APB=090x7a02
+#define DEV_LS7A_CONF=090x7a10
+#define DEV_LS7A_LPC=090x7a0c
+
+#define FLAG_CFG0=09BIT(0)
+#define FLAG_CFG1=09BIT(1)
+#define FLAG_DEV_FIX=09BIT(2)
+
+struct loongson_pci {
+=09void __iomem *cfg0_base;
+=09void __iomem *cfg1_base;
+=09struct platform_device *pdev;
+=09u32 flags;
+};
+
+/* Fixup wrong class code in PCIe bridges */
+static void bridge_class_quirk(struct pci_dev *dev)
+{
+=09dev->class =3D PCI_CLASS_BRIDGE_PCI << 8;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
+=09=09=09DEV_PCIE_PORT_0, bridge_class_quirk);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
+=09=09=09DEV_PCIE_PORT_1, bridge_class_quirk);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
+=09=09=09DEV_PCIE_PORT_2, bridge_class_quirk);
+
+static void system_bus_quirk(struct pci_dev *pdev)
+{
+=09u16 tmp;
+
+=09pdev->mmio_always_on =3D 1;
+=09pdev->non_compliant_bars =3D 1;
+=09/* Enable MEM & IO Decoding */
+=09pci_read_config_word(pdev, PCI_STATUS, &tmp);
+=09tmp |=3D PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
+=09pci_write_config_word(pdev, PCI_STATUS, tmp);
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+=09=09=09DEV_LS2K_APB, system_bus_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+=09=09=09DEV_LS7A_CONF, system_bus_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+=09=09=09DEV_LS7A_LPC, system_bus_quirk);
+
+static void loongson_mrrs_quirk(struct pci_dev *dev)
+{
+=09struct pci_bus *bus =3D dev->bus;
+=09struct pci_dev *bridge;
+=09static const struct pci_device_id bridge_devids[] =3D {
+=09=09{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
+=09=09{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
+=09=09{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
+=09=09{ 0, },
+=09};
+
+
+=09/* look for the matching bridge */
+=09while (!pci_is_root_bus(bus)) {
+=09=09bridge =3D bus->self;
+=09=09bus =3D bus->parent;
+=09=09/*
+=09=09 * Some Loongson PCIE ports has a h/w limitation of
+=09=09 * 256 bytes maximum read request size. It can't handle
+=09=09 * anything higher than this. So force this limit on
+=09=09 * any devices attached under these ports.
+=09=09 */
+=09=09if (pci_match_id(bridge_devids, bridge)) {
+=09=09=09if (pcie_get_readrq(dev) > 256) {
+=09=09=09=09dev_info(&dev->dev, "limiting MRRS to 256\n");
+=09=09=09=09pcie_set_readrq(dev, 256);
+=09=09=09}
+=09=09=09break;
+=09=09}
+=09}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
+
+static void __iomem *cfg1_map(struct loongson_pci *priv, int bus, int dev,
+=09=09=09=09int func, int where)
+{
+=09unsigned long addroff =3D 0x0;
+
+=09if (bus !=3D 0)
+=09=09addroff |=3D BIT(28); /* Type 1 Access */
+=09addroff |=3D (where & 0xff) | ((where & 0xf00) << 16);
+=09addroff |=3D (bus << 16) | (dev << 11) | (func << 8);
+=09return priv->cfg1_base + addroff;
+}
+
+static void __iomem *cfg0_map(struct loongson_pci *priv, int bus, int dev,
+=09=09=09=09int func, int where)
+{
+=09unsigned long addroff =3D 0x0;
+
+=09if (bus !=3D 0)
+=09=09addroff |=3D BIT(24); /* Type 1 Access */
+=09addroff |=3D (bus << 16) | (dev << 11) | (func << 8) | where;
+=09return priv->cfg0_base + addroff;
+}
+
+void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devfn=
,
+=09=09=09       int where)
+{
+=09unsigned char busnum =3D bus->number;
+=09int device =3D PCI_SLOT(devfn);
+=09int function =3D PCI_FUNC(devfn);
+=09struct pci_host_bridge *bridge =3D pci_find_host_bridge(bus);
+=09struct loongson_pci *priv =3D  pci_host_bridge_priv(bridge);
+
+=09/*
+=09 * Do not read more than one device on the bus other than
+=09 * the host bridge.
+=09 */
+=09if (bus->primary !=3D 0 && device > 0 &&
+=09=09priv->flags & FLAG_DEV_FIX)
+=09=09return NULL;
+
+=09/* CFG0 can only access standard space */
+=09if (where < PCI_CFG_SPACE_SIZE && priv->flags & FLAG_CFG0 &&
+=09=09priv->cfg0_base)
+=09=09return cfg0_map(priv, busnum, device, function, where);
+
+=09/* CFG1 can access exp space */
+=09if (where < PCI_CFG_SPACE_EXP_SIZE && priv->flags & FLAG_CFG1 &&
+=09=09priv->cfg1_base)
+=09=09return cfg1_map(priv, busnum, device, function, where);
+
+=09return NULL;
+}
+
+static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+=09int irq;
+=09u8 val;
+
+=09irq =3D of_irq_parse_and_map_pci(dev, slot, pin);
+=09if (irq > 0)
+=09=09return irq;
+
+=09/* Care legacy systems */
+=09pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &val);
+=09/* 0xff is also invalid */
+=09if (val =3D=3D 0xff)
+=09=09return 0;
+
+=09return val;
+}
+
+/* H/w only accept 32-bit PCI operations */
+static struct pci_ops loongson_pci_ops =3D {
+=09.map_bus =3D pci_loongson_map_bus,
+=09.read=09=3D pci_generic_config_read32,
+=09.write=09=3D pci_generic_config_write32,
+};
+
+static const struct of_device_id loongson_pci_of_match[] =3D {
+=09{ .compatible =3D "loongson,rs780e-pci",
+=09=09.data =3D (void *)(FLAG_CFG0), },
+=09{ .compatible =3D "loongson,ls2k-pci",
+=09=09.data =3D (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
+=09{ .compatible =3D "loongson,ls7a-pci",
+=09=09.data =3D (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
+=09{}
+};
+
+static int loongson_pci_probe(struct platform_device *pdev)
+{
+=09struct loongson_pci *priv;
+=09struct device *dev =3D &pdev->dev;
+=09struct device_node *node =3D dev->of_node;
+=09struct pci_host_bridge *bridge;
+=09struct resource *regs;
+=09int err;
+
+=09if (!node)
+=09=09return -ENODEV;
+
+=09bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*priv));
+=09if (!bridge)
+=09=09return -ENODEV;
+
+=09priv =3D pci_host_bridge_priv(bridge);
+=09priv->pdev =3D pdev;
+=09priv->flags =3D (unsigned long)of_device_get_match_data(dev);
+
+=09regs =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+=09if (!regs) {
+=09=09dev_err(dev, "missing mem resources for cfg0\n");
+=09=09return -EINVAL;
+=09}
+
+=09priv->cfg0_base =3D devm_pci_remap_cfg_resource(dev, regs);
+=09if (IS_ERR(priv->cfg0_base))
+=09=09return PTR_ERR(priv->cfg0_base);
+
+=09/* CFG1 is optional */
+=09if (priv->flags & FLAG_CFG1) {
+=09=09regs =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
+=09=09if (!regs)
+=09=09=09dev_info(dev, "missing mem resource for cfg1\n");
+=09=09else {
+=09=09=09priv->cfg1_base =3D devm_pci_remap_cfg_resource(dev, regs);
+=09=09=09if (IS_ERR(priv->cfg1_base))
+=09=09=09=09priv->cfg1_base =3D NULL;
+=09=09}
+=09}
+
+
+=09err =3D pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+=09=09=09=09=09=09&bridge->dma_ranges, NULL);
+=09if (err) {
+=09=09dev_err(dev, "Failed to get bridge resources\n");
+=09=09return err;
+=09}
+
+=09bridge->dev.parent =3D dev;
+=09bridge->sysdata =3D priv;
+=09bridge->ops =3D &loongson_pci_ops;
+=09bridge->map_irq =3D loongson_map_irq;
+
+=09err =3D pci_host_probe(bridge);
+=09if (err)
+=09=09return err;
+
+=09return 0;
+}
+
+static struct platform_driver loongson_pci_driver =3D {
+=09.driver =3D {
+=09=09.name =3D "loongson-pci",
+=09=09.of_match_table =3D loongson_pci_of_match,
+=09},
+=09.probe =3D loongson_pci_probe,
+};
+builtin_platform_driver(loongson_pci_driver);
--=20
2.26.0.rc2


