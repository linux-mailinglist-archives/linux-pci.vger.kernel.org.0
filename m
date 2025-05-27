Return-Path: <linux-pci+bounces-28440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D8CAC493F
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 09:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F70B3A7BBA
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 07:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B43C22577D;
	Tue, 27 May 2025 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IJIU7FfX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1871DB551;
	Tue, 27 May 2025 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748330456; cv=none; b=jC/Ap8Ctv63oz6idkj/bYc8uugHb0TA7g9nFnWDk1Ru1DeAnbpB95RFGjAcidWizO/eI3Afq6N9/2IgRNd4jrmIkc8JRKh8ZEi06CuIzFaQAfWCpWPtnsaQ4zcEvLGFeX8vVi4GjYngne5OAkSR8Dx/A9r+Sx+MOMu5+xSHTmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748330456; c=relaxed/simple;
	bh=hDnMdFE0TGRxhKLJZcX5dp/dTYiPzjGYmoRu0+VNOWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TM/zyt3eGyk+WiqKrBnzsr/2XMPoJj+4ibo+aFKN/W7yuWmsxpKPWDTbX+sIzkaVuQ23RaW3Z61DG76cALBOLfcnVg7Rwj6wpoOyqeUoUc744FI4zN+FCzeTf2Fm96bei+0foKtDgNeeaODUFRCWIYQ0QraFYK4yte4bTU8vP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IJIU7FfX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R2o2YF003591;
	Tue, 27 May 2025 07:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=13qF7ZLOMAO
	9XoWt8DDGVjNGLqSpYPjsO3tOVtrFstg=; b=IJIU7FfX65l2tBqxFWn1s5n2IuO
	j0Y5WX8mzjjEyTneqBAdPDqbrnllndBdKp4Exuu4NVbA4WaUkVjkwOJhsLx7JU/o
	I9o9iyQruw2+Y4ZGCmHbPn/ZHkH3y6shJ6JGToxme5UBi8+szAdLB1mcroojxXIu
	+ivkxMxFNODVDp6Mpb6xjNMddZg8KpPEvS6WhRUO1pm/Qn6rwDhefqEqF9zyFoW/
	OERCPALQo5TojRNL1iZcYQdhuayL3mdiehxDyFwLPI2VgKUx10Y5lf3sG0foPZsk
	lvMQuBDi+KE97B80wEXokSqsOU6bFZfrBssuWH/U0a4FCvhf6/KEgwwlGvQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u66we6d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:20:44 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 54R7KfLh031390;
	Tue, 27 May 2025 07:20:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 46u76kypst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:20:41 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54R7KfgN031377;
	Tue, 27 May 2025 07:20:41 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 54R7KekC031367
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:20:41 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 722683502; Tue, 27 May 2025 15:20:39 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
        krzk+dt@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v5 2/4] dt-bindings: PCI: qcom,pcie-sm8150: document qcs615
Date: Tue, 27 May 2025 15:20:34 +0800
Message-Id: <20250527072036.3599076-3-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
References: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=aYJhnQot c=1 sm=1 tr=0 ts=683567cc cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=HC48MwHpPFP3ZpptyjwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: d8Wkmteai1lqEl-rSpSPUd9-6vGR48wi
X-Proofpoint-GUID: d8Wkmteai1lqEl-rSpSPUd9-6vGR48wi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1OCBTYWx0ZWRfX8TgHIIC7UnnV
 FBcEu1sAm5DFu1E/81eSsgBTYBwjBaUUADie+pxAguwjMYw7nnWaFLGediRwlgVmf1WMXepIdFt
 0ejrARWUuCJbPIRXmG+LJCrWTNldr1CnKUQl8eJDlgIGazSjZRY1iS436CFEfnExfVqZY441/Ld
 0790F57AfZgbKrj9GSpufsI5V1A4kAHGsj4mI4rozFIczWvEHYpzUYWJE695Aqd7+oNa6fSwok/
 t3giC/JlTTX8KMhgLlPqckNPu/y186ImJ2FHOD26Ksa+g/CNMg8NTo6wdwA4o12aH1tMsSjv9Ay
 Qq0Qx+/DM6nSQn95HeC4sy1vIaJ8K+fR4KjFQB1VevZK8FeIvReHmesLtqt9Zly+3+ARPN7Zb4U
 6Uw6Vxs8N7aJyscEK7KaSQNxDhK3w2UAEnk9TC0r+UhcsjCD3T4Ltd8X/eMMK4pWqCi/qpGf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1011 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270058

Add compatible for qcs615 platform, with sm8150 as the fallback.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
index 434448cd816a..26b247a41785 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
@@ -16,7 +16,12 @@ description:
 
 properties:
   compatible:
-    const: qcom,pcie-sm8150
+    oneOf:
+      - const: qcom,pcie-sm8150
+      - items:
+          - enum:
+              - qcom,pcie-qcs615
+          - const: qcom,pcie-sm8150
 
   reg:
     minItems: 5
-- 
2.34.1


