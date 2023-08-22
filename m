Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822FA783D25
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjHVJlq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjHVJlp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 05:41:45 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2DEA1B2;
        Tue, 22 Aug 2023 02:41:43 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8DxfevVguRkbuAaAA--.52666S3;
        Tue, 22 Aug 2023 17:41:41 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax3c7TguRkuzVgAA--.38685S2;
        Tue, 22 Aug 2023 17:41:40 +0800 (CST)
From:   Feiyang Chen <chenfeiyang@loongson.cn>
To:     bhelgaas@google.com, rafael.j.wysocki@intel.com
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>,
        mika.westerberg@linux.intel.com, helgaas@kernel.org,
        anders.roxell@linaro.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, guyinggang@loongson.cn,
        siyanteng@loongson.cn, chenhuacai@loongson.cn,
        loongson-kernel@lists.loongnix.cn, chris.chenfeiyang@gmail.com
Subject: [PATCH] PCI/PM: Only read PCI_PM_CTRL register when available
Date:   Tue, 22 Aug 2023 17:41:36 +0800
Message-Id: <20230822094136.621740-1-chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3c7TguRkuzVgAA--.38685S2
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtr4UKFy3KF4Dtr4fAr13Awc_yoWDZrbE9a
        yxZa1xAF4UCFykCasIyw48Xry093ZxZ397WF4xtFW3uF1rXa4kJrWUZr1qyF9xuF45Wrn8
        ZasrGw15ur92kosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbvxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Gryq6s0DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
        vY0x0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
        jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07b3iihUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the pm_cap of the PCI device is unset, do not read the
PCI_PM_CTRL register in pci_set_full_power_state().

Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 drivers/pci/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0..d6671cefcfa7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1305,8 +1305,10 @@ static int pci_set_full_power_state(struct pci_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
+	if (dev->pm_cap) {
+		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+		dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
+	}
 	if (dev->current_state != PCI_D0) {
 		pci_info_ratelimited(dev, "Refused to change power state from %s to D0\n",
 				     pci_power_name(dev->current_state));
-- 
2.39.3

