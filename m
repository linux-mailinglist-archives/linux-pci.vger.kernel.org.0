Return-Path: <linux-pci+bounces-19162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42149FF8C8
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 12:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C963A2F78
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 11:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BC81AC44D;
	Thu,  2 Jan 2025 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S3miscrQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFAA1AC435;
	Thu,  2 Jan 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735817483; cv=none; b=luMfOqkpvVQ8g0Ft9sUb9SSNiZ7T5KBNkl4v/E2crlyT0Fnm0pbP7EUfWhAgHsbgQMSZxWNVJQ/a9wBeZmmEUT4axhDGJ0/ZMv9meM2/Zmqtl1r57EkghYOZ/ZvwD6OGcYImpKdZMPtHlioZ1XwZ74POd7U6wSKv47sLwGNrpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735817483; c=relaxed/simple;
	bh=kR5DZg11/lS8sJzEVh31zwKRWJNDoRwVH3FjDzxFd5A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AU4Why5csuhj+7GyM6ngiagAvYQcn967Jw2/MTKX2wQePbu/KY0jq8WogRQePF9C8iingILpFj7rx2ra5OQsTFQqktMU60FToVMM/N3DtQwJQRZh7ffEGqABaIOlb3MxwVh0WqaScqN4u/YWLF5CbKb75EPz+G3vgf0SuH/BQuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S3miscrQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502Abt4f015290;
	Thu, 2 Jan 2025 11:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vUeLGBAxvts4X203Q/MGdubbLNCCoO34ykMY+aa8tUg=; b=S3miscrQjh53QEBH
	63BJ/CDdpOr4h/Vzlmx/7ClGimyObEcbasB3hTq8GDzBBXJdVWKvgQ+RU19U/Iox
	l1h+uBi3kZLPqx8LgPHeVpUD0kCtYZA0QqSgHKSIXuKC8DyLbKJOKpTMbs0Mbsjg
	sAuEjbvJ6KGxkarw4OOXxLUdnLV0deqzdP904iXQD6KhiLuiCCAKgvkKJGvtuuUZ
	KT4SK7EX/SliJ0whBKTh4pqZWibeVXRS+s4hFRnmf/40KNWFn4pD9akqmScUCK+w
	zmdFXasioBxLIefcNRhsTWNLXpN7D3LpGTNGRww4D+i1UgbtSO/+8zhjV35NIeGi
	cijaIw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ws7a82u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 11:31:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 502BV2Bn002783
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 Jan 2025 11:31:02 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 Jan 2025 03:30:56 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_nsekar@quicinc.com>,
        <quic_varada@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v5 3/5] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe controller
Date: Thu, 2 Jan 2025 17:00:17 +0530
Message-ID: <20250102113019.1347068-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102113019.1347068-1-quic_varada@quicinc.com>
References: <20250102113019.1347068-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: eMWF3jbt_JODEXyErEDXygikOpshaQCH
X-Proofpoint-GUID: eMWF3jbt_JODEXyErEDXygikOpshaQCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501020100

Document the PCIe controller on IPQ5332 platform.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Re-arrange 5332 and 9574 compatibles to handle fallback usage in dts

v4: * v3 reused ipq9574 bindings for ipq5332. Instead add one for ipq5332
    * DTS uses ipq9574 compatible as fallback. Hence move ipq9574 to be able
      to use the 'reg' section for both ipq5332 and ipq9574. Else, dtbs_check
      and dt_binding_check flag errors.
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index bd87f6b49d68..9f37eca1ce0d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -26,7 +26,6 @@ properties:
           - qcom,pcie-ipq8064-v2
           - qcom,pcie-ipq8074
           - qcom,pcie-ipq8074-gen3
-          - qcom,pcie-ipq9574
           - qcom,pcie-msm8996
           - qcom,pcie-qcs404
           - qcom,pcie-sdm845
@@ -34,6 +33,10 @@ properties:
       - items:
           - const: qcom,pcie-msm8998
           - const: qcom,pcie-msm8996
+      - items:
+          - enum:
+              - qcom,pcie-ipq5332
+          - const: qcom,pcie-ipq9574
 
   reg:
     minItems: 4
@@ -165,7 +168,6 @@ allOf:
             enum:
               - qcom,pcie-ipq6018
               - qcom,pcie-ipq8074-gen3
-              - qcom,pcie-ipq9574
     then:
       properties:
         reg:
@@ -206,6 +208,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-ipq5332
+              - qcom,pcie-ipq9574
               - qcom,pcie-sdx55
     then:
       properties:
@@ -407,6 +411,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-ipq5332
               - qcom,pcie-ipq9574
     then:
       properties:
@@ -555,6 +560,7 @@ allOf:
               enum:
                 - qcom,pcie-apq8064
                 - qcom,pcie-ipq4019
+                - qcom,pcie-ipq5332
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
-- 
2.34.1


