Return-Path: <linux-pci+bounces-12236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 541059600A2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 06:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AAB1F22A98
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 04:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8D5146596;
	Tue, 27 Aug 2024 04:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cLeIEIjf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5274413;
	Tue, 27 Aug 2024 04:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734732; cv=none; b=tSeSssY7vc5U2noR49b65KuSaux2zUTprx/0Yi67nawzxlaCVV6kUCiGyLC4uxLG1Wrknq7VKk5/yixWPdgLANeS/Dtrg9cV6f2Kh1dWUsr+DWjPfoJgRH9r55l1cYOYE6sH5YMPKyrHJJpZac9FrQGSmuK0NNS9W+nQGnJ0nRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734732; c=relaxed/simple;
	bh=hwlFDIY3Bz6SOsLs9wWFeuTkr97xQC1hfZYOjwtqWVg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ce86cgplqw40CL7HEn06YHaWaWCEwmWOxeKpB2kDOT/sGVx0dZoxFMPhoxv70uWTVpqxIuzwfcl3imKUCJueHc1thOB5fHgcg9ShDnMiYGJ8+OGMvcVisaluq+y93Eeipevk5Iw0+vwoRwqL8mHqplrwBAsUI3g4/8sV7RE8U1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cLeIEIjf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R1vqkQ003058;
	Tue, 27 Aug 2024 04:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JyQLidQe1vlCymdG3XfMxXTE/EF808gaUXMYK0Xo29g=; b=cLeIEIjfBbORe2eR
	J9rz75YGDVU7cLNvPPWQrYfzY+xD7tiKhiyOinv8hzWb8WZsemWVOLiTKkPc6zsP
	b+XZ8MIqs3o8GRAJTEZhhabf2xjsH0Kf+wVlB2eQpbN2mQWyFyhpg6ZG1etIAGBA
	C9nyV6FnyXQ2tEk7zexMd0+sdCUyGplP0QcGe5/27Va9CXgEMuR9w0Q+fq+QOcii
	6UmcduUtN9DixpBHQMWTsx0s4IowzpJiGg7frWpUGA/NwYnQrQFfvD075TtjZ+DD
	4XSUDKfLDNbS+vFC5DhiIIfuMvJdHRwMlNFG8e2axrZVk57HWkd1hJSlIVe9PGH1
	CBP69A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4195kq8btf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 04:58:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47R4wVQs016238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 04:58:31 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 26 Aug 2024 21:58:25 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <robimarko@gmail.com>, <quic_srichara@quicinc.com>
Subject: [PATCH V2 2/6] dt-bindings: PCI: qcom: Add IPQ5108 SoC
Date: Tue, 27 Aug 2024 10:27:53 +0530
Message-ID: <20240827045757.1101194-3-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827045757.1101194-1-quic_srichara@quicinc.com>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2wuQLbCs5rtR8jvtfA-mWPleokVBny16
X-Proofpoint-GUID: 2wuQLbCs5rtR8jvtfA-mWPleokVBny16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_03,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408270034

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Add support for the PCIe controller on the Qualcomm
IPQ5108 SoC to the bindings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v2] Added reviewed by tag

 .../devicetree/bindings/pci/qcom,pcie.yaml    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index f867746b1ae5..c12efa27b8d8 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -21,6 +21,7 @@ properties:
           - qcom,pcie-apq8064
           - qcom,pcie-apq8084
           - qcom,pcie-ipq4019
+          - qcom,pcie-ipq5018
           - qcom,pcie-ipq6018
           - qcom,pcie-ipq8064
           - qcom,pcie-ipq8064-v2
@@ -312,6 +313,39 @@ allOf:
             - const: ahb # AHB reset
             - const: phy_ahb # PHY AHB reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq5018
+    then:
+      properties:
+        clocks:
+          minItems: 6
+          maxItems: 6
+        clock-names:
+          items:
+            - const: iface # PCIe to SysNOC BIU clock
+            - const: axi_m # AXI Master clock
+            - const: axi_s # AXI Slave clock
+            - const: ahb # AHB clock
+            - const: aux # Auxiliary clock
+            - const: axi_bridge # AXI bridge clock
+        resets:
+          minItems: 8
+          maxItems: 8
+        reset-names:
+          items:
+            - const: pipe # PIPE reset
+            - const: sleep # Sleep reset
+            - const: sticky # Core sticky reset
+            - const: axi_m # AXI master reset
+            - const: axi_s # AXI slave reset
+            - const: ahb # AHB reset
+            - const: axi_m_sticky # AXI master sticky reset
+            - const: axi_s_sticky # AXI slave sticky reset
+
   - if:
       properties:
         compatible:
@@ -503,6 +537,7 @@ allOf:
               enum:
                 - qcom,pcie-apq8064
                 - qcom,pcie-ipq4019
+                - qcom,pcie-ipq5018
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
-- 
2.34.1


