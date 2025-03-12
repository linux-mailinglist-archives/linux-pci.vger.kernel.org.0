Return-Path: <linux-pci+bounces-23482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E74DEA5D872
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 09:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351621798E0
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53E237168;
	Wed, 12 Mar 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OTw8WQL/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747AA236A7A;
	Wed, 12 Mar 2025 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769050; cv=none; b=LHeHfKDvVcNDe4c/S1KoiuoIOtPhnE5SFJ0JfCJ8d9DbKAN2+P2Qa9ADCttU80Nkr3JQJFCp+0OtGF8LpC+u04lEP3PsfTnU4xUsMp6pf7qKepeRoFcwGGQgR1cvgP7UcaXW0ACiPQV2swaJ8RmO56TmSPqth2Yo9kHjIRJtyWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769050; c=relaxed/simple;
	bh=LbNsXeglVe978pjjycLcNU0Z27vqz4UFhOywczA79PE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkwsauw6c3QrC6TkYRsX5si6HtNb2ctmwRQzn0KUJ//EF3G3KeWaIPZr3iJ0I3YdN53OEeLpy/XNaZ4RMwr3bw4URfRTg61G3L0vlzHsM9p5QlJV9ghrWr7BKCg5ws8AQe4XuguO4nvD3DtZOJyjAPCqHRjR6xt5rB2NbSxCT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OTw8WQL/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BMHAvv007562;
	Wed, 12 Mar 2025 08:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q5zymIfKRodFPz/QWqJbYl5x+yuSL4wsQhugQfEa+r4=; b=OTw8WQL/3mPbYqes
	aS6GZ2cdW6b16dABunLzJwJ26MMysXijRhVAgK/18jKvgkkUwGLmOb3g7DWKjGxR
	a3qbuujCu311UW1CtaJloiD3WFimXV0EvGlKu9j1gla1iotGrJ2J3+uFO7IS8eUk
	z0UwfrVcGDOLN1ogRcUGXVd0aQvVtrNoSeQsIUS0RbLryCKfEmxMWNfrpAFoaBlM
	cdKnOl3IyDQoDBgFSvaX8zi2F8hiTdEGN42eS3aO496v645TUqptYxIoy6mASnNX
	88Onq+GRc6QQ/yJFGr6ZfLJj2hYaP5iyATDXDw7lr1wVjB600spkEaUCcw0oEzfo
	iYj+sQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2qhpnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 08:43:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52C8hsuE003924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 08:43:54 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Mar 2025 01:43:50 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <quic_srichara@quicinc.com>,
        <quic_devipriy@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v12 1/4] dt-bindings: PCI: qcom: Add MHI registers for IPQ9574
Date: Wed, 12 Mar 2025 14:13:27 +0530
Message-ID: <20250312084330.873994-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312084330.873994-1-quic_varada@quicinc.com>
References: <20250312084330.873994-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 3Yz0gFdGmkBac2pqv9ys_OgGgCCTpLG5
X-Authority-Analysis: v=2.4 cv=G5ccE8k5 c=1 sm=1 tr=0 ts=67d1494b cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=tT2zuRAg_OdXTU1-GqcA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3Yz0gFdGmkBac2pqv9ys_OgGgCCTpLG5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=775 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120058

Append the MHI register range to IPQ9574.

Fixes: e0662dae178d ("dt-bindings: PCI: qcom: Document the IPQ9574 PCIe controller")
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
New patch introduced in this patchset. MHI range was missed in the
initial post
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 8f628939209e..77e66ab8764f 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -175,7 +175,7 @@ allOf:
       properties:
         reg:
           minItems: 5
-          maxItems: 5
+          maxItems: 6
         reg-names:
           items:
             - const: dbi # DesignWare PCIe registers
@@ -183,6 +183,7 @@ allOf:
             - const: atu # ATU address space
             - const: parf # Qualcomm specific registers
             - const: config # PCIe configuration space
+            - const: mhi # MHI registers
 
   - if:
       properties:
-- 
2.34.1


