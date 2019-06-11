Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D643CE47
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403752AbfFKOOV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 10:14:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388411AbfFKOOV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jun 2019 10:14:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6A777234335F00B61410;
        Tue, 11 Jun 2019 22:14:17 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 11 Jun 2019 22:14:06 +0800
From:   John Garry <john.garry@huawei.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>, <arnd@arndb.de>
CC:     <linux-pci@vger.kernel.org>, <rjw@rjwysocki.net>,
        <linux-arm-kernel@lists.infradead.org>, <will.deacon@arm.com>,
        <wangkefeng.wang@huawei.com>, <linuxarm@huawei.com>,
        <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v4 2/3] lib: logic_pio: Reject accesses to unregistered CPU MMIO regions
Date:   Tue, 11 Jun 2019 22:12:53 +0800
Message-ID: <1560262374-67875-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
References: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently when accessing logical indirect PIO addresses in
logic_{in, out}{,s}, we first ensure that the region is registered.

However, no such check exists for CPU MMIO regions. The CPU MMIO regions
would be registered by the PCI host (when PCI_IOBASE is defined) in
pci_register_io_range().

We have seen scenarios when systems which don't have a PCI host, or they
do but the PCI host probe fails, certain drivers attempts to still attempt
to access PCI IO ports; examples are in [1] and [2].

Such is a case on an ARM64 system without a PCI host:

root@(none)$ insmod hwmon/f71805f.ko
 Unable to handle kernel paging request at virtual address ffff7dfffee0002e
 Mem abort info:
   ESR = 0x96000046
   Exception class = DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
 Data abort info:
   ISV = 0, ISS = 0x00000046
   CM = 0, WnR = 1
 swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
 [ffff7dfffee0002e] pgd=000000000141c003, pud=000000000141d003, pmd=0000000000000000
 Internal error: Oops: 96000046 [#1] PREEMPT SMP
 Modules linked in: f71805f(+)
 CPU: 20 PID: 2736 Comm: insmod Not tainted 5.1.0-rc1-00003-g6f1bfec2a620-dirty #99
 Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
 pstate: 80000005 (Nzcv daif -PAN -UAO)
 pc : logic_outb+0x54/0xb8
 lr : f71805f_find+0x2c/0x1b8 [f71805f]
 sp : ffff000025fbba90
 x29: ffff000025fbba90 x28: ffff000008b944d0
 x27: ffff000025fbbdf0 x26: 0000000000000100
 x25: ffff801f8c270580 x24: ffff000011420000
 x23: ffff000025fbbb3e x22: ffff000025fbbb40
 x21: ffff000008b991b8 x20: 0000000000000087
 x19: 000000000000002e x18: ffffffffffffffff
 x17: 0000000000000000 x16: 0000000000000000
 x15: ffff00001127d6c8 x14: 0000000000000000
 x13: 0000000000000000 x12: 0000000000000000
 x11: 0000000000010820 x10: 0000841fdac40000
 x9 : 0000000000000001 x8 : 0000000040000000
 x7 : 0000000000210d00 x6 : 0000000000000000
 x5 : ffff801fb6a46040 x4 : ffff841febeaeda0
 x3 : 0000000000ffbffe x2 : ffff000025fbbb40
 x1 : ffff7dfffee0002e x0 : ffff7dfffee00000
 Process insmod (pid: 2736, stack limit = 0x(____ptrval____))
 Call trace:
  logic_outb+0x54/0xb8
  f71805f_find+0x2c/0x1b8 [f71805f]
  f71805f_init+0x38/0xe48 [f71805f]
  do_one_initcall+0x5c/0x198
  do_init_module+0x54/0x1b0
  load_module+0x1dc4/0x2158
  __se_sys_init_module+0x14c/0x1e8
  __arm64_sys_init_module+0x18/0x20
  el0_svc_common+0x5c/0x100
  el0_svc_handler+0x2c/0x80
  el0_svc+0x8/0xc
 Code: d2bfdc00 f2cfbfe0 f2ffffe0 8b000021 (39000034)
 ---[ end trace 10ea80bde051bbfc ]---
root@(none)$

Well-behaved drivers call request_{muxed_}region() to grab the IO port
region, but success here still doesn't actually mean that there is some IO
port mapped in this region.

This patch adds a check to ensure that the CPU MMIO region is registered
prior to accessing the PCI IO ports.

Any failed checks silently return.

[1] https://lore.kernel.org/linux-pci/56F209A9.4040304@huawei.com
[2] https://lore.kernel.org/linux-arm-kernel/e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com/

Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 60 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 40d9428010e1..47d24f428908 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -126,7 +126,7 @@ static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
 		if (in_range(pio, range->io_start, range->size))
 			return range;
 	}
-	pr_err("PIO entry token %lx invalid\n", pio);
+
 	return NULL;
 }
 
@@ -197,11 +197,12 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
 type logic_in##bw(unsigned long addr)					\
 {									\
 	type ret = (type)~0;						\
+	struct logic_pio_hwaddr *range = find_io_range(addr);		\
 									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		ret = read##bw(PCI_IOBASE + addr);			\
+		if (range)						\
+			ret = read##bw(PCI_IOBASE + addr);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
-		struct logic_pio_hwaddr *range = find_io_range(addr);	\
 		size_t sz = sizeof(type);				\
 									\
 		if (range && range->ops)				\
@@ -214,10 +215,12 @@ type logic_in##bw(unsigned long addr)					\
 									\
 void logic_out##bw(type value, unsigned long addr)			\
 {									\
+	struct logic_pio_hwaddr *range = find_io_range(addr);		\
+									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		write##bw(value, PCI_IOBASE + addr);			\
+		if (range)						\
+			write##bw(value, PCI_IOBASE + addr);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
-		struct logic_pio_hwaddr *range = find_io_range(addr);	\
 		size_t sz = sizeof(type);				\
 									\
 		if (range && range->ops)				\
@@ -230,10 +233,12 @@ void logic_out##bw(type value, unsigned long addr)			\
 									\
 void logic_ins##bw(unsigned long addr, void *buf, unsigned int cnt)	\
 {									\
+	struct logic_pio_hwaddr *range = find_io_range(addr);		\
+									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		reads##bw(PCI_IOBASE + addr, buf, cnt);			\
+		if (range)						\
+			reads##bw(PCI_IOBASE + addr, buf, cnt);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
-		struct logic_pio_hwaddr *range = find_io_range(addr);	\
 		size_t sz = sizeof(type);				\
 									\
 		if (range && range->ops)				\
@@ -242,16 +247,17 @@ void logic_ins##bw(unsigned long addr, void *buf, unsigned int cnt)	\
 		else							\
 			WARN_ON_ONCE(1);				\
 	}								\
-									\
 }									\
 									\
 void logic_outs##bw(unsigned long addr, const void *buf,		\
 		    unsigned int cnt)					\
 {									\
+	struct logic_pio_hwaddr *range = find_io_range(addr);		\
+									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		writes##bw(PCI_IOBASE + addr, buf, cnt);		\
+		if (range)						\
+			writes##bw(PCI_IOBASE + addr, buf, cnt);	\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
-		struct logic_pio_hwaddr *range = find_io_range(addr);	\
 		size_t sz = sizeof(type);				\
 									\
 		if (range && range->ops)				\
@@ -269,28 +275,44 @@ type logic_in##bw(unsigned long addr)					\
 {									\
 	type ret = (type)~0;						\
 									\
-	if (addr < MMIO_UPPER_LIMIT)					\
-		ret = read##bw(PCI_IOBASE + addr);			\
+	if (addr < MMIO_UPPER_LIMIT) {					\
+		struct logic_pio_hwaddr *range = find_io_range(addr);	\
+									\
+		if (range)						\
+			ret = read##bw(PCI_IOBASE + addr);		\
+	}								\
 	return ret;							\
 }									\
 									\
-void logic_out##bw(type value, unsigned long addr)			\
+void logic_out##bw(type val, unsigned long addr)			\
 {									\
-	if (addr < MMIO_UPPER_LIMIT)					\
-		write##bw(value, PCI_IOBASE + addr);			\
+	if (addr < MMIO_UPPER_LIMIT) {					\
+		struct logic_pio_hwaddr *range = find_io_range(addr);	\
+									\
+		if (range)						\
+			write##bw(val, PCI_IOBASE + addr);		\
+	}								\
 }									\
 									\
 void logic_ins##bw(unsigned long addr, void *buf, unsigned int cnt)	\
 {									\
-	if (addr < MMIO_UPPER_LIMIT)					\
-		reads##bw(PCI_IOBASE + addr, buf, cnt);			\
+	if (addr < MMIO_UPPER_LIMIT) {					\
+		struct logic_pio_hwaddr *range = find_io_range(addr);	\
+									\
+		if (range)						\
+			reads##bw(PCI_IOBASE + addr, buf, cnt);		\
+	}								\
 }									\
 									\
 void logic_outs##bw(unsigned long addr, const void *buf,		\
 		    unsigned int cnt)					\
 {									\
-	if (addr < MMIO_UPPER_LIMIT)					\
-		writes##bw(PCI_IOBASE + addr, buf, cnt);		\
+	if (addr < MMIO_UPPER_LIMIT) {					\
+		struct logic_pio_hwaddr *range = find_io_range(addr);	\
+									\
+		if (range)						\
+			writes##bw(PCI_IOBASE + addr, buf, cnt);	\
+	}								\
 }
 #endif /* CONFIG_INDIRECT_PIO */
 
-- 
2.17.1

