Return-Path: <linux-pci+bounces-5924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B24189D6C8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 12:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D221F21264
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B20F134420;
	Tue,  9 Apr 2024 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qv3S/r3j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086185281;
	Tue,  9 Apr 2024 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657661; cv=none; b=QeUSFHZhyMSN6zzD5dbN9rRuSQHicmqQTdUrzCBF20/kafJuJC7x+lFnNF7sse0mHYeHit6KUS/gVwNCBK+c3Q+5YpfbOhWqGAVq5O5ldmB2rHZ8AWCSJh83UJo54X586pGhL8jCclS3mAtJMENVnfV6QvV94zVe36yNGAjJXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657661; c=relaxed/simple;
	bh=FG21nJMzDgQVBPiWDAMRoSDJCoh5DoD48CK6U3Qv5f8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Wd7irpKMXHFwWXSaktvOtS6cRzff7IqYny57qso1AIRyRk3fLPZ5RP5zxuVmlxNH78V+eeoK2pzx61cK3Km3VbbFei82jq3DwzADszWG9Rj+0u9g9Fm3FIdfoh4eBeqPiQT0DfIIHJELua34MqB50KCSFfg0vfgHps5uKDipWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qv3S/r3j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4397m76x018643;
	Tue, 9 Apr 2024 10:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=ljGBYLQFC3HKRQ9g+LrdPl9BYHhm2n7q5flQqnt1vP8
	=; b=Qv3S/r3j8bkzQnRlIA+FSK6aYlN4aG6sLhb/Ie6cu3AuDl+M1m56DrkHayq
	xBJIMAVnwSkOQQ9BgVwmfNB1OM33PsMG4YRdrVWj9bmOynK+t5HGPxSgwcJdgL3U
	oE17m/+M5fF2JHScAwubD8xsLSVIKXydC9O+3yb/IcHtzSSIdQ3BgBRdPuJ3X1eG
	2F5/m9Yb+vi3TXiE8TsQ9NpVrmtK+mienisSp+yTRuMaLUHNWTF69KBYv4iycPwQ
	XWKiVD/b0UnAnA5Tn8lXgEWrPYF+R2+TT/Sq41J0thMJM3Yvu7YCkhMzkN6lsVYI
	HR/rgxpCEuu8HBjKJPiPa2xWy7g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd0kr0d3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 10:13:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 439ADtYb007018
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 10:13:55 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 03:13:48 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 9 Apr 2024 15:43:21 +0530
Subject: [PATCH v10 3/6] dt-bindings: pci: qcom: Add OPP table
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240409-opp_support-v10-3-1956e6be343f@quicinc.com>
References: <20240409-opp_support-v10-0-1956e6be343f@quicinc.com>
In-Reply-To: <20240409-opp_support-v10-0-1956e6be343f@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712657607; l=1082;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=FG21nJMzDgQVBPiWDAMRoSDJCoh5DoD48CK6U3Qv5f8=;
 b=2tzuYqm50xrOy67emmVZ6lFMnhwb7zcg7q5Q4h5etwxKJH4ody2kvAb9knukpDI9pHZxerEjI
 wDvPoN+DcSMDCk6GH8mwAJwZIU0F2aScQmKLcYgH5xQ8VTLUdhyKZeo
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lUzCsTmTfrPpDMcKie2JdGylYHDxXL2L
X-Proofpoint-GUID: lUzCsTmTfrPpDMcKie2JdGylYHDxXL2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_06,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404090065

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


