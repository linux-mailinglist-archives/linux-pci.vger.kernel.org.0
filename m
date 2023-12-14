Return-Path: <linux-pci+bounces-940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8EF812811
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 07:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97E11F21AF8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 06:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2230D274;
	Thu, 14 Dec 2023 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WMvSVRkh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E67133;
	Wed, 13 Dec 2023 22:29:55 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE2hRdd016504;
	Thu, 14 Dec 2023 06:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=A6PPmlLB6gn91AEx4ASsMIEO3od95Y+EsLFhvi3krTo=; b=WM
	vSVRkhY+9Nqp49J1t0bk8Ccbe8Oer98IB+UHjpjlL1D2HrCpFu/ciRDJglUahox/
	3yrWSb72K/f8ss15f/XeucynIKC4V1ehhPTLGX31uDGQCTbRkzv2eJ8fsIC+LC90
	aCxTYefN1zZytTJYSrlnNeKDMC/3djtxRUo02xohPDR2hEjDProCVIEcXaq7tzDc
	04epe0D0nPjYG6L9yhal/dlpT11yGnvU/o12AOOp/8dXdhDqf3liW/SvO+yFmTDt
	FXcU7ROJ1jeqn9k1CWORi0Bl7h16H6/sfaL+Jws9e2Urk7riedDcHvule8x2LGK9
	NSDcHcfOTqcDhcI1a9/g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyq2trkm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 06:29:46 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE6Tjr2016549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 06:29:45 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 22:29:38 -0800
From: Praveenkumar I <quic_ipkumar@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <quic_nsekar@quicinc.com>, <quic_srichara@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-phy@lists.infradead.org>
CC: <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH 05/10] dt-bindings: phy: qcom,uniphy-pcie: Add ipq5332 bindings
Date: Thu, 14 Dec 2023 11:58:42 +0530
Message-ID: <20231214062847.2215542-6-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FQgD7QvKKfjwdfvvusR2OiHsobtaDXDq
X-Proofpoint-ORIG-GUID: FQgD7QvKKfjwdfvvusR2OiHsobtaDXDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140039

Qualcomm IPQ5332 has single-lane and dual-lane PCIe UNIPHY
with Gen 3 support. This UNIPHY is similar to the one found
on Qualcomm IPQ5018. Hence add the bindings in qcom,uniphy-pcie.

Clocks and resets are different for IPQ5332. Update the
bindings to support both IPQ5018 and IPQ5332.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
This patch depends on the below series which adds PCIe support in
Qualcomm IPQ5018
https://lore.kernel.org/all/20231003120846.28626-1-quic_nsekar@quicinc.com/

 .../bindings/phy/qcom,uniphy-pcie-28lp.yaml   | 65 +++++++++++++++++--
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml
index 6b2574f9532e..205eaec2291e 100644
--- a/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml
@@ -20,19 +20,20 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
 
   clock-names:
-    items:
-      - const: pipe_clk
+    minItems: 1
+    maxItems: 4
 
   resets:
-    maxItems: 2
+    minItems: 2
+    maxItems: 3
 
   reset-names:
-    items:
-      - const: phy
-      - const: phy_phy
+    minItems: 2
+    maxItems: 3
 
   "#phy-cells":
     const: 0
@@ -54,6 +55,56 @@ required:
   - "#clock-cells"
   - clock-output-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq5018-uniphy-pcie-gen2x1
+              - qcom,ipq5018-uniphy-pcie-gen2x2
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+        clock-names:
+          items:
+            - const: pipe_clk
+        resets:
+          minItems: 2
+          maxItems: 2
+        reset-name:
+          items:
+            - const: phy
+            - const: phy_phy
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq5332-uniphy-pcie-gen3x1
+              - qcom,ipq5332-uniphy-pcie-gen3x2
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: pipe
+            - const: lane_m
+            - const: lane_s
+            - const: phy_ahb
+        resets:
+          minItems: 2
+          maxItems: 2
+        reset-name:
+          items:
+            - const: phy
+            - const: phy_ahb
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


