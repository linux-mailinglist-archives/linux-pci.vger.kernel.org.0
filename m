Return-Path: <linux-pci+bounces-39052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9497ABFDA8F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F81C1A60A47
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F57D2DA77F;
	Wed, 22 Oct 2025 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnVX4TiI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0852D979D
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155000; cv=none; b=CqqExYtPNMQngGG5dN5BdmSzCONJjKX4FCwoliqx3eeqVICNHa5pRDUAwJzyLNyak5qRw/9VFXAFv30ikimCye+qi8+44OsbyCyWVFpPjhOptFQwe65j/rdcc4a+bHmD3j8tNM5KZDYO+EiN39gGLcaCr1rMRdeELM4HAgSkOcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155000; c=relaxed/simple;
	bh=AHQ+PPz0lajD0Sbg9dkLO7N8/9v2UFyfb6OC+VlckOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lW/WNDhAQJ77+pAhD9x6iSUBUHEG05z2soSACaHOjs7KMCSYWCJsiuqIbVErmyQYk1XtgKzoyLLTcJzTYTfIY6WdiBe31pXHqG8syxZ+g7qZ1pk3wJ8gnjTcMwAT/LksLFk/MNTEFU1WPrD6Xbg6G7TBwTt9J6qTf+z5D742Z+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EnVX4TiI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so46160445e9.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761154996; x=1761759796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAW0fJOEgm/3OZNhaFXEVj7ih7MDZGYCIb3wxvxnUgY=;
        b=EnVX4TiIbacu/s9dKYTbLOdHK34pbI2Rb2/NGGUw4b27PF3xOjqSnIc572eeJr6SgC
         DWP15uE2f7kgsg6ZSuDDUTuG62JFUyxuZgSvWODWjqRFZ6SjcQDrSTiTuKZsFGE9hkUJ
         wWJWb80du91sMVllXL5xQEpIORV/a4cg91Ko4feGlA9njZAeiEQvEw/YlaKFdxJyyfeZ
         jR3rYvXS/xqB46rbcCGNGGf7yren28oJ0w4Bw+c+FNS8PJ7QzkTcMeFpxaRrZl1RjKvK
         4N4NFeESbEW+ET4JPPTObK6nLkwviSyFMxYqy0jchPAlbTi2OahOPJLwTNQIfHfBqr9F
         H2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154996; x=1761759796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAW0fJOEgm/3OZNhaFXEVj7ih7MDZGYCIb3wxvxnUgY=;
        b=nF0P2PKlVpZPkY3mCikmTQmpnECHk+4cBtidkNR5fR9ergwqXWWB73zBQswfDReotr
         ER0sIoKakbMyU07mtO8db5ivX7GFyk9RS7RfhCExd/fNVFpffZKX8q7gN5BR4Jcgk5CB
         mk6zLBSBDZd9LcX/2w4tUWcrp7+mtcsju9qGvrWSsr7eoF4lyk1h8+npnUsWIclYztiv
         AO5KDXPNwuAyO2qdsSlfffttDhp1icuypfP+8NInq7UZNVkmAKv6O4Vm8VW6AH+SqxV4
         QhcBZCsLwFl5QA5X4BN5fcKCiBzIxerOI2fvh1Vc81WmsX31pOisZUi4fKzrDpAQoln7
         jn6g==
X-Forwarded-Encrypted: i=1; AJvYcCVVpf8n/QSfvldft7eFtEtZdv2gCP29uGrLelFHY7SIQsRPRgwZEKAQpo/jzFw7wCGEGVw9QFQLRgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8eaw6NCtTMvXyxk8cDD7KJoOzm2pEAlocYg9YZ+uRvXCUd/Ju
	DulHTicyAegYUxSXH6urW6fJbuUJg3jNkSEy03Ab7s0Ua1HzxrUIF6LHea4hB/OkGOg=
X-Gm-Gg: ASbGncug6XwA12QkaXHOi/s1Njm+vFcZcj/qwp3fqcl8tUir1B21ZbTfJX5+Jplq2FI
	soSZOVEtsvseB+Ftfm3snyhHUwmhMOE4CjcVuL5a3R7MoOvcePm3aGV47KWd5KtlcuMBiYU+XNW
	YumVAlhrbmx9g1yeECjTUBNYD9iOvVOEVk4S9YZuZs74GwMWYbxq4Up16T1jJsZXd3RG4vOe5Xq
	SgPkTnbDWW0LeKKx+iT3roGxhCvrtREkZeGxTBFZrKHkvZ95qeShrlyxD94RldmcxxQxqsqssZX
	Jln52z1fszet4g5OQvSIDz8+fbubctNbNgGCDszEE/EDtv8yolO30P8MtBrG421GUcPh0onviy+
	eel2ucGxndKF9Nj+QVEi9P+3DmlpVgPq5kBMiHdfpxWmiKBp2Sh+bXLrHLpyjlxe9fgMROrvK1Y
	H8UKeOuwVq
X-Google-Smtp-Source: AGHT+IGm/cwWONtZV5J+zWL9XkRoy7AS0qpJj+VyisJzdvWqNmyDUXTbPVop32iUGbLguD/uMSNlhg==
X-Received: by 2002:a05:600c:818f:b0:46f:b42e:e361 with SMTP id 5b1f17b1804b1-47117931c89mr151814655e9.41.1761154996494;
        Wed, 22 Oct 2025 10:43:16 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:edfc:89e3:4805:d8de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494aad668sm43434755e9.2.2025.10.22.10.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:43:15 -0700 (PDT)
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
Subject: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
Date: Wed, 22 Oct 2025 19:43:08 +0200
Message-ID: <20251022174309.1180931-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022174309.1180931-1-vincent.guittot@linaro.org>
References: <20251022174309.1180931-1-vincent.guittot@linaro.org>
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
 .../pci/controller/dwc/pcie-nxp-s32g-regs.h   |  37 ++
 drivers/pci/controller/dwc/pcie-nxp-s32g.c    | 439 ++++++++++++++++++
 4 files changed, 487 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
 create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 349d4657393c..3f3172a0cd95 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -406,6 +406,16 @@ config PCIE_UNIPHIER_EP
 	  Say Y here if you want PCIe endpoint controller support on
 	  UniPhier SoCs. This driver supports Pro5 SoC.
 
+config PCIE_NXP_S32G
+	tristate "NXP S32G PCIe controller (host mode)"
+	depends on ARCH_S32 || COMPILE_TEST
+	select PCIE_DW_HOST
+	help
+	  Enable support for the PCIe controller in NXP S32G based boards to
+	  work in Host mode. The controller is based on DesignWare IP and
+	  can work either as RC or EP. In order to enable host-specific
+	  features PCIE_S32G must be selected.
+
 config PCIE_SOPHGO_DW
 	bool "Sophgo DesignWare PCIe controller (host mode)"
 	depends on ARCH_SOPHGO || COMPILE_TEST
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
index 000000000000..6f04204054dd
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
@@ -0,0 +1,37 @@
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
+/* Link Interrupt Control And Status */
+#define PCIE_S32G_LINK_INT_CTRL_STS		0x40
+#define LINK_REQ_RST_NOT_INT_EN			BIT(1)
+#define LINK_REQ_RST_NOT_CLR			BIT(2)
+
+/* PCIe controller 0 General Control 1 */
+#define PCIE_S32G_PE0_GEN_CTRL_1		0x50
+#define DEVICE_TYPE_MASK			GENMASK(3, 0)
+#define DEVICE_TYPE(x)				FIELD_PREP(DEVICE_TYPE_MASK, x)
+#define SRIS_MODE				BIT(8)
+
+/* PCIe controller 0 General Control 3 */
+#define PCIE_S32G_PE0_GEN_CTRL_3		0x58
+#define LTSSM_EN				BIT(0)
+
+/* PCIe Controller 0 Transmit Message Request */
+#define PCIE_S32G_PE0_TX_MSG_REQ		0x80
+#define PME_TURN_OFF_REQ			BIT(19)
+
+/* PCIe Controller 0 Link Debug 2 */
+#define PCIE_S32G_PE0_LINK_DBG_2		0xB4
+#define SMLH_LTSSM_STATE_MASK			GENMASK(5, 0)
+#define SMLH_LINK_UP				BIT(6)
+#define RDLH_LINK_UP				BIT(7)
+
+#endif  /* PCI_S32G_REGS_H */
diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
new file mode 100644
index 000000000000..53529f63c555
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
@@ -0,0 +1,439 @@
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
+struct s32g_pcie {
+	struct dw_pcie	pci;
+	void __iomem *ctrl_base;
+	struct phy *phy;
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
+static bool is_s32g_pcie_ltssm_enabled(struct s32g_pcie *s32g_pp)
+{
+	return (s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3) & LTSSM_EN);
+}
+
+static enum dw_pcie_ltssm s32g_pcie_get_ltssm(struct dw_pcie *pci)
+{
+	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
+	u32 reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_LINK_DBG_2);
+
+	return (enum dw_pcie_ltssm)FIELD_GET(SMLH_LTSSM_STATE_MASK, reg);
+}
+
+#define PCIE_LINKUP	(SMLH_LINK_UP | RDLH_LINK_UP)
+
+static bool s32g_has_data_phy_link(struct s32g_pcie *s32g_pp)
+{
+	u32 reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_LINK_DBG_2);
+
+	if ((reg & PCIE_LINKUP) == PCIE_LINKUP) {
+		switch (FIELD_GET(SMLH_LTSSM_STATE_MASK, reg)) {
+		case DW_PCIE_LTSSM_L0:
+		case DW_PCIE_LTSSM_L0S:
+		case DW_PCIE_LTSSM_L1_IDLE:
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
+	return s32g_has_data_phy_link(s32g_pp);
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
+	.get_ltssm = s32g_pcie_get_ltssm,
+	.link_up = s32g_pcie_link_up,
+	.start_link = s32g_pcie_start_link,
+	.stop_link = s32g_pcie_stop_link,
+};
+
+static void s32g_pcie_pme_turn_off(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
+	u32 reg;
+
+	reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_TX_MSG_REQ);
+	reg |= PME_TURN_OFF_REQ;
+	s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_TX_MSG_REQ, reg);
+}
+
+static const struct dw_pcie_host_ops s32g_pcie_host_ops = {
+	.pme_turn_off = s32g_pcie_pme_turn_off,
+};
+
+static void s32g_pcie_disable_equalization(struct dw_pcie *pci)
+{
+	u32 reg;
+
+	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
+	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
+		 GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
+	reg |= FIELD_PREP(GEN3_EQ_CONTROL_OFF_FB_MODE, 1) |
+	       FIELD_PREP(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC, 0x84);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
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
+static void s32g_init_pcie_controller(struct s32g_pcie *s32g_pp)
+{
+	struct dw_pcie *pci = &s32g_pp->pci;
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+
+	/* Set RP mode */
+	val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1);
+	val &= ~DEVICE_TYPE_MASK;
+	val |= DEVICE_TYPE(PCI_EXP_TYPE_ROOT_PORT);
+
+	/* Use default CRNS */
+	val &= ~SRIS_MODE;
+
+	s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1, val);
+
+	/* Disable phase 2,3 equalization */
+	s32g_pcie_disable_equalization(pci);
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
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
+static int s32g_init_pcie_phy(struct s32g_pcie *s32g_pp)
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
+static int s32g_deinit_pcie_phy(struct s32g_pcie *s32g_pp)
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
+static int s32g_pcie_init(struct device *dev,
+			  struct s32g_pcie *s32g_pp)
+{
+	int ret;
+
+	s32g_pcie_disable_ltssm(s32g_pp);
+
+	ret = s32g_init_pcie_phy(s32g_pp);
+	if (ret)
+		return ret;
+
+	s32g_init_pcie_controller(s32g_pp);
+
+	return 0;
+}
+
+static void s32g_pcie_deinit(struct s32g_pcie *s32g_pp)
+{
+	s32g_pcie_disable_ltssm(s32g_pp);
+	s32g_deinit_pcie_phy(s32g_pp);
+}
+
+static int s32g_pcie_host_init(struct s32g_pcie *s32g_pp)
+{
+	struct dw_pcie *pci = &s32g_pp->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	int ret;
+
+	pp->ops = &s32g_pcie_host_ops;
+
+	ret = dw_pcie_host_init(pp);
+
+	return ret;
+}
+
+static int s32g_pcie_get_resources(struct platform_device *pdev,
+				   struct s32g_pcie *s32g_pp)
+{
+	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci = &s32g_pp->pci;
+
+	s32g_pp->phy = devm_phy_get(dev, NULL);
+	if (IS_ERR(s32g_pp->phy))
+		return dev_err_probe(dev, PTR_ERR(s32g_pp->phy),
+				"Failed to get serdes PHY\n");
+	s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
+	if (IS_ERR(s32g_pp->ctrl_base))
+		return PTR_ERR(s32g_pp->ctrl_base);
+
+	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	pci->dev = dev;
+	pci->ops = &s32g_pcie_ops;
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
+	ret = s32g_pcie_host_init(s32g_pp);
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
+	if (!dw_pcie_link_up(pci))
+		return 0;
+
+	return dw_pcie_suspend_noirq(pci);
+}
+
+static int s32g_pcie_resume_noirq(struct device *dev)
+{
+	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &s32g_pp->pci;
+
+	s32g_init_pcie_controller(s32g_pp);
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


