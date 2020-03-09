Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9F117DAB5
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 09:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCIIXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 04:23:49 -0400
Received: from mail.loongson.cn ([114.242.206.163]:56018 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbgCIIXq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 04:23:46 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb9_+_GVesb4YAA--.12S7;
        Mon, 09 Mar 2020 16:23:38 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH 5/6] MIPS: Loongson: Add PCI support for 7A1000
Date:   Mon,  9 Mar 2020 16:23:25 +0800
Message-Id: <1583742206-29163-6-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxb9_+_GVesb4YAA--.12S7
X-Coremail-Antispam: 1UD129KBjvJXoW3WF18Xw4xJFy7XFWkCr1DAwb_yoWxAF43pF
        1fAa18Gr4FqF17GF9ayFWUGr1fAFZYyF9rAay2yryj9asavw1jvrnYqF15tr4IkF4DXayx
        WFZ3Gr4UCF1DCaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j
        6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
        IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
        xan2IY04v7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUCVW8JwCI42
        IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
        Ja73UjIFyTuYvjfU8c_TDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI support for 7A1000 to detect PCI device.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/include/asm/mach-loongson64/pci.h |   1 +
 arch/mips/loongson64/pci.c                  |  12 ++-
 arch/mips/pci/Makefile                      |   2 +-
 arch/mips/pci/ops-loongson3-ls7a.c          | 132 ++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+), 4 deletions(-)
 create mode 100644 arch/mips/pci/ops-loongson3-ls7a.c

diff --git a/arch/mips/include/asm/mach-loongson64/pci.h b/arch/mips/include/asm/mach-loongson64/pci.h
index 8b59d64..42c9744 100644
--- a/arch/mips/include/asm/mach-loongson64/pci.h
+++ b/arch/mips/include/asm/mach-loongson64/pci.h
@@ -8,6 +8,7 @@
 #define __ASM_MACH_LOONGSON64_PCI_H_
 
 extern struct pci_ops loongson_pci_ops;
+extern struct pci_ops loongson_ls7a_pci_ops;
 
 /* this is an offset from mips_io_port_base */
 #define LOONGSON_PCI_IO_START	0x00004000UL
diff --git a/arch/mips/loongson64/pci.c b/arch/mips/loongson64/pci.c
index e84ae20..b79368f 100644
--- a/arch/mips/loongson64/pci.c
+++ b/arch/mips/loongson64/pci.c
@@ -23,8 +23,8 @@ static struct resource loongson_pci_io_resource = {
 	.flags	= IORESOURCE_IO,
 };
 
-static struct pci_controller  loongson_pci_controller = {
-	.pci_ops	= &loongson_pci_ops,
+static struct pci_controller loongson_pci_controller = {
+	.pci_ops	= NULL,
 	.io_resource	= &loongson_pci_io_resource,
 	.mem_resource	= &loongson_pci_mem_resource,
 	.mem_offset	= 0x00000000UL,
@@ -36,6 +36,11 @@ extern int sbx00_acpi_init(void);
 
 static int __init pcibios_init(void)
 {
+	if (strstr(eboard->name, "780E"))
+		loongson_pci_controller.pci_ops = &loongson_pci_ops;
+
+	if (strstr(eboard->name, "7A1000"))
+		loongson_pci_controller.pci_ops = &loongson_ls7a_pci_ops;
 
 	loongson_pci_controller.io_map_base = mips_io_port_base;
 	loongson_pci_mem_resource.start = loongson_sysconf.pci_mem_start_addr;
@@ -43,7 +48,8 @@ static int __init pcibios_init(void)
 
 	register_pci_controller(&loongson_pci_controller);
 
-	sbx00_acpi_init();
+	if (strstr(eboard->name, "780E"))
+		sbx00_acpi_init();
 
 	return 0;
 }
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 342ce10..7256bb1 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_LASAT)		+= pci-lasat.o
 obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
 obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
 obj-$(CONFIG_LEMOTE_MACH2F)	+= fixup-lemote2f.o ops-loongson2.o
-obj-$(CONFIG_MACH_LOONGSON64)	+= fixup-loongson3.o ops-loongson3.o
+obj-$(CONFIG_MACH_LOONGSON64)	+= fixup-loongson3.o ops-loongson3.o ops-loongson3-ls7a.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o pci-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/ops-loongson3-ls7a.c b/arch/mips/pci/ops-loongson3-ls7a.c
new file mode 100644
index 0000000..4ed6c40
--- /dev/null
+++ b/arch/mips/pci/ops-loongson3-ls7a.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Loongson Technology Corporation Limited
+ *
+ * Author: Jianmin Lv <lvjianmin@loongson.cn>
+ * Author: Tiezhu Yang <yangtiezhu@loongson.cn>
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+
+#include <asm/mips-boards/bonito64.h>
+
+#include <loongson.h>
+
+#define PCI_ACCESS_READ 0
+#define PCI_ACCESS_WRITE 1
+
+#define HT1LO_PCICFG_BASE 0x1a000000
+#define HT1LO_PCICFG_BASE_TP1 0x1b000000
+
+#define HT1LO_PCICFG_BASE_EXT 0xefe00000000
+#define HT1LO_PCICFG_BASE_TP1_EXT 0xefe10000000
+
+static int ls7a_pci_config_access(unsigned char access_type,
+		struct pci_bus *bus, unsigned int devfn,
+		int where, u32 *data)
+{
+	u_int64_t addr;
+	void *addrp;
+	unsigned char busnum = bus->number;
+	int device = PCI_SLOT(devfn);
+	int function = PCI_FUNC(devfn);
+	int reg = where & ~3;
+
+	if (where >= PCI_CFG_SPACE_EXP_SIZE)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (busnum == 0 && device > 23)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (where < PCI_CFG_SPACE_SIZE) { /* standard config */
+		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+		if (busnum == 0) {
+			addr = HT1LO_PCICFG_BASE | addr;
+			addrp = (void *)TO_UNCAC(addr);
+		} else {
+			addr = HT1LO_PCICFG_BASE_TP1 | addr;
+			addrp = (void *)TO_UNCAC(addr);
+		}
+	} else { /* extended config */
+		reg = (reg & 0xff) | ((reg & 0xf00) << 16);
+		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+		if (busnum == 0) {
+			addr = HT1LO_PCICFG_BASE_EXT | addr;
+			addrp = (void *)TO_UNCAC(addr);
+		} else {
+			addr = HT1LO_PCICFG_BASE_TP1_EXT | addr;
+			addrp = (void *)TO_UNCAC(addr);
+		}
+	}
+
+	if (access_type == PCI_ACCESS_WRITE)
+		*(unsigned int *)addrp = cpu_to_le32(*data);
+	else {
+		*data = le32_to_cpu(*(unsigned int *)addrp);
+		if (busnum == 0 &&
+		    reg == PCI_CLASS_REVISION && *data == 0x06000001)
+			*data = (PCI_CLASS_BRIDGE_PCI << 16) | (*data & 0xffff);
+
+		if (*data == 0xffffffff) {
+			*data = -1;
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int ls7a_pci_pcibios_read(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 *val)
+{
+	int ret;
+	u32 data = 0;
+
+	ret = ls7a_pci_config_access(PCI_ACCESS_READ, bus, devfn, where, &data);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
+
+	if (size == 1)
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+	else if (size == 2)
+		*val = (data >> ((where & 3) << 3)) & 0xffff;
+	else
+		*val = data;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int ls7a_pci_pcibios_write(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 val)
+{
+	int ret;
+	u32 data = 0;
+
+	if (size == 4)
+		data = val;
+	else {
+		ret = ls7a_pci_config_access(PCI_ACCESS_READ, bus,
+						devfn, where, &data);
+		if (ret != PCIBIOS_SUCCESSFUL)
+			return ret;
+
+		if (size == 1)
+			data = (data & ~(0xff << ((where & 3) << 3))) |
+				(val << ((where & 3) << 3));
+		else if (size == 2)
+			data = (data & ~(0xffff << ((where & 3) << 3))) |
+				(val << ((where & 3) << 3));
+	}
+
+	ret = ls7a_pci_config_access(PCI_ACCESS_WRITE, bus,
+					devfn, where, &data);
+
+	return ret;
+}
+
+struct pci_ops loongson_ls7a_pci_ops = {
+	.read = ls7a_pci_pcibios_read,
+	.write = ls7a_pci_pcibios_write
+};
-- 
2.1.0

