Return-Path: <linux-pci+bounces-34561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E34B31AA5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C271D2848D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C744030E829;
	Fri, 22 Aug 2025 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="X1ZFhVeg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout9.mo534.mail-out.ovh.net (smtpout9.mo534.mail-out.ovh.net [178.33.251.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E53D3074A7
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.251.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871129; cv=none; b=QZvxwrVf7mraYpTCgPihZmciSjvP1m33c9YluIRHdwMC7QPnkughyxEqF95Yyed3aZllbNSgWzIGM6lLSSuaV4UbqVK0ClpMp+kwQAe/Mjjg6hKJiSJdvmWtr1P7MEWlVgZI8Ipm0ChaOZK6F6EEVTCqB3i+J4acKzuYJGBpkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871129; c=relaxed/simple;
	bh=I2+ooCH66VdkjAu2Ze3eP4vpjnffGHDacRvjoxxTVaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QfTeZr3+0JFZIfovC/YwUipcv4dbuTVgV2gqrNfWKY/mVyOOlOU9couHp2LrRkWllC+7QlAShJLnUhph1Jk74rhH2sIM7TstjrHPUxKQsgQIkMQGpwLhxbL3SSmrxEH8m/kN+6vfoQrZAAgLwqvjtjd6n4mGRq+JIf3glyrzCqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=X1ZFhVeg; arc=none smtp.client-ip=178.33.251.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c7hcH3ybvz6ByC;
	Fri, 22 Aug 2025 13:58:39 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Fri, 22 Aug 2025 13:58:39 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.164.55])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c7hcH2WNbz1yGR;
	Fri, 22 Aug 2025 13:58:39 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.4])
	by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 5F0633E32CF;
	Fri, 22 Aug 2025 13:58:38 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-95G00193c9e7f0-3e02-4c96-8053-d7a721d83764,
                    ADC0680FE15BB91110492B9A34CE42AA242C155A) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:147.156.42.5
From: Marcos Del Sol Vives <marcos@orca.pet>
To: linux-kernel@vger.kernel.org
Cc: Marcos Del Sol Vives <marcos@orca.pet>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 2/3] gpio: vortex: add new GPIO device driver
Date: Fri, 22 Aug 2025 15:58:12 +0200
Message-Id: <20250822135816.739582-3-marcos@orca.pet>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822135816.739582-1-marcos@orca.pet>
References: <20250822135816.739582-1-marcos@orca.pet>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8615104614398383718
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhgtohhsucffvghlucfuohhlucggihhvvghsuceomhgrrhgtohhssehorhgtrgdrphgvtheqnecuggftrfgrthhtvghrnhepjefhtddukedtjedttdejhfekgeetgeetudelheeghfduffeiveekgfehhfekjedunecuffhomhgrihhnpehvohhrthgvgiekiedrtghomhenucfkphepuddvjedrtddrtddruddpudegjedrudehiedrgedvrdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehmrghrtghoshesohhrtggrrdhpvghtpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhifrghllhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopehmrghrtghoshesohhrtggrrdhpvghtpdhrtghpthhtoheplhhinh
 hugidqghhpihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
DKIM-Signature: a=rsa-sha256; bh=+ddC6/C+4PiskoWM7HBtyuAMn3NQyUw8QTC7ohXcGxA=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755871119;
 v=1;
 b=X1ZFhVegygBtdgZiV99FaouYtYLuwjtKIrOkVUEtuOUnB9ihybHA9Hi1l2anmGBanr1BSFxn
 8nmIwv8uYRphhQ1P8uzBf8GdkLxPW62NC75kYlA/K9Ep8aoPaAI1YZkdSxQWZiCY1/vT0RiGryI
 FqF1raZoOuSEAt9ba//Rx+Lokp+tG0PohRm5Kh9xjZIS9chFnnOjbioOF3hLuvHtrM3oYfvnY9z
 JaPd1lEGa/0zFFQqLX81wmIOcMNSZdvSaZG35EoseUV3lYLevJh1IlvaTQCx0ubU1mEysp/fT5d
 zuKpaD1A7D8nN4x49+E1XLK/x3Ir1xnzr2PSKLRfXhPmA==

Add a new simple GPIO device driver for most DM&P Vortex86 SoCs,
implemented according to their programming reference manuals [1][2][3].

Vortex86EX/EX2 use a radically different mechanism of GPIO control
and are not supported by this driver.

This is required for detecting the status of the poweroff button and
performing the poweroff sequence on ICOP eBox computers.

IRQs are not implemented, as they are only available for ports 0 and 1,
none which are accessible on my test machine (an EBOX-3352-GLW).

[1]: https://www.vortex86.com/downloadsStart?serial=Vortex86SX/DX/MXPLUS
[2]: https://www.vortex86.com/downloadsStart?serial=Vortex86DX2
[3]: https://www.vortex86.com/downloadsStart?serial=Vortex86DX3

Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
---
 MAINTAINERS                |   5 ++
 drivers/gpio/Kconfig       |  13 +++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-vortex.c | 170 +++++++++++++++++++++++++++++++++++++
 4 files changed, 189 insertions(+)
 create mode 100644 drivers/gpio/gpio-vortex.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2720544cd91f..afa88f446630 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26953,6 +26953,11 @@ VOLTAGE AND CURRENT REGULATOR IRQ HELPERS
 R:	Matti Vaittinen <mazziesaccount@gmail.com>
 F:	drivers/regulator/irq_helpers.c
 
+VORTEX HARDWARE SUPPORT
+R:	Marcos Del Sol Vives <marcos@orca.pet>
+S:	Maintained
+F:	drivers/gpio/gpio-vortex.c
+
 VRF
 M:	David Ahern <dsahern@kernel.org>
 L:	netdev@vger.kernel.org
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e43abb322fa6..dd5b24843b41 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1077,6 +1077,19 @@ config GPIO_TS5500
 	  blocks of the TS-5500: DIO1, DIO2 and the LCD port, and the TS-5600
 	  LCD port.
 
+config GPIO_VORTEX
+	tristate "Vortex SoC GPIO support"
+	select REGMAP_MMIO
+	select GPIO_REGMAP
+	help
+	  Driver to access the 8-bit bidirectional GPIO ports present on DM&P
+	  Vortex86SX/MX/MX+/DX/DX2/DX3 SoCs.
+
+	  Vortex86EX-series parts are not supported.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gpio-vortex.
+
 config GPIO_WINBOND
 	tristate "Winbond Super I/O GPIO support"
 	select ISA_BUS_API
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 379f55e9ed1e..7b8626c9bd75 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -197,6 +197,7 @@ obj-$(CONFIG_GPIO_VIPERBOARD)		+= gpio-viperboard.o
 obj-$(CONFIG_GPIO_VIRTUSER)		+= gpio-virtuser.o
 obj-$(CONFIG_GPIO_VIRTIO)		+= gpio-virtio.o
 obj-$(CONFIG_GPIO_VISCONTI)		+= gpio-visconti.o
+obj-$(CONFIG_GPIO_VORTEX)		+= gpio-vortex.o
 obj-$(CONFIG_GPIO_VX855)		+= gpio-vx855.o
 obj-$(CONFIG_GPIO_WCD934X)		+= gpio-wcd934x.o
 obj-$(CONFIG_GPIO_WHISKEY_COVE)		+= gpio-wcove.o
diff --git a/drivers/gpio/gpio-vortex.c b/drivers/gpio/gpio-vortex.c
new file mode 100644
index 000000000000..edac919a5799
--- /dev/null
+++ b/drivers/gpio/gpio-vortex.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * GPIO driver for Vortex86 SoCs
+ *
+ * Vortex SoCs may have either a single set (DX/MX/SX) of data/direction ports,
+ * or two non-contiguous sets (DX2/DX3).
+ *
+ * Because gpio-regmap is not designed to handle ranges with holes of arbitrary
+ * sizes in them, this driver reports a virtual layout where ports 0..n-1 are
+ * data ports, and n..n*2-1 are direction ports. The xlate function then maps
+ * these virtual ports back to the real hardware registers relative to the
+ * requested I/O window.
+ *
+ * Author: Marcos Del Sol Vives <marcos@orca.pet>
+ */
+
+#include <linux/bits.h>
+#include <linux/errno.h>
+#include <linux/gpio/regmap.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+struct vortex_gpio {
+	struct regmap_range ranges[4];
+	struct regmap_access_table access_table;
+	struct device *dev;
+};
+
+static int vortex_gpio_xlate(struct gpio_regmap *gpio, unsigned int base,
+			     unsigned int offset, unsigned int *reg,
+			     unsigned int *mask)
+{
+	struct vortex_gpio *priv = gpio_regmap_get_drvdata(gpio);
+	unsigned int virtual_port, r_min, r_size;
+	int i;
+
+	virtual_port = base + offset / 8;
+
+	for (i = 0; i < priv->access_table.n_yes_ranges; i++) {
+		r_min = priv->ranges[i].range_min;
+		r_size = priv->ranges[i].range_max - r_min + 1;
+
+		if (virtual_port < r_size) {
+			*reg = virtual_port + r_min;
+			*mask = BIT(offset % 8);
+			return 0;
+		}
+		virtual_port -= r_size;
+	}
+
+	/* should never happen */
+	dev_err(priv->dev, "tried to translate an out-of-bounds virtual port: %u\n",
+		base + offset / 8);
+	return -EINVAL;
+}
+
+static int vortex_gpio_add_range(struct vortex_gpio *priv,
+				 struct platform_device *pdev,
+				 const char *res_name)
+{
+	struct resource *res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_IO, res_name);
+	if (!res)
+		return 0;
+
+	priv->ranges[priv->access_table.n_yes_ranges].range_min = res->start;
+	priv->ranges[priv->access_table.n_yes_ranges].range_max = res->end;
+	priv->access_table.n_yes_ranges++;
+
+	return resource_size(res);
+}
+
+static int vortex_gpio_probe(struct platform_device *pdev)
+{
+	struct gpio_regmap_config gpiocfg = {};
+	struct device *dev = &pdev->dev;
+	struct regmap_config rmcfg = {};
+	unsigned long io_min, io_max;
+	struct vortex_gpio *priv;
+	int i, dat_len, dir_len;
+	struct regmap *map;
+	void __iomem *regs;
+
+	/* Initialize private data */
+	priv = devm_kzalloc(dev, sizeof(struct vortex_gpio),
+			    GFP_KERNEL);
+	if (unlikely(!priv))
+		return -ENOMEM;
+	priv->dev = dev;
+	priv->access_table.yes_ranges = priv->ranges;
+
+	/* Add I/O ports from platform data to ranges */
+	dat_len = vortex_gpio_add_range(priv, pdev, "dat1");
+	if (unlikely(!dat_len)) {
+		dev_err(dev, "failed to get data register\n");
+		return -ENODEV;
+	}
+	dat_len += vortex_gpio_add_range(priv, pdev, "dat2");
+
+	dir_len = vortex_gpio_add_range(priv, pdev, "dir1");
+	if (unlikely(!dir_len)) {
+		dev_err(dev, "failed to get direction register\n");
+		return -ENODEV;
+	}
+	dir_len += vortex_gpio_add_range(priv, pdev, "dir2");
+
+	if (unlikely(dat_len != dir_len)) {
+		dev_err(dev, "data and direction size mismatch (%d vs %d)\n",
+			dat_len, dir_len);
+		return -EINVAL;
+	}
+
+	/* Request smallest I/O window that covers all registers */
+	io_min = priv->ranges[0].range_min;
+	io_max = priv->ranges[0].range_max;
+	for (i = 1; i < priv->access_table.n_yes_ranges; i++) {
+		io_min = min(io_min, priv->ranges[i].range_min);
+		io_max = max(io_max, priv->ranges[i].range_max);
+	}
+
+	regs = devm_ioport_map(dev, io_min, io_max - io_min + 1);
+	if (unlikely(!regs))
+		return -ENOMEM;
+
+	/* Subtract io_min to make them relative to the window */
+	for (i = 0; i < priv->access_table.n_yes_ranges; i++) {
+		priv->ranges[i].range_min -= io_min;
+		priv->ranges[i].range_max -= io_min;
+	}
+
+	rmcfg.reg_bits = 8;
+	rmcfg.val_bits = 8;
+	rmcfg.io_port = true;
+	rmcfg.wr_table = &priv->access_table;
+	rmcfg.rd_table = &priv->access_table;
+
+	map = devm_regmap_init_mmio(dev, regs, &rmcfg);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map),
+				     "Unable to initialize register map\n");
+
+	gpiocfg.parent = dev;
+	gpiocfg.regmap = map;
+	gpiocfg.drvdata = priv;
+	gpiocfg.ngpio = 8 * dat_len;
+	gpiocfg.ngpio_per_reg = 8;
+	gpiocfg.reg_dat_base = GPIO_REGMAP_ADDR(0);
+	gpiocfg.reg_set_base = GPIO_REGMAP_ADDR(0);
+	gpiocfg.reg_dir_out_base = GPIO_REGMAP_ADDR(dat_len);
+	gpiocfg.flags = GPIO_REGMAP_DIR_BEFORE_SET;
+	gpiocfg.reg_mask_xlate = vortex_gpio_xlate;
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpiocfg));
+}
+
+static struct platform_driver vortex_gpio_driver = {
+	.driver.name = "vortex-gpio",
+	.probe = vortex_gpio_probe,
+};
+
+module_platform_driver(vortex_gpio_driver);
+
+MODULE_AUTHOR("Marcos Del Sol Vives <marcos@orca.pet>");
+MODULE_DESCRIPTION("GPIO driver for Vortex86 SoCs");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:vortex-gpio");
-- 
2.34.1


