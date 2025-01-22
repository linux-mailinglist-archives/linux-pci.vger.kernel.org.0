Return-Path: <linux-pci+bounces-20223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E09FA18C23
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 07:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CAD3AC0C3
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 06:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77B21C173D;
	Wed, 22 Jan 2025 06:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mIno8EHU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2E1C07D8;
	Wed, 22 Jan 2025 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527699; cv=none; b=B0TGlbFoWJglOL78bx8Ck6CNbqmq/x3+ylaNhmqtIYiohJlA8WvHjBM/WLGwvmK8HsBcBTwbORc1NqMojiLhZZR6Lt3/FivBw2AK0Di/yMjWMzGtKq5iqFJMUshVXvDqCik8I9wHfySzxlaTrV02q7t2+kV/YBgFkZ/zp2EOVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527699; c=relaxed/simple;
	bh=a4BiCDQhwGj1LHCGJCVHblr/L+Ad05ea03m4VkZ7S1A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWQIIB6yLo3zpQEhkUGF0e6Kc2fhqTPVD13Q6y1IaxIDt81trgTFeP7nMdeS86Ana4c7HuBG2J1Z3aK3EasK6MljSYFf38jvcm0DyU6VBH7WQR0cqA9QRxkn+uI/4HTEEWG0V3vnOZXaulEUNTMb5aHEDmNR7IjDlXIi17YPiiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mIno8EHU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M4ZCC8020517;
	Wed, 22 Jan 2025 06:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DwOTU/FjzsKfJqGbRHWHC600KbvAtx9PvP02JkijqwA=; b=mIno8EHU4q3f8tU+
	IGneCLo0aH9c+H+J9w6Tk5C+W5pWWmVNx4QyMYryebvOz9hrlBLOErkMPIx2WjUX
	cIvIg+m57cH3DCQZc9NeNWbVA+HedHtG1y/HjUj3D43JswK5rgTATQH/Z32tDTNh
	MlykmUeTEDnUUwmNaaKmWumoWEuZoBWn5FYFVu/73FFuDv6Pf+bMarCz7ZsGWXRk
	W/tuezv9/PhsvrXMxdiDoZQoc19fmpTBwCDBokUlNV7nrCTsYd4vnlVotTLt01KI
	qyav2/bLLhtyfFmF09kFuVoSLiOyNbGBOdvoNZmoOWA49jEJqYJwBdy5GxFVTJ8m
	KGFrGA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ass6g867-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 06:34:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50M6YmO4010135
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 06:34:48 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 21 Jan 2025 22:34:42 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v7 3/7] dt-bindings: PCI: qcom: Use sdx55 reg description for ipq9574
Date: Wed, 22 Jan 2025 12:04:07 +0530
Message-ID: <20250122063411.3503097-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122063411.3503097-1-quic_varada@quicinc.com>
References: <20250122063411.3503097-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -JQPBpVa6J7rW8oZjQsEvU5Wb-pIS1cp
X-Proofpoint-ORIG-GUID: -JQPBpVa6J7rW8oZjQsEvU5Wb-pIS1cp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_02,2025-01-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=804 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501220046

All DT entries except "reg" is similar between ipq5332 and
ipq9574. ipq9574 has 5 registers while ipq5332 has 6. MHI is the
additional (i.e. sixth entry). Since this matches with the
sdx55's "reg" definition which allows for 5 or 6 registers,
combine ipq9574 with sdx55.

This change is to prepare ipq9574 to be used as ipq5332's
fallback compatible.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index bd87f6b49d68..413c6b76c26c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -165,7 +165,6 @@ allOf:
             enum:
               - qcom,pcie-ipq6018
               - qcom,pcie-ipq8074-gen3
-              - qcom,pcie-ipq9574
     then:
       properties:
         reg:
@@ -206,6 +205,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-ipq9574
               - qcom,pcie-sdx55
     then:
       properties:
-- 
2.34.1


