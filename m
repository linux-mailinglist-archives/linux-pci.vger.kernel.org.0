Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C662234F3B
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 03:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHABZz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 21:25:55 -0400
Received: from mail.loongson.cn ([114.242.206.163]:48054 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbgHABZz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jul 2020 21:25:55 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb96dxCRfxTEDAA--.2948S2;
        Sat, 01 Aug 2020 09:25:50 +0800 (CST)
From:   Xingxing Su <suxingxing@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Don't use Printk in raw_spinlocks
Date:   Sat,  1 Aug 2020 09:25:49 +0800
Message-Id: <1596245149-28628-1-git-send-email-suxingxing@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxb96dxCRfxTEDAA--.2948S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGryDJF48Jw15tr4rXF4xZwb_yoWrKryxpr
        yYqryxGr40yry8JF4Utay5tFy0kr4qyay7Jr18Xw15ZFsrur1UJr17tF4Skw1DJr45JF9r
        Jr4qyr4jgrWUGw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I
        3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
        k0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
        Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5PpnJUUUUU==
X-CM-SenderInfo: pvx0x0xj0l0wo6or00hjvr0hdfq/1tbiAQAPC13QvMJ82QAAsT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Do not use printk in raw_spinlocks, 
it will cause BUG: Invalid wait context.

The trace reported by lockdep follows.

[    2.986113] =============================
[    2.986115] [ BUG: Invalid wait context ]
[    2.986116] 5.8.0-rc1+ #11 Not tainted
[    2.986118] -----------------------------
[    2.986120] swapper/0/1 is trying to lock:
[    2.986122] ffffffff80f5ddd8 (console_owner){....}-{3:3}, at: console_unlock+0x284/0x820
[    2.986130] other info that might help us debug this:
[    2.986132] context-{5:5}
[    2.986134] 3 locks held by swapper/0/1:
[    2.986135]  #0: 98000007fa03c990 (&dev->mutex){....}-{0:0}, at: device_driver_attach+0x28/0x90
[    2.986144]  #1: ffffffff80fb83a8 (pci_lock){....}-{2:2}, at: pci_bus_write_config_word+0x60/0xb8
[    2.986152]  #2: ffffffff80f5ded0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x1b0/0x3b8
[    2.986161] stack backtrace:
[    2.986163] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc1+ #11
[    2.986164] Stack : 0000000000001d67 98000000030be9b0 0000000000000001 7b2aba74f6c4785b
[    2.986172]         7b2aba74f6c4785b 0000000000000000 98000007f89cb438 ffffffff80e7dc80
[    2.986181]         0000000000000001 000000000000000a 0000000000000001 0000000000000001
[    2.986189]         ffffffff80f4e156 fffffffffffffffd ffffffff80cc2d98 fffffffff8000000
[    2.986197]         0000000024000000 ffffffff80f40000 0000000000000000 0000000000000000
[    2.986205]         ffffffff9500cce0 0000000000000000 ffffffff80f50000 ffffffff81546318
[    2.986213]         ffffffff81c4c3c0 0000000000000018 ffffffffbc000000 0000000000000000
[    2.986221]         ffffffff81340000 98000007f89c8000 98000007f89cb430 98000007f8a00000
[    2.986229]         ffffffff806be568 0000000000000000 0000000000000000 0000000000000000
[    2.986237]         0000000000000000 0000000000000000 ffffffff80211c1c 7b2aba74f6c4785b
[    2.986245]         ...
[    2.986250] Call Trace:
[    2.986251] [<ffffffff80211c1c>] show_stack+0x9c/0x130
[    2.986253] [<ffffffff806be568>] dump_stack+0xe8/0x150
[    2.986255] [<ffffffff802ad408>] __lock_acquire+0x570/0x3250
[    2.986257] [<ffffffff802abed0>] lock_acquire+0x118/0x558
[    2.986259] [<ffffffff802be764>] console_unlock+0x2e4/0x820
[    2.986261] [<ffffffff802c0a68>] vprintk_emit+0x1c0/0x3b8
[    2.986263] [<ffffffff807f45a8>] dev_vprintk_emit+0x1c8/0x210
[    2.986265] [<ffffffff807f462c>] dev_printk_emit+0x3c/0x60
[    2.986267] [<ffffffff807f499c>] _dev_warn+0x5c/0x80
[    2.986269] [<ffffffff806eea9c>] pci_generic_config_write32+0x154/0x160
[    2.986271] [<ffffffff806edca4>] pci_bus_write_config_word+0x84/0xb8
[    2.986273] [<ffffffff806f1664>] pci_setup_device+0x22c/0x768
[    2.986275] [<ffffffff806f26a0>] pci_scan_single_device+0xc8/0x100
[    2.986277] [<ffffffff806f2788>] pci_scan_slot+0xb0/0x178
[    2.986279] [<ffffffff806f3ae4>] pci_scan_child_bus_extend+0x5c/0x370
[    2.986281] [<ffffffff806f407c>] pci_scan_root_bus_bridge+0x6c/0xf0
[    2.986283] [<ffffffff806f411c>] pci_host_probe+0x1c/0xd8
[    2.986285] [<ffffffff807fa03c>] platform_drv_probe+0x54/0xb8
[    2.986287] [<ffffffff807f71f8>] really_probe+0x130/0x388
[    2.986289] [<ffffffff807f7594>] driver_probe_device+0x64/0xd8
[    2.986291] [<ffffffff807f7844>] device_driver_attach+0x84/0x90
[    2.986293] [<ffffffff807f7918>] __driver_attach+0xc8/0x128
[    2.986295] [<ffffffff807f4cac>] bus_for_each_dev+0x74/0xd8
[    2.986297] [<ffffffff807f6408>] bus_add_driver+0x170/0x250
[    2.986299] [<ffffffff807f899c>] driver_register+0x84/0x150
[    2.986301] [<ffffffff80200b08>] do_one_initcall+0x98/0x458
[    2.986303] [<ffffffff810212dc>] kernel_init_freeable+0x2c0/0x36c
[    2.986305] [<ffffffff80be7540>] kernel_init+0x10/0x128
[    2.986307] [<ffffffff80209d44>] ret_from_kernel_thread+0x14/0x1c

Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
---
 drivers/pci/access.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 79c4a2e..b3fc164 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -160,9 +160,6 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
 	 * write happen to have any RW1C (write-one-to-clear) bits set, we
 	 * just inadvertently cleared something we shouldn't have.
 	 */
-	dev_warn_ratelimited(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
-			     size, pci_domain_nr(bus), bus->number,
-			     PCI_SLOT(devfn), PCI_FUNC(devfn), where);
 
 	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
 	tmp = readl(addr) & mask;
-- 
2.1.0

