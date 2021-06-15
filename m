Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34383A8C74
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 01:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhFOX2t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 19:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhFOX2t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 19:28:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB77CC061574
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 16:26:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x24so945869lfr.10
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 16:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P1KZ1PMGJa0XLzKjBXrbyg3eD936HCG42wVLMlnZns4=;
        b=FZycETvf4ZQEAmmUi/lN71jp38ZxRLSE8xCPzbXORmyxUHpD8ID+YRJMZX7HFgtTqp
         hAcVQIkbwRlJEfKnlhUpaX1btu5YxBtK35YLutQa0//keaEfuFeZWBTJefSxoogEREge
         lEbAhiLw7u2jK3IBW97pZDH7Fvd/c4HKzAYSjQEREqfxqeG6hHnmVygnz8OGkvuEK1Pw
         NQkNpFcqAzHNgmvGE2ZObGcG2PqcQTiPWLIbwfMX6Rg+3gCU0jLnrjefiP3vnXcaazDd
         yr1NPlO4CZQmIFKsgKEFqjhUfm9GH6JcPxaPhQT5cnc1bQUb1fiPkpwwrnR9tj4OHvM8
         uHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P1KZ1PMGJa0XLzKjBXrbyg3eD936HCG42wVLMlnZns4=;
        b=d2Z/etuvgju4H9D4tj4W76pdPOZahjkQG36bHPwHluyKWB+CTJP7U9zF8ZfQt+7slL
         KPtIOKIdVCzXqRcDiiwkdxVYtsRdScQrBxPxvvbjFkk+NOq6CslD2dmUe0fij0CxlB6H
         8FksLv6iWYQyNuNWoBh1dvkudzStPXj80Ao1dMbL4hBg0RJe0UdxNm6fC08Wzxk059hr
         QB3sNqDfDJS5s6Pc8QRALDFuv8xX1L3mD56ofv1FBU7rqzTcChmlxTsyFfW1RyY6U0ll
         lffnM+DD3MLZtUKWg9bbe7FBX7f4716R9m29mcHcwEnVOZ8rKjKwnLPekYs6Uc08zwdf
         jWqA==
X-Gm-Message-State: AOAM530QrP6B3EVNECLGFM10PaTi1YxCBU8Sda9cIEWbPptMYOpT9FOg
        Rsrer6WhCrnmdeBKI/w+nQbL7A==
X-Google-Smtp-Source: ABdhPJzCpcM3IK/HUskxFXvVp0Wkf42aVemNRz58HXrFRDxH7bu4RVZEwhMbjGM+UqXs4JnRZaDwdA==
X-Received: by 2002:ac2:5389:: with SMTP id g9mr1256720lfh.557.1623799599791;
        Tue, 15 Jun 2021 16:26:39 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id r9sm49390lfm.158.2021.06.15.16.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 16:26:39 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v6] PCI: ixp4xx: Add a new driver for IXP4xx
Date:   Wed, 16 Jun 2021 01:24:25 +0200
Message-Id: <20210615232425.1253281-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds a new PCI controller driver for the Intel IXP4xx
(IX425, IXP435 etc), based on the XScale microarchitecture.

This replaces the old driver in arch/arm/mach-ixp4xx/common-pci.c
which utilized the ARM-specific BIOS32 PCI framework,
and all parameterization for such things as memory and
IO space as well as interrupt swizzling is done from the
device tree.

The plan is to phase out and delete the old driver piecemal.

The __raw_writel() and __raw_readl() are used for accessing
the PCI controller for the same reason that these accessors
are used in the timer, IRQ and GPIO drivers: the platform
will alter its address bus pattern based on whether the
system is booted in big- or little-endian mode. For this
reason all register on IXP4xx must always be accessed in
native (CPU) endianness.

This driver supports 64MB of PCI memory space, but not the
indirect access of 1GB that is available in the old driver.
We can address that later if and only if there are users
that need all 1GB of PCI address space. Krzysztof reports
having to use indirect MMIO only once for a VGA card. There
is work ongoing for general indirect MMIO. (In practice
the indirect MMIO is performed by writing address and
writing and reading values into/from a controller
register.)

Tested by booting the NSLU2, attaching a USB stick, mounting
and browsing the drive.

Link: https://lore.kernel.org/linux-arm-kernel/m37edwuv8m.fsf@t19.piap.pl/
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Zoltan HERPAI <wigyori@uid0.hu>
Cc: Raylynn Knight <rayknight@me.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v5->v6:
- Drop pointless of_match_pointer() macro.
- Collect Arnd's Review tag.
- Bjorn I understand you have a lot to do but could you give
  this driver a quick look and ACK? Arnd and Lorenzon have
  reviewed it already.
- Kernel bot build errors on this patch can be IGNORED because
  I am sending it outside of the context of the series in order
  to not spam too many patches.
ChangeLog v4->v5:
- Drop the spinlock that was used around the config space
  accessors - CONFIG_PCI_LOCKLESS_CONFIG is not set so the
  core will deal with the locking!
- Collect Lorenzo's ACK.
ChangeLog v2->v4:
- Use IS_ENABLED() to detect big endian mode.
- Rebase on v5.13-rc1
- Add a Link: to Krzysztofs mail
ChangeLog v2->v3:
- Fix a double assignment of .suppress_bind_attrs
ChangeLog v1->v2:
- Add dependencies on ARM to Kconfig since we are regisering
  and ARM only abort handler.
- Create ixp4xx_readl() and ixp4xx_writel() static inline
  wrappers around the __raw_readl() and __raw_writel() calls
  with a big comment block explaining what is going on.
- Drop bus pointer from state container, it is only used in
  probe()
- Use pci_host_probe() and get rid of a lot of boilerplate.
- Use builtin_driver_probe() and explain why this is
  necessary with comments in the code.

PCI maintainers: looking for review or ACK to take this
driver throght ARM SoC since it is dependent on the first
patches in the series in order not to cause build
problems.
---
 MAINTAINERS                         |   6 +
 drivers/pci/controller/Kconfig      |   8 +
 drivers/pci/controller/Makefile     |   1 +
 drivers/pci/controller/pci-ixp4xx.c | 688 ++++++++++++++++++++++++++++
 4 files changed, 703 insertions(+)
 create mode 100644 drivers/pci/controller/pci-ixp4xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..16f17ac198e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14016,6 +14016,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
 F:	drivers/pci/controller/dwc/pcie-fu740.c
 
+PCI DRIVER FOR INTEL IXP4XX
+M:	Linus Walleij <linus.walleij@linaro.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
+F:	drivers/pci/controller/pci-ixp4xx.c
+
 PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
 M:	Jonathan Derrick <jonathan.derrick@intel.com>
 L:	linux-pci@vger.kernel.org
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 2f2c8a1729f9..5e1e3796efa4 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -37,6 +37,14 @@ config PCI_FTPCI100
 	depends on OF
 	default ARCH_GEMINI
 
+config PCI_IXP4XX
+	bool "Intel IXP4xx PCI controller"
+	depends on ARM && OF
+	default ARCH_IXP4XX
+	help
+	  Say Y here if you want support for the PCI host controller found
+	  in the Intel IXP4xx XScale-based network processor SoC.
+
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 63e3880a3e87..aaf30b3dcc14 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_CADENCE) += cadence/
 obj-$(CONFIG_PCI_FTPCI100) += pci-ftpci100.o
+obj-$(CONFIG_PCI_IXP4XX) += pci-ixp4xx.o
 obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
 obj-$(CONFIG_PCI_HYPERV_INTERFACE) += pci-hyperv-intf.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
diff --git a/drivers/pci/controller/pci-ixp4xx.c b/drivers/pci/controller/pci-ixp4xx.c
new file mode 100644
index 000000000000..f721d047c616
--- /dev/null
+++ b/drivers/pci/controller/pci-ixp4xx.c
@@ -0,0 +1,688 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for Intel IXP4xx PCI host controller
+ *
+ * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
+ *
+ * Based on the IXP4xx arch/arm/mach-ixp4xx/common-pci.c driver
+ * Copyright (C) 2002 Intel Corporation
+ * Copyright (C) 2003 Greg Ungerer <gerg@linux-m68k.org>
+ * Copyright (C) 2003-2004 MontaVista Software, Inc.
+ * Copyright (C) 2005 Deepak Saxena <dsaxena@plexity.net>
+ * Copyright (C) 2005 Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * TODO:
+ * - Test IO-space access
+ * - DMA support
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/bits.h>
+
+/* Register offsets */
+#define IXP4XX_PCI_NP_AD		0x00
+#define IXP4XX_PCI_NP_CBE		0x04
+#define IXP4XX_PCI_NP_WDATA		0x08
+#define IXP4XX_PCI_NP_RDATA		0x0c
+#define IXP4XX_PCI_CRP_AD_CBE		0x10
+#define IXP4XX_PCI_CRP_WDATA		0x14
+#define IXP4XX_PCI_CRP_RDATA		0x18
+#define IXP4XX_PCI_CSR			0x1c
+#define IXP4XX_PCI_ISR			0x20
+#define IXP4XX_PCI_INTEN		0x24
+#define IXP4XX_PCI_DMACTRL		0x28
+#define IXP4XX_PCI_AHBMEMBASE		0x2c
+#define IXP4XX_PCI_AHBIOBASE		0x30
+#define IXP4XX_PCI_PCIMEMBASE		0x34
+#define IXP4XX_PCI_AHBDOORBELL		0x38
+#define IXP4XX_PCI_PCIDOORBELL		0x3C
+#define IXP4XX_PCI_ATPDMA0_AHBADDR	0x40
+#define IXP4XX_PCI_ATPDMA0_PCIADDR	0x44
+#define IXP4XX_PCI_ATPDMA0_LENADDR	0x48
+#define IXP4XX_PCI_ATPDMA1_AHBADDR	0x4C
+#define IXP4XX_PCI_ATPDMA1_PCIADDR	0x50
+#define IXP4XX_PCI_ATPDMA1_LENADDR	0x54
+
+/* CSR bit definitions */
+#define IXP4XX_PCI_CSR_HOST		BIT(0)
+#define IXP4XX_PCI_CSR_ARBEN		BIT(1)
+#define IXP4XX_PCI_CSR_ADS		BIT(2)
+#define IXP4XX_PCI_CSR_PDS		BIT(3)
+#define IXP4XX_PCI_CSR_ABE		BIT(4)
+#define IXP4XX_PCI_CSR_DBT		BIT(5)
+#define IXP4XX_PCI_CSR_ASE		BIT(8)
+#define IXP4XX_PCI_CSR_IC		BIT(15)
+#define IXP4XX_PCI_CSR_PRST		BIT(16)
+
+/* ISR (Interrupt status) Register bit definitions */
+#define IXP4XX_PCI_ISR_PSE		BIT(0)
+#define IXP4XX_PCI_ISR_PFE		BIT(1)
+#define IXP4XX_PCI_ISR_PPE		BIT(2)
+#define IXP4XX_PCI_ISR_AHBE		BIT(3)
+#define IXP4XX_PCI_ISR_APDC		BIT(4)
+#define IXP4XX_PCI_ISR_PADC		BIT(5)
+#define IXP4XX_PCI_ISR_ADB		BIT(6)
+#define IXP4XX_PCI_ISR_PDB		BIT(7)
+
+/* INTEN (Interrupt Enable) Register bit definitions */
+#define IXP4XX_PCI_INTEN_PSE		BIT(0)
+#define IXP4XX_PCI_INTEN_PFE		BIT(1)
+#define IXP4XX_PCI_INTEN_PPE		BIT(2)
+#define IXP4XX_PCI_INTEN_AHBE		BIT(3)
+#define IXP4XX_PCI_INTEN_APDC		BIT(4)
+#define IXP4XX_PCI_INTEN_PADC		BIT(5)
+#define IXP4XX_PCI_INTEN_ADB		BIT(6)
+#define IXP4XX_PCI_INTEN_PDB		BIT(7)
+
+/* Shift value for byte enable on NP cmd/byte enable register */
+#define IXP4XX_PCI_NP_CBE_BESL		4
+
+/* PCI commands supported by NP access unit */
+#define NP_CMD_IOREAD			0x2
+#define NP_CMD_IOWRITE			0x3
+#define NP_CMD_CONFIGREAD		0xa
+#define NP_CMD_CONFIGWRITE		0xb
+#define NP_CMD_MEMREAD			0x6
+#define	NP_CMD_MEMWRITE			0x7
+
+/* Constants for CRP access into local config space */
+#define CRP_AD_CBE_BESL         20
+#define CRP_AD_CBE_WRITE	0x00010000
+
+/* Special PCI configuration space registers for this controller */
+#define IXP4XX_PCI_RTOTTO		0x40
+
+struct ixp4xx_pci {
+	struct device *dev;
+	void __iomem *base;
+	bool errata_hammer;
+	bool host_mode;
+};
+
+/*
+ * The IXP4xx has a peculiar address bus that will change the
+ * byte order on SoC peripherals depending on whether the device
+ * operates in big endian or little endian mode. That means that
+ * readl() and writel() that always use little-endian access
+ * will not work for SoC peripherals such as the PCI controller
+ * when used in big endian mode. The accesses to the individual
+ * PCI devices on the other hand, are always little-endian and
+ * can use readl() and writel().
+ *
+ * For local AHB bus access we need to use __raw_[readl|writel]()
+ * to make sure that we access the SoC devices in the CPU native
+ * endianness.
+ */
+static inline u32 ixp4xx_readl(struct ixp4xx_pci *p, u32 reg)
+{
+	return __raw_readl(p->base + reg);
+}
+
+static inline void ixp4xx_writel(struct ixp4xx_pci *p, u32 reg, u32 val)
+{
+	__raw_writel(val, p->base + reg);
+}
+
+static int ixp4xx_pci_check_master_abort(struct ixp4xx_pci *p)
+{
+	u32 isr = ixp4xx_readl(p, IXP4XX_PCI_ISR);
+
+	if (isr & IXP4XX_PCI_ISR_PFE) {
+		/* Make sure the master abort bit is reset */
+		ixp4xx_writel(p, IXP4XX_PCI_ISR, IXP4XX_PCI_ISR_PFE);
+		dev_dbg(p->dev, "master abort detected\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ixp4xx_pci_read(struct ixp4xx_pci *p, u32 addr, u32 cmd, u32 *data)
+{
+	int ret;
+
+	ixp4xx_writel(p, IXP4XX_PCI_NP_AD, addr);
+
+	if (p->errata_hammer) {
+		int i;
+
+		/*
+		 * PCI workaround - only works if NP PCI space reads have
+		 * no side effects. Hammer the register and read twice 8
+		 * times. last one will be good.
+		 */
+		for (i = 0; i < 8; i++) {
+			ixp4xx_writel(p, IXP4XX_PCI_NP_CBE, cmd);
+			*data = ixp4xx_readl(p, IXP4XX_PCI_NP_RDATA);
+			*data = ixp4xx_readl(p, IXP4XX_PCI_NP_RDATA);
+		}
+	} else {
+		ixp4xx_writel(p, IXP4XX_PCI_NP_CBE, cmd);
+		*data = ixp4xx_readl(p, IXP4XX_PCI_NP_RDATA);
+	}
+
+	/* Check for master abort */
+	ret = ixp4xx_pci_check_master_abort(p);
+
+	return ret;
+}
+
+static int ixp4xx_pci_write(struct ixp4xx_pci *p, u32 addr, u32 cmd, u32 data)
+{
+	int ret;
+
+	ixp4xx_writel(p, IXP4XX_PCI_NP_AD, addr);
+
+	/* Set up the write */
+	ixp4xx_writel(p, IXP4XX_PCI_NP_CBE, cmd);
+
+	/* Execute the write by writing to NP_WDATA */
+	ixp4xx_writel(p, IXP4XX_PCI_NP_WDATA, data);
+
+	/* Check for master abort */
+	ret = ixp4xx_pci_check_master_abort(p);
+
+	return ret;
+}
+
+static u32 ixp4xx_config_addr(u8 bus_num, u16 devfn, int where)
+{
+	u32 addr;
+
+	if (!bus_num) {
+		/* type 0 */
+		addr = BIT(32-PCI_SLOT(devfn)) | ((PCI_FUNC(devfn)) << 8) |
+			(where & ~3);
+	} else {
+		/* type 1 */
+		addr = (bus_num << 16) | ((PCI_SLOT(devfn)) << 11) |
+			((PCI_FUNC(devfn)) << 8) | (where & ~3) | 1;
+	}
+	return addr;
+}
+
+/*
+ * CRP functions are "Controller Configuration Port" accesses
+ * initiated from within this driver itself to read/write PCI
+ * control information in the config space.
+ */
+static u32 ixp4xx_crp_byte_lane_enable_bits(u32 n, int size)
+{
+	if (size == 1)
+		return (0xf & ~BIT(n)) << CRP_AD_CBE_BESL;
+	if (size == 2)
+		return (0xf & ~(BIT(n) | BIT(n+1))) << CRP_AD_CBE_BESL;
+	if (size == 4)
+		return 0;
+	return 0xffffffff;
+}
+
+static int ixp4xx_crp_read_config(struct ixp4xx_pci *p, int where, int size,
+				  u32 *value)
+{
+	u32 n, cmd, val;
+
+	n = where % 4;
+	cmd = where & ~3;
+
+	dev_dbg(p->dev, "%s from %d size %d cmd %08x\n",
+		__func__, where, size, cmd);
+
+	ixp4xx_writel(p, IXP4XX_PCI_CRP_AD_CBE, cmd);
+	val = ixp4xx_readl(p, IXP4XX_PCI_CRP_RDATA);
+
+	val >>= (8*n);
+	switch (size) {
+	case 1:
+		val &= U8_MAX;
+		dev_dbg(p->dev, "%s read byte %02x\n", __func__, val);
+		break;
+	case 2:
+		val &= U16_MAX;
+		dev_dbg(p->dev, "%s read word %04x\n", __func__, val);
+		break;
+	case 4:
+		val &= U32_MAX;
+		dev_dbg(p->dev, "%s read long %08x\n", __func__, val);
+		break;
+	default:
+		/* Should not happen */
+		dev_err(p->dev, "%s illegal size\n", __func__);
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+	*value = val;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int ixp4xx_crp_write_config(struct ixp4xx_pci *p, int where, int size,
+				   u32 value)
+{
+	u32 n, cmd, val;
+
+	n = where % 4;
+	cmd = ixp4xx_crp_byte_lane_enable_bits(n, size);
+	if (cmd == 0xffffffff)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	cmd |= where & ~3;
+	cmd |= CRP_AD_CBE_WRITE;
+
+	val = value << (8*n);
+
+	dev_dbg(p->dev, "%s to %d size %d cmd %08x val %08x\n",
+		__func__, where, size, cmd, val);
+
+	ixp4xx_writel(p, IXP4XX_PCI_CRP_AD_CBE, cmd);
+	ixp4xx_writel(p, IXP4XX_PCI_CRP_WDATA, val);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/*
+ * Then follows the functions that read and write from the common
+ * PCI configuration space.
+ */
+
+static u32 ixp4xx_byte_lane_enable_bits(u32 n, int size)
+{
+	if (size == 1)
+		return (0xf & ~BIT(n)) << 4;
+	if (size == 2)
+		return (0xf & ~(BIT(n) | BIT(n+1))) << 4;
+	if (size == 4)
+		return 0;
+	return 0xffffffff;
+}
+
+static int ixp4xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 *value)
+{
+	struct ixp4xx_pci *p = bus->sysdata;
+	u32 n, addr, val, cmd;
+	u8 bus_num = bus->number;
+	int ret;
+
+	*value = 0xffffffff;
+	n = where % 4;
+	cmd = ixp4xx_byte_lane_enable_bits(n, size);
+	if (cmd == 0xffffffff)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	addr = ixp4xx_config_addr(bus_num, devfn, where);
+	cmd |= NP_CMD_CONFIGREAD;
+	dev_dbg(p->dev, "read_config from %d size %d dev %d:%d:%d address: %08x cmd: %08x\n",
+		where, size, bus_num, PCI_SLOT(devfn), PCI_FUNC(devfn), addr, cmd);
+
+	ret = ixp4xx_pci_read(p, addr, cmd, &val);
+	if (ret)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	val >>= (8*n);
+	switch (size) {
+	case 1:
+		val &= U8_MAX;
+		dev_dbg(p->dev, "%s read byte %02x\n", __func__, val);
+		break;
+	case 2:
+		val &= U16_MAX;
+		dev_dbg(p->dev, "%s read word %04x\n", __func__, val);
+		break;
+	case 4:
+		val &= U32_MAX;
+		dev_dbg(p->dev, "%s read long %08x\n", __func__, val);
+		break;
+	default:
+		/* Should not happen */
+		dev_err(p->dev, "%s illegal size\n", __func__);
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+	*value = val;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int ixp4xx_pci_write_config(struct pci_bus *bus,  unsigned int devfn,
+				   int where, int size, u32 value)
+{
+	struct ixp4xx_pci *p = bus->sysdata;
+	u32 n, addr, val, cmd;
+	u8 bus_num = bus->number;
+	int ret;
+
+	n = where % 4;
+	cmd = ixp4xx_byte_lane_enable_bits(n, size);
+	if (cmd == 0xffffffff)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	addr = ixp4xx_config_addr(bus_num, devfn, where);
+	cmd |= NP_CMD_CONFIGWRITE;
+	val = value << (8*n);
+
+	dev_dbg(p->dev, "write_config_byte %#x to %d size %d dev %d:%d:%d addr: %08x cmd %08x\n",
+		value, where, size, bus_num, PCI_SLOT(devfn), PCI_FUNC(devfn), addr, cmd);
+
+	ret = ixp4xx_pci_write(p, addr, cmd, val);
+	if (ret)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops ixp4xx_pci_ops = {
+	.read = ixp4xx_pci_read_config,
+	.write = ixp4xx_pci_write_config,
+};
+
+static u32 ixp4xx_pci_addr_to_64mconf(phys_addr_t addr)
+{
+	u8 base;
+
+	base = ((addr & 0xff000000) >> 24);
+	return (base << 24) | ((base + 1) << 16)
+		| ((base + 2) << 8) | (base + 3);
+}
+
+static int ixp4xx_pci_parse_map_ranges(struct ixp4xx_pci *p)
+{
+	struct device *dev = p->dev;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(p);
+	struct resource_entry *win;
+	struct resource *res;
+	phys_addr_t addr;
+
+	win = resource_list_first_type(&bridge->windows, IORESOURCE_MEM);
+	if (win) {
+		u32 pcimembase;
+
+		res = win->res;
+		addr = res->start - win->offset;
+
+		if (res->flags & IORESOURCE_PREFETCH)
+			res->name = "IXP4xx PCI PRE-MEM";
+		else
+			res->name = "IXP4xx PCI NON-PRE-MEM";
+
+		dev_dbg(dev, "%s window %pR, bus addr %pa\n",
+			res->name, res, &addr);
+		if (resource_size(res) != SZ_64M) {
+			dev_err(dev, "memory range is not 64MB\n");
+			return -EINVAL;
+		}
+
+		pcimembase = ixp4xx_pci_addr_to_64mconf(addr);
+		/* Commit configuration */
+		ixp4xx_writel(p, IXP4XX_PCI_PCIMEMBASE, pcimembase);
+	} else {
+		dev_err(dev, "no AHB memory mapping defined\n");
+	}
+
+	win = resource_list_first_type(&bridge->windows, IORESOURCE_IO);
+	if (win) {
+		res = win->res;
+
+		addr = pci_pio_to_address(res->start);
+		if (addr & 0xff) {
+			dev_err(dev, "IO mem at uneven address: %pa\n", &addr);
+			return -EINVAL;
+		}
+
+		res->name = "IXP4xx PCI IO MEM";
+		/*
+		 * Setup I/O space location for PCI->AHB access, the
+		 * upper 24 bits of the address goes into the lower
+		 * 24 bits of this register.
+		 */
+		ixp4xx_writel(p, IXP4XX_PCI_AHBIOBASE, (addr >> 8));
+	} else {
+		dev_info(dev, "no IO space AHB memory mapping defined\n");
+	}
+
+	return 0;
+}
+
+static int ixp4xx_pci_parse_map_dma_ranges(struct ixp4xx_pci *p)
+{
+	struct device *dev = p->dev;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(p);
+	struct resource_entry *win;
+	struct resource *res;
+	phys_addr_t addr;
+	u32 ahbmembase;
+
+	win = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
+	if (win) {
+		res = win->res;
+		addr = res->start - win->offset;
+
+		if (resource_size(res) != SZ_64M) {
+			dev_err(dev, "DMA memory range is not 64MB\n");
+			return -EINVAL;
+		}
+
+		dev_dbg(dev, "DMA MEM BASE: %pa\n", &addr);
+		/*
+		 * 4 PCI-to-AHB windows of 16 MB each, write the 8 high bits
+		 * into each byte of the PCI_AHBMEMBASE register.
+		 */
+		ahbmembase = ixp4xx_pci_addr_to_64mconf(addr);
+		/* Commit AHB membase */
+		ixp4xx_writel(p, IXP4XX_PCI_AHBMEMBASE, ahbmembase);
+	} else {
+		dev_err(dev, "no DMA memory range defined\n");
+	}
+
+	return 0;
+}
+
+/* Only used to get context for abort handling */
+static struct ixp4xx_pci *ixp4xx_pci_abort_singleton;
+
+static int ixp4xx_pci_abort_handler(unsigned long addr, unsigned int fsr,
+				    struct pt_regs *regs)
+{
+	struct ixp4xx_pci *p = ixp4xx_pci_abort_singleton;
+	u32 isr, status;
+	int ret;
+
+	isr = ixp4xx_readl(p, IXP4XX_PCI_ISR);
+	ret = ixp4xx_crp_read_config(p, PCI_STATUS, 2, &status);
+	if (ret) {
+		dev_err(p->dev, "unable to read abort status\n");
+		return -EINVAL;
+	}
+
+	dev_err(p->dev,
+		"PCI: abort_handler addr = %#lx, isr = %#x, status = %#x\n",
+		addr, isr, status);
+
+	/* Make sure the Master Abort bit is reset */
+	ixp4xx_writel(p, IXP4XX_PCI_ISR, IXP4XX_PCI_ISR_PFE);
+	status |= PCI_STATUS_REC_MASTER_ABORT;
+	ret = ixp4xx_crp_write_config(p, PCI_STATUS, 2, status);
+	if (ret)
+		dev_err(p->dev, "unable to clear abort status bit\n");
+
+	/*
+	 * If it was an imprecise abort, then we need to correct the
+	 * return address to be _after_ the instruction.
+	 */
+	if (fsr & (1 << 10)) {
+		dev_err(p->dev, "imprecise abort\n");
+		regs->ARM_pc += 4;
+	}
+
+	return 0;
+}
+
+static int __init ixp4xx_pci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct ixp4xx_pci *p;
+	struct pci_host_bridge *host;
+	int ret;
+	u32 val;
+	phys_addr_t addr;
+	u32 basereg[4] = {
+		PCI_BASE_ADDRESS_0,
+		PCI_BASE_ADDRESS_1,
+		PCI_BASE_ADDRESS_2,
+		PCI_BASE_ADDRESS_3,
+	};
+	int i;
+
+	host = devm_pci_alloc_host_bridge(dev, sizeof(*p));
+	if (!host)
+		return -ENOMEM;
+
+	host->ops = &ixp4xx_pci_ops;
+	p = pci_host_bridge_priv(host);
+	host->sysdata = p;
+	p->dev = dev;
+	dev_set_drvdata(dev, p);
+
+	/*
+	 * Set up quirk for erratic behaviour in the 42x variant
+	 * when accessing config space.
+	 */
+	if (of_device_is_compatible(np, "intel,ixp42x-pci")) {
+		p->errata_hammer = true;
+		dev_info(dev, "activate hammering errata\n");
+	}
+
+	p->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(p->base))
+		return PTR_ERR(p->base);
+
+	val = ixp4xx_readl(p, IXP4XX_PCI_CSR);
+	p->host_mode = !!(val & IXP4XX_PCI_CSR_HOST);
+	dev_info(dev, "controller is in %s mode\n",
+		 p->host_mode ? "host" : "option");
+
+	/* Hook in our fault handler for PCI errors */
+	ixp4xx_pci_abort_singleton = p;
+	hook_fault_code(16+6, ixp4xx_pci_abort_handler, SIGBUS, 0,
+			"imprecise external abort");
+
+	ret = ixp4xx_pci_parse_map_ranges(p);
+	if (ret)
+		return ret;
+
+	ret = ixp4xx_pci_parse_map_dma_ranges(p);
+	if (ret)
+		return ret;
+
+	/* This is only configured in host mode */
+	if (p->host_mode) {
+		addr = __pa(PAGE_OFFSET);
+		/* This is a noop (0x00) but explains what is going on */
+		addr |= PCI_BASE_ADDRESS_SPACE_MEMORY;
+
+		for (i = 0; i < 4; i++) {
+			/* Write this directly into the config space */
+			ret = ixp4xx_crp_write_config(p, basereg[i], 4, addr);
+			if (ret)
+				dev_err(dev, "failed to set up PCI_BASE_ADDRESS_%d\n", i);
+			else
+				dev_info(dev, "set PCI_BASE_ADDR_%d to %pa\n", i, &addr);
+			addr += SZ_16M;
+		}
+
+		/*
+		 * Enable CSR window at 64 MiB to allow PCI masters to continue
+		 * prefetching past the 64 MiB boundary, if all AHB to PCI windows
+		 * are consecutive.
+		 */
+		ret = ixp4xx_crp_write_config(p, PCI_BASE_ADDRESS_4, 4, addr);
+		if (ret)
+			dev_err(dev, "failed to set up PCI_BASE_ADDRESS_4\n");
+		else
+			dev_info(dev, "set PCI_BASE_ADDR_4 to %pa\n", &addr);
+
+		/*
+		 * Put the IO memory at the very end of physical memory at
+		 * 0xfffffc00. This is when the PCI is trying to access IO
+		 * memory over AHB.
+		 */
+		addr = 0xfffffc00;
+		addr |= PCI_BASE_ADDRESS_SPACE_IO;
+		ret = ixp4xx_crp_write_config(p, PCI_BASE_ADDRESS_5, 4, addr);
+		if (ret)
+			dev_err(dev, "failed to set up PCI_BASE_ADDRESS_5\n");
+		else
+			dev_info(dev, "set PCI_BASE_ADDR_5 to %pa\n", &addr);
+
+		/*
+		 * Retry timeout to 0x80
+		 * Transfer ready timeout to 0xff
+		 */
+		ret = ixp4xx_crp_write_config(p, IXP4XX_PCI_RTOTTO, 4,
+					      0x000080ff);
+		if (ret)
+			dev_err(dev, "failed to set up TRDY limit\n");
+		else
+			dev_info(dev, "set TRDY limit to 0x80ff\n");
+	}
+
+	/* Clear interrupts */
+	val = IXP4XX_PCI_ISR_PSE | IXP4XX_PCI_ISR_PFE | IXP4XX_PCI_ISR_PPE | IXP4XX_PCI_ISR_AHBE;
+	ixp4xx_writel(p, IXP4XX_PCI_ISR, val);
+
+	/*
+	 * Set Initialize Complete in PCI Control Register: allow IXP4XX to
+	 * respond to PCI configuration cycles. Specify that the AHB bus is
+	 * operating in big endian mode. Set up byte lane swapping between
+	 * little-endian PCI and the big-endian AHB bus.
+	 */
+	val = IXP4XX_PCI_CSR_IC | IXP4XX_PCI_CSR_ABE;
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		val |= (IXP4XX_PCI_CSR_PDS | IXP4XX_PCI_CSR_ADS);
+	ixp4xx_writel(p, IXP4XX_PCI_CSR, val);
+
+	ret = ixp4xx_crp_write_config(p, PCI_COMMAND, 2, PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
+	if (ret)
+		dev_err(dev, "unable to initialize master and command memory\n");
+	else
+		dev_info(dev, "initialized as master\n");
+
+	pci_host_probe(host);
+
+	return 0;
+}
+
+static const struct of_device_id ixp4xx_pci_of_match[] = {
+	{
+		.compatible = "intel,ixp42x-pci",
+	},
+	{
+		.compatible = "intel,ixp43x-pci",
+	},
+	{},
+};
+
+/*
+ * This driver needs to be a builtin module with suppressed bind
+ * attributes since the probe() is initializing a hard exception
+ * handler and this can only be done from __init-tagged code
+ * sections. This module cannot be removed and inserted at all.
+ */
+static struct platform_driver ixp4xx_pci_driver = {
+	.driver = {
+		.name = "ixp4xx-pci",
+		.suppress_bind_attrs = true,
+		.of_match_table = ixp4xx_pci_of_match,
+	},
+};
+/*
+ * This is the only way to have an __init tagged probe that does
+ * not cause link errors.
+ */
+builtin_platform_driver_probe(ixp4xx_pci_driver, ixp4xx_pci_probe);
-- 
2.31.1

