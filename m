Return-Path: <linux-pci+bounces-34450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BFCB2F521
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 12:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7242C1BA74D5
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 10:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A5926F476;
	Thu, 21 Aug 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="Xaev/zgv"
X-Original-To: linux-pci@vger.kernel.org
Received: from 5.mo533.mail-out.ovh.net (5.mo533.mail-out.ovh.net [54.36.140.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED7F7263A
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771599; cv=none; b=OgPuVG577XB1T5IqhPz7Gt7hKmYaEv8j5tYZIgCbn7EK+nJkpq+vfThYPWEcQ3Pq2MOi3gCNlFzHFFvw00t5U+rOime43SAqmldKHatxZyX80NT63c5YyItbF02AIfldfYbQL5NHryO0WvdvxZuCI/c3u4f96EVjRhc3at+Y0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771599; c=relaxed/simple;
	bh=QE6s/0lAW6AiPaa0sSBUwamHMoawMGEWdM9hqsudp50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCMbCoi8yLN695VCifnkj2tVQYIFbRs2tymG1HZiuoaTOqchOaTVnsV1Pb//+6/09Jpu7wAzb8mEGcuo61Yz+Am5/YSmJ3l9WWoYdXYXhwGPwOv+iLLuAYUYCbqGXKhmrEvSqCcrffV64AjAOHCViDuJkmGaS8KQUMf+MTZRuss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=Xaev/zgv; arc=none smtp.client-ip=54.36.140.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4c6zpG2kb8z5x0H;
	Thu, 21 Aug 2025 10:19:50 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Thu, 21 Aug 2025 10:19:50 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.254.198])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c6zpG1Z2nz1xnd;
	Thu, 21 Aug 2025 10:19:50 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.9])
	by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 23DE0B832BF;
	Thu, 21 Aug 2025 10:19:49 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-97G0025494fe06-fc45-4a28-81e9-f834ace860e6,
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
Subject: [PATCH v3 3/3] mfd: vortex: implement new driver for Vortex southbridges
Date: Thu, 21 Aug 2025 12:18:59 +0200
Message-Id: <20250821101902.626329-4-marcos@orca.pet>
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
X-Ovh-Tracer-Id: 17493669805666293350
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhgtohhsucffvghlucfuohhlucggihhvvghsuceomhgrrhgtohhssehorhgtrgdrphgvtheqnecuggftrfgrthhtvghrnhepudffudeutdejudeffeeugeehveevgfefiefgueejueejheevtefgtdffvddukeelnecukfhppeduvdejrddtrddtrddupddugeejrdduheeirdegvddrheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepledprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrrhgtohhssehorhgtrgdrphgvthdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdroh
 hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
DKIM-Signature: a=rsa-sha256; bh=X/42sBBdS5U7O2cvVD41aAwhluwIH1nuwQLgzreoPFM=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755771590;
 v=1;
 b=Xaev/zgvZj+ULtrtrlK/R/tTC2D6mgvOYWpZjKg5b5JK6xFzDWKLG7oR3Rd1GNcubedOEan7
 HHVCVqJDniLBJwdte3hq66CsyHSvmFz1LKUfA3c0VKfhrhhIWUEZjFT+XiobJof9VtH4GhbVYnM
 0gJGfB/K9NtSQD3DriVbiMfQy1rV4cnxgiHoZPW1/jo2kwcF7fhuZj0A4I+6otH+m/WQSu36Cie
 qAJmT5jjy/JVEh3Yf5doDe5BLx+oQSWzC92g4CnjYqubROTgyw9CVQADkf5YpC5RAIJcb68ufI4
 ypLjuExxIYxw+Rkpgfdbd/vfJhjbmTDHHtfYOq1PHAT5Q==

This new driver loads resources related to southbridges available in DM&P
Vortex devices, currently only the GPIO pins.

Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
---
 MAINTAINERS             |  1 +
 drivers/mfd/Kconfig     |  9 +++++
 drivers/mfd/Makefile    |  1 +
 drivers/mfd/vortex-sb.c | 81 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |  1 +
 5 files changed, 93 insertions(+)
 create mode 100644 drivers/mfd/vortex-sb.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c3098a39411..bc0c541309dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26957,6 +26957,7 @@ VORTEX HARDWARE SUPPORT
 R:	Marcos Del Sol Vives <marcos@orca.pet>
 S:	Maintained
 F:	drivers/gpio/gpio-vortex.c
+F:	drivers/mfd/vortex-sb.c
 
 VRF
 M:	David Ahern <dsahern@kernel.org>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 425c5fba6cb1..fe54bb22687d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2008,6 +2008,15 @@ config MFD_VX855
 	  VIA VX855/VX875 south bridge. You will need to enable the vx855_spi
 	  and/or vx855_gpio drivers for this to do anything useful.
 
+config MFD_VORTEX_SB
+	tristate "Vortex southbridge"
+	select MFD_CORE
+	depends on PCI
+	help
+	  Say yes here if you want to have support for the southbridge
+	  present on Vortex SoCs. You will need to enable the vortex-gpio
+	  driver for this to do anything useful.
+
 config MFD_ARIZONA
 	select REGMAP
 	select REGMAP_IRQ
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f7bdedd5a66d..2504ba311f1a 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -202,6 +202,7 @@ obj-$(CONFIG_MFD_JANZ_CMODIO)	+= janz-cmodio.o
 obj-$(CONFIG_MFD_TPS6586X)	+= tps6586x.o
 obj-$(CONFIG_MFD_VX855)		+= vx855.o
 obj-$(CONFIG_MFD_WL1273_CORE)	+= wl1273-core.o
+obj-$(CONFIG_MFD_VORTEX_SB)	+= vortex-sb.o
 
 si476x-core-y := si476x-cmd.o si476x-prop.o si476x-i2c.o
 obj-$(CONFIG_MFD_SI476X_CORE)	+= si476x-core.o
diff --git a/drivers/mfd/vortex-sb.c b/drivers/mfd/vortex-sb.c
new file mode 100644
index 000000000000..ef9bbe2d3870
--- /dev/null
+++ b/drivers/mfd/vortex-sb.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  MFD southbridge driver for Vortex SoCs
+ *
+ *  Author: Marcos Del Sol Vives <marcos@orca.pet>
+ *
+ *  Based on the RDC321x MFD driver by Florian Fainelli and Bernhard Loos
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/mfd/core.h>
+
+static const struct resource vortex_gpio_resources[] = {
+	{
+		.name	= "dat",
+		.start	= 0x78,
+		.end	= 0x7C,
+		.flags	= IORESOURCE_IO,
+	}, {
+		.name	= "dir",
+		.start	= 0x98,
+		.end	= 0x9C,
+		.flags	= IORESOURCE_IO,
+	}
+};
+
+static const struct mfd_cell vortex_sb_cells[] = {
+	{
+		.name		= "vortex-gpio",
+		.resources	= vortex_gpio_resources,
+		.num_resources	= ARRAY_SIZE(vortex_gpio_resources),
+	},
+};
+
+static int vortex_sb_probe(struct pci_dev *pdev,
+					const struct pci_device_id *ent)
+{
+	int err;
+
+	/*
+	 * In the Vortex86DX3, the southbridge appears twice (on both 00:07.0
+	 * and 00:07.1). Register only once for .0.
+	 *
+	 * Other Vortex boards (eg Vortex86MX+) have the southbridge exposed
+	 * only once, also at 00:07.0.
+	 */
+	if (PCI_FUNC(pdev->devfn) != 0)
+		return -ENODEV;
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable device\n");
+		return err;
+	}
+
+	return devm_mfd_add_devices(&pdev->dev, -1,
+				    vortex_sb_cells,
+				    ARRAY_SIZE(vortex_sb_cells),
+				    NULL, 0, NULL);
+}
+
+static const struct pci_device_id vortex_sb_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_RDC, PCI_DEVICE_ID_RDC_R6035) },
+	{}
+};
+MODULE_DEVICE_TABLE(pci, vortex_sb_table);
+
+static struct pci_driver vortex_sb_driver = {
+	.name		= "vortex-sb",
+	.id_table	= vortex_sb_table,
+	.probe		= vortex_sb_probe,
+};
+
+module_pci_driver(vortex_sb_driver);
+
+MODULE_AUTHOR("Marcos Del Sol Vives <marcos@orca.pet>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Vortex MFD southbridge driver");
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 92ffc4373f6d..2ff8a593ef72 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2412,6 +2412,7 @@
 #define PCI_VENDOR_ID_RDC		0x17f3
 #define PCI_DEVICE_ID_RDC_R6020		0x6020
 #define PCI_DEVICE_ID_RDC_R6030		0x6030
+#define PCI_DEVICE_ID_RDC_R6035		0x6035
 #define PCI_DEVICE_ID_RDC_R6040		0x6040
 #define PCI_DEVICE_ID_RDC_R6060		0x6060
 #define PCI_DEVICE_ID_RDC_R6061		0x6061
-- 
2.34.1


