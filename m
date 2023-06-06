Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C32723C17
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjFFIpr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 04:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjFFIpp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 04:45:45 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21F6FEA;
        Tue,  6 Jun 2023 01:45:42 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8BxHPA08n5k1g0AAA--.408S3;
        Tue, 06 Jun 2023 16:45:40 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTMoz8n5kzAkCAA--.301S2;
        Tue, 06 Jun 2023 16:45:39 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Will Deacon <will@kernel.org>, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3] PCI: Align pci memory space base address with page size
Date:   Tue,  6 Jun 2023 16:45:39 +0800
Message-Id: <20230606084539.1694441-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxTMoz8n5kzAkCAA--.301S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF15tFy7CrWfZFWrGr45Jwc_yoW8Xr13pF
        W7AanrCry8Gr13Gw4vqw1kuF4fWa1v93yYyrWfAasag3ZrCas2yr1UAFy5Zry8ur47GF1U
        XFs8tr1fZFWrXagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
        6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
        Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
        IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
        WIevJa73UjIFyTuYvjxU2MKZDUUUU
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
it should not be a problem on 64 bit system.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/pci/setup-res.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 967f9a758923..55440ae0128d 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -339,6 +339,14 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_64BIT
+	/*
+	 * force minimum page alignment for vfio pci usage
+	 * supposing there is enough pci memory resource on 64bit system
+	 */
+	if (res->flags & IORESOURCE_MEM)
+		align = max_t(resource_size_t, PAGE_SIZE, align);
+#endif
 	size = resource_size(res);
 	ret = _pci_assign_resource(dev, resno, size, align);
 
-- 
2.27.0

