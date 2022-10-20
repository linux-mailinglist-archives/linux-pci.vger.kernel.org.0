Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491A0605991
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 10:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiJTIWL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 04:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiJTIWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 04:22:10 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B3EE15CB1C;
        Thu, 20 Oct 2022 01:22:07 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.32])
        by gateway (Coremail) with SMTP id _____8CxKdguBVFjM_wAAA--.3054S3;
        Thu, 20 Oct 2022 16:22:06 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLuItBVFjxM4BAA--.7555S5;
        Thu, 20 Oct 2022 16:22:06 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH V4 3/4] irqchip/loongson-pch-pic: Support to set IRQ type for ACPI path
Date:   Thu, 20 Oct 2022 16:22:04 +0800
Message-Id: <20221020082205.20505-4-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221020082205.20505-1-lvjianmin@loongson.cn>
References: <20221020082205.20505-1-lvjianmin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLuItBVFjxM4BAA--.7555S5
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Ar47tr4UJrWfGw48KryxuFg_yoW8GF4UpF
        W5Cr4avwsrJry7Cw1Fkw4kG343A3s7tFW7KF4UtFnaqrn7G3s5AF1UuFWv9rn5ZFWfAF12
        qanYqFW5ua43AFDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU4eMKDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For ACPI path, the translate callback used IRQ_TYPE_NONE and ignored
the IRQ type in fwspec->param[1]. For supporting to set type for
IRQs of the irqdomain, fwspec->param[1] should be used to get IRQ
type.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/irqchip/irq-loongson-pch-pic.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 03493cda65a3..a26a3f59d4a5 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -155,9 +155,6 @@ static int pch_pic_domain_translate(struct irq_domain *d,
 	struct pch_pic *priv = d->host_data;
 	struct device_node *of_node = to_of_node(fwspec->fwnode);
 
-	if (fwspec->param_count < 1)
-		return -EINVAL;
-
 	if (of_node) {
 		if (fwspec->param_count < 2)
 			return -EINVAL;
@@ -165,8 +162,14 @@ static int pch_pic_domain_translate(struct irq_domain *d,
 		*hwirq = fwspec->param[0] + priv->ht_vec_base;
 		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 	} else {
+		if (fwspec->param_count < 1)
+			return -EINVAL;
+
 		*hwirq = fwspec->param[0] - priv->gsi_base;
-		*type = IRQ_TYPE_NONE;
+		if (fwspec->param_count > 1)
+			*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+		else
+			*type = IRQ_TYPE_NONE;
 	}
 
 	return 0;
-- 
2.31.1

