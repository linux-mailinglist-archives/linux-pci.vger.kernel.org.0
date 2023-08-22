Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816D4784030
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjHVLzs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 07:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbjHVLzr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 07:55:47 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE947E67;
        Tue, 22 Aug 2023 04:55:32 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8Cx5_ExouRksucaAA--.54912S3;
        Tue, 22 Aug 2023 19:55:29 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXSMvouRk30RgAA--.19507S2;
        Tue, 22 Aug 2023 19:55:28 +0800 (CST)
From:   Feiyang Chen <chenfeiyang@loongson.cn>
To:     bhelgaas@google.com, rafael.j.wysocki@intel.com
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>,
        mika.westerberg@linux.intel.com, helgaas@kernel.org,
        anders.roxell@linaro.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, guyinggang@loongson.cn,
        siyanteng@loongson.cn, chenhuacai@loongson.cn,
        loongson-kernel@lists.loongnix.cn, chris.chenfeiyang@gmail.com
Subject: [PATCH v2] PCI/PM: Only read PCI_PM_CTRL register when available
Date:   Tue, 22 Aug 2023 19:55:14 +0800
Message-Id: <20230822115514.999111-1-chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXSMvouRk30RgAA--.19507S2
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtFyfKr1fZr43CFy3tFW7ZFc_yoWDtrgE93
        ykZa4xZrWqyFn8Cas8Aws7ZrW09anxurn7uFs2qF13CF1xW34kJFyUZrn8Cry3W3y5WF98
        u3srGw15CryvyosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUb-8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
        xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
        daVFxhVjvjDU0xZFpf9x07jn4SrUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the current state is already PCI_D0, pci_power_up() will return
0 even though dev->pm_cap is not set. In that case, we should not
read the PCI_PM_CTRL register in pci_set_full_power_state().

Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 drivers/pci/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0..7e90ab7b47a1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1242,9 +1242,6 @@ int pci_power_up(struct pci_dev *dev)
 		else
 			dev->current_state = state;
 
-		if (state == PCI_D0)
-			return 0;
-
 		return -EIO;
 	}
 
@@ -1302,8 +1299,12 @@ static int pci_set_full_power_state(struct pci_dev *dev)
 	int ret;
 
 	ret = pci_power_up(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		if (dev->current_state == PCI_D0)
+			return 0;
+
 		return ret;
+	}
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
-- 
2.39.3

