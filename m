Return-Path: <linux-pci+bounces-20433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2467A20463
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 07:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5F57A4512
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 06:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A574D1DDA09;
	Tue, 28 Jan 2025 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OksHRIkQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2505C1DD0EF;
	Tue, 28 Jan 2025 06:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738045692; cv=none; b=V5p7jWSEuKNXZa1zuo1SOJ6Xf7qsmB5J6010Peba6ndF3sv4SIKXO9r7Ej4iXN6mHxAbqXFk4sS8C+ivNynjPlezS8KlEIY7pRKVLg0XwRGKnHzzz7kMF7WKr6RjMRYLoE2SKrtmUdbJkL0W8BfDeDN0pGtjsEssTymosRN/CEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738045692; c=relaxed/simple;
	bh=fkbrOpaW76BA9/XX4YbjOKpgb/ZrhwyXbvW8VEky9Js=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXMrw3p5J387ME1/puBHnbSg5YGywlZ1zm87/RomwWa4VEml9YjOftZg54SYmC/g/Xzd36HJ7ujuvRtrxCu6xGQMf2tlsXa1fDa/eRY4RfIyBLS4dUvADpj1HtwBFEOTuHWWH2o/VBTTWKULmKR2WBXlWD1H1dCbwK7Pv2eYcmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OksHRIkQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S1sg2b032251;
	Tue, 28 Jan 2025 06:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YgA7MqkWfEWtf9D7EueHOeV13JMP0Da35X+DQUFpZF0=; b=OksHRIkQAeWT5FL8
	Cm6u4Un+eiI9MqTyyDYhMdRsUYk7QPfXCw0i0cwjnkF9Ydqj25FBSpKsaqtksHqO
	18GhUxdk3Uk3u0yh+Vp4jhO2mObO1Win/iOPpk9sH7bsOuYtbOBC+cjMuaQ2KPlD
	3dzTvh0DzB16iBUpdmJb7B1A1W216kX1J6DcJKjTvhu/702WqGxMDT/8VvpDiDV0
	AdAKSKTm6ufPAw83WcIFGmLyIeBnNSiQP3X35+rS5cHL1da37CMDoOLE5MyzckRT
	dykgEskuocgZ9HZwicjFn4EXHx97xsSC19KQ+Rh1fvkazo9UX2Dnyr/oRnu4o74V
	+8dFRw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44enyq0dtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 06:27:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50S6Rte9021525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 06:27:56 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 22:27:50 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v9 5/7] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe controller
Date: Tue, 28 Jan 2025 11:57:06 +0530
Message-ID: <20250128062708.573662-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128062708.573662-1-quic_varada@quicinc.com>
References: <20250128062708.573662-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4Qd7S7TzPghTjtCTULhfLgJBQGoVTQI7
X-Proofpoint-GUID: 4Qd7S7TzPghTjtCTULhfLgJBQGoVTQI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_02,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=932 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280048

Document the PCIe controller on IPQ5332 platform. IPQ5332 will
use IPQ9574 as the fall back compatible.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v9: Remove superfluous ipq5332 constraint since the fallback is present

v8: Use ipq9574 as fallback compatible for ipq5332 along with ipq5424

v7: Moved ipq9574 related changes to a separate patch
    Add 'global' interrupt

v6: Commit message update only. Add info regarding the moving of
    ipq9574 from 5 "reg" definition to 5 or 6 reg definition.

v5: Re-arrange 5332 and 9574 compatibles to handle fallback usage in dts

v4: * v3 reused ipq9574 bindings for ipq5332. Instead add one for ipq5332
    * DTS uses ipq9574 compatible as fallback. Hence move ipq9574 to be able
      to use the 'reg' section for both ipq5332 and ipq9574. Else, dtbs_check
      and dt_binding_check flag errors.
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 4b4927178abc..f7ea865f56bc 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -33,6 +33,7 @@ properties:
           - qcom,pcie-sdx55
       - items:
           - enum:
+              - qcom,pcie-ipq5332
               - qcom,pcie-ipq5424
           - const: qcom,pcie-ipq9574
       - items:
@@ -49,11 +50,11 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 8
+    maxItems: 9
 
   interrupt-names:
     minItems: 1
-    maxItems: 8
+    maxItems: 9
 
   iommu-map:
     minItems: 1
@@ -443,6 +444,7 @@ allOf:
         interrupts:
           minItems: 8
         interrupt-names:
+          minItems: 8
           items:
             - const: msi0
             - const: msi1
@@ -452,6 +454,7 @@ allOf:
             - const: msi5
             - const: msi6
             - const: msi7
+            - const: global
 
   - if:
       properties:
@@ -559,6 +562,7 @@ allOf:
               enum:
                 - qcom,pcie-apq8064
                 - qcom,pcie-ipq4019
+                - qcom,pcie-ipq5332
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
-- 
2.34.1


