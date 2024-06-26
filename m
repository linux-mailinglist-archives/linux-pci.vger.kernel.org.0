Return-Path: <linux-pci+bounces-9306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17B491811E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 14:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844BE28A2B2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4684185E5F;
	Wed, 26 Jun 2024 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eA4OnKDs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F79181CE0;
	Wed, 26 Jun 2024 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405523; cv=none; b=JOxxaLTstl/0Hgb07ajSUcnFWZyzuhe75yyjNKaZ1zbfo0ezYbZnKdpuMOZa+8oDYeea+gfkEERK/tQK+rRp4NlJPVDLQJQB961vvmOzqVmHc7ZbfR4j5Uu7vbkzFyK9zg2/eyk2sy0aHwTB3Cfr3f9pmZ2GK04yyMaw8Hmc8RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405523; c=relaxed/simple;
	bh=M5ueyXKkAHTsqGieJh/5NZs5cm942PRTPgWnaAvDn/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qQa6WSERVVH84weA6De+vs7pUBvvIjrKFA1h1z/GXrds/6VgY70vpQbiBrC7mnnCvTvWjPiE4vFuisEkX9Nbmko7hbxk0Xd8qQViDUkDTNXMfhXoYyOvksICt5NZq6imhMQn9cQOUJaiQyxPsLUtCbHo01KBYl9vB0evmgdPLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eA4OnKDs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfKte029744;
	Wed, 26 Jun 2024 12:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G5quL8Le1znlILQ0TlxaLUKoxv02YwE2X+2KKVoelvo=; b=eA4OnKDscgxJ6+es
	50ocvlA91FY/4uJ9n7pYgkNj4i8rdRBKmJyk0vPny17wuvIjBYioMANpJLFPOwaM
	+LQXDOM9WcAoUUxvyQrkF4gyU7Wi1Bgby6uclcq6Qx/vukjj+sX8DXHBS43PICz7
	ebem7642mEWbZ3h68Zjf1ylx3pyaPmt/h0z2GcCyp5WulriUwOeNgZJdkOymCDSQ
	To72OK/iTFkxCXGn9eoIhRQG0Y+3JlCRoG+XZ3qTpr7kccb7SQNIw0r1EjZUkKLU
	Z45cZvTHBY86koWUCBhmiFpfacIBNKQ0+qY80E+upXDz8FLT2uWlzs/lsBaHqdXB
	JfK/lA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400c46979n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:38:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QCcS4n012751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:38:28 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 05:38:23 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 26 Jun 2024 18:07:54 +0530
Subject: [PATCH RFC 6/7] pci: qcom: Add support for start_link() &
 stop_link()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-qps615-v1-6-2ade7bd91e02@quicinc.com>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
In-Reply-To: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
CC: <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719405471; l=6636;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=M5ueyXKkAHTsqGieJh/5NZs5cm942PRTPgWnaAvDn/U=;
 b=s5re4cIaqpCTv4NXLAZPHXYru4NC0kKdaDIK76vv63afbCKFUmpmyaj2+dkZGp0RAlGJq+jqM
 HF0MPMUg2fjCM3pzeNEhExHPempkqpCziUi0tNIiK1Z3g6/4YFTiAH4
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LAR28ddJI4T4Fm8_Ntexcz-6BvFwdWOt
X-Proofpoint-GUID: LAR28ddJI4T4Fm8_Ntexcz-6BvFwdWOt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260094

In the stop_link() if the PCIe link is not up, disable LTSSM enable
bit to stop link training otherwise keep the link in D3cold.
And in the start_link() the enable LTSSM bit if the resources are
turned on other wise do the all the initialization and then start
the link.

Introduce ltssm_disable function op to stop the link training.

Use a flag 'pci_pwrctl_turned_off" to indicate the resources are
turned off by the pci pwrctl framework.

If the link is stopped using the stop_link() then just return with
doing anything in suspend and resume.
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 108 +++++++++++++++++++++++++++++----
 1 file changed, 97 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 14772edcf0d3..1ab3ffdb3914 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -37,6 +37,7 @@
 /* PARF registers */
 #define PARF_SYS_CTRL				0x00
 #define PARF_PM_CTRL				0x20
+#define PARF_PM_STTS				0x24
 #define PARF_PCS_DEEMPH				0x34
 #define PARF_PCS_SWING				0x38
 #define PARF_PHY_CTRL				0x40
@@ -83,6 +84,9 @@
 /* PARF_PM_CTRL register fields */
 #define REQ_NOT_ENTR_L1				BIT(5)
 
+/* PARF_PM_STTS register fields */
+#define PM_ENTER_L23				BIT(5)
+
 /* PARF_PCS_DEEMPH register fields */
 #define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		FIELD_PREP(GENMASK(21, 16), x)
 #define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	FIELD_PREP(GENMASK(13, 8), x)
@@ -126,6 +130,7 @@
 
 /* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
+#define ELBI_SYS_CTRL_PME_TURNOFF_MSG		BIT(4)
 
 /* AXI_MSTR_RESP_COMP_CTRL0 register fields */
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
@@ -228,6 +233,7 @@ struct qcom_pcie_ops {
 	void (*host_post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
+	void (*ltssm_disable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
 };
 
@@ -248,10 +254,13 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
+	bool pci_pwrctl_turned_off;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
+static void qcom_pcie_icc_update(struct qcom_pcie *pcie);
+
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
 	gpiod_set_value_cansleep(pcie->reset, 1);
@@ -266,17 +275,6 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
-static int qcom_pcie_start_link(struct dw_pcie *pci)
-{
-	struct qcom_pcie *pcie = to_qcom_pcie(pci);
-
-	/* Enable Link Training state machine */
-	if (pcie->cfg->ops->ltssm_enable)
-		pcie->cfg->ops->ltssm_enable(pcie);
-
-	return 0;
-}
-
 static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
@@ -556,6 +554,15 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static void qcom_pcie_2_3_2_ltssm_disable(struct qcom_pcie *pcie)
+{
+	u32 val;
+
+	val = readl(pcie->parf + PARF_LTSSM);
+	val &= ~LTSSM_EN;
+	writel(val, pcie->parf + PARF_LTSSM);
+}
+
 static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -1336,6 +1343,7 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 	.post_init = qcom_pcie_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+	.ltssm_disable = qcom_pcie_2_3_2_ltssm_disable,
 };
 
 /* Qcom IP rev.: 1.9.0 */
@@ -1346,6 +1354,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+	.ltssm_disable = qcom_pcie_2_3_2_ltssm_disable,
 	.config_sid = qcom_pcie_config_sid_1_9_0,
 };
 
@@ -1395,9 +1404,81 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
 	.no_l0s = true,
 };
 
+static int qcom_pcie_turnoff_link(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u32 ret_l23, val, ret;
+
+	if (!dw_pcie_link_up(pcie->pci)) {
+		if (pcie->cfg->ops->ltssm_disable)
+			pcie->cfg->ops->ltssm_disable(pcie);
+	} else {
+		writel(ELBI_SYS_CTRL_PME_TURNOFF_MSG, pcie->elbi + ELBI_SYS_CTRL);
+
+		ret_l23 = readl_poll_timeout(pcie->parf + PARF_PM_STTS, val,
+					     val & PM_ENTER_L23, 10000, 100000);
+		if (ret_l23) {
+			dev_err(pci->dev, "Failed to enter L2/L3\n");
+			return -ETIMEDOUT;
+		}
+
+		qcom_pcie_host_deinit(&pcie->pci->pp);
+
+		ret = icc_disable(pcie->icc_mem);
+		if (ret)
+			dev_err(pci->dev, "Failed to disable PCIe-MEM interconnect path: %d\n",
+				ret);
+
+		pcie->pci_pwrctl_turned_off = true;
+	}
+
+	return 0;
+}
+
+static int qcom_pcie_turnon_link(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	if (pcie->pci_pwrctl_turned_off) {
+		qcom_pcie_host_init(&pcie->pci->pp);
+
+		dw_pcie_setup_rc(&pcie->pci->pp);
+	}
+
+	if (pcie->cfg->ops->ltssm_enable)
+		pcie->cfg->ops->ltssm_enable(pcie);
+
+	/* Ignore the retval, the devices may come up later. */
+	dw_pcie_wait_for_link(pcie->pci);
+
+	qcom_pcie_icc_update(pcie);
+
+	pcie->pci_pwrctl_turned_off = false;
+
+	return 0;
+}
+
+static int qcom_pcie_start_link(struct dw_pcie *pci)
+{
+	return qcom_pcie_turnon_link(pci);
+}
+
+static void qcom_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	if (!dw_pcie_link_up(pcie->pci))  {
+		if (pcie->cfg->ops->ltssm_disable)
+			pcie->cfg->ops->ltssm_disable(pcie);
+	} else {
+		qcom_pcie_turnoff_link(pci);
+	}
+}
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.stop_link = qcom_pcie_stop_link,
 };
 
 static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
@@ -1604,6 +1685,8 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	struct qcom_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
 
+	if (pcie->pci_pwrctl_turned_off)
+		return 0;
 	/*
 	 * Set minimum bandwidth required to keep data path functional during
 	 * suspend.
@@ -1642,6 +1725,9 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 	struct qcom_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
 
+	if (pcie->pci_pwrctl_turned_off)
+		return 0;
+
 	if (pcie->suspended) {
 		ret = qcom_pcie_host_init(&pcie->pci->pp);
 		if (ret)

-- 
2.42.0


