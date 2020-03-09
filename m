Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF4317DAB6
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 09:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgCIIXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 04:23:49 -0400
Received: from mail.loongson.cn ([114.242.206.163]:55952 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726391AbgCIIXr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 04:23:47 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb9_+_GVesb4YAA--.12S2;
        Mon, 09 Mar 2020 16:23:27 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 0/6] Add basic support for Loongson 7A1000 bridge chip
Date:   Mon,  9 Mar 2020 16:23:20 +0800
Message-Id: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxb9_+_GVesb4YAA--.12S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWfZF1DZryrZrW3tF4Dtwb_yoW5GF48pa
        y5A3Z5Grs8Wry7AFn3ZryUur4rArZ3JrZFqa12qr1UuasxX3WYvr93KF45Jr47Z348Kay8
        WryrGrWUGFsxC3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1U
        MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JU4a0PUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Loongson 7A1000 bridge chip has been released for several years
since the second half of 2017, but it is not supported by the Linux
mainline kernel while it only works well with the Loongson internal
kernel version. When I update the latest version of Linux mainline
kernel on the Loongson 3A3000 CPU and 7A1000 bridge chip system,
the boot process failed and I feel depressed.

The 7A1000 bridge chip is used a lot with 3A3000 or 3A4000 CPU in
the most Loongson desktop and sever products, it is important to
support Loongson 7A1000 bridge chip by the Linux mainline kernel.

This patch series adds the basic support for the Loongson 7A1000
bridge chip, when apply these patches based on linux-5.6-rc5, the
boot process is successful and we can login normally used with the
latest firmware and discrete graphics card, the next work to do is
power management and some other controller device drivers.

Additionally, when I git clone mips code [1], the speed is too slow
and clone always failed, so this patch series is based on the latest
linux-5.6-rc5 [2].

If you have any questions and suggestions, please let me know.

Thanks,

Tiezhu Yang

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
[2] git clone https://github.com/torvalds/linux.git

Tiezhu Yang (6):
  PCI: Add Loongson vendor ID and 7A1000 device IDs
  AHCI: Add support for Loongson 7A1000 SATA controller
  MIPS: Loongson: Use firmware arguments to get board name
  MIPS: Loongson: Add DMA support for 7A1000
  MIPS: Loongson: Add PCI support for 7A1000
  MIPS: Loongson: Add support for 7A1000 interrupt controller

 arch/mips/include/asm/mach-loongson64/boot_param.h |   2 +
 arch/mips/include/asm/mach-loongson64/ioaicu.h     | 166 +++++++++++
 arch/mips/include/asm/mach-loongson64/irq.h        |   2 +
 arch/mips/include/asm/mach-loongson64/pci.h        |   1 +
 arch/mips/loongson64/Makefile                      |   2 +-
 arch/mips/loongson64/dma.c                         |  49 +++-
 arch/mips/loongson64/env.c                         |   5 +
 arch/mips/loongson64/init.c                        |  13 +
 arch/mips/loongson64/ioaicu.c                      | 305 +++++++++++++++++++++
 arch/mips/loongson64/irq.c                         |  20 +-
 arch/mips/loongson64/pci.c                         |  12 +-
 arch/mips/loongson64/smp.c                         |  11 +-
 arch/mips/pci/Makefile                             |   2 +-
 arch/mips/pci/ops-loongson3-ls7a.c                 | 132 +++++++++
 drivers/ata/ahci.c                                 |   8 +
 include/linux/pci_ids.h                            |  18 ++
 16 files changed, 733 insertions(+), 15 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson64/ioaicu.h
 create mode 100644 arch/mips/loongson64/ioaicu.c
 create mode 100644 arch/mips/pci/ops-loongson3-ls7a.c

-- 
2.1.0

