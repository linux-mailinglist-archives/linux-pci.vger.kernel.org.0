Return-Path: <linux-pci+bounces-4931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0BB880BEB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 08:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209931F23AB4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 07:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBBD36137;
	Wed, 20 Mar 2024 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l5YY4Yb5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F052D638;
	Wed, 20 Mar 2024 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919123; cv=none; b=clfOGgopsHKcmZ/gSkHaoDZwIbvY1EdDPEnulbzwLNYMcNcoX+0C/VNb4UBl3ZVBpF/540n18XHYdAPItMfqv5e/D3kKkzciCAN7yKs2yoXhBG1RO41AhuRWuCKp4XhQoiHnmI6tA0n8LhmarjnkZ0+XJeWCkAkal2pw5PmW2yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919123; c=relaxed/simple;
	bh=nUraW8ctqgeH6QRccwcKRr4KikIK7I9mNNFJgzPOc1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRROciEtyTKywHxTlRwO057egLLMYZjfgESZmfhpBTW/Vn7xnJLl2wfTMrGoyk4NCnJ+iAd0fiUMgeX1ofCJsIdcl9IfSJvinCPhl+/DaFd+AH2ju5qqoUe6NRI/YA0TG+QrtRe8FR/9verjXYNU0HJghd1aCbjFRQCPDdj+jYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l5YY4Yb5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K50S0X006683;
	Wed, 20 Mar 2024 07:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=WfQ0dYAfRUGtdk/Mon4CaDA59QDsUrhV9EhfbujMBzg=; b=l5
	YY4Yb5dDP29secf8BcHSL5xnFJ4teJt5At+Ef7C2kLcOkxtBerFkpoUp44YL2DKu
	zfNqUGHWQhDEh8cSgWVpkZTtKHFPV0IZ/m+iHancwM7z2UW+HwlIWo6j3fF9BL7V
	Miw5RRx2x9nuPdKSl/KLBsfefx+1dP95q6n99YLddVAtxdY+dOYdRD+jwX4Niu/k
	0fLHhBpZw99a6kELYMEkRy/CAR05NIsTUdcvnn2X+4RX/32DflmawMpyHfIe1jbZ
	5nCcXeKV4Uw/VJ1+EPV6SXtGongyg9IE4Pi5g3o31VyKxOjAZhfgrkYZUBGvtG7I
	CtEVcE9v07y81LCBW5FQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyke2rtrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 07:16:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K7GAca002357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 07:16:10 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 00:16:09 -0700
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mani@kernel.org>
CC: <quic_msarkar@quicinc.com>, <quic_kraravin@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Conor Dooley
	<conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 3/3] PCI: qcom: Add rx margining settings for gen4
Date: Wed, 20 Mar 2024 00:14:47 -0700
Message-ID: <20240320071527.13443-4-quic_schintav@quicinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240320071527.13443-1-quic_schintav@quicinc.com>
References: <20240320071527.13443-1-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8jQHw3srWTJ0t-1SIQ-99aGOU1vMXa5A
X-Proofpoint-GUID: 8jQHw3srWTJ0t-1SIQ-99aGOU1vMXa5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=952 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403200057

Add rx margining settings for gen4 operation.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 23 +++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-cmn.c   | 35 ++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-cmn.h   | 11 +++++-
 drivers/pci/controller/dwc/pcie-qcom-ep.c    |  4 ++-
 drivers/pci/controller/dwc/pcie-qcom.c       |  4 ++-
 5 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 064744bfe35a..ce1c5f9c406a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -206,6 +206,29 @@
 
 #define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
 
+/*
+ * GEN4 lane margining register definitions
+ */
+#define GEN4_LANE_MARGINING_1_OFF		0xb80
+#define MARGINING_MAX_VOLTAGE_OFFSET_MASK	GENMASK(29, 24)
+#define MARGINING_NUM_VOLTAGE_STEPS_MASK	GENMASK(22, 16)
+#define MARGINING_MAX_TIMING_OFFSET_MASK	GENMASK(13, 8)
+#define MARGINING_NUM_TIMING_STEPS_MASK		GENMASK(5, 0)
+#define MARGINING_MAX_VOLTAGE_OFFSET_SHIFT	24
+#define MARGINING_NUM_VOLTAGE_STEPS_SHIFT	16
+#define MARGINING_MAX_TIMING_OFFSET_SHIFT	8
+
+#define GEN4_LANE_MARGINING_2_OFF		0xb84
+#define MARGINING_IND_ERROR_SAMPLER		BIT(28)
+#define MARGINING_SAMPLE_REPORTING_METHOD	BIT(27)
+#define MARGINING_IND_LEFT_RIGHT_TIMING		BIT(26)
+#define MARGINING_IND_UP_DOWN_VOLTAGE		BIT(25)
+#define MARGINING_VOLTAGE_SUPPORTED		BIT(24)
+#define MARGINING_MAXLANES_MASK			GENMASK(20, 16)
+#define MARGINING_SAMPLE_RATE_TIMING_MASK	GENMASK(13, 8)
+#define MARGINING_SAMPLE_RATE_VOLTAGE_MASK	GENMASK(5, 0)
+#define MARGINING_MAXLANES_SHIFT		16
+#define MARGINING_SAMPLE_RATE_TIMING_SHIFT	8
 /*
  * iATU Unroll-specific register definitions
  * From 4.80 core version the address translation will be made by unroll
diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.c b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
index 208a55e8e9a1..bf6b27ee8327 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-cmn.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
@@ -53,6 +53,41 @@ void qcom_pcie_cmn_set_16gt_eq_settings(struct dw_pcie *pci)
 }
 EXPORT_SYMBOL_GPL(qcom_pcie_cmn_set_16gt_eq_settings);
 
+void qcom_pcie_cmn_set_16gt_rx_margining_settings(struct dw_pcie *pci)
+{
+	u32 reg;
+
+	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_1_OFF);
+	reg &= ~MARGINING_MAX_VOLTAGE_OFFSET_MASK;
+	reg |= (MARGINING_MAX_VOLTAGE_OFFSET_VAL <<
+		MARGINING_MAX_VOLTAGE_OFFSET_SHIFT);
+	reg &= ~MARGINING_NUM_VOLTAGE_STEPS_MASK;
+	reg |= (MARGINING_NUM_VOLTAGE_STEPS_VAL <<
+		MARGINING_NUM_VOLTAGE_STEPS_SHIFT);
+	reg &= ~MARGINING_MAX_TIMING_OFFSET_MASK;
+	reg |= (MARGINING_MAX_TIMING_OFFSET_VAL <<
+		MARGINING_MAX_TIMING_OFFSET_SHIFT);
+	reg &= ~MARGINING_NUM_TIMING_STEPS_MASK;
+	reg |= MARGINING_NUM_TIMING_STEPS_VAL;
+	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_1_OFF, reg);
+
+	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_2_OFF);
+	reg |= MARGINING_IND_ERROR_SAMPLER;
+	reg |= MARGINING_SAMPLE_REPORTING_METHOD;
+	reg |= MARGINING_IND_LEFT_RIGHT_TIMING;
+	reg |= MARGINING_VOLTAGE_SUPPORTED;
+	reg &= ~MARGINING_IND_UP_DOWN_VOLTAGE;
+	reg &= ~MARGINING_MAXLANES_MASK;
+	reg |= (pci->num_lanes <<
+		MARGINING_MAXLANES_SHIFT);
+	reg &= ~MARGINING_SAMPLE_RATE_TIMING_MASK;
+	reg |= (MARGINING_SAMPLE_RATE_TIMING_VAL <<
+		MARGINING_SAMPLE_RATE_TIMING_SHIFT);
+	reg |= MARGINING_SAMPLE_RATE_VOLTAGE_VAL;
+	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_2_OFF, reg);
+}
+EXPORT_SYMBOL_GPL(qcom_pcie_cmn_set_16gt_rx_margining_settings);
+
 int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)
 {
 	if (IS_ERR(pci))
diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.h b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
index 97302e8fafa8..11d6b00372ec 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-cmn.h
+++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
@@ -11,9 +11,18 @@
 
 #define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_16GT_VAL   0x5
 #define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_16GT_VAL  0x5
-#define GEN3_EQ_FMDC_N_EVALS_16GT_VAL          0xD
+#define GEN3_EQ_FMDC_N_EVALS_16GT_VAL		0xD
+
+/* GEN4(16GT/s) RX margining settings */
+#define MARGINING_MAX_VOLTAGE_OFFSET_VAL	0x24
+#define MARGINING_NUM_VOLTAGE_STEPS_VAL		0x78
+#define MARGINING_MAX_TIMING_OFFSET_VAL		0x32
+#define MARGINING_NUM_TIMING_STEPS_VAL		0x10
+#define MARGINING_SAMPLE_RATE_TIMING_VAL	0x3f
+#define MARGINING_SAMPLE_RATE_VOLTAGE_VAL	0x3f
 
 int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem);
 int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
 void qcom_pcie_cmn_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
 void qcom_pcie_cmn_set_16gt_eq_settings(struct dw_pcie *pci);
+void qcom_pcie_cmn_set_16gt_rx_margining_settings(struct dw_pcie *pci);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index b6bcab21bb9f..b4d53f96eb9e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -438,8 +438,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		goto err_disable_resources;
 	}
 
-	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
+	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT) {
 		qcom_pcie_cmn_set_16gt_eq_settings(pci);
+		qcom_pcie_cmn_set_16gt_rx_margining_settings(pci);
+	}
 
 	/*
 	 * The physical address of the MMIO region which is exposed as the BAR
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b0a22a000fa3..3dfb4d165ba5 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -263,8 +263,10 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
-	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
+	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT) {
 		qcom_pcie_cmn_set_16gt_eq_settings(pci);
+		qcom_pcie_cmn_set_16gt_rx_margining_settings(pci);
+	}
 
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
-- 
2.43.2


