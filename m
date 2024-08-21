Return-Path: <linux-pci+bounces-11971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE9D95A395
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 19:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6FC1F21311
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6D11B2524;
	Wed, 21 Aug 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DWGZNY/L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78C1B250D;
	Wed, 21 Aug 2024 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260219; cv=none; b=Splq5CJu0PFtQorIf52Y8nFIAxN/ZuNira80TdQIkPpHAuaeRDCCVk2wQK8w1qMvr0qfsfHNZQqyhHHlmkGTc+/zjb5dYIC6tkSdIiLT3OaLZXkr8dOEZCKvhOXD9XHGWzUOR813XKpbZfWf6Fd5MZvXaguJWQlqv7+cQJMix0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260219; c=relaxed/simple;
	bh=VeKgVBP+HIWb8mOlTlBXYPkmLOikNhQ3OhCL3r2AG0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiAtiPdwhvaR7NDFn/XrAAPU+pqRl0pZJ0YJMUK/J9mXrdV82BwOMTCyoho9sLjdli6iLx9CNflCCeoEMNrbC2S2UykfZEM0dN4ueNFSD7mTjNSHYOZyh8FkDXZOAqehn5xql/SLkhkihosLja7CMRFH7bQqOJmfjfw9DYPOGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DWGZNY/L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LB4dHX006765;
	Wed, 21 Aug 2024 17:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WLWeMVzP9bm09dnH+qL1lI842S6T9Tj73KzL81nFV1w=; b=DWGZNY/L+c0iZ+2u
	j6WV2D/6GFR2evnL04Ml2wgCZAwKDkYChhQzer4VLG8xQN1OMnyPy2DwBbPx+Rj4
	K6932evpMwfUyJ9wCtaMrHSbt4AJE8ACMeKuYN2rzSpyQvD8vdcdTjpoaNPeeus2
	u1yApnm5LC9FpGujhMgla909pAT07uOomi4hvF0Bs2yzk0QvRla9P+vvJgE5zHtC
	fGSS/7ELKc6uFNtZTt7c99x5PgX0zcuzfgzCRPAlEJhfGiXcaNpfyL6M4v49bS0u
	j/w5WIsPIfW3rqcwUYjY3OK+tD1GstNrs5sdGemqXA3O4Jdlqng4VwoBaeNWo211
	33GJrg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4159adagvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 17:09:59 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LH9vO7010914
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 17:09:57 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 21 Aug 2024 10:09:57 -0700
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mani@kernel.org>
CC: <quic_msarkar@quicinc.com>, <quic_kraravin@quicinc.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Niklas Cassel <cassel@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v5 2/3] PCI: qcom: Add equalization settings for 16 GT/s
Date: Wed, 21 Aug 2024 10:08:43 -0700
Message-ID: <20240821170917.21018-3-quic_schintav@quicinc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821170917.21018-1-quic_schintav@quicinc.com>
References: <20240821170917.21018-1-quic_schintav@quicinc.com>
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
X-Proofpoint-GUID: XqakE0XSd4UpmVA11VxDlQck2fDVmhmq
X-Proofpoint-ORIG-GUID: XqakE0XSd4UpmVA11VxDlQck2fDVmhmq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=979
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210124

During high data transmission rates such as 16 GT/s , there is an
increased risk of signal loss due to poor channel quality and
interference. This can impact receiver's ability to capture signals
accurately. Hence, signal compensation is achieved through appropriate
lane equalization settings at both transmitter and receiver. This will
result in increased PCIe signal strength.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.h  | 12 ++++++
 drivers/pci/controller/dwc/pcie-qcom-common.c | 37 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  3 ++
 drivers/pci/controller/dwc/pcie-qcom.c        |  3 ++
 5 files changed, 56 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 53c4c8f399c8..50265a2fbb9f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -126,6 +126,18 @@
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
index 1d8992147bba..e085075557cd 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -15,6 +15,43 @@
 #include "pcie-designware.h"
 #include "pcie-qcom-common.h"
 
+void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
+{
+	u32 reg;
+
+	/*
+	 * GEN3_RELATED_OFF register is repurposed to apply equalization
+	 * settings at various data transmission rates through registers
+	 * namely GEN3_EQ_*. RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
+	 * determines data rate for which this equalization settings are
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
 	struct icc_path *icc_p;
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
index 897fa18e618a..c281582de12c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.h
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
@@ -13,3 +13,4 @@
 struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path);
 int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem, u32 bandwidth);
 void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
+void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index e1860026e134..823e33a4d745 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -455,6 +455,9 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		goto err_disable_resources;
 	}
 
+	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
+		qcom_pcie_common_set_16gt_eq_settings(pci);
+
 	/*
 	 * The physical address of the MMIO region which is exposed as the BAR
 	 * should be written to MHI BASE registers.
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ee32590f1506..829b34391af1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -280,6 +280,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
+	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
+		qcom_pcie_common_set_16gt_eq_settings(pci);
+
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
 		pcie->cfg->ops->ltssm_enable(pcie);
-- 
2.46.0


