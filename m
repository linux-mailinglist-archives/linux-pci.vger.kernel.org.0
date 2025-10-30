Return-Path: <linux-pci+bounces-39859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA0DC22802
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 23:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69D944F054F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF1313267;
	Thu, 30 Oct 2025 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="oMNt4pbE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA1338F24
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861796; cv=none; b=GlVl23rqbPYYmUf78U9XiTdOOYZItpiEvsEMsDDosgrivmrhQ8dAr69D5COTELqyv50II5OJnSM3GBqYnHXCI6KXFRascCmEg4czEDDOoIstCvkwM5+7TNhSXA0WzAnyG/F/a5K19z+XlBrkJe3CeE1xVYyBtXOA3ZsUg3JEc7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861796; c=relaxed/simple;
	bh=CGaZD/WBB2T/3LnUfyJ17UZIVhNw4ZOgsLpSDiP2i7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCFeTOJmVf+Zsracc9Sbym1lTBxCK8Z7yt27vIcCfAuoXyM+e9Y1pvPeCRnEX6DnXnoyc2s1gUbvOo6eD6nZfo1CEyYQeYiPCIBIftJiRXkxhsJR/z0jEhz2ivbLWt2KPSAebR/9IcW48Z8C1z9j6VLoNkb1YWnjalwKE2Q/t6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=oMNt4pbE; arc=none smtp.client-ip=209.85.166.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f67.google.com with SMTP id ca18e2360f4ac-94359aa7f60so146747039f.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 15:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761861794; x=1762466594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAx7l7dPI5UwyX/WQhhRToXfZd8zxlPEGfF1MIyC1ps=;
        b=oMNt4pbEygvh/Qu/kwPTtrOtdATxViqllKZz7d4rMB68VSQ+Fdkpf5h/bso6KaC7OO
         QjpAjCSrpd380uq7/g4GjrHd9Q6FSbeBHn69Gsi7cs3tjg6vX9iCzfRtzuWVSecbAPXb
         XGlpap9Da2ZzaH82ZFzPZYehQBLj7koBn5Vm5AtMOG+Oqj73J8BMB/9BmC6P8pXD5xT4
         KynrwYYpHmCT4EpYet53Qkv2MvM8eAdUq8zNLfvIRaekBD5y5o6IZIpOupjsGb04uSpl
         43R8qN39RPPO0bNDvpfM4+V5IVVwn8KJE15ChrPq9X+YwnveDD5zRH3PB+XdW4RtS7YC
         cbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861794; x=1762466594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAx7l7dPI5UwyX/WQhhRToXfZd8zxlPEGfF1MIyC1ps=;
        b=lwznPRakMo/v437jvfY+nbHVLZ3czpPKyDeEPsCGcg5O5gbLx8CZyhO7hoR2SCbZC3
         cZqdZ3s94gitaSWT9Bkac37BxzXXXa1zSMZj+awjvkMtUpTs3/7OqWXxzncM83bQv32U
         CweNATHSm59a0Y2EqR36MhhLxpFmrFO5ApcA/Bb/sJ5LKQPR2zqFhuasS6kK9upn7k05
         eD0OlheY3XrsRbyUNbX94adb0nIwin2nVYpJeFHNUXyKDyzpmOGmJ37A96V0ngaAh6tQ
         qJ6bayF4E1LVQx+Va8jhDQEP5r/AaoAgK67wolTJJpDwLE3tkDYE8Tfjh/ClAq2tmafo
         mVZg==
X-Forwarded-Encrypted: i=1; AJvYcCU/4BrWA+AzRcGwRPQG/UatEn1jRfAP9Bnk5bIfmcMU7sOUZACEhNRj+r3A5LQf1gUHRKAP6Xc/L6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL63ZpaMHRY3TUmYExLfF6yFvXYv0ISHzFOD22uLmDWduJuZ/Q
	ONel6XhnJN9S3xUBFLenViLLx5vkSOytn+Ehf/rycu+zBaM1SfYacs3KHrEtFTXmSiQ=
X-Gm-Gg: ASbGncs0CyRvRSmfN2eDqYA7HWb/7TH5ZL9VGKwGPEZ9zN5ndCUokeuTjFPtVnMpocN
	yeGOIOUCoz1kOtnOsfbPbSKHIsiW/VbbYUzESVFdlPsXu1xsuTfNa6EkYwIpF0IAhYSSOZ4nSrb
	vjYjQLQyWN2UiL7DqgAiWuW9atF2lWULVc23UMWnC6rsWf9jdITxRS0CpHXJuYKHEI1Ukz5GMHo
	ptkAkKxc4UdAxEkbkUoxPh6Q6Sjor74K1+mvFmQNmohUW2ylva7HBs8tr4kdy/Rtsxw28E+nk/F
	Oq82xebxoi0aTmi7/mRzOnmY5AquoaNr5ubNXZ+ZqXB/daUPdL09oFNdyP99SzK8tcqyQiVlLh/
	yzVcNI05lWbs8ARLK29wC5NC1Ds3iQ/JCVUNZsER+q/GrZA9gv/tLn4hUx91V2Y+TsDzqR+txps
	KdpngEWbuOyC4UiMHZRQ9UEd/4Vut/8YfysJySiDEnCck=
X-Google-Smtp-Source: AGHT+IH3mrpSCASAAv+ytz8l+GuuoAA0fcqRsAbcd/UlN8UygraNHmbh0FJvZAokaZklT4YGVqqHfQ==
X-Received: by 2002:a05:6602:14ca:b0:924:2696:a53 with SMTP id ca18e2360f4ac-948228f5ecamr268126239f.3.1761861793573;
        Thu, 30 Oct 2025 15:03:13 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359efe149sm604118039f.13.2025.10.30.15.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:03:12 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: dlan@gentoo.org,
	aurelien@aurel32.net,
	johannes@erdfelt.com,
	p.zabel@pengutronix.de,
	christian.bruel@foss.st.com,
	thippeswamy.havalige@amd.com,
	krishna.chundru@oss.qualcomm.com,
	mayank.rana@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com,
	shradha.t@samsung.com,
	inochiama@gmail.com,
	guodong@riscstar.com,
	linux-pci@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] PCI: spacemit: introduce SpacemiT PCIe host driver
Date: Thu, 30 Oct 2025 17:02:56 -0500
Message-ID: <20251030220259.1063792-6-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030220259.1063792-1-elder@riscstar.com>
References: <20251030220259.1063792-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a driver for the PCIe host controller found in the SpacemiT
K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
The driver supports three PCIe ports that operate at PCIe gen2 transfer
rates (5 GT/sec).  The first port uses a combo PHY, which may be
configured for use for USB 3 instead.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 349 ++++++++++++++++++
 3 files changed, 361 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-spacemit-k1.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 349d4657393c9..d229260f0337e 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -509,6 +509,17 @@ config PCI_KEYSTONE_EP
 	  on DesignWare hardware and therefore the driver re-uses the
 	  DesignWare core functions to implement the driver.
 
+config PCIE_SPACEMIT_K1
+	tristate "SpacemiT K1 PCIe controller (host mode)"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	depends on PCI && OF && HAS_IOMEM
+	select PCIE_DW_HOST
+	select PCI_PWRCTRL_SLOT
+	default ARCH_SPACEMIT
+	help
+	  Enables support for the PCIe controller in the K1 SoC operating
+	  in host mode.
+
 config PCIE_VISCONTI_HOST
 	bool "Toshiba Visconti PCIe controller"
 	depends on ARCH_VISCONTI || COMPILE_TEST
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 7ae28f3b0fb39..662b0a219ddc4 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
 obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
+obj-$(CONFIG_PCIE_SPACEMIT_K1) += pcie-spacemit-k1.o
 obj-$(CONFIG_PCIE_STM32_HOST) += pcie-stm32.o
 obj-$(CONFIG_PCIE_STM32_EP) += pcie-stm32-ep.o
 
diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
new file mode 100644
index 0000000000000..2efb92ef948f2
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SpacemiT K1 PCIe host driver
+ *
+ * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
+ * Copyright (c) 2023, spacemit Corporation.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/types.h>
+
+#include "pcie-designware.h"
+
+#define PCI_VENDOR_ID_SPACEMIT		0x201f
+#define PCI_DEVICE_ID_SPACEMIT_K1	0x0001
+
+/* Offsets and field definitions for link management registers */
+#define K1_PHY_AHB_IRQ_EN			0x0000
+#define PCIE_INTERRUPT_EN		BIT(0)
+
+#define K1_PHY_AHB_LINK_STS			0x0004
+#define SMLH_LINK_UP			BIT(1)
+#define RDLH_LINK_UP			BIT(12)
+
+#define INTR_ENABLE				0x0014
+#define MSI_CTRL_INT			BIT(11)
+
+/* Some controls require APMU regmap access */
+#define SYSCON_APMU			"spacemit,apmu"
+
+/* Offsets and field definitions for APMU registers */
+#define PCIE_CLK_RESET_CONTROL			0x0000
+#define LTSSM_EN			BIT(6)
+#define PCIE_AUX_PWR_DET		BIT(9)
+#define PCIE_RC_PERST			BIT(12)	/* 1: assert PERST# */
+#define APP_HOLD_PHY_RST		BIT(30)
+#define DEVICE_TYPE_RC			BIT(31)	/* 0: endpoint; 1: RC */
+
+#define PCIE_CONTROL_LOGIC			0x0004
+#define PCIE_SOFT_RESET			BIT(0)
+
+struct k1_pcie {
+	struct dw_pcie pci;
+	struct phy *phy;
+	void __iomem *link;
+	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
+	u32 pmu_off;
+};
+
+#define to_k1_pcie(dw_pcie) \
+		platform_get_drvdata(to_platform_device((dw_pcie)->dev))
+
+static void k1_pcie_toggle_soft_reset(struct k1_pcie *k1)
+{
+	u32 offset;
+	u32 val;
+
+	/*
+	 * Write, then read back to guarantee it has reached the device
+	 * before we start the delay.
+	 */
+	offset = k1->pmu_off + PCIE_CONTROL_LOGIC;
+	regmap_set_bits(k1->pmu, offset, PCIE_SOFT_RESET);
+	regmap_read(k1->pmu, offset, &val);
+
+	mdelay(2);
+
+	regmap_clear_bits(k1->pmu, offset, PCIE_SOFT_RESET);
+}
+
+/* Enable app clocks, deassert resets */
+static int k1_pcie_enable_resources(struct k1_pcie *k1)
+{
+	struct dw_pcie *pci = &k1->pci;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(pci->app_clks), pci->app_clks);
+	if (ret)
+		return ret;
+
+	ret = reset_control_bulk_deassert(ARRAY_SIZE(pci->app_rsts),
+					  pci->app_rsts);
+	if (ret)
+		goto err_disable_clks;
+
+	return 0;
+
+err_disable_clks:
+	clk_bulk_disable_unprepare(ARRAY_SIZE(pci->app_clks), pci->app_clks);
+
+	return ret;
+}
+
+/* Assert resets, disable app clocks */
+static void k1_pcie_disable_resources(struct k1_pcie *k1)
+{
+	struct dw_pcie *pci = &k1->pci;
+
+	reset_control_bulk_assert(ARRAY_SIZE(pci->app_rsts), pci->app_rsts);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(pci->app_clks), pci->app_clks);
+}
+
+static int k1_pcie_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct k1_pcie *k1 = to_k1_pcie(pci);
+	u32 offset;
+	u32 mask;
+	u32 val;
+	int ret;
+
+	k1_pcie_toggle_soft_reset(k1);
+
+	ret = k1_pcie_enable_resources(k1);
+	if (ret)
+		return ret;
+
+	ret = phy_init(k1->phy);
+	if (ret) {
+		k1_pcie_disable_resources(k1);
+
+		return ret;
+	}
+
+	/* Set the PCI vendor and device ID */
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
+	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_SPACEMIT_K1);
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	/*
+	 * Assert fundamental reset (drive PERST# low).  Put the controller
+	 * in root complex mode, and indicate that Vaux (3.3v) is present.
+	 */
+	mask = PCIE_RC_PERST;
+	mask |= DEVICE_TYPE_RC | PCIE_AUX_PWR_DET;
+
+	/*
+	 * Write, then read back to guarantee it has reached the device
+	 * before we start the delay.
+	 */
+	offset = k1->pmu_off + PCIE_CLK_RESET_CONTROL;
+	regmap_set_bits(k1->pmu, offset, mask);
+	regmap_read(k1->pmu, offset, &val);
+
+	mdelay(PCIE_T_PVPERL_MS);
+
+	/* Deassert fundamental reset (drive PERST# high) */
+	regmap_clear_bits(k1->pmu, offset, PCIE_RC_PERST);
+
+	return 0;
+}
+
+/* Disable ASPM L1 for now, until reported errors can be reproduced */
+static void k1_pcie_post_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	u8 offset;
+	u32 val;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	/* Turn off ASPM L1 for the link */
+	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
+	val &= ~PCI_EXP_LNKCAP_ASPM_L1;
+	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
+static void k1_pcie_deinit(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct k1_pcie *k1 = to_k1_pcie(pci);
+
+	/* Assert fundamental reset (drive PERST# low) */
+	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
+			PCIE_RC_PERST);
+
+	phy_exit(k1->phy);
+
+	k1_pcie_disable_resources(k1);
+}
+
+static const struct dw_pcie_host_ops k1_pcie_host_ops = {
+	.init		= k1_pcie_init,
+	.post_init	= k1_pcie_post_init,
+	.deinit		= k1_pcie_deinit,
+};
+
+static bool k1_pcie_link_up(struct dw_pcie *pci)
+{
+	struct k1_pcie *k1 = to_k1_pcie(pci);
+	u32 val;
+
+	val = readl_relaxed(k1->link + K1_PHY_AHB_LINK_STS);
+
+	return (val & RDLH_LINK_UP) && (val & SMLH_LINK_UP);
+}
+
+static int k1_pcie_start_link(struct dw_pcie *pci)
+{
+	struct k1_pcie *k1 = to_k1_pcie(pci);
+	u32 val;
+
+	/* Stop holding the PHY in reset, and enable link training */
+	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
+			   APP_HOLD_PHY_RST | LTSSM_EN, LTSSM_EN);
+
+	/* Enable the MSI interrupt */
+	writel_relaxed(MSI_CTRL_INT, k1->link + INTR_ENABLE);
+
+	/* Top-level interrupt enable */
+	val = readl_relaxed(k1->link + K1_PHY_AHB_IRQ_EN);
+	val |= PCIE_INTERRUPT_EN;
+	writel_relaxed(val, k1->link + K1_PHY_AHB_IRQ_EN);
+
+	return 0;
+}
+
+static void k1_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct k1_pcie *k1 = to_k1_pcie(pci);
+	u32 val;
+
+	/* Disable interrupts */
+	val = readl_relaxed(k1->link + K1_PHY_AHB_IRQ_EN);
+	val &= ~PCIE_INTERRUPT_EN;
+	writel_relaxed(val, k1->link + K1_PHY_AHB_IRQ_EN);
+
+	writel_relaxed(0, k1->link + INTR_ENABLE);
+
+	/* Disable the link and hold the PHY in reset */
+	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
+			   APP_HOLD_PHY_RST | LTSSM_EN, APP_HOLD_PHY_RST);
+}
+
+static const struct dw_pcie_ops k1_pcie_ops = {
+	.link_up	= k1_pcie_link_up,
+	.start_link	= k1_pcie_start_link,
+	.stop_link	= k1_pcie_stop_link,
+};
+
+static int k1_pcie_parse_port(struct k1_pcie *k1)
+{
+	struct device *dev = k1->pci.dev;
+	struct device_node *root_port;
+	struct phy *phy;
+
+	/* We assume only one root port */
+	root_port = of_get_next_available_child(dev_of_node(dev), NULL);
+	if (!root_port)
+		return -EINVAL;
+
+	phy = devm_of_phy_get(dev, root_port, NULL);
+
+	of_node_put(root_port);
+
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	k1->phy = phy;
+
+	return 0;
+}
+
+static int k1_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct k1_pcie *k1;
+	int ret;
+
+	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
+	if (!k1)
+		return -ENOMEM;
+
+	k1->pmu = syscon_regmap_lookup_by_phandle_args(dev_of_node(dev),
+						       SYSCON_APMU, 1,
+						       &k1->pmu_off);
+	if (IS_ERR(k1->pmu))
+		return dev_err_probe(dev, PTR_ERR(k1->pmu),
+				     "failed to lookup PMU registers\n");
+
+	k1->link = devm_platform_ioremap_resource_byname(pdev, "link");
+	if (!k1->link)
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to map \"link\" registers\n");
+
+	k1->pci.dev = dev;
+	k1->pci.ops = &k1_pcie_ops;
+	dw_pcie_cap_set(&k1->pci, REQ_RES);
+
+	k1->pci.pp.ops = &k1_pcie_host_ops;
+
+	/* Hold the PHY in reset until we start the link */
+	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
+			APP_HOLD_PHY_RST);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_no_callbacks(dev);
+	devm_pm_runtime_enable(dev);
+
+	platform_set_drvdata(pdev, k1);
+
+	ret = k1_pcie_parse_port(k1);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to parse root port\n");
+
+	ret = dw_pcie_host_init(&k1->pci.pp);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize host\n");
+
+	return 0;
+}
+
+static void k1_pcie_remove(struct platform_device *pdev)
+{
+	struct k1_pcie *k1 = platform_get_drvdata(pdev);
+
+	dw_pcie_host_deinit(&k1->pci.pp);
+}
+
+static const struct of_device_id k1_pcie_of_match_table[] = {
+	{ .compatible = "spacemit,k1-pcie", },
+	{ },
+};
+
+static struct platform_driver k1_pcie_driver = {
+	.probe	= k1_pcie_probe,
+	.remove	= k1_pcie_remove,
+	.driver = {
+		.name			= "spacemit-k1-pcie",
+		.of_match_table		= k1_pcie_of_match_table,
+		.probe_type		= PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_platform_driver(k1_pcie_driver);
-- 
2.48.1


