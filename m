Return-Path: <linux-pci+bounces-12249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C700F9601D9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 08:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7311C2105B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98635148FE5;
	Tue, 27 Aug 2024 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WaW4DDuZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47DC81ADA;
	Tue, 27 Aug 2024 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740622; cv=none; b=KUDNo5A4PtX4JGDddD0dounZwJo+VjOzG9CzbQRid8yBos8Ikl08eIV5ZM2xCK4IKA7ZiY6Vs+/lhNXPFvFbhYi/+PLKxoa8ET77qyXVyj/75tnV+wsJFFCsO/XHFs716Jr7aG2d7ZVMFZu08CXDqmokD6WF/Ge3DgLqeJYFO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740622; c=relaxed/simple;
	bh=gGitQ26dsv5058ywunVrVkcVwJ8TbRKJQxW0M1nJmE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LKHde8HY5f+4HVfOq5fBxcb3SD3c2MzPOabfugQbTDS8QqQUq+BNfSD5ZZLwCkdPDmdmy44nFh0MaGtsImKC7i0/F+8Zd2eDUfkCEgk07jASbVqMFilMe7pNht5EfdHAXr7AiA0tgTRjEATnvEimrB62hlwiRM7WZncj+wTvyks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WaW4DDuZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QJGvLo028312;
	Tue, 27 Aug 2024 06:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HmzSLR5b2qe
	crg/Ef7E81TTG1LQ6i+5dR7iHmUS/YFc=; b=WaW4DDuZn96vQixRJt0rg/dETPM
	IeieATEsLeJnKPJcnQsPwr4sPOzZ/Vx5RMEx/qFnQ1WDndK5FsL8MQWK2w/3zFDF
	j9HSeGYbykmyUxo1lE3nfmD2dztsssIhQV7/3V89/+Say73Bewx5Y7J0CF0nxF+r
	8FnFI8IOSu1eY+pCODYX68T8gA46Ebc7tbTIETgq5UVAYKpYX2c2WSwiMwFwTc6j
	6C0HyqqxfwbSpIOK/kNFwQSGTSc+6/MSoh9Kqs2YxHrcSRK3ghdFdFxW/97D+jkH
	KoSYwnkrFDOfXMcTaz9Ro9NKCzCq7n1CCOL3hrqopm6HEyX+KNakah3Qpag==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417973nyt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:49 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47R6aPUo025453;
	Tue, 27 Aug 2024 06:36:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4178km76qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:47 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47R6XGl8020992;
	Tue, 27 Aug 2024 06:36:47 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 47R6akIu025705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:47 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id D39BD64E; Mon, 26 Aug 2024 23:36:46 -0700 (PDT)
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
Subject: [PATCH 1/8] phy: qcom-qmp: pcs-pcie: Add v6.30 register offsets
Date: Mon, 26 Aug 2024 23:36:24 -0700
Message-Id: <20240827063631.3932971-2-quic_qianyu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: aYt8Nz3IflEJrnJrCN-DcXepvS-LP3CD
X-Proofpoint-GUID: aYt8Nz3IflEJrnJrCN-DcXepvS-LP3CD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270048

x1e80100 SoC uses QMP phy with version v6.30 for PCIe Gen4 x8. Add the new
PCS PCIE specific offsets in a dedicated header file.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
new file mode 100644
index 000000000000..5a58ff197e6e
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_PCIE_V6_30_H_
+#define QCOM_PHY_QMP_PCS_PCIE_V6_30_H_
+
+/* Only for QMP V6_30 PHY - PCIE have different offsets than V6 */
+#define QPHY_PCIE_V6_30_PCS_POWER_STATE_CONFIG2		0x014
+#define QPHY_PCIE_V6_30_PCS_TX_RX_CONFIG		0x020
+#define QPHY_PCIE_V6_30_PCS_ENDPOINT_REFCLK_DRIVE	0x024
+#define QPHY_PCIE_V6_30_PCS_OSC_DTCT_ACTIONS		0x098
+#define QPHY_PCIE_V6_30_PCS_EQ_CONFIG1			0x0a8
+#define QPHY_PCIE_V6_30_PCS_G3_RXEQEVAL_TIME		0x0f8
+#define QPHY_PCIE_V6_30_PCS_G4_RXEQEVAL_TIME		0x0fc
+#define QPHY_PCIE_V6_30_PCS_G4_EQ_CONFIG5		0x110
+#define QPHY_PCIE_V6_30_PCS_G4_PRE_GAIN			0x164
+#define QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG1	0x184
+#define QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG3	0x18c
+#define QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG5	0x194
+#define QPHY_PCIE_V6_30_PCS_G3_FOM_EQ_CONFIG5		0x1b4
+#define QPHY_PCIE_V6_30_PCS_G4_FOM_EQ_CONFIG5		0x1c8
+
+#endif
-- 
2.34.1


