Return-Path: <linux-pci+bounces-4930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 305EE880BE8
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 08:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D3B284820
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 07:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BB729409;
	Wed, 20 Mar 2024 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DXHGbsM0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE12208B;
	Wed, 20 Mar 2024 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919120; cv=none; b=PCiay21QxKLZbG13AbMfI5QNYQkkcumos2G76o1MQmGIMs5A3BDCvYB1/GoUxH/ezBpg0cPfvC8hNTUe/3DM4YB9+a5xgXfNNpzFafSQnKPIsl5eGCaeN7Beh59eBfuMpeLoi84GcP/NJ+BxFemoKN5cuYP1VrWyc3Jb85Cw+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919120; c=relaxed/simple;
	bh=WVX6rzaTh0T3wiUZzO6oHX/wcJaW2l2l4l4yu3Dybh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIOnVOaKqSEKGEOf2KwXocyM5GXZKRD52oH+CKa5O+nSen17CcKERPDc4QLdO2uimZ3+3ILfb9q9R6g9L/qbW8SAi6d3M9v/cL+FR3VF8btIIzXOgOuBmAHq71z/NndxsTsqRQnZ5nCK+QC84s7jkjd/XqwYv3Ize3EmW9HGSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DXHGbsM0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K4WBoY025290;
	Wed, 20 Mar 2024 07:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=GZwsLs+Ov9uEHLCdzAKcsfTpRz9mkq4ZM2Oiq6R5864=; b=DX
	HGbsM0+NMxnGA8FfkKyORL0OJQtTmTK+55yi6ZtYOd1PO99kitBrnddcQiIXi/hJ
	5i14gChYGRk6rPhb1cBpSkoCy9x7+fOlyVqDXi/UvBaPWvj0O4ziUzF6Y9gXfN2p
	PijuWGLLJrqkJDSsQhRRJVpH1glFxHE4s1n6DNu69lAZ0U9Es3X7ezDNdFnHjA1P
	4B9nQxNY8Y1p3EjOBD166L+P7upC5iXJXtR4qLfYgzg+YWuIPaIkpbxu8nwvGbUW
	J882knFDrWkxgOooLwTl/ecnk8/WK6t0FLsw1G3s9GZmD61DA7Ki3oVIgpBmH7Ez
	85DPreO9QDgA3PWzGBMA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyh8e14p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 07:16:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K7G1fe013574
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 07:16:01 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 00:16:00 -0700
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
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 2/3] PCI: qcom: Add equalization settings for gen4
Date: Wed, 20 Mar 2024 00:14:46 -0700
Message-ID: <20240320071527.13443-3-quic_schintav@quicinc.com>
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
X-Proofpoint-ORIG-GUID: HcvU1rMtZ3FiF8IFbt9x9vyL_-9dVjVW
X-Proofpoint-GUID: HcvU1rMtZ3FiF8IFbt9x9vyL_-9dVjVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200057

GEN3_RELATED_OFFSET is being used as shadow register for generation4 and
generation5 data rates based on rate select mask settings on this register.
Select relevant mask and equalization settings for generation4 operation.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 15 ++++++++
 drivers/pci/controller/dwc/pcie-qcom-cmn.c   | 36 ++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-cmn.h   |  5 +++
 drivers/pci/controller/dwc/pcie-qcom-ep.c    |  3 ++
 drivers/pci/controller/dwc/pcie-qcom.c       |  3 ++
 5 files changed, 62 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae4837462..064744bfe35a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -122,6 +122,21 @@
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
 
+#define GEN3_EQ_CONTROL_OFF			0x8a8
+#define GEN3_EQ_CONTROL_OFF_FB_MODE_MASK        GENMASK(3, 0)
+#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE   BIT(4)
+#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK	GENMASK(23, 8)
+#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL	BIT(24)
+
+#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac
+#define GEN3_EQ_FMDC_T_MIN_PHASE23_MASK         GENMASK(4, 0)
+#define GEN3_EQ_FMDC_N_EVALS_MASK               GENMASK(9, 5)
+#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_MASK  GENMASK(13, 10)
+#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_MASK	GENMASK(17, 14)
+#define GEN3_EQ_FMDC_N_EVALS_SHIFT			5
+#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_SHIFT		10
+#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_SHIFT	14
+
 #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
 #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.c b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
index 64fa412ec293..208a55e8e9a1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-cmn.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
@@ -17,6 +17,42 @@
 #define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
 		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
 
+void qcom_pcie_cmn_set_16gt_eq_settings(struct dw_pcie *pci)
+{
+	u32 reg;
+
+	/*
+	 * GEN3_RELATED_OFF is repurposed to be used with GEN4(16GT/s) rate
+	 * as well based on RATE_SHADOW_SEL_MASK settings on this register.
+	 */
+	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
+	reg |= (0x1 << GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT);
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
+
+	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
+	reg &= ~GEN3_EQ_FMDC_T_MIN_PHASE23_MASK;
+	reg &= ~GEN3_EQ_FMDC_N_EVALS_MASK;
+	reg |= (GEN3_EQ_FMDC_N_EVALS_16GT_VAL <<
+		GEN3_EQ_FMDC_N_EVALS_SHIFT);
+	reg &= ~GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_MASK;
+	reg |= (GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_16GT_VAL <<
+		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_SHIFT);
+	reg &= ~GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_MASK;
+	reg |= (GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_16GT_VAL <<
+		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_SHIFT);
+	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
+
+	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
+	reg &= ~GEN3_EQ_CONTROL_OFF_FB_MODE_MASK;
+	reg &= ~GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE;
+	reg &= ~GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL;
+	reg &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK;
+	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
+}
+EXPORT_SYMBOL_GPL(qcom_pcie_cmn_set_16gt_eq_settings);
+
 int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)
 {
 	if (IS_ERR(pci))
diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.h b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
index 845eda23ae59..97302e8fafa8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-cmn.h
+++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
@@ -9,6 +9,11 @@
 #include "../../pci.h"
 #include "pcie-designware.h"
 
+#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_16GT_VAL   0x5
+#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_16GT_VAL  0x5
+#define GEN3_EQ_FMDC_N_EVALS_16GT_VAL          0xD
+
 int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem);
 int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
 void qcom_pcie_cmn_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
+void qcom_pcie_cmn_set_16gt_eq_settings(struct dw_pcie *pci);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index ce6343426de8..b6bcab21bb9f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -438,6 +438,9 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		goto err_disable_resources;
 	}
 
+	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
+		qcom_pcie_cmn_set_16gt_eq_settings(pci);
+
 	/*
 	 * The physical address of the MMIO region which is exposed as the BAR
 	 * should be written to MHI BASE registers.
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 57a08294c561..b0a22a000fa3 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -263,6 +263,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
+	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
+		qcom_pcie_cmn_set_16gt_eq_settings(pci);
+
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
 		pcie->cfg->ops->ltssm_enable(pcie);
-- 
2.43.2


