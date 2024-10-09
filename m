Return-Path: <linux-pci+bounces-14047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF829964B5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 11:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD6B288C79
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA6E18E341;
	Wed,  9 Oct 2024 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mekVeJLV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE518E045;
	Wed,  9 Oct 2024 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465362; cv=none; b=DBLmR7Dn3WHhxEkh7jSibVZRVg0F2WZRrwT2V3U/mCqe7oYr94ZBL6k4tcn7H+rYtdf0TJGxMHnUlOP2RwtbhB/L+hoe4fS8tqZ7TPV3lHDI54bLOK1KIlF9/gSUVkyMMw22CJdnJX32WkzmDRcuT2u07J6UdjOYCIW3lH4/ay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465362; c=relaxed/simple;
	bh=sOKcqGX4UZHwenPSjHPtTDzhT/8VpI0ge79oPvoda0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xjdli61b1N4LR3zYEBUjN3GmJcPuffffxqL7syXe6zGVruq+9Y+xfAiwE2R6UwbkC/NlnQCGk9jSVVEYUanFLVclof5ziDEgE0PP80gr8+r7+Tlali0INGqUp3A0iarlawdH4ciF9lMYb6stS9mfn/g4X+smuvATDQb6qBWZcOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mekVeJLV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499936eC027775;
	Wed, 9 Oct 2024 09:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=R8apB/HC6zb
	dmOM/osprUzGSdJFwFC3SdC4+94ASLH8=; b=mekVeJLV6N5wW8Bni8APxpuHBBg
	j0Fnn1a9lHJw+A0gfbAIjQAhZ6Hjo6vq0rHWsayoVCqzLIG9dbL8YL/5yeQwlBrw
	Yo+6Ln52KzxeG0OjH2y9+W51LOwXql5ZVHBQ2AzO/yj9f9pay2XRR3gS7lgHkoh/
	1Mw4KyJG7HW0hz+eorN8AZ62o7kLUc+QdJDZgQY7R23GBomRZuvHIvtWA9XftzKi
	TrC5JJAErL3aePeAHc+VtmCTaBWk8Qv+Cx6F2QWI0vBh/tJCLYAhch1fRBSxBueM
	ETH7sXrJ6tyvOiZ2K5HoE0B9tpYhsdj5SG2JFLjvmZeh4rapVhOvwlUCGxQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42513u3nwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 09:15:45 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4998q4f5007906;
	Wed, 9 Oct 2024 09:15:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 425cbww5fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 09:15:44 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4998w4n5026504;
	Wed, 9 Oct 2024 09:15:44 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 4999FhCa013578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 09:15:43 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id 66B40656; Wed,  9 Oct 2024 02:15:43 -0700 (PDT)
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
        linux-clk@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v5 1/7] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100 QMP PCIe PHY Gen4 x8
Date: Wed,  9 Oct 2024 02:15:34 -0700
Message-Id: <20241009091540.1446-2-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009091540.1446-1-quic_qianyu@quicinc.com>
References: <20241009091540.1446-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: w54SpCWBvZYu24DpvgymEVVD6nQ3wMSM
X-Proofpoint-GUID: w54SpCWBvZYu24DpvgymEVVD6nQ3wMSM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410090060

PCIe 3rd instance of X1E80100 supports Gen 4 x8 which needs different
8 lane capable QMP PCIe PHY with hardware revision v6.30. Document Gen
4 x8 PHY as separate module.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index dcf4fa55fbba..680ec3113c2b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -41,6 +41,7 @@ properties:
       - qcom,x1e80100-qmp-gen3x2-pcie-phy
       - qcom,x1e80100-qmp-gen4x2-pcie-phy
       - qcom,x1e80100-qmp-gen4x4-pcie-phy
+      - qcom,x1e80100-qmp-gen4x8-pcie-phy
 
   reg:
     minItems: 1
@@ -172,6 +173,7 @@ allOf:
               - qcom,sc8280xp-qmp-gen3x2-pcie-phy
               - qcom,sc8280xp-qmp-gen3x4-pcie-phy
               - qcom,x1e80100-qmp-gen4x4-pcie-phy
+              - qcom,x1e80100-qmp-gen4x8-pcie-phy
     then:
       properties:
         clocks:
@@ -201,6 +203,7 @@ allOf:
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy
+              - qcom,x1e80100-qmp-gen4x8-pcie-phy
     then:
       properties:
         resets:
-- 
2.34.1


