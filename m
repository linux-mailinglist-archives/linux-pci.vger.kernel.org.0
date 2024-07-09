Return-Path: <linux-pci+bounces-10004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 987B092BDC3
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 17:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68D4B2CC34
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A82A19CCE8;
	Tue,  9 Jul 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KPXGIz8e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A51591EE;
	Tue,  9 Jul 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537247; cv=none; b=P0bEqGLPmNEY74CTvktBy7EWusQ1lWcmcPWP/TozhZPqclsmlHXJOfW3rUEUu9YNnHXn2eYzOpJ6Wuhq1YIZv3oe4fz90kiVlbT3qeTg0p2PxV1KDZgXrWeC0o7XMc+SBVjLT0ju83eogpSG4WoaqDoBmQrL3tVf8ucEmSDFk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537247; c=relaxed/simple;
	bh=JB2qCg1Sv/WpHeH9o5aGx7yq0QAXFpUYBlvgWghuhjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hOYGYQiNneMQih0vEFvsps9Om5cmE7xTLz9mrFwKRGjVs+zqFEYwkE4GfSYdS6qPwppqBmOmkCaDTP5zmP9zkGF5LYVPsSSfCRKp6/CLQ58CiDpkDBbz5AxJSGwjjWaSvC+GDq/1N9mbtMIZCWtejwLXP5We8IpSD7pCXUn2+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KPXGIz8e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469AcpV2021511;
	Tue, 9 Jul 2024 14:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OdqwpOUetaPnGvkZHmUIT2r15/wl59M+8LNFOwnzpKs=; b=KPXGIz8eEQafmCS6
	19S6yzjod772WCRsHbVZd/IaMrCAMEG6oME3ISwS9/MF2RbWqvsClAmSQtkP+Km+
	ZGLY16xhn7XCmiHVczWCJZ655tkWI2bbEK4aVi5tgxh5FQAU45cWW4ZfL7WckcDF
	zJu1I3MFuyanuIyqNJ4ijuNdmud54SEiTOTEDvZIttkd4mMb/JodB5DyA7lRfHvB
	OZrTAwdJq/1VckpRJZu+mkSwYt210SgH8wlNWqgSEufMqb3W8Udr83jVgzpOTGol
	KiK7azO5fzWtTraLRWj4MUFZvYP16YSTWULOk7MyNOWgS20Mp7VwAzec9uJSay85
	Og2tGQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wmmpwdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 14:59:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469ExnvK025010
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 14:59:49 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 07:59:43 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Date: Tue, 9 Jul 2024 22:59:29 +0800
Subject: [PATCH v2 1/2] dt-bindings: PCI: Document compatible for QCS9100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-add_qcs9100_pcie_compatible-v2-1-04f1e85c8a48@quicinc.com>
References: <20240709-add_qcs9100_pcie_compatible-v2-0-04f1e85c8a48@quicinc.com>
In-Reply-To: <20240709-add_qcs9100_pcie_compatible-v2-0-04f1e85c8a48@quicinc.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720537180; l=1083;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=JB2qCg1Sv/WpHeH9o5aGx7yq0QAXFpUYBlvgWghuhjU=;
 b=clBXAQ3zrkpq2aRhR8pv2HUhdvIhqhO+YtXcph7VK5dqR/eSuVGxHW2Iwhy2q16PSGm1Zopar
 BjWgDzXEhmSDrYQJ7ksnxJu2D3A3gyLdZ2/dWm1AvpCyJOv8/oSKKeV
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ee6cfComLEr3nbpMmHHo_0Yab46BBBjT
X-Proofpoint-ORIG-GUID: Ee6cfComLEr3nbpMmHHo_0Yab46BBBjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=962
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090097

Document compatible for QCS9100 platform.
QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
platform use non-SCMI resource. In the future, the SA8775p platform will
move to use SCMI resources and it will have new sa8775p-related device
tree. Consequently, introduce "qcom,pcie-qcs9100" to describe non-SCMI
based PCIe.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
index efde49d1bef8..4de33df6963f 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
@@ -16,7 +16,10 @@ description:
 
 properties:
   compatible:
-    const: qcom,pcie-sa8775p
+    items:
+      - enum:
+          - qcom,pcie-qcs9100
+          - qcom,pcie-sa8775p
 
   reg:
     minItems: 6

-- 
2.25.1


