Return-Path: <linux-pci+bounces-6714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C7E8B43A5
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 03:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38329284348
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 01:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DE639ACD;
	Sat, 27 Apr 2024 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d35MymxP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F4C38DD1;
	Sat, 27 Apr 2024 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714182857; cv=none; b=QBHjvXZOH1sN4BSi54KnG5B1dc+qjDKSbrr/HTgD8fecINwG/ZvRTXip09IQCQ3qKB6qsesV7kIEzlA0H005et7xrz1IR+ZLmES/BZ0fm3+aZILtyd0bgc8Wc1hiV+D884mTL7a93csyNB0cW2d1eMnkN4scMVhSXHm4gGnfDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714182857; c=relaxed/simple;
	bh=FG21nJMzDgQVBPiWDAMRoSDJCoh5DoD48CK6U3Qv5f8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ggr5zJD7vPE+PSX2VhDMIFfeVPkYC80Nsp6fSfj5Q774v+U3pyD/6CM7v+V/Uh9FSQdKIoa9YmISweYlRKKz2nvVgZB1rgE98BxvM1+lWd1EzEmi+JN62bLVA6t4oRDw/v8csDzhrfbtgtf57NqYenV5yf3t8ChqPE9yOmx0CV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d35MymxP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43R1A2VU004162;
	Sat, 27 Apr 2024 01:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=ljGBYLQFC3HKRQ9g+LrdPl9BYHhm2n7q5flQqnt1vP8
	=; b=d35MymxP4bI+yhK3d+5eIT6hFvxGLHLMtpZVFWlDsVBdVZvA9AM1QcCzudw
	637gTcdsa+AJ32u+jnk6r0sxVHIRJaudVxsgLFUSFqRcsmp21DSbmOfX6ke7h4RU
	2Iyd7CLO84zPQdY8upVwKQfyqDgJ68+zGJka4Z13Vvsk88mDjPlCiOF9phVvOUbw
	J73wsbpeI2W0OkMeIEJbEQnagGVcUqvBf5k32Dk+9MicPQxw6oLt2vXY1Amldrjo
	TAzpVHpPOck8S/ReUY3JTwmU8J635+MgJ8Xd6xEJAh+/PF8z04jAT/Wda9a+UCSX
	L6qgKL9glbQIrIgl5tEkXoxLvtw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrfak8y3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 01:54:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43R1s4qQ010956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 01:54:04 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 26 Apr 2024 18:53:58 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 27 Apr 2024 07:22:36 +0530
Subject: [PATCH v12 3/6] dt-bindings: pci: qcom: Add OPP table
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240427-opp_support-v12-3-f6beb0a1f2fc@quicinc.com>
References: <20240427-opp_support-v12-0-f6beb0a1f2fc@quicinc.com>
In-Reply-To: <20240427-opp_support-v12-0-f6beb0a1f2fc@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <johan+linaro@kernel.org>,
        <bmasney@redhat.com>, <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_krichai@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714182817; l=1082;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=FG21nJMzDgQVBPiWDAMRoSDJCoh5DoD48CK6U3Qv5f8=;
 b=zx70rg7S4ipt+KtlqG49gOJAMhEhxAsGBUmDDC+ERlRiQS2a0STZWYm6ImIQrCn4u91cSJ40A
 nu8VtWAmhv/DqZHsqV0XSSjFesKTgkkk8TY2mhoKKEtPlBlYfYIutu5
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z0ZUH33C3hVJ222RenuLc3vp2fTM7ePK
X-Proofpoint-GUID: Z0ZUH33C3hVJ222RenuLc3vp2fTM7ePK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_22,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404270012

PCIe needs to choose the appropriate performance state of RPMh power
domain based on the PCIe gen speed.

Adding the Operating Performance Points table allows to adjust power
domain performance state and ICC peak bw, depending on the PCIe data
rate and link width.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
index 1496d6993ab4..d8c0afaa4b19 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
@@ -69,6 +69,10 @@ properties:
       - const: msi6
       - const: msi7
 
+  operating-points-v2: true
+  opp-table:
+    type: object
+
   resets:
     maxItems: 1
 

-- 
2.42.0


