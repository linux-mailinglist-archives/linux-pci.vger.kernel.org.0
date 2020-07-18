Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4BB224A5F
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jul 2020 11:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgGRJkC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jul 2020 05:40:02 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53172 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbgGRJkC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Jul 2020 05:40:02 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP2ZZwxJfPMkAAA--.893S2;
        Sat, 18 Jul 2020 17:39:37 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v5] PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for bridge_class_quirk()
Date:   Sat, 18 Jul 2020 17:39:36 +0800
Message-Id: <1595065176-460-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxP2ZZwxJfPMkAAA--.893S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr17tFykJF1xCr1kZr18Xwb_yoW8uF4Dpa
        45Aa17KF4FqFWDAw1DWrWDWa45uF9xCa48Ca9a9w129asxXa4UWrZrKa4Fvr4UJrWkXay8
        XayDCw48Ca1Dur7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUjaLvtUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to the datasheet of Loongson LS7A bridge chip, the old version
of Loongson LS7A PCIE port has a wrong value about PCI class which is
0x060000, the correct value should be 0x060400, this bug can be fixed by
"dev->class = PCI_CLASS_BRIDGE_PCI << 8;" at the software level. As far
as I know, the latest version of LS7A has already fixed the value at the
hardware level.

In order to maintain downward compatibility, use DECLARE_PCI_FIXUP_EARLY
instead of DECLARE_PCI_FIXUP_HEADER for bridge_class_quirk() to fix it as
early as possible.

Otherwise, in the function pci_setup_device(), the related code about
"dev->class" such as "class = dev->class >> 8;" and "dev->transparent
= ((dev->class & 0xff) == 1);" maybe get wrong value without EARLY fixup.

Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2: Modify the patch subject used with lower case "loongson"

v3: Update the commit message

v4: Update the commit message to describe the bug

v5: Remove "due to" in the commit message suggested by Sergei Shtylyov

 drivers/pci/controller/pci-loongson.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 459009c..58b862a 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -37,11 +37,11 @@ static void bridge_class_quirk(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_PCIE_PORT_0, bridge_class_quirk);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_PCIE_PORT_1, bridge_class_quirk);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_PCIE_PORT_2, bridge_class_quirk);
 
 static void system_bus_quirk(struct pci_dev *pdev)
-- 
2.1.0

