Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0242A773D80
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjHHQSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjHHQRU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:17:20 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C09A93C06;
        Tue,  8 Aug 2023 08:48:24 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cxrus0WNJkk_ESAA--.39249S3;
        Tue, 08 Aug 2023 22:59:00 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxJ80zWNJk4DNPAA--.1524S2;
        Tue, 08 Aug 2023 22:58:59 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH] PCI/VGA: Make the vga_is_firmware_default() less arch-independent
Date:   Tue,  8 Aug 2023 22:58:59 +0800
Message-Id: <20230808145859.1590625-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ80zWNJk4DNPAA--.1524S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww1fGrW7ZF15ur4kAw18WFX_yoW3CF4kpF
        WfJFWfKFs8Gr4fJrZrGF48Xw1rZrsY9FW8KFW7A3Z3Ja43urykur1FyFZ0qryfJ397Jw4f
        KF42yrn5GFsrXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
        6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
        Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
        IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
        vjDU0xZFpf9x07jepB-UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the vga_is_firmware_default() function works only on x86 and
IA64 architectures, but it is a no-op on ARM64, PPC, RISC-V, etc. This
patch completes the implementation by tracking the firmware framebuffer's
address range. The added code is trying to identify the VRAM aperture that
contains the firmware framebuffer. Once found, related information about
the VRAM aperture will be tracked.

Note that we need to identify the VRAM aperture before it get moved. We
achieve this by using DECLARE_PCI_FIXUP_CLASS_HEADER(), which ensures that
vga_arb_firmware_fb_addr_tracker() gets called before PCI resource
allocation. Once we found the VRAM aperture that contains firmware fb, we
are able to monitor the address changes of it. If the VRAM aperture of the
primary GPU do moved, we will update our cached firmware framebuffer's
address range accordingly. This approach overcomes the VRAM bar relocation
issue successfully. Hence, this patch make the vga_is_firmware_default()
function works on whatever arch that has UEFI GOP support, including x86
and IA64. But, at the first step, we make it available only on platforms
which PCI resource relocation do happens. Once provided method proved to
be effective and reliable, it can be expanded to other arch easily.

This patch is tested on
1) LS3A5000+LS7A2000 and LS3A5000+LS7A1000 platform.
2) Intel i3-8100 CPU + H110 D4L motherboard with triple video cards:

$ lspci | grep VGA

Intel Corporation CoffeeLake-S GT2 [UHD Graphics 630]
Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere [Radeon RX 470] (rev cf)
ASPEED Technology, Inc. ASPEED Graphics Family (rev 52)

Note that on x86, in order to testing the new approach this patch provided,
we remove the vga_arb_get_fb_range_from_screen_info() call in
vga_is_firmware_default() function, as following.

-#if defined(CONFIG_X86) || defined(CONFIG_IA64)
-       ret = vga_arb_get_fb_range_from_screen_info(&fb_start, &fb_end);
-#else
        ret = vga_arb_get_fb_range_from_tracker(&fb_start, &fb_end);
-#endif

It is just that we don't observe the case which VRAM Bar of VGA compatible
controller moves, so there just no need to unify it. But on LoongArch,
the VRAM Bar of AMDGPU do moves.

v2:
	* Fix test robot warnnings and fix typos

v3:
	* Fix linkage problems if the global screen_info is not exported

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 154 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 139 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 5a696078b382..e0919a70af3e 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -61,6 +61,92 @@ static bool vga_arbiter_used;
 static DEFINE_SPINLOCK(vga_lock);
 static DECLARE_WAIT_QUEUE_HEAD(vga_wait_queue);
 
+static struct firmware_fb_tracker {
+	/* The PCI(e) device who owns the firmware framebuffer */
+	struct pci_dev *pdev;
+	/* The index of the VRAM Bar */
+	unsigned int bar;
+	/* Firmware fb's offset from the VRAM aperture start */
+	resource_size_t offset;
+	/* The firmware fb's size, in bytes */
+	resource_size_t size;
+
+	/* Firmware fb's address range, suffer from change */
+	resource_size_t start;
+	resource_size_t end;
+} firmware_fb;
+
+/*
+ * Get the physical address range that the firmware framebuffer occupies.
+ *
+ * The global screen_info is arch-specific; it will not be exported if the
+ * CONFIG_EFI is not selected on Arm64. Hence, CONFIG_EFI is chosen as
+ * compile-time conditional to suppress linkage problems. This guard can be
+ * removed if the global screen_info became arch-independent one day.
+ */
+static bool vga_arb_get_fb_range_from_screen_info(resource_size_t *start,
+						  resource_size_t *end)
+{
+	resource_size_t fb_start = 0;
+	resource_size_t fb_size = 0;
+	resource_size_t fb_end;
+
+#if defined(CONFIG_EFI)
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
+static bool vga_arb_get_fb_range_from_tracker(resource_size_t *start,
+					      resource_size_t *end)
+{
+	struct pci_dev *pdev = firmware_fb.pdev;
+	resource_size_t new_vram_base;
+	resource_size_t new_fb_start;
+	resource_size_t old_fb_start;
+	resource_size_t old_fb_end;
+
+	/*
+	 * No firmware framebuffer support or no aperture that contains the
+	 * firmware FB is found. In this case, the firmware_fb.pdev will be
+	 * NULL. We will return immediately.
+	 */
+	if (!pdev)
+		return false;
+
+	new_vram_base = pdev->resource[firmware_fb.bar].start;
+	new_fb_start = new_vram_base + firmware_fb.offset;
+	old_fb_start = firmware_fb.start;
+	old_fb_end = firmware_fb.end;
+
+	if (new_fb_start != old_fb_start) {
+		firmware_fb.start = new_fb_start;
+		firmware_fb.end = new_fb_start + firmware_fb.size - 1;
+		vgaarb_dbg(&pdev->dev,
+			   "[0x%llx, 0x%llx] -> [0x%llx, 0x%llx]\n",
+			   (u64)old_fb_start, (u64)old_fb_end,
+			   (u64)firmware_fb.start, (u64)firmware_fb.end);
+	}
+
+	*start = firmware_fb.start;
+	*end = firmware_fb.end;
+
+	return true;
+}
 
 static const char *vga_iostate_to_str(unsigned int iostate)
 {
@@ -543,20 +629,21 @@ void vga_put(struct pci_dev *pdev, unsigned int rsrc)
 }
 EXPORT_SYMBOL(vga_put);
 
+/* Select the device owning the boot framebuffer if there is one */
 static bool vga_is_firmware_default(struct pci_dev *pdev)
 {
-#if defined(CONFIG_X86) || defined(CONFIG_IA64)
-	u64 base = screen_info.lfb_base;
-	u64 size = screen_info.lfb_size;
 	struct resource *r;
-	u64 limit;
+	resource_size_t fb_start;
+	resource_size_t fb_end;
+	bool ret;
 
-	/* Select the device owning the boot framebuffer if there is one */
-
-	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)screen_info.ext_lfb_base << 32;
-
-	limit = base + size;
+#if defined(CONFIG_X86) || defined(CONFIG_IA64)
+	ret = vga_arb_get_fb_range_from_screen_info(&fb_start, &fb_end);
+#else
+	ret = vga_arb_get_fb_range_from_tracker(&fb_start, &fb_end);
+#endif
+	if (!ret)
+		return false;
 
 	/* Does firmware framebuffer belong to us? */
 	pci_dev_for_each_resource(pdev, r) {
@@ -566,12 +653,10 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
 		if (!r->start || !r->end)
 			continue;
 
-		if (base < r->start || limit >= r->end)
-			continue;
-
-		return true;
+		if (fb_start >= r->start && fb_end <= r->end)
+			return true;
 	}
-#endif
+
 	return false;
 }
 
@@ -1555,3 +1640,42 @@ static int __init vga_arb_device_init(void)
 	return rc;
 }
 subsys_initcall_sync(vga_arb_device_init);
+
+static void vga_arb_firmware_fb_addr_tracker(struct pci_dev *pdev)
+{
+	resource_size_t fb_start;
+	resource_size_t fb_end;
+	unsigned int i;
+
+	/* Already found the pdev which has firmware framebuffer ownership */
+	if (firmware_fb.pdev)
+		return;
+
+	if (!vga_arb_get_fb_range_from_screen_info(&fb_start, &fb_end))
+		return;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		struct resource *ap = &pdev->resource[i];
+
+		if (resource_type(ap) != IORESOURCE_MEM)
+			continue;
+
+		if (!ap->start || !ap->end)
+			continue;
+
+		if (ap->start <= fb_start && fb_end <= ap->end) {
+			firmware_fb.pdev = pdev;
+			firmware_fb.bar = i;
+			firmware_fb.size = fb_end - fb_start + 1;
+			firmware_fb.offset = fb_start - ap->start;
+			firmware_fb.start = fb_start;
+			firmware_fb.end = fb_end;
+
+			vgaarb_dbg(&pdev->dev,
+				   "BAR %u contains firmware FB\n", i);
+			break;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA,
+			       8, vga_arb_firmware_fb_addr_tracker);
-- 
2.34.1

