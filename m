Return-Path: <linux-pci+bounces-41888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F11EBC7AF46
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 17:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D571A4F30D1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A784B34B185;
	Fri, 21 Nov 2025 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsogHt66"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BF3446DE
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743770; cv=none; b=UNjDvKq9hSYNTtnWtMowownMvhhJcvhwwDdRTG/N0pcmvmXNo/D9YBCB/3lLAaLRWIZxd/7fhwNR1fg/GKRyOMwgFgMBF/5PzX34mzLwH5LZRIdyCyV4QDUCaN99cxhbAtQlFPlmwZO5/w+Lrwei9DNdyeIqswb6vD9vMSeu1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743770; c=relaxed/simple;
	bh=jLg2owi8cuztQmDDnUqDXrYsNNeS8ealusos2hASFl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjc9pq+nXrAqt7o9KQDtyhmVQLphRjvwrkGXMZg/Q2uSzW2HsyS/aZqzxgfMzASWzkyDYCeN85kaPcCEKOYMLS1VJ/l6w+286+/8nJ9AYsgpdJ/RARIW2rfhtkikOUGpylCy1wzIXwk62ncq4M9KHSsw3RqzRA+Yo06XMxA6yDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wsogHt66; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso10816755e9.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 08:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763743766; x=1764348566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/vY75jJnCefykhwTh1Z1MHEIZ3RIjWefl7LKsllcrU=;
        b=wsogHt66QDq0Jo0CAv425fq5gddsiLiHN+5e8cyFdGTFtlzkEi0k9eN7/vRTwJBw9r
         NtNXIXJCC0TfDFQ5ET9fw3laOP2jEWmfC+xy4jP30KYOYfIwa8JFWtVf6HhwbE9ocY1h
         BNmU3Sk57/n2cYqPfeurFvnwO7kSekHqyybrWCwwNoXPhVIyVVhSjXBnO6khIrAFTbbX
         vkTNoYTisYUny5zoPKQDdhSg6XH01un+5vYht/okL+NXuZbQp1+G48z04Frjg31XmS8t
         /HUcEqFV4/SHM+t4JjuHzJfwdigQcuPi+9KpTVgzkza/EIC3vsOCvzSnJRmNLuKbQeLm
         S7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743766; x=1764348566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/vY75jJnCefykhwTh1Z1MHEIZ3RIjWefl7LKsllcrU=;
        b=Jg9/KvIMzYkZSHWyhKlymSa8eqUG9NUCkS/RH9vNoliZiLPMrMmEBR6x78IxuHxjZn
         UWPNSco7bmJQrHdai+0AgQrUn9YMvFEm4w1hG801/Kw83DBopaaQYPLYwaT3A4kVbTjk
         PidAqfnIDt220+o9gBksNWKHN79zf1JZ9jMA0GHEl/QXPk2eNb+qvnl+ASsxoPJqvies
         Yx3ZI1DBHgkwf8CVIuBMgHJtQUnVqz5yMjK+0cq17q9s18F/Wz8t6f/SwAgSMRWj+Kw6
         SOM6QvrsN98wkj1auZ2UVbamKX1k4so+3tBiOpjh9kqkn58T/iZJQB79+665r3P7kShU
         4HRw==
X-Forwarded-Encrypted: i=1; AJvYcCUFe52lnA/o277wiqYbnt8e7GsGbQi1ktAccqJ/hBhuBe+JP0A2YMRpnv/rQpqBMSrkJHrgYTCPHVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/4uKZYpFgSD5V3dQTXFnceEkE+HeyEnvuVj3dsTXrjKHVc4iY
	/msNwYVP4CezyoJPeTD1sp0cVr5XcqkAc1wNZHbl1EZBIb6NTJL0bnJdLnL6uicj5no=
X-Gm-Gg: ASbGncsOeSUkC+e2k9/u8YnF8zpLVdRPcoFtnyPr4XfNxmDcqTURPtHdZqFvNLgITo5
	ZMLNmVPfPxRs3GweG3SwjH8UHifOsRsI/Ukw8FAAK3xmqk/JNxq2lihXYD2em6PoJ9+0fwtkuG0
	8lb7on5KLjUViNQm0yarArOauwpMhp+5LBxLOfeHjN0OdpXHTYsqd+IZ1trK0Y3LkV2zySEKGfZ
	H0Q7nFwZ+rDraTw9ipsZwuuV4BTI2736n7EXIxiXpbf9Sd+6Laspn/cmzL/1q8ywywZmxmmBMdo
	7b7zN6BDBP+bfnbh0sttlZw2q1CQVDIgT7GKIiKTbEanZpw8NVPFmnVXpoqUzzoGak3ip+YlCLU
	UbIMvIrFe2baincPpl0XTA2IO1JmLneM418qoh7wUX+nPP+VKNkdX3lxtwUmmIZaQoEC2Kz+cS9
	v4a+zP+6d5zf6JWSfbrRM=
X-Google-Smtp-Source: AGHT+IGDruNhclScUMNwEExIZioMGZQLDwqyNoIqYrX1+4Uxd8LqhZUc4qw+IFLq6lISLEtgKUg9XA==
X-Received: by 2002:a05:600c:3ba3:b0:477:aed0:f403 with SMTP id 5b1f17b1804b1-477c110d91dmr27171665e9.8.1763743766134;
        Fri, 21 Nov 2025 08:49:26 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:803a:ae25:6381:a6fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb8ff3sm12938478f8f.29.2025.11.21.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:49:25 -0800 (PST)
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
Subject: [PATCH 3/4 v6] PCI: s32g: Add initial PCIe support (RC)
Date: Fri, 21 Nov 2025 17:49:19 +0100
Message-ID: <20251121164920.2008569-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121164920.2008569-1-vincent.guittot@linaro.org>
References: <20251121164920.2008569-1-vincent.guittot@linaro.org>
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/Kconfig         |  10 +
 drivers/pci/controller/dwc/Makefile        |   1 +
 drivers/pci/controller/dwc/pcie-nxp-s32g.c | 404 +++++++++++++++++++++
 3 files changed, 415 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 349d4657393c..eac60d55d413 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -256,6 +256,16 @@ config PCIE_TEGRA194_EP
 	  in order to enable device-specific features PCIE_TEGRA194_EP must be
 	  selected. This uses the DesignWare core.
 
+config PCIE_NXP_S32G
+	bool "NXP S32G PCIe controller (host mode)"
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
diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
new file mode 100644
index 000000000000..eacf0229762c
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
@@ -0,0 +1,404 @@
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
+/* PCIe Controller 0  Interrupt Status */
+#define PCIE_S32G_PE0_INT_STS			0xE8
+#define HP_INT_STS				BIT(6)
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
+	 * and might end up routed to Ncore. PCIe coherent traffic (e.g. MSIs)
+	 * that targets peripheral space will be dropped by Ncore because
+	 * peripherals on S32G are not coherent as slaves. We add a hard
+	 * boundary in the PCIe controller coherency control registers to
+	 * separate physical memory space from peripheral space.
+	 *
+	 * Define the start of DDR as seen by Linux as this boundary between
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
+	s32g_pcie_disable_ltssm(s32g_pp);
+
+	return s32g_init_pcie_phy(s32g_pp);
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
+builtin_platform_driver(s32g_pcie_driver);
+
+MODULE_AUTHOR("Ionut Vicovan <Ionut.Vicovan@nxp.com>");
+MODULE_DESCRIPTION("NXP S32G PCIe Host controller driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


