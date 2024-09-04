Return-Path: <linux-pci+bounces-12722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6C096B285
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 09:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15C51C21894
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 07:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B3C148310;
	Wed,  4 Sep 2024 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWib1M3o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CE1482F3;
	Wed,  4 Sep 2024 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433923; cv=none; b=Ja1wqbaoTn4/M3WqX3DO9tok6AX0aCvbzlCXg8lg4hagJ7z6zLoJ0PIOJwXls/9gC5YZxgP3mTT+w9+7XOCZB2IX0DIwxOJF1dpzfZQ4t81ZDjRjD2zedwbLn9Q+3gK/+guw3d88ytvk+J8j4E88rWOkYafgLGWKsqKBaBb58YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433923; c=relaxed/simple;
	bh=LwVGABloRuNGFpCVqJ9UyuuTFWf3rxmzAgpQvwystx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SlZl7z3y54lkQrn1s/2LCITza3fzmtoFa/TWUFvZncNqjvsePYJ9bndyN7HRUNF5+oiShV9n6+srKQ0YrbP7v/coNA4LTcIihlz9F5bKzX7M6kpj8plgLvl09KkrdinLHuF/MjvUZZa2eapjqDB5OUweNlGWSD6sh+9i9eIQ2tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWib1M3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33742C4CECF;
	Wed,  4 Sep 2024 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725433923;
	bh=LwVGABloRuNGFpCVqJ9UyuuTFWf3rxmzAgpQvwystx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lWib1M3oZ58jLBwEHWD2UhgNp8kPvJdwCfvdHlUy783Nvfj7vIrsEB6MzirY2rVzu
	 STgDrahXCCk9wPxdfbGvAxTBaBOx4SpYjYNiRtrNG0RccAyjZPxyCUOjLjgmlx16jn
	 ulkU+tlFyeqNAOEfZ2LjbDAA6ivPO1rdsdLwJX7LbXOIvKvAjpH4dK9+7yAVLOiebF
	 5YGyX3ILT4U5fO7UpF2qTCUkbNjw5h0VU+uG3pwwZLWlnhbEymWu3gat1HDjDa6p7R
	 UmNN8L/WfD0Mt8zvp7kgqwMN8jF/Sbvt0gtJpUCAIMvCkpft9LyJ2NPgRoDZdlm3rG
	 eqXPgmY7fB39A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD2BCD484B;
	Wed,  4 Sep 2024 07:12:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 04 Sep 2024 12:41:59 +0530
Subject: [PATCH v6 3/4] PCI: qcom: Add equalization settings for 16.0 GT/s
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-pci-qcom-gen4-stability-v6-3-ec39f7ae3f62@linaro.org>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
In-Reply-To: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Chuanhua Lei <lchuanhua@maxlinear.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 abel.vesa@linaro.org, johan+linaro@kernel.org, 
 Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8912;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=O30AbR/u6bNNZQiLXcwalUrc4of9/6k1WIJqurCfXZQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBm2Ag/EgK/nkm3WCLqVQKqX/BtDr66lXxn1rXvr
 +c7ebkJiZWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZtgIPwAKCRBVnxHm/pHO
 9XLrCACJm2fqFsKEizN0IiXfX4R841fL49SZYtGEJUpF7Aa6PFA8iEX/bOAmTjB5zmoPmhWcoEx
 tFdKlGUvWDcESJ9BUp8KRl3EnBPnOHu2kyfOZUGeAjidXhP0GMcAW3W2yfjbb6n4jY+rkKkVm+d
 AWU/MNfC71a80muKjrA4E9Uay+x+VtFHyBch+512VVzbI3si5oJgyjBhwaXa86b7pe3xtXlGZCN
 lcVzG12vX2OT15WD7WBonK96bmx68N36GkkRIRnxBL7Uwy06xmx1xY55tcbYkmjUFg6J04Vd2q4
 mC/u1VUle96DS73D8ASulnbJ3YdK9mVL+8EKxAbI7RYU4HX4
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>

During high data transmission rates such as 16.0 GT/s, there is an
increased risk of signal loss due to poor channel quality and interference.
This can impact receiver's ability to capture signals accurately. Hence,
signal compensation is achieved through appropriate lane equalization
settings at both transmitter and receiver. This will result in increased
PCIe signal strength.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[mani: dropped the code refactoring and minor changes]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS                                   |  4 ++-
 drivers/pci/controller/dwc/Kconfig            |  5 +++
 drivers/pci/controller/dwc/Makefile           |  1 +
 drivers/pci/controller/dwc/pcie-designware.h  | 12 +++++++
 drivers/pci/controller/dwc/pcie-qcom-common.c | 45 +++++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h |  8 +++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  4 +++
 drivers/pci/controller/dwc/pcie-qcom.c        |  4 +++
 8 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..3cfb6068b9f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2728,7 +2728,7 @@ F:	drivers/iommu/msm*
 F:	drivers/mfd/ssbi.c
 F:	drivers/mmc/host/mmci_qcom*
 F:	drivers/mmc/host/sdhci-msm.c
-F:	drivers/pci/controller/dwc/pcie-qcom.c
+F:	drivers/pci/controller/dwc/pcie-qcom*
 F:	drivers/phy/qualcomm/
 F:	drivers/power/*/msm*
 F:	drivers/reset/reset-qcom-*
@@ -17757,6 +17757,7 @@ M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	drivers/pci/controller/dwc/pcie-qcom-common.c
 F:	drivers/pci/controller/dwc/pcie-qcom.c
 
 PCIE DRIVER FOR ROCKCHIP
@@ -17793,6 +17794,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+F:	drivers/pci/controller/dwc/pcie-qcom-common.c
 F:	drivers/pci/controller/dwc/pcie-qcom-ep.c
 
 PCMCIA SUBSYSTEM
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 4c38181acffa..b6d6778b0698 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -265,12 +265,16 @@ config PCIE_DW_PLAT_EP
 	  order to enable device-specific features PCI_DW_PLAT_EP must be
 	  selected.
 
+config PCIE_QCOM_COMMON
+	bool
+
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller (host mode)"
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select CRC8
+	select PCIE_QCOM_COMMON
 	help
 	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
 	  PCIe controller uses the DesignWare core plus Qualcomm-specific
@@ -281,6 +285,7 @@ config PCIE_QCOM_EP
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
+	select PCIE_QCOM_COMMON
 	help
 	  Say Y here to enable support for the PCIe controllers on Qualcomm SoCs
 	  to work in endpoint mode. The PCIe controller uses the DesignWare core
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index ec215b3d6191..a8308d9ea986 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
+obj-$(CONFIG_PCIE_QCOM_COMMON) += pcie-qcom-common.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 22765564f301..51744ad25575 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -126,6 +126,18 @@
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
 
+#define GEN3_EQ_CONTROL_OFF			0x8a8
+#define GEN3_EQ_CONTROL_OFF_FB_MODE		GENMASK(3, 0)
+#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE	BIT(4)
+#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC	GENMASK(23, 8)
+#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL	BIT(24)
+
+#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac
+#define GEN3_EQ_FMDC_T_MIN_PHASE23		GENMASK(4, 0)
+#define GEN3_EQ_FMDC_N_EVALS			GENMASK(9, 5)
+#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA	GENMASK(13, 10)
+#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA	GENMASK(17, 14)
+
 #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
 #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
new file mode 100644
index 000000000000..dc7d93db9dc5
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/pci.h>
+
+#include "pcie-designware.h"
+#include "pcie-qcom-common.h"
+
+void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
+{
+	u32 reg;
+
+	/*
+	 * GEN3_RELATED_OFF register is repurposed to apply equalization
+	 * settings at various data transmission rates through registers namely
+	 * GEN3_EQ_*. RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF determines
+	 * data rate for which this equalization settings are applied.
+	 */
+	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
+	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK, 0x1);
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
+
+	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
+	reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
+		GEN3_EQ_FMDC_N_EVALS |
+		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
+		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
+	reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
+		FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
+		FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
+		FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
+	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
+
+	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
+	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
+		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
+		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
+		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
+	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
+}
+EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
new file mode 100644
index 000000000000..259e04b7bdf9
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "pcie-designware.h"
+
+void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 236229f66c80..af83470216e8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -25,6 +25,7 @@
 
 #include "../../pci.h"
 #include "pcie-designware.h"
+#include "pcie-qcom-common.h"
 
 /* PARF registers */
 #define PARF_SYS_CTRL				0x00
@@ -486,6 +487,9 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		goto err_disable_resources;
 	}
 
+	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT)
+		qcom_pcie_common_set_16gt_eq_settings(pci);
+
 	/*
 	 * The physical address of the MMIO region which is exposed as the BAR
 	 * should be written to MHI BASE registers.
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0180edf3310e..2742e82fdcb3 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -35,6 +35,7 @@
 
 #include "../../pci.h"
 #include "pcie-designware.h"
+#include "pcie-qcom-common.h"
 
 /* PARF registers */
 #define PARF_SYS_CTRL				0x00
@@ -283,6 +284,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
+	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT)
+		qcom_pcie_common_set_16gt_eq_settings(pci);
+
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
 		pcie->cfg->ops->ltssm_enable(pcie);

-- 
2.25.1



