Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A7D1EDE69
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 09:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgFDHdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 03:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgFDHdF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2020 03:33:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1C0C05BD1E;
        Thu,  4 Jun 2020 00:33:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y18so1869543plr.4;
        Thu, 04 Jun 2020 00:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G1TWi6JPyNVe7bv/I+K/eUE8jAY2IrEwwJWBp9E1Myw=;
        b=VRcVw7/kavSZf9rj9+yUaUledA3UiyitgYdZpkJuRaBPZiv/XxfruamYsKBTg2Knnt
         UctwoJTPrpGbyz10pLkfpQ7gZJDR06iuWDOGCELz8egWA2p7pv3CfC5e/uo80YgBDvv2
         +p2yQ0nJtrBg77fxX+2lS3fplBaxX2jhXuOFsXQc1haRlU//UQkUExofqZUTLEv+tYUf
         0HPpsXpyMNfp7prPgQJTrKe7AoQy+NMlVR7mxCKwXTXaI8ffpd/Beq1QtfJoZePiSTAP
         luH/EELtbU2b3Ogyu+6mNauz0PBwM2N1JT4oeLiet15070TLnfJ5MpidyCqv9jzvGXxp
         tD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G1TWi6JPyNVe7bv/I+K/eUE8jAY2IrEwwJWBp9E1Myw=;
        b=g1OmXYGBNqg7ebZU5I3quzunq4OAtlBnfAGbPJevrwgxMHk+3qwMDiys6QTK+0r6KU
         u8aUonZMkq9qSwEEpwfz5lDhcrWjjzOn1aHMVPRkDSSVMfeQF70BQneVZZQ3x04c5J0B
         zqcog6SJCfTLXw81h00On7kvwZfPjzWhEgC6Ys9p6cNqq5w5RDBS76F5/MDHASXQrcl3
         bQ0bfAyB8O/oQ09Nauwwbsl2Ftfh8FToNiIRb/AmdArolz+9EZmXN/rtd7PAPOko0MAq
         IF0OUGS0oeex/tyuNWANLF4h6C6zzy4IH/ClJL/B4AZ/4MBzHpaYuNAVDwnheZ52W/AV
         cn5g==
X-Gm-Message-State: AOAM531Uf0VbYpZdvJQQUh62kN7DOdQCyMkxtWHD5ME+dkvfJSmVpNhm
        Tb54SY2YKOA94mn8sv4yMvU=
X-Google-Smtp-Source: ABdhPJzmK48ZXy8KIsztR1dHR6JZ9+RmkxY2h7FTcbObWg9zRB8hAbN2E4ASzpUToFxtUV37ZKGx4w==
X-Received: by 2002:a17:902:868b:: with SMTP id g11mr3497107plo.225.1591255984657;
        Thu, 04 Jun 2020 00:33:04 -0700 (PDT)
Received: from localhost.localdomain ([101.12.48.8])
        by smtp.gmail.com with ESMTPSA id mp15sm5073224pjb.45.2020.06.04.00.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 00:33:03 -0700 (PDT)
From:   Richard Hsu <saraon640529@gmail.com>
To:     Richard_Hsu@asmedia.com.tw, Yd_Tseng@asmedia.com.tw,
        Jesse1_Chang@asmedia.com.tw, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, bhelgaas@google.com, lkp@intel.com
Cc:     kbuild-all@lists.01.org, linux-gpio@vger.kernel.org,
        linux-pci@vger.kernel.org, Richard Hsu <saraon640529@gmail.com>
Subject: [PATCH] gpio:asm28xx-18xx: new driver
Date:   Thu,  4 Jun 2020 15:32:43 +0800
Message-Id: <20200604073243.19280-1-saraon640529@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus Walleij,Bartosz Golaszewski and kbuild test robot,
   I have fixed the warnings(make W=1 ARCH=i386) by replace two functions
with static type,and resend the patch.
line 69:
<<void pci_config_pm_runtime_get(struct pci_dev *pdev)
>>static void pci_config_pm_runtime_get(struct pci_dev *pdev)
line 91:
<<void pci_config_pm_runtime_put(struct pci_dev *pdev)
>>static void pci_config_pm_runtime_put(struct pci_dev *pdev)

Thanks

BR,
  Richard
Signed-off-by: Richard Hsu <saraon640529@gmail.com>
---
 drivers/gpio/gpio-asm28xx-18xx.c | 278 +++++++++++++++++++++++++++++++
 1 file changed, 278 insertions(+)
 create mode 100644 drivers/gpio/gpio-asm28xx-18xx.c

diff --git a/drivers/gpio/gpio-asm28xx-18xx.c b/drivers/gpio/gpio-asm28xx-18xx.c
index 000000000000..0cf8d0df5407
--- /dev/null
+++ b/drivers/gpio/gpio-asm28xx-18xx.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Asmedia 28xx/18xx GPIO driver
+ *
+ * Copyright (C) 2020 ASMedia Technology Inc.
+ * Author: Richard Hsu <Richard_Hsu@asmedia.com.tw>
+ */
+
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/gpio/driver.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/pm_runtime.h>
+#include <linux/bits.h>
+
+
+/* GPIO registers offsets */
+#define ASM_GPIO_CTRL		0x920
+#define ASM_GPIO_OUTPUT		0x928
+#define ASM_GPIO_INPUT		0x930
+#define ASM_REG_SWITCH		0xFFF
+
+#define ASM_REG_SWITCH_CTL	0x01
+
+#define ASM_GPIO_PIN5		5
+#define ASM_GPIO_DEFAULT	0
+
+
+#define PCI_DEVICE_ID_ASM_28XX_PID1	0x2824
+#define PCI_DEVICE_ID_ASM_28XX_PID2	0x2812
+#define PCI_DEVICE_ID_ASM_28XX_PID3	0x2806
+#define PCI_DEVICE_ID_ASM_18XX_PID1	0x1824
+#define PCI_DEVICE_ID_ASM_18XX_PID2	0x1812
+#define PCI_DEVICE_ID_ASM_18XX_PID3	0x1806
+#define PCI_DEVICE_ID_ASM_81XX_PID1	0x812a
+#define PCI_DEVICE_ID_ASM_81XX_PID2	0x812b
+#define PCI_DEVICE_ID_ASM_80XX_PID1	0x8061
+
+/*
+ * Data for PCI driver interface
+ *
+ * This data only exists for exporting the supported
+ * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
+ * register a pci_driver, because someone else might one day
+ * want to register another driver on the same PCI id.
+ */
+static const struct pci_device_id pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_28XX_PID1), 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_28XX_PID2), 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_28XX_PID3), 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_18XX_PID1), 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_18XX_PID2), 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_18XX_PID3), 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_81XX_PID1), 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_81XX_PID2), 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_80XX_PID1), 0 },
+	{ 0, },	/* terminate list */
+};
+MODULE_DEVICE_TABLE(pci, pci_tbl);
+
+struct asm28xx_gpio {
+	struct gpio_chip	chip;
+	struct pci_dev		*pdev;
+	spinlock_t		lock;
+};
+
+static void pci_config_pm_runtime_get(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device *parent = dev->parent;
+
+	if (parent)
+		pm_runtime_get_sync(parent);
+	pm_runtime_get_noresume(dev);
+	/*
+	 * pdev->current_state is set to PCI_D3cold during suspending,
+	 * so wait until suspending completes
+	 */
+	pm_runtime_barrier(dev);
+	/*
+	 * Only need to resume devices in D3cold, because config
+	 * registers are still accessible for devices suspended but
+	 * not in D3cold.
+	 */
+	if (pdev->current_state == PCI_D3cold)
+		pm_runtime_resume(dev);
+}
+
+static void pci_config_pm_runtime_put(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device *parent = dev->parent;
+
+	pm_runtime_put(dev);
+	if (parent)
+		pm_runtime_put_sync(parent);
+}
+
+static int asm28xx_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	if (offset == ASM_GPIO_PIN5)
+		return -ENODEV;
+
+	return 0;
+}
+
+static void asm28xx_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct asm28xx_gpio *agp = gpiochip_get_data(chip);
+	u8 temp;
+	unsigned long flags;
+
+	pci_config_pm_runtime_get(agp->pdev);
+	spin_lock_irqsave(&agp->lock, flags);
+	pci_read_config_byte(agp->pdev, ASM_GPIO_OUTPUT, &temp);
+	if (value)
+		temp |= BIT(offset);
+	else
+		temp &= ~BIT(offset);
+
+	pci_write_config_byte(agp->pdev, ASM_GPIO_OUTPUT, temp);
+	spin_unlock_irqrestore(&agp->lock, flags);
+	pci_config_pm_runtime_put(agp->pdev);
+	dev_dbg(chip->parent, "ASMEDIA-28xx/18xx gpio %d set %d reg=%02x\n", offset, value, temp);
+}
+
+static int asm28xx_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct asm28xx_gpio *agp = gpiochip_get_data(chip);
+	u8 temp;
+	unsigned long flags;
+
+	pci_config_pm_runtime_get(agp->pdev);
+	spin_lock_irqsave(&agp->lock, flags);
+	pci_read_config_byte(agp->pdev, ASM_GPIO_INPUT, &temp);
+	spin_unlock_irqrestore(&agp->lock, flags);
+	pci_config_pm_runtime_put(agp->pdev);
+
+	dev_dbg(chip->parent, "ASMEDIA-28xx/18xx GPIO Pin %d get reg=%02x\n", offset, temp);
+	return (temp & BIT(offset)) ? 1 : 0;
+}
+
+static int asm28xx_gpio_dirout(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct asm28xx_gpio *agp = gpiochip_get_data(chip);
+	u8 temp;
+	unsigned long flags;
+
+	pci_config_pm_runtime_get(agp->pdev);
+	spin_lock_irqsave(&agp->lock, flags);
+	pci_read_config_byte(agp->pdev, ASM_GPIO_CTRL, &temp);
+	temp |= BIT(offset);
+	pci_write_config_byte(agp->pdev, ASM_GPIO_CTRL, temp);
+	spin_unlock_irqrestore(&agp->lock, flags);
+	pci_config_pm_runtime_put(agp->pdev);
+	dev_dbg(chip->parent, "ASMEDIA-28xx/18xx dirout gpio %d  reg=%02x\n", offset, temp);
+
+	return 0;
+}
+
+static int asm28xx_gpio_dirin(struct gpio_chip *chip, unsigned offset)
+{
+	struct asm28xx_gpio *agp = gpiochip_get_data(chip);
+	u8 temp;
+	unsigned long flags;
+
+	pci_config_pm_runtime_get(agp->pdev);
+	spin_lock_irqsave(&agp->lock, flags);
+	pci_read_config_byte(agp->pdev, ASM_GPIO_CTRL, &temp);
+	temp &= ~BIT(offset);
+	pci_write_config_byte(agp->pdev, ASM_GPIO_CTRL, temp);
+	spin_unlock_irqrestore(&agp->lock, flags);
+	pci_config_pm_runtime_put(agp->pdev);
+	dev_dbg(chip->parent, "ASMEDIA-28xx/18xx dirin gpio %d  reg=%02x\n", offset, temp);
+
+	return 0;
+}
+
+static struct asm28xx_gpio gp = {
+	.chip = {
+		.label		= "ASM28XX-18XX GPIO",
+		.owner		= THIS_MODULE,
+		.ngpio		= 8,
+		.request	= asm28xx_gpio_request,
+		.set		= asm28xx_gpio_set,
+		.get		= asm28xx_gpio_get,
+		.direction_output = asm28xx_gpio_dirout,
+		.direction_input = asm28xx_gpio_dirin,
+	},
+};
+
+static int __init asm28xx_gpio_init(void)
+{
+	int err = -ENODEV;
+	struct pci_dev *pdev = NULL;
+	const struct pci_device_id *ent;
+	u8 temp;
+	unsigned long flags;
+	int type;
+
+	/* We look for our device - Asmedia 28XX and 18XX Bridge
+	 * I don't know about a system with two such bridges,
+	 * so we can assume that there is max. one device.
+	 *
+	 * We can't use plain pci_driver mechanism,
+	 * as the device is really a multiple function device,
+	 * main driver that binds to the pci_device is an bus
+	 * driver and have to find & bind to the device this way.
+	 */
+
+	for_each_pci_dev(pdev) {
+		ent = pci_match_id(pci_tbl, pdev);
+		if (ent) {
+			/* Because GPIO Registers only work on Upstream port. */
+			type = pci_pcie_type(pdev);
+			if (type == PCI_EXP_TYPE_UPSTREAM) {
+				dev_info(&pdev->dev, "ASMEDIA-28xx/18xx Init Upstream detected\n");
+				goto found;
+			}
+		}
+	}
+	goto out;
+
+found:
+	gp.pdev = pdev;
+	gp.chip.parent = &pdev->dev;
+
+	spin_lock_init(&gp.lock);
+
+	err = gpiochip_add_data(&gp.chip, &gp);
+	if (err) {
+		dev_err(&pdev->dev, "GPIO registering failed (%d)\n", err);
+		goto out;
+	}
+
+	pci_config_pm_runtime_get(pdev);
+
+	/* Set PCI_CFG_Switch bit = 1,then we can access GPIO Registers. */
+	spin_lock_irqsave(&gp.lock, flags);
+	pci_read_config_byte(pdev, ASM_REG_SWITCH, &temp);
+	temp |= ASM_REG_SWITCH_CTL;
+	pci_write_config_byte(pdev, ASM_REG_SWITCH, temp);
+	pci_read_config_byte(pdev, ASM_REG_SWITCH, &temp);
+	spin_unlock_irqrestore(&gp.lock, flags);
+
+	pci_config_pm_runtime_put(pdev);
+	dev_err(&pdev->dev, "ASMEDIA-28xx/18xx Init SWITCH = 0x%x\n", temp);
+out:
+	return err;
+}
+
+static void __exit asm28xx_gpio_exit(void)
+{
+	unsigned long flags;
+
+	pci_config_pm_runtime_get(gp.pdev);
+
+	spin_lock_irqsave(&gp.lock, flags);
+	/* Set GPIO Registers to default value. */
+	pci_write_config_byte(gp.pdev, ASM_GPIO_OUTPUT, ASM_GPIO_DEFAULT);
+	pci_write_config_byte(gp.pdev, ASM_GPIO_INPUT, ASM_GPIO_DEFAULT);
+	pci_write_config_byte(gp.pdev, ASM_GPIO_CTRL, ASM_GPIO_DEFAULT);
+	/* Clear PCI_CFG_Switch bit = 0,then we can't access GPIO Registers. */
+	pci_write_config_byte(gp.pdev, ASM_REG_SWITCH, ASM_GPIO_DEFAULT);
+	spin_unlock_irqrestore(&gp.lock, flags);
+	pci_config_pm_runtime_put(gp.pdev);
+
+	gpiochip_remove(&gp.chip);
+}
+
+module_init(asm28xx_gpio_init);
+module_exit(asm28xx_gpio_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Richard Hsu <Richard_Hsu@asmedia.com.tw>");
+MODULE_DESCRIPTION("ASMedia 28xx 18xx GPIO Driver");
-- 
2.17.1

