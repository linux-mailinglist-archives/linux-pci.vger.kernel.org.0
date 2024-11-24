Return-Path: <linux-pci+bounces-17255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDC79D6DDF
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 11:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C68B21ABC
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 10:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4190A19006F;
	Sun, 24 Nov 2024 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bZBbf3Vd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53818DF89
	for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732445493; cv=none; b=IKH/rS3RYvnrNq1Qs6lr1hLuRoF78gLvnblmsw08MpV/zJOXD6wtlRzSuBC3tPFXd4XrMJCfgtiOAAHq+1/FqLXfVG+88b50swQxuJf7GMQJh2xKssDJkuIRVPVROYoIGDibUHPS/4Rp9VsgoqJQ6QARX9UdThwN4KT7HTHj3Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732445493; c=relaxed/simple;
	bh=SNaDfWT7qaJHzHNIuTsJHuQ6OzVZ4pdQvOucGfm+7wc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiKOPmSDGAIb1QG5MTm4aaZtHsVN3iChudPuDZ0WdPKoBfO5Q9fyqCGDakkyFJL6mUFYgMSCEE94cTsjqw/yGzj9SVii/ozLvivIo9E3p+0g63mCIwKLokkv2e27/YeZdtFDUBADD60BbHs3W9Og0jT6QJ51aAc9eVXDX5Jrqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bZBbf3Vd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso263178066b.2
        for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2024 02:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732445487; x=1733050287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HUgGSQNS5gzMBRUpxkk9k2e4e9c2w3Oi5V7Xpz1BCQ=;
        b=bZBbf3Vdne4bh2hp9xHXvhWlPDkaufTd2s1wH4wJikIlphrh2W+YR0k8SiokCWSFLA
         kMluGbQ8KKueg+ywDJyY++jXr7/TRGJEsUaRgdH7s/ZNHnqM+9IxcLDw9j9TPnggtU/L
         LtSu6NFXvOPk6Kx9Ru7yvP/h+tQ8/6WEinmaFVPQ6jX4Y3G6P+9omEe840fUNS/UWhJk
         1HV/+w7gtZLqLifQhTBz/4Ou4LUSSWJRzwq8QVXdy0iLuVUlMXuwRB4vA6XRiimA8IRw
         JStt16A5LAl1kre0Gk+l1+hkyUtAZ9jvVV/4/hT+rG+fxno3n1MZh/vyGh069mMF619E
         4mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732445487; x=1733050287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HUgGSQNS5gzMBRUpxkk9k2e4e9c2w3Oi5V7Xpz1BCQ=;
        b=S/X46sXWWFSInZvijmwwousyLIRURTCTx/Sjdrc7L3l/Lv/rArx/PHO29jpSkCYG1g
         tmrTS//zwFt6tyA6gXLDTs2MTpEeytSp7X/zVQT0IHyHo5CxNJRqJN4uWKg6nWYMbDVs
         272cTIiPsyqEaf6yuGxRNaCq7vYxDFc2AsX14ev+RlL+vMsyN6Kqr64FYVOhzXBUtpxA
         OXPfh+qGU76s1yFOevu70lhrw7uOIBQiLSCdMnC2HIxCPE8SaS0RrPE3MXddeXPOb6aN
         HDo3dlTGNo/LKAMi+n9A5rSB6y6Jdc9SfDnZwjAws3ePuU04pYyjVn0P5e5PifA2biAu
         Ahww==
X-Forwarded-Encrypted: i=1; AJvYcCWnEqxI6nvdvpxC6mTLdg12HN0jhWcf7cxQ48os+0Yvfnnhc4jxwh68qHQyirw2ULwpZiciF1+1jxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvOf8YVnWlDcBsOAssgjWI13aHRC3VaLtMK1xx/m5WqV6OjiX
	tdun/5Q9wg9aPT5evSUnHY3becbkHhuzag/Lhg+ciVBrgEbkhU7/J/CmyR1NAdo=
X-Gm-Gg: ASbGncs/eXDEHAvfxP2JusWq3+WIA0iX+bDWCQvuRzRiioge5HB2CI1F1hew4pcWBZB
	lHhnm9DtcMxo0OGtJgI5eJ73Mq0pJZjf6jt6k4IQvwlHUZhPjL9P5kCXEyItZErFUGA4GShsalO
	X9cd7+Wj1IPvXYNwJ9PyYf61CRc7t4xWa7u8ttkekTCC6VCsquzgzDlssK/g71a8RKCJaBNjnHf
	GkkBSOwwtcuQC9FAz43si3EnHoK3gbM1ewpo7XOIty7FV915whSimWaCnxu7xEn+N7N2hUAhPRv
	/RwdhEWUNe/47VUubY3s
X-Google-Smtp-Source: AGHT+IG1SyCOmbxw6jQ5LMpZ5paA969htsI2AYdqOys5SRT4lhTtwWTQWbveVf53OXNISG7SeowqGQ==
X-Received: by 2002:a17:906:23ea:b0:aa5:4672:663b with SMTP id a640c23a62f3a-aa546726729mr139091466b.55.1732445487173;
        Sun, 24 Nov 2024 02:51:27 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b89f6sm329670266b.198.2024.11.24.02.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 02:51:26 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4 06/10] pinctrl: rp1: Implement RaspberryPi RP1 gpio support
Date: Sun, 24 Nov 2024 11:51:43 +0100
Message-ID: <1257f76168ae03dba027bd33e6fca31b8df29c35.1732444746.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1732444746.git.andrea.porta@suse.com>
References: <cover.1732444746.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RP1 is an MFD supporting a gpio controller and /pinmux/pinctrl.
Add minimum support for the gpio only portion. The driver is in
pinctrl folder since upcoming patches will add the pinmux/pinctrl
support where the gpio part can be seen as an addition.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS                   |   1 +
 drivers/pinctrl/Kconfig       |  11 +
 drivers/pinctrl/Makefile      |   1 +
 drivers/pinctrl/pinctrl-rp1.c | 789 ++++++++++++++++++++++++++++++++++
 4 files changed, 802 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-rp1.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dc064cd4b6b5..06277969a522 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19388,6 +19388,7 @@ F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
 F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
 F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 F:	drivers/clk/clk-rp1.c
+F:	drivers/pinctrl/pinctrl-rp1.c
 F:	include/dt-bindings/clock/rp1.h
 F:	include/dt-bindings/misc/rp1.h
 
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 354536de564b..b56e207dcf82 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -587,6 +587,17 @@ config PINCTRL_MLXBF3
 	  each pin. This driver can also be built as a module called
 	  pinctrl-mlxbf3.
 
+config PINCTRL_RP1
+	tristate "Pinctrl driver for RP1"
+	depends on MISC_RP1
+	default MISC_RP1
+	select PINMUX
+	select PINCONF
+	select GENERIC_PINCONF
+	help
+	  Enable the gpio and pinctrl/mux driver for RaspberryPi RP1
+	  multi function device.
+
 source "drivers/pinctrl/actions/Kconfig"
 source "drivers/pinctrl/aspeed/Kconfig"
 source "drivers/pinctrl/bcm/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 97823f52b972..2d714047a1ce 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
 obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
 obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
+obj-$(CONFIG_PINCTRL_RP1)       += pinctrl-rp1.o
 obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
diff --git a/drivers/pinctrl/pinctrl-rp1.c b/drivers/pinctrl/pinctrl-rp1.c
new file mode 100644
index 000000000000..7f550d4f677d
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-rp1.c
@@ -0,0 +1,789 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Raspberry Pi RP1 GPIO unit
+ *
+ * Copyright (C) 2023 Raspberry Pi Ltd.
+ *
+ * This driver is inspired by:
+ * pinctrl-bcm2835.c, please see original file for copyright information
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MODULE_NAME "pinctrl-rp1"
+#define RP1_NUM_GPIOS	54
+#define RP1_NUM_BANKS	3
+
+#define RP1_INT_EDGE_FALLING		BIT(0)
+#define RP1_INT_EDGE_RISING		BIT(1)
+#define RP1_INT_LEVEL_LOW		BIT(2)
+#define RP1_INT_LEVEL_HIGH		BIT(3)
+#define RP1_INT_MASK			GENMASK(3, 0)
+#define RP1_INT_EDGE_BOTH		(RP1_INT_EDGE_FALLING |	\
+					 RP1_INT_EDGE_RISING)
+
+#define RP1_FSEL_COUNT			9
+
+#define RP1_FSEL_ALT0			0x00
+#define RP1_FSEL_GPIO			0x05
+#define RP1_FSEL_NONE			0x09
+#define RP1_FSEL_NONE_HW		0x1f
+
+#define RP1_PAD_DRIVE_2MA		0x0
+#define RP1_PAD_DRIVE_4MA		0x1
+#define RP1_PAD_DRIVE_8MA		0x2
+#define RP1_PAD_DRIVE_12MA		0x3
+
+enum {
+	RP1_PUD_OFF			= 0,
+	RP1_PUD_DOWN			= 1,
+	RP1_PUD_UP			= 2,
+};
+
+enum {
+	RP1_DIR_OUTPUT			= 0,
+	RP1_DIR_INPUT			= 1,
+};
+
+enum {
+	RP1_OUTOVER_PERI		= 0,
+	RP1_OUTOVER_INVPERI		= 1,
+	RP1_OUTOVER_LOW			= 2,
+	RP1_OUTOVER_HIGH		= 3,
+};
+
+enum {
+	RP1_OEOVER_PERI			= 0,
+	RP1_OEOVER_INVPERI		= 1,
+	RP1_OEOVER_DISABLE		= 2,
+	RP1_OEOVER_ENABLE		= 3,
+};
+
+enum {
+	RP1_INOVER_PERI			= 0,
+	RP1_INOVER_INVPERI		= 1,
+	RP1_INOVER_LOW			= 2,
+	RP1_INOVER_HIGH			= 3,
+};
+
+enum {
+	RP1_GPIO_CTRL_IRQRESET_SET		= 0,
+	RP1_GPIO_CTRL_INT_CLR			= 1,
+	RP1_GPIO_CTRL_INT_SET			= 2,
+	RP1_GPIO_CTRL_OEOVER			= 3,
+	RP1_GPIO_CTRL_FUNCSEL			= 4,
+	RP1_GPIO_CTRL_OUTOVER			= 5,
+	RP1_GPIO_CTRL				= 6,
+};
+
+enum {
+	RP1_INTE_SET			= 0,
+	RP1_INTE_CLR			= 1,
+};
+
+enum {
+	RP1_RIO_OUT_SET			= 0,
+	RP1_RIO_OUT_CLR			= 1,
+	RP1_RIO_OE			= 2,
+	RP1_RIO_OE_SET			= 3,
+	RP1_RIO_OE_CLR			= 4,
+	RP1_RIO_IN			= 5,
+};
+
+enum {
+	RP1_PAD_SLEWFAST		= 0,
+	RP1_PAD_SCHMITT			= 1,
+	RP1_PAD_PULL			= 2,
+	RP1_PAD_DRIVE			= 3,
+	RP1_PAD_IN_ENABLE		= 4,
+	RP1_PAD_OUT_DISABLE		= 5,
+};
+
+static const struct reg_field rp1_gpio_fields[] = {
+	[RP1_GPIO_CTRL_IRQRESET_SET]	= REG_FIELD(0x2004, 28, 28),
+	[RP1_GPIO_CTRL_INT_CLR]		= REG_FIELD(0x3004, 20, 23),
+	[RP1_GPIO_CTRL_INT_SET]		= REG_FIELD(0x2004, 20, 23),
+	[RP1_GPIO_CTRL_OEOVER]		= REG_FIELD(0x0004, 14, 15),
+	[RP1_GPIO_CTRL_FUNCSEL]		= REG_FIELD(0x0004, 0, 4),
+	[RP1_GPIO_CTRL_OUTOVER]		= REG_FIELD(0x0004, 12, 13),
+	[RP1_GPIO_CTRL]			= REG_FIELD(0x0004, 0, 31),
+};
+
+static const struct reg_field rp1_inte_fields[] = {
+	[RP1_INTE_SET]			= REG_FIELD(0x2000, 0, 0),
+	[RP1_INTE_CLR]			= REG_FIELD(0x3000, 0, 0),
+};
+
+static const struct reg_field rp1_rio_fields[] = {
+	[RP1_RIO_OUT_SET]		= REG_FIELD(0x2000, 0, 0),
+	[RP1_RIO_OUT_CLR]		= REG_FIELD(0x3000, 0, 0),
+	[RP1_RIO_OE]			= REG_FIELD(0x0004, 0, 0),
+	[RP1_RIO_OE_SET]		= REG_FIELD(0x2004, 0, 0),
+	[RP1_RIO_OE_CLR]		= REG_FIELD(0x3004, 0, 0),
+	[RP1_RIO_IN]			= REG_FIELD(0x0008, 0, 0),
+};
+
+static const struct reg_field rp1_pad_fields[] = {
+	[RP1_PAD_SLEWFAST]		= REG_FIELD(0, 0, 0),
+	[RP1_PAD_SCHMITT]		= REG_FIELD(0, 1, 1),
+	[RP1_PAD_PULL]			= REG_FIELD(0, 2, 3),
+	[RP1_PAD_DRIVE]			= REG_FIELD(0, 4, 5),
+	[RP1_PAD_IN_ENABLE]		= REG_FIELD(0, 6, 6),
+	[RP1_PAD_OUT_DISABLE]		= REG_FIELD(0, 7, 7),
+};
+
+struct rp1_iobank_desc {
+	int min_gpio;
+	int num_gpios;
+	int gpio_offset;
+	int inte_offset;
+	int ints_offset;
+	int rio_offset;
+	int pads_offset;
+};
+
+struct rp1_pin_info {
+	u8 num;
+	u8 bank;
+	u8 offset;
+	u8 fsel;
+	u8 irq_type;
+
+	struct regmap_field *gpio[ARRAY_SIZE(rp1_gpio_fields)];
+	struct regmap_field *rio[ARRAY_SIZE(rp1_rio_fields)];
+	struct regmap_field *inte[ARRAY_SIZE(rp1_inte_fields)];
+	struct regmap_field *pad[ARRAY_SIZE(rp1_pad_fields)];
+};
+
+struct rp1_pinctrl {
+	struct device *dev;
+	void __iomem *gpio_base;
+	void __iomem *rio_base;
+	void __iomem *pads_base;
+	int irq[RP1_NUM_BANKS];
+	struct rp1_pin_info pins[RP1_NUM_GPIOS];
+
+	struct pinctrl_dev *pctl_dev;
+	struct gpio_chip gpio_chip;
+	struct pinctrl_gpio_range gpio_range;
+
+	raw_spinlock_t irq_lock[RP1_NUM_BANKS];
+};
+
+static const struct rp1_iobank_desc rp1_iobanks[RP1_NUM_BANKS] = {
+	/*         gpio   inte    ints     rio    pads */
+	{  0, 28, 0x0000, 0x011c, 0x0124, 0x0000, 0x0004 },
+	{ 28,  6, 0x4000, 0x411c, 0x4124, 0x4000, 0x4004 },
+	{ 34, 20, 0x8000, 0x811c, 0x8124, 0x8000, 0x8004 },
+};
+
+static int rp1_pinconf_set(struct rp1_pin_info *pin,
+			   unsigned int offset, unsigned long *configs,
+			   unsigned int num_configs);
+
+static struct rp1_pin_info *rp1_get_pin(struct gpio_chip *chip,
+					unsigned int offset)
+{
+	struct rp1_pinctrl *pc = gpiochip_get_data(chip);
+
+	if (pc && offset < RP1_NUM_GPIOS)
+		return &pc->pins[offset];
+	return NULL;
+}
+
+static void rp1_input_enable(struct rp1_pin_info *pin, int value)
+{
+	regmap_field_write(pin->pad[RP1_PAD_IN_ENABLE], !!value);
+}
+
+static void rp1_output_enable(struct rp1_pin_info *pin, int value)
+{
+	regmap_field_write(pin->pad[RP1_PAD_OUT_DISABLE], !value);
+}
+
+static u32 rp1_get_fsel(struct rp1_pin_info *pin)
+{
+	u32 oeover, fsel;
+
+	regmap_field_read(pin->gpio[RP1_GPIO_CTRL_OEOVER], &oeover);
+	regmap_field_read(pin->gpio[RP1_GPIO_CTRL_FUNCSEL], &fsel);
+
+	if (oeover != RP1_OEOVER_PERI || fsel >= RP1_FSEL_COUNT)
+		fsel = RP1_FSEL_NONE;
+
+	return fsel;
+}
+
+static void rp1_set_fsel(struct rp1_pin_info *pin, u32 fsel)
+{
+	if (fsel >= RP1_FSEL_COUNT)
+		fsel = RP1_FSEL_NONE_HW;
+
+	rp1_input_enable(pin, 1);
+	rp1_output_enable(pin, 1);
+
+	if (fsel == RP1_FSEL_NONE) {
+		regmap_field_write(pin->gpio[RP1_GPIO_CTRL_OEOVER], RP1_OEOVER_DISABLE);
+	} else {
+		regmap_field_write(pin->gpio[RP1_GPIO_CTRL_OUTOVER], RP1_OUTOVER_PERI);
+		regmap_field_write(pin->gpio[RP1_GPIO_CTRL_OEOVER], RP1_OEOVER_PERI);
+	}
+
+	regmap_field_write(pin->gpio[RP1_GPIO_CTRL_FUNCSEL], fsel);
+}
+
+static int rp1_get_dir(struct rp1_pin_info *pin)
+{
+	unsigned int val;
+
+	regmap_field_read(pin->rio[RP1_RIO_OE], &val);
+
+	return !val ? RP1_DIR_INPUT : RP1_DIR_OUTPUT;
+}
+
+static void rp1_set_dir(struct rp1_pin_info *pin, bool is_input)
+{
+	int reg = is_input ? RP1_RIO_OE_CLR : RP1_RIO_OE_SET;
+
+	regmap_field_write(pin->rio[reg], 1);
+}
+
+static int rp1_get_value(struct rp1_pin_info *pin)
+{
+	unsigned int val;
+
+	regmap_field_read(pin->rio[RP1_RIO_IN], &val);
+
+	return !!val;
+}
+
+static void rp1_set_value(struct rp1_pin_info *pin, int value)
+{
+	/* Assume the pin is already an output */
+	int reg = value ? RP1_RIO_OUT_SET : RP1_RIO_OUT_CLR;
+
+	regmap_field_write(pin->rio[reg], 1);
+}
+
+static int rp1_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rp1_pin_info *pin = rp1_get_pin(chip, offset);
+	int ret;
+
+	if (!pin)
+		return -EINVAL;
+
+	ret = rp1_get_value(pin);
+
+	return ret;
+}
+
+static void rp1_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct rp1_pin_info *pin = rp1_get_pin(chip, offset);
+
+	if (pin)
+		rp1_set_value(pin, value);
+}
+
+static int rp1_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rp1_pin_info *pin = rp1_get_pin(chip, offset);
+	u32 fsel;
+
+	if (!pin)
+		return -EINVAL;
+
+	fsel = rp1_get_fsel(pin);
+	if (fsel != RP1_FSEL_GPIO)
+		return -EINVAL;
+
+	return (rp1_get_dir(pin) == RP1_DIR_OUTPUT) ?
+		GPIO_LINE_DIRECTION_OUT :
+		GPIO_LINE_DIRECTION_IN;
+}
+
+static int rp1_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rp1_pin_info *pin = rp1_get_pin(chip, offset);
+
+	if (!pin)
+		return -EINVAL;
+	rp1_set_dir(pin, RP1_DIR_INPUT);
+	rp1_set_fsel(pin, RP1_FSEL_GPIO);
+
+	return 0;
+}
+
+static int rp1_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
+				     int value)
+{
+	struct rp1_pin_info *pin = rp1_get_pin(chip, offset);
+
+	if (!pin)
+		return -EINVAL;
+	rp1_set_value(pin, value);
+	rp1_set_dir(pin, RP1_DIR_OUTPUT);
+	rp1_set_fsel(pin, RP1_FSEL_GPIO);
+
+	return 0;
+}
+
+static int rp1_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
+			       unsigned long config)
+{
+	struct rp1_pin_info *pin = rp1_get_pin(chip, offset);
+	unsigned long configs[] = { config };
+
+	return rp1_pinconf_set(pin, offset, configs,
+			       ARRAY_SIZE(configs));
+}
+
+static const struct gpio_chip rp1_gpio_chip = {
+	.label = MODULE_NAME,
+	.owner = THIS_MODULE,
+	.request = gpiochip_generic_request,
+	.free = gpiochip_generic_free,
+	.direction_input = rp1_gpio_direction_input,
+	.direction_output = rp1_gpio_direction_output,
+	.get_direction = rp1_gpio_get_direction,
+	.get = rp1_gpio_get,
+	.set = rp1_gpio_set,
+	.base = -1,
+	.set_config = rp1_gpio_set_config,
+	.ngpio = RP1_NUM_GPIOS,
+	.can_sleep = false,
+};
+
+static void rp1_gpio_irq_handler(struct irq_desc *desc)
+{
+	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
+	struct irq_chip *host_chip = irq_desc_get_chip(desc);
+	struct rp1_pinctrl *pc = gpiochip_get_data(chip);
+	const struct rp1_iobank_desc *bank;
+	int irq = irq_desc_get_irq(desc);
+	unsigned long ints;
+	int bit_pos;
+
+	if (pc->irq[0] == irq)
+		bank = &rp1_iobanks[0];
+	else if (pc->irq[1] == irq)
+		bank = &rp1_iobanks[1];
+	else
+		bank = &rp1_iobanks[2];
+
+	chained_irq_enter(host_chip, desc);
+
+	ints = readl(pc->gpio_base + bank->ints_offset);
+	for_each_set_bit(bit_pos, &ints, 32) {
+		struct rp1_pin_info *pin = rp1_get_pin(chip, bit_pos);
+
+		regmap_field_write(pin->gpio[RP1_GPIO_CTRL_IRQRESET_SET], 1);
+		generic_handle_irq(irq_linear_revmap(pc->gpio_chip.irq.domain,
+						     bank->gpio_offset + bit_pos));
+	}
+
+	chained_irq_exit(host_chip, desc);
+}
+
+static void rp1_gpio_irq_config(struct rp1_pin_info *pin, bool enable)
+{
+	int reg = enable ? RP1_INTE_SET : RP1_INTE_CLR;
+
+	regmap_field_write(pin->inte[reg], 1);
+	if (!enable)
+		/* Clear any latched events */
+		regmap_field_write(pin->gpio[RP1_GPIO_CTRL_IRQRESET_SET], 1);
+}
+
+static void rp1_gpio_irq_enable(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	unsigned int gpio = irqd_to_hwirq(data);
+	struct rp1_pin_info *pin = rp1_get_pin(chip, gpio);
+
+	rp1_gpio_irq_config(pin, true);
+}
+
+static void rp1_gpio_irq_disable(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	unsigned int gpio = irqd_to_hwirq(data);
+	struct rp1_pin_info *pin = rp1_get_pin(chip, gpio);
+
+	rp1_gpio_irq_config(pin, false);
+}
+
+static int rp1_irq_set_type(struct rp1_pin_info *pin, unsigned int type)
+{
+	u32 irq_flags;
+
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		irq_flags = 0;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		irq_flags = RP1_INT_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		irq_flags = RP1_INT_EDGE_FALLING;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		irq_flags = RP1_INT_EDGE_RISING | RP1_INT_EDGE_FALLING;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_flags = RP1_INT_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_flags = RP1_INT_LEVEL_LOW;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* Clear them all */
+	regmap_field_write(pin->gpio[RP1_GPIO_CTRL_INT_CLR], RP1_INT_MASK);
+
+	/* Set those that are needed */
+	regmap_field_write(pin->gpio[RP1_GPIO_CTRL_INT_SET], irq_flags);
+	pin->irq_type = type;
+
+	return 0;
+}
+
+static int rp1_gpio_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	unsigned int gpio = irqd_to_hwirq(data);
+	struct rp1_pin_info *pin = rp1_get_pin(chip, gpio);
+	struct rp1_pinctrl *pc = gpiochip_get_data(chip);
+	int bank = pin->bank;
+	unsigned long flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
+
+	ret = rp1_irq_set_type(pin, type);
+	if (!ret) {
+		if (type & IRQ_TYPE_EDGE_BOTH)
+			irq_set_handler_locked(data, handle_edge_irq);
+		else
+			irq_set_handler_locked(data, handle_level_irq);
+	}
+
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+
+	return ret;
+}
+
+static void rp1_gpio_irq_ack(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	unsigned int gpio = irqd_to_hwirq(data);
+	struct rp1_pin_info *pin = rp1_get_pin(chip, gpio);
+
+	/* Clear any latched events */
+	regmap_field_write(pin->gpio[RP1_GPIO_CTRL_IRQRESET_SET], 1);
+}
+
+static struct irq_chip rp1_gpio_irq_chip = {
+	.name = MODULE_NAME,
+	.irq_enable = rp1_gpio_irq_enable,
+	.irq_disable = rp1_gpio_irq_disable,
+	.irq_set_type = rp1_gpio_irq_set_type,
+	.irq_ack = rp1_gpio_irq_ack,
+	.irq_mask = rp1_gpio_irq_disable,
+	.irq_unmask = rp1_gpio_irq_enable,
+	.flags = IRQCHIP_IMMUTABLE,
+};
+
+static void rp1_pull_config_set(struct rp1_pin_info *pin, unsigned int arg)
+{
+	regmap_field_write(pin->pad[RP1_PAD_PULL], arg & 0x3);
+}
+
+static int rp1_pinconf_set(struct rp1_pin_info *pin, unsigned int offset,
+			   unsigned long *configs, unsigned int num_configs)
+{
+	u32 param, arg;
+	int i;
+
+	if (!pin)
+		return -EINVAL;
+
+	for (i = 0; i < num_configs; i++) {
+		param = pinconf_to_config_param(configs[i]);
+		arg = pinconf_to_config_argument(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+			rp1_pull_config_set(pin, RP1_PUD_OFF);
+			break;
+
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			rp1_pull_config_set(pin, RP1_PUD_DOWN);
+			break;
+
+		case PIN_CONFIG_BIAS_PULL_UP:
+			rp1_pull_config_set(pin, RP1_PUD_UP);
+			break;
+
+		case PIN_CONFIG_INPUT_ENABLE:
+			rp1_input_enable(pin, arg);
+			break;
+
+		case PIN_CONFIG_OUTPUT_ENABLE:
+			rp1_output_enable(pin, arg);
+			break;
+
+		case PIN_CONFIG_OUTPUT:
+			rp1_set_value(pin, arg);
+			rp1_set_dir(pin, RP1_DIR_OUTPUT);
+			rp1_set_fsel(pin, RP1_FSEL_GPIO);
+			break;
+
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+			regmap_field_write(pin->pad[RP1_PAD_SCHMITT], !!arg);
+			break;
+
+		case PIN_CONFIG_SLEW_RATE:
+			regmap_field_write(pin->pad[RP1_PAD_SLEWFAST], !!arg);
+			break;
+
+		case PIN_CONFIG_DRIVE_STRENGTH:
+			switch (arg) {
+			case 2:
+				arg = RP1_PAD_DRIVE_2MA;
+				break;
+			case 4:
+				arg = RP1_PAD_DRIVE_4MA;
+				break;
+			case 8:
+				arg = RP1_PAD_DRIVE_8MA;
+				break;
+			case 12:
+				arg = RP1_PAD_DRIVE_12MA;
+				break;
+			default:
+				return -ENOTSUPP;
+			}
+			regmap_field_write(pin->pad[RP1_PAD_DRIVE], arg);
+			break;
+
+		default:
+			return -ENOTSUPP;
+
+		} /* switch param type */
+	} /* for each config */
+
+	return 0;
+}
+
+static const struct of_device_id rp1_pinctrl_match[] = {
+	{ .compatible = "raspberrypi,rp1-gpio" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rp1_pinctrl_match);
+
+static struct rp1_pinctrl rp1_pinctrl_data = {};
+
+static const struct regmap_config rp1_pinctrl_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+	.name = "rp1-pinctrl",
+};
+
+static int rp1_gen_regfield(struct device *dev,
+			    const struct reg_field *array,
+			    size_t array_size,
+			    int reg_off,
+			    int pin_off,
+			    bool additive_offset,
+			    struct regmap *regmap,
+			    struct regmap_field *out[])
+{
+	struct reg_field regfield;
+	int k;
+
+	for (k = 0; k < array_size; k++) {
+		regfield = array[k];
+		regfield.reg = (additive_offset ? regfield.reg : 0) + reg_off;
+		if (pin_off >= 0) {
+			regfield.lsb = pin_off;
+			regfield.msb = regfield.lsb;
+		}
+		out[k] = devm_regmap_field_alloc(dev, regmap, regfield);
+
+		if (IS_ERR(out[k]))
+			return PTR_ERR(out[k]);
+	}
+
+	return 0;
+}
+
+static int rp1_pinctrl_probe(struct platform_device *pdev)
+{
+	struct regmap *gpio_regmap, *rio_regmap, *pads_regmap;
+	struct rp1_pinctrl *pc = &rp1_pinctrl_data;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct gpio_irq_chip *girq;
+	int err, i;
+
+	pc->dev = dev;
+	pc->gpio_chip = rp1_gpio_chip;
+	pc->gpio_chip.parent = dev;
+
+	pc->gpio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pc->gpio_base))
+		return dev_err_probe(dev, PTR_ERR(pc->gpio_base), "could not get GPIO IO memory\n");
+
+	pc->rio_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(pc->rio_base))
+		return dev_err_probe(dev, PTR_ERR(pc->rio_base), "could not get RIO IO memory\n");
+
+	pc->pads_base = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(pc->pads_base))
+		return dev_err_probe(dev, PTR_ERR(pc->pads_base), "could not get PADS IO memory\n");
+
+	gpio_regmap = devm_regmap_init_mmio(dev, pc->gpio_base,
+					    &rp1_pinctrl_regmap_cfg);
+	if (IS_ERR(gpio_regmap))
+		return dev_err_probe(dev, PTR_ERR(gpio_regmap), "could not init GPIO regmap\n");
+
+	rio_regmap = devm_regmap_init_mmio(dev, pc->rio_base,
+					   &rp1_pinctrl_regmap_cfg);
+	if (IS_ERR(rio_regmap))
+		return dev_err_probe(dev, PTR_ERR(rio_regmap), "could not init RIO regmap\n");
+
+	pads_regmap = devm_regmap_init_mmio(dev, pc->pads_base,
+					    &rp1_pinctrl_regmap_cfg);
+	if (IS_ERR(pads_regmap))
+		return dev_err_probe(dev, PTR_ERR(pads_regmap), "could not init PADS regmap\n");
+
+	for (i = 0; i < RP1_NUM_BANKS; i++) {
+		const struct rp1_iobank_desc *bank = &rp1_iobanks[i];
+		int j;
+
+		for (j = 0; j < bank->num_gpios; j++) {
+			struct rp1_pin_info *pin =
+				&pc->pins[bank->min_gpio + j];
+			int reg_off;
+
+			pin->num = bank->min_gpio + j;
+			pin->bank = i;
+			pin->offset = j;
+
+			reg_off = bank->gpio_offset + pin->offset
+				  * sizeof(u32) * 2;
+			err = rp1_gen_regfield(dev,
+					       rp1_gpio_fields,
+					       ARRAY_SIZE(rp1_gpio_fields),
+					       reg_off,
+					       -1,
+					       true,
+					       gpio_regmap,
+					       pin->gpio);
+
+			if (err)
+				return dev_err_probe(dev, err,
+						     "Unable to allocate regmap for gpio\n");
+
+			reg_off = bank->inte_offset;
+			err = rp1_gen_regfield(dev,
+					       rp1_inte_fields,
+					       ARRAY_SIZE(rp1_inte_fields),
+					       reg_off,
+					       pin->offset,
+					       true,
+					       gpio_regmap,
+					       pin->inte);
+
+			if (err)
+				return dev_err_probe(dev, err,
+						     "Unable to allocate regmap for inte\n");
+
+			reg_off = bank->rio_offset;
+			err = rp1_gen_regfield(dev,
+					       rp1_rio_fields,
+					       ARRAY_SIZE(rp1_rio_fields),
+					       reg_off,
+					       pin->offset,
+					       true,
+					       rio_regmap,
+					       pin->rio);
+
+			if (err)
+				return dev_err_probe(dev, err,
+						     "Unable to allocate regmap for rio\n");
+
+			reg_off = bank->pads_offset + pin->offset * sizeof(u32);
+			err = rp1_gen_regfield(dev,
+					       rp1_pad_fields,
+					       ARRAY_SIZE(rp1_pad_fields),
+					       reg_off,
+					       -1,
+					       false,
+					       pads_regmap,
+					       pin->pad);
+
+			if (err)
+				return dev_err_probe(dev, err,
+						     "Unable to allocate regmap for pad\n");
+		}
+
+		raw_spin_lock_init(&pc->irq_lock[i]);
+	}
+
+	girq = &pc->gpio_chip.irq;
+	girq->chip = &rp1_gpio_irq_chip;
+	girq->parent_handler = rp1_gpio_irq_handler;
+	girq->num_parents = RP1_NUM_BANKS;
+	girq->parents = pc->irq;
+	girq->default_type = IRQ_TYPE_NONE;
+	girq->handler = handle_level_irq;
+
+	/*
+	 * Use the same handler for all groups: this is necessary
+	 * since we use one gpiochip to cover all lines - the
+	 * irq handler then needs to figure out which group and
+	 * bank that was firing the IRQ and look up the per-group
+	 * and bank data.
+	 */
+	for (i = 0; i < RP1_NUM_BANKS; i++) {
+		pc->irq[i] = irq_of_parse_and_map(np, i);
+		if (!pc->irq[i]) {
+			girq->num_parents = i;
+			break;
+		}
+	}
+
+	platform_set_drvdata(pdev, pc);
+
+	err = devm_gpiochip_add_data(dev, &pc->gpio_chip, pc);
+	if (err)
+		return dev_err_probe(dev, err, "could not add GPIO chip\n");
+
+	return 0;
+}
+
+static struct platform_driver rp1_pinctrl_driver = {
+	.probe = rp1_pinctrl_probe,
+	.driver = {
+		.name = MODULE_NAME,
+		.of_match_table = rp1_pinctrl_match,
+		.suppress_bind_attrs = true,
+	},
+};
+module_platform_driver(rp1_pinctrl_driver);
+
+MODULE_AUTHOR("Phil Elwell <phil@raspberrypi.com>");
+MODULE_AUTHOR("Andrea della Porta <andrea.porta@suse.com>");
+MODULE_DESCRIPTION("RP1 pinctrl/gpio driver");
+MODULE_LICENSE("GPL");
-- 
2.35.3


