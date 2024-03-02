Return-Path: <linux-pci+bounces-4358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B807186EE54
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 05:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13FBAB24246
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 04:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107D18F5C;
	Sat,  2 Mar 2024 04:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pCgRPf5l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670798BFD;
	Sat,  2 Mar 2024 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709352027; cv=none; b=i6gcZm4XYZrUTJ178RTRPRqhuYnlbFF/8/8f+lkBFrDBymNRJ3WwWKxKVBeU9FWWXIu/qCg9vYgcra3qoRoiOxISrtedBxFeMr5MKse5pHbGhQhu1855Nw4OauKfkmno8jxiIMPtOB7T/qhztWC2QCwrATmPJiI56x4eT1uMO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709352027; c=relaxed/simple;
	bh=gEXVyphupj2CWbliP1o3xIi3gZkXWhknxxEg/8SeEs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eEjUgG4LBzzo3x6B+mCNGDA4eceXkSr/B+0to5T2OLjXdvUeVw8Nvk06M7e4w/bQSFeLfu89/1tOaao/VNpD75c0p+TeoYQ0pDOSfCx9K7clCTnpOxU6Y3RZUS4G5fdaNryDdDbixcerracIZsSjds/2ChLfK6FELDDFi3VGwPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pCgRPf5l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4223sGMS005133;
	Sat, 2 Mar 2024 04:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=Zyj0RWvOiosbqWwtwDt7FHmCZXnxwMqY+tBECEjX24I
	=; b=pCgRPf5lmTu16BQMaGt3PEB4bVv5hZtQx0UQS4TNPTEDg1RSmXawmCEcET/
	Kn+sxx2DCdvdwzMN8Bt5R3rJFmsXd0O8nu8gGcwdaCP33cc4pvjmIJZhqaTskrUl
	pnPbutvhxMc8KxHVvdaMCIYdKYvzFTXTYLoBTRB8o547A5l7hbuvYUHGscXR1ckE
	1bvj/PFPeIWV4UNmahjysL1JHRsYUUp9H1jfQZiFdbxvZHEn2rQMdfItQmq92pY2
	7yz3IwoKtLO7hihJRociyvx/SpX5gBJf4ei54dodhj8pfQhbJIatic/QsRR8vMOX
	V/oCsaviYvlhaTwBvQdM52NfmWg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkk3u102k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Mar 2024 04:00:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42240HGt006359
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 2 Mar 2024 04:00:17 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 20:00:11 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 2 Mar 2024 09:29:55 +0530
Subject: [PATCH v8 1/7] dt-bindings: PCI: qcom: Add interconnects path as
 required property
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240302-opp_support-v8-1-158285b86b10@quicinc.com>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
In-Reply-To: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney
	<bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709352003; l=929;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=gEXVyphupj2CWbliP1o3xIi3gZkXWhknxxEg/8SeEs0=;
 b=nhHW3sijbUU6+aQsN2ArCeH3WIZo7u6mD7Dt7EgnqobTdWvWUyrJDtP0H4f7YyQ1tK4FXMnpE
 ZkF08yFxYyPA439eIBfYuWD5BSm7TBP7oJ621VJ/uNSdlgMzLbVTmAB
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AJQMHq3IfoH7Gqwo2jVEdZC5rTzpmxIb
X-Proofpoint-ORIG-GUID: AJQMHq3IfoH7Gqwo2jVEdZC5rTzpmxIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_24,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=860
 lowpriorityscore=0 clxscore=1015 mlxscore=0 impostorscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403020031

Add the interconnects path as required property for sm8450 platform.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a93ab3b54066..5ad5c4cfd2a8 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -834,6 +834,8 @@ allOf:
               - qcom,pcie-sa8540p
               - qcom,pcie-sa8775p
               - qcom,pcie-sc8280xp
+              - qcom,pcie-sm8450-pcie0
+              - qcom,pcie-sm8450-pcie1
     then:
       required:
         - interconnects

-- 
2.42.0


