Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B13917DABA
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 09:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgCIIXw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 04:23:52 -0400
Received: from mail.loongson.cn ([114.242.206.163]:55948 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbgCIIXv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 04:23:51 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb9_+_GVesb4YAA--.12S6;
        Mon, 09 Mar 2020 16:23:31 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 4/6] MIPS: Loongson: Add DMA support for 7A1000
Date:   Mon,  9 Mar 2020 16:23:24 +0800
Message-Id: <1583742206-29163-5-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxb9_+_GVesb4YAA--.12S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4ktF4kWF1xtry5Gr1xZrb_yoWrCr1xpF
        Z7A3WrGr4Yqr17uF93X3y8ury5AanYyr4SqFW29r1Yka4qqw1rtF48Xa4ktw4fAr4rGF4x
        urW0ka18CF1IgF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j
        6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
        IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
        xan2IY04v7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
        vjDU0xZFpf9x0JU2oGLUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement __phys_to_dma() and __dma_to_phys() according to the
node id offset in 7A1000 DMA route config register.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/include/asm/mach-loongson64/boot_param.h |  1 +
 arch/mips/loongson64/dma.c                         | 49 +++++++++++++++++++++-
 arch/mips/loongson64/init.c                        | 13 ++++++
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index 225a563..60e7a7e 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -218,5 +218,6 @@ struct loongson_system_configuration {
 extern struct efi_memory_map_loongson *loongson_memmap;
 extern struct loongson_system_configuration loongson_sysconf;
 extern struct board_devices *eboard;
+extern u32 node_id_offset;
 
 #endif
diff --git a/arch/mips/loongson64/dma.c b/arch/mips/loongson64/dma.c
index 5e86635..997c257 100644
--- a/arch/mips/loongson64/dma.c
+++ b/arch/mips/loongson64/dma.c
@@ -2,24 +2,69 @@
 #include <linux/dma-direct.h>
 #include <linux/init.h>
 #include <linux/swiotlb.h>
+#include <boot_param.h>
 
-dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+struct loongson_dma_ops {
+	dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
+	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
+};
+
+struct loongson_dma_ops loongson_dma;
+
+dma_addr_t __rs780e_phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	/* We extract 2bit node id (bit 44~47, only bit 44~45 used now) from
 	 * Loongson-3's 48bit address space and embed it into 40bit */
 	long nid = (paddr >> 44) & 0x3;
+
 	return ((nid << 44) ^ paddr) | (nid << 37);
 }
 
-phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
+dma_addr_t __ls7a_phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	long nid = (paddr >> 44) & 0x3;
+
+	return ((nid << 44) ^ paddr) | (nid << (36 + node_id_offset));
+}
+
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return loongson_dma.phys_to_dma(dev, paddr);
+}
+
+phys_addr_t __rs780e_dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
 	/* We extract 2bit node id (bit 44~47, only bit 44~45 used now) from
 	 * Loongson-3's 48bit address space and embed it into 40bit */
 	long nid = (daddr >> 37) & 0x3;
+
 	return ((nid << 37) ^ daddr) | (nid << 44);
 }
 
+phys_addr_t __ls7a_dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	long nid = (daddr >> (36 + node_id_offset)) & 0x3;
+
+	return ((nid << (36 + node_id_offset)) ^ daddr) | (nid << 44);
+}
+
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	return loongson_dma.dma_to_phys(dev, daddr);
+}
+
 void __init plat_swiotlb_setup(void)
 {
 	swiotlb_init(1);
+
+	if (strstr(eboard->name, "780E")) {
+		loongson_dma.phys_to_dma = __rs780e_phys_to_dma;
+		loongson_dma.dma_to_phys = __rs780e_dma_to_phys;
+	}
+
+	if (strstr(eboard->name, "7A1000")) {
+		loongson_dma.phys_to_dma = __ls7a_phys_to_dma;
+		loongson_dma.dma_to_phys = __ls7a_dma_to_phys;
+	}
 }
diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
index 5ac1a0f..dd8463d 100644
--- a/arch/mips/loongson64/init.c
+++ b/arch/mips/loongson64/init.c
@@ -12,6 +12,11 @@
 #include <asm/fw/fw.h>
 
 #include <loongson.h>
+#include <boot_param.h>
+
+#define NODE_ID_OFFSET_ADDR     0x90000E001001041CULL
+
+u32 node_id_offset;
 
 static void __init mips_nmi_setup(void)
 {
@@ -23,6 +28,11 @@ static void __init mips_nmi_setup(void)
 	flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
 }
 
+static void ls7a_early_config(void)
+{
+	node_id_offset = (*(u32 *)NODE_ID_OFFSET_ADDR >> 8) & 0x1F;
+}
+
 void __init prom_init(void)
 {
 	fw_init_cmdline();
@@ -32,6 +42,9 @@ void __init prom_init(void)
 	set_io_port_base((unsigned long)
 		ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
 
+	if (strstr(eboard->name, "7A1000"))
+		ls7a_early_config();
+
 	prom_init_numa_memory();
 
 	/* Hardcode to CPU UART 0 */
-- 
2.1.0

