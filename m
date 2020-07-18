Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68182249E6
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jul 2020 10:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGRIhj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jul 2020 04:37:39 -0400
Received: from mail.loongson.cn ([114.242.206.163]:45526 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbgGRIhj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Jul 2020 04:37:39 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxKuSwtBJf6MMAAA--.13S2;
        Sat, 18 Jul 2020 16:37:05 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v4] PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for bridge_class_quirk()
Date:   Sat, 18 Jul 2020 16:37:04 +0800
Message-Id: <1595061424-27701-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxKuSwtBJf6MMAAA--.13S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr17tFykJF1xCr1kZr18Xwb_yoW8Zw1Dpa
        45Aa17KF4FqFWDAw1DWrWDWa45uF9rCa48Ca929wnF9asxX3WUWr9rKa4Fvr4UJrWkXayU
        XayDCr48Ca1Duw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUSeHgUUUUU=
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
= ((dev->class & 0xff) == 1);" maybe get wrong value due to without
EARLY fixup.

Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2: Modify the patch subject used with lower case "loongson"

v3: Update the commit message

v4: Update the commit message

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

