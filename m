Return-Path: <linux-pci+bounces-34562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058B7B31A9D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6553A5C3CCC
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F373101BC;
	Fri, 22 Aug 2025 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="U7uMZGgh"
X-Original-To: linux-pci@vger.kernel.org
Received: from 11.mo534.mail-out.ovh.net (11.mo534.mail-out.ovh.net [46.105.33.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C830E859
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.33.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871133; cv=none; b=oXCDeAzjC8RYQVoEjMSluzmkEVdWH93DS210Bpvrb8J+hgPh/afh/LcF8J/ut7uQikvOuCSvUVt4O45h4QyrbFte5nJngCXtF/1Fr+26Au8iBc++WdmGtUASVLBtoNKD+o0sifl63lpUJjZEmj2TNtbTDMzoxAmi0V88WY54qUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871133; c=relaxed/simple;
	bh=1nFot461mH2AXNOy+OXg4eZ75foA2HBvx3TjV+cwST4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKcq/OSDU4jfsJ7cgpzKwYuDMpZcPALDTQyX7DX7Fhdjjx2D+NiWKFx2bTPyzzC3D8tbSb49PPZ/+yMPPbJ/QjP77RFUVFj4VXmsi62+ATA+XKTHxmFQb3u0MvfACkSIhAakhDdt6fH8lm0wv1tIu/FS3ewMmlHMdWpknbGkbbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=U7uMZGgh; arc=none smtp.client-ip=46.105.33.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c7hcM1W1rz6D5x;
	Fri, 22 Aug 2025 13:58:43 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Fri, 22 Aug 2025 13:58:43 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.168.168])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c7hcM0F12z1yGZ;
	Fri, 22 Aug 2025 13:58:43 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.4])
	by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 1AEDF3E32D0;
	Fri, 22 Aug 2025 13:58:42 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-95G0016ef2d7ab-2360-4703-861c-5b60f28993d5,
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
Subject: [PATCH v4 3/3] mfd: vortex: implement new driver for Vortex southbridges
Date: Fri, 22 Aug 2025 15:58:13 +0200
Message-Id: <20250822135816.739582-4-marcos@orca.pet>
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
X-Ovh-Tracer-Id: 8616230514139223654
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhgtohhsucffvghlucfuohhlucggihhvvghsuceomhgrrhgtohhssehorhgtrgdrphgvtheqnecuggftrfgrthhtvghrnhepudffudeutdejudeffeeugeehveevgfefiefgueejueejheevtefgtdffvddukeelnecukfhppeduvdejrddtrddtrddupddugeejrdduheeirdegvddrheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepledprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrrhgtohhssehorhgtrgdrphgvthdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdroh
 hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
DKIM-Signature: a=rsa-sha256; bh=qUWhGzunPuC1HDyNVxUC9O9rEFAp/6tcqWTBpQ5k3nI=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755871123;
 v=1;
 b=U7uMZGghJg4ldSfCih9aDGX5RIqWjR0vS1G13sbYsAyHSwTAaR16gVZU0QT4isByk+vpXPKH
 cmL0Salw29gSHg6sHfvEPbi1tBZrFg7Ga/XnG8hxnjQKppsMDSIbgFFFlcbXxpWV3Ej07r/XtfV
 ERLinKufx77j4bgjqy1gx6LnlgPnQ+ObmgPqZ/GJcLly3R/O8w30FDUb0cTUeCOZZFansMrbqIh
 xLKVUDWzddwilTgv48OmHexde26VfAM/vG/yztggoeJyqQjYiVhsIGkMVsduFjJjHmcn4XlWzWa
 JB79lGhxkmIIq1c2lnuTFMahQwov4XIvOzpRwDlR82p2A==

This new driver loads resources related to southbridges available in DM&P
Vortex devices, currently only the GPIO pins.

Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
---
 MAINTAINERS             |   1 +
 drivers/mfd/Kconfig     |   9 +++
 drivers/mfd/Makefile    |   1 +
 drivers/mfd/vortex-sb.c | 135 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |   3 +
 5 files changed, 149 insertions(+)
 create mode 100644 drivers/mfd/vortex-sb.c

diff --git a/MAINTAINERS b/MAINTAINERS
index afa88f446630..63e410e23e95 100644
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
index 000000000000..141fa19773e2
--- /dev/null
+++ b/drivers/mfd/vortex-sb.c
@@ -0,0 +1,135 @@
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
+struct vortex_southbridge {
+	const struct mfd_cell *cells;
+	int n_cells;
+};
+
+/* Layout for Vortex86DX/MX */
+static const struct resource vortex_dx_gpio_resources[] = {
+	{
+		.name	= "dat1",
+		.start	= 0x78,
+		.end	= 0x7C,
+		.flags	= IORESOURCE_IO,
+	}, {
+		.name	= "dir1",
+		.start	= 0x98,
+		.end	= 0x9C,
+		.flags	= IORESOURCE_IO,
+	}
+};
+
+static const struct mfd_cell vortex_dx_sb_cells[] = {
+	{
+		.name		= "vortex-gpio",
+		.resources	= vortex_dx_gpio_resources,
+		.num_resources	= ARRAY_SIZE(vortex_dx_gpio_resources),
+	},
+};
+
+static const struct vortex_southbridge vortex_dx_sb = {
+	.cells = vortex_dx_sb_cells,
+	.n_cells = ARRAY_SIZE(vortex_dx_sb_cells),
+};
+
+/* Layout for Vortex86DX2/DX3 */
+static const struct resource vortex_dx2_gpio_resources[] = {
+	{
+		.name	= "dat1",
+		.start	= 0x78,
+		.end	= 0x7C,
+		.flags	= IORESOURCE_IO,
+	}, {
+		.name	= "dat2",
+		.start	= 0x100,
+		.end	= 0x105,
+		.flags	= IORESOURCE_IO,
+	}, {
+		.name	= "dir1",
+		.start	= 0x98,
+		.end	= 0x9D,
+		.flags	= IORESOURCE_IO,
+	}, {
+		.name	= "dir2",
+		.start	= 0x93,
+		.end	= 0x97,
+		.flags	= IORESOURCE_IO,
+	}
+};
+
+static const struct mfd_cell vortex_dx2_sb_cells[] = {
+	{
+		.name		= "vortex-gpio",
+		.resources	= vortex_dx2_gpio_resources,
+		.num_resources	= ARRAY_SIZE(vortex_dx2_gpio_resources),
+	},
+};
+
+static const struct vortex_southbridge vortex_dx2_sb = {
+	.cells = vortex_dx2_sb_cells,
+	.n_cells = ARRAY_SIZE(vortex_dx2_sb_cells),
+};
+
+static int vortex_sb_probe(struct pci_dev *pdev,
+			   const struct pci_device_id *ent)
+{
+	struct vortex_southbridge *priv = (struct vortex_southbridge *) ent->driver_data;
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
+	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+				    priv->cells, priv->n_cells,
+				    NULL, 0, NULL);
+}
+
+static const struct pci_device_id vortex_sb_table[] = {
+	/* Vortex86DX */
+	{ PCI_DEVICE_DATA(RDC, R6031, &vortex_dx_sb) },
+	/* Vortex86DX2/DX3 */
+	{ PCI_DEVICE_DATA(RDC, R6035, &vortex_dx2_sb) },
+	/* Vortex86MX */
+	{ PCI_DEVICE_DATA(RDC, R6036, &vortex_dx_sb) },
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
index 92ffc4373f6d..2c7afebd94ea 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2412,6 +2412,9 @@
 #define PCI_VENDOR_ID_RDC		0x17f3
 #define PCI_DEVICE_ID_RDC_R6020		0x6020
 #define PCI_DEVICE_ID_RDC_R6030		0x6030
+#define PCI_DEVICE_ID_RDC_R6031		0x6031
+#define PCI_DEVICE_ID_RDC_R6035		0x6035
+#define PCI_DEVICE_ID_RDC_R6036		0x6036
 #define PCI_DEVICE_ID_RDC_R6040		0x6040
 #define PCI_DEVICE_ID_RDC_R6060		0x6060
 #define PCI_DEVICE_ID_RDC_R6061		0x6061
-- 
2.34.1


