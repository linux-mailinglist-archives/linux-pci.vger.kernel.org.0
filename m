Return-Path: <linux-pci+bounces-41193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3343DC5A341
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 22:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DBBA353E64
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 21:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4867C325705;
	Thu, 13 Nov 2025 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kONDiLhT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731F1326939
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070358; cv=none; b=J/v7KD1l53nhicW9Agc/Lpm1qr+Brs93Kw8GE0Sp48U7pE0ult8dbFrLnhRHNqWTDytQl032vpy8TpgTwtXqbSxpcRtgFh1KWE2i1vMr6S8PutYwsdHrsrtoidWNoyA8Ck8/IwHoglN9rITZ47sloZvf00U+eWVYWYRz8M/OW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070358; c=relaxed/simple;
	bh=dmttAo+Jemguo+z64TFi9xk7TLfeTE44rROL+Uf68BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+RAy9IIv9Xpm2VSQ6PAQtClNXpEd+ykoWgwR99Ucz7hzk1Os+EydLkdAWDXCs3QDcnDD5SLLhjclvl3pbUl9nO7buJKmC8WjGl+qBq/hM1T+yvL0MUVW8gja62amG8E6GLwkFTBugsuzJWj6xoJ+yIxZwkGiBCpB3tmV3Bhpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kONDiLhT; arc=none smtp.client-ip=209.85.166.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f194.google.com with SMTP id e9e14a558f8ab-43377ee4825so7334745ab.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 13:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1763070354; x=1763675154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHK8zPr6d0GmFSaiLzIgkmN/zTwMi8I5yquyjriCdgc=;
        b=kONDiLhTluJOV4V5R/Ep71qCBtmLA9mMWZnXCEuWVuGDjknw7q0bLLm1EK0Qs1rIXH
         QSpLGPCblAt7fAyGU+JXBJifIFGawh1Swd6/SR1mxMfYIBiu8SJAhbFwHNaVIEuhz+s5
         bBMtaa6fuAEdubBmVAsjBolATg6sczgwtZZlX03dnRsDtj2ONOAqQr9rvJUBgWXr6NqX
         FDz4bjOZIIXtmyv4GZvJVnkxI1WZ8ypdpJYAh5iaqM4hnUc+eaf6IgjmaPa+bXvkXSzj
         h27fzVmcE1RLfCTceqX8n72kivHHNETCIlaGAXNdWpNUBxI5DwstI2EV/0Sc8po0IGvu
         D8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763070354; x=1763675154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KHK8zPr6d0GmFSaiLzIgkmN/zTwMi8I5yquyjriCdgc=;
        b=qlqwTmiYFGrz3GefKrZ1btwD2+pjQtuJCVNwxwjy5MGByB/ycTh6Y2cXWdPKv7YeIe
         9s2V5mX7milVuKN/jF2v+IiDT7vwQzakkYjlChhcGT5S7CUyKA3DMzFwLHGEBIUq2ode
         ZICeHgiRkkHfRjvNDTbt14OmIWhdC/bAc5nxYJUD8IK7T34vdudpUrR/CJjdgxo54D0y
         LdJ4Rm1zlp+hvXBj80l44o0ISZ0g5so91dqNUCDBxBPIfw0maPsG2SYuW6yOWkRJKpVp
         XNlscBm3e7Ai4zQElkVkPBy/AHtpXHJKb/ahlPmaV1oPqcgCQytuFCIcbwleobdHu3if
         qm0A==
X-Forwarded-Encrypted: i=1; AJvYcCU0yIRKdXhJzZ2nagZpEnY98OOMbp3aSKP5opM5Lligdjp5bxwbWIApLOJ94q0OH/t2PCkQseqSpm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4OwFcqzTSiXBB9fNjoSiqTYF/7GmIseztG2XGDUo/uK1qGMm
	5rzhWb0Ix0pWDVpDxA5lH/b4UTlfx1NHSqxYSDfyLvn6EBJMk2247kDIsZQbikI0dIw=
X-Gm-Gg: ASbGncsPyEUIHgumuU2I0eEdmU+DYgM0rgfSh86FVK/SuwGvpI58//cSdmuwx4S6WJ8
	U/COfu89uhtI0bm7cnfF70G1vi2z4dmfig+PCwaMYIscT2SSyXyGp8X1YEL4JyQbdqR21dFa7q7
	o7M8tlMJTbAAdfIlTw1rL0cWzu1g16LBHDXJ0qlmlo7y3C/KU9LXDLc7kfhMvXOdhAcyoveQZCo
	jwKrmXz2uW1QYMlfj71taeemXfLNokagRxX0UEUCXJIM5MYa+5H3alKDe6DfPBRO2wKP6+jxqnS
	LrwEGC2aQiUbk6E7nCNQDzpmp8upmS0hB4tYwN2Vbf3iYmO4S3KyXoV7/emtxPtmIn1TBC0fzWZ
	oCLtunC+xhijLUXuG8AaF5BzHUbm4NbT2BEu55lQ9sHUHggEex6iZiqRq28YnaLtZkIPYBUUxpu
	oop2nfd4YKwddpuXXLPUD/5j4Anawx3Jd4FG/rTiBIS3PitiaK+g6kuQ==
X-Google-Smtp-Source: AGHT+IFl4CpymPkt5vmQxCdNn8nKwjZaGBs4cxdbPCn8PzMUOAsPh052vrqTvmxUyL9S/rllocpFOg==
X-Received: by 2002:a05:6e02:3c86:b0:433:7b22:c2bd with SMTP id e9e14a558f8ab-4348c864268mr17350665ab.2.1763070354464;
        Thu, 13 Nov 2025 13:45:54 -0800 (PST)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434839a4ac7sm10877115ab.25.2025.11.13.13.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 13:45:53 -0800 (PST)
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
Subject: [PATCH v6 5/7] PCI: spacemit: Add SpacemiT PCIe host driver
Date: Thu, 13 Nov 2025 15:45:37 -0600
Message-ID: <20251113214540.2623070-6-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251113214540.2623070-1-elder@riscstar.com>
References: <20251113214540.2623070-1-elder@riscstar.com>
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
v6: - Disabling ASPM L1 is now done earlier, at the end of the
      dw_pcie_host_ops->init callback rather than ->post_init
    - The function that disables ASPM L1 has been moved an renamed
      to be k1_pcie_disable_aspm_l1()
    - The return value from devm_platform_ioremap_resource_byname()
      is now checked with IS_ERR()
    - The number of MSI vectors implemented 256, rather than the default
    - The sentinel entry in the OF match table no longer includes
      a trailing comma
    - MODULE_LICENSE() and MODULE_DESCRIPTION() macros are now
      included

 drivers/pci/controller/dwc/Kconfig            |  13 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 358 ++++++++++++++++++
 3 files changed, 372 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-spacemit-k1.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 349d4657393c9..718bb54e943f6 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -416,6 +416,19 @@ config PCIE_SOPHGO_DW
 	  Say Y here if you want PCIe host controller support on
 	  Sophgo SoCs.
 
+config PCIE_SPACEMIT_K1
+	tristate "SpacemiT K1 PCIe controller (host mode)"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	depends on HAS_IOMEM
+	select PCIE_DW_HOST
+	select PCI_PWRCTRL_SLOT
+	default ARCH_SPACEMIT
+	help
+	  Enables support for the DesignWare based PCIe controller in
+	  the SpacemiT K1 SoC operating in host mode.  Three controllers
+	  are available on the K1 SoC; the first of these shares a PHY
+	  with a USB 3.0 host controller (one or the other can be used).
+
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
 	depends on ARCH_SPEAR13XX || COMPILE_TEST
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
index 0000000000000..451febfa326b7
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -0,0 +1,358 @@
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
+/* Disable ASPM L1 to avoid errors reported on some NVMe drives */
+static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
+{
+	struct dw_pcie *pci = &k1->pci;
+	u8 offset;
+	u32 val;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset += PCI_EXP_LNKCAP;
+
+	/* Turn off ASPM L1 for the link */
+	dw_pcie_dbi_ro_wr_en(pci);
+	val = dw_pcie_readl_dbi(pci, offset);
+	val &= ~PCI_EXP_LNKCAP_ASPM_L1;
+	dw_pcie_writel_dbi(pci, offset, val);
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
+static int k1_pcie_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct k1_pcie *k1 = to_k1_pcie(pci);
+	u32 reset_ctrl;
+	u32 val;
+	int ret;
+
+	k1_pcie_toggle_soft_reset(k1);
+
+	ret = k1_pcie_enable_resources(k1);
+	if (ret)
+		return ret;
+
+	/* Set the PCI vendor and device ID */
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
+	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_SPACEMIT_K1);
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	/*
+	 * Start by asserting fundamental reset (drive PERST# low).  The
+	 * PCI CEM spec says that PERST# should be deasserted at least
+	 * 100ms after the power becomes stable, so we'll insert that
+	 * delay first.  Write, then read it back to guarantee the write
+	 * reaches the device before we start the delay.
+	 */
+	reset_ctrl = k1->pmu_off + PCIE_CLK_RESET_CONTROL;
+	regmap_set_bits(k1->pmu, reset_ctrl, PCIE_RC_PERST);
+	regmap_read(k1->pmu, reset_ctrl, &val);
+	mdelay(PCIE_T_PVPERL_MS);
+
+	/*
+	 * Put the controller in root complex mode, and indicate that
+	 * Vaux (3.3v) is present.
+	 */
+	regmap_set_bits(k1->pmu, reset_ctrl, DEVICE_TYPE_RC | PCIE_AUX_PWR_DET);
+
+	ret = phy_init(k1->phy);
+	if (ret) {
+		k1_pcie_disable_resources(k1);
+
+		return ret;
+	}
+
+	/* Deassert fundamental reset (drive PERST# high) */
+	regmap_clear_bits(k1->pmu, reset_ctrl, PCIE_RC_PERST);
+
+	/* Finally, as a workaround, disable ASPM L1 */
+	k1_pcie_disable_aspm_l1(k1);
+
+	return 0;
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
+	if (IS_ERR(k1->link))
+		return dev_err_probe(dev, PTR_ERR(k1->link),
+				     "failed to map \"link\" registers\n");
+
+	k1->pci.dev = dev;
+	k1->pci.ops = &k1_pcie_ops;
+	k1->pci.pp.num_vectors = MAX_MSI_IRQS;
+	dw_pcie_cap_set(&k1->pci, REQ_RES);
+
+	k1->pci.pp.ops = &k1_pcie_host_ops;
+
+	/* Hold the PHY in reset until we start the link */
+	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
+			APP_HOLD_PHY_RST);
+
+	ret = devm_regulator_get_enable(dev, "vpcie3v3");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get \"vpcie3v3\" supply\n");
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
+	{ }
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
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SpacemiT K1 PCIe host driver");
-- 
2.48.1


