Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80C55F89C2
	for <lists+linux-pci@lfdr.de>; Sun,  9 Oct 2022 08:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJIGo4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Oct 2022 02:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJIGox (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Oct 2022 02:44:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F9E865B9;
        Sat,  8 Oct 2022 23:44:48 -0700 (PDT)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxX+DPbUJjsykpAA--.19711S2;
        Sun, 09 Oct 2022 14:44:31 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH V3 0/4] irqchip: Support to set irq type for ACPI path
Date:   Sun,  9 Oct 2022 14:44:27 +0800
Message-Id: <20221009064431.18839-1-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxX+DPbUJjsykpAA--.19711S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWUur13CryDAFy3XrWfAFb_yoWkZrX_uF
        4I934DZa4vqF1IvayxJry5XFyqyFWDWa1v9FWvyFn3W34rJws3Ar47uwnI934xKa4rXFn3
        GrZ5Jr1Fk34I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUba8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
        jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK
        6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFV
        Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
        x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
        1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
        JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For ACPI path of pch-pic and liointc driver, setting irq
type is not supported yet, so the patch series add code
to implement it.

And a bug in translate callback of irqchip/loongson-pch-pic, which
is introduced by previous patch, is fixed.

GSI for legacy irqs of PCI devices are mapped in pch-pic domain, after
supporting setting_irq_type for pch-pic domain, we add the workaround
for LoongArch based PCI controller with high-level trigger intterrupt
so that the high-level trigger type is passed into acpi_register_gsi().
  
V1 -> V2
- Change comment information and fix a bug for DT path in patch[1].

V2 -> V3
- Separate original patch[1] to three patches[1][2][3].

Jianmin Lv (4):
  ACPI / PCI: fix LPIC irq model default PCI IRQ polarity
  irqchip/loongson-pch-pic: fix translate callback for DT path
  irqchip/loongson-pch-pic: Support to set irq type for ACPI path
  irqchip/loongson-liointc: Support to set irq type for ACPI path

 drivers/acpi/pci_irq.c                 |  6 ++++--
 drivers/irqchip/irq-loongson-liointc.c |  7 ++++++-
 drivers/irqchip/irq-loongson-pch-pic.c | 14 ++++++++++----
 3 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.31.1

