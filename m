Return-Path: <linux-pci+bounces-20394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A98BA1D171
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 08:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC55166406
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5997C1FDA7A;
	Mon, 27 Jan 2025 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ok73dxYU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81831FCCEF;
	Mon, 27 Jan 2025 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737962988; cv=none; b=FI4uu1hVbPo5rrQPYopEl8G5UJX9I2GtEViziul/6+1Ae5csSTXBcNvKAf+9i7xqmeOjwMNX7V3swF70ePaMOqE8qFFwnyrS3vyDKgo/d4tHwhe3ZeiFak+y2Q9lXVU5ijFyJTBdQtLGkuMH3TVyctKB1VvVYTTMSYb3oSkYCkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737962988; c=relaxed/simple;
	bh=JZzbTkB0m27Fih0w47JQRCzJ4vpLKLdqsOfDTxmpsfc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4meC4eTou/0a0A5yTcmz/VZwEjQYSsOkjv4UZ0KNAZQSZxkmE9SYglRTafAB7j1NDZ48Tdvk+v0NDdn1kOeg/qSd87lUpXuIE3g0Xi19UDeg5FBAjep++dLa1rRbF0fklKZTDfxFaNS/TSHkUIWfpIvTyb4KiuC3sySDvbQuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ok73dxYU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R3VbHk006215;
	Mon, 27 Jan 2025 07:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aaABYnUtB3lEa6U/KIBYiWR7R8UcrmMmy17b+n6nRFM=; b=ok73dxYUdXaBRb1c
	wBTWQd30FenybpRWByGzZTo4LI63Xdm4JPI2Pr9SqKXTS98hT6vApCqzaKkuK4/6
	mruefSDP+jdIDiLunoLuPVKIEjwb7H7O34GIrnyc/Mvv4G4zInlDA5f/7KFzCncd
	l+wx/8k3M0eZjav8MhrVWgS7jrh/dwvwsIFB8e25g+rDxhmow+qY6tqOHYrdUwy1
	rrFyF2hVZ0Wv88HYPOCkil6zQOoWNIv/D0Lmh/UMfHGaWL4TU04qhbuY6EYfNcfs
	NYN4BSeV6G/DP576U6PNhOB028yFrfuQP1s/ISDoHL5ESqotwx4iJNLa2bWQRZxS
	qdNUjg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44e2988eew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 07:29:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50R7TbR3014020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 07:29:37 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 26 Jan 2025 23:29:31 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <p.zabel@pengutronix.de>,
        <quic_varada@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v8 5/7] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe controller
Date: Mon, 27 Jan 2025 12:58:48 +0530
Message-ID: <20250127072850.3777975-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127072850.3777975-1-quic_varada@quicinc.com>
References: <20250127072850.3777975-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: jTfGoH1pkm2JtB4vORZjV0riUJH6s4hy
X-Proofpoint-ORIG-GUID: jTfGoH1pkm2JtB4vORZjV0riUJH6s4hy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270059

Document the PCIe controller on IPQ5332 platform. IPQ5332 will
use IPQ9574 as the fall back compatible.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
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
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 4b4927178abc..2ffa8480a665 100644
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
@@ -209,6 +210,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-ipq5332
               - qcom,pcie-ipq9574
               - qcom,pcie-sdx55
     then:
@@ -411,6 +413,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-ipq5332
               - qcom,pcie-ipq9574
     then:
       properties:
@@ -443,6 +446,7 @@ allOf:
         interrupts:
           minItems: 8
         interrupt-names:
+          minItems: 8
           items:
             - const: msi0
             - const: msi1
@@ -452,6 +456,7 @@ allOf:
             - const: msi5
             - const: msi6
             - const: msi7
+            - const: global
 
   - if:
       properties:
@@ -559,6 +564,7 @@ allOf:
               enum:
                 - qcom,pcie-apq8064
                 - qcom,pcie-ipq4019
+                - qcom,pcie-ipq5332
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
-- 
2.34.1


