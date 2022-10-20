Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E27C60598D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 10:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiJTIWK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 04:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJTIWJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 04:22:09 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F3DB15A96C;
        Thu, 20 Oct 2022 01:22:07 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.32])
        by gateway (Coremail) with SMTP id _____8BxfdouBVFjJ_wAAA--.5190S3;
        Thu, 20 Oct 2022 16:22:06 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLuItBVFjxM4BAA--.7555S2;
        Thu, 20 Oct 2022 16:22:05 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH V4 0/4] irqchip: Support to set irq type for ACPI path
Date:   Thu, 20 Oct 2022 16:22:01 +0800
Message-Id: <20221020082205.20505-1-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLuItBVFjxM4BAA--.7555S2
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvdXoWrKFWUur13CryDAFy3XrWfAFb_yoWktFgE9F
        4I934DZa4vqFn2vayxJry5XFyqyFWDWa1v9FWvyFn3W34rJws3Ar47uw1aq34xtFy5XFs3
        JrZ5Ar1FkryI9jkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        A7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4
        kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I
        6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8EoGPUUUUU==
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

V3 -> V4
- Improve commit log

Jianmin Lv (4):
  ACPI / PCI: fix LPIC IRQ model default PCI IRQ polarity
  irqchip/loongson-pch-pic: fix translate callback for DT path
  irqchip/loongson-pch-pic: Support to set IRQ type for ACPI path
  irqchip/loongson-liointc: Support to set IRQ type for ACPI path

 drivers/acpi/pci_irq.c                 |  6 ++++--
 drivers/irqchip/irq-loongson-liointc.c |  7 ++++++-
 drivers/irqchip/irq-loongson-pch-pic.c | 14 ++++++++++----
 3 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.31.1

