Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6F721C9F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 05:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjFEDod (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Jun 2023 23:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFEDoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 23:44:32 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B433B4;
        Sun,  4 Jun 2023 20:44:29 -0700 (PDT)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx5OEXWn1k_S0AAA--.861S2;
        Mon, 05 Jun 2023 11:44:23 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2] PCI: Align pci memory space base address with page size
Date:   Mon,  5 Jun 2023 11:44:23 +0800
Message-Id: <20230605034423.1528206-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx5OEXWn1k_S0AAA--.861S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1rurW3JrykAr1fArykGrg_yoW5WFW3pF
        yfAan5CFs8Gr13GwsxJw1DuF4fWan29wsxJrWfAr93KFsrZry3Xr1fJryUurW8Aw4DGFWj
        gFs0yr1UuFyDXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCI devices has only 4K memory space size, it is normal in general
machines and aligned with page size. However some architectures which
support different page size, default page size on LoongArch is 16K, and
ARM64 supports page size varying from 4K to 64K. On machines where larger
page size is use, memory space region of two different pci devices may be
in one page. It is not safe with mmu protection, also VFIO pci device
driver requires base address of pci memory space page aligned, so that it
can be memory mapped to qemu user space when it is pass-through to vm.

It consumes more pci memory resource with page size alignment requirement,
on 64 bit system it should not be a problem. And UEFI bios set pci memory
base address with 4K fixed-size aligned, the safer solution is to align
with larger size on UEFI BIOS stage on these architectures, linux kernel
can reuse resource from UEFI bios. For new devices such hotplug pci
devices and sriov devices, pci resource is assigned in Linux kernel side.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/arm64/kernel/pci.c  | 13 +++++++++++++
 arch/loongarch/pci/pci.c | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 2276689b5411..e2f7b176b156 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -232,4 +232,17 @@ void pcibios_remove_bus(struct pci_bus *bus)
 	acpi_pci_remove_bus(bus);
 }
 
+resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+				resource_size_t size, resource_size_t align)
+{
+	resource_size_t start = res->start;
+
+	/*
+	 * align base address of pci memory resource with page size
+	 */
+	if ((res->flags & IORESOURCE_MEM) && (align < PAGE_SIZE))
+		start = ALIGN(start, PAGE_SIZE);
+
+	return start;
+}
 #endif
diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
index 2726639150bc..943a48e60fb1 100644
--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -83,6 +83,24 @@ int pcibios_alloc_irq(struct pci_dev *dev)
 	return acpi_pci_irq_enable(dev);
 }
 
+/*
+ * memory space size of some pci cards is 4K, it is separated with
+ * different pages for generic architectures, so that mmu protection can
+ * work with different pci cards. However page size for LoongArch system
+ * is 16K, memory space of different pci cards may share the same page
+ * on LoongArch, it is not safe here.
+ */
+resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+				resource_size_t size, resource_size_t align)
+{
+	resource_size_t start = res->start;
+
+	if ((res->flags & IORESOURCE_MEM) && (align < PAGE_SIZE))
+		start = ALIGN(start, PAGE_SIZE);
+
+	return start;
+}
+
 static void pci_fixup_vgadev(struct pci_dev *pdev)
 {
 	struct pci_dev *devp = NULL;
-- 
2.27.0

