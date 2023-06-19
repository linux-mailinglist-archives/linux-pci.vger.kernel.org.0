Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A67349C5
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 03:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjFSBrb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Jun 2023 21:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFSBra (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Jun 2023 21:47:30 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1518E42;
        Sun, 18 Jun 2023 18:47:28 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8DxzOqvs49kgLAGAA--.13847S3;
        Mon, 19 Jun 2023 09:47:27 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxbMqus49kK6UfAA--.14793S2;
        Mon, 19 Jun 2023 09:47:27 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v5] PCI: Align pci memory space base address with page size
Date:   Mon, 19 Jun 2023 09:47:15 +0800
Message-Id: <20230619014715.3792883-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxbMqus49kK6UfAA--.14793S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGr1rurW3JF48uF4UArWkAFc_yoW5ZFyUpF
        yfAwnrCrW8Gr13G398t34kuF43Xan2k3yY9ryrCa4rWF9rZFyUA348Jryaqa4UAr4kWrW0
        qFn5KF1jqa15X3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
        Ja73UjIFyTuYvjxU2MKZDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCI devices have only 4K memory space size, it is normal in general
machines and aligned with page size. However some architectures which
support different page size, default page size on LoongArch is 16K, and
ARM64 supports page size varying from 4K to 64K. On machines where larger
page size is use, memory space region of two different pci devices may be
in one page. It is not safe with mmu protection, also VFIO pci device
driver requires base address of pci memory space page aligned, so that it
can be memory mapped to qemu user space when it is passed-through to vm.

It consumes more pci memory resource with page size alignment requirement,
here extra option PCI_MEMRES_PAGE_ALIGN is added, it can be enabled by
different architectures, currently arm64/loongarch enable this option.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
Change history
v5: enable option PCI_MEMRES_PAGE_ALIGN on arm64. Verified on LoongArch
and pass to compile on arm64 with defconfig

v4: add extra kernel option PCI_MEMRES_PAGE_ALIGN to set memory resource
    page aligned

v3: move alignment requirement to generic pci code

v2: add pci resource alignment requirement in arch specified function
    pcibios_align_resource on arm64/LoongArch platforms

---
 arch/arm64/Kconfig      | 1 +
 arch/loongarch/Kconfig  | 1 +
 drivers/pci/Kconfig     | 3 +++
 drivers/pci/setup-res.c | 7 +++++++
 4 files changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 343e1e1cae10..24858bbf2b72 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -232,6 +232,7 @@ config ARM64
 	select OF_EARLY_FLATTREE
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_ECAM if (ACPI && PCI)
+	select PCI_MEMRES_PAGE_ALIGN if PCI
 	select PCI_SYSCALL if PCI
 	select POWER_RESET
 	select POWER_SUPPLY
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d38b066fc931..7dbde5e5b351 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -140,6 +140,7 @@ config LOONGARCH
 	select PCI_DOMAINS_GENERIC
 	select PCI_ECAM if ACPI
 	select PCI_LOONGSON
+	select PCI_MEMRES_PAGE_ALIGN
 	select PCI_MSI_ARCH_FALLBACKS
 	select PCI_QUIRKS
 	select PERF_USE_VMALLOC
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9309f2469b41..9be5f85ff9dc 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -128,6 +128,9 @@ config PCI_LOCKLESS_CONFIG
 config PCI_BRIDGE_EMUL
 	bool
 
+config PCI_MEMRES_PAGE_ALIGN
+	bool
+
 config PCI_IOV
 	bool "PCI IOV support"
 	select PCI_ATS
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 967f9a758923..6ad76734a670 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -339,6 +339,13 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_PCI_MEMRES_PAGE_ALIGN
+	/*
+	 * force minimum page alignment for vfio pci usage
+	 */
+	if (res->flags & IORESOURCE_MEM)
+		align = max_t(resource_size_t, PAGE_SIZE, align);
+#endif
 	size = resource_size(res);
 	ret = _pci_assign_resource(dev, resno, size, align);
 
-- 
2.27.0

