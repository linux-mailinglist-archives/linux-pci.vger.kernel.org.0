Return-Path: <linux-pci+bounces-13048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA0697570F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 17:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B1D1F240A4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 15:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341271AC88D;
	Wed, 11 Sep 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0gl2vju"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E545A1AAE01;
	Wed, 11 Sep 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068391; cv=none; b=mw57H1QIgs6gw1l+W9hIBppMJDblBOmfMa8ULisUuE1kVUc7IKXe6HvFlGPFhG5o96nyU73O3MO7pEXW3E1wamToonE7eitvsBK9nKQkp/o6mx0vrIMDlHqfzSJKn3ThQwGi94j3mYdPc4Q2TJ2+QB3kU3Kov1D7SzX6pa9ewCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068391; c=relaxed/simple;
	bh=8g9CetueQMca5kqUY57tyDJLRYWCZlLEjXZ/ksj4xqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gSm4h3amP/I3bOX/H3LOgVW/uCTfBDf3yLlkL0THVWpsVcYLM3+LjpfP9eeTeOqmMzdIdnTx12IC8N1rdVCdlVK8OtuSRJGEvxXnr2JiA7i/tGlKbcC9NNXfAwLI24tCovAJPahKYxO6scIMqKVTvvYkmw5+NapchIL4XkbNJEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0gl2vju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B9C5C4CECF;
	Wed, 11 Sep 2024 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726068390;
	bh=8g9CetueQMca5kqUY57tyDJLRYWCZlLEjXZ/ksj4xqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M0gl2vjudZRKSDnAmOKdhEGXzqrNK0VhreYXIf3RlNDMmVP6+vsoFgQBf7hXK3Jh3
	 OGuZtEzrk0H5OkHN4PnWxWICNQNW2T8ER4OQDeSjQqiMcr2XbKYBUUFAdTbz15sfVW
	 rbiFpE60IKr28/SVj7o/36jfFvoli6HCBHDz2eSbocWolwrA/ih03u1M4/sa0vPNZU
	 RezdFrun4SqdfLHDNmxKVoGyq6igNct1xNPnA6zg+K+MKG8hvIfq2juB3MTz2O45Qy
	 MW6/7A+H/Qodf+v+MKftyt5CYWioC54Kci80DBrEBxuVBkMhj/LZ4Jj0VAv5N4vacR
	 q/dk98y9LvRfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9E3EE57C2;
	Wed, 11 Sep 2024 15:26:30 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 11 Sep 2024 20:56:28 +0530
Subject: [PATCH v7 3/4] PCI: qcom: Add equalization settings for 16.0 GT/s
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-pci-qcom-gen4-stability-v7-3-743f5c1fd027@linaro.org>
References: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>
In-Reply-To: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>
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
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Pratyush Anand <pratyush.anand@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 abel.vesa@linaro.org, johan+linaro@kernel.org, 
 Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, 
 linux-tegra@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=11360;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=oLENcLDkZ9Xxlyw7bSBn//6Zm5hvtwW9ikXnMa+bJ+w=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBm4baj8l761qQDkQGUsQzfial69zmXPxPs2BPO2
 dabc+AlT16JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZuG2owAKCRBVnxHm/pHO
 9dwWB/94sV/tPUWS+NN1J78jOt2I2aSKWlmmhlkQCA9NBh+yHOpKqSBvMLn/3SD6/wpJ5NXo4Pw
 Nlt3NriovrhbGTzUZNJNb1Jn+sAzUW2G888VWBgpxShEpQ8dVFZcVqdCkTvE3ysXbrDZsbqXFsA
 B7f5m4bJ6JfMtfHH9HeSdQNESCRmFxBjbdpItGfSLPb0iK+pb2nG+uemjqMejd/J1hPLjzUGQb8
 GTmO5IJBXoeefbcu2d/MDobERUkz6jOomJxLZq3cpviDjpZFfiLHs9Slk96IKdLGj8EtdDRl+TZ
 EzSf20r1/3dVESylkfhhRYflEoua5sXYYG0zZZ8+3nu1pFk1
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

While at it, let's also modify the pcie-tegra194 driver to make use of the
common GEN3_EQ_CONTROL_OFF definitions in pcie-designware.h.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[mani: dropped the code refactoring and minor changes]
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS                                   |  4 ++-
 drivers/pci/controller/dwc/Kconfig            |  5 +++
 drivers/pci/controller/dwc/Makefile           |  1 +
 drivers/pci/controller/dwc/pcie-designware.h  | 13 ++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.c | 47 +++++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h | 13 ++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  4 +++
 drivers/pci/controller/dwc/pcie-qcom.c        |  4 +++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 19 ++++-------
 9 files changed, 97 insertions(+), 13 deletions(-)

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
index 22765564f301..7e3a9632fbe8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -125,6 +125,19 @@
 #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
+#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT	0x1
+
+#define GEN3_EQ_CONTROL_OFF			0x8A8
+#define GEN3_EQ_CONTROL_OFF_FB_MODE		GENMASK(3, 0)
+#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE	BIT(4)
+#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC	GENMASK(23, 8)
+#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL	BIT(24)
+
+#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF		0x8AC
+#define GEN3_EQ_FMDC_T_MIN_PHASE23		GENMASK(4, 0)
+#define GEN3_EQ_FMDC_N_EVALS			GENMASK(9, 5)
+#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA	GENMASK(13, 10)
+#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA	GENMASK(17, 14)
 
 #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
 #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
new file mode 100644
index 000000000000..596a35449de1
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -0,0 +1,47 @@
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
+void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
+{
+	u32 reg;
+
+	/*
+	 * GEN3_RELATED_OFF register is repurposed to apply equalization
+	 * settings at various data transmission rates through registers namely
+	 * GEN3_EQ_*. The RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
+	 * determines the data rate for which these equalization settings are
+	 * applied.
+	 */
+	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
+	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
+			  GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT);
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
+EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_equalization);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
new file mode 100644
index 000000000000..536387e02e29
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _PCIE_QCOM_COMMON_H
+#define _PCIE_QCOM_COMMON_H
+
+struct dw_pcie;
+
+void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci);
+
+#endif
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 236229f66c80..b091432d9f90 100644
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
+		qcom_pcie_common_set_16gt_equalization(pci);
+
 	/*
 	 * The physical address of the MMIO region which is exposed as the BAR
 	 * should be written to MHI BASE registers.
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0180edf3310e..6f7957c4adcc 100644
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
+		qcom_pcie_common_set_16gt_equalization(pci);
+
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
 		pcie->cfg->ops->ltssm_enable(pcie);
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4bf7b433417a..6e03e14151d6 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -177,11 +177,6 @@
 #define N_FTS_VAL					52
 #define FTS_VAL						52
 
-#define GEN3_EQ_CONTROL_OFF			0x8a8
-#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT	8
-#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK	GENMASK(23, 8)
-#define GEN3_EQ_CONTROL_OFF_FB_MODE_MASK	GENMASK(3, 0)
-
 #define PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT	0x8D0
 #define AMBA_ERROR_RESPONSE_CRS_SHIFT		3
 #define AMBA_ERROR_RESPONSE_CRS_MASK		GENMASK(1, 0)
@@ -861,9 +856,9 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
-	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK;
-	val |= (0x3ff << GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT);
-	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE_MASK;
+	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC;
+	val |= FIELD_PREP(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC, 0x3ff);
+	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE;
 	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
@@ -872,10 +867,10 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
-	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK;
-	val |= (pcie->of_data->gen4_preset_vec <<
-		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT);
-	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE_MASK;
+	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC;
+	val |= FIELD_PREP(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC,
+			  pcie->of_data->gen4_preset_vec);
+	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE;
 	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);

-- 
2.25.1



