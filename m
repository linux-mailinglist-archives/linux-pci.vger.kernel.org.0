Return-Path: <linux-pci+bounces-5292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B3D88EF82
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 20:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63721C307E5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05503152E13;
	Wed, 27 Mar 2024 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLJVJQIO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43F152DE9
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568964; cv=none; b=nmha2umblAOG4ju+1VAgZrHk9Jo06A8701OSYfxyyDxTTumS+EPcjs80lg1cKIMjHdvehu1UUG+d0F3xnnpjJpqNuVMfEJPo2f0BIjnWwg5XNKG8xYiggLAt0T4Ppvh19kIQcEgr82LbQZom2xUpEV31oT8u7+2AzE9NwVlLyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568964; c=relaxed/simple;
	bh=1S6D/JY3KLoJmr8wGe/Dmw5boyY+i2H88C3gEZ34OCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kSJQ2ONY/sR3b0OWWU1ebQclFzNdJ4GIJzV5QuFAavkd9VKdOVQBWcxkXCDhEBjEnROj7Ir2DRJZNZVU8+D5kIUGx5nFMPuBi7wsI2ywUqYsKEePAPCdLPATn4RoN4qLGfNnave2avVMJrhzzLfok44yn7OMY5hp97CUf7EcjaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pLJVJQIO; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513e89d0816so156904e87.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 12:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711568961; x=1712173761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eDPJyDX8czhPyAaXOvjbQyQlZrq8DHkycEJC9OJrp0=;
        b=pLJVJQIOPrTRUf3LKRdRusOKfaedz4X3TPURdZK0i6GFWQdlkGhqZBplY2JxxH/A15
         XPt3izRX25RLxjLIqqB+tjTj6CWAml02p8VCFvVJRJehEyR88oHe1cFTXK+a1TZm+GA4
         AO3qlDN80P8ryjVOozLg8DYAdr2t3ZM6Y6sCoLENB5V1CM/EfjBkxzGO+q0r6zSHQi4W
         bLqrZY6VTHnbAEexg3LrLcxj11pO0+tFdwcZcAnJh4lOYu3bsrbcwjFIq76cpq+/JAln
         7HhRc1cLWwAL7VVwkxW3zGhfSE7krO+vGRRDJkRdQYTMrrqe2eGJZ5KFTW0W/XC0CShV
         wkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568961; x=1712173761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eDPJyDX8czhPyAaXOvjbQyQlZrq8DHkycEJC9OJrp0=;
        b=JPOdSP8H/aLux7DW+HdbOLHnwvhoYhToUZU78gayuJecGGjJNgwoNvykorS/CadA87
         FQK9CFERyfsAK5mXpdZ2B7/D3lU5bfrOxLD23GKkUUGbE/ID5ohmQ/Pax7L/tIt6n7Jt
         gNo3Q9/eObW5jmuS4irDWIofr3urgmx4hj8pJnuaJH3O3Wo6e/2P4actynliXWEt6/oU
         lwZ7AQi6nNOEx6Eobq1qF/UqO1NZrp6nNPwlpbEUaz+XzxkTUf2hIPPVN+T8DzQ0A7D9
         JPoCdClFcS0YfByFwJyM8GGLt1l4wzNyfxWbWTnoJ4aO7INvC7DDecXVgwgQwlUklFCg
         X4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVwLuivzbZF95+d9NmilnaNVADIzIYGPzpF6KlXeXt3O4jon7sNjt0MWj0tZt5WvuhLtCEF60mr4J0KTAIjCmq1PoZCjOuP8C7+
X-Gm-Message-State: AOJu0Ywh1eQtFcHbR+mZHOviqQFfoKN5HYRgGMgLr3mdMPbjkbxoJHNk
	BiPGnfcpnfZTe2b4uREOwVj5XRR1WvSSKgil43BKtI9qVg3pUYlwhES+65FSohF6UNTj30KWh9Q
	W
X-Google-Smtp-Source: AGHT+IGhyLIDzblCUi77Pa5S3zbnC8ng8y/OaVOZkt/XQHkFAft9znKQeGVgOn7u9hJgI6ytgH1XIg==
X-Received: by 2002:a19:4359:0:b0:512:b0a7:2943 with SMTP id m25-20020a194359000000b00512b0a72943mr342514lfj.5.1711568960890;
        Wed, 27 Mar 2024 12:49:20 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4e0ce293cfsm582147ejb.41.2024.03.27.12.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:49:20 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Mar 2024 20:49:09 +0100
Subject: [PATCH v3 2/2] PCI: qcom: properly implement RC shutdown/power up
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-topic-8280_pcie-v3-2-ee7af6f892a0@linaro.org>
References: <20240210-topic-8280_pcie-v3-0-ee7af6f892a0@linaro.org>
In-Reply-To: <20240210-topic-8280_pcie-v3-0-ee7af6f892a0@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711568954; l=8480;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1S6D/JY3KLoJmr8wGe/Dmw5boyY+i2H88C3gEZ34OCs=;
 b=zKoXnvvVFOZPsGWDxzU2b+5Yg2oSt1zdlkrciUMhfPFWCm5Bso6eVBh9HXumdqeJFbxSn2KAF
 vXEBN3ML5JvCOM1s6IY8IkpnN4hZJShWwbXBLltoygvmOaD/DJy48i2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Currently, we've only been minimizing the power draw while keeping the
RC up at all times. This is suboptimal, as it draws a whole lot of power
and prevents the SoC from power collapsing.

Implement full shutdown and re-initialization to allow for powering off
the controller.

This is mainly intended for SC8280XP with a broken power rail setup,
which requires a full RC shutdown/reinit in order to reach SoC-wide
power collapse, but sleeping is generally better than not sleeping and
less destructive suspend can be implemented later for platforms that
support it.

Co-developed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pci/controller/dwc/Kconfig     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 158 ++++++++++++++++++++++++++-------
 2 files changed, 125 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 8afacc90c63b..4ce266951cb6 100644
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
index d875a9b2b7be..8fb3532f4651 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -30,13 +30,17 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <soc/qcom/cmd-db.h>
 
 #include "../../pci.h"
 #include "pcie-designware.h"
 
+#include <dt-bindings/interconnect/qcom,icc.h>
+
 /* PARF registers */
 #define PARF_SYS_CTRL				0x00
 #define PARF_PM_CTRL				0x20
+#define PARF_PM_STTS				0x24
 #define PARF_PCS_DEEMPH				0x34
 #define PARF_PCS_SWING				0x38
 #define PARF_PHY_CTRL				0x40
@@ -81,7 +85,10 @@
 #define L1_CLK_RMV_DIS				BIT(1)
 
 /* PARF_PM_CTRL register fields */
-#define REQ_NOT_ENTR_L1				BIT(5)
+#define REQ_NOT_ENTR_L1				BIT(5) /* "Prevent L0->L1" */
+
+/* PARF_PM_STTS register fields */
+#define PM_ENTER_L23				BIT(5)
 
 /* PARF_PCS_DEEMPH register fields */
 #define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		FIELD_PREP(GENMASK(21, 16), x)
@@ -126,6 +133,7 @@
 
 /* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
+#define ELBI_SYS_CTRL_PME_TURNOFF_MSG		BIT(4)
 
 /* AXI_MSTR_RESP_COMP_CTRL0 register fields */
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
@@ -248,6 +256,7 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
+	bool soc_is_rpmh;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -277,6 +286,24 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
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
 static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
@@ -1012,9 +1039,19 @@ static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
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
 
@@ -1581,6 +1618,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
+	/* If the soc features RPMh, cmd_db must have been prepared by now */
+	pcie->soc_is_rpmh = !cmd_db_ready();
+
 	qcom_pcie_icc_update(pcie);
 
 	if (pcie->mhi)
@@ -1597,58 +1637,108 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_pcie_suspend_noirq(struct device *dev)
+static int qcom_pcie_resume_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
 
-	/*
-	 * Set minimum bandwidth required to keep data path functional during
-	 * suspend.
-	 */
-	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
-	if (ret) {
-		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
-		return ret;
+	if (pcie->soc_is_rpmh) {
+		/*
+		 * Undo the tag change from qcom_pcie_suspend_noirq first in
+		 * case RPMh spontaneously decides to power collapse the
+		 * platform based on other inputs.
+		 */
+		icc_set_tag(pcie->icc_mem, QCOM_ICC_TAG_ALWAYS);
+
+		/* Flush the tag change */
+		ret = icc_enable(pcie->icc_mem);
+		if (ret) {
+			dev_err(pcie->pci->dev, "failed to icc_enable: %d", ret);
+			return ret;
+		}
 	}
 
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
+	/* Only check this now to make sure the icc tag has been set. */
+	if (!pcie->suspended)
+		return 0;
+
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
+	if (pcie->soc_is_rpmh) {
+		icc_set_tag(pcie->icc_mem, QCOM_ICC_TAG_WAKE);
+
+		/* Ignore the retval, failing here would be tragic anyway.. */
+		icc_enable(pcie->icc_mem);
+	}
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
+	if (pcie->soc_is_rpmh) {
+		/*
+		 * The PCIe RC may be covertly accessed by the secure firmware
+		 * on sleep exit. Use the WAKE bucket to let RPMh pull the plug
+		 * on PCIe in sleep, but guarantee it comes back up for resume.
+		 */
+		icc_set_tag(pcie->icc_mem, QCOM_ICC_TAG_WAKE);
+
+		/* Flush the tag change */
+		ret = icc_enable(pcie->icc_mem);
+		if (ret) {
+			dev_err(pcie->pci->dev, "failed to icc_enable %d\n", ret);
+
+			/* Revert everything and pray icc calls succeed */
+			return qcom_pcie_resume_noirq(dev);
+		}
+	} else {
+		/*
+		 * Set minimum bandwidth required to keep data path functional
+		 * during suspend.
+		 */
+		ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
+		if (ret) {
+			dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
+			return ret;
+		}
 	}
 
-	qcom_pcie_icc_update(pcie);
+	pcie->suspended = true;
 
 	return 0;
 }

-- 
2.44.0


