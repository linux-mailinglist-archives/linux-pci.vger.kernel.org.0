Return-Path: <linux-pci+bounces-4293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C3E86DAF3
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 06:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC49283B0B
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 05:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE2F51C52;
	Fri,  1 Mar 2024 05:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B4fLqj2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055E52F7D;
	Fri,  1 Mar 2024 05:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709269989; cv=none; b=H6Xkk2/72BJYYI0+c91AzJSeEubOszbOjuNhrGBKIDQOdjY/PWtENadu7B0iN3+4tZyFKiyLciSaBGaobUNoenlhkcJrn2SdwIYeVbTJHRpKt1ED/tIBxgQdtp0l1yOSPEDnMW1EeXlAsFXrikcz/2VjDS8yvSQZBCmnbexx5dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709269989; c=relaxed/simple;
	bh=lJDZVXEYtZZrc2wCsRgU3zHsOsubjinXlyfGLgF+StM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVmBZsOOkrHEtgzMUrTlsV9ThwCJc7yKlkL8RMaCOHFzvzImAsJomGWCo6kqjveKnbEZrapjXfqLwjlUIaYFlAL4wZi+b7sZRlmmnt26gNjZwYFCMYIZit59V3C/2rhAsAfg9smDOv1MVEIj/2r/3/AvEqNFT2bondFzwsyGPlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B4fLqj2H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4213k6nG032150;
	Fri, 1 Mar 2024 05:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=vO1+TkbuZCWShjiBHhEgeYIA4w5QtFn0J+b+a3N0mpk=; b=B4
	fLqj2HQYOsfwzgEX3nsMmOiPIjjt3FcP9pvVXX9KmHJsSKfJ3ZLKL7Qgc4X+CGXR
	jVGBS4BZJTnDveH5BJJWBiq5mjFCnL6yve8waE14sCwjPqLKxdy+AfsKMPTUdMso
	bV3lpod2bc4KO2Xn+PeA+Z3TIlrEb9rbuANlgYi5DUlfMyxJNtZWv2BRd04SofG8
	zBWUceMdVLK1T2zPWy6TxidI0I7p94MrVVxNwwZgwzGH5lL6FIuozCL0bxHeSv+2
	lzZNcij5cgJYgnyXO3AHsXkRFY+kIP/T1XzVM23VXHZR2rUo1jTxgI7rNpMp6m6E
	yKCyGdVI/iFcaHSxpllg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wk7cg84jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 05:12:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4215Cstx024006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 05:12:54 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 29 Feb 2024 21:12:53 -0800
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
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Josh Triplett
	<josh@joshtriplett.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v1 2/3] PCI: dwc: add equalization settings for gen4
Date: Thu, 29 Feb 2024 21:11:35 -0800
Message-ID: <20240301051220.20917-3-quic_schintav@quicinc.com>
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
X-Proofpoint-ORIG-GUID: yjU_sUF6tKHzJAhTLgYCbUdPCMq8Rodr
X-Proofpoint-GUID: yjU_sUF6tKHzJAhTLgYCbUdPCMq8Rodr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010042

GEN3_RELATED_OFFSET is being used as shadow register for generation4 and
generation5 data rates based on rate select mask settings on this register.
Select relevant mask and equalization settings for generation4 operation.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-cmn.c | 31 ++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-cmn.h | 23 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c  |  4 +++
 drivers/pci/controller/dwc/pcie-qcom.c     |  4 +++
 4 files changed, 62 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.c b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
index 0f8d004fbc79..cfdc04eef78c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-cmn.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
@@ -18,6 +18,37 @@
 #define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
 		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
 
+void qcom_pcie_cmn_set_gen4_eq_settings(struct dw_pcie *pci)
+{
+	u32 reg;
+
+	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
+	reg |= (0x1 << GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT);
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
+
+	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
+	reg &= ~GEN3_EQ_FMDC_T_MIN_PHASE23_MASK;
+	reg &= ~GEN3_EQ_FMDC_N_EVALS_MASK;
+	reg |= (GEN3_EQ_FMDC_N_EVALS_VAL <<
+		GEN3_EQ_FMDC_N_EVALS_SHIFT);
+	reg &= ~GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_MASK;
+	reg |= (GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_VAL <<
+		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_SHIFT);
+	reg &= ~GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_MASK;
+	reg |= (GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_VAL <<
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
+EXPORT_SYMBOL_GPL(qcom_pcie_cmn_set_gen4_eq_settings);
 
 int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)
 {
diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.h b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
index 8794dbd4775c..08e1bd179207 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-cmn.h
+++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
@@ -9,10 +9,29 @@
 #include "../../pci.h"
 #include "pcie-designware.h"
 
+#define GEN3_EQ_CONTROL_OFF			0x8a8
+#define GEN3_EQ_CONTROL_OFF_FB_MODE_MASK        GENMASK(3, 0)
+#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE   BIT(4)
+#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK	GENMASK(23, 8)
+#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL	BIT(24)
+
+#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac
+#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_VAL   0x5
+#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_VAL  0x5
+#define GEN3_EQ_FMDC_N_EVALS_VAL          0xD
+#define GEN3_EQ_FMDC_T_MIN_PHASE23_MASK         GENMASK(4, 0)
+#define GEN3_EQ_FMDC_N_EVALS_MASK               GENMASK(9, 5)
+#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_MASK  GENMASK(13, 10)
+#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_MASK	GENMASK(17, 14)
+#define GEN3_EQ_FMDC_N_EVALS_SHIFT			5
+#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_SHIFT		10
+#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_SHIFT	14
+
 #ifdef CONFIG_PCIE_QCOM_CMN
 int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem);
 int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
 void qcom_pcie_cmn_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
+void qcom_pcie_cmn_set_gen4_eq_settings(struct dw_pcie *pci);
 #else
 static inline int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)
 {
@@ -27,4 +46,8 @@ static inline int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *i
 static inline void qcom_pcie_cmn_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem)
 {
 }
+
+static inline void qcom_pcie_cmn_set_gen4_eq_settings(struct dw_pcie *pci)
+{
+}
 #endif
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index ce6343426de8..0b169bcd081d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -438,6 +438,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		goto err_disable_resources;
 	}
 
+	/* set Gen4 equalization settings */
+	if (pci->link_gen == 4)
+		qcom_pcie_cmn_set_gen4_eq_settings(pci);
+
 	/*
 	 * The physical address of the MMIO region which is exposed as the BAR
 	 * should be written to MHI BASE registers.
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 57a08294c561..ad0cd55da777 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -263,6 +263,10 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
+	/* set Gen4 equalization settings */
+	if (pci->link_gen == 4)
+		qcom_pcie_cmn_set_gen4_eq_settings(pci);
+
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
 		pcie->cfg->ops->ltssm_enable(pcie);
-- 
2.43.2


