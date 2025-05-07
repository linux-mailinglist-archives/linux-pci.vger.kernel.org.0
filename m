Return-Path: <linux-pci+bounces-27306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A738AAD3B7
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 05:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E443F4658A5
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 03:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C8E1A8F68;
	Wed,  7 May 2025 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EPUjd3lx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD0EAD0;
	Wed,  7 May 2025 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587439; cv=none; b=IaqaZzgEoSoQ++uGUaRn8aPV5dj4+nwytkya2SQ4k3Hkwki/FD+OBdK7p0U9VGmBO29UKdP6mPR2U7lgLl7g9bAcMv/7F0EGYy2DfDcxj0RfZJAWdtlw96sRl9ivwe/rYxDnN33ynkyQrsz6J9zP0GxIDKf4dERKpqSzfUVpjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587439; c=relaxed/simple;
	bh=mfLb12vO/eWh4WaqLTB2s7VVkSlR3AZOyfNOC0OayVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyrU4xpmFlpINjNqhRCUUSJ4ByP88TjDfFMLHc2KT2+Rw5C+R/y1uJLLRRhJDkVVfQHUmBmcJoFNcnupA8K5LVj/VBLxYbliZmYOu9wOyhKfZZ4CEmpXKuyTN29kgK3Zbzga5EIcw8uUJ91YxVGnRf/XeftdS/eX7Mc+L+e9vyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EPUjd3lx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471GsOB019006;
	Wed, 7 May 2025 03:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1HbdsOJNgI6
	7H10Eq7jnbZdoIIeJf+3X1GGfehTd3Kc=; b=EPUjd3lxs0uDemNz82kLFq1Zf/1
	9d9CFc/EUpV+jBayJzEJLL0QhiFBijHl8PxDh3curDbxYqAr6vIi/mEfaoj4flKp
	haZaYXlwlfrXcqMtRuE/X/pt5JU/QN27GlTeO+3FyNgxBBLhzxlHU3ghu85fjFeX
	IWVqg8y8UE5frP7OXHNyIwBLENsqiEEI9qtRks6zQdYqx3O10kgC3Vrf38OLGaiJ
	QURXYrgCB49ecPYjQVV0LHksjpxFv9soexlBrBgY4vSBOfNc8DVhSnVJBLNOne8J
	88q3GytqhrWybdlsqb5cj4I05IxLbrH/kueknfxl0h964W2LOUj/j0px0iw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5wg45tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:10:27 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5473AObu006141;
	Wed, 7 May 2025 03:10:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46dc7m5ysr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:10:24 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5473AO2r006135;
	Wed, 7 May 2025 03:10:24 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5473AOBR006125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:10:24 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 267EE2F3F; Wed,  7 May 2025 11:10:23 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org,
        manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v5 2/6] dt-bindings: PCI: qcom,pcie-sa8775p: document qcs8300
Date: Wed,  7 May 2025 11:10:15 +0800
Message-Id: <20250507031019.4080541-3-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507031019.4080541-1-quic_ziyuzhan@quicinc.com>
References: <20250507031019.4080541-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: naYzJ3r7232AqcpGp74D6qRF_KxnJ4El
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDAyNyBTYWx0ZWRfX6UoJwPf6sWWn
 URY/PXYrqLJvbvtkqMmpfb7kWioNoieH/nIQEqNW3fgKsTtEELqqUudIr9/4cXzr+x2DgRtCgGl
 e0k4cSO2ZTrOldSybM2p4lM7eAuLrM2cy97Q0t7VEaN9iuxFFcZVC/Q6iU4FVSPrrpVU7KbtNJP
 g3vHjCZsr7BglL4l2pLjnuKJe3b+pUDz5+sh4WePKDaP+K2lxpixb6skSPxUF5f7hf4LCjzN6ly
 /+LnmBO8vTigJrQLcotL/wpOf7X5U6gKyfSBTpfOGGBEItw6MdHZLLVPwf5f60uj2xod/SbVZ8O
 rac3bOCpqk1DjeMtN2m17RtLhEbRBSjK51BDYNJ6BPlUqaBXNJ1t3ftc6u14bnGk18NJyXc7eGk
 Rnxd3hj2QE1rIUOGUlbG07HNWUF4yUMbMROPrcPxYQMEbLQ6UOGrYw7RB8Rjz6SNWjsjuxuG
X-Authority-Analysis: v=2.4 cv=dPemmPZb c=1 sm=1 tr=0 ts=681acf23 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=5s6rildDmCdGve1q1wIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: naYzJ3r7232AqcpGp74D6qRF_KxnJ4El
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070027

Add compatible for qcs8300 platform, with sa8775p as the fallback.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 .../bindings/pci/qcom,pcie-sa8775p.yaml       | 26 ++++++++++++++-----
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
index efde49d1bef8..154bb60be402 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
@@ -16,7 +16,12 @@ description:
 
 properties:
   compatible:
-    const: qcom,pcie-sa8775p
+    oneOf:
+      - const: qcom,pcie-sa8775p
+      - items:
+          - enum:
+              - qcom,pcie-qcs8300
+          - const: qcom,pcie-sa8775p
 
   reg:
     minItems: 6
@@ -45,7 +50,7 @@ properties:
 
   interrupts:
     minItems: 8
-    maxItems: 8
+    maxItems: 9
 
   interrupt-names:
     items:
@@ -57,13 +62,16 @@ properties:
       - const: msi5
       - const: msi6
       - const: msi7
+      - const: global
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   reset-names:
     items:
       - const: pci
+      - const: link_down
 
 required:
   - interconnects
@@ -129,7 +137,8 @@ examples:
                          <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>;
             interrupt-names = "msi0",
                               "msi1",
                               "msi2",
@@ -137,7 +146,8 @@ examples:
                               "msi4",
                               "msi5",
                               "msi6",
-                              "msi7";
+                              "msi7",
+                              "global";
             #interrupt-cells = <1>;
             interrupt-map-mask = <0 0 0 0x7>;
             interrupt-map = <0 0 0 1 &intc GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
@@ -157,8 +167,10 @@ examples:
 
             power-domains = <&gcc PCIE_0_GDSC>;
 
-            resets = <&gcc GCC_PCIE_0_BCR>;
-            reset-names = "pci";
+            resets = <&gcc GCC_PCIE_1_BCR>,
+                     <&gcc GCC_PCIE_1_LINK_DOWN_BCR>;
+            reset-names = "pci",
+                          "link_down";
 
             perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
             wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
-- 
2.34.1


