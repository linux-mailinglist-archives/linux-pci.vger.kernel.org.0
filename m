Return-Path: <linux-pci+bounces-30573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ABFAE7714
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 08:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB2F17DC20
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 06:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614AA1F8755;
	Wed, 25 Jun 2025 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WtYfPiiK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2BA1F866B;
	Wed, 25 Jun 2025 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833163; cv=none; b=ZkxnO0V5F8Isn3XmWY6d8GwknDLkAPKFlnYrgHc/cA96Er6Htz/9Vv70siBCe1QR8mNPtMRrpXtEHp6jEmcpggQ2NwlqzKmB8UefxVS2FBAajx6faYAwf5Ob16o4Rtd2Fx6SWFwcJU7H8EZpxia+XU1McAE71CZkoFpRXOFdWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833163; c=relaxed/simple;
	bh=fRKEajYsrjEETd0CV9CF87Nd+bCIvmN7rl+y4Q2rXBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPGcZmlZoFb0i53MeaZMZoNMH/5hVqIZKjzLXKHRQIwkl0TRQzEMQ/KS3ckZNzDUHHK1CuMkFTQavrlHtO+tidhuyqmlXPOqzUw9+pxMpiwm+q/4JAGh0kYlmIPjZgdYqHLT9AQ1WV6lzyNX0dU9nJtGGUhIMXS3745GaevkK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WtYfPiiK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P1pHBU001125;
	Wed, 25 Jun 2025 06:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ko96WMYCjhf
	nkHlSLv3qudWFvcVqQt11yvW1BUhMEyg=; b=WtYfPiiKKZFqiQOcLYOY839edLm
	DDs3hGYp7wPrpFJ2WG8l/dknJzwYoqtyC9LS2uHvSqt9Y3DwTXonVXwkjtFilehy
	QN416a6ZSKp8INmn8m4qFYOFXX5+/MQVMfWBY6fh+UQ/u3zGiRbtKmzLOBZrI0WA
	/xPydMP7VHIolhmknJ9jKo8sknxuwkNAjv6cfj6nFWoBQ07ut/ST4Q0LJUuG1nQN
	B+3Ur5gtKGxJRv150TIUXazd04ewroDPKH2aBnIYwwU8aSa9yD7ICwqVH2EBQ2z0
	cVQuvdr8cpY1FihWHCeGtQB5cuPNfOSWx53gFisCg4QPAQ++1XgiuZB7kRA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g7td8k67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 06:32:30 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P6WSUK029375;
	Wed, 25 Jun 2025 06:32:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47dntma48b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 06:32:28 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P6WRK1029360;
	Wed, 25 Jun 2025 06:32:28 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 55P6WR8o029350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 06:32:27 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 04B263835; Wed, 25 Jun 2025 14:32:26 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v6 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings for QCS615
Date: Wed, 25 Jun 2025 14:32:11 +0800
Message-Id: <20250625063213.1416442-2-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625063213.1416442-1-quic_ziyuzhan@quicinc.com>
References: <20250625063213.1416442-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=CPYqXQrD c=1 sm=1 tr=0 ts=685b97fe cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=oxzBFytuHnZbSq-PjLoA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA0NyBTYWx0ZWRfX1iQtwp72NeyK
 q83f0VKpUBQGpnmybEonumJe4YRQ1awPDldHspZyg4MHARr51CiX1Fh2VeWxZNqioBHd5ggjfIK
 ZvfCu8sRakSFZDJ4kCwrjHnVO3drJqOLjeKRK+hPNkBL1BXAGasNIxiv70Ljv7x1xOZQ5BOLiGQ
 uZgxwMnI8loSnPr+yEBaPle9hz778RJBAIm5klW+7b2IvLnUvLByEluM1ZukorU64CpfRy1DYYJ
 pbxLEmumCI+P0xUhisGVofMNr3ZGx0YHi9xZ7zWCGiaB46WFcNJTsFjXZFkgVzm/LDyka/xijfZ
 HuGI0uj6VjcyUJqZCl5TyXbMAe8f8xl0sUf8WM/1YMWqZBSl/6uf2a1azRiNAK1rcgoCjHnkRAo
 Ra4l3HnoVa3Mb/TktHN5SQBqJ8N5962yziQvK4pPoqXWhgXd6j+jqCDTM+asZKOD1Vbfdk/d
X-Proofpoint-GUID: cCDw8hKUtLMS-FKduVj31CqRnEB0WNMC
X-Proofpoint-ORIG-GUID: cCDw8hKUtLMS-FKduVj31CqRnEB0WNMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250047

QCS615 pcie phy only use 5 clocks, which are aux, cfg_ahb, ref,
ref_gen, pipe. So move "qcom,qcs615-qmp-gen3x1-pcie-phy" compatible
from 6 clocks' list to 5 clocks' list.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 2c6c9296e4c0..a1ae8c7988c8 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -145,6 +145,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qcs615-qmp-gen3x1-pcie-phy
               - qcom,sar2130p-qmp-gen3x2-pcie-phy
               - qcom,sc8180x-qmp-pcie-phy
               - qcom,sdm845-qhp-pcie-phy
@@ -175,7 +176,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,qcs615-qmp-gen3x1-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
               - qcom,sc8280xp-qmp-gen3x2-pcie-phy
               - qcom,sc8280xp-qmp-gen3x4-pcie-phy
-- 
2.34.1


