Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7F82219C7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 04:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGPCTa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 22:19:30 -0400
Received: from mail.loongson.cn ([114.242.206.163]:37408 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726770AbgGPCTa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 22:19:30 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxqdQbuQ9ff2QFAA--.5347S2;
        Thu, 16 Jul 2020 10:19:08 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v3] PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for bridge_class_quirk()
Date:   Thu, 16 Jul 2020 10:19:06 +0800
Message-Id: <1594865946-15188-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9CxqdQbuQ9ff2QFAA--.5347S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4kGr4UtrW7Gr4xZr47urg_yoW5Cw4Dpa
        y5Ja12kF4FqFZ8AwnrW34DCasY9FnxArykCa9xWwnF9a43ua45WrW7KF9YqF45Jw4kXr4U
        Xas8C3W8Ja15urUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUF3kuDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to the datasheet of Loongson LS7A bridge chip, the old version
of Loongson LS7A PCIE port has a hardware bug about PCI class. As far as
I know, the latest version has already fixed this bug.

In order to maintain downward compatibility, use DECLARE_PCI_FIXUP_EARLY
instead of DECLARE_PCI_FIXUP_HEADER for bridge_class_quirk() to fix it as
early as possible.

Otherwise, in the function pci_setup_device(), the related code about
"dev->class" such as "class = dev->class >> 8;" and "dev->transparent
= ((dev->class & 0xff) == 1);" maybe get wrong value due to without
EARLY fixup.

By the way, we can see that the PCI class fixup of other controllers are
all EARLY fixups:

[root@linux linux.git]# grep -rn -A 3 "PCI_CLASS_BRIDGE_PCI << 8" drivers/pci/controller/ | grep EARLY
drivers/pci/controller/pcie-tango.c-327-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x0024, tango_fixup_class);
drivers/pci/controller/pcie-tango.c-328-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x0028, tango_fixup_class);
drivers/pci/controller/pci-tegra.c-775-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf0, tegra_pcie_fixup_class);
drivers/pci/controller/pci-tegra.c-776-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
drivers/pci/controller/dwc/pcie-qcom.c-1442-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0101, qcom_fixup_class);
drivers/pci/controller/dwc/pcie-qcom.c-1443-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0104, qcom_fixup_class);
drivers/pci/controller/pcie-iproc-bcma.c-23-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8011, bcma_pcie2_fixup_class);
drivers/pci/controller/pcie-iproc-bcma.c-24-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8012, bcma_pcie2_fixup_class);

Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2: Modify the patch subject used with lower case "loongson"

v3: Update the commit message

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

