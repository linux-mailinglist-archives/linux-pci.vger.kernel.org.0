Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751BD78736C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbjHXPDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbjHXPDj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 11:03:39 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E45A919AA;
        Thu, 24 Aug 2023 08:03:35 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cx2epGcedkmZAbAA--.51253S3;
        Thu, 24 Aug 2023 23:03:34 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c5EcedkEYBiAA--.42989S3;
        Thu, 24 Aug 2023 23:03:33 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v5 1/2] PCI/VGA: Make the vga_is_firmware_default() less arch-dependent
Date:   Thu, 24 Aug 2023 23:03:31 +0800
Message-Id: <20230824150332.6434-2-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824150332.6434-1-suijingfeng@loongson.cn>
References: <20230824150332.6434-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx_c5EcedkEYBiAA--.42989S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFWrCF1xXr4xWFWUZw1kJFc_yoW5tF4kpr
        WfGFyrtrZ5Gw4fGrW3tF4jqF15Ar93Cry0kFW29wn3CF13JrykWr1FyFZ0qryUJ397XF43
        JF4ayF1DGayDJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
        McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
        1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
        JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
        UjIFyTuYvjxUcCztUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the vga_is_firmware_default() function only works on x86 and
ia64, it is a no-op on the rest of the architectures. This patch completes
the implementation for it, the added code tries to capture the PCI (e) VGA
device that owns the firmware framebuffer, since only one GPU could own
the firmware fb, things are almost done once we have determined the boot
VGA device. As the PCI resource relocation do have a influence on the
results of identification, we make it available on architectures where PCI
resource relocation does happen at first. Because this patch is more
important for those architectures(such as arm, arm64, loongarch, mips and
risc-v etc).

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 76 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 5a696078b382..bc5fcc855513 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -60,7 +60,8 @@ static int vga_count, vga_decode_count;
 static bool vga_arbiter_used;
 static DEFINE_SPINLOCK(vga_lock);
 static DECLARE_WAIT_QUEUE_HEAD(vga_wait_queue);
-
+/* The PCI(e) device who owns the firmware framebuffer */
+static struct pci_dev *pdev_boot_vga;
 
 static const char *vga_iostate_to_str(unsigned int iostate)
 {
@@ -571,6 +572,9 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
 
 		return true;
 	}
+#else
+	if (pdev_boot_vga && pdev_boot_vga == pdev)
+		return true;
 #endif
 	return false;
 }
@@ -1555,3 +1559,73 @@ static int __init vga_arb_device_init(void)
 	return rc;
 }
 subsys_initcall_sync(vga_arb_device_init);
+
+/*
+ * Get the physical address range that the firmware framebuffer occupies.
+ *
+ * Note that the global screen_info is arch-specific, thus CONFIG_SYSFB is
+ * chosen as compile-time conditional to suppress linkage problems on non-x86
+ * architectures.
+ *
+ * Returns true on success, otherwise return false.
+ */
+static bool vga_arb_get_firmware_fb_range(u64 *start, u64 *end)
+{
+	u64 fb_start = 0;
+	u64 fb_size = 0;
+	u64 fb_end;
+
+#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_SYSFB)
+	fb_start = screen_info.lfb_base;
+	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		fb_start |= (u64)screen_info.ext_lfb_base << 32;
+
+	fb_size = screen_info.lfb_size;
+#endif
+
+	/* No firmware framebuffer support */
+	if (!fb_start || !fb_size)
+		return false;
+
+	fb_end = fb_start + fb_size - 1;
+
+	*start = fb_start;
+	*end = fb_end;
+
+	return true;
+}
+
+/*
+ * Identify the PCI VGA device that contains the firmware framebuffer
+ */
+static void pci_boot_vga_capturer(struct pci_dev *pdev)
+{
+	u64 fb_start, fb_end;
+	struct resource *res;
+	unsigned int i;
+
+	if (pdev_boot_vga)
+		return;
+
+	if (!vga_arb_get_firmware_fb_range(&fb_start, &fb_end))
+		return;
+
+	pci_dev_for_each_resource(pdev, res, i) {
+		if (resource_type(res) != IORESOURCE_MEM)
+			continue;
+
+		if (!res->start || !res->end)
+			continue;
+
+		if (res->start <= fb_start && fb_end <= res->end) {
+			pdev_boot_vga = pdev;
+
+			vgaarb_info(&pdev->dev,
+				    "BAR %u: %pR contains firmware FB [0x%llx-0x%llx]\n",
+				    i, res, fb_start, fb_end);
+			break;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA,
+			       8, pci_boot_vga_capturer);
-- 
2.34.1

