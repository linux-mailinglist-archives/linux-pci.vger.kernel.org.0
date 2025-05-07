Return-Path: <linux-pci+bounces-27307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F540AAD3BC
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 05:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E5F464CAB
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 03:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB59C1B4236;
	Wed,  7 May 2025 03:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EPMN3Lz/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289C19CD07;
	Wed,  7 May 2025 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587440; cv=none; b=cgaDZjlNDJTFf3S/PpHM2Jk3uHIbDT0uIYEQs+ixiVt9GWVQP3i5QFb/HnU5yxDz+nRI0TF92Ed1cDRzV12bMA5z+J5YLtkZ4bVjqzfHbIS1QUkE65RS5bUlrZs/N6mIYJh2uqxFzAZSkA+6ZoPNsyuZrtA6nj1Zy3j4rIByO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587440; c=relaxed/simple;
	bh=iy2QIfjS/1fL1YdV0dh2vv9G5cktcRLnWRZRRuktFgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwOdaWniDZ0pwekSjtvTITScIurP8qYrYIXnHsMDLuUpI06xTi92yHhEcWaKLOzOMjyaC+Fwa5YOlSrXrLV7/DLiBKZ5w1976LGe13Nyc51CRcG+DKHzSEIwKUlMWSS/x8sdvtoqz1v+4m6nxdZh35PyacyBuLzmAV/bWDf1DWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EPMN3Lz/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471GvaP021991;
	Wed, 7 May 2025 03:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NehKGHnpjn1
	Q6VEQzNURH9HW3M+bD/GZ+/LCmQdSxY8=; b=EPMN3Lz/8wHMen7BACuTUUfB8X2
	ggpeLU5i4fhttgJUUt+RUOFDy/IhBQqDcyDlR/bw8m5twWYFiVVLYLVOLuMjRV1l
	S4DU8GZ76Fr2h8SnRSBlxnzIocDV1E0ifo+P9rEPJn6P5WFsYJMXflZ+sAS5jpT4
	l6D2qixezguakTWKri6KdsPnBBOwSoJlyUQ+8dNoBv8YaKv5SuYtbwZL2m+0C5CN
	kHENHP/h/JLt/0l5bwRJOK8UCj97G/tw8YrMGwVDP9yI7ZaZIAS3VRRLcz5sVdfr
	TziLWujeAIGnl5LoP6VfoPu/7pX1n7/JQNSLXqgOq58+9w5mHQrepo8kU0w==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5uuv9w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:10:27 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5473AOhK006128;
	Wed, 7 May 2025 03:10:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46dc7m5ysj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:10:24 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5473AOXP006122;
	Wed, 7 May 2025 03:10:24 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5473AN1g005947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:10:24 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 72E452F3D; Wed,  7 May 2025 11:10:22 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org,
        manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v5 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings for sa8775p
Date: Wed,  7 May 2025 11:10:14 +0800
Message-Id: <20250507031019.4080541-2-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507031019.4080541-1-quic_ziyuzhan@quicinc.com>
References: <20250507031019.4080541-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=L9cdQ/T8 c=1 sm=1 tr=0 ts=681acf23 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=tAWiX01tdBucjzfsbJgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VqHZ2eVrxvxyoPqdSm3A8yLEwzOQgqY4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDAyNyBTYWx0ZWRfX7KeMtdaP0OJD
 ryAwGYeA5T/VvbsIgppzbgheZrT20myfJ8idtoSFNOhRuyGTuGUDYDVVKJCCnKbYD7hzFhp02w0
 0DaDOZa59PI/aVyJ24TLN9Xjwp9I3MgNQR/mV0XJkrvr9G/6lDG5t+sAgqVNI6wuUEUnwqOVRzC
 eMQRa7RdHI+A7iRh+v3V+uRYo8tSZN33P/Bamp2sCJ/U16cFmteoFuIn/Xw4L+Gz4ZSx9CIplrC
 Yc+iOaBMtHZmEcc/SfmVJCQAq+zabNisMOsQW0P5tsLrSSoy2U1lmIaaFnRnCt62ZIhWYKQXEq9
 0yxai5jKSmswk6zSZrm5HtJ19iP+dGGsfENhi3NUGcUUVMuCLy44Z3ythzgeb6ihAm3OiQAJ0pf
 Ty3NFeNvDwvUYBmLSsLP3L+uoFnT9EWU3Gv+SqBZfa3+3tMJ8OmiJb8Dga/NB91AIOnAcfYo
X-Proofpoint-ORIG-GUID: VqHZ2eVrxvxyoPqdSm3A8yLEwzOQgqY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070027

qcs8300 pcie1 phy use the same clocks as sa8775p, in the review comments
of qcs8300 patches, gcc aux clock should be removed and replace it with
phy_aux clock.So move "qcom,sa8775p-qmp-gen4x4-pcie-phy" compatible from
7 clocks' list to 6 clocks' list to solve the dtb check error.

qcs8300 pcie phy only use 6 clocks, so move qcs8300 gen4x2 pcie phy
compatible from 7 clocks' list to 6 clocks' list.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 2c6c9296e4c0..a11a7e78636d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -176,6 +176,8 @@ allOf:
           contains:
             enum:
               - qcom,qcs615-qmp-gen3x1-pcie-phy
+              - qcom,qcs8300-qmp-gen4x2-pcie-phy
+              - qcom,sa8775p-qmp-gen4x4-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
               - qcom,sc8280xp-qmp-gen3x2-pcie-phy
               - qcom,sc8280xp-qmp-gen3x4-pcie-phy
@@ -196,9 +198,7 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,qcs8300-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x2-pcie-phy
-              - qcom,sa8775p-qmp-gen4x4-pcie-phy
     then:
       properties:
         clocks:
-- 
2.34.1


