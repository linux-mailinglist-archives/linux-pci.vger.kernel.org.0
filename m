Return-Path: <linux-pci+bounces-3825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B405F85DD70
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 15:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EF81F231FA
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687CF7E799;
	Wed, 21 Feb 2024 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JzIjTMzG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1512D7D3E3;
	Wed, 21 Feb 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524276; cv=none; b=g5bA4+0L327O1Eok+1xLbx4KQTEZ1JHpgTY2E3hXgbqp0Qh9GrfcHXgaPkX4DznohdhZjxjpwd0ozQEtptbmJoHZDZFOfcJUZX4vlDLH8j5PO0cq4JHwdzlD5x+Bh4xUxtyScWZfdk533dsxfglRBOropeNN///b+5yuC6jA0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524276; c=relaxed/simple;
	bh=jKHfHJLbb646bFwS+TVsYwts353+UPrd5uRaTDJ9P84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CRONMd1qvJGddYWwJnC5sASzo65TXsVC5yoGF/mn89x4+cM4fTp2qaLR43TeqPt6F/b2cto/lu5qy/xfivjVx+V3YZMTGQCdMbauWfMHEb4lC4Zij5y9e3gEH8RdNw/y/vl5qJO2/gLTc0kzVvJqe1Bjfhyk0F6sB/Obz9FM7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hu-msarkar-hyd.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JzIjTMzG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hu-msarkar-hyd.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LDUKpw009553;
	Wed, 21 Feb 2024 14:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=Tpx8bfM
	fXMy6EkMR2lV7rJQi8Jwr4iKQdbtQyqtKqiQ=; b=JzIjTMzGeQWoypjfY8LJ5Zo
	Br/dG2fkTxyzoeibx3ti0rPxs4sxpO755JX7r1TBA92z9cEN7iX0WOkSeVQuohjv
	0TQDBJ+WBD7d+dx+VtV/PFW6hf7bnU7p0t8wzsLUX12qWSkF549lkViuBWyekwsH
	B/qiYETc28kSptMTlbuxdeRojPqu6b90qmwPoz2lVbjWuk+TaYegM2LNCVKQ+ifl
	lo9eTvAYslEJptIG1AUrs8e20mqTRpKFI7dipTpq4noNO9Ic0asj3OxlUwkSUBBA
	YiTXzm19UL3kBU4M9r/AXKj9Bc6QeXIQoSxDEDZh5+8mvw/PBvmRsk8BawlfIbA=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdfm38dj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 14:04:17 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41LE4B7c013249;
	Wed, 21 Feb 2024 14:04:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wanvkycgp-1;
	Wed, 21 Feb 2024 14:04:14 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41LE4E4Q013318;
	Wed, 21 Feb 2024 14:04:14 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 41LE4EhK013315;
	Wed, 21 Feb 2024 14:04:14 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 0)
	id 3430C39B8; Wed, 21 Feb 2024 19:34:13 +0530 (+0530)
From: root <root@hu-msarkar-hyd.qualcomm.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org,
        conor+dt@kernel.org, quic_nitegupt@quicinc.com
Cc: quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, Nitesh Gupta <nitegupt@quicinc.com>,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] PCI: qcom: Add support for detecting controller level PCIe errors
Date: Wed, 21 Feb 2024 19:34:04 +0530
Message-Id: <20240221140405.28532-4-root@hu-msarkar-hyd.qualcomm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240221140405.28532-1-root@hu-msarkar-hyd.qualcomm.com>
References: <20240221140405.28532-1-root@hu-msarkar-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WPYgCo4vdFuwidjhMFipRSqHelEtk5Gb
X-Proofpoint-ORIG-GUID: WPYgCo4vdFuwidjhMFipRSqHelEtk5Gb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210109

From: Nitesh Gupta <nitegupt@quicinc.com>

Synopsys Controllers provide capabilities to detect various controller
level errors. These can range from controller interface error to random
PCIe configuration errors. This patch intends to add support to detect
these errors and report it to userspace entity via sysfs, which can take
appropriate actions to mitigate the errors.

Signed-off-by: Nitesh Gupta <nitegupt@quicinc.com>
Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware.h |  26 ++
 drivers/pci/controller/dwc/pcie-qcom.c       | 350 +++++++++++++++++++
 2 files changed, 376 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae4837462..cd45f9a2f9bc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -223,6 +223,32 @@
 
 #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
 
+
+/*
+ * Error Reporting DBI register
+ */
+#define DBI_DEVICE_CONTROL_DEVICE_STATUS	0x78
+#define DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG	0x8c
+#define DBI_INTERFACE_TIMER_STATUS		0x938
+#define DBI_SAFETY_MASK_OFF			0x960
+#define DBI_SAFETY_STATUS			0x964
+
+#define DBI_ADV_ERR_CAP_CTRL_OFF		0x18
+#define DBI_ROOT_ERR_CMD_OFF			0x2c
+
+/*
+ * RAS-DP register
+ */
+#define PCIE_RASDP_ERROR_MODE_EN_REG		0x28
+#define RASDP_ERROR_MODE_EN			BIT(0)
+
+/*
+ * Interface Timer register
+ */
+#define PCIE_INTERFACE_TIMER_CONTROL		0x930
+#define INTERFACE_TIMER_EN			BIT(0)
+#define INTERFACE_TIMER_AER_EN			BIT(1)
+
 /*
  * The default address offset between dbi_base and atu_base. Root controller
  * drivers are not required to initialize atu_base if the offset matches this
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 10f2d0bb86be..138e3b08d4b9 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/device.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
@@ -68,6 +69,73 @@
 #define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1	0xc84
 #define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2	0xc88
 
+/* Error Reporting Parf Registers */
+#define PARF_INT_ALL_STATUS			0x224
+#define PARF_INT_ALL_CLEAR			0x228
+#define PARF_INT_CLEAR				0x21c
+#define PARF_INT_STATUS			0x220
+#define PARF_INT_ALL_MASK			0x22c
+#define PARF_INT_ALL_2_CLEAR			0x504
+#define PARF_INT_ALL_2_STATUS			0x500
+#define PARF_INT_ALL_3_CLEAR			0x2e14
+#define PARF_INT_ALL_3_STATUS			0x2e10
+#define PARF_INT_ALL_4_CLEAR			0x2dd8
+#define PARF_INT_ALL_4_STATUS			0x2dd0
+#define PARF_INT_ALL_5_CLEAR			0x2ddc
+#define PARF_INT_ALL_5_STATUS			0x2dd4
+#define PARF_CFG_SAFETY_INT_MASK_CTRL		0x2c60
+
+
+#define PCIE_AER_EXT_CAP_ID			0x01
+#define PCI_EXT_CAP_RASDP_ID			0x0b
+
+/* Interrupt Masks */
+#define CFGPCIE_INT_ALL_STATUS_MASK		0x3ff3e
+#define CFGPCIE_PARF_INT_STATUS_MASK		0x1b
+#define CFGPCIE_INTERFACE_TIMER_STATUS_MASK	0xe7b
+#define CFGPCIE_INT_ALL_2_STATUS_MASK		GENMASK(24, 0)
+#define CFGPCIE_INT_ALL_3_STATUS_MASK		GENMASK(31, 0)
+#define CFGPCIE_INT_ALL_4_STATUS_MASK		GENMASK(31, 0)
+#define CFGPCIE_INT_ALL_5_STATUS_MASK		GENMASK(31, 0)
+
+/* PCI_INTERRUPT_LINE register field */
+#define SERR_EN					BIT(17)
+
+/* DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG register fields */
+#define PCIE_CAP_SYS_ERR_ON_CORR_ERR_EN		BIT(0)
+#define PCIE_CAP_SYS_ERR_ON_NON_FATAL_ERR_EN	BIT(1)
+#define PCIE_CAP_SYS_ERR_ON_FATAL_ERR_EN	BIT(2)
+
+/* DBI_DEVICE_CONTROL_DEVICE_STATUS register fields */
+#define PCIE_CAP_UNSUPPORT_REQ_REP_EN		BIT(3)
+#define PCIE_CAP_FATAL_ERR_REPORT_EN		BIT(2)
+#define PCIE_CAP_NON_FATAL_ERR_REPORT_EN	BIT(1)
+#define PCIE_CAP_CORR_ERR_REPORT_EN		BIT(0)
+
+/* PARF_CFG_SAFETY_INT_MASK_CTRL register fields */
+#define CFG_SAFETY_UNCORR_INT_MASK		BIT(0)
+#define CFG_SAFETY_CORR_INT_MASK		BIT(1)
+
+/* DBI_ADV_ERR_CAP_CTRL_OFF register fields */
+#define ECRC_GEN_EN				BIT(6)
+#define ECRC_CHECK_EN				BIT(8)
+
+/* DBI_ROOT_ERR_CMD_OFF register fields */
+#define CORR_ERR_REPORTING_EN			BIT(0)
+#define NON_FATAL_ERR_REPORTING_EN		BIT(1)
+#define FATAL_ERR_REPORTING_EN			BIT(2)
+
+/* DBI_SAFETY_MASK_OFF register fields */
+#define SAFETY_INT_MASK			GENMASK(5, 0)
+
+/* DBI_SAFETY_STATUS register fields */
+#define PCIE_RASDP_UNCORR_ERR			BIT(0)
+#define PCIE_IFACE_TMR_ERR			BIT(1)
+#define PCIE_CDM_CHK_ERR			BIT(2)
+#define PCIE_AER_UNCORR_ERR			BIT(3)
+#define PCIE_AER_CORR_ERR			BIT(4)
+#define PCIE_RASDP_CORR_ERR			BIT(5)
+
 /* PARF_SYS_CTRL register fields */
 #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
 #define MST_WAKEUP_EN				BIT(13)
@@ -231,6 +299,24 @@ struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
 };
 
+enum qcom_pcie_fault_code {
+	RASDP_UNCORR_ERROR,	/* RASDP uncorrectable error */
+	RASDP_CORR_ERROR,	/* RASDP correctable error */
+	CDM_REG_CHK_ERROR,	/* CDM register check error */
+	INTERFACE_TIMER_ERROR,	/* PCIe local bus interface timer error */
+	PCIE_SPURIOUS_INT,	/* Spurious Interrupt received */
+	MAX_PCIE_SAFETY_FAULT	/* Maximum PCIe fault source code supported */
+};
+
+static const char * const pcie_fault_string[] = {
+	"RASDP_Uncorr_Error",
+	"RASDP_Corr_Error",
+	"CDM_Reg_Chk_Error",
+	"Interface_Timer_Error",
+	"PCIe_Spurious_Interrupt",
+	"TOTAL_PCIE_FAULTS",
+};
+
 struct qcom_pcie {
 	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
@@ -243,6 +329,10 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
+	int global_irq;
+	spinlock_t safety_lock;
+	u32 pcie_fault[MAX_PCIE_SAFETY_FAULT];
+	u32 pcie_fault_total;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -959,9 +1049,94 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	return ret;
 }
 
+static void qcom_pcie_enable_error_reporting_2_7_0(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u32 val, offset;
+
+	/* Clear all the interrupts before we enable it */
+	writel(0, pci->dbi_base + DBI_SAFETY_STATUS);
+	writel(0, pci->dbi_base + DBI_INTERFACE_TIMER_STATUS);
+
+	/* Enable interrupts which are aggregated using GLOBAL_INT */
+	writel(CFGPCIE_INT_ALL_STATUS_MASK, pcie->parf + PARF_INT_ALL_CLEAR);
+	writel(CFGPCIE_PARF_INT_STATUS_MASK, pcie->parf + PARF_INT_CLEAR);
+	writel(CFGPCIE_INT_ALL_2_STATUS_MASK, pcie->parf + PARF_INT_ALL_2_CLEAR);
+	writel(CFGPCIE_INT_ALL_3_STATUS_MASK, pcie->parf + PARF_INT_ALL_3_CLEAR);
+	writel(CFGPCIE_INT_ALL_4_STATUS_MASK, pcie->parf + PARF_INT_ALL_4_CLEAR);
+	writel(CFGPCIE_INT_ALL_5_STATUS_MASK, pcie->parf + PARF_INT_ALL_5_CLEAR);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = readl(pci->dbi_base + PCI_INTERRUPT_LINE);
+	val |= SERR_EN;
+	writel(val, pci->dbi_base + PCI_INTERRUPT_LINE);
+
+	val = readl(pci->dbi_base + DBI_DEVICE_CONTROL_DEVICE_STATUS);
+	val |= (PCIE_CAP_CORR_ERR_REPORT_EN | PCIE_CAP_NON_FATAL_ERR_REPORT_EN |
+			PCIE_CAP_FATAL_ERR_REPORT_EN | PCIE_CAP_UNSUPPORT_REQ_REP_EN);
+	writel(val, pci->dbi_base + DBI_DEVICE_CONTROL_DEVICE_STATUS);
+
+	val = readl(pci->dbi_base + DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG);
+	val |= (PCIE_CAP_SYS_ERR_ON_CORR_ERR_EN | PCIE_CAP_SYS_ERR_ON_NON_FATAL_ERR_EN |
+			PCIE_CAP_SYS_ERR_ON_FATAL_ERR_EN);
+	writel(val, pci->dbi_base + DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	/* Enable RAS-DP Interrupts */
+	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_RASDP_ID);
+	val = readl(pci->dbi_base + offset + PCIE_RASDP_ERROR_MODE_EN_REG);
+	val |= RASDP_ERROR_MODE_EN;
+	writel(val, pci->dbi_base + PCIE_RASDP_ERROR_MODE_EN_REG);
+
+	/* Enable CDM Check */
+	val = readl(pci->dbi_base + PCIE_PL_CHK_REG_CONTROL_STATUS);
+	/* Enable continuous CMD register check mode */
+	val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS;
+	/* Start the CDM register check */
+	val |= PCIE_PL_CHK_REG_CHK_REG_START;
+	/* Enable comparison CDM register check mode */
+	val |= PCIE_PL_CHK_REG_CHK_REG_COMPARISON_ERROR;
+	/* Enable logic CDM register check mode */
+	val |= PCIE_PL_CHK_REG_CHK_REG_LOGIC_ERROR;
+	writel(val, pci->dbi_base + PCIE_PL_CHK_REG_CONTROL_STATUS);
+
+	/* Interface Timer Enable */
+	val = readl(pci->dbi_base + PCIE_INTERFACE_TIMER_CONTROL);
+	val |=  (INTERFACE_TIMER_EN | INTERFACE_TIMER_AER_EN);
+	writel(val, pci->dbi_base + PCIE_INTERFACE_TIMER_CONTROL);
+
+	/* Enable safety correctable and uncorrectable error reporting */
+	val = readl(pcie->parf + PARF_CFG_SAFETY_INT_MASK_CTRL);
+	val |= (CFG_SAFETY_UNCORR_INT_MASK | CFG_SAFETY_CORR_INT_MASK);
+	writel(val, pcie->parf + PARF_CFG_SAFETY_INT_MASK_CTRL);
+
+	/* Enable CRC check and generation */
+	offset = dw_pcie_find_ext_capability(pci, PCIE_AER_EXT_CAP_ID);
+	val = readl(pci->dbi_base + offset + DBI_ADV_ERR_CAP_CTRL_OFF);
+	val |= (ECRC_GEN_EN | ECRC_CHECK_EN);
+	writel(val, pci->dbi_base + offset + DBI_ADV_ERR_CAP_CTRL_OFF);
+
+	/* Enable AER */
+	val = readl(pci->dbi_base + offset + DBI_ROOT_ERR_CMD_OFF);
+	val |= (CORR_ERR_REPORTING_EN | NON_FATAL_ERR_REPORTING_EN
+		| FATAL_ERR_REPORTING_EN);
+	writel(val, pci->dbi_base + offset + DBI_ROOT_ERR_CMD_OFF);
+
+	/* Enable interrupts */
+	val = readl(pci->dbi_base + DBI_SAFETY_MASK_OFF);
+	val &= ~(SAFETY_INT_MASK);
+	writel(val, pci->dbi_base + DBI_SAFETY_MASK_OFF);
+
+	/* Disable Legacy Interrupts */
+	writel(0, pcie->parf + PARF_INT_ALL_MASK);
+}
+
 static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
 	qcom_pcie_clear_hpc(pcie->pci);
+	qcom_pcie_enable_error_reporting_2_7_0(pcie);
 
 	return 0;
 }
@@ -1416,6 +1591,130 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 	}
 }
 
+static void qcom_pcie_check_spurious_int(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u32 *pcie_fault = pcie->pcie_fault;
+	struct device *dev = pci->dev;
+	struct kobject *kobj_ref = &dev->kobj;
+	u32 val;
+
+	val = readl(pci->dbi_base + DBI_INTERFACE_TIMER_STATUS);
+	if (val & CFGPCIE_INTERFACE_TIMER_STATUS_MASK)
+		return;
+
+	val = readl(pcie->parf + PARF_INT_ALL_STATUS);
+	if (val & CFGPCIE_INT_ALL_STATUS_MASK)
+		return;
+
+	val = readl(pcie->parf + PARF_INT_STATUS);
+	if (val & CFGPCIE_PARF_INT_STATUS_MASK)
+		return;
+
+	val = readl(pcie->parf + PARF_INT_ALL_2_STATUS);
+	if (val & CFGPCIE_INT_ALL_2_STATUS_MASK)
+		return;
+
+	val = readl(pcie->parf + PARF_INT_ALL_3_STATUS);
+	if (val & CFGPCIE_INT_ALL_3_STATUS_MASK)
+		return;
+
+	val = readl(pcie->parf + PARF_INT_ALL_4_STATUS);
+	if (val & CFGPCIE_INT_ALL_4_STATUS_MASK)
+		return;
+
+	val = readl(pcie->parf + PARF_INT_ALL_5_STATUS);
+	if (val & CFGPCIE_INT_ALL_5_STATUS_MASK)
+		return;
+
+	dev_err(pci->dev, "PCIe Spurious Interrupt");
+	pcie_fault[PCIE_SPURIOUS_INT]++;
+	pcie->pcie_fault_total++;
+	sysfs_notify(kobj_ref, NULL, "qcom_pcie_error_report");
+}
+
+static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
+{
+	struct qcom_pcie *pcie = data;
+	struct dw_pcie *pci = pcie->pci;
+	u32 *pcie_fault = pcie->pcie_fault;
+	struct device *dev = pci->dev;
+	struct kobject *kobj_ref = &dev->kobj;
+	unsigned long irqsave_flags;
+	u32 val, int_status;
+
+	spin_lock_irqsave(&pcie->safety_lock, irqsave_flags);
+
+	int_status = readl(pci->dbi_base + DBI_SAFETY_STATUS);
+	writel(0, pci->dbi_base + DBI_SAFETY_STATUS);
+
+	if (int_status) {
+		dev_err(pci->dev, "global interrupt fired status: %u", int_status);
+
+		if (int_status & PCIE_RASDP_UNCORR_ERR) {
+			dev_err(pci->dev, "RASDP uncorrectable error triggered");
+			pcie_fault[RASDP_UNCORR_ERROR]++;
+			pcie->pcie_fault_total++;
+			sysfs_notify(kobj_ref, NULL, "qcom_pcie_error_report");
+
+			/*
+			 * rasdp_uncorr_err ends up triggering a
+			 * pcie_uncorr error continuously. So masking
+			 * pcie_uncorr interrupts .
+			 */
+			val = readl(pci->dbi_base + DBI_SAFETY_MASK_OFF);
+			val |= PCIE_AER_UNCORR_ERR;
+			writel(val, pci->dbi_base + DBI_SAFETY_MASK_OFF);
+		}
+
+		if (int_status & PCIE_CDM_CHK_ERR) {
+			dev_err(pci->dev, "CDM error triggered");
+			val = readl(pci->dbi_base + PCIE_PL_CHK_REG_CONTROL_STATUS);
+
+			if (val & PCIE_PL_CHK_REG_CHK_REG_COMPARISON_ERROR) {
+				pcie_fault[CDM_REG_CHK_ERROR]++;
+				pcie->pcie_fault_total++;
+				sysfs_notify(kobj_ref, NULL, "qcom_pcie_error_report");
+
+				/*
+				 * cdm_chk_err injection results in a continuous
+				 * interrupt storm on certain targets, so masking it.
+				 */
+				val = readl(pci->dbi_base + DBI_SAFETY_MASK_OFF);
+				val |= (PCIE_CDM_CHK_ERR | PCIE_AER_UNCORR_ERR);
+				writel(val, pci->dbi_base + DBI_SAFETY_MASK_OFF);
+			}
+		}
+
+		if (int_status & PCIE_IFACE_TMR_ERR) {
+			dev_err(pci->dev, "Iface Timeout error triggered");
+			pcie_fault[INTERFACE_TIMER_ERROR]++;
+			pcie->pcie_fault_total++;
+			sysfs_notify(kobj_ref, NULL, "qcom_pcie_error_report");
+
+			/*
+			 * interface_timer_err injection results in a continuous
+			 * interrupt storm on certain targets, so masking it.
+			 */
+			val = readl(pci->dbi_base + DBI_SAFETY_MASK_OFF);
+			val |= (PCIE_IFACE_TMR_ERR | PCIE_AER_UNCORR_ERR);
+			writel(val, pci->dbi_base + DBI_SAFETY_MASK_OFF);
+		}
+
+		if (int_status & PCIE_RASDP_CORR_ERR) {
+			dev_err(pci->dev, "RASDP correctable error triggered");
+			pcie_fault[RASDP_CORR_ERROR]++;
+			pcie->pcie_fault_total++;
+			sysfs_notify(kobj_ref, NULL, "qcom_pcie_error_report");
+		}
+	} else {
+		qcom_pcie_check_spurious_int(pcie);
+	}
+
+	spin_unlock_irqrestore(&pcie->safety_lock, irqsave_flags);
+	return IRQ_HANDLED;
+}
+
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
 {
 	struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(s->private);
@@ -1438,6 +1737,40 @@ static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
 	return 0;
 }
 
+static ssize_t qcom_pcie_error_report_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	unsigned int i;
+	struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(dev);
+	u32 *pcie_fault = pcie->pcie_fault;
+	size_t len = 0;
+
+	for (i = 0; i < MAX_PCIE_SAFETY_FAULT; i++) {
+		if (pcie_fault_string[i])
+			len += sysfs_emit_at(buf, len, "%s: %lu\n",
+					pcie_fault_string[i],
+					pcie_fault[i]);
+	}
+
+	len += sysfs_emit_at(buf, len, "%s: %lu\n",
+					pcie_fault_string[i],
+					pcie->pcie_fault_total);
+
+	return len;
+}
+static DEVICE_ATTR_RO(qcom_pcie_error_report);
+
+static struct attribute *qcom_pcie_attrs[] = {
+	&dev_attr_qcom_pcie_error_report.attr,
+	NULL,
+};
+
+static const struct attribute_group qcom_pcie_attribute_group = {
+	.attrs = qcom_pcie_attrs,
+	.name = "qcom_pcie"
+};
+
 static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
@@ -1496,6 +1829,21 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
+	pcie->global_irq = platform_get_irq_byname(pdev, "global");
+	if (pcie->global_irq < 0) {
+		ret = pcie->global_irq;
+		goto err_pm_runtime_put;
+	}
+
+	ret = devm_request_threaded_irq(dev, pcie->global_irq, NULL,
+				qcom_pcie_global_irq_thread,
+				IRQF_ONESHOT,
+				"global_irq", pcie);
+	if (ret) {
+		dev_err(dev, "Failed to request Global IRQ\n");
+		goto err_pm_runtime_put;
+	}
+
 	pcie->parf = devm_platform_ioremap_resource_byname(pdev, "parf");
 	if (IS_ERR(pcie->parf)) {
 		ret = PTR_ERR(pcie->parf);
@@ -1551,6 +1899,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (pcie->mhi)
 		qcom_pcie_init_debugfs(pcie);
 
+	sysfs_create_group(&pdev->dev.kobj, &qcom_pcie_attribute_group);
+
 	return 0;
 
 err_phy_exit:
-- 
2.40.1


