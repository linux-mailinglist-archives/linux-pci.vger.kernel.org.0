Return-Path: <linux-pci+bounces-6966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC798B8E4F
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 18:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9379B2835A2
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA034CA4E;
	Wed,  1 May 2024 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dLqeSkM0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F391803E;
	Wed,  1 May 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581420; cv=none; b=q9oskWQQbgbHDbsGeFvAf8GV+caMGo7fE6jnQv+sb8GBDZl9tk3/BJMS/XYqPumFiPuns6kE5oT2cgUtQpGDGrquGqm4h8DF4Q3b954ziGI9XyhZXVH1kQVo52u0UY/3qfCYlrr4eHcyReOKg8JO1qV1Mc9jyLDQtJ2LZtDcoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581420; c=relaxed/simple;
	bh=IQGaEtR1iABnBEVuFtHVy0wS7Yytg49EDR8frPYAYqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTFW5X9VfvIro313X/9Cq/OVnGz3DE/wFxveOMpx1yUN7yhJm490dwn0ofbOrR8UAjvFhTFxHz0Ld81XmqBVPYqG341pVsKUaPRuIrmQnJpROqahec9CZRuID+PDWqWSd3l/T7KQt9v4NXxTI3p5Gq0/9D94D14eIro6fZrv5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dLqeSkM0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 441Dvgk9029877;
	Wed, 1 May 2024 16:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=LMzlZR7/5Sc23tatmbLT0ExcC7MhL8iZPSrKO/qKm8U=; b=dL
	qeSkM06oRbv+95FHQnKDdQf9+sMMD/pkEXRzHWBI53JXyN2LRSr1v95eY0EceRJu
	7sz/kEwZYGXe54kOhG/gBj/jj4Vz01Ljlyc+i3nZW8DiAOggm0rgymfsO7DGASZZ
	C+uSwk7hYT9LiH7vnCBGyCyPNDXI88zevUVTEUDhM+845+GZHgEE8rU8MVepQTuA
	pK/NqL3N7JXeEyBmZ/3OmVdcjyk/TA00z0LJa6bsk02YRbfSy7Xm0EgiCvqn4MTu
	EICTl/SUXFUEbe7V/Qi5VgLDlAY1FrzksaNbL1efrzDNmrN1nAT9s5bwaQtjo9Hb
	327P0SlLkuqP3hzSyyyg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtvf7kuj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 16:36:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 441Gaefj021794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 16:36:40 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 1 May 2024 09:36:39 -0700
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
To: <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <manivannan.sadhasivam@linaro.org>, <andersson@kernel.org>,
        <agross@kernel.org>, <konrad.dybcio@linaro.org>, <mani@kernel.org>
CC: <quic_msarkar@quicinc.com>, <quic_kraravin@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v4 2/3] PCI: qcom: Add equalization settings for 16 GT/s
Date: Wed, 1 May 2024 09:35:33 -0700
Message-ID: <20240501163610.8900-3-quic_schintav@quicinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240501163610.8900-1-quic_schintav@quicinc.com>
References: <20240501163610.8900-1-quic_schintav@quicinc.com>
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
X-Proofpoint-GUID: 2VjDNPEdwNB061ByoSa_sVG6lT5tqC8E
X-Proofpoint-ORIG-GUID: 2VjDNPEdwNB061ByoSa_sVG6lT5tqC8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=908 priorityscore=1501
 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405010117

During high data transmission rates such as 16 GT/s , there is an
increased risk of signal loss due to poor channel quality and
interference. This can impact receiver's ability to capture signals
accurately. Hence, signal compensation is achieved through appropriate
lane equilization settings at both transmitter and receiver. This will
result in increasing PCIe signal strength.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware.h  | 12 ++++++
 drivers/pci/controller/dwc/pcie-qcom-common.c | 37 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  3 ++
 drivers/pci/controller/dwc/pcie-qcom.c        |  3 ++
 5 files changed, 56 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae4837462..ed0045043847 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -122,6 +122,18 @@
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
index 228d9eec0222..16c277b2e9d4 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -16,6 +16,43 @@
 #define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
 		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
 
+void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
+{
+	u32 reg;
+
+	/*
+	 * GEN3_RELATED_OFF register is repurposed to apply equilaztion
+	 * settings at various data transmission rates through registers
+	 * namely GEN3_EQ_*. RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
+	 * determines data rate for which this equilization settings are
+	 * applied.
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
+
 struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path)
 {
 	struct icc_path *icc_mem_p;
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
index da1760c7e164..5c01f6c18b3b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.h
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
@@ -10,3 +10,4 @@
 struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path);
 int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
 void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
+void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index f0c61d847643..7940222d35f6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -438,6 +438,9 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		goto err_disable_resources;
 	}
 
+	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
+		qcom_pcie_common_set_16gt_eq_settings(pci);
+
 	/*
 	 * The physical address of the MMIO region which is exposed as the BAR
 	 * should be written to MHI BASE registers.
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0095c42aeee0..525942f2cf98 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -263,6 +263,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
+	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
+		qcom_pcie_common_set_16gt_eq_settings(pci);
+
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
 		pcie->cfg->ops->ltssm_enable(pcie);
-- 
2.43.2


