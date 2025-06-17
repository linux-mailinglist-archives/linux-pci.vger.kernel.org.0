Return-Path: <linux-pci+bounces-29909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DFEADBF07
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 04:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCD51893CA0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 02:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA9C2367C4;
	Tue, 17 Jun 2025 02:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SoTWRc5s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77284211A05;
	Tue, 17 Jun 2025 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750126609; cv=none; b=OqolJsrsRNrGueQXaycKzyobJhuqS17SJY1QI9dy1orp8lIwf78shlGJ3z1ahRVytcmt9s/3EWEk326UvOTsPH4YNWiVAwP3Ja6dQtfdc9EHRRYxE3SuAzQWhPmn9RhyiU9NrUvnjlyy9omFM4giCUg90ekuFGGd2unO881HXR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750126609; c=relaxed/simple;
	bh=ysKp37rtgbhAo1Sv+aZdUPn6SNlL7sj6FGQ8xd5chLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lW/ba4zbFbVz9RJ8W8JBG7S66bUcEeW4+2dfijf0JXZajomC8gETXc6GbCCKx1JPp5yDRDDc4GZv060a5PLBbEmwajeIhmWMqhQE0HuV8Mxe3wkHbBYvOG5MEYcBp7HAd8wcW0qmadrWgBJ73UT7LEQ/GISIX1Jnd2MKHaSm8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SoTWRc5s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GG1lLu019929;
	Tue, 17 Jun 2025 02:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=r3HR1NIB0g+
	iyfJRx14G/Yce278aBOpNghyFxwuxQFM=; b=SoTWRc5szolwf01yOwrCiJln9fl
	bX800o3Lm7z9PCPGQJ9+l2It4sJOKvr4nhLNKGi9ChNhPFrxuycqK4qEcMQsviMC
	+dPpKXRbKsQFKd0vU7lNF902ZuF0pXS1JLkUgCsyTxKrHODR8NWkxi9+qrwm7E4v
	lfc+b+g2YiR5ylNr+LBHUNN8ovGhIaEk5ZI/icq2/bbiB6DmeqFp1rXbbx+5MDC9
	g0HKcpQeS4HfTQncJYSqYcjHOmqag4O7gUHtQDcHkqxbBNacUr7dT0eOk04RvL9Z
	3ZjnHvxDAEaMVECQDPUStBNPcv/2LiPGdr7KQGOmVNnMF3SvgRcV+7MmrtQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hfehtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 02:16:31 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55H2GT9Y014425;
	Tue, 17 Jun 2025 02:16:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 479jt4gb0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 02:16:29 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55H2GSh0014405;
	Tue, 17 Jun 2025 02:16:28 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 55H2GSTO014399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 02:16:28 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id D2447365B; Tue, 17 Jun 2025 10:16:26 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
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
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v2 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings for sa8775p
Date: Tue, 17 Jun 2025 10:16:14 +0800
Message-Id: <20250617021617.2793902-2-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617021617.2793902-1-quic_ziyuzhan@quicinc.com>
References: <20250617021617.2793902-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDAxOSBTYWx0ZWRfX61TZDmurcp5t
 IiW0i4CUTXaTYIc/NzOfWCwlbqNSK09/1M34TLhhDPN5tBO0QVdAn4u7wqhfiFjXe2wEdALHo36
 CiLahZYLxZX2s2XeU2XwtL5qZYKD/hlUGVdUXXfG2o/wcf9bdvBY7gA4yrSqUcLvKhNsIoI1Gfk
 gtHqBBDKjY3lS/MqhgU4tr01q4iHH7qYZQvVmnjlb6Y44IVCRBek45cPa7I4ZEzRuGaE7itDysL
 Tu6WWe/jPJOJus2vMruagccHfy+pI+LzAc7NBNCyza4qrsKSTNDwVA6yY641UAvsd5esSnUqBMp
 zPYUdPnk5cWfsOC0irH/tXXBzU5iIalTd+Fa862etgAvyCZl58KSCEyq46cQ2HN6bhTZsZ+Vkmi
 +fSs2h/HIhC/WgDbEdbdpF75wcA4FmQlz1DSMNa6YR3oeQFh+vvp0L6M/0G/w/5+jhQTobB6
X-Authority-Analysis: v=2.4 cv=VvEjA/2n c=1 sm=1 tr=0 ts=6850cfff cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=tAWiX01tdBucjzfsbJgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 7D1D8A7aQpqbdbAf5N_J78Ny-4LY45zy
X-Proofpoint-ORIG-GUID: 7D1D8A7aQpqbdbAf5N_J78Ny-4LY45zy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170019

The gcc_aux_clk is required by the PCIe controller but not by the PCIe
PHY. In PCIe PHY, the source of aux_clk used in low-power mode should
be gcc_phy_aux_clk. Hence, remove gcc_aux_clk and replace it with
gcc_phy_aux_clk.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 2c6c9296e4c0..17fd6547d3b4 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -176,6 +176,8 @@ allOf:
           contains:
             enum:
               - qcom,qcs615-qmp-gen3x1-pcie-phy
+              - qcom,sa8775p-qmp-gen4x2-pcie-phy
+              - qcom,sa8775p-qmp-gen4x4-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
               - qcom,sc8280xp-qmp-gen3x2-pcie-phy
               - qcom,sc8280xp-qmp-gen3x4-pcie-phy
@@ -197,8 +199,6 @@ allOf:
           contains:
             enum:
               - qcom,qcs8300-qmp-gen4x2-pcie-phy
-              - qcom,sa8775p-qmp-gen4x2-pcie-phy
-              - qcom,sa8775p-qmp-gen4x4-pcie-phy
     then:
       properties:
         clocks:
-- 
2.34.1


