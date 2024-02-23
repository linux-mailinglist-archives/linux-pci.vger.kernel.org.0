Return-Path: <linux-pci+bounces-3920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB986148F
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FB9B2283B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF404839FB;
	Fri, 23 Feb 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xjtp9Zd5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908782882;
	Fri, 23 Feb 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699717; cv=none; b=EdUxsMzAQ+BKjzfshWt9q4eGAB4ztk7PWXe0qH1hyJ46+tEg21cbuqhlkqJsCPjG75W4TNT0ePbhfHaDootSy9J4lvUbfIM0FCHCHFjv387CQzbdH2Wk8zdn6OxjU8MyN3K6vKr4oeODty/ppHs7URUVjl0T1qL+GmWsj9uPcoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699717; c=relaxed/simple;
	bh=gEXVyphupj2CWbliP1o3xIi3gZkXWhknxxEg/8SeEs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=poAdRLXvVhs8BNdgbtCJC4725WTnywu3kH7fQnpiPJaaMzD5siCFtclOZCt29NV+MqjrjIidbYOCBT3G5Hw+YAw2F+NOmm1bHzhCzdSpaZRHMgxYkYGX/sxUZEneaANenJt0O9jFgzZ0O+x88yaS2gQDNzd8cgTRvMhf+60h3e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xjtp9Zd5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NE0SLH028637;
	Fri, 23 Feb 2024 14:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=Zyj0RWvOiosbqWwtwDt7FHmCZXnxwMqY+tBECEjX24I
	=; b=Xjtp9Zd5tWw/enqbrSbHhBG8I821fni+oBtBrCvpXxEJaOffyXWFy0G77Bn
	sYg1OmubxXFzbhpylWcfvJURdRmiwYBbfOHKbyzXlLdzJoumdLLHJDHvci4RGMlP
	KorKT/OVhHVQ5Hph9GoSlWuOSkubYdI84YuUfza0PMm+ic1f/V1++/deuEyPFNPY
	hVLBvjT7QdKucRRyxz91tTA3HFPHlK4iC56GuATr/E6OvlW2h1ObJcJnSwFdS6f2
	uSk59dLej5cMJfTuqqhLPOdVF6d8YSW7YBHugVR+68M1H0y4PNUNX/z2FqosHjQM
	byEl3Ino6Z+QFWdseGmyiJ7nh6w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wer8mrsxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:48:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NEmQDt020455
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:48:26 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 06:48:20 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Fri, 23 Feb 2024 20:17:58 +0530
Subject: [PATCH v7 1/7] dt-bindings: PCI: qcom: Add interconnects path as
 required property
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-opp_support-v7-1-10b4363d7e71@quicinc.com>
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
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708699692; l=929;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=gEXVyphupj2CWbliP1o3xIi3gZkXWhknxxEg/8SeEs0=;
 b=QLiFymHjGMJEjW8+ephW4x2dYldE9CRebBwBEfRLFz6zpB8xDww/cqUI/t7dS7iSEY1aa4UKV
 mUexvNGoFndDq/XXdmmy7OFLVWBaXmw4faFtPLuogQKKgKFPkTpE9rU
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DYhOoomshwAu8GdCNAOA8Ib7qOoGDvhQ
X-Proofpoint-ORIG-GUID: DYhOoomshwAu8GdCNAOA8Ib7qOoGDvhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 mlxlogscore=841 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230107

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


