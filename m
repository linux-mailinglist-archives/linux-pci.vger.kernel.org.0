Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B541E5C63
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 11:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbgE1JuU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 05:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387493AbgE1JuT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2020 05:50:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EA5C05BD1E;
        Thu, 28 May 2020 02:50:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p21so13227909pgm.13;
        Thu, 28 May 2020 02:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rzoHWaS62eoMInu/DTQ8KnPAEE94EQRv2IhHkekJENg=;
        b=vKy2W44WSIQj4v3PpuCsw1UmLsutUq41RYoTQ07Q5YaXNU5izlr6zW6liNYZsK3/04
         qckbar+oTXWPQz5Hyu58yluhISdc5jcG6LxNmWaT99FWO3BPIU1kF9gOAC5etDdAJqTF
         0SiSffdM057YGFh8mzFZIdaLql2B5cf/ERfDmpV9aCALEOOrHW1UFfBc9GsidlcR0mkE
         YuvR7AnCrhxaeb378zaKuw/LFDhHVKLy7iH9H/QXM7K3ZVLDs3EsLuv3Q2fxTgU0d/oV
         s2CgvmzM3VzvnOFQeUkn+JJ7GWoaxFUytSPoQLuRNcXbPx+otIfRYK8w8bmhpR/UGTX4
         YKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rzoHWaS62eoMInu/DTQ8KnPAEE94EQRv2IhHkekJENg=;
        b=jbUBU6XopNdKD+daQukRqyuT+LABBz74Bq2B07mcAPyHl/zblzdYDf/1uso81e5oit
         YcRWhVUj9HOBWonW9bjCBbHmoJCGUh50/bW/GqwqmBWgCXfxhrQtCL8wP1uP2rQ9Thzt
         mcijw40VEAJ4JpziIRf5l7Nx00ET8f7ld7xCS3wVipNDNIqn+6CwGETwotPdFcp2tfI5
         snO/QBK301GcH8t+vlrXspK0Li1YZrbsM4kwI5h9LhlQ5fS1UQc6EQrsMqAdqdEyNGt2
         siOs1yieaGowgbZGVsy0QQTRw9NVB8jea35RQvRfStV4KHZOUyJVkGXpQz2xIpFXoJ5A
         l2Sg==
X-Gm-Message-State: AOAM530lB2ZFgq35gxFlbS8LmmiHT859bO3r1Ii6ENlaEN5FHWJUxzCV
        gnkNFV8tTi3Y6f5sHbFarzk=
X-Google-Smtp-Source: ABdhPJw1nHS1/MBoCc10nXEtBTDvivOI3i+QYS/Pn1i3cc2Oyxvjjn5e1NH6s6LW2gSH2VnljQdjzQ==
X-Received: by 2002:aa7:84c6:: with SMTP id x6mr2300228pfn.46.1590659417832;
        Thu, 28 May 2020 02:50:17 -0700 (PDT)
Received: from localhost.localdomain ([101.15.161.162])
        by smtp.gmail.com with ESMTPSA id h11sm4389779pjk.20.2020.05.28.02.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 02:50:17 -0700 (PDT)
From:   Richard Hsu <saraon640529@gmail.com>
To:     Richard_Hsu@asmedia.com.tw, Yd_Tseng@asmedia.com.tw,
        Jesse1_Chang@asmedia.com.tw, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, bhelgaas@google.com
Cc:     linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
        Richard Hsu <saraon640529@gmail.com>
Subject: [PATCH] gpio:Add ASMedia 28xx and 18xx GPIO driver
Date:   Thu, 28 May 2020 17:49:55 +0800
Message-Id: <20200528094955.16483-1-saraon640529@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bartosz Golaszewski and Linux Walleij,
  I have modified code and created a new patch correctly.

Hi Bjorn Helgass,
  Thanks for your reply and suggestions.I will explain it more detail.
1.Why i select driver's framework based on AMD South Bridge(gpio-amd
8111.c)?
 Our device is similar as it and it is not the specific gpio controller
like others.We can't use plain pci_driver mechanism,as it is really
multiple function,main driver that binds to the pci_device is a bus
driver(descrbed in gpio-8111.c).This driver is almost the same with
amd8111.The different parts is the gpio register accessing methods
between io and pci configuration.

2.What's special about asm28xx that means you need PM stuff when
almost nobody else does?
  Main driver of asm28xx is a bus driver.And when no device be added
on,bridge sometimes will enter power saving state.other
sub-system or driver can access it after wake it up(ex.proc_bus_pci_
read() in drivers/pci/Proc.c).

3.We end up with multiple drivers controlling the device without
any coordination between them(ex. PM)?
  This driver just wake it up before accessing specific gpio
registers.AP(RW) also wake device up before accessing register.
That might not be a problem for this particular case.

This driver is used for particular condition and work well.And
driver framework is the same with related AMD8111.It perhaps
can keep in the same driver framework and i really hope so.

I am grateful for your assistance.

Signed-off-by: Richard Hsu <saraon640529@gmail.com>
---
 drivers/gpio/Kconfig             |   8 +
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/gpio-asm28xx-18xx.c | 278 +++++++++++++++++++++++++++++++
 3 files changed, 287 insertions(+)
 mode change 100644 => 100755 drivers/gpio/Kconfig
 mode change 100644 => 100755 drivers/gpio/Makefile
 create mode 100755 drivers/gpio/gpio-asm28xx-18xx.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
old mode 100644
index 1b96169d84f7..0676082efcb7
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -113,6 +113,14 @@ config GPIO_AMDPT
 	  driver for GPIO functionality on Promontory IOHub
 	  Require ACPI ASL code to enumerate as a platform device.
 
+config GPIO_ASM28XX
+	tristate "Asmedia 28XX/18XX GPIO support"
+	depends on PCI
+	select GPIO_GENERIC
+	help
+	  Driver for GPIO functionality on Asmedia 28XX and 18XX PCI-E Bridge.
+
+
 config GPIO_ASPEED
 	tristate "Aspeed GPIO support"
 	depends on (ARCH_ASPEED || COMPILE_TEST) && OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
old mode 100644
index b2cfc21a97f3..0cee016f9d2f
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_GPIO_AMD8111)		+= gpio-amd8111.o
 obj-$(CONFIG_GPIO_AMD_FCH)		+= gpio-amd-fch.o
 obj-$(CONFIG_GPIO_AMDPT)		+= gpio-amdpt.o
 obj-$(CONFIG_GPIO_ARIZONA)		+= gpio-arizona.o
+obj-$(CONFIG_GPIO_ASM28XX)		+= gpio-asm28xx-18xx.o
 obj-$(CONFIG_GPIO_ASPEED)		+= gpio-aspeed.o
 obj-$(CONFIG_GPIO_ASPEED_SGPIO)		+= gpio-aspeed-sgpio.o
 obj-$(CONFIG_GPIO_ATH79)		+= gpio-ath79.o
diff --git a/drivers/gpio/gpio-asm28xx-18xx.c b/drivers/gpio/gpio-asm28xx-18xx.c
index 000000000000..8c1972044c80
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
+void pci_config_pm_runtime_get(struct pci_dev *pdev)
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
+void pci_config_pm_runtime_put(struct pci_dev *pdev)
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

