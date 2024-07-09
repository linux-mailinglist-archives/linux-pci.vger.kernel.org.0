Return-Path: <linux-pci+bounces-9999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F0392BD85
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 16:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5581C22E0E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198C918FDBD;
	Tue,  9 Jul 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dspl8lMR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A61E864;
	Tue,  9 Jul 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536855; cv=none; b=LjJ10VnHW5mwSFcQjpP+4/0AwXlrkgIw5KXcDPuRTDblihxuk7lvadzWu+sN7u80MgIGfNWdBSZtovTpUL1oHqEl0zRe/iVZFLDM8SQBAvGy3qo/SSQw6cI7AvZHpwOCeSNM66kHmzq/osciT/yf/IaDf8+S5SFvHVH5CC6I9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536855; c=relaxed/simple;
	bh=oAUhPtcZ0FUV5xoeA71k+/wIZLEOdCXNurgZIHXvnKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aHzt9cR1CzWJwen0Cr4B3D665BZ5dlD/x6d7Ofk91NVpCEfD+Lhb2LlOyLb7uttME5Z5CpLqladst6rtEbJOFAjEoQEF8JwRYUTEOfjRb2uw9E7DolG8rk1KdLkyeZILaycbhHZox3izNA35MRsSpIG6dNxurnVuFJ2itCsLmTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dspl8lMR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469Ah5nk020426;
	Tue, 9 Jul 2024 14:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	otF8zgKHb7fx/Ai4X9xXwiyDJmakSRghKVOBUjZhzuA=; b=Dspl8lMRzkB2TAzS
	MoHWst/TlEQ7RYZnUdmCsu9Jz26/bLzLxzMz0a+5YNrsWjvc5mQmeYRZP/CsWCF8
	+oujsPtHRUv/8pQMNu5G1Azlg4BMsXs2D7Y0wmTXltYqWkGFTQnn7gt9+07bihKU
	hjsi845s+HLhO0QXBSOLadolh0qu26Rco1qfA1tlleGwR/Zg/iLwYodEzdxZcMF5
	rQPQbKmejCmkeJ4LhwR3/vDrdwbyf8E5mJay2fAuVJ5LNCUrzWatpGK52c42iU6C
	j2ItXo8oChyNprh0VlWqn5pGu8LYvFgihkud76O7Aap4p6EmHtdICtF0TKkd1Z9P
	3UPpZg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xa66ps3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 14:54:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469Es39h022682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 14:54:04 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 07:53:55 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Date: Tue, 9 Jul 2024 22:53:43 +0800
Subject: [PATCH v2 1/2] dt-bindings: PCI: qcom-ep: Add support for QCS9100
 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-add_qcs9100_pcie_ep_compatible-v2-1-217742eac32b@quicinc.com>
References: <20240709-add_qcs9100_pcie_ep_compatible-v2-0-217742eac32b@quicinc.com>
In-Reply-To: <20240709-add_qcs9100_pcie_ep_compatible-v2-0-217742eac32b@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <kernel@quicinc.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720536832; l=1307;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=oAUhPtcZ0FUV5xoeA71k+/wIZLEOdCXNurgZIHXvnKc=;
 b=oilqxqn2muqSlMy5K0dHc+LpyB2djSuOC0D1u5hOndfX1sCLK0yoy7xpqMvVLiONonE/3YLJ+
 4ES3evUVI6AA6b59F1ZV9VBbjH84jG4eDMUFJrxe+cFnJTNkNsuOo2B
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3piS_-ABQ97feVsMKrZ51UqTsEy7NNhN
X-Proofpoint-ORIG-GUID: 3piS_-ABQ97feVsMKrZ51UqTsEy7NNhN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=667
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090097

Add devicetree bindings support for QCS9100 SoC. It has DMA register
space and dma interrupt to support HDMA.
QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
platform use non-SCMI resource. In the future, the SA8775p platform will
move to use SCMI resources and it will have new sa8775p-related device
tree. Consequently, introduce "qcom,qcs9100-pcie-ep" to describe non-SCMI
based PCIe.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 46802f7d9482..8012663e7efc 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,qcs9100-pcie-ep
           - qcom,sa8775p-pcie-ep
           - qcom,sdx55-pcie-ep
           - qcom,sm8450-pcie-ep
@@ -203,6 +204,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qcs9100-pcie-ep
               - qcom,sa8775p-pcie-ep
     then:
       properties:

-- 
2.25.1


