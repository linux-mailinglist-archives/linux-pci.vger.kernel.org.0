Return-Path: <linux-pci+bounces-3327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28515850593
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 18:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC811C236B1
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEE45D751;
	Sat, 10 Feb 2024 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+DY11qL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D15D486
	for <linux-pci@vger.kernel.org>; Sat, 10 Feb 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585020; cv=none; b=nvZs4Ge3yB6DI7CGfOcZSQME6xP+V5cUn99blkYHfg0dpaAsQ+a81vPAfzfEN/dQgpc33u5YMfbrm6jzjfZKjIEyOYTastFkNw/lQDfzOwCPkLXFqZDZjkcepv4jXQjFR2Hlsjh2pxvu0JY+smApKQs4Yga1KxeDWkgtHuZ9H8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585020; c=relaxed/simple;
	bh=wE4PKuF9KFooytVFW0iQrweEQ1kdbfao/3lAPwkkUOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V4enWsQHVSfH4KOJwMbsxR2WtGi4bDixwAA7hFJChzXJJLR3c4+vgkbP9z157WtWAEhkNm/OMCasw6iGk61N15IHnkapociyQZHdWGpPTA8qk1b0HhPvGIekAcpJaJBUg0dLB8Gz5J7A330qAQ4XPG4EVSk4PhgrOSKHZbKv+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t+DY11qL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3864258438so348629366b.0
        for <linux-pci@vger.kernel.org>; Sat, 10 Feb 2024 09:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707585016; x=1708189816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYtbA2sJ08AZFlGOFG+9KX+Za91jaMGA0SaDjbtpsAk=;
        b=t+DY11qLYpSCGEKVESKqDdZVgzBdsQRfrryC8LByahLWkR5EG6DJ9z6IlH6Zr7sYR8
         zberEMFxJ7iJDov2F3L648OMTOhG0uOplPCyJeMhLJQ6pm69wkOwgpJGC7USUJKr0EH/
         TR+UKt/tIrWl+WPv7C6Ym75x18wdC3Tey3iwI2Y8rxS6hpzmF0XiGkcSVQNWb20hneCg
         b7hos0/bin4cRQV0wAzCloYQVgRg//dxXuo8Y0L1D+cs88JF5tMU06hEHDRwVbmPOzKY
         8BUIz/2bRCsKv7SKUarByP05fTYR/D3LAUnXctH5wGcg+888QXeB5iXHTB/fYKynfFBn
         entQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707585016; x=1708189816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYtbA2sJ08AZFlGOFG+9KX+Za91jaMGA0SaDjbtpsAk=;
        b=Rz9JkwPyuXBKm1MIpE2L8gnxnHHWnf3ZxFojbFMi92PE8T27nmHgR8zEue/DD6e+cZ
         VN7qzUzbqoqMiF2GFQs0AFMuNLbleEeeIcNkF+9q3yMO18sfgJdNoJ172uxuNYuO/ctd
         iolDYD5eRcAtDSEmLlKL4VL0o+lzdxEQOCcK5t9B7MLdqk8U29LnmbFi6ECHJxwRAUD3
         ++9my/ZiJ0FWXLmW1b3ESQq76MLxbByMFqB0KMh756QOX2VQJB5lqox9Ux6o5xZeROxh
         8cw3BmdRBeTPhYnk/yaeJrgrbMxBWacBVLsfhMdJ5BIWZBG1PK/up3pdP36demQwe1T8
         LgYA==
X-Forwarded-Encrypted: i=1; AJvYcCUc5VdhyvQAz7Ir9jkKTnTyc9KJVRS6a1cJcfvoYSln8+VuzDKA6Mt0BMqn/2wc5/Qy0m44v6IaZfibRRwquB3SCpJV40feT37S
X-Gm-Message-State: AOJu0YzYf19UP3EmgKmXWPI8VCenI8/dH3D7BAXVhBC1ythyMXb1uELg
	HjOyLIoKW526TDKDl3u8uku6dEMkOe9H9ynMp5CY1lKA+V/wLiuGii4hPPyT2Bc=
X-Google-Smtp-Source: AGHT+IGFWghOq1zSr8fO07eUw3+OQadic5XoDgs3HjkNmTbQKGSy1KVwMnF/WHTfiv4S6rLz86Hqjg==
X-Received: by 2002:a17:906:29c5:b0:a38:833b:c8ad with SMTP id y5-20020a17090629c500b00a38833bc8admr3345318eje.16.1707585016654;
        Sat, 10 Feb 2024 09:10:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNWwCR4k9y6uamWkS0Jgu4fUGhqdbt7ZcPSXGhCiVKYdq6GvcH+u7xgpYYQXOmT92H1gIaQDIIC4HZesobK0DT+gdTMOG1Vm6f0g6e4LmSmH64f4lv0TSAh4Zr4KMqCD8JUpqAfXp88PFEOa15NRu2h0dGa4hGp83UQHcWP+xNk7gcCelOltice8ArdZVlSCoLe2RBzaKudzU3OkMV0KhXjzWy30h5VgN0r15tEvCgH0/qBAQSi8Mxf55TGn+vbkiVtyxmjjKBeAYQalGyRl2wrH0S9NmwpKucgmk6yCjCd7lZaG+IK14YjZtmK0GLuZQRW5rGrMfmJlnGgw0ZTTS8Wt8lkd68YwRu3Qg/Vx549pLTaAKHLj5Rh4sNI/qRSC+aR6JDBzx5S/aoD1rUr6TQOBT4iDhDl7w0tg==
Received: from [127.0.1.1] (abyl12.neoplus.adsl.tpnet.pl. [83.9.31.12])
        by smtp.gmail.com with ESMTPSA id lg25-20020a170907181900b00a3c1e1ca800sm973242ejc.11.2024.02.10.09.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:10:16 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 10 Feb 2024 18:10:07 +0100
Subject: [PATCH v2 3/3] PCI: qcom: properly implement RC shutdown/power up
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-topic-8280_pcie-v2-3-1cef4b606883@linaro.org>
References: <20240210-topic-8280_pcie-v2-0-1cef4b606883@linaro.org>
In-Reply-To: <20240210-topic-8280_pcie-v2-0-1cef4b606883@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.13-dev-0438c

Currently, we've only been minimizing the power draw while keeping the
RC up at all times. This is suboptimal, as it draws a whole lot of power
and prevents the SoC from power collapsing.

Implement full shutdown and re-initialization to allow for powering off
the controller.

This is mainly indended for SC8280XP with a broken power rail setup,
which requires a full RC shutdown/reinit in order to reach SoC-wide
power collapse, but sleeping is generally better than not sleeping and
less destructive suspend can be implemented later for platforms that
support it.

Co-developed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pci/controller/dwc/Kconfig     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 159 ++++++++++++++++++++++++++-------
 2 files changed, 126 insertions(+), 34 deletions(-)

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
index 6a469ed213ce..c807833ee4a7 100644
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
@@ -243,6 +252,7 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
+	bool soc_is_rpmh;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -272,6 +282,24 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
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
@@ -987,9 +1015,19 @@ static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
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
 
@@ -1545,6 +1583,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
+	/* If the soc features RPMh, cmd_db must have been prepared by now */
+	pcie->soc_is_rpmh = !cmd_db_ready();
+
 	qcom_pcie_icc_update(pcie);
 
 	if (pcie->mhi)
@@ -1561,58 +1602,108 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
2.40.1


