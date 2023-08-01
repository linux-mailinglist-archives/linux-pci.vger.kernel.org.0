Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4051076BD12
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 20:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjHAS4V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjHAS4T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 14:56:19 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49F46268F;
        Tue,  1 Aug 2023 11:56:12 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxTetLVclk7UsOAA--.28292S3;
        Wed, 02 Aug 2023 02:56:11 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF81JVclkyWREAA--.44250S2;
        Wed, 02 Aug 2023 02:56:09 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, Li Yi <liyi@loongson.cn>,
        linux-pci@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH] LoongArch: Remove vgaarb related workarounds
Date:   Wed,  2 Aug 2023 02:56:07 +0800
Message-Id: <20230801185607.703295-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF81JVclkyWREAA--.44250S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFy5Xr13GrWUtrWUAw4xuFX_yoW8CF13pF
        nI9Fs7KrWfGr18GwnIyr17WryDZ3ZrA347uFWaka40kr13Zw1Fq393Ar93Xr4fJa9rXFWx
        ZFs8Cw48KF4DtabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When we have a better approach[1] to handle multiple video cards problems
on Loongarch, we want to drop the vgaarb related workaround.

[1] https://patchwork.freedesktop.org/patch/550708/?series=121740&rev=1

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Li Yi <liyi@loongson.cn>
Cc: linux-pci@vger.kernel.org
Cc: loongson-kernel@lists.loongnix.cn
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 arch/loongarch/pci/pci.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
index 2726639150bc..4319b5d75872 100644
--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -8,13 +8,10 @@
 #include <linux/acpi.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-#include <linux/vgaarb.h>
 #include <asm/cacheflush.h>
 #include <asm/loongson.h>
 
 #define PCI_DEVICE_ID_LOONGSON_HOST     0x7a00
-#define PCI_DEVICE_ID_LOONGSON_DC1      0x7a06
-#define PCI_DEVICE_ID_LOONGSON_DC2      0x7a36
 
 int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
 						int reg, int len, u32 *val)
@@ -82,19 +79,3 @@ int pcibios_alloc_irq(struct pci_dev *dev)
 		return 0;
 	return acpi_pci_irq_enable(dev);
 }
-
-static void pci_fixup_vgadev(struct pci_dev *pdev)
-{
-	struct pci_dev *devp = NULL;
-
-	while ((devp = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, devp))) {
-		if (devp->vendor != PCI_VENDOR_ID_LOONGSON) {
-			vga_set_default_device(devp);
-			dev_info(&pdev->dev,
-				"Overriding boot device as %X:%X\n",
-				devp->vendor, devp->device);
-		}
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC1, pci_fixup_vgadev);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC2, pci_fixup_vgadev);
-- 
2.34.1

