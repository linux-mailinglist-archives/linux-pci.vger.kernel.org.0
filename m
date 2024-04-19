Return-Path: <linux-pci+bounces-6469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E858AA62A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 02:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B7E2844A0
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 00:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1BB3C38;
	Fri, 19 Apr 2024 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bKwJ4PPk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A8510A25;
	Fri, 19 Apr 2024 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713485474; cv=none; b=H+7n8dlyzZ1mYS/f7M4BsX1lJBM9NBYypD+AiB3XXGXKrUdweYzdRwLQBeD2CziFP8gdfTi4trBL7ufBUe1Rypn5xZv59ME4g4/ACKT+UgxKfIDaoDrBCKKR/6s2tMk7QF8ar3tanOhdvtpRgb4MmTvdtEjYqO92piAFmPUJIEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713485474; c=relaxed/simple;
	bh=qTRflK83hWPe8WMZaUDFvxeBpnPe3PBX9JmEeKHKz5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOblJ+LTqjcKp44aV30szgX+1S9xgOIppjuJDBvrfIdMuUT6s2153J7Eeq5k4fkwu/RMlisbM2LF3ENMAMca5jRAzOe6cuWAaxn5Eo7/0M2qU7jItSsfl1VuDUPcbXMCOrQBEKX/whQgm0p4KRSGqfKzqaGMMFbFC5i7TkRjDu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bKwJ4PPk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IMserW000792;
	Fri, 19 Apr 2024 00:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=QMLqYCG5YLp0bH+Im5zgY8BvC8QMj6jH3G/EsLQGnTk=; b=bK
	wJ4PPkTweKhfPAuSEwzkO/epfybcwuFn6JOQRIzLaV1V+kW+BA7yNt+4B9uj9wT/
	GTPyZQKXOzHk55RBTblHici9wb69fGexbBO+KrklLmBYi2DOvrVaLTGTfwR4z7+2
	+be0vr4w9B2Ox4i9Q13Lc8vUBNXi0SAM12fAQaSHj5egP8KOy6Ds6q0d0aqPAN+T
	RvCdWhvIbm4U1HaoJU9INY4BYHtVHnTFT9rDRBxveZPGv8sej3LDDIb6RoS1B11n
	7BqzspI5ML2emdlImYaQRPk6of+1ojnNJzm3ZyThGN7M87YMyc9N8OgSJ+eQM0ZT
	K0u/e4fMaCdOVTtHsU+g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk4vm9a4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 00:10:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43J0Aud6001710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 00:10:56 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 17:10:55 -0700
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
Subject: [PATCH v3 3/3] PCI: qcom: Add rx margining settings for 16GT/s
Date: Thu, 18 Apr 2024 17:09:36 -0700
Message-ID: <20240419001013.28788-4-quic_schintav@quicinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240419001013.28788-1-quic_schintav@quicinc.com>
References: <20240419001013.28788-1-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a0jWp-cJVae7NLxedAhk-PU-PCefoKqu
X-Proofpoint-GUID: a0jWp-cJVae7NLxedAhk-PU-PCefoKqu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_21,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxlogscore=859 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190000

Add rx lane margining settings for 16GT/s(GEN 4) data rate. These
settings improve link stability while operating at high date rates
and helps to improve signal quality.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware.h  | 18 ++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.c | 24 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  4 +++-
 drivers/pci/controller/dwc/pcie-qcom.c        |  4 +++-
 5 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ad771bb52d29..e8c48855143f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -203,6 +203,24 @@
 
 #define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
 
+/*
+ * GEN4 lane margining register definitions
+ */
+#define GEN4_LANE_MARGINING_1_OFF		0xb80
+#define MARGINING_MAX_VOLTAGE_OFFSET(n)		FIELD_PREP(GENMASK(29, 24), n)
+#define MARGINING_NUM_VOLTAGE_STEPS(n)		FIELD_PREP(GENMASK(22, 16), n)
+#define MARGINING_MAX_TIMING_OFFSET(n)		FIELD_PREP(GENMASK(13, 8), n)
+#define MARGINING_NUM_TIMING_STEPS(n)		FIELD_PREP(GENMASK(5, 0), n)
+
+#define GEN4_LANE_MARGINING_2_OFF		0xb84
+#define MARGINING_IND_ERROR_SAMPLER(n)		FIELD_PREP(BIT(28), n)
+#define MARGINING_SAMPLE_REPORTING_METHOD(n)	FIELD_PREP(BIT(27), n)
+#define MARGINING_IND_LEFT_RIGHT_TIMING(n)	FIELD_PREP(BIT(26), n)
+#define MARGINING_IND_UP_DOWN_VOLTAGE(n)	FIELD_PREP(BIT(25), n)
+#define MARGINING_VOLTAGE_SUPPORTED(n)		FIELD_PREP(BIT(24), n)
+#define MARGINING_MAXLANES(n)			FIELD_PREP(GENMASK(20, 16), n)
+#define MARGINING_SAMPLE_RATE_TIMING(n)		FIELD_PREP(GENMASK(13, 8), n)
+#define MARGINING_SAMPLE_RATE_VOLTAGE(n)	FIELD_PREP(GENMASK(5, 0), n)
 /*
  * iATU Unroll-specific register definitions
  * From 4.80 core version the address translation will be made by unroll
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
index a6f3eb4c3ee6..3279314ae78c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -46,6 +46,30 @@ void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
 }
 EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
 
+void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci)
+{
+	u32 reg;
+
+	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_1_OFF);
+	reg = MARGINING_MAX_VOLTAGE_OFFSET(0x24) |
+		MARGINING_NUM_VOLTAGE_STEPS(0x78) |
+		MARGINING_MAX_TIMING_OFFSET(0x32) |
+		MARGINING_NUM_TIMING_STEPS(0x10);
+	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_1_OFF, reg);
+
+	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_2_OFF);
+	reg = MARGINING_IND_ERROR_SAMPLER(1) |
+		MARGINING_SAMPLE_REPORTING_METHOD(1) |
+		MARGINING_IND_LEFT_RIGHT_TIMING(1) |
+		MARGINING_VOLTAGE_SUPPORTED(1) |
+		MARGINING_IND_UP_DOWN_VOLTAGE(0) |
+		MARGINING_MAXLANES(pci->num_lanes) |
+		MARGINING_SAMPLE_RATE_TIMING(0x3f) |
+		MARGINING_SAMPLE_RATE_VOLTAGE(0x3f);
+	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_2_OFF, reg);
+}
+EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_rx_margining_settings);
+
 int qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, struct icc_path **icc_mem_p)
 {
 	*icc_mem_p = devm_of_icc_get(pci->dev, "pcie-mem");
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
index e72c651b0d28..b9eb78fcc766 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.h
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
@@ -11,3 +11,4 @@ int qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, struct icc_path **icc
 int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
 void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
 void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
+void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index cb75a874f76c..3032dd91514c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -438,8 +438,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		goto err_disable_resources;
 	}
 
-	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
+	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT) {
 		qcom_pcie_common_set_16gt_eq_settings(pci);
+		qcom_pcie_common_set_16gt_rx_margining_settings(pci);
+	}
 
 	/*
 	 * The physical address of the MMIO region which is exposed as the BAR
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index acf66f974edc..f69364ecf2de 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -263,8 +263,10 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
-	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
+	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT) {
 		qcom_pcie_common_set_16gt_eq_settings(pci);
+		qcom_pcie_common_set_16gt_rx_margining_settings(pci);
+	}
 
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
-- 
2.43.2


