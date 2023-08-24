Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2E1787373
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbjHXPDo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242150AbjHXPDk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 11:03:40 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFAF7FD;
        Thu, 24 Aug 2023 08:03:35 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cx5_FGcedknZAbAA--.56209S3;
        Thu, 24 Aug 2023 23:03:34 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c5EcedkEYBiAA--.42989S4;
        Thu, 24 Aug 2023 23:03:33 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v5 2/2] PCI/VGA: Remove vga_is_firmware_default() function
Date:   Thu, 24 Aug 2023 23:03:32 +0800
Message-Id: <20230824150332.6434-3-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824150332.6434-1-suijingfeng@loongson.cn>
References: <20230824150332.6434-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx_c5EcedkEYBiAA--.42989S4
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr1UKry5tw43Cry3KryxtFc_yoW5GFW8pF
        s3tFWxJrW8Wr45C3s0yF48ZF15ZwsY9aykKFWq93s3Ga45Arn7XrW3ArZYyry7JrZ2q3W3
        AF13Jr10qFyDJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
        McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
        1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
        JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
        UjIFyTuYvjxU4OzVUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The new implemented pci_boot_vga_capturer() function is also effective on
X86 and IA64, it can determine the default boot VGA device before VRAM BAR
relocations done by the PCI core. Since the fixup handler has already
identified the firmware framebuffer, there no need to look again later. So,
switch to using the pci_boot_vga_capturer() on X86 and IA64 also, remove
vga_is_firmware_default() and its relevant codes.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 46 +++-----------------------------------------
 1 file changed, 3 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index bc5fcc855513..1dff74f778cd 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -51,7 +51,6 @@ struct vga_device {
 	unsigned int io_norm_cnt;	/* normal IO count */
 	unsigned int mem_norm_cnt;	/* normal MEM count */
 	bool bridge_has_one_vga;
-	bool is_firmware_default;	/* device selected by firmware */
 	unsigned int (*set_decode)(struct pci_dev *pdev, bool decode);
 };
 
@@ -544,41 +543,6 @@ void vga_put(struct pci_dev *pdev, unsigned int rsrc)
 }
 EXPORT_SYMBOL(vga_put);
 
-static bool vga_is_firmware_default(struct pci_dev *pdev)
-{
-#if defined(CONFIG_X86) || defined(CONFIG_IA64)
-	u64 base = screen_info.lfb_base;
-	u64 size = screen_info.lfb_size;
-	struct resource *r;
-	u64 limit;
-
-	/* Select the device owning the boot framebuffer if there is one */
-
-	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)screen_info.ext_lfb_base << 32;
-
-	limit = base + size;
-
-	/* Does firmware framebuffer belong to us? */
-	pci_dev_for_each_resource(pdev, r) {
-		if (resource_type(r) != IORESOURCE_MEM)
-			continue;
-
-		if (!r->start || !r->end)
-			continue;
-
-		if (base < r->start || limit >= r->end)
-			continue;
-
-		return true;
-	}
-#else
-	if (pdev_boot_vga && pdev_boot_vga == pdev)
-		return true;
-#endif
-	return false;
-}
-
 static bool vga_arb_integrated_gpu(struct device *dev)
 {
 #if defined(CONFIG_ACPI)
@@ -610,14 +574,10 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
 	 */
 
 	/*
-	 * We always prefer a firmware default device, so if we've already
-	 * found one, there's no need to consider vgadev.
+	 * We always prefer a firmware default device.
 	 */
-	if (boot_vga && boot_vga->is_firmware_default)
-		return false;
-
-	if (vga_is_firmware_default(pdev)) {
-		vgadev->is_firmware_default = true;
+	if (pdev == pdev_boot_vga) {
+		vgaarb_dbg(&pdev->dev, "Boot VGA selected by firmware\n");
 		return true;
 	}
 
-- 
2.34.1

