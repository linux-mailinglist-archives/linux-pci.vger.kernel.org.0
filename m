Return-Path: <linux-pci+bounces-28661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC627AC7F22
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 15:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B08B9E8655
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65AD1C84C0;
	Thu, 29 May 2025 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Na0URufs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D75022B8B8
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748526571; cv=none; b=BhZn1s7GDOD5UQTHtGD1oFPjV82Q2w3eC29nB6HgbFZCo0OWq5sE361nVs485TpmFwmYkyS0vSBf2B/656/COqgHaVCRGTWUDXixHzhIifzxeW2kDfgrkQXUSxBGoM65Yd9eY4eseONlMy1NTqp7PIpcsO6Pzo77y0OmvdKKBFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748526571; c=relaxed/simple;
	bh=y8jDVpq7LKUQ9CqcGPPQ2e5Mg8kcJ25fyvqOhRg3bOU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLl9VF8dJ2sehPjg2GQQdA0J4HH/TGNFbvQiX4eMLjJOiQ5cPUJOx7YsZBZ7mayw0OtvsW7DndVj5UQqwG8Ty4U91o2KCssxMghDti4Kjn2irnYMyGDvOj6QmWsrpM1HAd9TYBz/gSfDFI7oOuX8tfMibbCSR0Pr3V56tmu2WYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Na0URufs; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so134409366b.2
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 06:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748526564; x=1749131364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wj8QgbsxJRL0MftbkSgKJ3blHGMJQkJTy40CcLwRbFg=;
        b=Na0URufsze62LG7bk1CyzMtO+53SIrFaBrQ2y6/tLWdzmo//rpRgwuQu0gRRV2SyaE
         KLZLW6D1HTpzZ689YyX8cNpcSo1AhW6aKBrAORW3Cp2gcYhj7h4NExq1tpDVuHslS+UN
         VZK+eF+mwZyb8zJQK59SxvPCcm5dalc28ag3wPQMdIYpODZ+DYembneVQZ30Y+2dTGXM
         zhB1uJdmAtX+GjLfv989L0vTUVMoqjH2K6588lc+t5TXi8ljyzryqICXPsc2D1OswcyA
         ESXJHduhecpomS84dK9v/M5TtpgBReNax52p4GilTnvebYy/UMmm+Y/j2WvSZsK+S4tr
         82lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748526564; x=1749131364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wj8QgbsxJRL0MftbkSgKJ3blHGMJQkJTy40CcLwRbFg=;
        b=Bmek95iuS7nL23THl/S4mfZpnX7e95iqB8FWoeX2JDyxp4CzASPtzoGrtMAkyU8GqI
         BuKAQqtJOlQQQUUNKNgZyjdI/jLym3PAHpId0DFjQ6aGO857/kQfxy49QRZkou8W4WiX
         F8vWPFRFQFBWD6VZ9AUdVngUgmWEuxdlaeqbn/YeYnSLOYP/ghKjn78gWow//Tei008h
         GoZ5tDH8Z/OJFAskbKmQYTtVbRnfrgqXzokSjXCbp+6sgG7SvZ3TeABKetGjeTKNAOOa
         4ZwDP5/Z50gFv2yD6iF7Ot9IFzWhxd8d54kiF3xRTrn83y/gCqkStNcFONC5lRd1CKB2
         51Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUIJLEmSwxIxp8kjktugRncFCda0z1svqjYcQITixizXlnaSD13ja7NfJ1GSQQrLLSl2ocJ5G6kJ6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1apZ0BkZzmS1gEa2WyhGwogj9DXRX2bOOCDVGUaAtFWHu6Ssx
	Ov825pqHWh4ZEKVmpOoeRJRUeIBzqJI1wPwIYIyo5DxfkSIvPHHV25MEjpLGaYrKl6U=
X-Gm-Gg: ASbGncuSI/iACTTALgJvQ+M5KD/ROJIvESFha19nt1qwEmW+3R8+fHEMDa0kagcwj83
	TxJ7NjGSmvASt3nmEJ9hNZWlIF6uMUEp75c4NA/QHilmX24Ep6mHnLuhl0aIJbx+AHbAEQGw0Sz
	NWcn5/TDjlWyuySzAKXorT+Tx0XpRSoYnqglbqbcwOejxOCKKMAJyqjcYeySn4teLcVgvObutuy
	SbRlOpcVWOjMQHuULlOZSrB3QGzd0ees3L9VoGQb7+isYxeFYBDes6v63tfrbnf4Vln6B5LBxuE
	dcytUFR2RQ8r2GC9X7EI6/r0znTqEQUnPuKi2m53uL93sVwoteU7FGbYpDM53cMCpjKUJkODCY6
	8PKmBCiYXT1VRFEi+VHKXgg==
X-Google-Smtp-Source: AGHT+IHHIIgPCZ2G2XXmjouay347WxnFCikrezM11ZRIjgNE/4yZdwYBj4DJfxwpeOIRVUNFy9Htgg==
X-Received: by 2002:a17:907:9611:b0:ac3:3e40:e183 with SMTP id a640c23a62f3a-adacda55ce4mr222397166b.3.1748526564312;
        Thu, 29 May 2025 06:49:24 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fed8bsm147541366b.28.2025.05.29.06.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 06:49:23 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com,
	Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v12 07/13] misc: rp1: RaspberryPi RP1 misc driver
Date: Thu, 29 May 2025 15:50:44 +0200
Message-ID: <20250529135052.28398-7-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1748526284.git.andrea.porta@suse.com>
References: <cover.1748526284.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RaspberryPi RP1 is a PCI multi function device containing
peripherals ranging from Ethernet to USB controller, I2C, SPI
and others.

Implement a bare minimum driver to operate the RP1, leveraging
actual OF based driver implementations for the on-board peripherals
by loading a devicetree overlay during driver probe if the RP1
node is not already present in the DT.

The peripherals are accessed by mapping MMIO registers starting
from PCI BAR1 region.

With the overlay approach we can achieve more generic and agnostic
approach to managing this chipset, being that it is a PCI endpoint
and could possibly be reused in other hw implementations. The
presented approach is also used by Bootlin's Microchip LAN966x
patchset (see link) as well, for a similar chipset.
In this case, the inclusion tree for the DT overlay is as follow
(the arrow points to the includer):

 rp1-pci.dtso <---- rp1-common.dtsi

On the other hand, to ensure compatibility with downstream, this
driver can also work with a DT already comprising the RP1 node, so
the dynamically loaded overlay will not be used if the DT is already
fully defined.

The reason why this driver is contained in drivers/misc has
been paved by Bootlin's LAN966X driver, which first used the
overlay approach to implement non discoverable peripherals behind a
PCI bus. For RP1, the same arguments apply: it's not used as an SoC
since the driver code is not running on-chip and is not like an MFD
since it does not really need all the MFD infrastructure (shared regs,
etc.). So, for this particular use, misc has been proposed and deemed
as a good choice. For further details about that please check the links.

This driver is heavily based on downstream code from RaspberryPi
Foundation, and the original author is Phil Elwell.

Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
Link: https://lore.kernel.org/all/20240612140208.GC1504919@google.com/
Link: https://lore.kernel.org/all/83f7fa09-d0e6-4f36-a27d-cee08979be2a@app.fastmail.com/
Link: https://lore.kernel.org/all/2024081356-mutable-everyday-6f9d@gregkh/
Link: https://lore.kernel.org/all/20240808154658.247873-1-herve.codina@bootlin.com/

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>   # quirks.c, pci_ids.h
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/Kconfig          |   1 +
 drivers/misc/Makefile         |   1 +
 drivers/misc/rp1/Kconfig      |  20 ++
 drivers/misc/rp1/Makefile     |   3 +
 drivers/misc/rp1/rp1-pci.dtso |  25 +++
 drivers/misc/rp1/rp1_pci.c    | 333 ++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c          |   1 +
 include/linux/pci_ids.h       |   3 +
 8 files changed, 387 insertions(+)
 create mode 100644 drivers/misc/rp1/Kconfig
 create mode 100644 drivers/misc/rp1/Makefile
 create mode 100644 drivers/misc/rp1/rp1-pci.dtso
 create mode 100644 drivers/misc/rp1/rp1_pci.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6b37d61150ee..3b9606bb4ccc 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -648,4 +648,5 @@ source "drivers/misc/uacce/Kconfig"
 source "drivers/misc/pvpanic/Kconfig"
 source "drivers/misc/mchp_pci1xxxx/Kconfig"
 source "drivers/misc/keba/Kconfig"
+source "drivers/misc/rp1/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d6c917229c45..e15a732de690 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -74,3 +74,4 @@ lan966x-pci-objs		:= lan966x_pci.o
 lan966x-pci-objs		+= lan966x_pci.dtbo.o
 obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
 obj-y				+= keba/
+obj-$(CONFIG_MISC_RP1)		+= rp1/
diff --git a/drivers/misc/rp1/Kconfig b/drivers/misc/rp1/Kconfig
new file mode 100644
index 000000000000..5232e70d3079
--- /dev/null
+++ b/drivers/misc/rp1/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# RaspberryPi RP1 misc device
+#
+
+config MISC_RP1
+	tristate "RaspberryPi RP1 misc device"
+	depends on OF_IRQ && OF_OVERLAY && PCI_MSI && PCI_QUIRKS
+	select PCI_DYNAMIC_OF_NODES
+	help
+	  Support the RP1 peripheral chip found on Raspberry Pi 5 board.
+
+	  This device supports several sub-devices including e.g. Ethernet
+	  controller, USB controller, I2C, SPI and UART.
+
+	  The driver is responsible for enabling the DT node once the PCIe
+	  endpoint has been configured, and handling interrupts.
+
+	  This driver uses an overlay to load other drivers to support for
+	  RP1 internal sub-devices.
diff --git a/drivers/misc/rp1/Makefile b/drivers/misc/rp1/Makefile
new file mode 100644
index 000000000000..508b4cb05627
--- /dev/null
+++ b/drivers/misc/rp1/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_MISC_RP1)		+= rp1-pci.o
+rp1-pci-objs			:= rp1_pci.o rp1-pci.dtbo.o
diff --git a/drivers/misc/rp1/rp1-pci.dtso b/drivers/misc/rp1/rp1-pci.dtso
new file mode 100644
index 000000000000..eea826b36e02
--- /dev/null
+++ b/drivers/misc/rp1/rp1-pci.dtso
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/*
+ * The dts overlay is included from the dts directory so
+ * it can be possible to check it with CHECK_DTBS while
+ * also compile it from the driver source directory.
+ */
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target-path="";
+		__overlay__ {
+			compatible = "pci1de4,1";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			#include "arm64/broadcom/rp1-common.dtsi"
+		};
+	};
+};
diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
new file mode 100644
index 000000000000..803832006ec8
--- /dev/null
+++ b/drivers/misc/rp1/rp1_pci.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2025 Raspberry Pi Ltd.
+ *
+ * All rights reserved.
+ */
+
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+#define RP1_HW_IRQ_MASK		GENMASK(5, 0)
+
+#define REG_SET			0x800
+#define REG_CLR			0xc00
+
+/* MSI-X CFG registers start at 0x8 */
+#define MSIX_CFG(x) (0x8 + (4 * (x)))
+
+#define MSIX_CFG_IACK_EN        BIT(3)
+#define MSIX_CFG_IACK           BIT(2)
+#define MSIX_CFG_ENABLE         BIT(0)
+
+/* Address map */
+#define RP1_PCIE_APBS_BASE	0x108000
+
+/* Interrupts */
+#define RP1_INT_END		61
+
+/* Embedded dtbo symbols created by cmd_wrap_S_dtb in scripts/Makefile.lib */
+extern char __dtbo_rp1_pci_begin[];
+extern char __dtbo_rp1_pci_end[];
+
+struct rp1_dev {
+	struct pci_dev *pdev;
+	struct irq_domain *domain;
+	struct irq_data *pcie_irqds[64];
+	void __iomem *bar1;
+	int ovcs_id;	/* overlay changeset id */
+	bool level_triggered_irq[RP1_INT_END];
+};
+
+static void msix_cfg_set(struct rp1_dev *rp1, unsigned int hwirq, u32 value)
+{
+	iowrite32(value, rp1->bar1 + RP1_PCIE_APBS_BASE + REG_SET + MSIX_CFG(hwirq));
+}
+
+static void msix_cfg_clr(struct rp1_dev *rp1, unsigned int hwirq, u32 value)
+{
+	iowrite32(value, rp1->bar1 + RP1_PCIE_APBS_BASE + REG_CLR + MSIX_CFG(hwirq));
+}
+
+static void rp1_mask_irq(struct irq_data *irqd)
+{
+	struct rp1_dev *rp1 = irqd->domain->host_data;
+	struct irq_data *pcie_irqd = rp1->pcie_irqds[irqd->hwirq];
+
+	pci_msi_mask_irq(pcie_irqd);
+}
+
+static void rp1_unmask_irq(struct irq_data *irqd)
+{
+	struct rp1_dev *rp1 = irqd->domain->host_data;
+	struct irq_data *pcie_irqd = rp1->pcie_irqds[irqd->hwirq];
+
+	pci_msi_unmask_irq(pcie_irqd);
+}
+
+static int rp1_irq_set_type(struct irq_data *irqd, unsigned int type)
+{
+	struct rp1_dev *rp1 = irqd->domain->host_data;
+	unsigned int hwirq = (unsigned int)irqd->hwirq;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		dev_dbg(&rp1->pdev->dev, "MSIX IACK EN for IRQ %u\n", hwirq);
+		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK_EN);
+		rp1->level_triggered_irq[hwirq] = true;
+	break;
+	case IRQ_TYPE_EDGE_RISING:
+		msix_cfg_clr(rp1, hwirq, MSIX_CFG_IACK_EN);
+		rp1->level_triggered_irq[hwirq] = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct irq_chip rp1_irq_chip = {
+	.name		= "rp1_irq_chip",
+	.irq_mask	= rp1_mask_irq,
+	.irq_unmask	= rp1_unmask_irq,
+	.irq_set_type	= rp1_irq_set_type,
+};
+
+static void rp1_chained_handle_irq(struct irq_desc *desc)
+{
+	unsigned int hwirq = desc->irq_data.hwirq & RP1_HW_IRQ_MASK;
+	struct rp1_dev *rp1 = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int virq;
+
+	chained_irq_enter(chip, desc);
+
+	virq = irq_find_mapping(rp1->domain, hwirq);
+	generic_handle_irq(virq);
+	if (rp1->level_triggered_irq[hwirq])
+		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK);
+
+	chained_irq_exit(chip, desc);
+}
+
+static int rp1_irq_xlate(struct irq_domain *d, struct device_node *node,
+			 const u32 *intspec, unsigned int intsize,
+			 unsigned long *out_hwirq, unsigned int *out_type)
+{
+	struct rp1_dev *rp1 = d->host_data;
+	struct irq_data *pcie_irqd;
+	unsigned long hwirq;
+	int pcie_irq;
+	int ret;
+
+	ret = irq_domain_xlate_twocell(d, node, intspec, intsize,
+				       &hwirq, out_type);
+	if (ret)
+		return ret;
+
+	pcie_irq = pci_irq_vector(rp1->pdev, hwirq);
+	pcie_irqd = irq_get_irq_data(pcie_irq);
+	rp1->pcie_irqds[hwirq] = pcie_irqd;
+	*out_hwirq = hwirq;
+
+	return 0;
+}
+
+static int rp1_irq_activate(struct irq_domain *d, struct irq_data *irqd,
+			    bool reserve)
+{
+	struct rp1_dev *rp1 = d->host_data;
+
+	msix_cfg_set(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_ENABLE);
+
+	return 0;
+}
+
+static void rp1_irq_deactivate(struct irq_domain *d, struct irq_data *irqd)
+{
+	struct rp1_dev *rp1 = d->host_data;
+
+	msix_cfg_clr(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_ENABLE);
+}
+
+static const struct irq_domain_ops rp1_domain_ops = {
+	.xlate      = rp1_irq_xlate,
+	.activate   = rp1_irq_activate,
+	.deactivate = rp1_irq_deactivate,
+};
+
+static void rp1_unregister_interrupts(struct pci_dev *pdev)
+{
+	struct rp1_dev *rp1 = pci_get_drvdata(pdev);
+	int irq, i;
+
+	if (rp1->domain) {
+		for (i = 0; i < RP1_INT_END; i++) {
+			irq = irq_find_mapping(rp1->domain, i);
+			irq_dispose_mapping(irq);
+		}
+
+		irq_domain_remove(rp1->domain);
+	}
+
+	pci_free_irq_vectors(pdev);
+}
+
+static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	u32 dtbo_size = __dtbo_rp1_pci_end - __dtbo_rp1_pci_begin;
+	void *dtbo_start = __dtbo_rp1_pci_begin;
+	struct device *dev = &pdev->dev;
+	struct device_node *rp1_node;
+	bool skip_ovl = true;
+	struct rp1_dev *rp1;
+	int err = 0;
+	int i;
+
+	/*
+	 * Either use rp1_nexus node if already present in DT, or
+	 * set a flag to load it from overlay at runtime
+	 */
+	rp1_node = of_find_node_by_name(NULL, "rp1_nexus");
+	if (!rp1_node) {
+		rp1_node = dev_of_node(dev);
+		skip_ovl = false;
+	}
+
+	if (!rp1_node) {
+		dev_err(dev, "Missing of_node for device\n");
+		err = -EINVAL;
+		goto err_put_node;
+	}
+
+	rp1 = devm_kzalloc(&pdev->dev, sizeof(*rp1), GFP_KERNEL);
+	if (!rp1) {
+		err = -ENOMEM;
+		goto err_put_node;
+	}
+
+	rp1->pdev = pdev;
+
+	if (pci_resource_len(pdev, 1) <= 0x10000) {
+		dev_err(&pdev->dev,
+			"Not initialized - is the firmware running?\n");
+		err = -EINVAL;
+		goto err_put_node;
+	}
+
+	err = pcim_enable_device(pdev);
+	if (err < 0) {
+		err = dev_err_probe(&pdev->dev, err,
+				    "Enabling PCI device has failed");
+		goto err_put_node;
+	}
+
+	rp1->bar1 = pcim_iomap(pdev, 1, 0);
+	if (!rp1->bar1) {
+		dev_err(&pdev->dev, "Cannot map PCI BAR\n");
+		err = -EIO;
+		goto err_put_node;
+	}
+
+	pci_set_master(pdev);
+
+	err = pci_alloc_irq_vectors(pdev, RP1_INT_END, RP1_INT_END,
+				    PCI_IRQ_MSIX);
+	if (err < 0) {
+		err = dev_err_probe(&pdev->dev, err,
+				    "Failed to allocate MSI-X vectors\n");
+		goto err_put_node;
+	} else if (err != RP1_INT_END) {
+		dev_err(&pdev->dev, "Cannot allocate enough interrupts\n");
+		err = -EINVAL;
+		goto err_put_node;
+	}
+
+	pci_set_drvdata(pdev, rp1);
+	rp1->domain = irq_domain_add_linear(rp1_node, RP1_INT_END,
+					    &rp1_domain_ops, rp1);
+	if (!rp1->domain) {
+		dev_err(&pdev->dev, "Error creating IRQ domain\n");
+		err = -ENOMEM;
+		goto err_unregister_interrupts;
+	}
+
+	for (i = 0; i < RP1_INT_END; i++) {
+		unsigned int irq = irq_create_mapping(rp1->domain, i);
+
+		if (!irq) {
+			dev_err(&pdev->dev, "Failed to create IRQ mapping\n");
+			err = -EINVAL;
+			goto err_unregister_interrupts;
+		}
+
+		irq_set_chip_and_handler(irq, &rp1_irq_chip, handle_level_irq);
+		irq_set_probe(irq);
+		irq_set_chained_handler_and_data(pci_irq_vector(pdev, i),
+						 rp1_chained_handle_irq, rp1);
+	}
+
+	if (!skip_ovl) {
+		err = of_overlay_fdt_apply(dtbo_start, dtbo_size, &rp1->ovcs_id,
+					   rp1_node);
+		if (err)
+			goto err_unregister_interrupts;
+	}
+
+	err = of_platform_default_populate(rp1_node, NULL, dev);
+	if (err) {
+		dev_err_probe(&pdev->dev, err, "Error populating devicetree\n");
+		goto err_unload_overlay;
+	}
+
+	return 0;
+
+err_unload_overlay:
+	of_overlay_remove(&rp1->ovcs_id);
+err_unregister_interrupts:
+	rp1_unregister_interrupts(pdev);
+err_put_node:
+	if (skip_ovl)
+		of_node_put(rp1_node);
+
+	return err;
+}
+
+static void rp1_remove(struct pci_dev *pdev)
+{
+	struct rp1_dev *rp1 = pci_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	of_platform_depopulate(dev);
+	of_overlay_remove(&rp1->ovcs_id);
+	rp1_unregister_interrupts(pdev);
+}
+
+static const struct pci_device_id dev_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RPI_RP1_C0), },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, dev_id_table);
+
+static struct pci_driver rp1_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= dev_id_table,
+	.probe		= rp1_probe,
+	.remove		= rp1_remove,
+};
+
+module_pci_driver(rp1_driver);
+
+MODULE_AUTHOR("Phil Elwell <phil@raspberrypi.com>");
+MODULE_AUTHOR("Andrea della Porta <andrea.porta@suse.com>");
+MODULE_DESCRIPTION("RaspberryPi RP1 misc device");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8d610c17e0f2..dad0ca42707f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6284,6 +6284,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RPI_RP1_C0, of_pci_make_dev_node);
 
 /*
  * Devices known to require a longer delay before first config space access
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2e28182c3af0..ddfe09722d54 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2624,6 +2624,9 @@
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
+#define PCI_VENDOR_ID_RPI		0x1de4
+#define PCI_DEVICE_ID_RPI_RP1_C0	0x0001
+
 #define PCI_VENDOR_ID_ALIBABA		0x1ded
 
 #define PCI_VENDOR_ID_CXL		0x1e98
-- 
2.35.3


