Return-Path: <linux-pci+bounces-12248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA669601D7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 08:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84CB1B20F89
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 06:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5961448E0;
	Tue, 27 Aug 2024 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KgYsVR+U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47913A1C4;
	Tue, 27 Aug 2024 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740621; cv=none; b=qAz7BZaKNRHjfv2PNbrPN3vC5/QjOJzzLB7wwcKPYDXs38Y+lJiaebZ7mq+K7LFoQKXAqkSw+/qtQFbhG2jHMR3g1Le26kLlduQBvHdnzoQphhunpgbg9vxQBpxwhUHVynqAVCSymESGpAGrLSeWaVJT/2K6MM3wZ4SOyPoArvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740621; c=relaxed/simple;
	bh=KrXRpt5137K1bheaQ/8z82wI9Fy6xGhONzf+N+Vw3F4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EYGYTaywYL+zounqcVnJ/41UaTWZ921skk08YCabmIng+Wtlo2vklmxs9TWUvQUrbOUAku0JC46RWL9hcRUnByYeZ/C1xCq9B5+M5ZnHla94AjHzIjHcjH+X49pIsfUTTiwwmSLCXfc998glI7PUjn3FNhHu1drO8SwQ0+2ta40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KgYsVR+U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QJGfat007436;
	Tue, 27 Aug 2024 06:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zbkPwV9dVUu
	hngPOgG5UYOl1QL7fgQAKlOAw5lMh/XU=; b=KgYsVR+UqbY3rSqIx6bjAjObRDc
	sfeVUyiyt5F516m6QVaaOsa8N36iLk+tCBUksEjov81DrJI5srJMKiLN2hHUTmH0
	f9rF44TC3UPcdV/npQOoBbFIm+8QWIYIMJ7wIinzMviB/H6435T9+UHGG/xtq8it
	Zce9El4WM9snUA6w8Sr1vNoQ15L4x/gZxaT1Iae9DemtLC3HLBBKInkmhmBGiPMV
	O45SiMNaGTdYRdLNRbDrR+yYzPW5qIDQGFkQ23NWQHiwtH/5ql2JI4/dT7R5SBuf
	fYt+ot4otvoWlYsLcDIsAGf5iMzC/MHvq8hb+0bgaIQDFUIHWnUbyDrhx7w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417976wxdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:49 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47R60LdW027894;
	Tue, 27 Aug 2024 06:36:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 418uqwxr4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:48 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47R6ZIUV003937;
	Tue, 27 Aug 2024 06:36:48 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 47R6alXr006290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:48 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id D7D2F64E; Mon, 26 Aug 2024 23:36:47 -0700 (PDT)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
        quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
        neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH 2/8] phy: qcom-qmp: pcs: Add v6.30 register offsets
Date: Mon, 26 Aug 2024 23:36:25 -0700
Message-Id: <20240827063631.3932971-3-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: emBf63CM5WmMYWpxM0N_op1orrOzgVPL
X-Proofpoint-GUID: emBf63CM5WmMYWpxM0N_op1orrOzgVPL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=889 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408270048

x1e80100 SoC uses QMP phy with version v6.30 for PCIe Gen4 x8. Add the new
PCS offsets in a dedicated header file.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
new file mode 100644
index 000000000000..9aa6d3622c24
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V6_30_H_
+#define QCOM_PHY_QMP_PCS_V6_30_H_
+
+/* Only for QMP V6_30 PHY - PCIe PCS registers */
+#define	QPHY_V6_30_PCS_LOCK_DETECT_CONFIG2		0x0cc
+#define	QPHY_V6_30_PCS_G3S2_PRE_GAIN			0x17c
+#define	QPHY_V6_30_PCS_RX_SIGDET_LVL			0x194
+#define	QPHY_V6_30_PCS_ALIGN_DETECT_CONFIG7		0x1dc
+#define	QPHY_V6_30_PCS_TX_RX_CONFIG			0x1e0
+#define	QPHY_V6_30_PCS_TX_RX_CONFIG2			0x1e4
+#define	QPHY_V6_30_PCS_EQ_CONFIG4			0x1fc
+#define	QPHY_V6_30_PCS_EQ_CONFIG5			0x200
+
+#endif
-- 
2.34.1


