Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96BA372255
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 23:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhECVRy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 17:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhECVRy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 17:17:54 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B053C06174A
        for <linux-pci@vger.kernel.org>; Mon,  3 May 2021 14:17:00 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p12so8614281ljg.1
        for <linux-pci@vger.kernel.org>; Mon, 03 May 2021 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QB2eo9mOZyIP1GSRr7eRTM83gniSfCN+6Qj6PzMwfco=;
        b=aCYhJfHufwZ+VSjm/SQDR8Oa3vljj5MHXPfPGLbtySrL9EhCk5AK5OW/n8TRySDPNa
         ZC7zIMOALyJcXMrQXgRkEk/c/lmSxZBJs5FiEfWa5Mq54M1T451RydPysGk1yex0Bo6j
         aLum1Y/aK/xgYlO4PYcD0HCM4A53MY+sl+NPPHHePwe8s6QwwwcjayG1IXXH1zu8U8Zr
         SArKA5mdXzTLBgtWj5LHInqkD10ks/V0hoG0NnRyFjVPCHHuPBDfSgE55UwnL0HyTcna
         lEAdu2mY/N4CfVe0O/zmA6u3AIWEzsTAEu/vl6UQC5D+SJB5xZPFteQA841Fn4juuCsA
         RFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QB2eo9mOZyIP1GSRr7eRTM83gniSfCN+6Qj6PzMwfco=;
        b=rUC8QoYw1CjMxtNSh62moE1kpiKrQsbjRbx4pMW48Mp7dcvzEOFMfGW1PGPPHo8UeE
         qV52dIk4wDz+pmTxoIaWdA5uWr9Ig/JP5+noHPnwc+c4X0UeXzOZji4FrXbSQQHzvbNW
         kVty9JVbKoirwGk/tE83f0uKeV3u1H15Xxzusca/ITS0hFlOcgia6r0CLsu3uaxjabpb
         ShVHBzpatHKciXgvCwWVfgHaJqL44r3qXxbOH/IFcRd8fa3uHqPZUZql4vmjvD+dMlWu
         0o2H6qopMNDrKd1UpKODnLw5pD85ucWA5xP61pKjwmW6FcHSj4/Z6C9EYTx5+eF1rWAK
         tcTA==
X-Gm-Message-State: AOAM530OpNcxxrUeR8L7ovqRjAYWoH0eiLTHBOn8b1sDkftLI4TLAA8o
        WW4MgOW4d0ojkQpu5drMmufloA==
X-Google-Smtp-Source: ABdhPJzvrTmjYFUidR7z6SX2xhven0jTGno2hhx7hvJkueL4F4JRIWr3v/jJ9xO3RbA0jRa7NeBw6A==
X-Received: by 2002:a2e:a585:: with SMTP id m5mr13309810ljp.223.1620076618500;
        Mon, 03 May 2021 14:16:58 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m12sm67676lfb.72.2021.05.03.14.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 14:16:58 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/4] PCI: ixp4xx: Add a new driver for IXP4xx
Date:   Mon,  3 May 2021 23:16:49 +0200
Message-Id: <20210503211649.4109334-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210503211649.4109334-1-linus.walleij@linaro.org>
References: <20210503211649.4109334-1-linus.walleij@linaro.org>
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
that need all 1GB of PCI address space.

Tested by booting the NSLU2, attaching a USB stick, mounting
and browsing the drive.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Zoltan HERPAI <wigyori@uid0.hu>
Cc: Raylynn Knight <rayknight@me.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
PCI maintainers: looking for review or ACK to take this
driver throght ARM SoC since it is dependent on the first
patches in the series in order not to cause build
problems.
---
 MAINTAINERS                         |   6 +
 drivers/pci/controller/Kconfig      |   5 +
 drivers/pci/controller/Makefile     |   1 +
 drivers/pci/controller/pci-ixp4xx.c | 684 ++++++++++++++++++++++++++++
 4 files changed, 696 insertions(+)
 create mode 100644 drivers/pci/controller/pci-ixp4xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..ae220d52a6d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13692,6 +13692,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
 F:	drivers/pci/controller/dwc/*imx6*
 
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
index 5aa8977d7b0f..fc6249cdd909 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -37,6 +37,11 @@ config PCI_FTPCI100
 	depends on OF
 	default ARCH_GEMINI
 
+config PCI_IXP4XX
+	bool "Intel IXP4xx PCI controller"
+	depends on OF
+	default ARCH_IXP4XX
+
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index e4559f2182f2..f81f3fd7a9e0 100644
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
index 000000000000..313fbe7cf177
--- /dev/null
+++ b/drivers/pci/controller/pci-ixp4xx.c
@@ -0,0 +1,684 @@
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
+#include "../pci.h"
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
+	struct pci_bus *bus;
+	raw_spinlock_t lock; /* Protects bus writes */
+	bool errata_hammer;
+	bool host_mode;
+};
+
+static int ixp4xx_pci_check_master_abort(struct ixp4xx_pci *p)
+{
+	u32 isr = __raw_readl(p->base + IXP4XX_PCI_ISR);
+
+	if (isr & IXP4XX_PCI_ISR_PFE) {
+		/* Make sure the master abort bit is reset */
+		__raw_writel(IXP4XX_PCI_ISR_PFE, p->base + IXP4XX_PCI_ISR);
+		dev_dbg(p->dev, "master abort detected\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ixp4xx_pci_read(struct ixp4xx_pci *p, u32 addr, u32 cmd, u32 *data)
+{
+	unsigned long flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&p->lock, flags);
+
+	__raw_writel(addr, p->base + IXP4XX_PCI_NP_AD);
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
+			__raw_writel(cmd, p->base + IXP4XX_PCI_NP_CBE);
+			*data = __raw_readl(p->base + IXP4XX_PCI_NP_RDATA);
+			*data = __raw_readl(p->base + IXP4XX_PCI_NP_RDATA);
+		}
+	} else {
+		__raw_writel(cmd, p->base + IXP4XX_PCI_NP_CBE);
+		*data = __raw_readl(p->base + IXP4XX_PCI_NP_RDATA);
+	}
+
+	/* Check for master abort */
+	ret = ixp4xx_pci_check_master_abort(p);
+
+	raw_spin_unlock_irqrestore(&p->lock, flags);
+	return ret;
+}
+
+static int ixp4xx_pci_write(struct ixp4xx_pci *p, u32 addr, u32 cmd, u32 data)
+{
+	unsigned long flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&p->lock, flags);
+
+	__raw_writel(addr, p->base + IXP4XX_PCI_NP_AD);
+
+	/* Set up the write */
+	__raw_writel(cmd, p->base + IXP4XX_PCI_NP_CBE);
+
+	/* Execute the write by writing to NP_WDATA */
+	__raw_writel(data, p->base + IXP4XX_PCI_NP_WDATA);
+
+	/* Check for master abort */
+	ret = ixp4xx_pci_check_master_abort(p);
+
+	raw_spin_unlock_irqrestore(&p->lock, flags);
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
+	unsigned long flags;
+	u32 n, cmd, val;
+
+	n = where % 4;
+	cmd = where & ~3;
+
+	dev_dbg(p->dev, "%s from %d size %d cmd %08x\n",
+		__func__, where, size, cmd);
+
+	raw_spin_lock_irqsave(&p->lock, flags);
+	__raw_writel(cmd, p->base + IXP4XX_PCI_CRP_AD_CBE);
+	val = __raw_readl(p->base + IXP4XX_PCI_CRP_RDATA);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
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
+	unsigned long flags;
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
+	raw_spin_lock_irqsave(&p->lock, flags);
+	__raw_writel(cmd, p->base + IXP4XX_PCI_CRP_AD_CBE);
+	__raw_writel(val, p->base + IXP4XX_PCI_CRP_WDATA);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
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
+		__raw_writel(pcimembase, p->base + IXP4XX_PCI_PCIMEMBASE);
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
+		__raw_writel((addr >> 8), p->base + IXP4XX_PCI_AHBIOBASE);
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
+		__raw_writel(ahbmembase, p->base + IXP4XX_PCI_AHBMEMBASE);
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
+	isr = __raw_readl(p->base + IXP4XX_PCI_ISR);
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
+	__raw_writel(IXP4XX_PCI_ISR_PFE, p->base + IXP4XX_PCI_ISR);
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
+static int ixp4xx_pci_probe(struct platform_device *pdev)
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
+	raw_spin_lock_init(&p->lock);
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
+	val = __raw_readl(p->base + IXP4XX_PCI_CSR);
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
+	__raw_writel(val, p->base + IXP4XX_PCI_ISR);
+
+	/*
+	 * Set Initialize Complete in PCI Control Register: allow IXP4XX to
+	 * respond to PCI configuration cycles. Specify that the AHB bus is
+	 * operating in big endian mode. Set up byte lane swapping between
+	 * little-endian PCI and the big-endian AHB bus.
+	 */
+	val = IXP4XX_PCI_CSR_IC | IXP4XX_PCI_CSR_ABE;
+#ifdef __ARMEB__
+	val |= (IXP4XX_PCI_CSR_PDS | IXP4XX_PCI_CSR_ADS);
+#endif
+	__raw_writel(val, p->base + IXP4XX_PCI_CSR);
+
+
+	ret = ixp4xx_crp_write_config(p, PCI_COMMAND, 2, PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
+	if (ret)
+		dev_err(dev, "unable to initialize master and command memory\n");
+	else
+		dev_info(dev, "initialized as master\n");
+
+	ret = pci_scan_root_bus_bridge(host);
+	if (ret) {
+		dev_err(dev, "failed to scan host: %d\n", ret);
+		return ret;
+	}
+
+	p->bus = host->bus;
+
+	pci_bus_assign_resources(p->bus);
+	pci_bus_add_devices(p->bus);
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
+static struct platform_driver ixp4xx_pci_driver = {
+	.driver = {
+		.name = "ixp4xx-pci",
+		.of_match_table = of_match_ptr(ixp4xx_pci_of_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe  = ixp4xx_pci_probe,
+};
+builtin_platform_driver(ixp4xx_pci_driver);
-- 
2.29.2

