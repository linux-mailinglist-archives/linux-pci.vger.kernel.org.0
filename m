Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4A07864B7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 03:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjHXBiy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 21:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbjHXBid (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 21:38:33 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 493671703;
        Wed, 23 Aug 2023 18:37:57 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8DxBfFvtOZkEl4bAA--.56095S3;
        Thu, 24 Aug 2023 09:37:51 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxxsxutOZkU95hAA--.18403S2;
        Thu, 24 Aug 2023 09:37:51 +0800 (CST)
From:   Feiyang Chen <chenfeiyang@loongson.cn>
To:     bhelgaas@google.com, rafael.j.wysocki@intel.com
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>,
        mika.westerberg@linux.intel.com, helgaas@kernel.org,
        anders.roxell@linaro.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, guyinggang@loongson.cn,
        siyanteng@loongson.cn, chenhuacai@loongson.cn,
        loongson-kernel@lists.loongnix.cn, chris.chenfeiyang@gmail.com,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v3] PCI/PM: Only read PCI_PM_CTRL register when available
Date:   Thu, 24 Aug 2023 09:37:38 +0800
Message-Id: <20230824013738.1894965-1-chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxxsxutOZkU95hAA--.18403S2
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr4fZFW7JF1kuw45Zw15Jrc_yoW8GrWkpa
        95KF9xCFy8JF12qFsIqF10kFyrGa92vrWjkFWIk347Za1UGrZ8Kr43ta4jqF15ZrZ5JrWa
        qFZ0yr4UXF4Yk3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the current state is already PCI_D0, pci_power_up() will return
0 even though dev->pm_cap is not set. In that case, we should not
read the PCI_PM_CTRL register in pci_set_full_power_state().

There is nothing more needs to be done below in that case.
Additionally, pci_power_up() has two callers only and the other one
ignores the return value, so we can safely move the current state
check from pci_power_up() to pci_set_full_power_state().

Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
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

