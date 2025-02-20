Return-Path: <linux-pci+bounces-21892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D7EA3D525
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 10:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7094017CFBC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 09:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C243A1F0E29;
	Thu, 20 Feb 2025 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bPBxQcYH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3301F03FF;
	Thu, 20 Feb 2025 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044631; cv=none; b=C+wYLiYql9Qq6Y8jfSQnvKG/kBg8ay3x8uRFo1lDQCgEDTKkE+jZgqlWRkxadoFcoHkUEVSCtbPJ33hWQC3RywNq6NqbAtU4JA7AwyoJw3TgZ8LsptxPNaL0BPNZkta1bAW1/eRTa0SVxqmDMFXXqCxyUek72ALSSBb0VgijHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044631; c=relaxed/simple;
	bh=6zFccnyK28j0nWGmhNrSZEECVxCCZemt/LbLgmabjzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/oiJre7us82OG3rOhDwXh7RuD3vhTzPbuK+M9n6+afntEbkLhJ8HkKMYbY78UTyDPsuCj41epevVoPreZQ6renTfN7RlUyCOj47PfE9qMG98qzcmlsi+3Tsz8hKrWLpG60v6TLOSkVZO9IviD6pwO8ll28Ui+FLxckbjYAhQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bPBxQcYH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7KfwJ016802;
	Thu, 20 Feb 2025 09:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D/3x8oDV74kIZT1yzrY7CxdXusMwAGj+vnnbJOq/tus=; b=bPBxQcYHomMSJid4
	f2rfS+vZt5YN+aRm0LIE6RRE0028fXLOxHplyjqapVE2ZQDSUpiYSuzHyGiq2ZPl
	6iFhKutjw+w6W4leBqjevpll2zH4jl6eJAipowIYDxpKmwSqonDfn09LHo1v+SCn
	BA7SJ7L9PDAKyaSh19Jv5OqsCW5g/0cWIo37BMmAOW7xXd9Ls5P7gvt0PdK6R/e/
	BzoznWo9g/coyDRYerccEBF13CjI74Jo6H1ME/kSrNJ/piWYmO8JiB9m/vdHdrq5
	GGgFi6YmDYatY8Cx2uSqevkyI6c1h3n2TgDQvTVP8ig3VXPKI7rV/6HIavoKT5f9
	7WCubA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy0dkp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:43:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K9hdfE012156
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:43:39 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Feb 2025 01:43:33 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_varada@quicinc.com>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 5/7] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe controller
Date: Thu, 20 Feb 2025 15:12:49 +0530
Message-ID: <20250220094251.230936-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220094251.230936-1-quic_varada@quicinc.com>
References: <20250220094251.230936-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: WvlHqzJ1DHr-aPJLVMWKElmHJu57Zs0N
X-Proofpoint-ORIG-GUID: WvlHqzJ1DHr-aPJLVMWKElmHJu57Zs0N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200071

Document the PCIe controller on IPQ5332 platform. IPQ5332 will use IPQ9574
as the fall back compatible.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v11: Add 'Reviewed-by: Krzysztof Kozlowski'

v10: Remove unnecessary ipq5332 constraint in 'power domains' not required
     constraint
     Fix maxItems for interrupts contstraint of sdm845

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
index 4b4927178abc..6696a36009da 100644
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
@@ -599,6 +602,7 @@ allOf:
         - properties:
             interrupts:
               minItems: 8
+              maxItems: 8
             interrupt-names:
               items:
                 - const: msi0
-- 
2.34.1


