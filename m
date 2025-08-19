Return-Path: <linux-pci+bounces-34257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B1FB2BA9A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98367B8F45
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F242F311582;
	Tue, 19 Aug 2025 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LDknqn+p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E35730F801;
	Tue, 19 Aug 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587833; cv=none; b=TQDGB5clY6x5ZgFpZfyVoq4d+djGgMqL00EtWrh751vQemJVosWuVHhTNNU0RQgQKD16dfGd6SZQmgVgqURUBtC3qIZGm2Am7iWmt1kvhs/S2wxpk6Kf74ql3aUhAm0SgBnkcldnP/zZKL0XMtke1JLkcdrzFkLB7o6cNAes9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587833; c=relaxed/simple;
	bh=/K2ZZ3aSOc75uG6jwVft7Z+OjL7tdOAJcwHvCTK6B7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6QHcxv8d/pU4XakfLq9EWCSn+DuCPp7Bn/9+p+ySvFcF4DSqKf54YBiASbR7ZOIcZEdRViGv2d9G/C/tFSzEXMT+bg3Kpi46Uku1ixNkt4Y3X8yAm+rxxp2MuSjiMNZTHpG0WfYx6LA4PXvwh8W8GOMr4tCa+mN+8JZVZKzIMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LDknqn+p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J038sh022565;
	Tue, 19 Aug 2025 07:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=reK9yJ+1FG4
	UAR6LmVPZZyLN9FV6+a5NRwdu3ER/wIk=; b=LDknqn+pDAtSu0Pyf136QCrKR4Y
	V3XDboHzUSGHl61VrQDEuMmDDz3sS3r3cOQnJsQSHSkWuRTlrf8i192Ur3V1gQZc
	Tn82EvftZ7ByC4Bmlbi5BEn04ca8p5VfINY+lv2kOmQv/Xb07E+/1t9XFnHUBMoU
	FTTNydAA+a6VL09MkHQgf58tArBgO2vX6ilTCBoU2xz9ByaUrHXS475lelnqV98a
	/nUKjv87y/E7yxxY8fz5EAMZqN1yeswRaJ/sG22v887IZ5dvPKe3IBWI+jxcGS8h
	hQo6Y9f8T6LJ6jeGf1VKvV72fLtNQT+s/2Ukf2ZcX+vn3u5H7GoOkb4ed9A==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99qh7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:17:00 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J7Gv47031752;
	Tue, 19 Aug 2025 07:16:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 48jk2m3ekq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:16:57 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57J7GvqZ031741;
	Tue, 19 Aug 2025 07:16:57 GMT
Received: from ziyuzhan-gv.ap.qualcomm.com (ziyuzhan-gv.qualcomm.com [10.64.66.102])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 57J7Guad031723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:16:57 +0000
Received: by ziyuzhan-gv.ap.qualcomm.com (Postfix, from userid 4438065)
	id 2B9A5521; Tue, 19 Aug 2025 15:16:55 +0800 (CST)
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v5 2/3] PCI: qcom: fix macro typo for CURSOR
Date: Tue, 19 Aug 2025 15:16:47 +0800
Message-ID: <20250819071649.1531437-3-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819071649.1531437-1-ziyue.zhang@oss.qualcomm.com>
References: <20250819071649.1531437-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: LrE5RDTExgu6r5AIVB7CV9WqaEzc9tF5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfX4H2xE+dSvvWW
 FKseMWTdoKAMdF5j+lUMQAN47ytW1AgWaBQizMrKQOZdPSF8Vs9RYmtFe+ym+WOjklIqjYADxhS
 qVvqG5xk8SIIa5lTMU0yWxoNkLQ+dYYXWKJRBsvpAq+YqsQ32iEXRzvu1oFjwRqhrtU9xpwDymB
 Vex028UU4IYkmodWmm6bBPNmgRVj8xIblEBVfVhJdOd+MiftDTDwgHN0Sw5GqgsUWis17G/kggB
 NluF1jqG6yBUd9M6DPHJGviqOmIqrKyyqGfxUC+sYu9nVs3ie4GMRRZPAb/qmPbxMN8Dq97wHVp
 uxo+xseblzRU9tHnv8aC2dGnA7K4vP/UAbIFnlHhKylLTfDhbUsSn1snABQoTQZcYDz4O8+kPlK
 BcL9Tp24
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a424ec cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=yZn9HN9ZKZZuwR4VxpAA:9
X-Proofpoint-GUID: LrE5RDTExgu6r5AIVB7CV9WqaEzc9tF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

Corrected a typo in the macro name GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA and
GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA to ensure consistency and avoid
potential issues.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.h  | 4 ++--
 drivers/pci/controller/dwc/pcie-qcom-common.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 11de844428e5..266f91045577 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -133,8 +133,8 @@
 #define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF		0x8AC
 #define GEN3_EQ_FMDC_T_MIN_PHASE23		GENMASK(4, 0)
 #define GEN3_EQ_FMDC_N_EVALS			GENMASK(9, 5)
-#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA	GENMASK(13, 10)
-#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA	GENMASK(17, 14)
+#define GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA	GENMASK(13, 10)
+#define GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA	GENMASK(17, 14)
 
 #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
 #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
index cb98e66d81d9..852ef4d3bb56 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -38,12 +38,12 @@ void qcom_pcie_common_set_equalization(struct dw_pcie *pci)
 		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
 		reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
 			GEN3_EQ_FMDC_N_EVALS |
-			GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
-			GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
+			GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA |
+			GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA);
 		reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
 			FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
-			FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
-			FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
+			FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA, 0x5) |
+			FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA, 0x5);
 		dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
 
 		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
-- 
2.43.0


