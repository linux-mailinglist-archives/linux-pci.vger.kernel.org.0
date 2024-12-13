Return-Path: <linux-pci+bounces-18374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7D9F0DDE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 14:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570ED2823D8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7441E3DFC;
	Fri, 13 Dec 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AjB2TWVt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC561E3DF4;
	Fri, 13 Dec 2024 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097873; cv=none; b=SiERP9ZGMA0cZKySVcUyic0cg4ZgqL5OaQyf+fuEPw0+6gmZXLTMt4El5Efw+4sWlRbrU5I27503eIyn0Ujxn7oK1/pDTYGkmGZD32/Nk1U6ihN1uTRs0bZWnHY37ryYwaf3IrnUTudsJ7Vmcaa/smaRB0oKdl38KYAIpQgpz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097873; c=relaxed/simple;
	bh=GZipg7h6DWmPJaMvVMe3pCQLAKHop6MGFLjAdjXuVRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOac3hsusMiAvc1CEGtbi2hOhYnemhtYB5SlOP+dzBk/wtOCTNQJaH6Y/2li3e3XIKYZ3U+0CT6PgBxqxLLbAI3sR6oNvwRRSqevb0f2abcBV9BetTSPLzYCvsA2xlNV5CJHpNvc3H6GI8IdIUUkl7SIzQEZGLhSKDWkDMn1csk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AjB2TWVt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9Zpj1006041;
	Fri, 13 Dec 2024 13:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tPxQLS6L9qg4PnYBRfZP6c11YFbfwHkjvedsJyuKDtk=; b=AjB2TWVtbq4Wi6yS
	DXr232mx1W3zMm+inV9lI4wOSp4hQsPR+VADeE0LKseMCB9AUg+AUWvfpwG72J24
	eDO2aitGTyWOQqFH+hb2RZaSrfAWPV+DQML7Su8ydHUR1tuALesjFxC5kzy3N9XV
	NHK1nYJ07HVjBE3q8T+bx0Nd+mwxcNbePdeaSvqKp38PbEe1eRzgdh1Tw0Sjamir
	n+ridMYugHSUOvzbOhNotEJDFUHIKlW6vNUvCXgr+xoBOw1JuEAdAH+mBMMs8hU+
	NCQsvH90vl3fYnIF+FmrgSpZxc+4LUfdoRf7WAQNQvhUZyMLhRKVCKtLk0qGJrRt
	gRgHEg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43g6xutawa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:51:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDDp0F1014645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:51:00 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Dec 2024 05:50:55 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH 2/4] dt-bindings: phy: qcom,ipq8074-qmp-pcie: Document the IPQ5424 QMP PCIe PHYs
Date: Fri, 13 Dec 2024 19:19:48 +0530
Message-ID: <20241213134950.234946-3-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
References: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8K-98vrUQl7pTPSfJ339j17zbYxGDDlz
X-Proofpoint-GUID: 8K-98vrUQl7pTPSfJ339j17zbYxGDDlz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130097

Document the PCIe phy on the IPQ5424 platform using the
IPQ9574 bindings as a fallback, since the PCIe phy on the
IPQ5424 is similar to IPQ9574.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
index 58ce2d91d28c..f60804687412 100644
--- a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
@@ -15,12 +15,21 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,ipq6018-qmp-pcie-phy
-      - qcom,ipq8074-qmp-gen3-pcie-phy
-      - qcom,ipq8074-qmp-pcie-phy
-      - qcom,ipq9574-qmp-gen3x1-pcie-phy
-      - qcom,ipq9574-qmp-gen3x2-pcie-phy
+    oneOf:
+      - enum:
+          - qcom,ipq6018-qmp-pcie-phy
+          - qcom,ipq8074-qmp-gen3-pcie-phy
+          - qcom,ipq8074-qmp-pcie-phy
+          - qcom,ipq9574-qmp-gen3x1-pcie-phy
+          - qcom,ipq9574-qmp-gen3x2-pcie-phy
+      - items:
+          - enum:
+              - qcom,ipq5424-qmp-gen3x1-pcie-phy
+          - const: qcom,ipq9574-qmp-gen3x1-pcie-phy
+      - items:
+          - enum:
+              - qcom,ipq5424-qmp-gen3x2-pcie-phy
+          - const: qcom,ipq9574-qmp-gen3x2-pcie-phy
 
   reg:
     items:
-- 
2.34.1


