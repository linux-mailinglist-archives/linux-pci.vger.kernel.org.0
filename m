Return-Path: <linux-pci+bounces-14277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F23F99A1CF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EC01F2522B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 10:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F6213EE7;
	Fri, 11 Oct 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jhOTnqrB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D9198A3F;
	Fri, 11 Oct 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643453; cv=none; b=XSBJ2wpHpAWWZK4c6zBL95lOYF9HgnJwdv3qEkNH2WXKzqY/4SeedvP6ZagwZ8HWwyTNxJFayL2a7lYh3ALNiqEpQAk17GnJDnzul59j8PKQDqIE20+n4ZiAnwBR4HU0zwnq6O8xbie7d8Pzf23DR7ZHWRCUX96yPx4fX5zRRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643453; c=relaxed/simple;
	bh=sOKcqGX4UZHwenPSjHPtTDzhT/8VpI0ge79oPvoda0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDW3fh9QhmVXF8FpVNH4zmTJ6Qp1yPH+INwn5DNaGIV+kN30GtcXNRruIGbECeKIkCG1jesKYe+fEXoizWp+HcdFxntcCxIPk9nVpfNTI6APZm1fa+M1AfxTak2oZI3timM4dM0SNjK62NkHlYbitKZLxTzeHTy+1TFCjRWqh5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jhOTnqrB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B6O1Oc030035;
	Fri, 11 Oct 2024 10:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=R8apB/HC6zb
	dmOM/osprUzGSdJFwFC3SdC4+94ASLH8=; b=jhOTnqrBWqa2ycu9AGXKTac0hJJ
	9NbCuovLg8kPMxilAbyFAT+HQ/iuEcSGZ4zk4jwcuRbOZdbmYucEciJ19cVr+1lt
	bcN0i9ltrQB9QCtKUN74Ruc4OqcpXQl258UZRI+Z4NNya9uk5Jo29TIfQozM8Zap
	yalJ5BOishcpl5lH3/u+xglVwhemNFknn+bTTwmADRuEUcEkamuhUp1sa+YmU5bc
	eAhGiFu5bj74c7Djbn4iY2kkPdqjVrTplKk6qCVDyeCSckhWfv1VfJByrbnIEru2
	p1K7QteF4zRcB35td5NDTWoS3ryTwK+Z8IeL+Hfmt5fl0EgxvpXoci9ywCw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426g6navd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:41:45 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 49BAV68a019033;
	Fri, 11 Oct 2024 10:41:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 426wjy2dpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:41:45 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49BAeKwr031365;
	Fri, 11 Oct 2024 10:41:44 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 49BAfiDa000929
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:41:44 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id 80FCD651; Fri, 11 Oct 2024 03:41:44 -0700 (PDT)
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
Subject: [PATCH v6 1/8] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100 QMP PCIe PHY Gen4 x8
Date: Fri, 11 Oct 2024 03:41:35 -0700
Message-Id: <20241011104142.1181773-2-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
References: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: eg7xCzd5psDHknnbshH5TfLoxABY44d0
X-Proofpoint-GUID: eg7xCzd5psDHknnbshH5TfLoxABY44d0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410110073

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


