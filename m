Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE95282C24
	for <lists+linux-pci@lfdr.de>; Sun,  4 Oct 2020 20:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgJDSAe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Oct 2020 14:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgJDSAb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Oct 2020 14:00:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF60C0613D0;
        Sun,  4 Oct 2020 11:00:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lw21so4679274ejb.6;
        Sun, 04 Oct 2020 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCJ2Al+Kxhyem7n13XC8d7BNcmUOhG5PSSfPR0UXFnU=;
        b=hJmwYd2BuvdGWGh1TM2bxoZEmTCGsjYD4wis1vCnvmI38Z67z9juig/cHyZSIsPzqf
         9zZoH8OO9L0SjXNa7q0X7kL4CV/NdN8EbwKLdZLIeUol+gg8ij0k7qDAk7OV7N3zB6HW
         ccePv1DfO4vA+RXRbyO6VCDwRn1cXbvWfoYkizaVpGkPnks7JtPIv/a5kDNTBrK+6wAQ
         1s/PYD1hh1BZ2MEoMp+YvpKeWKUSZB7kz5FaZ4UdIqb8HLdI1gk01NhlMvEdlKh8Tswv
         VhBIahx2EjFaFDKjRQ2uNgpACwd1neGstVhpGttVJi4vvgeBrLGyMHcXzkWNkIjrZ+xI
         5R+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCJ2Al+Kxhyem7n13XC8d7BNcmUOhG5PSSfPR0UXFnU=;
        b=DxDdoYANIHqlH5t1nvrp9xc9VeYfzA9rmt0ghptZOqBFKR5+kbTHlBEnH9iLE/YGvK
         0m5ScPDVaoPZjckMUXgaKtwnKPOMYa5k83nWlpwdyxqljBT0WrC4MAqLNyel77/tR/Cu
         1R5Arp8aflOXbD1xb21viplijiPJY2lrcghfQLEmVdG8Mo8Empx+vNIFf309AyrqHrFG
         SwkS1wxGjgZhOjkQqUG1CDwmljSa93p3BN0M2JO7NgkVNQg7bf4+De6IrXI+wsD8QFV6
         2X2IivWAyomWE2PM6YmYwni8n6sTviVYhNxyKzxCdbQK8OihqoRkKVUidoT2H2IwAqyz
         8HRA==
X-Gm-Message-State: AOAM531NIvGfP7R4AJLtctV8GjXdbxRpew33TfpwedxYJNiq6FraqiVw
        i8s4jL1jxBZ5upSOPXbfhIv6wx3jGwc=
X-Google-Smtp-Source: ABdhPJxo9InvtizPDR2EVD3KhOhPBtBohX7voenXF/jD/qJs+Az8fFpxm0LYRmE2fbHXJLERThcs8g==
X-Received: by 2002:a17:907:338c:: with SMTP id zj12mr11539447ejb.224.1601834429967;
        Sun, 04 Oct 2020 11:00:29 -0700 (PDT)
Received: from localhost.localdomain (p4fc3e21a.dip0.t-ipconnect.de. [79.195.226.26])
        by smtp.googlemail.com with ESMTPSA id n11sm6065906ejs.38.2020.10.04.11.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 11:00:29 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, robh+dt@kernel.org,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH 3/3] gpio: ej1x8: Add GPIO driver for Etron Tech Inc. EJ168/EJ188/EJ198
Date:   Sun,  4 Oct 2020 18:29:08 +0200
Message-Id: <20201004162908.3216898-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

EJ168/EJ188/EJ198 are USB xHCI controllers. They also contain four GPIO
lines which are used on some systems to toggle an LED based on whether a
USB device is connected.

There is no public datasheet available for this hardware. All
information in this driver is taken from the
"F9K1115v2.03.97-GPL-10.2.85-20140313" GPL code dump of the Belkin
F9K1115v2. This board comes with an EJ168 USB xHCI controller and the
USB 3.0 LED is connected to one of the GPIOs. Inside the GPL source
archive the related code can be found in:
  linux/kernels/mips-linux-2.6.31/drivers/usb/host/etxhci-pci.c

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpio/Kconfig      |   9 ++
 drivers/gpio/Makefile     |   1 +
 drivers/gpio/gpio-ej1x8.c | 311 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 drivers/gpio/gpio-ej1x8.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 8030fd91a3cc..88820b04ffa5 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -215,6 +215,15 @@ config GPIO_EIC_SPRD
 	help
 	  Say yes here to support Spreadtrum EIC device.
 
+config GPIO_EJ1X8
+	tristate "Etron Tech Inc. EJ168/EJ188/EJ198 GPIO driver"
+	depends on OF_GPIO && PCI
+	help
+	  Selecting this option will enable the GPIO pins present on
+	  the Etron Tech Inc. EJ168/EJ188/EJ198 USB xHCI controllers.
+
+	  If unsure, say N.
+
 config GPIO_EM
 	tristate "Emma Mobile GPIO"
 	depends on (ARCH_EMEV2 || COMPILE_TEST) && OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4f9abff4f2dc..6d5e345b1f2d 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_GPIO_DAVINCI)		+= gpio-davinci.o
 obj-$(CONFIG_GPIO_DLN2)			+= gpio-dln2.o
 obj-$(CONFIG_GPIO_DWAPB)		+= gpio-dwapb.o
 obj-$(CONFIG_GPIO_EIC_SPRD)		+= gpio-eic-sprd.o
+obj-$(CONFIG_GPIO_EJ1X8)		+= gpio-ej1x8.o
 obj-$(CONFIG_GPIO_EM)			+= gpio-em.o
 obj-$(CONFIG_GPIO_EP93XX)		+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_EXAR)			+= gpio-exar.o
diff --git a/drivers/gpio/gpio-ej1x8.c b/drivers/gpio/gpio-ej1x8.c
new file mode 100644
index 000000000000..c673e62c34f8
--- /dev/null
+++ b/drivers/gpio/gpio-ej1x8.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2020 Martin Blumenstingl <martin.blumenstingl@googlemail.com> */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/property.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#define EJ1X8_GPIO_INIT					0x44
+#define EJ1X8_GPIO_WRITE				0x68
+#define EJ1X8_GPIO_READ					0x6c
+
+#define EJ1X8_GPIO_CTRL					0x18005020
+#define EJ1X8_GPIO_CTRL_READ_ALL_MASK			GENMASK(7, 0)
+#define EJ1X8_GPIO_CTRL_WRITE_ALL_MASK			GENMASK(23, 16)
+#define EJ1X8_GPIO_CTRL_OUT_LOW				0x0
+#define EJ1X8_GPIO_CTRL_OUT_HIGH			0x1
+#define EJ1X8_GPIO_CTRL_IN				0x2
+#define EJ1X8_GPIO_CTRL_MASK				0x3
+
+#define EJ1X8_GPIO_MODE					0x18005022
+#define EJ1X8_GPIO_MODE_READ_WRITE_ALL_MASK		GENMASK(23, 16)
+#define EJ1X8_GPIO_MODE_DISABLE				0x0
+#define EJ1X8_GPIO_MODE_ENABLE				0x1
+#define EJ1X8_GPIO_MODE_MASK				0x3
+
+static LIST_HEAD(ej1x8_gpios);
+
+struct ej1x8_gpio {
+	spinlock_t			lock;
+	struct pci_dev			*pci_dev;
+	struct gpio_chip		chip;
+	struct list_head		list_head;
+};
+
+static u8 ej1x8_gpio_shift(unsigned int gpio, u8 mask)
+{
+	return (gpio * fls(mask));
+}
+
+static u8 ej1x8_gpio_mask(unsigned int gpio, u8 mask)
+{
+	return mask << ej1x8_gpio_shift(gpio, mask);
+}
+
+static int ej1x8_gpio_read(struct gpio_chip *gc, u32 reg, u32 *value)
+{
+	struct ej1x8_gpio *ej1x8 = gpiochip_get_data(gc);
+	int err;
+
+	err = pci_write_config_dword(ej1x8->pci_dev, EJ1X8_GPIO_WRITE, reg);
+	if (err) {
+		dev_err(gc->parent, "Failed to select 0x%08x register\n", reg);
+		return err;
+	}
+
+	usleep_range(1000, 10000);
+
+	err = pci_read_config_dword(ej1x8->pci_dev, EJ1X8_GPIO_READ, value);
+	if (err) {
+		dev_err(gc->parent, "Failed to read 0x%08x register\n", reg);
+		return err;
+	}
+
+	return 0;
+}
+
+static int ej1x8_gpio_write(struct gpio_chip *gc, u32 reg, u32 value)
+{
+	struct ej1x8_gpio *ej1x8 = gpiochip_get_data(gc);
+	int err;
+
+	err = pci_write_config_dword(ej1x8->pci_dev, EJ1X8_GPIO_WRITE,
+				     reg | value | BIT(24));
+	if (err) {
+		dev_err(gc->parent, "Failed to write 0x%08x register\n", reg);
+		return err;
+	}
+
+	usleep_range(1000, 10000);
+
+	return 0;
+}
+
+static int ej1x8_gpio_config(struct gpio_chip *gc, unsigned int gpio, u8 mode,
+			     u8 ctrl)
+{
+	struct ej1x8_gpio *ej1x8 = gpiochip_get_data(gc);
+	u8 all_gpio_ctrl, all_gpio_mode;
+	u32 temp;
+	int err;
+
+	spin_lock(&ej1x8->lock);
+
+	err = pci_read_config_dword(ej1x8->pci_dev, EJ1X8_GPIO_INIT, &temp);
+	if (err) {
+		dev_err(gc->parent, "Failed to read INIT register\n");
+		return err;
+	}
+
+	err = pci_write_config_dword(ej1x8->pci_dev, EJ1X8_GPIO_INIT,
+				     temp | 0x1);
+	if (err) {
+		dev_err(gc->parent, "Failed to write INIT register\n");
+		return err;
+	}
+
+	err = ej1x8_gpio_read(gc, EJ1X8_GPIO_CTRL, &temp);
+	if (err)
+		goto err_unlock;
+
+	all_gpio_ctrl = FIELD_GET(EJ1X8_GPIO_CTRL_READ_ALL_MASK, temp);
+	all_gpio_ctrl &= ~ej1x8_gpio_mask(gpio, EJ1X8_GPIO_CTRL_MASK);
+	all_gpio_ctrl |= ctrl << ej1x8_gpio_shift(gpio, EJ1X8_GPIO_CTRL_MASK);
+
+	err = ej1x8_gpio_read(gc, EJ1X8_GPIO_MODE, &temp);
+	if (err)
+		goto err_unlock;
+
+	all_gpio_mode = FIELD_GET(EJ1X8_GPIO_MODE_READ_WRITE_ALL_MASK, temp);
+	all_gpio_mode &= ~ej1x8_gpio_mask(gpio, EJ1X8_GPIO_MODE_MASK);
+	all_gpio_mode |= mode << ej1x8_gpio_shift(gpio, EJ1X8_GPIO_MODE_MASK);
+
+	err = ej1x8_gpio_write(gc, EJ1X8_GPIO_CTRL,
+			       FIELD_PREP(EJ1X8_GPIO_CTRL_WRITE_ALL_MASK,
+					  all_gpio_ctrl));
+	if (err)
+		goto err_unlock;
+
+	err = ej1x8_gpio_write(gc, EJ1X8_GPIO_MODE,
+			       FIELD_PREP(EJ1X8_GPIO_MODE_READ_WRITE_ALL_MASK,
+					  all_gpio_mode));
+	if (err)
+		goto err_unlock;
+
+	spin_unlock(&ej1x8->lock);
+
+	return 0;
+
+err_unlock:
+	spin_unlock(&ej1x8->lock);
+	return err;
+}
+
+static int ej1x8_gpio_get_mode(struct gpio_chip *gc, unsigned int gpio, u8 *mode)
+{
+	struct ej1x8_gpio *ej1x8 = gpiochip_get_data(gc);
+	u32 temp, all_gpio_mode;
+	int err;
+
+	spin_lock(&ej1x8->lock);
+	err = ej1x8_gpio_read(gc, EJ1X8_GPIO_MODE, &temp);
+	spin_unlock(&ej1x8->lock);
+
+	if (err)
+		return err;
+
+	all_gpio_mode = FIELD_GET(EJ1X8_GPIO_MODE_READ_WRITE_ALL_MASK, temp);
+	*mode = all_gpio_mode >> ej1x8_gpio_shift(gpio, EJ1X8_GPIO_MODE_MASK);
+	*mode &= EJ1X8_GPIO_MODE_MASK;
+
+	return 0;
+}
+
+static void ej1x8_gpio_free(struct gpio_chip *gc, unsigned int gpio)
+{
+	ej1x8_gpio_config(gc, gpio, EJ1X8_GPIO_MODE_DISABLE, EJ1X8_GPIO_CTRL_IN);
+}
+
+static int ej1x8_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
+{
+	u8 mode;
+	int err;
+
+	err = ej1x8_gpio_get_mode(gc, gpio, &mode);
+	if (err)
+		return err;
+
+	switch (mode) {
+	case EJ1X8_GPIO_CTRL_IN:
+		return GPIO_LINE_DIRECTION_IN;
+
+	case EJ1X8_GPIO_CTRL_OUT_HIGH:
+	case EJ1X8_GPIO_CTRL_OUT_LOW:
+		return GPIO_LINE_DIRECTION_OUT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ej1x8_gpio_direction_output(struct gpio_chip *gc, unsigned int gpio,
+				       int value)
+{
+	u8 gpio_ctrl;
+
+	if (value)
+		gpio_ctrl = EJ1X8_GPIO_CTRL_OUT_HIGH;
+	else
+		gpio_ctrl = EJ1X8_GPIO_CTRL_OUT_LOW;
+
+	return ej1x8_gpio_config(gc, gpio, EJ1X8_GPIO_MODE_ENABLE, gpio_ctrl);
+}
+
+static int ej1x8_gpio_get_value(struct gpio_chip *gc, unsigned int gpio)
+{
+	u8 mode;
+	int err;
+
+	err = ej1x8_gpio_get_mode(gc, gpio, &mode);
+	if (err)
+		return err;
+
+	switch (mode) {
+	case EJ1X8_GPIO_CTRL_OUT_HIGH:
+		return 1;
+
+	case EJ1X8_GPIO_CTRL_OUT_LOW:
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static void ej1x8_gpio_set_value(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	ej1x8_gpio_direction_output(gc, gpio, value);
+}
+
+static const struct pci_device_id ej1x8_gpio_pci_ids[] __initconst = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_ETRON, PCI_DEVICE_ID_ETRON_EJ168) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ETRON, PCI_DEVICE_ID_ETRON_EJ188) },
+	{ /* sentinel */ }
+};
+
+static int __init ej1x8_gpio_init(void)
+{
+	struct pci_dev *pci_dev = NULL;
+	struct ej1x8_gpio *ej1x8;
+	int err;
+
+	for_each_pci_dev(pci_dev) {
+		if (!pci_match_id(ej1x8_gpio_pci_ids, pci_dev))
+			continue;
+
+		if (!device_property_read_bool(&pci_dev->dev, "gpio-controller"))
+			continue;
+
+		ej1x8 = kzalloc(sizeof(*ej1x8), GFP_KERNEL);
+		if (!ej1x8)
+			continue;
+
+		spin_lock_init(&ej1x8->lock);
+		ej1x8->pci_dev = pci_dev_get(pci_dev);
+
+		/* TODO: input mode is supported by the hardware but not the driver */
+		ej1x8->chip.label = dev_name(&pci_dev->dev);
+		ej1x8->chip.owner = THIS_MODULE;
+		ej1x8->chip.parent = &pci_dev->dev;
+		ej1x8->chip.of_node = pci_dev->dev.of_node;
+		ej1x8->chip.free = ej1x8_gpio_free;
+		ej1x8->chip.get_direction = ej1x8_gpio_get_direction;
+		ej1x8->chip.direction_output = ej1x8_gpio_direction_output;
+		ej1x8->chip.get = ej1x8_gpio_get_value;
+		ej1x8->chip.set = ej1x8_gpio_set_value;
+		ej1x8->chip.base = -1;
+		ej1x8->chip.ngpio = 4;
+
+		err = gpiochip_add_data(&ej1x8->chip, ej1x8);
+		if (err) {
+			dev_warn(&pci_dev->dev,
+				 "Failed to register GPIO device: %d\n", err);
+			pci_dev_put(ej1x8->pci_dev);
+			kfree(ej1x8);
+			continue;
+		}
+
+		list_add(&ej1x8->list_head, &ej1x8_gpios);
+	}
+
+	return 0;
+}
+
+static void __exit ej1x8_gpio_exit(void)
+{
+	struct ej1x8_gpio *ej1x8, *tmp;
+
+	list_for_each_entry_safe(ej1x8, tmp, &ej1x8_gpios, list_head) {
+		gpiochip_remove(&ej1x8->chip);
+		pci_dev_put(ej1x8->pci_dev);
+		list_del(&ej1x8->list_head);
+		kfree(ej1x8);
+	}
+}
+
+module_init(ej1x8_gpio_init);
+module_exit(ej1x8_gpio_exit);
+
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
+MODULE_DESCRIPTION("Etron Technology Inc. EJ168/EJ188/EJ198 GPIO driver");
+MODULE_LICENSE("GPL v2");
-- 
2.28.0

