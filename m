Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E48A605995
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 10:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJTIWO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 04:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiJTIWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 04:22:10 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FB6215B110;
        Thu, 20 Oct 2022 01:22:07 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.32])
        by gateway (Coremail) with SMTP id _____8BxLtsuBVFjJvwAAA--.5004S3;
        Thu, 20 Oct 2022 16:22:06 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLuItBVFjxM4BAA--.7555S3;
        Thu, 20 Oct 2022 16:22:05 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH V4 1/4] ACPI / PCI: fix LPIC IRQ model default PCI IRQ polarity
Date:   Thu, 20 Oct 2022 16:22:02 +0800
Message-Id: <20221020082205.20505-2-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221020082205.20505-1-lvjianmin@loongson.cn>
References: <20221020082205.20505-1-lvjianmin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLuItBVFjxM4BAA--.7555S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJrW3XFW3ZFWfZFyktFWxXrb_yoW8ArWxpF
        ZF93Wayr48tFs8XwsFk3WxZry5J3Z3Cryjkrs5Cw4Uua1Dur4IqFyxWFW3Jr98WFZrZa1U
        ZryYyw48Way7uFJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        CVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jr6p9UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On LoongArch ACPI based systems, the PCI devices (e.g. sata
controlers and PCI-to-to PCI bridge controlers) existed in
Loongson chipsets output high-level interrupt signal to the
interrupt controller they connected to, while the IRQs are
active low from the perspective of PCI(in 2.2.6. Interrupt
Pins, "Interrupts on PCI are optional and defined as level
sensitive, asserted low), which means that the interrupt
output of PCI devices plugged into PCI-to-to PCI bridges of
Loongson chipset will be also converted to high-level. So
high level triggered type is required to be passed to
acpi_register_gsi() when creating mappings for PCI devices.

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

