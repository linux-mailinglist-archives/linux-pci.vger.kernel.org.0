Return-Path: <linux-pci+bounces-19823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE09A11A00
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7ED31889598
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 06:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0960F22F38B;
	Wed, 15 Jan 2025 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kA4Pc4fM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1315223;
	Wed, 15 Jan 2025 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923700; cv=none; b=L9hqvUsKOX4OHyipW9OpF9LpfXYkjaHa2RMhNwzs3eMZAc9GWRd8DkSs/NjspNQB36wyzz4H4R6RPk4P4FxTic9wk7e94UXvRiFcQAeyLSL3pVH0NPVWoPKUT4I2UoBEgr4NCwT5tSUe+kh9oTctMWkz3a60xFru3Hs0fZiSu2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923700; c=relaxed/simple;
	bh=h0UbGpL2zRtLKy9BhFzjGnHOxg/JF/NR89dqtcEyJjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=db0GJumNUSlKe2O34A/Wy14b6hPW6DNvPCTTkrrpHkJv800ojG4MfU+taIUnQceV1AhhvOax9KS5U95DbsOmAm4CAiwyxpNauRJWxu82BSx+5V2tiP6rqTLQ89MRKYBfyqKYRTfvsSiFPiHzAY6SqscNl5Y2Z5ux8gvNxpSaPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kA4Pc4fM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F2rX3m019760;
	Wed, 15 Jan 2025 06:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	32k9MJzS1D9xuFGgdmXqIZaFloKzrJssHj9L2G+HVXI=; b=kA4Pc4fMJmIaLgrS
	ysLAIgB7nsoV9yZLyogTTrSXZ8mzjUtXgSKhDTpWNko17WdnypBIi5cyaNKLKNod
	jW+5SxinMR/vzSsidYBCBmnXcx4OBw6OS++J7lN6QHm2zYjbeUzQNmnsKC4Z+nnC
	uY71YQeD8e+Lkd8nPXyBdndd/+z73GHkXD96OCZluBLddEgAV/hAANANb2Eas8S8
	8esD6b65cCwpwYK5etXmfg4ZfT77Kfm/1RliIvDvtVmGLTvrPMo4Q19pWANNBuG5
	HBS0PsvGTJPc1D64jYkKdCz63C8frkjgbPQKhjHyEVEwiWtYvKTfawrZB6iSxNNZ
	eIw6hA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4464mtrfbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:48:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F6m7gQ005250
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:48:07 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 22:48:02 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v2 1/3] dt-bindings: PCI: qcom: Document the IPQ5424 PCIe controller
Date: Wed, 15 Jan 2025 12:17:45 +0530
Message-ID: <20250115064747.3302912-2-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115064747.3302912-1-quic_mmanikan@quicinc.com>
References: <20250115064747.3302912-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rExKp8rmMWsclvGvWwoNmvjYkHRQApQK
X-Proofpoint-GUID: rExKp8rmMWsclvGvWwoNmvjYkHRQApQK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_02,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150049

Document the PCIe controller on the IPQ5424 platform using the
IPQ9574 bindings as a fallback, since the PCIe on the IPQ5424
is similar to IPQ9574.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V2:
	- Pick up R-b tag 

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


