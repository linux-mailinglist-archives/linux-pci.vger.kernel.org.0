Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9637978C4E1
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjH2NHI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 09:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbjH2NGn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 09:06:43 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E0B61B7;
        Tue, 29 Aug 2023 06:06:37 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8Ax1fBb7e1kGcQcAA--.58704S3;
        Tue, 29 Aug 2023 21:06:35 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_yNW7e1kXntmAA--.10656S2;
        Tue, 29 Aug 2023 21:06:31 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     bhelgaas@google.com, rafael.j.wysocki@intel.com
Cc:     mika.westerberg@linux.intel.com, helgaas@kernel.org,
        anders.roxell@linaro.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, guyinggang@loongson.cn,
        siyanteng@loongson.cn, chenhuacai@loongson.cn,
        loongson-kernel@lists.loongnix.cn, chris.chenfeiyang@gmail.com,
        rafael@kernel.org, Feiyang Chen <chenfeiyang@loongson.cn>
Subject: [PATCH v4] PCI/PM: Only read PCI_PM_CTRL register when available
Date:   Tue, 29 Aug 2023 21:06:26 +0800
Message-Id: <20230829130626.1978944-1-siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_yNW7e1kXntmAA--.10656S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF13Wr43urW3Wr4UCrW7GFX_yoW5GFWkp3
        95GF9rGF18JF18t3ZIqFsrZFn8ua92yrZ3ZFyI9w17u3W7W395tr1ftFyYqF1rZrZrXFy3
        Xa9Fyr18Wa15GacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Feiyang Chen <chenfeiyang@loongson.cn>

    For a device with no Power Management Capability, pci_power_up() previously
    returned 0 (success) if the platform was able to put the device in D0,
    which led to pci_set_full_power_state() trying to read PCI_PM_CTRL, even
    though it doesn't exist.

    Since dev->pm_cap == 0 in this case, pci_set_full_power_state() actually
    read the wrong register, interpreted it as PCI_PM_CTRL, and corrupted
    dev->current_state.  This led to messages like this in some cases:

    pci 0000:01:00.0: Refused to change power state from D3hot to D0

    To prevent this, make pci_power_up() always return a negative failure code
    if the device lacks a Power Management Capability, even if non-PCI platform
    power management has been able to put the device in D0.  The failure will
    prevent pci_set_full_power_state() from trying to access PCI_PM_CTRL.

    Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
    Link: https://lore.kernel.org/r/20230824013738.1894965-1-chenfeiyang@loongson.cn
    Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
    Reviewed-by: "Rafael J. Wysocki" <rafael@kernel.org>
    Cc: stable@vger.kernel.org	# v5.19+
---
v4:
Modify commit messages.

BTW, Feiyang went on vacation, I will continue this patch.

 drivers/pci/pci.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f59f3c1c9869..59c01d68c6d5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1226,6 +1226,10 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
  *
  * On success, return 0 or 1, depending on whether or not it is necessary to
  * restore the device's BARs subsequently (1 is returned in that case).
+ *
+ * On failure, return a negative error code.  Always return failure if @dev
+ * lacks a Power Management Capability, even if the platform was able to
+ * put the device in D0 via non-PCI means.
  */
 int pci_power_up(struct pci_dev *dev)
 {
@@ -1242,9 +1246,6 @@ int pci_power_up(struct pci_dev *dev)
 		else
 			dev->current_state = state;
 
-		if (state == PCI_D0)
-			return 0;
-
 		return -EIO;
 	}
 
@@ -1302,8 +1303,12 @@ static int pci_set_full_power_state(struct pci_dev *dev)
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
2.31.4

