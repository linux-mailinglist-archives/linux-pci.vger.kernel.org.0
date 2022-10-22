Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B076608B8D
	for <lists+linux-pci@lfdr.de>; Sat, 22 Oct 2022 12:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJVKZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Oct 2022 06:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiJVKZR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Oct 2022 06:25:17 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA14C309E20;
        Sat, 22 Oct 2022 02:41:19 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.32])
        by gateway (Coremail) with SMTP id _____8DxPdn7olNjLJ0BAA--.6893S3;
        Sat, 22 Oct 2022 15:59:55 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_1f7olNjLlUDAA--.13337S3;
        Sat, 22 Oct 2022 15:59:55 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH V5 1/4] ACPI / PCI: fix LPIC IRQ model default PCI IRQ polarity
Date:   Sat, 22 Oct 2022 15:59:52 +0800
Message-Id: <20221022075955.11726-2-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221022075955.11726-1-lvjianmin@loongson.cn>
References: <20221022075955.11726-1-lvjianmin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_1f7olNjLlUDAA--.13337S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7CF1UAryUJr1rXF48JF43ZFb_yoW8ZFyfpF
        Za9a1ayr4ktFZ8Xan2k3W8ZFyrJ3ZxCrWYkan5Cw47Ga1Dur4IqFyxWFW7J3s8WFZrZa1U
        Zr1Yyw48WasrCFJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On LoongArch based systems, the PCI devices (e.g. SATA controllers and
PCI-to-PCI bridge controllers) in Loongson chipsets output high-level
interrupt signal to the interrupt controller they are connected (see
Loongson 7A1000 Bridge User Manual v2.00, sec 5.3, "For the bridge chip,
AC97 DMA interrupts are edge triggered, gpio interrupts can be configured
to be level triggered or edge triggered as needed, and the rest of the
interrupts are level triggered and active high."), while the IRQs are
active low from the perspective of PCI (see Conventional PCI spec r3.0,
sec 2.2.6, "Interrupts on PCI are optional and defined as level sensitive,
asserted low."), which means that the interrupt output of PCI devices plugged
into PCI-to-PCI bridges of Loongson chipset will be also converted to high-level.
So high level triggered type is required to be passed to acpi_register_gsi()
when creating mappings for PCI devices.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/acpi/pci_irq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 08e15774fb9f..ff30ceca2203 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -387,13 +387,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	u8 pin;
 	int triggering = ACPI_LEVEL_SENSITIVE;
 	/*
-	 * On ARM systems with the GIC interrupt model, level interrupts
+	 * On ARM systems with the GIC interrupt model, or LoongArch
+	 * systems with the LPIC interrupt model, level interrupts
 	 * are always polarity high by specification; PCI legacy
 	 * IRQs lines are inverted before reaching the interrupt
 	 * controller and must therefore be considered active high
 	 * as default.
 	 */
-	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
+	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ||
+		       acpi_irq_model == ACPI_IRQ_MODEL_LPIC ?
 				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
 	char *link = NULL;
 	char link_desc[16];
-- 
2.31.1

