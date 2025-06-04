Return-Path: <linux-pci+bounces-28950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB996ACDAD3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 11:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532483A5307
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE49628C84F;
	Wed,  4 Jun 2025 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IR1gSq5V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F828B500;
	Wed,  4 Jun 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028806; cv=none; b=uU6TVjBeDX1wpoWiqsrlXDm+qVRrh9WB2oIu/sNRwEfTzAN6r7Q7PJ/y1aLpyPQBtchSicuEpNSgmAzB+ISr8WUlNlK5hX7rNQX/VZU9+P1rvdqUrZQruXI60K0sMTB/u6TPlzh8rIjN4JiV04ItcY/U7RFzcJ4M5CLFdCNrJDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028806; c=relaxed/simple;
	bh=WMJ+2FDMzvwwk4n9rjcMxQKcv0nbmdceR8unomBAUaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hDes+MrJDCFAdNlM3/TTE6OOJhRmIfhwWAe+SROKaW5ea0LS/y1Pl5dKohB48DLz2gI924CCy0pGc8YYXgXaZI33GeJkwjjbQ1lkDudbWeKx9OseSd8hGfljoiYLPVYhQibCpcPn/JxzoTk9adYlwHex8W/VjFG4sDIWSnAhPEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IR1gSq5V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5548K97F027289;
	Wed, 4 Jun 2025 09:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/RFb4Mva0y7
	NPvI1Dh63uBQ40b2bk/sRpMb9QwhsANk=; b=IR1gSq5VuYaXq86tlzeyr8PEdp3
	nZPt8gSMmtJvQ2SwPLGdzkww80btNThg4UJnM5ym4dBXL2iKN5qpYNFOwzMaQVjg
	rw34GJ7gbuMypUbl6u17//K1FMMLwrTq5LrfbcNn+Kc/l4BlvcxxvK6hLYJV21rJ
	xtCnWi57uFeU6Vo+I25icKq6jS3SKSCqdf2IW4d+S4v6vb0asVd2Qz5KEDGcNg3U
	QwV4qoHvC8BqBVEcFGVF0DHKN3bpfYDmfv2STz/87djEjd/S7KopbqL6jRd+uBop
	AFaHitNhPb82Q/uKwx8ibizlsczvmc3zKs48cDY7WSje48whlPs5177PEMw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8swgsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:19:55 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5549Jrbg021539;
	Wed, 4 Jun 2025 09:19:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46ytumf3e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:19:53 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5549Jrmx021533;
	Wed, 4 Jun 2025 09:19:53 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5549Jq2d021530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:19:53 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id E05FC35E2; Wed,  4 Jun 2025 17:19:51 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
        krzk+dt@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: [PATCH v1 1/2] PCI: qcom: Add equalization settings for 8.0 GT/s
Date: Wed,  4 Jun 2025 17:19:45 +0800
Message-Id: <20250604091946.1890602-2-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604091946.1890602-1-quic_ziyuzhan@quicinc.com>
References: <20250604091946.1890602-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=RMizH5i+ c=1 sm=1 tr=0 ts=68400fbc cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=EJA3nsRW0WvAYhpDu64A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2OSBTYWx0ZWRfXx2xiNm5zmX3K
 GtGibazl4bc/JNyyb8K9mRADYx00uCNefbzhF+eQ12ZB0EL2Srmr8+hfgzs9n2RIxP/bfOUFE97
 j3AnOqrEWDOQOCDxPMSqQo77WqUgRIfnp1CRWoVZi35b7vQFoIhp8OQTFhKWdCsOTUzciHONGoO
 jqeoYL1de4S64FjjwvCwE1+CrMHYk3s4WwH4BR1VcATxmF7vWPcCCDTm9OIQJrAFwTqn7dLMImy
 gN2QJvFgLVBknsB1gFueUm0chbaXw4OAVP0dtODSjYms0OrO7gjfCN27skOFsERT8IxWNSggFJg
 5oDouKOKtvH9idWpmDsnLFGvn8aGMrMmpfFthWKiyPCkog+/3zj/JQWvARrqVvodVb16T/vuPcH
 3y0GHm9ME4oFYVxgEd2a3tJSsK7O7cghU0JOy1/49S2N8fpn1nygObTFAz5rCCJ0amDWxN0q
X-Proofpoint-GUID: 42rWv-a8nDP2KL86tq3kGANHk1eSL32P
X-Proofpoint-ORIG-GUID: 42rWv-a8nDP2KL86tq3kGANHk1eSL32P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040069

Adding lane equalization setting for 8.0 GT/s to enhance link stability
and fix AER correctable errors reported on some platforms (eg. SA8775P).

GEN3 and GEN4 require the same equalization setting. This setting is
programmed into a group of shadow registers, which can be switched to
configure equalization for different GEN speeds by writing 00b, 01b
to `RATE_SHADOW_SEL`.

Hence program equalization registers in a loop using link speed as index,
so that equalization setting can be programmed for both GEN3 and GEN4.

Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 drivers/pci/controller/dwc/pcie-qcom-common.c | 55 ++++++++++---------
 drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  3 +-
 4 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ce9e18554e42..388306991467 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -127,7 +127,6 @@
 #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
-#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT	0x1
 
 #define GEN3_EQ_CONTROL_OFF			0x8A8
 #define GEN3_EQ_CONTROL_OFF_FB_MODE		GENMASK(3, 0)
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
index 3aad19b56da8..48040f20b29c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -8,43 +8,46 @@
 #include "pcie-designware.h"
 #include "pcie-qcom-common.h"
 
-void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
+void qcom_pcie_common_set_equalization(struct dw_pcie *pci)
 {
 	u32 reg;
+	u16 i;
 
 	/*
 	 * GEN3_RELATED_OFF register is repurposed to apply equalization
-	 * settings at various data transmission rates through registers namely
-	 * GEN3_EQ_*. The RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
+	@@ -19,32 +21,34 @@ void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
 	 * determines the data rate for which these equalization settings are
 	 * applied.
 	 */
-	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
-	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
-			  GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT);
-	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
+	for (i = PCIE_SPEED_8_0GT; i <= (pcie_link_speed[pci->max_link_speed] < PCIE_SPEED_32_0GT ?
+		 pcie_link_speed[pci->max_link_speed] : PCIE_SPEED_16_0GT); i++) {
+		reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+		reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+		reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
+		reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
+			  i - PCIE_SPEED_8_0GT);
+		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
 
-	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
-	reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
-		GEN3_EQ_FMDC_N_EVALS |
-		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
-		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
-	reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
-		FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
-		FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
-		FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
-	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
+		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
+		reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
+			GEN3_EQ_FMDC_N_EVALS |
+			GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
+			GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
+		reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
+			FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
+			FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
+			FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
+		dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
 
-	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
-	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
-		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
-		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
-		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
-	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
+		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
+		reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
+			GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
+			GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
+			GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
+		dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
+	}
 }
-EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_equalization);
+EXPORT_SYMBOL_GPL(qcom_pcie_common_set_equalization);
 
 void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci)
 {
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
index 7d88d29e4766..7f5ca2fd9a72 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.h
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
@@ -8,7 +8,7 @@
 
 struct dw_pcie;
 
-void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci);
+void qcom_pcie_common_set_equalization(struct dw_pcie *pci);
 void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci);
 
 #endif
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c789e3f85655..51eac2dc6222 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -298,8 +298,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
+	qcom_pcie_common_set_equalization(pci);
+
 	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT) {
-		qcom_pcie_common_set_16gt_equalization(pci);
 		qcom_pcie_common_set_16gt_lane_margining(pci);
 	}
 
-- 
2.34.1


