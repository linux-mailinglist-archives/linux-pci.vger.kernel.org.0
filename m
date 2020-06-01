Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FAB1E9F5D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 09:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFAHgX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 03:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgFAHgX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 03:36:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038BCC061A0E;
        Mon,  1 Jun 2020 00:36:23 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w68so2257685pfb.3;
        Mon, 01 Jun 2020 00:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q3NTTsQFKZ4hMjP2eqJhNI9pBK8Rfe+kjRBcs7DOkXQ=;
        b=At7bTKSUSK+ldpbk0YAp6ixR5vIwBzlo00V23/Lne2e2bAlHq6ml03fLXRdnXrAIx/
         05j96qf3V6w8nUdpBAL8I7OtMwkNyZDjFzvF1PnvHR/v7+HRcKg7Tm6cVFVSgnPNs9b4
         M/AunGMXnkQdh2zyibqIW/MOH2ywun6kbBVR0qFrsQYhNarXq1OjkAA+lbOqvENmAu+P
         IfV1RNQZJP1dx7NZNZqLmcCcKP5ES5vc372srePfGnbbTFeiDm+K1btfIDjonx9C/qnz
         +m5YDZpvuWOSqrHkHpXsZPr3LkhwKlYDcPzvXDmYxbXNMD3xo4XCnyNftIParMuQGRWj
         1Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q3NTTsQFKZ4hMjP2eqJhNI9pBK8Rfe+kjRBcs7DOkXQ=;
        b=h/K9Z+vekM45c4YphNR8MHkFW4UQbc9KLZsfv2P6JuHNEt8o4MF/v7wPPi+wTa6SyI
         EqVpPXf6lOFYyMrz6M6teTwcDoB94Epm9+Asuyxc7Anbm7JZHAfd07CzDgeNSrhH9DvM
         adQDOgNS/87dKrc4tIRQy3FJBTTB3y+oukiQpIxEydmXsXf1vOU80LytKLOVw4L2CyR2
         Uvg4BaDDi7GCcD8TaGz7poUvtLAQk/CWTFj1rd6kD2EmecgDb1J3kS1anjb4PqVHgcph
         OcPzqezQE0NzJm3Hmj1ElwCgn93zIGwI+riFFzjMJxboZrm+FiL3nVwP7sUIEQ6GhzUk
         hg7w==
X-Gm-Message-State: AOAM5307XOgs6EGyJvqOnHcBrcTRIqo9+wK9Wl2YI1RkP/ORvz4jDwXZ
        JrqT1qBB7yqs9YcjzTBIUmg=
X-Google-Smtp-Source: ABdhPJwWqTg3zCaYfCb9oT0C5BmccJpQQPIBlIucjBdjc4EMdW9eGZB2KFH+FyVhxfACBkNgyt9WnA==
X-Received: by 2002:a63:454c:: with SMTP id u12mr18381241pgk.153.1590996982359;
        Mon, 01 Jun 2020 00:36:22 -0700 (PDT)
Received: from localhost.localdomain ([101.12.48.8])
        by smtp.gmail.com with ESMTPSA id r3sm6469603pjj.21.2020.06.01.00.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 00:36:21 -0700 (PDT)
From:   Richard Hsu <saraon640529@gmail.com>
To:     Richard_Hsu@asmedia.com.tw, Yd_Tseng@asmedia.com.tw,
        Jesse1_Chang@asmedia.com.tw, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, bhelgaas@google.com
Cc:     linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
        Richard Hsu <saraon640529@gmail.com>
Subject: [PATCH] gpio:asm28xx-18xx: new driver
Date:   Mon,  1 Jun 2020 15:36:04 +0800
Message-Id: <20200601073604.26289-1-saraon640529@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn Helgaas,
 1. What are the other functions and where is the other driver?
 >PCI bus and GPIO can be considered as two functions independently.
 And the driver is located at drivers/gpio/gpio-amd8111.c

 2.We end up with multiple drivers controlling the device without
any coordination between them?
 >Yes,because two functions are independently in the device,and
the main driver for PCI bus function is more important.We wish
they can't be affected and coordinated between two drivers
as much as possible.If main driver is affected,it is more
serious.
 In our case,we have gpio registers on pci configuration space
of asm28xx pci-e bridge(with main pci bus driver).If we want
to use it by another driver that use gpio subsystem /sys/class/
gpio/(sysfs interface).I find the driver(gpio-amd8111.c) that
meet our request.Sorry! i am not best friend with git,and
reply mail in the same way. 


Hi Bartosz Golaszewski,
 Thank you.And i have studied PCI MFD device in drivers/mfd.
Maybe,it is not what i am looking for.This type of device
include core and miscellaneous function drivers.And function
drivers export resources(io/mem/dma) to sysfs.Fist,we can't
implement another pci bus driver as core driver,and secondly,
it don't use gpio subsystem with /sys/class/gpio/(sysfs
interface).
 So,you will review this driver and upstream to mainline
kernel?

 BR,
 Richard

Signed-off-by: Richard Hsu <saraon640529@gmail.com>
---
 drivers/gpio/Kconfig             |   7 +
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/gpio-asm28xx-18xx.c | 278 +++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+)
 create mode 100644 drivers/gpio/gpio-asm28xx-18xx.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 1b96169d84f7..932f128f18c9 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -113,6 +113,13 @@ config GPIO_AMDPT
 	  driver for GPIO functionality on Promontory IOHub
 	  Require ACPI ASL code to enumerate as a platform device.
 
+config GPIO_ASM28XX
+	tristate "Asmedia 28XX/18XX GPIO support"
+	depends on PCI
+	select GPIO_GENERIC
+	help
+	  Driver for GPIO functionality on Asmedia 28XX and 18XX PCI-E Bridge.
+
 config GPIO_ASPEED
 	tristate "Aspeed GPIO support"
 	depends on (ARCH_ASPEED || COMPILE_TEST) && OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index b2cfc21a97f3..0cee016f9d2f 100644
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
new file mode 100644
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

