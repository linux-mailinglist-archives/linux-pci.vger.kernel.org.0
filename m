Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163927B5218
	for <lists+linux-pci@lfdr.de>; Mon,  2 Oct 2023 14:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbjJBMFU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Oct 2023 08:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbjJBMFT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2023 08:05:19 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AB11D3;
        Mon,  2 Oct 2023 05:05:15 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxV_H4sRply5MuAA--.24516S3;
        Mon, 02 Oct 2023 20:05:12 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxK9z3sRplVSEXAA--.47905S3;
        Mon, 02 Oct 2023 20:05:11 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH pci-next v6 1/2] PCI/VGA: Make the vga_is_firmware_default() less arch-dependent
Date:   Mon,  2 Oct 2023 20:05:10 +0800
Message-Id: <20231002120511.594737-2-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002120511.594737-1-suijingfeng@loongson.cn>
References: <20231002120511.594737-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxK9z3sRplVSEXAA--.47905S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFWrCF1xXr4xWFWUZw1kJFc_yoW5tF48pr
        WfGFWrtrs5Gw4fGrW3ta10qFn09F93C340kFW3uwn3CF17AFykWr1FkFZ0qry5G397XF43
        XF4ayF1DGayDXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
        wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HSoJUUUUU==
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
 drivers/pci/vgaarb.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 5e6b1eb54c64..02821c0f4cd0 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -60,6 +60,9 @@ static bool vga_arbiter_used;
 static DEFINE_SPINLOCK(vga_lock);
 static DECLARE_WAIT_QUEUE_HEAD(vga_wait_queue);
 
+/* The PCI(e) VGA device which owns the firmware framebuffer */
+static struct pci_dev *pdev_boot_vga;
+
 static const char *vga_iostate_to_str(unsigned int iostate)
 {
 	/* Ignore VGA_RSRC_IO and VGA_RSRC_MEM */
@@ -582,6 +585,9 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
 
 		return true;
 	}
+#else
+	if (pdev_boot_vga && pdev_boot_vga == pdev)
+		return true;
 #endif
 	return false;
 }
@@ -1557,3 +1563,73 @@ static int __init vga_arb_device_init(void)
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

