Return-Path: <linux-pci+bounces-23584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A31A5ED8B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 09:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C78E189CF6B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 08:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BF4260363;
	Thu, 13 Mar 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IfPy+HpH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C019F78F37;
	Thu, 13 Mar 2025 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853191; cv=none; b=CPIV7m87cjWJkwlLrWZ1kVe2cUAPlGX6MCs+i6Pl3BRyTBavy/jZ1KiKrerGlQNS6QNddKzGDb9ZPl8lyE+temndKIqy0FhxWBeTTNjJTBd4gn/266YI6w8Qqh0LWGTUJhb0ezEadNtgAgmHRxGji61xyYuQuBQ8UqxtUEkPZ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853191; c=relaxed/simple;
	bh=rzi8DZpEPDxoGdyV+WJCzI8Kf6JXzbbVwFv1xsj4W9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5k/RtQ06RwqKp770pvn0f2xXOncZzQ6DqZyqNxO7lrLBEkLaMgeRzRfynkwjrfkPM166i2M3C5FGICosKWnv0fmeWYy13U7CS9df56XnCFF5yWUwU1akCZk2CXpXG2U9aIDoAGb4k/hblCtz54QFoyxLpR04maaBxGGQ42H1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IfPy+HpH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D02oJo005526;
	Thu, 13 Mar 2025 08:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EZztCWBM8yG9ILGIIl9ucZ67RxfIUWIVNdS8FEJqp3E=; b=IfPy+HpHPsLL4/V9
	h03+UmN2g3FnZOrI8XZz8sr+8zgBbj4m6LrPR6CrQV+2kAiqlco6JLvPl+E+/MWx
	4D9mKS7l2u9qC0byGx+0D/1IU1MHStw67QyOUCfqKVNnHZh+1kGzeZ4vasI3tpG6
	JMdXdTlvc+yJMbGPPI03aorxGf9Hdv9WD77jf7rqi9kQBFiu5mlvQCr1H0lRnzto
	e2RYdtRNIghBRo4uAYJ0MHKLOJvanQlDsZYWANJJySJ2bYvpfBzGvamh0pczEDos
	n+q1RpqmnmwYzLSEeg04eBqK1f3jKeFbntDfs1d37AH5fBUVoAHgIdB0tJro8PbV
	xqDD7A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45b96yayqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 08:06:21 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52D86LrK006924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 08:06:21 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Mar 2025 01:06:17 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v13 1/4] dt-bindings: PCI: qcom: Add MHI registers for IPQ9574
Date: Thu, 13 Mar 2025 13:35:57 +0530
Message-ID: <20250313080600.1719505-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313080600.1719505-1-quic_varada@quicinc.com>
References: <20250313080600.1719505-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: GKugHKtf172Ua1m53wF6dmuAGy0LrYHE
X-Authority-Analysis: v=2.4 cv=I+llRMgg c=1 sm=1 tr=0 ts=67d291fd cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=SybdbZUrytBkLZyOo90A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: GKugHKtf172Ua1m53wF6dmuAGy0LrYHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=741
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130063

Append the MHI register range to IPQ9574. This is an optional range used
by the dwc controller driver to print debug stats via the debugfs file
'link_transition_count'.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v13: Fix 'minItems' for reg-names.
     Update commit log
     Remove 'Fixes'

v12: New patch introduced in this patchset. MHI range was missed in the
     initial post
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 8f628939209e..469b99fa0f0e 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -175,14 +175,16 @@ allOf:
       properties:
         reg:
           minItems: 5
-          maxItems: 5
+          maxItems: 6
         reg-names:
+          minItems: 5
           items:
             - const: dbi # DesignWare PCIe registers
             - const: elbi # External local bus interface registers
             - const: atu # ATU address space
             - const: parf # Qualcomm specific registers
             - const: config # PCIe configuration space
+            - const: mhi # MHI registers
 
   - if:
       properties:
-- 
2.34.1


