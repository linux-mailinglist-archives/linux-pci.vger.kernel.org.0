Return-Path: <linux-pci+bounces-41514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B50C6A831
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 17:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49EFF35DC61
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3DB36A004;
	Tue, 18 Nov 2025 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iiziEQ2P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981B36CDFB
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481784; cv=none; b=h9Q1QD0KQzJuLwAYuw/Q8sLUgjwSIhiyrVKYvpuhtGKUQxxzzZNgZN0V64l2jRLuMkFPZIyHSCorhPxQfoWOxG7KHBbkplq8riC2AdXWyyjwReWQGBaRSATmnWr/GJNZc7yn1QZi+sQe6ofewV4uw862yBnPx3SPjTSSKmaS1Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481784; c=relaxed/simple;
	bh=jRZFD8mOgui7WOATBjTTiBKqtzXEHQ67D0YMS9otKxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cN98bs6f9w0uig49W/IaxKt0RGyt+iDNrWYG8aK2sNQNIgO5D6v6oHBiMK54asr+HEsvLSXxzQhFLRskvwXE6DmN5pwUAMCriaLJgTw0nmXPCWlJS+pvgcAZMVfVcxhEYDPxydpD/BlGGVOFzYM+p9xip+M7paOujuECZphcqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iiziEQ2P; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477a1c28778so30813945e9.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 08:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763481780; x=1764086580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbUXnWJiMgu3Cjju37fWmgqS2Nw7wZk0yffLxoWu3P8=;
        b=iiziEQ2PMt/tg2X9TylC42ecIIeZnLcdyTsD0Mt29BSv3LNgRPkXpCASEinlhdTIml
         OQp9eDyGEAmjwIHOmUleVxqKdzzIk21pulubNcLvxyjvwH9nePMSXKLf6/WDc7pPu4Zl
         RcyNU2puDT0iD76jSw49z06nkpWoCAZUJVe/dJsS0nFs9KjlRhiX9LyDi3BUItznv0R4
         MvPLKAErPMCOTyPj1+ZAnQ/F6x5Eb2ioGVTpQtpxWg4Ypb+WmAok7VDQbrZIGJFWNjaF
         9lg8c/Sa21e4oCOOcB//AvMZSJlTnbUd0WTuE4x0ravVL5c8pLK+zGjpoGKWUE/fu/qi
         h8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763481780; x=1764086580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EbUXnWJiMgu3Cjju37fWmgqS2Nw7wZk0yffLxoWu3P8=;
        b=H745JsVXkC0kZ3CRi2MADKqazqRGiXI0HUaLMMH76yN3WspcesTkrQNpylM/fk1uuq
         z2e3QcbQgFM3v9lhTP+MV3UUTVyxQWRpeel+X5RYgjAu5U5kZRz5H7bo++UWkFY9ZOxj
         T3PRLpFTkSckm9vMS2mvOSSB2VSC03EAsXqHt1fJJ3FYUos7hNo2zdt2SC6PfaZ8HfxI
         bBr0SB7etvDnTdMaehjO4HZIZfcyZXK3mYTzFwNomIGr+nWCYZ+W0VdmVxjgJGFjyo/T
         /CECl/9SUgTFWLUOs5v5jGyGG0QnKFp3SPehBp5E4TNOx21yqm2+XM4R/LJicLJpJcZ9
         OB5g==
X-Forwarded-Encrypted: i=1; AJvYcCX8+PWcN8MvK59vFdnvuiCptZdtwtE03U7Mna1J+KguKXU0m7yPztw0tKbkJ3nMPgQ7uKsugZYVZlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6U1nfTaTB2Pngnr+RLs12i1seuEDh3J3TDwm6e4beJg9Sdh1
	Lly0wU/TopVVXe19cJ76ks6ikmRoF4/JfGX5/fk2wxYhFwFesURglWPLqqYpkc5KVaE=
X-Gm-Gg: ASbGnctCBfuD1I9eiXKCXg5B6I6inHXfVyfyEnMd6CBvWsB1gfiYVXyfQG5AM3Xkskb
	goL+XFvZG8OzmRz7tFcx120IPj+ob9Vnr4IzTwlZxvmgbXnaLf4i+1twOpxbZzzmlY/0lGB3FKp
	G2RCQx/58UheuhoqqJNN6drWffyzyjTWBzL68w5lRPz/o+fzRjhGmNpMiWY3tknJLpW5HWv+A0W
	ez+CGfyI/tjS8J3ajzP3u3++6gMzzhmvv6Y3/6+QkWnUJHBvGcIKH6LU1nx/yZTa3BYDBOG2Gf5
	LMdz+xCXZCtB29zBvvYz7LDZ18nL8UZlYeSmYjvAqwAs+5WmTm6P4JezOGLJtrgmtp4hhBkjG4x
	RP3ZwUnG2/Io7ud7pgrujFqK+n0J3Vzgl8Sodi2t7fcJmHwq0+Ijt0F1XrfUwd8tlKgYeMKh1XO
	AZ5oWqskAGO0jjla2I8kAhuKyMCiDd+A==
X-Google-Smtp-Source: AGHT+IEOBFhSvsd6R+GN4SrXaQZQxvUFQpzHkQT09I9M4b2MWgROdMDgN+AFRcEiEMeNDCt1yB3EXg==
X-Received: by 2002:a05:600c:5703:b0:477:9fcf:3fe3 with SMTP id 5b1f17b1804b1-4779fcf4706mr69121415e9.0.1763481779475;
        Tue, 18 Nov 2025 08:02:59 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:76db:cf5c:2806:ec0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779fc42f25sm171954575e9.6.2025.11.18.08.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:02:56 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 3/4 v5] PCI: s32g: Add initial PCIe support (RC)
Date: Tue, 18 Nov 2025 17:02:37 +0100
Message-ID: <20251118160238.26265-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118160238.26265-1-vincent.guittot@linaro.org>
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support of the PCIe controller for S32G Soc family. Only
host mode is supported.

Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../pci/controller/dwc/pcie-nxp-s32g-regs.h   |  21 +
 drivers/pci/controller/dwc/pcie-nxp-s32g.c    | 391 ++++++++++++++++++
 4 files changed, 423 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
 create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 349d4657393c..e276956c3fca 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -256,6 +256,16 @@ config PCIE_TEGRA194_EP
 	  in order to enable device-specific features PCIE_TEGRA194_EP must be
 	  selected. This uses the DesignWare core.
 
+config PCIE_NXP_S32G
+	tristate "NXP S32G PCIe controller (host mode)"
+	depends on ARCH_S32 || COMPILE_TEST
+	select PCIE_DW_HOST
+	help
+	  Enable support for the PCIe controller in NXP S32G based boards to
+	  work in Host mode. The controller is based on DesignWare IP and
+	  can work either as RC or EP. In order to enable host-specific
+	  features PCIE_NXP_S32G must be selected.
+
 config PCIE_DW_PLAT
 	bool
 
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 7ae28f3b0fb3..3301bbbad78c 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
+obj-$(CONFIG_PCIE_NXP_S32G) += pcie-nxp-s32g.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
new file mode 100644
index 000000000000..81e35b6227d1
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2015-2016 Freescale Semiconductor, Inc.
+ * Copyright 2016-2023, 2025 NXP
+ */
+
+#ifndef PCIE_S32G_REGS_H
+#define PCIE_S32G_REGS_H
+
+/* PCIe controller Sub-System */
+
+/* PCIe controller 0 General Control 1 */
+#define PCIE_S32G_PE0_GEN_CTRL_1		0x50
+#define DEVICE_TYPE_MASK			GENMASK(3, 0)
+#define SRIS_MODE				BIT(8)
+
+/* PCIe controller 0 General Control 3 */
+#define PCIE_S32G_PE0_GEN_CTRL_3		0x58
+#define LTSSM_EN				BIT(0)
+
+#endif  /* PCI_S32G_REGS_H */
diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
new file mode 100644
index 000000000000..eaa6b5363afe
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for NXP S32G SoCs
+ *
+ * Copyright 2019-2025 NXP
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/memblock.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/pci.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+#include "pcie-designware.h"
+#include "pcie-nxp-s32g-regs.h"
+
+struct s32g_pcie_port {
+	struct list_head list;
+	struct phy *phy;
+};
+
+struct s32g_pcie {
+	struct dw_pcie	pci;
+	void __iomem *ctrl_base;
+	struct list_head ports;
+};
+
+#define to_s32g_from_dw_pcie(x) \
+	container_of(x, struct s32g_pcie, pci)
+
+static void s32g_pcie_writel_ctrl(struct s32g_pcie *s32g_pp, u32 reg, u32 val)
+{
+	writel(val, s32g_pp->ctrl_base + reg);
+}
+
+static u32 s32g_pcie_readl_ctrl(struct s32g_pcie *s32g_pp, u32 reg)
+{
+	return readl(s32g_pp->ctrl_base + reg);
+}
+
+static void s32g_pcie_enable_ltssm(struct s32g_pcie *s32g_pp)
+{
+	u32 reg;
+
+	reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3);
+	reg |= LTSSM_EN;
+	s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3, reg);
+}
+
+static void s32g_pcie_disable_ltssm(struct s32g_pcie *s32g_pp)
+{
+	u32 reg;
+
+	reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3);
+	reg &= ~LTSSM_EN;
+	s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3, reg);
+}
+
+static int s32g_pcie_start_link(struct dw_pcie *pci)
+{
+	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
+
+	s32g_pcie_enable_ltssm(s32g_pp);
+
+	return 0;
+}
+
+static void s32g_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
+
+	s32g_pcie_disable_ltssm(s32g_pp);
+}
+
+static struct dw_pcie_ops s32g_pcie_ops = {
+	.start_link = s32g_pcie_start_link,
+	.stop_link = s32g_pcie_stop_link,
+};
+
+/* Configure the AMBA AXI Coherency Extensions (ACE) interface */
+static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci, u64 ddr_base_addr)
+{
+	u32 ddr_base_low = lower_32_bits(ddr_base_addr);
+	u32 ddr_base_high = upper_32_bits(ddr_base_addr);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, 0x0);
+
+	/*
+	 * Ncore is a cache-coherent interconnect module that enables the
+	 * integration of heterogeneous coherent and non-coherent agents in
+	 * the chip. Ncore Transactions to peripheral should be non-coherent
+	 * or it might drop them.
+	 *
+	 * One example where this is needed are PCIe MSIs, which use NoSnoop=0
+	 * and might end up routed to Ncore.
+	 * Define the start of DDR as seen by Linux as the boundary between
+	 * "memory" and "peripherals", with peripherals being below.
+	 */
+	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_1_OFF,
+			   (ddr_base_low & CFG_MEMTYPE_BOUNDARY_LOW_ADDR_MASK));
+	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_2_OFF, ddr_base_high);
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
+static int s32g_init_pcie_controller(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
+	u32 val;
+
+	/* Set RP mode */
+	val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1);
+	val &= ~DEVICE_TYPE_MASK;
+	val |= FIELD_PREP(DEVICE_TYPE_MASK, PCI_EXP_TYPE_ROOT_PORT);
+
+	/* Use default CRNS */
+	val &= ~SRIS_MODE;
+
+	s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1, val);
+
+	/*
+	 * Make sure we use the coherency defaults (just in case the settings
+	 * have been changed from their reset values)
+	 */
+	s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
+	val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
+	dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
+
+	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	val |= GEN3_RELATED_OFF_EQ_PHASE_2_3;
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops s32g_pcie_host_ops = {
+	.init = s32g_init_pcie_controller,
+};
+
+static int s32g_init_pcie_phy(struct s32g_pcie *s32g_pp)
+{
+	struct dw_pcie *pci = &s32g_pp->pci;
+	struct device *dev = pci->dev;
+	struct s32g_pcie_port *port, *tmp;
+	int ret;
+
+	list_for_each_entry(port, &s32g_pp->ports, list) {
+		ret = phy_init(port->phy);
+		if (ret) {
+			dev_err(dev, "Failed to init serdes PHY\n");
+			goto err_phy_revert;
+		}
+
+		ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, 0);
+		if (ret) {
+			dev_err(dev, "Failed to set mode on serdes PHY\n");
+			goto err_phy_exit;
+		}
+
+		ret = phy_power_on(port->phy);
+		if (ret) {
+			dev_err(dev, "Failed to power on serdes PHY\n");
+			goto err_phy_exit;
+		}
+	}
+
+	return 0;
+
+err_phy_exit:
+	phy_exit(port->phy);
+
+err_phy_revert:
+	list_for_each_entry_continue_reverse(port, &s32g_pp->ports, list) {
+		phy_power_off(port->phy);
+		phy_exit(port->phy);
+	}
+
+	list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
+		list_del(&port->list);
+
+	return ret;
+}
+
+static void s32g_deinit_pcie_phy(struct s32g_pcie *s32g_pp)
+{
+	struct s32g_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list) {
+		phy_power_off(port->phy);
+		phy_exit(port->phy);
+		list_del(&port->list);
+	}
+}
+
+static int s32g_pcie_init(struct device *dev, struct s32g_pcie *s32g_pp)
+{
+	int ret;
+
+	s32g_pcie_disable_ltssm(s32g_pp);
+
+	ret = s32g_init_pcie_phy(s32g_pp);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void s32g_pcie_deinit(struct s32g_pcie *s32g_pp)
+{
+	s32g_pcie_disable_ltssm(s32g_pp);
+
+	s32g_deinit_pcie_phy(s32g_pp);
+}
+
+static int s32g_pcie_parse_port(struct s32g_pcie *s32g_pp, struct device_node *node)
+{
+	struct device *dev = s32g_pp->pci.dev;
+	struct s32g_pcie_port *port;
+	int num_lanes;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->phy = devm_of_phy_get(dev, node, NULL);
+	if (IS_ERR(port->phy))
+		return dev_err_probe(dev, PTR_ERR(port->phy),
+				"Failed to get serdes PHY\n");
+
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &s32g_pp->ports);
+
+	/*
+	 * The DWC core initialization code cannot parse yet the num-lanes
+	 * attribute in the Root Port node. The S32G only supports one Root
+	 * Port for now so its driver can parse the node and set the num_lanes
+	 * field of struct dwc_pcie before calling dw_pcie_host_init().
+	 */
+	if (!of_property_read_u32(node, "num-lanes", &num_lanes))
+		s32g_pp->pci.num_lanes = num_lanes;
+
+	return 0;
+}
+
+static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie *s32g_pp)
+{
+	struct s32g_pcie_port *port, *tmp;
+	int ret = -ENOENT;
+
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		if (!of_node_is_type(of_port, "pci"))
+			continue;
+
+		ret = s32g_pcie_parse_port(s32g_pp, of_port);
+		if (ret)
+			goto err_port;
+	}
+
+err_port:
+	list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
+		list_del(&port->list);
+
+	return ret;
+}
+
+static int s32g_pcie_get_resources(struct platform_device *pdev,
+				   struct s32g_pcie *s32g_pp)
+{
+	struct dw_pcie *pci = &s32g_pp->pci;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	pci->dev = dev;
+	pci->ops = &s32g_pcie_ops;
+
+	s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
+	if (IS_ERR(s32g_pp->ctrl_base))
+		return PTR_ERR(s32g_pp->ctrl_base);
+
+	INIT_LIST_HEAD(&s32g_pp->ports);
+
+	ret = s32g_pcie_parse_ports(dev, s32g_pp);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				"Failed to parse Root Port: %d\n", ret);
+
+	platform_set_drvdata(pdev, s32g_pp);
+
+	return 0;
+}
+
+static int s32g_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct s32g_pcie *s32g_pp;
+	struct dw_pcie_rp *pp;
+	int ret;
+
+	s32g_pp = devm_kzalloc(dev, sizeof(*s32g_pp), GFP_KERNEL);
+	if (!s32g_pp)
+		return -ENOMEM;
+
+	ret = s32g_pcie_get_resources(pdev, s32g_pp);
+	if (ret)
+		return ret;
+
+	pm_runtime_no_callbacks(dev);
+	devm_pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		goto err_pm_runtime_put;
+
+	ret = s32g_pcie_init(dev, s32g_pp);
+	if (ret)
+		goto err_pm_runtime_put;
+
+	pp = &s32g_pp->pci.pp;
+	pp->ops = &s32g_pcie_host_ops;
+	pp->use_atu_msg = true;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret)
+		goto err_pcie_deinit;
+
+	return 0;
+
+err_pcie_deinit:
+	s32g_pcie_deinit(s32g_pp);
+err_pm_runtime_put:
+	pm_runtime_put(dev);
+
+	return ret;
+}
+
+static int s32g_pcie_suspend_noirq(struct device *dev)
+{
+	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &s32g_pp->pci;
+
+	return dw_pcie_suspend_noirq(pci);
+}
+
+static int s32g_pcie_resume_noirq(struct device *dev)
+{
+	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &s32g_pp->pci;
+
+	return dw_pcie_resume_noirq(pci);
+}
+
+static const struct dev_pm_ops s32g_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(s32g_pcie_suspend_noirq,
+				  s32g_pcie_resume_noirq)
+};
+
+static const struct of_device_id s32g_pcie_of_match[] = {
+	{ .compatible = "nxp,s32g2-pcie" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, s32g_pcie_of_match);
+
+static struct platform_driver s32g_pcie_driver = {
+	.driver = {
+		.name	= "s32g-pcie",
+		.of_match_table = s32g_pcie_of_match,
+		.suppress_bind_attrs = true,
+		.pm = pm_sleep_ptr(&s32g_pcie_pm_ops),
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe = s32g_pcie_probe,
+};
+
+module_platform_driver(s32g_pcie_driver);
+
+MODULE_AUTHOR("Ionut Vicovan <Ionut.Vicovan@nxp.com>");
+MODULE_DESCRIPTION("NXP S32G PCIe Host controller driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


