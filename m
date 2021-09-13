Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09932409C16
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 20:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbhIMS1Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 14:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239256AbhIMS1W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 14:27:22 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB7E060F9F;
        Mon, 13 Sep 2021 18:26:06 +0000 (UTC)
Received: from [198.52.44.129] (helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mPqeb-00AYPD-1Z; Mon, 13 Sep 2021 19:26:05 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: [PATCH v3 04/10] PCI: apple: Add initial hardware bring-up
Date:   Mon, 13 Sep 2021 19:25:44 +0100
Message-Id: <20210913182550.264165-5-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913182550.264165-1-maz@kernel.org>
References: <20210913182550.264165-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 198.52.44.129
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, Robin.Murphy@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Add a minimal driver to bring up the PCIe bus on Apple system-on-chips,
particularly the Apple M1. This driver exposes the internal bus used for
the USB type-A ports, Ethernet, Wi-Fi, and Bluetooth. Bringing up the
radios requires additional drivers beyond what's necessary for PCIe
itself.

At this stage, nothing is functionnal.

Co-developed-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210816031621.240268-3-alyssa@rosenzweig.io
---
 MAINTAINERS                         |   7 +
 drivers/pci/controller/Kconfig      |  12 ++
 drivers/pci/controller/Makefile     |   1 +
 drivers/pci/controller/pcie-apple.c | 243 ++++++++++++++++++++++++++++
 4 files changed, 263 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-apple.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 813a847e2d64..9905cc48fed9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1280,6 +1280,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
 F:	drivers/iommu/apple-dart.c
 
+APPLE PCIE CONTROLLER DRIVER
+M:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
+M:	Marc Zyngier <maz@kernel.org>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	drivers/pci/controller/pcie-apple.c
+
 APPLE SMC DRIVER
 M:	Henrik Rydberg <rydberg@bitmath.org>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 326f7d13024f..814833a8120d 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -312,6 +312,18 @@ config PCIE_HISI_ERR
 	  Say Y here if you want error handling support
 	  for the PCIe controller's errors on HiSilicon HIP SoCs
 
+config PCIE_APPLE
+	tristate "Apple PCIe controller"
+	depends on ARCH_APPLE || COMPILE_TEST
+	depends on OF
+	depends on PCI_MSI_IRQ_DOMAIN
+	help
+	  Say Y here if you want to enable PCIe controller support on Apple
+	  system-on-chips, like the Apple M1. This is required for the USB
+	  type-A ports, Ethernet, Wi-Fi, and Bluetooth.
+
+	  If unsure, say Y if you have an Apple Silicon system.
+
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/mobiveil/Kconfig"
 source "drivers/pci/controller/cadence/Kconfig"
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index aaf30b3dcc14..f9d40bad932c 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_VMD) += vmd.o
 obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
 obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
 obj-$(CONFIG_PCIE_HISI_ERR) += pcie-hisi-error.o
+obj-$(CONFIG_PCIE_APPLE) += pcie-apple.o
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
 obj-y				+= mobiveil/
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
new file mode 100644
index 000000000000..f3c414950a10
--- /dev/null
+++ b/drivers/pci/controller/pcie-apple.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host bridge driver for Apple system-on-chips.
+ *
+ * The HW is ECAM compliant, so once the controller is initialized,
+ * the driver mostly deals MSI mapping and handling of per-port
+ * interrupts (INTx, management and error signals).
+ *
+ * Initialization requires enabling power and clocks, along with a
+ * number of register pokes.
+ *
+ * Copyright (C) 2021 Alyssa Rosenzweig <alyssa@rosenzweig.io>
+ * Copyright (C) 2021 Google LLC
+ * Copyright (C) 2021 Corellium LLC
+ * Copyright (C) 2021 Mark Kettenis <kettenis@openbsd.org>
+ *
+ * Author: Alyssa Rosenzweig <alyssa@rosenzweig.io>
+ * Author: Marc Zyngier <maz@kernel.org>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/iopoll.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/pci-ecam.h>
+
+#define CORE_RC_PHYIF_CTL		0x00024
+#define   CORE_RC_PHYIF_CTL_RUN		BIT(0)
+#define CORE_RC_PHYIF_STAT		0x00028
+#define   CORE_RC_PHYIF_STAT_REFCLK	BIT(4)
+#define CORE_RC_CTL			0x00050
+#define   CORE_RC_CTL_RUN		BIT(0)
+#define CORE_RC_STAT			0x00058
+#define   CORE_RC_STAT_READY		BIT(0)
+#define CORE_FABRIC_STAT		0x04000
+#define   CORE_FABRIC_STAT_MASK		0x001F001F
+#define CORE_LANE_CFG(port)		(0x84000 + 0x4000 * (port))
+#define   CORE_LANE_CFG_REFCLK0REQ	BIT(0)
+#define   CORE_LANE_CFG_REFCLK1		BIT(1)
+#define   CORE_LANE_CFG_REFCLK0ACK	BIT(2)
+#define   CORE_LANE_CFG_REFCLKEN	(BIT(9) | BIT(10))
+#define CORE_LANE_CTL(port)		(0x84004 + 0x4000 * (port))
+#define   CORE_LANE_CTL_CFGACC		BIT(15)
+
+#define PORT_LTSSMCTL			0x00080
+#define   PORT_LTSSMCTL_START		BIT(0)
+#define PORT_INTSTAT			0x00100
+#define   PORT_INT_TUNNEL_ERR		31
+#define   PORT_INT_CPL_TIMEOUT		23
+#define   PORT_INT_RID2SID_MAPERR	22
+#define   PORT_INT_CPL_ABORT		21
+#define   PORT_INT_MSI_BAD_DATA		19
+#define   PORT_INT_MSI_ERR		18
+#define   PORT_INT_REQADDR_GT32		17
+#define   PORT_INT_AF_TIMEOUT		15
+#define   PORT_INT_LINK_DOWN		14
+#define   PORT_INT_LINK_UP		12
+#define   PORT_INT_LINK_BWMGMT		11
+#define   PORT_INT_AER_MASK		(15 << 4)
+#define   PORT_INT_PORT_ERR		4
+#define   PORT_INT_INTx(i)		i
+#define   PORT_INT_INTx_MASK		15
+#define PORT_INTMSK			0x00104
+#define PORT_INTMSKSET			0x00108
+#define PORT_INTMSKCLR			0x0010c
+#define PORT_MSICFG			0x00124
+#define   PORT_MSICFG_EN		BIT(0)
+#define   PORT_MSICFG_L2MSINUM_SHIFT	4
+#define PORT_MSIBASE			0x00128
+#define   PORT_MSIBASE_1_SHIFT		16
+#define PORT_MSIADDR			0x00168
+#define PORT_LINKSTS			0x00208
+#define   PORT_LINKSTS_UP		BIT(0)
+#define   PORT_LINKSTS_BUSY		BIT(2)
+#define PORT_LINKCMDSTS			0x00210
+#define PORT_OUTS_NPREQS		0x00284
+#define   PORT_OUTS_NPREQS_REQ		BIT(24)
+#define   PORT_OUTS_NPREQS_CPL		BIT(16)
+#define PORT_RXWR_FIFO			0x00288
+#define   PORT_RXWR_FIFO_HDR		GENMASK(15, 10)
+#define   PORT_RXWR_FIFO_DATA		GENMASK(9, 0)
+#define PORT_RXRD_FIFO			0x0028C
+#define   PORT_RXRD_FIFO_REQ		GENMASK(6, 0)
+#define PORT_OUTS_CPLS			0x00290
+#define   PORT_OUTS_CPLS_SHRD		GENMASK(14, 8)
+#define   PORT_OUTS_CPLS_WAIT		GENMASK(6, 0)
+#define PORT_APPCLK			0x00800
+#define   PORT_APPCLK_EN		BIT(0)
+#define   PORT_APPCLK_CGDIS		BIT(8)
+#define PORT_STATUS			0x00804
+#define   PORT_STATUS_READY		BIT(0)
+#define PORT_REFCLK			0x00810
+#define   PORT_REFCLK_EN		BIT(0)
+#define   PORT_REFCLK_CGDIS		BIT(8)
+#define PORT_PERST			0x00814
+#define   PORT_PERST_OFF		BIT(0)
+#define PORT_RID2SID(i16)		(0x00828 + 4 * (i16))
+#define   PORT_RID2SID_VALID		BIT(31)
+#define   PORT_RID2SID_SID_SHIFT	16
+#define   PORT_RID2SID_BUS_SHIFT	8
+#define   PORT_RID2SID_DEV_SHIFT	3
+#define   PORT_RID2SID_FUNC_SHIFT	0
+#define PORT_OUTS_PREQS_HDR		0x00980
+#define   PORT_OUTS_PREQS_HDR_MASK	GENMASK(9, 0)
+#define PORT_OUTS_PREQS_DATA		0x00984
+#define   PORT_OUTS_PREQS_DATA_MASK	GENMASK(15, 0)
+#define PORT_TUNCTRL			0x00988
+#define   PORT_TUNCTRL_PERST_ON		BIT(0)
+#define   PORT_TUNCTRL_PERST_ACK_REQ	BIT(1)
+#define PORT_TUNSTAT			0x0098c
+#define   PORT_TUNSTAT_PERST_ON		BIT(0)
+#define   PORT_TUNSTAT_PERST_ACK_PEND	BIT(1)
+#define PORT_PREFMEM_ENABLE		0x00994
+
+struct apple_pcie {
+	struct device		*dev;
+	void __iomem            *base;
+};
+
+struct apple_pcie_port {
+	struct apple_pcie	*pcie;
+	struct device_node	*np;
+	void __iomem		*base;
+	int			idx;
+};
+
+static inline void rmwl(u32 clr, u32 set, void __iomem *addr)
+{
+	writel_relaxed((readl_relaxed(addr) & ~clr) | set, addr);
+}
+
+static int apple_pcie_setup_port(struct apple_pcie *pcie,
+				 struct device_node *np)
+{
+	struct platform_device *platform = to_platform_device(pcie->dev);
+	struct apple_pcie_port *port;
+	struct gpio_desc *reset;
+	u32 stat, idx;
+	int ret;
+
+	reset = gpiod_get_from_of_node(np, "reset-gpios", 0,
+				       GPIOD_OUT_LOW, "#PERST");
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	port = devm_kzalloc(pcie->dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_index(np, "reg", 0, &idx);
+	if (ret)
+		return ret;
+
+	/* Use the first reg entry to work out the port index */
+	port->idx = idx >> 11;
+	port->pcie = pcie;
+	port->np = np;
+
+	port->base = devm_platform_ioremap_resource(platform, port->idx + 2);
+	if (IS_ERR(port->base))
+		return -ENODEV;
+
+	rmwl(0, PORT_APPCLK_EN, port + PORT_APPCLK);
+
+	rmwl(0, PORT_PERST_OFF, port->base + PORT_PERST);
+	gpiod_set_value(reset, 1);
+
+	ret = readl_relaxed_poll_timeout(port->base + PORT_STATUS, stat,
+					 stat & PORT_STATUS_READY, 100, 250000);
+	if (ret < 0) {
+		dev_err(pcie->dev, "port %pOF ready wait timeout\n", np);
+		return ret;
+	}
+
+	/* Flush writes and enable the link */
+	dma_wmb();
+
+	writel_relaxed(PORT_LTSSMCTL_START, port->base + PORT_LTSSMCTL);
+
+	return 0;
+}
+
+static int apple_pcie_init(struct pci_config_window *cfg)
+{
+	struct device *dev = cfg->parent;
+	struct platform_device *platform = to_platform_device(dev);
+	struct device_node *of_port;
+	struct apple_pcie *pcie;
+	int ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->dev = dev;
+
+	mutex_init(&pcie->lock);
+
+	pcie->base = devm_platform_ioremap_resource(platform, 1);
+
+	if (IS_ERR(pcie->base))
+		return -ENODEV;
+
+	for_each_child_of_node(dev->of_node, of_port) {
+		ret = apple_pcie_setup_port(pcie, of_port);
+		if (ret) {
+			dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct pci_ecam_ops apple_pcie_cfg_ecam_ops = {
+	.init		= apple_pcie_init,
+	.pci_ops	= {
+		.map_bus	= pci_ecam_map_bus,
+		.read		= pci_generic_config_read,
+		.write		= pci_generic_config_write,
+	}
+};
+
+static const struct of_device_id apple_pcie_of_match[] = {
+	{ .compatible = "apple,pcie", .data = &apple_pcie_cfg_ecam_ops },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, apple_pcie_of_match);
+
+static struct platform_driver apple_pcie_driver = {
+	.probe	= pci_host_common_probe,
+	.driver	= {
+		.name			= "pcie-apple",
+		.of_match_table		= apple_pcie_of_match,
+		.suppress_bind_attrs	= true,
+	},
+};
+module_platform_driver(apple_pcie_driver);
+
+MODULE_LICENSE("GPL v2");
-- 
2.30.2

