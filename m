Return-Path: <linux-pci+bounces-28530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F47AC76BD
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 05:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D091BC07B8
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 03:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A115F2500DF;
	Thu, 29 May 2025 03:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eGIsrYTB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144F524887F;
	Thu, 29 May 2025 03:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490875; cv=none; b=jv2SGQPkzfHd7fCNj9uLeHCo7kTOzn7wqioRDEZiPFbk+hsIotuDeDfnQMkOWuduQLiA+ZXAq6i0ADAIbWZe7VtSqMqlv/w9To1I5fddXbW3iK2yp6xJycDoX2fRiG+Q+53zuTb3yT7QoVR0G5BQ3M0Ot+KAsmQFqZb3LAdeZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490875; c=relaxed/simple;
	bh=ysKp37rtgbhAo1Sv+aZdUPn6SNlL7sj6FGQ8xd5chLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tBJTtVNj0F9YLxKR4MraDDQsWSH6NWYQQGTWlBB06LM5WyMECvh8I792na5PivASUNy7oX/uwYoi33zD2xGIRPlwFlWNpc5K63fhXK6ldds13+VHdqYH5KVZkdHS3KaUcC++JxKHthtGQR7qSNIt9btkQ5t8KLJ76UxDqH4hudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eGIsrYTB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T2Caaj029201;
	Thu, 29 May 2025 03:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=r3HR1NIB0g+
	iyfJRx14G/Yce278aBOpNghyFxwuxQFM=; b=eGIsrYTBZasvFU1JH1Ix5zhZmA1
	DCBYSY6WiM8hvN3DljF/dVuHmlB8YNCnLGxwYpCJCp4bbufoOllLz/lJPn0i2K/X
	9mRDYOBNkP2PirGp+mxKihtANfpIfuX9kZwNqnqZBQu580kN6jvpnbdHlQnHCG5v
	bl7Rj0+3V0X2QOIfFwNh3WXuF5NGg/aTh7P/m2sAoDuaAnQ/cxjN92r0fn7h9mQE
	ZyD8Ea/f1gtXp8OGwuK4QW3K0bNXzKaXvqo400TOl+KjvXHgAaUVIYaqqQ7+Wb5h
	y6FDIoLzrPWmnrTpQ8Nxf/gQLHlewHJF63BLpPdfh8lghGTJPfvmJQI3zbg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w992pf4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:54:22 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 54T3sKfH011607;
	Thu, 29 May 2025 03:54:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46u76mdp20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:54:20 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54T3sKMC011593;
	Thu, 29 May 2025 03:54:20 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 54T3sJ1D011588
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:54:20 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 620DD3158; Thu, 29 May 2025 11:54:18 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
        krzk+dt@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v1 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings for sa8775p
Date: Thu, 29 May 2025 11:54:13 +0800
Message-Id: <20250529035416.4159963-2-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529035416.4159963-1-quic_ziyuzhan@quicinc.com>
References: <20250529035416.4159963-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDAzNCBTYWx0ZWRfX20Sdaahm8LJv
 9ybCbnjMDYmIeS8xEBPZZLTmFGl+Hpkewyy6HsQkbr32kWbQycfHEoxG7vKZNDRsqGzOIeYpCCq
 Lq4hakFWGbWlWd3Y9+lRk3VKfcYFvvEnFvGLKnr+l5kHJDcWkvxNFamQNYgVLLC2M7vbHB4LrlR
 QFxd2qFdL6Ajot/imvzDICDVJk1KsXcW/uA99tZ3U43lvVJgM9ZrwcH9QNLcgY1S1/e9vCwK9ZK
 tduJQpGU4ae30kNzakZQolNg7O6FSEBmDL7wD3PFc3fd+1m64UFl0WC6ff7Bjq/NTom0hOx4n0g
 34YVAJX5Z9B2eq8EU9Fkb+WtvkJcM6mOzi78WgdsWxWlxBPqqnC4vJVjrpK4S7HJ3l5f1xGZc5N
 v8rs51J0qnnD4iRCZLMaL3TQvVkqk3D3/poU/a9DZ93I/ao4NiVaFttat4WueQbqv8ZJFigx
X-Authority-Analysis: v=2.4 cv=Fes3xI+6 c=1 sm=1 tr=0 ts=6837da6f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=tAWiX01tdBucjzfsbJgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: FQ7ZcrREHm9Sm0FVF45HfYwbEMAoKYmp
X-Proofpoint-ORIG-GUID: FQ7ZcrREHm9Sm0FVF45HfYwbEMAoKYmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_01,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=967 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290034

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


