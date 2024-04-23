Return-Path: <linux-pci+bounces-6559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC3A8AE0A7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 11:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988AC286B3B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE2757870;
	Tue, 23 Apr 2024 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BdIPVgyX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C957333;
	Tue, 23 Apr 2024 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863307; cv=none; b=Sgv9A/Rb1K9U7Z6p3s+pfFpiVZKJlao0WwJxue4yv8NY69hkHlO9VJrsaW6cHPjxGX26zXJn6gZh2L/+lzhM7DWsCGMDeXSJ2qXXohwDpWmB8YXSVdm4kIJbQjH/mC8Hi8rIkW8M8jmD0KVdaTa0XOE1Ntxk01Drryg9DN0zuzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863307; c=relaxed/simple;
	bh=FG21nJMzDgQVBPiWDAMRoSDJCoh5DoD48CK6U3Qv5f8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ofArj3MbiYuubVeQztAdP4KbnHonMr7B8HKZQOzrWK68e297ajAUxmUPIXCv2CWuGSJh7nBKKiU+bTdiofJ3JhTpiodrM9S4Av9qznmO2LnNszo8nnjZYfcv48T215FtrgbLrK+hCFmsnD/NOo919e+U9itpuMWy3DbpqjYfzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BdIPVgyX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N8FdPD009777;
	Tue, 23 Apr 2024 09:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=ljGBYLQFC3HKRQ9g+LrdPl9BYHhm2n7q5flQqnt1vP8
	=; b=BdIPVgyXnOs+BcDdS63bRI16icB5qAtv2f4mE87jZ22lAQ/C2KnbCejcPhT
	+Q8lf4H7rxKBxVz1ChnMCZ+TJ4gos6szK8L5yY7voVfKJrkyX6pAYHRIa6TCayzB
	G026nfSwb/yFIGHPJ7Cd0m2ZoU8mee/uhlU6Pi42tYxdJfqg27BF8ApU3bmx8NyS
	Vdl76p6WzgXbfunRyvpxuCbVLdIQRS5gFWJKe/a+42TV4BIcvLo9Vb+NHxrMA9Y5
	LgEBTklN2bY/rVxPSVN7MZADjDljw3JE8at4G7DpCGRtaL7/qiIJs9xfoPVyuR3D
	Up3cDH66DftK5AilLfU7fux5m5A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp9aa04c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 09:08:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43N98Dsl001926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 09:08:13 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 02:08:06 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 23 Apr 2024 14:36:57 +0530
Subject: [PATCH v11 3/6] dt-bindings: pci: qcom: Add OPP table
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240423-opp_support-v11-3-15fdd40b0f95@quicinc.com>
References: <20240423-opp_support-v11-0-15fdd40b0f95@quicinc.com>
In-Reply-To: <20240423-opp_support-v11-0-15fdd40b0f95@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713863266; l=1082;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=FG21nJMzDgQVBPiWDAMRoSDJCoh5DoD48CK6U3Qv5f8=;
 b=gKzIIKu1NU2Cx4Ti1z6HPqOt186P9zNlyY8LdyfkL+N/4kLyAsS2LTuQCXN9ORy5hr2PAXHWu
 P6l1/Yboc95BRwkWG+jS531zXfl0WYWzdWMdLZd+qNqadr8a2q6vO3F
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 17Hwed8_nEFOhj7BAhF34KB1wXSD_2Dy
X-Proofpoint-ORIG-GUID: 17Hwed8_nEFOhj7BAhF34KB1wXSD_2Dy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_07,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404230025

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


