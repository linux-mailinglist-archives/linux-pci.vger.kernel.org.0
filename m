Return-Path: <linux-pci+bounces-3923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B3186149F
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7CE1F24EDB
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AFA84FB1;
	Fri, 23 Feb 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rz4CNhMi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7F5C60F;
	Fri, 23 Feb 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699737; cv=none; b=JgaDKIjPJ+NiIlfY5mKkx3F0/0067WPWb4Zzpb/8bcV0cHzi0j3CRjKtCnkS4lgeA0BltpS44hZ1x5lPR7L3Opntq+JUN148NWMfmI4L3oOv16KXuiUw9rqvdjw9lkSW/Dn+9ra8/SNzOr5rDTJZ0pLf1O5wla7XlQM6XaIwx0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699737; c=relaxed/simple;
	bh=sUI5hJ3jZ135N0buYIvZdIjDEI5T2GRIwmaUXAbq2Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y4Wog7F/5OuD6SwfA9WCJ3E24amcpRmHWPZ4D7uBHvrywkPh0XTpVpx3VeDhHe4oJOz6GbqS3USEnXTqQTMbmJMw8gMmTnLUOJPMe2uLaJR76Z1/m0tYdz8jnnjU//0j/8Yw5WpJDaH0AGiEo2qnWe7bYmgfwC5p9ayF+uWR58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rz4CNhMi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NDU2a9007337;
	Fri, 23 Feb 2024 14:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=2ilRA4F8XouQOkHZIvowRMIrWXeaZkTccgPDvx1p9nE
	=; b=Rz4CNhMiSVHG4vrHRo+SkaSbstpSIjXAJ0OV6aXNcbl5CMt2/U4KwdaBCOb
	p8SAMfLInNT9BnMQMhHm5zUlSLm8lEgLIb6iDm/R3cGyQru/RvrNZlsVk8P9I9dp
	q00cwYnkEVBY/Z4koptzINgSZFPWd+/5mr1ONIYXQ3ELqrgOiySLzdXt+lVCYdY9
	vWKW7uFh79ZB2WTe9Q8/j0upfwWWtXHprUJTFd33bPkC0SAgJIisk8EXreyVAMEw
	ZB0BS7AtnaLLZLFfAV7/CBcLQ9lslQs7A1sfH9WLHS7Y60/3vEYzYDDKngKU4m1k
	ldPin8R/GmtPMsjgYYyuWxglVuw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weqcf8v9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:48:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NEmkY9017016
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:48:46 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 06:48:39 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Fri, 23 Feb 2024 20:18:01 +0530
Subject: [PATCH v7 4/7] dt-bindings: pci: qcom: Add opp table
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-opp_support-v7-4-10b4363d7e71@quicinc.com>
References: <20240223-opp_support-v7-0-10b4363d7e71@quicinc.com>
In-Reply-To: <20240223-opp_support-v7-0-10b4363d7e71@quicinc.com>
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
	<quic_krichai@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708699692; l=1100;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=sUI5hJ3jZ135N0buYIvZdIjDEI5T2GRIwmaUXAbq2Io=;
 b=rvAl5ycEVrHXHRamaQsUvfLfLWU7+GLK4wOrDyC8Id/jNHkQkEuQHsnWG1LCu2W2DjbW4lWlK
 Nf9SL3HFN2ZCOETppS1sxPUyj34X/Lo/x9m+bf1Hf2kXygeZ2rHxL80
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: earLYDZASq_1d-e4n4lx5YliBjlQ0bXG
X-Proofpoint-GUID: earLYDZASq_1d-e4n4lx5YliBjlQ0bXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=916
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230108

PCIe needs to choose the appropriate performance state of RPMH power
domain based upon the PCIe gen speed.

Adding the Operating Performance Points table allows to adjust power
domain performance state and icc peak bw, depending on the PCIe gen
speed and width.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 5ad5c4cfd2a8..e1d75cabb1a9 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -127,6 +127,10 @@ properties:
     description: GPIO controlled connection to WAKE# signal
     maxItems: 1
 
+  operating-points-v2: true
+  opp-table:
+    type: object
+
 required:
   - compatible
   - reg

-- 
2.42.0


