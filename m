Return-Path: <linux-pci+bounces-34449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3688B2F518
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 12:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 706A07B97A1
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 10:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24802F49FE;
	Thu, 21 Aug 2025 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="BultrdNB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout6.mo534.mail-out.ovh.net (smtpout6.mo534.mail-out.ovh.net [54.36.140.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D5C2EB5DE;
	Thu, 21 Aug 2025 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771594; cv=none; b=EXn3/T0CfZT4ptPAxGhL8bfId6VwjneIpNHgwinFHsoXczI8JlAEhjL+FM85kER+g3cYXYTeBYRQG5LRJgqz6ssb9PJBFSiR/l7Qs4P8dxCNpTGEw8s2KddrzjGWnYdnasWayDp+Ewag59SajB+NwOXg8v2Zc9Aoy8J+1amIry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771594; c=relaxed/simple;
	bh=NqQf9Jc+3SbRrfRkJ4AYKg+XmoSQqCNl3ADyalX/KvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WsZLBa8zTIknYO/YuRwUBHSXSfInw3b56ups/Pg/VXTFlN6Wo76mfPdLs3u5L6O8/iCMoApy5bDXiUwhiTDBH2YmZRYI4wADyFGUgQNh5f5jVT1pOFm4w7qraXsi9uAqFCCvzU/ByEO6QtPVYuaqSxMCV/+RG6LIkKnUYV+ovRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=BultrdNB; arc=none smtp.client-ip=54.36.140.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c6zp91RMjz6BJy;
	Thu, 21 Aug 2025 10:19:45 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Thu, 21 Aug 2025 10:19:45 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.37.222])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c6zp90Qbkz1xnh;
	Thu, 21 Aug 2025 10:19:45 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.9])
	by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 07D81B832BF;
	Thu, 21 Aug 2025 10:19:43 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-97G002b6cf9774-3ea7-46e3-8327-10b8b50bb1ac,
                    684E78C7C579463DAB27E2CA1F9C4E28A39E1181) smtp.auth=marcos@orca.pet
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
Subject: [PATCH v3 2/3] gpio: vortex: add new GPIO device driver
Date: Thu, 21 Aug 2025 12:18:58 +0200
Message-Id: <20250821101902.626329-3-marcos@orca.pet>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821101902.626329-1-marcos@orca.pet>
References: <20250821101902.626329-1-marcos@orca.pet>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17492262431657055846
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhgtohhsucffvghlucfuohhlucggihhvvghsuceomhgrrhgtohhssehorhgtrgdrphgvtheqnecuggftrfgrthhtvghrnhepkeevudelhfdvvdekjeehgffhheetjeefhfevgffhfefhgfdvlefgtefhgeduhefgnecuffhomhgrihhnpegumhhprdgtohhmrdhtfienucfkphepuddvjedrtddrtddruddpudegjedrudehiedrgedvrdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehmrghrtghoshesohhrtggrrdhpvghtpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhifrghllhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopehmrghrtghoshesohhrtggrrdhpvghtpdhrtghpthhtoheplhhinhhugi
 dqghhpihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
DKIM-Signature: a=rsa-sha256; bh=JiNSSypzdmcdGwO4MzvY7/7N/cIlsyO551KqNqoZdhU=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755771585;
 v=1;
 b=BultrdNBYhvdi669Qga+DOJa1f8TR4W8fJUcJgoICU0Nozw7GoaGy8p9djdfFhDzInV+Y0bS
 p777+2mquBuaFC1UUBNeawhFUhaRMOz1Qw/GrWkWqbMhIUp9oELzf1Bfkge92Qrbk3JgfJ5RQNE
 WwM8p8TaI0qSmsWH58UcbjjYwi8ingC5v+ZxvffJTxWeHTYNW+7VljM/a9MMMNX8jDdwNYQtJKO
 YUEv/J0k2qTlVtWVCxuSxDwlSEJWJZykMp3RIIbcyC1TF9qxuwDO3DC946Qoeu6C8AeozTNfIRj
 WAQddxr+dQuijWHywzx7soBj2HmWSnMttaQTA+D/phMkA==

Add a new simple GPIO device driver for Vortex86 lines of SoCs,
implemented according to their programming reference manual [1].

This is required for detecting the status of the poweroff button and
performing the poweroff sequence on ICOP eBox computers.

IRQs are not implemented, as they are only available for ports 0 and 1,
none which are accessible on my test machine (an EBOX-3352-GLW).

[1]:
http://www.dmp.com.tw/tech/DMP_Vortex86_Series_Software_Programming_Reference_091216.pdf

Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
---
 MAINTAINERS                |   5 ++
 drivers/gpio/Kconfig       |  11 ++++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-vortex.c | 110 +++++++++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 drivers/gpio/gpio-vortex.c

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..8c3098a39411 100644
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
index e43abb322fa6..cd2b1e105908 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1077,6 +1077,17 @@ config GPIO_TS5500
 	  blocks of the TS-5500: DIO1, DIO2 and the LCD port, and the TS-5600
 	  LCD port.
 
+config GPIO_VORTEX
+	tristate "Vortex SoC GPIO support"
+	select REGMAP_MMIO
+	select GPIO_REGMAP
+	help
+	  Driver to access the five 8-bit bidirectional GPIO ports present on
+	  all DM&P Vortex SoCs.
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
index 000000000000..6fc184942e7f
--- /dev/null
+++ b/drivers/gpio/gpio-vortex.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  GPIO driver for Vortex86 SoCs
+ *
+ *  Author: Marcos Del Sol Vives <marcos@orca.pet>
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/spinlock.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/regmap.h>
+#include <linux/regmap.h>
+#include <linux/ioport.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+
+#define DAT_RANGE 0
+#define DIR_RANGE 1
+
+struct vortex_gpio {
+	struct regmap_range ranges[2];
+	struct regmap_access_table access_table;
+};
+
+static int vortex_gpio_probe(struct platform_device *pdev)
+{
+	struct gpio_regmap_config gpiocfg = {};
+	struct resource *dat_res, *dir_res;
+	struct device *dev = &pdev->dev;
+	struct regmap_config rmcfg = {};
+	unsigned long io_start, io_end;
+	struct vortex_gpio *priv;
+	struct regmap *map;
+	void __iomem *regs;
+
+	dat_res = platform_get_resource_byname(pdev, IORESOURCE_IO, "dat");
+	if (unlikely(!dat_res)) {
+		dev_err(dev, "failed to get data register\n");
+		return -ENODEV;
+	}
+
+	dir_res = platform_get_resource_byname(pdev, IORESOURCE_IO, "dir");
+	if (unlikely(!dir_res)) {
+		dev_err(dev, "failed to get direction register\n");
+		return -ENODEV;
+	}
+
+	if (unlikely(resource_size(dat_res) != resource_size(dir_res))) {
+		dev_err(dev, "data and direction size mismatch\n");
+		return -EINVAL;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct vortex_gpio),
+			    GFP_KERNEL);
+	if (unlikely(!priv))
+		return -ENOMEM;
+	pdev->dev.driver_data = priv;
+
+	/* Map an I/O window that covers both data and direction */
+	io_start = min(dat_res->start, dir_res->start);
+	io_end = max(dat_res->end, dir_res->end);
+	regs = devm_ioport_map(dev, io_start, io_end - io_start + 1);
+	if (unlikely(!regs))
+		return -ENOMEM;
+
+	/* Dynamically build access table from gpiocfg */
+	priv->ranges[DAT_RANGE].range_min = dat_res->start - io_start;
+	priv->ranges[DAT_RANGE].range_max = dat_res->end - io_start;
+	priv->ranges[DIR_RANGE].range_min = dir_res->start - io_start;
+	priv->ranges[DIR_RANGE].range_max = dir_res->end - io_start;
+	priv->access_table.n_yes_ranges = ARRAY_SIZE(priv->ranges);
+	priv->access_table.yes_ranges = priv->ranges;
+
+	rmcfg.reg_bits = 8;
+	rmcfg.val_bits = 8;
+	rmcfg.io_port = true;
+	rmcfg.wr_table = &priv->access_table;
+	rmcfg.rd_table = &priv->access_table;
+
+	map = devm_regmap_init_mmio(dev, regs, &rmcfg);
+	if (unlikely(IS_ERR(map)))
+		return dev_err_probe(dev, PTR_ERR(map),
+				     "Unable to initialize register map\n");
+
+	gpiocfg.parent = dev;
+	gpiocfg.regmap = map;
+	gpiocfg.ngpio = 8 * resource_size(dat_res);
+	gpiocfg.ngpio_per_reg = 8;
+	gpiocfg.reg_dat_base = GPIO_REGMAP_ADDR(priv->ranges[DAT_RANGE].range_min);
+	gpiocfg.reg_set_base = GPIO_REGMAP_ADDR(priv->ranges[DAT_RANGE].range_min);
+	gpiocfg.reg_dir_out_base = GPIO_REGMAP_ADDR(priv->ranges[DIR_RANGE].range_min);
+	gpiocfg.flags = GPIO_REGMAP_DIR_BEFORE_SET;
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


