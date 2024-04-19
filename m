Return-Path: <linux-pci+bounces-6468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C618AA628
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 02:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072321F2246B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 00:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3283209;
	Fri, 19 Apr 2024 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jMc2gYKv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46263F9EF;
	Fri, 19 Apr 2024 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713485467; cv=none; b=KQ5TgFFtxWrLKBRPpQNJuhYa4jl2kt/MnpfxMrfHuACby73qrcK08A4g/6G2BUbs8OGE/N22WmTq8o7POQPa1c20RYbT/0C/lrRQzgDhAHEzmnX2KVmD8X/duHYcdnIkanjbAbp+KzcNbkhcCpb2ts0JmpxMLmeIbCbWOZy7MYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713485467; c=relaxed/simple;
	bh=v66b4aJQWO0i/mL8XgtA3gfflpX1asf5E1/7JRiIcQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imvT6+NAGndooPYDRtOj3b5E/kulV8P9cz/c1fskfEnvq4USryh8FIqTDq1B19aY4s+rax7NxeNMUEEY/0PoDESYcIVXmYoMCDlwC18gtyWRDl5oacWQRwF4zJCopzsC9M6YuaokloepAk6gpMdz13o3Td/cfXJFCTfeCS97RQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jMc2gYKv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IMaAFf010920;
	Fri, 19 Apr 2024 00:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=VeqS4J+SdTS4zg8NDopZijK8BCw4bfOv4Pu+bprKXm8=; b=jM
	c2gYKvLoPNJ9/GxUUwpgIQdGUvnJM+3GPoZVPM6Jwt2MuRDVGA/nKl0ccPnjL01S
	3/9pBFF9hntS9uL+71WXxYgjDdOuWZ/nsJLSKRbOLDPIgR7OOZOl5Ani2e5E20Z1
	fu6/l/35HNX7YJNQSN1a/nxYF3u1jUzztjtbfLt3sUNiFuSLxTvU+UvHv+338bLM
	giWm3NGnRprsLe12EsL7RuaXwlN2LV36rhOUqXalJaW9oCE2il4lWWETJOnSAijw
	+WtV/W8nC17m3oPEb0GEDHKYtiGSWtLufUu7yXstIrv9qupFRvYu6z7/AjaAYET8
	f0dLHWY4XJN4OSXgM8lg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjuphtk6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 00:10:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43J0AmkK004561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 00:10:48 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 17:10:47 -0700
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
Subject: [PATCH v3 2/3] PCI: qcom: Add equalization settings for 16GT/s
Date: Thu, 18 Apr 2024 17:09:35 -0700
Message-ID: <20240419001013.28788-3-quic_schintav@quicinc.com>
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
X-Proofpoint-GUID: ix49cfQ_RgX75NJCIH3JFxzsb8CUggxe
X-Proofpoint-ORIG-GUID: ix49cfQ_RgX75NJCIH3JFxzsb8CUggxe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_21,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404190000

GEN3_RELATED_OFFSET is being used to determine data rate of shadow
registers. Select data rate as 16GT/s and set appropriate equilization
settings to improve link stability for 16GT/s data rate.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware.h  | 12 ++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.c | 30 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  3 ++
 drivers/pci/controller/dwc/pcie-qcom.c        |  3 ++
 5 files changed, 49 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae4837462..ad771bb52d29 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -122,6 +122,18 @@
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
 
+#define GEN3_EQ_CONTROL_OFF			0x8a8
+#define GEN3_EQ_CONTROL_OFF_FB_MODE(n)		FIELD_PREP(GENMASK(3, 0), n)
+#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE(n)	FIELD_PREP(BIT(4), n)
+#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC(n)	FIELD_PREP(GENMASK(23, 8), n)
+#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL(n)	FIELD_PREP(BIT(24), n)
+
+#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac
+#define GEN3_EQ_FMDC_T_MIN_PHASE23(n)	FIELD_PREP(GENMASK(4, 0), n)
+#define GEN3_EQ_FMDC_N_EVALS(n)		FIELD_PREP(GENMASK(9, 5), n)
+#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA(n)	FIELD_PREP(GENMASK(13, 10), n)
+#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA(n)	FIELD_PREP(GENMASK(17, 14), n)
+
 #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
 #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
index dc2120ec5fef..a6f3eb4c3ee6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -16,6 +16,36 @@
 #define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
 		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
 
+void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
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
+	reg = GEN3_EQ_FMDC_T_MIN_PHASE23(0) |
+		GEN3_EQ_FMDC_N_EVALS(0xD) |
+		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA(0x5) |
+		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA(0x5);
+	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
+
+	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
+	reg = GEN3_EQ_CONTROL_OFF_FB_MODE(0) |
+		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE(0) |
+		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL(0) |
+		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC(0);
+	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
+}
+EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
+
 int qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, struct icc_path **icc_mem_p)
 {
 	*icc_mem_p = devm_of_icc_get(pci->dev, "pcie-mem");
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
index f0520d7301da..e72c651b0d28 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.h
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
@@ -10,3 +10,4 @@
 int qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, struct icc_path **icc_mem_p);
 int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
 void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
+void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 11c99b358147..cb75a874f76c 100644
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
index 71f011daad1d..acf66f974edc 100644
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


