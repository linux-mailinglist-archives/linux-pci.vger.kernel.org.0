Return-Path: <linux-pci+bounces-1476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE7381F260
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 23:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C1C1F231C6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 22:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BD8481CF;
	Wed, 27 Dec 2023 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0d0lnHw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B248CD4
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d60ad5f0bso6406435e9.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 14:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703715462; x=1704320262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMW6ukEiM+bQd9qassIFQqfy72BMmAOOOw/d3jPA85w=;
        b=G0d0lnHwgcAIcmyksM9VgnpL/7oBNggZdwQO8Ia25EBTIfUHEFl6w4rGAW3MytS86u
         HtX95vYLFOl39FMS/bVQ7y6tvsVNBfySVjrFiXiPnrfrYkN8VktBBvRnPmL20SuVHIS+
         NbhEk1dJ6HdD2nAfZXiO9jJ3UHTK4yQelZONJ7RlJRIPkkdTGVbmTGZGYQ/VjPQRT9YZ
         KqpkYNZ9szjsItVFMxKvX7RcB8yllEc9mPU/RptdmK1xOrCnLqGfOvGVOWULwnJvuXyN
         /EfMQEWgetUUcbDrQrd6PZjAyQGAAwqEzMwAI7yvBEXcMqN2fQHHwPEQ8x18/1Dp00hA
         vIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703715462; x=1704320262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMW6ukEiM+bQd9qassIFQqfy72BMmAOOOw/d3jPA85w=;
        b=DT5/2Kmrg3Nk8GVzd38BwmUWoeG2ilRQ4tXZv0nUVx6JNBp7QVZFGLmT5P7qJNwnD8
         XwMdhCtYCQolb42mclxT0RNIHFGDLOz9LGVPvmoE7jlHcapZFY0eJPEf1SC6OWAjlw4K
         gyODEUkLkH37LYwavp+ev4qYnti179k0z1+YCpGUmnWF7vDApy1XG9UC1wobYut/eE7y
         3KnYs3EykD4drRAkwIRUfz0BmkaCsKElxnomUtAF75lyoAPKQns4ACDtmHfkRoFVGFTD
         B08cjuZMTpWGMQyP+Bo/MezmPiSpe8i0d/TXeM92xOYKTQVv0+bYQvvwnKtVsPp4x5Ii
         CCzw==
X-Gm-Message-State: AOJu0YwtncPw4DXGZqGdHso2KBnfU3SjYtDg3DeJ1YdHBnzNPvFBMvBV
	p4peGfaV2djMg3IExWtc14HxOkaF6d2eaw==
X-Google-Smtp-Source: AGHT+IEr15ffMgiQ3ANHhn07jb1hFR1fa4gU3lzjq5kUeQ+ddpFRXVz7e5oRD0tOd8r2C+rfmkD7hw==
X-Received: by 2002:a05:600c:17c5:b0:40c:23f2:c12d with SMTP id y5-20020a05600c17c500b0040c23f2c12dmr5990327wmo.153.1703715462252;
        Wed, 27 Dec 2023 14:17:42 -0800 (PST)
Received: from [10.167.154.1] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id ka12-20020a170907920c00b00a26ac57b951sm6245712ejb.23.2023.12.27.14.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 14:17:41 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Dec 2023 23:17:22 +0100
Subject: [PATCH 4/4] PCI: qcom: Implement RC shutdown/power up
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-topic-8280_pcie-v1-4-095491baf9e4@linaro.org>
References: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
In-Reply-To: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Stanimir Varbanov <svarbanov@mm-sol.com>, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>, Vinod Koul <vkoul@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703715452; l=8228;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=SOHIxQch7KXN/NGvpDtApiAK8bsu3Kt0tHCXPIEY/a0=;
 b=xVcIdOfd/R7LBqRnVfBIvqWNV9w5aFC1KSyhcHiWwrzFkZhRInKUsu+Sd0pgORsK7kjNqLb7t
 QjPMlmRMzR7DcWsREhyibEnaO9tpu+uo+5rhSL+Z7jpgINJZP/23Rb+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Currently, we've only been minimizing the power draw while keeping the
RC up at all times. This is suboptimal, as it draws a whole lot of power
and prevents the SoC from power collapsing.

Implement full shutdown and re-initialization to allow for powering off
the controller.

This is mainly intended for v1_9_0 (sc8280xp), but the hardware is rather
similar across the board. More platform-specific details may be added in
the future as necessary.

Co-developed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pci/controller/dwc/Kconfig     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 132 +++++++++++++++++++++++++--------
 2 files changed, 102 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 5ac021dbd46a..591c4109ed62 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -268,6 +268,7 @@ config PCIE_DW_PLAT_EP
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller (host mode)"
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=n
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select CRC8
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3d77269e70da..a9e24fcd1f66 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -30,13 +30,18 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <soc/qcom/cmd-db.h>
 
 #include "../../pci.h"
 #include "pcie-designware.h"
 
+#include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,rpm-icc.h>
+
 /* PARF registers */
 #define PARF_SYS_CTRL				0x00
 #define PARF_PM_CTRL				0x20
+#define PARF_PM_STTS				0x24
 #define PARF_PCS_DEEMPH				0x34
 #define PARF_PCS_SWING				0x38
 #define PARF_PHY_CTRL				0x40
@@ -80,7 +85,10 @@
 #define L1_CLK_RMV_DIS				BIT(1)
 
 /* PARF_PM_CTRL register fields */
-#define REQ_NOT_ENTR_L1				BIT(5)
+#define REQ_NOT_ENTR_L1				BIT(5) /* "Prevent L0->L1" */
+
+/* PARF_PM_STTS register fields */
+#define PM_ENTER_L23				BIT(5)
 
 /* PARF_PCS_DEEMPH register fields */
 #define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		FIELD_PREP(GENMASK(21, 16), x)
@@ -122,6 +130,7 @@
 
 /* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
+#define ELBI_SYS_CTRL_PME_TURNOFF_MSG		BIT(4)
 
 /* AXI_MSTR_RESP_COMP_CTRL0 register fields */
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
@@ -244,6 +253,7 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
+	bool soc_is_rpmh;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -273,6 +283,24 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
+static int qcom_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u32 ret_l23, val;
+
+	writel(ELBI_SYS_CTRL_PME_TURNOFF_MSG, pcie->elbi + ELBI_SYS_CTRL);
+	readl(pcie->elbi + ELBI_SYS_CTRL);
+
+	ret_l23 = readl_poll_timeout(pcie->parf + PARF_PM_STTS, val,
+				     val & PM_ENTER_L23, 10000, 100000);
+	if (ret_l23) {
+		dev_err(pci->dev, "Failed to enter L2/L3\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -991,9 +1019,19 @@ static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
 static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+	u32 val;
+
+	/* Disable PCIe clocks and resets */
+	val = readl(pcie->parf + PARF_PHY_CTRL);
+	val |= PHY_TEST_PWR_DOWN;
+	writel(val, pcie->parf + PARF_PHY_CTRL);
+	readl(pcie->parf + PARF_PHY_CTRL);
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 
+	reset_control_assert(res->rst);
+	usleep_range(2000, 2500);
+
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
@@ -1553,6 +1591,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
+	/* If the soc features RPMh, cmd_db must have been prepared by now */
+	pcie->soc_is_rpmh = !cmd_db_ready();
+
 	qcom_pcie_icc_update(pcie);
 
 	if (pcie->mhi)
@@ -1569,60 +1610,89 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_pcie_suspend_noirq(struct device *dev)
+static int qcom_pcie_resume_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
 
 	/*
-	 * Set minimum bandwidth required to keep data path functional during
-	 * suspend.
+	 * Undo the tag change from qcom_pcie_suspend_noirq first in case
+	 * RPM(h) spontaneously decides to power collapse the platform based
+	 * on other inputs.
 	 */
-	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
+	icc_set_tag(pcie->icc_mem, pcie->soc_is_rpmh ? QCOM_ICC_TAG_ALWAYS : RPM_ALWAYS_TAG);
+	/* Flush the tag change */
+	ret = icc_set_bw(pcie->icc_mem, 0, pcie->last_bw);
 	if (ret) {
-		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
+		dev_err(pcie->pci->dev, "failed to set interconnect bandwidth: %d\n", ret);
 		return ret;
 	}
 
-	pcie->last_bw = kBps_to_icc(1);
+	/* Only check this now to make sure the icc vote is in before going furhter. */
+	if (!pcie->suspended)
+		return 0;
 
-	/*
-	 * Turn OFF the resources only for controllers without active PCIe
-	 * devices. For controllers with active devices, the resources are kept
-	 * ON and the link is expected to be in L0/L1 (sub)states.
-	 *
-	 * Turning OFF the resources for controllers with active PCIe devices
-	 * will trigger access violation during the end of the suspend cycle,
-	 * as kernel tries to access the PCIe devices config space for masking
-	 * MSIs.
-	 *
-	 * Also, it is not desirable to put the link into L2/L3 state as that
-	 * implies VDD supply will be removed and the devices may go into
-	 * powerdown state. This will affect the lifetime of the storage devices
-	 * like NVMe.
-	 */
-	if (!dw_pcie_link_up(pcie->pci)) {
-		qcom_pcie_host_deinit(&pcie->pci->pp);
-		pcie->suspended = true;
-	}
+	ret = qcom_pcie_host_init(&pcie->pci->pp);
+	if (ret)
+		goto revert_icc_tag;
+
+	dw_pcie_setup_rc(&pcie->pci->pp);
+
+	ret = qcom_pcie_start_link(pcie->pci);
+	if (ret)
+		goto deinit_host;
+
+	/* Ignore the retval, the devices may come up later. */
+	dw_pcie_wait_for_link(pcie->pci);
+
+	qcom_pcie_icc_update(pcie);
+
+	pcie->suspended = false;
 
 	return 0;
+
+deinit_host:
+	qcom_pcie_host_deinit(&pcie->pci->pp);
+revert_icc_tag:
+	icc_set_tag(pcie->icc_mem, pcie->soc_is_rpmh ? QCOM_ICC_TAG_WAKE : RPM_ACTIVE_TAG);
+	/* Ignore the retval, failing here would be tragic anyway.. */
+	icc_set_bw(pcie->icc_mem, 0, pcie->last_bw);
+
+	return ret;
 }
 
-static int qcom_pcie_resume_noirq(struct device *dev)
+static int qcom_pcie_suspend_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
 
-	if (pcie->suspended) {
-		ret = qcom_pcie_host_init(&pcie->pci->pp);
+	if (pcie->suspended)
+		return 0;
+
+	if (dw_pcie_link_up(pcie->pci)) {
+		ret = qcom_pcie_stop_link(pcie->pci);
 		if (ret)
 			return ret;
+	}
 
-		pcie->suspended = false;
+	qcom_pcie_host_deinit(&pcie->pci->pp);
+
+	/*
+	 * The PCIe RC may be covertly accessed by the secure firmware on sleep exit.
+	 * Use the WAKE bucket to let RPMh pull the plug on PCIe in sleep,
+	 * but guarantee it comes back for resume.
+	 */
+	icc_set_tag(pcie->icc_mem, pcie->soc_is_rpmh ? QCOM_ICC_TAG_WAKE : RPM_ACTIVE_TAG);
+	/* Flush the tag change */
+	ret = icc_set_bw(pcie->icc_mem, 0, pcie->last_bw);
+	if (ret) {
+		dev_err(pcie->pci->dev, "failed to set interconnect bandwidth: %d\n", ret);
+
+		/* Revert everything and hope the next icc_set_bw goes through.. */
+		return qcom_pcie_resume_noirq(dev);
 	}
 
-	qcom_pcie_icc_update(pcie);
+	pcie->suspended = true;
 
 	return 0;
 }

-- 
2.43.0


