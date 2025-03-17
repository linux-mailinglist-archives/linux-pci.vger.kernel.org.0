Return-Path: <linux-pci+bounces-23913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F870A6489B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 11:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AB916A071
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 10:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17739233717;
	Mon, 17 Mar 2025 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mSe7FsU0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6CF226D1D;
	Mon, 17 Mar 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205689; cv=none; b=VCjDOkhpLMdSa5SIPRvZQIQ4bqAwf6H8+tY0IpKmFf/OfY7B27Dj1tiud+/QyUc1jwsx7HNmnZuczGctkhaz8P5gfOt41cCFZ3IbVy/g/DNb3Xwrx7CHxgq/nMmJftxBCqn7cBu9CRIjiVIS9J5ffnUmKerPel/k+j4LRiEEq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205689; c=relaxed/simple;
	bh=Ll9Qzlu+6pCWxbJM4YytS1sowktCr8GfhiKADbS4n4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbKCrbdQtFBjizUd9/TSKmfCc3wyr4MY+lSMXzh75SpvTW0ELsLYFZTDXgD2HbvNmxtLbyNFLgbT9f00qoBHOh78taBCgSVnBBtRAfaMpSOCGL3DLfZw7UQlb4Wl2EZdETg4kT1xntXSryQsmui0V67mRWE6i8Bd8xRXlY3NhfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mSe7FsU0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GMbu3M008664;
	Mon, 17 Mar 2025 10:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6oeKXfxLvwEecBoX43TQT4sz1smP6S93m1J0YTfldds=; b=mSe7FsU0Knbk3icl
	G4C4W6RXHxZBwpo9DihqJCaJJNJD3MlSqIBT5XRIR0/6bLyTmj6GKb/XtZ/hyWkj
	PinSZ1SJB6OFw8Uz3sVyllUP1cGga1+809TzWOTzgDXg7AKiNkqDfsla+4M8NmHc
	m8YkuwroBlJm+NcXikC8j57j8QrQDglK3Q7cBRzMl1z0CNe3CNwv0osQvy3Oz0RO
	8sTXmPl0h/Ah/f/ZXtex2xQ8sed1TxLjHuG3gAug/WEjP/XH1FWd9kAzjcgJxctK
	BKQZgx3Pv/8Jxe6HNUn7WYwxpjld9rOZ6bcNH095FiTYVGKdO3BUj13mfxuHw2ab
	nEUniQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1tx46hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 10:01:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52HA1F4X014871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 10:01:15 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Mar 2025 03:01:11 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v14 1/4] dt-bindings: PCI: qcom: Add MHI registers for IPQ9574
Date: Mon, 17 Mar 2025 15:30:26 +0530
Message-ID: <20250317100029.881286-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317100029.881286-1-quic_varada@quicinc.com>
References: <20250317100029.881286-1-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=W/I4VQWk c=1 sm=1 tr=0 ts=67d7f2ec cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=SybdbZUrytBkLZyOo90A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: dMCcSdMxRU0MKFhnh5O9-_I4MozTuOeT
X-Proofpoint-ORIG-GUID: dMCcSdMxRU0MKFhnh5O9-_I4MozTuOeT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=796 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170073

The MHI range is present in ipq5332, ipq6018, ipq8074 and ipq9574.
Append the MHI register range and complete the hardware description
for the above SoCs.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v14: Update commit log

v13: Fix 'minItems' for reg-names.
     Update commit log
     Remove 'Fixes'

v12: New patch introduced in this patchset. MHI range was missed in the
     initial post
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 8f628939209e..469b99fa0f0e 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -175,14 +175,16 @@ allOf:
       properties:
         reg:
           minItems: 5
-          maxItems: 5
+          maxItems: 6
         reg-names:
+          minItems: 5
           items:
             - const: dbi # DesignWare PCIe registers
             - const: elbi # External local bus interface registers
             - const: atu # ATU address space
             - const: parf # Qualcomm specific registers
             - const: config # PCIe configuration space
+            - const: mhi # MHI registers
 
   - if:
       properties:
-- 
2.34.1


