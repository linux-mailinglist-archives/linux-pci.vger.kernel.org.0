Return-Path: <linux-pci+bounces-18373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9813F9F0DE8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 14:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E9416BA7F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAB41E377D;
	Fri, 13 Dec 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M8pBhzFw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFDE1E0E14;
	Fri, 13 Dec 2024 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097867; cv=none; b=daV/8+Eco5oOnnPPy24qPbmZFWATAX76XRXq3rQ4TxENQcVi8AdzS96+2vmuD3DdC634RnGZwJkwpeNw+0MFJvNSwPuuoa3mvDCDRu0LLuLz8NGCHx4l/qG+nTjrxV3nOd57zpRgrmgWUbMhyE+tNvnPInE/kpE2TON++JgBKWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097867; c=relaxed/simple;
	bh=kg80iHIkfnTvWJ8P90iS8XXWorU1KDIsgaJzHwbgCi4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5NcXws/JOXfa+fX/AONS//mhe1dOKT57Y3/cc/YpY8K72yNQ4Xd0i/sHmGrqvgZ9KCZ5uprR1LkJMY6iO7vjly3bZJA3acuTut+yhNWt3K5t8NONwP3ZTsFvCc7Ti4dVOxZnSxpBViWWLekjpcHrCugG4ERSHJndDGnKLS/qZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M8pBhzFw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9YOST030103;
	Fri, 13 Dec 2024 13:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QwfHL709hjYvebFXtvJZRCl1+T2RDth2+zGbAUeKvUI=; b=M8pBhzFwYjsGmmdH
	25AC5Ntf+iK9SzZv3cZ0toabhkQgFjiKZlK5Li9mdSZoFUENvXEg/Ylp2HYCYLY8
	J2gfbgv/RyFfg/QDTnVRzbbx//qTL5gy0ZvRT52U3hGpa6SDnBB39cHtobJ7zBKf
	xutLlCLZ90bwKnOtoA1mJ1st4Mpqiagq7bac3c8bTn3Othu4SrznI89oAVsmcCtJ
	QVDKyK6Dp4aZRvgEtQ+iXPQo2FX5ch1Yx49vLPXE/YnKVLahwWfxGF9Ge9sEV0Eu
	89qK/RN6v3rQW1fbBKlrnZPF4B3XxjagtH7frLoS/sXsate/VMM1HjgvTy1hC4DP
	ypvLhw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fwgem19r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:50:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDDotDR003148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:50:55 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Dec 2024 05:50:49 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH 1/4] dt-bindings: PCI: qcom: Document the IPQ5424 PCIe controller
Date: Fri, 13 Dec 2024 19:19:47 +0530
Message-ID: <20241213134950.234946-2-quic_mmanikan@quicinc.com>
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
X-Proofpoint-GUID: vw-LJath-oUZpfF83NX0gr8rJiJEH_q9
X-Proofpoint-ORIG-GUID: vw-LJath-oUZpfF83NX0gr8rJiJEH_q9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130097

Document the PCIe controller on the IPQ5424 platform using the
IPQ9574 bindings as a fallback, since the PCIe on the IPQ5424
is similar to IPQ9574.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index bd87f6b49d68..7235d6554cfb 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -31,6 +31,10 @@ properties:
           - qcom,pcie-qcs404
           - qcom,pcie-sdm845
           - qcom,pcie-sdx55
+      - items:
+          - enum:
+              - qcom,pcie-ipq5424
+          - const: qcom,pcie-ipq9574
       - items:
           - const: qcom,pcie-msm8998
           - const: qcom,pcie-msm8996
-- 
2.34.1


