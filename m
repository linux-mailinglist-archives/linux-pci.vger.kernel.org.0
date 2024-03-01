Return-Path: <linux-pci+bounces-4294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE786DAF7
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 06:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C25284116
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 05:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE45D50A6D;
	Fri,  1 Mar 2024 05:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I0M9VDz1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173C50271;
	Fri,  1 Mar 2024 05:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709269998; cv=none; b=sv8zFDLNYvDau4zY3GR8CUFdtcXav6rhVPxz4eEomfy7d7HHDiehD5PRw915UaL5J6FjuqBvDXXJlgfw+YBvWzT8GBHCk6sVBE0g8HvGTcC18nMYU/G5YInVHcazh5fJ1ML3GKmioNHRxlDGnKZR8Av8YkRnFRI111baHZLpB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709269998; c=relaxed/simple;
	bh=M7UTzvr+YTB7bIeNJj1wK2uB4KOdvKq7tRzGheqxNw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAvIW2MoRhKo7b/sG8lJm/st7pE/rvR0cEvy1Zh2qhWBPGDk8qKJG0XPbQia6oGcNM6mtijomdEshTWpNvFen94BfWQD3T7GVDg4OmiZMlVsqw6RUvb+5YXnwRvzNKeMKVAWAXZUVA/CXykG3nSOl8HTMC72l6FnjWX2mC+VbiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I0M9VDz1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4214ds0r004295;
	Fri, 1 Mar 2024 05:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=GUBqkgDDi5arvjC/nxRao/2Qgxh7DZtpdRsG1DlND4E=; b=I0
	M9VDz1+GWKAwGiUR/6uObg6YNLZgQwy14G1YVtSZ3aaoFeOBoNSuCaBZCvjbeq/1
	WUIE9C7j9yl+9IHU0xQKx3zugcwnVPhbEaERAl7zy6zlmjsPaaWyXK+0g6o88hGN
	8H7NhiHwfuj12ZU+DMJ4RGu22t+uA6AhRUyAcBJttgEunVP1N9eOUG96hmEWG4Eq
	3VlRjwbeSo+JFxFg3GYVYiN+qmRh17DgB3kA9V03ICrPrgI4Zv4uPg4ZaEuhSQjy
	33DAx/WXV5mqRINpqNxHZXvzGoTdTnDkHUFT904BWXguOf93OruCekU2l/x0TCvx
	A5+XVw63bPqxOPXFMPAA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wk4rvrgpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 05:13:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4215D3Qn013663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 05:13:03 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 29 Feb 2024 21:13:03 -0800
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
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Josh Triplett
	<josh@joshtriplett.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v1 3/3] PCI: dwc: add rx margining settings for gen4
Date: Thu, 29 Feb 2024 21:11:36 -0800
Message-ID: <20240301051220.20917-4-quic_schintav@quicinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301051220.20917-1-quic_schintav@quicinc.com>
References: <20240301051220.20917-1-quic_schintav@quicinc.com>
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
X-Proofpoint-ORIG-GUID: kwweDpJRImdrkpmNyXo7Lzp9AGuMaPl9
X-Proofpoint-GUID: kwweDpJRImdrkpmNyXo7Lzp9AGuMaPl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=774 clxscore=1015
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403010042

Add rx margining settings for gen4 operation.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-cmn.c | 36 ++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-cmn.h | 34 ++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c  |  4 ++-
 drivers/pci/controller/dwc/pcie-qcom.c     |  4 ++-
 4 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.c b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
index cfdc04eef78c..abba4de32005 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-cmn.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
@@ -50,6 +50,42 @@ void qcom_pcie_cmn_set_gen4_eq_settings(struct dw_pcie *pci)
 }
 EXPORT_SYMBOL_GPL(qcom_pcie_cmn_set_gen4_eq_settings);
 
+void qcom_pcie_cmn_set_gen4_rx_margining_settings(struct dw_pcie *pci)
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
+EXPORT_SYMBOL_GPL(qcom_pcie_cmn_set_gen4_rx_margining_settings);
+
 int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)
 {
 	int ret = 0;
diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.h b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
index 08e1bd179207..b145743a7558 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-cmn.h
+++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
@@ -27,11 +27,40 @@
 #define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_SHIFT		10
 #define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_SHIFT	14
 
+#define GEN4_LANE_MARGINING_1_OFF		0xb80
+#define GEN4_LANE_MARGINING_2_OFF		0xb84
+
+#define MARGINING_MAX_VOLTAGE_OFFSET_MASK	GENMASK(29, 24)
+#define MARGINING_NUM_VOLTAGE_STEPS_MASK	GENMASK(22, 16)
+#define MARGINING_MAX_TIMING_OFFSET_MASK	GENMASK(13, 8)
+#define MARGINING_NUM_TIMING_STEPS_MASK		GENMASK(5, 0)
+#define MARGINING_MAX_VOLTAGE_OFFSET_SHIFT	24
+#define MARGINING_NUM_VOLTAGE_STEPS_SHIFT	16
+#define MARGINING_MAX_TIMING_OFFSET_SHIFT	8
+#define MARGINING_MAX_VOLTAGE_OFFSET_VAL	0x24
+#define MARGINING_NUM_VOLTAGE_STEPS_VAL		0x78
+#define MARGINING_MAX_TIMING_OFFSET_VAL		0x32
+#define MARGINING_NUM_TIMING_STEPS_VAL		0x10
+
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
+#define MARGINING_SAMPLE_RATE_TIMING_VAL	0x3f
+#define MARGINING_SAMPLE_RATE_VOLTAGE_VAL	0x3f
+
 #ifdef CONFIG_PCIE_QCOM_CMN
 int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem);
 int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
 void qcom_pcie_cmn_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
 void qcom_pcie_cmn_set_gen4_eq_settings(struct dw_pcie *pci);
+void qcom_pcie_cmn_set_gen4_rx_margining_settings(struct dw_pcie *pci);
 #else
 static inline int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)
 {
@@ -50,4 +79,9 @@ static inline void qcom_pcie_cmn_icc_update(struct dw_pcie *pci, struct icc_path
 static inline void qcom_pcie_cmn_set_gen4_eq_settings(struct dw_pcie *pci)
 {
 }
+
+static inline void qcom_pcie_cmn_set_gen4_rx_margining_settings(struct dw_pcie *pci)
+{
+}
+
 #endif
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 0b169bcd081d..5422fa970d9d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -439,8 +439,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	}
 
 	/* set Gen4 equalization settings */
-	if (pci->link_gen == 4)
+	if (pci->link_gen == 4) {
 		qcom_pcie_cmn_set_gen4_eq_settings(pci);
+		qcom_pcie_cmn_set_gen4_rx_margining_settings(pci);
+	}
 
 	/*
 	 * The physical address of the MMIO region which is exposed as the BAR
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ad0cd55da777..3ada1e9fdd11 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -264,8 +264,10 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
 	/* set Gen4 equalization settings */
-	if (pci->link_gen == 4)
+	if (pci->link_gen == 4) {
 		qcom_pcie_cmn_set_gen4_eq_settings(pci);
+		qcom_pcie_cmn_set_gen4_rx_margining_settings(pci);
+	}
 
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
-- 
2.43.2


