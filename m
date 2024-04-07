Return-Path: <linux-pci+bounces-5829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4576189AE83
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 06:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5291F23262
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 04:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9AE5CA1;
	Sun,  7 Apr 2024 04:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kzEsff2A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC011725;
	Sun,  7 Apr 2024 04:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712464704; cv=none; b=ad0vKNQhYEhMjVH6G5aT3+vkjA6sVpIKlge7tkdnGQWtEmLsozLJSQ5Hs1nA5a49RYPqlWELkYA81W0SeaZ7366kO7Gz/6tNYqLYXhQbkYC3TmpdRjem1vkMYBpJYq+KTotTqRJkiwSKQZxHZvg5Mr4gClJxpdLwASpFsQm08aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712464704; c=relaxed/simple;
	bh=VaLRK583nVXtRfRLU8lOqrk3FnusLkwdJP2YX043bzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SYAuDdxrLZZrueVoJCOK8pNdXo4o1hKQGVBeneiOtFS3mYOFuEZ3GBemorK2Nk9BbJAcPzfpMWHtKcCDxB2ZKGpkBzTmKRXRruQXkotdaqODv/AC8B1CQuDRy/ms2fcdOjn5FwKLmwPswuem5Vld8uR8yPWle6S+G/gXiaTCv94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kzEsff2A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4374I1On018536;
	Sun, 7 Apr 2024 04:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=ctbRZu1DoMxzGXligA3eM3/VMlIffgyxRvGOt8QRfvE
	=; b=kzEsff2AdndwxfU2cGcjk6a/u5j9IM2rO5E0QneodSn/zWgK4SJCrAeX/TU
	thfycsrSIB6U56PmQjffacBfNHFO28VWtDleRP2xgZhhmTsr8s0zsZaHhgDPkrkf
	Lwt7OLUI8TXlpEn6MQ5Rfsvd8dAHTl3Tl61Co+aUih2Wk6bLWehZVqf8uPGLEMif
	Pyc3cQIpkswfacYQtxikz3rKUJ1UFXcBIfRV7YYSaKypFwUs+NxnDJ+2bBN9gc9l
	vIvY0KmX531G828dnip0uY0fVuJZE2yMXWDjPr+MjQR2VoVUCgAunU2EFPsr1fK/
	OlqEB6iAPY+6aozxtp3uuWRRJpA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xaxmb9bd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 04:38:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4374cD5i008357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Apr 2024 04:38:13 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 6 Apr 2024 21:38:07 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sun, 7 Apr 2024 10:07:36 +0530
Subject: [PATCH v9 3/6] dt-bindings: pci: qcom: Add opp table
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240407-opp_support-v9-3-496184dc45d7@quicinc.com>
References: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
In-Reply-To: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
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
        <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712464666; l=956;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=VaLRK583nVXtRfRLU8lOqrk3FnusLkwdJP2YX043bzc=;
 b=mW4wNv5+/aJw3iGBK7lmlgHyR/N30f9W7L3ZT8pP018GQ3jYxnE1n7jH+4G+9RbfxpjgkUCn7
 v7l6R7gGkweDPgUFZBJgmSMRh2zDwDX0fllG3XvaxhInycaXfev1Rni
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PbqKzIM8yHHsVvSZx8lgQRqVhy9GO5fx
X-Proofpoint-ORIG-GUID: PbqKzIM8yHHsVvSZx8lgQRqVhy9GO5fx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_02,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404070033

PCIe needs to choose the appropriate performance state of RPMH power
domain based upon the PCIe gen speed.

Adding the Operating Performance Points table allows to adjust power
domain performance state and icc peak bw, depending on the PCIe gen
speed and width.

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


