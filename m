Return-Path: <linux-pci+bounces-35432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DBEB432DB
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 08:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B046F1C25773
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 06:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1C9285C8A;
	Thu,  4 Sep 2025 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EczCifLE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281FC2857E0;
	Thu,  4 Sep 2025 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968769; cv=none; b=fjUjhWOPfA1pzHfvPyfTH96mJDQhEJ5wO2Vv1uKbOUKdlHP5qmuhazxg0k8TTlOrqs1O/xzAkh2OofUsk8uNNhWY/lrcvth+Dcup0OOjXW7TNAeEDzETn+DKWf5fVc/UDOEWGkhHZF2ggFW/wCH1J/BxuH0otHybKvzkBqN+Bu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968769; c=relaxed/simple;
	bh=TYNSKhxj9q7Ci/yWtI8TRRm/7yHFC6K9MlZnx6+Dd/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twVLSofDhd60boj/zRhc2S9pi/6nX6c6hd0FxjY3meASmDJ+hUhio6BY0CDLiX82XC8CJos0NWOcOyzbIC5ITbSsyGIqOzpBh9ubyiSVq2lFzi9oagFeqJxtb7qHvxY/UvDAGr83iSj7RYy03CMAQEgsxR24sTbjyWCy/O2d+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EczCifLE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58404SPf007644;
	Thu, 4 Sep 2025 06:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=G3wNSnGOcZa
	kMZ9/76wkr48ic8NEKdbhqlHXvt4rFHo=; b=EczCifLE0yPysyphEWQ4fOOt8uW
	Skc2obET7xrX1MkkoSPuJZZU2Wxd6VilKrwW3KdHkswzCyK92R3C37fcfcMbRgto
	ib6QzI+NnAK220X5vzF8Zn9RSZFZhgMP0yzBw/hdljNm9TMUugkx6YRfKkI7NQQv
	zIxA5fjhZZrOBphNOiuCFjTOg4dmE1fY2b32wNtw983x4BzxxRIog0G3YnRa7DhM
	g2GFRM4rByuFKbip9TqYuFjf0+UEpeWwdom1m2j/LHoC70DFv3fYh8CAmHCN38Do
	cOandGe9/PZn6MQlPTcVlo05ikE0O9yOcAjiC3RPMDwr/3o/G+DI4lbFIKw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv6mx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 06:52:37 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5846qZMQ027260;
	Thu, 4 Sep 2025 06:52:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 48utcmhds6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 06:52:35 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5846qYhS027247;
	Thu, 4 Sep 2025 06:52:35 GMT
Received: from ziyuzhan-gv.ap.qualcomm.com (ziyuzhan-gv.qualcomm.com [10.64.66.102])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5846qYQ0027243
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 06:52:35 +0000
Received: by ziyuzhan-gv.ap.qualcomm.com (Postfix, from userid 4438065)
	id 25809525; Thu,  4 Sep 2025 14:52:33 +0800 (CST)
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
Subject: [PATCH v6 2/3] PCI: qcom: fix macro typo for CURSOR
Date: Thu,  4 Sep 2025 14:52:24 +0800
Message-ID: <20250904065225.1762793-3-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904065225.1762793-1-ziyue.zhang@oss.qualcomm.com>
References: <20250904065225.1762793-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX75mAYVJroFQz
 oPV028YbgYVJNnU93i/2InmkWs55s/QRxuQxAVZ3xYLlMUVHLSHJk1CS4tmuQTP52iRFpo4SAe4
 rBnoX4tXfIFmNuYA3IZOnvNRLfNiy3wmGBanxneeB7CLcXBe/uY+K1b9t9bKCDQylAsXvVsG6on
 8sim4+wL1QKSE2zNGfwc+UoeNDncS57hm80St5Lr60ByxNhZlaAd67RYfWUyBj34CGRVabCUxXm
 g9UaSUhun2k2XxrtUEho2+BZ3QDFIvg3AqRIuFZxfGdNt0utWqCQjQLqe8RNdXm4yQ4U0PoPYJC
 wPy42DnF5NV5bikFk1LokFUN7m94n5A96ioK2yjviJHuxvytTrVztcJsEzNiocQP5FT6/1oaj1r
 bixSJAc7
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b93736 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=yZn9HN9ZKZZuwR4VxpAA:9
X-Proofpoint-ORIG-GUID: nuauhxqYHz8l8BV5gKxWDeqFPc_LAdxx
X-Proofpoint-GUID: nuauhxqYHz8l8BV5gKxWDeqFPc_LAdxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

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
index 969c34f738a9..7c1e268c8749 100644
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


