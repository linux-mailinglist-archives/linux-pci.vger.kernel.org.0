Return-Path: <linux-pci+bounces-28536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C2BAC76D9
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 05:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7869E03BD
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 03:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB532517AC;
	Thu, 29 May 2025 03:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BU57s/Na"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F59B248889;
	Thu, 29 May 2025 03:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491013; cv=none; b=MFeOfwvDHCKJitXFZP9+GB+Ki+vbg6KwGleyUEne15rpZNIWv65xK4YNuhfmWwuGyWilf8VwqTVYfSAIyH1viVhCg9BvdGxMP0IM8RRLy914go5qGrP2Ti5FuhF3CtsyLNsB1rFyS/G8VLn72LlfI2wDxpNzn4M6c0onQlZ6UNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491013; c=relaxed/simple;
	bh=8S87dL7VGVZIFCpVzkRioBOEP4iaxedu77qqLcdPqwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KwsbLfwbphi47xSzn4Z5wRqcPCgY87efdhj5mCXF4pvxLPK2odWGQBVPwkt5eDOpHu3Osno7Me+dSnkm2UtCgX5oZj2vVb8Tz9rOG0FnFurED1fExKbjrjTpMcKT56e7UUo5hONNkSFGbAHteouJcsZTkQsl+d75SfZESFuYxRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BU57s/Na; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SKVUjO009425;
	Thu, 29 May 2025 03:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GvTxz3Z4D3a
	LRnzzNQ4lYHjXXC24JvHhufSVlNc6BlU=; b=BU57s/Nahf+kpOYKm7t7xBcuhwQ
	UJ1iI/Cie4s9ofY1iDbGXBu2gF1ruJ6s5h11dPlxQ7UzQaAvr/WGABteMXejhndY
	zUCeAKXskrD6p3h4EUC4SOPz5otyWKi2M3T7TPvzi778qK3s0XGcyAEWXupsBYZL
	RVlFAk7jpSDfNGSg3jPqaz8AevfEP9b2hZsVzL9FhTGLjtl2jbrvwmssD1G1Opbd
	tItTvi5lH16pLtykgEnSxRkQ7BaJjSweC9kV9nFNdGG87qyNjMMo3A5Ec/0JiVZt
	C4/1+i5XDEqjoSetiEKRNN8NlzGbW4qqYCHxvOVUKqf7sx44fjvkvdWfJHg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x03mtkmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:56:42 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 54T3sLP8011620;
	Thu, 29 May 2025 03:56:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46u76mdpe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:56:39 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54T3udkP013251;
	Thu, 29 May 2025 03:56:39 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 54T3ucuV013241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:56:39 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 7ED563159; Thu, 29 May 2025 11:56:37 +0800 (CST)
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
Subject: [PATCH v6 2/6] dt-bindings: PCI: qcom,pcie-sa8775p: document qcs8300
Date: Thu, 29 May 2025 11:56:31 +0800
Message-Id: <20250529035635.4162149-3-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
References: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-GUID: SJA3BLb2cEP5ApnslAUV_SFTfLUssDuT
X-Authority-Analysis: v=2.4 cv=FuAF/3rq c=1 sm=1 tr=0 ts=6837dafa cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=XaXDgpzvQ4r-6u6QFCwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SJA3BLb2cEP5ApnslAUV_SFTfLUssDuT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDAzNSBTYWx0ZWRfXxUsK54SLnM02
 bczgfdiFwG/AggBdlI+dCF7vyagkKyzK2vKNdGHGXOp6peC6ruLd6Z2NkbNkme1bmZ8xk12nMBs
 yPZdVWq1vnlyE0/GRwX6JAYequsLAc4fgCu4S5vDNW7eV+TcWDTQegritHKmsds3+eb3GYXav5+
 oenxpHsdpttpmyVO2y7P69je/lEp2PJsWfsWUzh3opJlL0QazcfctI8MtfSuuyOQ8Fou+Lx9XkG
 7wMndFBWewoF8BOpGagHMmAJwoeA3UNNMyRI5mRLhKuj0i1ym36aXfrgmnqcw1IBQlckrKHiVoR
 WLz26CNKFigeF7BE1BnfPXrgRPvrdgmrBjIZFgp5ZlXsG/5QoUQGGm487O2/GkQgKVJT0lO8Iqk
 d9J+usRHWDAWuwdgpeij8iA+1pkP1mRqSKzRNMWm1FQK+KvVvwMcX6cq78y8MvHY0btCtT0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_01,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290035

Add compatible for qcs8300 platform, with sa8775p as the fallback.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml         | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
index eaae4195fe43..bca41ae72e6a 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
@@ -16,7 +16,12 @@ description:
 
 properties:
   compatible:
-    const: qcom,pcie-sa8775p
+    oneOf:
+      - const: qcom,pcie-sa8775p
+      - items:
+          - enum:
+              - qcom,pcie-qcs8300
+          - const: qcom,pcie-sa8775p
 
   reg:
     minItems: 6
-- 
2.34.1


