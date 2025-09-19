Return-Path: <linux-pci+bounces-36513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C7BB8A75B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3601C82765
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338832039B;
	Fri, 19 Sep 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojsbzo0M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F333831FEF2
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297512; cv=none; b=R3jt0Sf+oO1CS2JMuJWBlwDc4L7zlk5Gc4rouHS6zz0OgdrQ6K8yNFo36Teior7szY7SgiXh2gfP76FurzsArPNK2HcuOncq4rhJVG4leRKREav561B6lPR8q63QPxm5FHJAKHHSQZVF2Be8YdyhnmqJ3eXuMiRdqaAFnMzLLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297512; c=relaxed/simple;
	bh=Uq+idK4eUm97Cd8JEOcmbeS0FsDH9XX5vvLzmPemTHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSyesYqhYlfrDUFpQf2BoEvHvBjrfD3xW1f5Ss9s0IBpiNGhhQHgSWmRyvxVH2je6Fk04L9wJpSasnvdQR417/KdqHYcsqlDr2yKdMyywkWUrLa9jV4Egzn3xVKe2CkIj5l9DffR0bHVRbIdZ2ZfGgnEinTMGz6VbhGa1U6qZ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ojsbzo0M; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ef166e625aso766045f8f.2
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 08:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758297507; x=1758902307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y47VMV8Z5C1ATtLA8CUEakdHLqOjzgpxH7XOKYffT7Y=;
        b=ojsbzo0MRRXqz3x4GuVtgjkOICBMSBnGFV02MTCDDSdZEtDf5se0m0zJ7y97D2W3Du
         w8efoEBE3wAmqArf7+IclSq5Krot/bHaSElNJx+v8lzb9APumZfNbMO2g3RFu2a+cAyr
         3PdPCGBj1JUoDTaeKDoQHISkLi78aGjiQS4u8vzGeeQAz3bc8dsklHsoIZ292zeGZrDR
         Gy+s/7I25dMt433tN6cRTcY1+4w0CpHxMZQs3ky6xQKr1aY8380P9qFIi7UxFTN+yVdf
         r0uhSDsQBAIgOZfAYkF2k6bvNPGkqdmLNWFpG+DiaMBEKW+Q24aopiHmjZNoW230s2ch
         4UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297507; x=1758902307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y47VMV8Z5C1ATtLA8CUEakdHLqOjzgpxH7XOKYffT7Y=;
        b=qjgFKk/6BcDHxEWQz9u5QYOje98fRKyoejD4DXFNiRKtIi4xIU7k3+H2IkDWObzALM
         2G27ddVrHFg4Fq/oJwG7Rpza7ByEfgLK1sxZv1GwVIxc25OubjZvnrbxupvux/ugsxx9
         RUFTvCg6vpWwJUZNkFL4AG6lpZqjced1AFPrEwdFaS1Xh+zqPgb4oHW85FAX16AJDMeY
         GowNtZzRGj1TIPvM/UzJR4/IXKVQUQTJPG3daNSbtx3ZtH7KScyJGHI7QUA5TFYpQt/z
         k1bfLJoe66HO4bic4O0K0Obu/ze7me9EA+RSJKObsvIv8UMTGmf6kgjHcKgL3g0HSH93
         qP2A==
X-Forwarded-Encrypted: i=1; AJvYcCXptdqyw+s4nZpc4wXDVz1ddNzwT4BepRgo9eFutAUNsPR9jDRhmrEpcHlqERCYaLWoKT9OhIPbvA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI8XDxsE5qE/RlQMEdqkSYiWSh98hv9YkswxuaRVxx5j7IINB1
	xLfZxw1tABwbELwIQb1cKRnircFYFrYG/XO8z3Fjxq4vEV40uD0vbQEdHPCBFUgpmd0=
X-Gm-Gg: ASbGncu10PyD9Pgmh7346tRATfuvwiwLiZKyKkvSIq+ERVTeX8Y8oxE1eFjOMSEAkxQ
	ixbs8eiwaZ1TeUkYZqizmdVVuavJkuMyeHTPIJrNt6nPP67zD4+tLo+WvCOHR7PhjSQWfu8B7TH
	tli1bGTuoHNCA41KYzXGUW5/siGykYA1bAaIZ8YWpF+ss5qoIdzSlon5CeWfReYh3IVipUSwoHT
	beB4e94wTv+tjQhcLQgZ7A715qfzKFmg5GkeLJxa3cOYDqmfPLX+FFNVX20J5I9iLwcwpg0uu+s
	KHZlnuOnNojTMfyklsWydb5Wxlof0oEDY30xhwwyk8RkwKKviG0urmG5UYjFHO2D4gIWvAMqTsO
	454Egv/a793A58FNTH2Uh8p3idwNTBB9cvd5gTHAYzw==
X-Google-Smtp-Source: AGHT+IFfrvhaU8j8P7rd6/dDFW4qNw+Jy7eMCNY2PRZvehXJM7LpdcnU1+spn1/jNPHqofONgAu42Q==
X-Received: by 2002:a05:6000:2509:b0:3e7:610b:85f6 with SMTP id ffacd0b85a97d-3ee842662b3mr3268819f8f.39.1758297506599;
        Fri, 19 Sep 2025 08:58:26 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:9dd0:62bf:d369:14ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407fa3sm8367224f8f.21.2025.09.19.08.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:58:25 -0700 (PDT)
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
Subject: [PATCH 2/3 v2] PCI: s32g: Add initial PCIe support (RC)
Date: Fri, 19 Sep 2025 17:58:20 +0200
Message-ID: <20250919155821.95334-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919155821.95334-1-vincent.guittot@linaro.org>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
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
 drivers/pci/controller/dwc/Kconfig           |  11 +
 drivers/pci/controller/dwc/Makefile          |   1 +
 drivers/pci/controller/dwc/pcie-designware.h |   1 +
 drivers/pci/controller/dwc/pcie-s32g-regs.h  |  61 ++
 drivers/pci/controller/dwc/pcie-s32g.c       | 578 +++++++++++++++++++
 5 files changed, 652 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-s32g-regs.h
 create mode 100644 drivers/pci/controller/dwc/pcie-s32g.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ff6b6d9e18ec..d7cee915aedd 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -255,6 +255,17 @@ config PCIE_TEGRA194_EP
 	  in order to enable device-specific features PCIE_TEGRA194_EP must be
 	  selected. This uses the DesignWare core.
 
+config PCIE_S32G
+	bool "NXP S32G PCIe controller (host mode)"
+	depends on ARCH_S32 || (OF && COMPILE_TEST)
+	select PCIE_DW_HOST
+	help
+	  Enable support for the PCIe controller in NXP S32G based boards to
+	  work in Host mode. The controller is based on DesignWare IP and
+	  can work either as RC or EP. In order to enable host-specific
+	  features PCIE_S32G must be selected.
+
+
 config PCIE_DW_PLAT
 	bool
 
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 6919d27798d1..47fbedd57747 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
+obj-$(CONFIG_PCIE_S32G) += pcie-s32g.o
 obj-$(CONFIG_PCIE_QCOM_COMMON) += pcie-qcom-common.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcd..2aec011a9dd4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -119,6 +119,7 @@
 
 #define GEN3_RELATED_OFF			0x890
 #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
+#define GEN3_RELATED_OFF_EQ_PHASE_2_3		BIT(9)
 #define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS	BIT(13)
 #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
diff --git a/drivers/pci/controller/dwc/pcie-s32g-regs.h b/drivers/pci/controller/dwc/pcie-s32g-regs.h
new file mode 100644
index 000000000000..674ea47a525f
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-s32g-regs.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2015-2016 Freescale Semiconductor, Inc.
+ * Copyright 2016-2023, 2025 NXP
+ */
+
+#ifndef PCIE_S32G_REGS_H
+#define PCIE_S32G_REGS_H
+
+/* Instance PCIE_SS - CTRL register offsets (ctrl base) */
+#define LINK_INT_CTRL_STS			0x40
+#define LINK_REQ_RST_NOT_INT_EN			BIT(1)
+#define LINK_REQ_RST_NOT_CLR			BIT(2)
+
+/* PCIe controller 0 general control 1 (ctrl base) */
+#define PE0_GEN_CTRL_1				0x50
+#define SS_DEVICE_TYPE_MASK			GENMASK(3, 0)
+#define SS_DEVICE_TYPE(x)			FIELD_PREP(SS_DEVICE_TYPE_MASK, x)
+#define SRIS_MODE_EN				BIT(8)
+
+/* PCIe controller 0 general control 3 (ctrl base) */
+#define PE0_GEN_CTRL_3				0x58
+/* LTSSM Enable. Active high. Set it low to hold the LTSSM in Detect state. */
+#define LTSSM_EN				BIT(0)
+
+/* PCIe Controller 0 Link Debug 2 (ctrl base) */
+#define PCIE_SS_PE0_LINK_DBG_2			0xB4
+#define PCIE_SS_SMLH_LTSSM_STATE_MASK		GENMASK(5, 0)
+#define PCIE_SS_SMLH_LINK_UP			BIT(6)
+#define PCIE_SS_RDLH_LINK_UP			BIT(7)
+#define LTSSM_STATE_L0				0x11U /* L0 state */
+#define LTSSM_STATE_L0S				0x12U /* L0S state */
+#define LTSSM_STATE_L1_IDLE			0x14U /* L1_IDLE state */
+#define LTSSM_STATE_HOT_RESET			0x1FU /* HOT_RESET state */
+
+/* PCIe Controller 0  Interrupt Status (ctrl base) */
+#define PE0_INT_STS				0xE8
+#define HP_INT_STS				BIT(6)
+
+/* Link Control and Status Register. (PCI_EXP_LNKCTL in pci-regs.h) */
+#define PCIE_CAP_LINK_TRAINING			BIT(27)
+
+/* Instance PCIE_PORT_LOGIC - DBI register offsets */
+#define PCIE_PORT_LOGIC_BASE			0x700
+
+/* ACE Cache Coherency Control Register 3 */
+#define PORT_LOGIC_COHERENCY_CONTROL_1		(PCIE_PORT_LOGIC_BASE + 0x1E0)
+#define PORT_LOGIC_COHERENCY_CONTROL_2		(PCIE_PORT_LOGIC_BASE + 0x1E4)
+#define PORT_LOGIC_COHERENCY_CONTROL_3		(PCIE_PORT_LOGIC_BASE + 0x1E8)
+
+/*
+ * See definition of register "ACE Cache Coherency Control Register 1"
+ * (COHERENCY_CONTROL_1_OFF) in the SoC RM
+ */
+#define CC_1_MEMTYPE_BOUNDARY_MASK		GENMASK(31, 2)
+#define CC_1_MEMTYPE_BOUNDARY(x)		FIELD_PREP(CC_1_MEMTYPE_BOUNDARY_MASK, x)
+#define CC_1_MEMTYPE_VALUE			BIT(0)
+#define CC_1_MEMTYPE_LOWER_PERIPH		0x0
+#define CC_1_MEMTYPE_LOWER_MEM			0x1
+
+#endif  /* PCI_S32G_REGS_H */
diff --git a/drivers/pci/controller/dwc/pcie-s32g.c b/drivers/pci/controller/dwc/pcie-s32g.c
new file mode 100644
index 000000000000..995e4593a13e
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-s32g.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for NXP S32G SoCs
+ *
+ * Copyright 2019-2025 NXP
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/pci.h>
+#include <linux/phy.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+#include "pcie-designware.h"
+#include "pcie-s32g-regs.h"
+
+struct s32g_pcie {
+	struct dw_pcie	pci;
+
+	/*
+	 * We have cfg in struct dw_pcie_rp and
+	 * dbi in struct dw_pcie, so define only ctrl here
+	 */
+	void __iomem *ctrl_base;
+	u64 coherency_base;
+
+	struct phy *phy;
+};
+
+#define to_s32g_from_dw_pcie(x) \
+	container_of(x, struct s32g_pcie, pci)
+
+static void s32g_pcie_writel_ctrl(struct s32g_pcie *s32g_pp, u32 reg, u32 val)
+{
+	if (dw_pcie_write(s32g_pp->ctrl_base + reg, 0x4, val))
+		dev_err(s32g_pp->pci.dev, "Write ctrl address failed\n");
+}
+
+static u32 s32g_pcie_readl_ctrl(struct s32g_pcie *s32g_pp, u32 reg)
+{
+	u32 val = 0;
+
+	if (dw_pcie_read(s32g_pp->ctrl_base + reg, 0x4, &val))
+		dev_err(s32g_pp->pci.dev, "Read ctrl address failed\n");
+
+	return val;
+}
+
+static void s32g_pcie_enable_ltssm(struct s32g_pcie *s32g_pp)
+{
+	u32 reg;
+
+	reg = s32g_pcie_readl_ctrl(s32g_pp, PE0_GEN_CTRL_3);
+	reg |= LTSSM_EN;
+	s32g_pcie_writel_ctrl(s32g_pp, PE0_GEN_CTRL_3, reg);
+}
+
+static void s32g_pcie_disable_ltssm(struct s32g_pcie *s32g_pp)
+{
+	u32 reg;
+
+	reg = s32g_pcie_readl_ctrl(s32g_pp, PE0_GEN_CTRL_3);
+	reg &= ~LTSSM_EN;
+	s32g_pcie_writel_ctrl(s32g_pp, PE0_GEN_CTRL_3, reg);
+}
+
+static bool is_s32g_pcie_ltssm_enabled(struct s32g_pcie *s32g_pp)
+{
+	return (s32g_pcie_readl_ctrl(s32g_pp, PE0_GEN_CTRL_3) & LTSSM_EN);
+}
+
+static enum dw_pcie_ltssm s32g_pcie_get_ltssm(struct dw_pcie *pci)
+{
+	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
+	u32 val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_SS_PE0_LINK_DBG_2);
+
+	return (enum dw_pcie_ltssm)FIELD_GET(PCIE_SS_SMLH_LTSSM_STATE_MASK, val);
+}
+
+#define PCIE_LINKUP	(PCIE_SS_SMLH_LINK_UP | PCIE_SS_RDLH_LINK_UP)
+
+static bool has_data_phy_link(struct s32g_pcie *s32g_pp)
+{
+	u32 val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_SS_PE0_LINK_DBG_2);
+
+	if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
+		switch (val & PCIE_SS_SMLH_LTSSM_STATE_MASK) {
+		case LTSSM_STATE_L0:
+		case LTSSM_STATE_L0S:
+		case LTSSM_STATE_L1_IDLE:
+			return true;
+		default:
+			return false;
+		}
+	}
+
+	return false;
+}
+
+static bool s32g_pcie_link_up(struct dw_pcie *pci)
+{
+	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
+
+	if (!is_s32g_pcie_ltssm_enabled(s32g_pp))
+		return false;
+
+	return has_data_phy_link(s32g_pp);
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
+struct dw_pcie_ops s32g_pcie_ops = {
+	.get_ltssm = s32g_pcie_get_ltssm,
+	.link_up = s32g_pcie_link_up,
+	.start_link = s32g_pcie_start_link,
+	.stop_link = s32g_pcie_stop_link,
+};
+
+static const struct dw_pcie_host_ops s32g_pcie_host_ops;
+
+static void disable_equalization(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
+	val &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
+		 GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
+	val |= FIELD_PREP(GEN3_EQ_CONTROL_OFF_FB_MODE, 1) |
+	       FIELD_PREP(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC, 0x84);
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
+static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci, u64 ddr_base_addr)
+{
+	u32 ddr_base_low = lower_32_bits(ddr_base_addr);
+	u32 ddr_base_high = upper_32_bits(ddr_base_addr);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writel_dbi(pci, PORT_LOGIC_COHERENCY_CONTROL_3, 0x0);
+
+	/*
+	 * Transactions to peripheral targets should be non-coherent,
+	 * or Ncore might drop them. Define the start of DDR as seen by Linux
+	 * as the boundary between "memory" and "peripherals", with peripherals
+	 * being below this boundary, and memory addresses being above it.
+	 * One example where this is needed are PCIe MSIs, which use NoSnoop=0
+	 * and might end up routed to Ncore.
+	 */
+	dw_pcie_writel_dbi(pci, PORT_LOGIC_COHERENCY_CONTROL_1,
+			   (ddr_base_low & CC_1_MEMTYPE_BOUNDARY_MASK) |
+			   (CC_1_MEMTYPE_LOWER_PERIPH & CC_1_MEMTYPE_VALUE));
+	dw_pcie_writel_dbi(pci, PORT_LOGIC_COHERENCY_CONTROL_2, ddr_base_high);
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
+static int init_pcie_controller(struct s32g_pcie *s32g_pp)
+{
+	struct dw_pcie *pci = &s32g_pp->pci;
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+
+	/* Set RP mode */
+	val = s32g_pcie_readl_ctrl(s32g_pp, PE0_GEN_CTRL_1);
+	val &= ~SS_DEVICE_TYPE_MASK;
+	val |= SS_DEVICE_TYPE(PCI_EXP_TYPE_ROOT_PORT);
+
+	/* Use default CRNS */
+	val &= ~SRIS_MODE_EN;
+
+	s32g_pcie_writel_ctrl(s32g_pp, PE0_GEN_CTRL_1, val);
+
+	/* Disable phase 2,3 equalization */
+	disable_equalization(pci);
+
+	/*
+	 * Make sure we use the coherency defaults (just in case the settings
+	 * have been changed from their reset values)
+	 */
+	s32g_pcie_reset_mstr_ace(pci, s32g_pp->coherency_base);
+
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
+	val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
+
+	/*
+	 * Set max payload supported, 256 bytes and
+	 * relaxed ordering.
+	 */
+	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
+	val &= ~(PCI_EXP_DEVCTL_RELAX_EN |
+		 PCI_EXP_DEVCTL_PAYLOAD |
+		 PCI_EXP_DEVCTL_READRQ);
+	val |= PCI_EXP_DEVCTL_RELAX_EN |
+	       PCI_EXP_DEVCTL_PAYLOAD_256B |
+	       PCI_EXP_DEVCTL_READRQ_256B;
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
+
+	/*
+	 * Enable the IO space, Memory space, Bus master,
+	 * Parity error, Serr and disable INTx generation
+	 */
+	dw_pcie_writel_dbi(pci, PCI_COMMAND,
+			   PCI_COMMAND_SERR | PCI_COMMAND_PARITY |
+			   PCI_COMMAND_INTX_DISABLE | PCI_COMMAND_IO |
+			   PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+
+	/* Enable errors */
+	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
+	val |= PCI_EXP_DEVCTL_CERE |
+	       PCI_EXP_DEVCTL_NFERE |
+	       PCI_EXP_DEVCTL_FERE |
+	       PCI_EXP_DEVCTL_URRE;
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
+
+	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	val |= GEN3_RELATED_OFF_EQ_PHASE_2_3;
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+
+	/* Disable writing dbi registers */
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	return 0;
+}
+
+static int init_pcie_phy(struct s32g_pcie *s32g_pp)
+{
+	struct dw_pcie *pci = &s32g_pp->pci;
+	struct device *dev = pci->dev;
+	int ret;
+
+	ret = phy_init(s32g_pp->phy);
+	if (ret) {
+		dev_err(dev, "Failed to init serdes PHY\n");
+		return ret;
+	}
+
+	ret = phy_set_mode_ext(s32g_pp->phy, PHY_MODE_PCIE, 0);
+	if (ret) {
+		dev_err(dev, "Failed to set mode on serdes PHY\n");
+		goto err_phy_exit;
+	}
+
+	ret = phy_power_on(s32g_pp->phy);
+	if (ret) {
+		dev_err(dev, "Failed to power on serdes PHY\n");
+		goto err_phy_exit;
+	}
+
+	return 0;
+
+err_phy_exit:
+	phy_exit(s32g_pp->phy);
+	return ret;
+}
+
+static int deinit_pcie_phy(struct s32g_pcie *s32g_pp)
+{
+	struct dw_pcie *pci = &s32g_pp->pci;
+	struct device *dev = pci->dev;
+	int ret;
+
+	ret = phy_power_off(s32g_pp->phy);
+	if (ret) {
+		dev_err(dev, "Failed to power off serdes PHY\n");
+		return ret;
+	}
+
+	ret = phy_exit(s32g_pp->phy);
+	if (ret) {
+		dev_err(dev, "Failed to exit serdes PHY\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct pci_bus *s32g_get_child_downstream_bus(struct pci_bus *bus)
+{
+	struct pci_bus *child, *root_bus = NULL;
+
+	list_for_each_entry(child, &bus->children, node) {
+		if (child->parent == bus) {
+			root_bus = child;
+			break;
+		}
+	}
+
+	if (!root_bus)
+		return ERR_PTR(-ENODEV);
+
+	return root_bus;
+}
+
+static void s32g_pcie_downstream_dev_to_D0(struct s32g_pcie *s32g_pp)
+{
+	struct dw_pcie *pci = &s32g_pp->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	struct pci_bus *root_bus = NULL;
+	struct pci_dev *pdev;
+
+	/* Check if we did manage to initialize the host */
+	if (!pp->bridge || !pp->bridge->bus)
+		return;
+
+	/*
+	 * link doesn't go into L2 state with some of the Endpoints
+	 * if they are not in D0 state. So, we need to make sure that
+	 * immediate downstream devices are in D0 state before sending
+	 * PME_TurnOff to put link into L2 state.
+	 */
+
+	root_bus = s32g_get_child_downstream_bus(pp->bridge->bus);
+	if (IS_ERR(root_bus)) {
+		dev_err(pci->dev, "Failed to find downstream devices\n");
+		return;
+	}
+
+	list_for_each_entry(pdev, &root_bus->devices, bus_list) {
+		if (PCI_SLOT(pdev->devfn) == 0) {
+			if (pci_set_power_state(pdev, PCI_D0))
+				dev_err(pci->dev,
+					"Failed to transition %s to D0 state\n",
+					dev_name(&pdev->dev));
+		}
+	}
+}
+
+static u64 s32g_get_coherency_boundary(struct device *dev)
+{
+	struct device_node *np;
+	struct resource res;
+
+	np = of_find_node_by_type(NULL, "memory");
+
+	if (of_address_to_resource(np, 0, &res)) {
+		dev_warn(dev, "Fail to get coherency boundary\n");
+		res.start = 0;
+	}
+
+	of_node_put(np);
+
+	return res.start;
+}
+
+static int s32g_pcie_get_resources(struct platform_device *pdev,
+				   struct s32g_pcie *s32g_pp)
+{
+	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci = &s32g_pp->pci;
+	struct phy *phy;
+
+	pci->dev = dev;
+	pci->ops = &s32g_pcie_ops;
+
+	platform_set_drvdata(pdev, s32g_pp);
+
+	phy = devm_phy_get(dev, NULL);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy),
+				"Failed to get serdes PHY\n");
+	s32g_pp->phy = phy;
+
+	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
+	if (IS_ERR(s32g_pp->ctrl_base))
+		return PTR_ERR(s32g_pp->ctrl_base);
+
+	s32g_pp->coherency_base = s32g_get_coherency_boundary(dev);
+
+	return 0;
+}
+
+static int s32g_pcie_init(struct device *dev,
+			  struct s32g_pcie *s32g_pp)
+{
+	int ret;
+
+	s32g_pcie_disable_ltssm(s32g_pp);
+
+	ret = init_pcie_phy(s32g_pp);
+	if (ret)
+		return ret;
+
+	ret = init_pcie_controller(s32g_pp);
+	if (ret)
+		goto err_deinit_phy;
+
+	return 0;
+
+err_deinit_phy:
+	deinit_pcie_phy(s32g_pp);
+	return ret;
+}
+
+static void s32g_pcie_deinit(struct s32g_pcie *s32g_pp)
+{
+	s32g_pcie_disable_ltssm(s32g_pp);
+	deinit_pcie_phy(s32g_pp);
+}
+
+static int s32g_pcie_host_init(struct device *dev,
+			       struct s32g_pcie *s32g_pp)
+{
+	struct dw_pcie *pci = &s32g_pp->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	int ret;
+
+	pp->ops = &s32g_pcie_host_ops;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "Failed to initialize host\n");
+		goto err_host_deinit;
+	}
+
+	return 0;
+
+err_host_deinit:
+	dw_pcie_host_deinit(pp);
+	return ret;
+}
+
+static int s32g_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct s32g_pcie *s32g_pp;
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
+	devm_pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		goto err_pm_runtime_put;
+
+	ret = s32g_pcie_init(dev, s32g_pp);
+	if (ret)
+		goto err_pm_runtime_put;
+
+	ret = s32g_pcie_host_init(dev, s32g_pp);
+	if (ret)
+		goto err_deinit_controller;
+
+	return 0;
+
+err_deinit_controller:
+	s32g_pcie_deinit(s32g_pp);
+err_pm_runtime_put:
+	pm_runtime_put(dev);
+
+	return ret;
+}
+
+static int s32g_pcie_suspend(struct device *dev)
+{
+	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &s32g_pp->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	struct pci_bus *bus, *root_bus;
+
+	s32g_pcie_downstream_dev_to_D0(s32g_pp);
+
+	bus = pp->bridge->bus;
+	root_bus = s32g_get_child_downstream_bus(bus);
+	if (!IS_ERR(root_bus))
+		pci_walk_bus(root_bus, pci_dev_set_disconnected, NULL);
+
+	pci_stop_root_bus(bus);
+	pci_remove_root_bus(bus);
+
+	s32g_pcie_deinit(s32g_pp);
+
+	return 0;
+}
+
+static int s32g_pcie_resume(struct device *dev)
+{
+	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &s32g_pp->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	int ret = 0;
+
+	ret = s32g_pcie_init(dev, s32g_pp);
+	if (ret < 0)
+		return ret;
+
+	ret = dw_pcie_setup_rc(pp);
+	if (ret) {
+		dev_err(dev, "Failed to resume DW RC: %d\n", ret);
+		goto fail_host_init;
+	}
+
+	ret = dw_pcie_start_link(pci);
+	if (ret) {
+		/*
+		 * We do not exit with error if link up was unsuccessful
+		 * Endpoint may not be connected.
+		 */
+		if (dw_pcie_wait_for_link(pci))
+			dev_warn(pci->dev,
+				 "Link Up failed, Endpoint may not be connected\n");
+
+		if (!phy_validate(s32g_pp->phy, PHY_MODE_PCIE, 0, NULL)) {
+			dev_err(dev, "Failed to get link up with EP connected\n");
+			goto fail_host_init;
+		}
+	}
+
+	ret = pci_host_probe(pp->bridge);
+	if (ret)
+		goto fail_host_init;
+
+	return 0;
+
+fail_host_init:
+	s32g_pcie_deinit(s32g_pp);
+	return ret;
+}
+
+static const struct dev_pm_ops s32g_pcie_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(s32g_pcie_suspend,
+			    s32g_pcie_resume)
+};
+
+static const struct of_device_id s32g_pcie_of_match[] = {
+	{ .compatible = "nxp,s32g2-pcie"},
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


