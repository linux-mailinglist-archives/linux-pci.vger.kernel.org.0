Return-Path: <linux-pci+bounces-40973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01416C514C1
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 10:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7652B3B8F50
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEC52FF170;
	Wed, 12 Nov 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PplWNV0P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6902FDC5B;
	Wed, 12 Nov 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938217; cv=none; b=Xc4D2AldCeK3Vtfl+jFCidCxa+TqT4a/RFJddQIxcdvzbf1tNmnqMVrq+8LKqyUWuk+7sJv/+H5DU2M+MywzXBpEI0lRpaKDjTBcEQcVI4T4jiesgcE8NcoCUeDCSCnxvRXelFwfMufBU4PePS0hpPbs1NNTNvsP6CLgibxbNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938217; c=relaxed/simple;
	bh=7tURlJM86yJH4vMqghem7Jsbv4a+GRg87gUdHWRlhqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CQAG/3s6ni78d8Yioq8F4h2h3ZGut157AWIBy7HKgcBcLGu6yTJZlJ0hZth7NQz+zPZaCQ6YS8l4Xk7WLPkSKQqTSPEg1WymdpKo/yq7ukgSV3XvXpfXLbRjsPcXqdOrCpiu9U8KKOHribViJegyTbJsNGTDhu7vsHbKhQg+yNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PplWNV0P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC8ndr14006241;
	Wed, 12 Nov 2025 09:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kmp/UD49T+mMXHBhn6G//elyFU+oJ4daqAG
	JIwEP9CM=; b=PplWNV0P7iwhJ6RzivUM35cViADNGkgEsrNI5sQMenUqGWrzFXc
	8kg2rkg4iUNmXJiRDheeTSQWQv13scIEeWFWAvhL8mQOmUd0vHKDu4ACZY7H40VF
	e9xS1iiROiHm4JgcFfn5tHT/YCCjGihoIOr8Oqy4qdbCRPtamd5qvHm6clb8xQPv
	qN4vvNfdyR6Zo/PR1j0CvapqdFA1KrOvCzEgMWc66FKf8+xu0E/BU7QbZMKCf98s
	i7iIDN8V4mYGPxIIcasKKvBQKvLviZkSv2ZpCrd2t+jtKdwCowuV/y8IHerP3uc2
	6ucnweTIsEd7u7dwaZuKj97JF8x7g6XXgEQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acg5bh870-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 09:03:24 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC93LG9012295;
	Wed, 12 Nov 2025 09:03:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4a9xxmq754-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 09:03:21 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AC93LQ5012283;
	Wed, 12 Nov 2025 09:03:21 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5AC93KOW012280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 09:03:21 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 716EB77B; Wed, 12 Nov 2025 17:03:19 +0800 (CST)
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        krishna.chundru@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Add PCIe3 and PCIe5 support for HAMOA-IOT-EVK board
Date: Wed, 12 Nov 2025 17:03:14 +0800
Message-Id: <20251112090316.936187-1-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: TrRre4cN3kxxGOAdTY9Db1hr6cDmKmIY
X-Proofpoint-GUID: TrRre4cN3kxxGOAdTY9Db1hr6cDmKmIY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3MCBTYWx0ZWRfX5vM68VZECLi6
 fGMuSV2S1Gxp6zmGivhzENv0KKxNWz3+AGPJRvRgNadpnWfV8QSbM+hPpnZzQrSqo9LN7NjhtoN
 ybnwwabPjBup0w1luyKfskRXXjp9QT6r38ZI2AlIPObyeSsXkB6xmqmy6AsjTpzch0E6/b3lSAI
 88ZoUkN+L8Lh+wg+e0DOpAwGyyfAkLTHbD7+TJsoKnbCoIhL+yFmAbw1qz8cWW9rExmFaAqmLOA
 9xpRUjXv0WZ2Hc5w+c0pKwLOV1dsh0Bi6drziXPEqKth4ldCArEWwmR8d3nU1nW7VLo7hNrI/+l
 7XYGLg+u6p2D7Twmln10hsqlNeu3liWAg4WsScRiQp0SrvoULciQkBqqnzYh3Olk0Y3iTwA/dU4
 EH7L2XuwX0GpPdYKso0H3YJ0PHrDKA==
X-Authority-Analysis: v=2.4 cv=YYawJgRf c=1 sm=1 tr=0 ts=69144d5c cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QeMu0tCiC60fgC08giYA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120070

This patch series adds support for PCIe3 and PCIe5 on the HAMOA-IOT-EVK
board.

PCIe3 is a Gen4 x8 slot intended for sata controller.
PCIe5 is a Gen3 x2 slot designed for external modem connectivity.

To enable these interfaces, the series introduces the necessary device
tree nodes and associated regulator definitions to ensure proper power
sequencing and functionality.

---
Changes in v3:
- Update commit message and DT format (Bjron)
- Merge PCIe3 and PCIe5 changes into one patch
- Link to v2: https://lore.kernel.org/all/20251030084804.1682744-1-ziyue.zhang@oss.qualcomm.com/

Changes in v2:
- Move PMIC gpio pins to patch set 4 (Krishna)
- Link to v1: https://lore.kernel.org/all/20250922075509.3288419-1-ziyue.zhang@oss.qualcomm.com/

Ziyue Zhang (2):
  arm64: dts: qcom: Add PCIe3 and PCIe5 support for HAMOA-IOT-SOM
    platform
  arm64: dts: qcom: Add PCIe3 and PCIe5 regulators for HAMAO-IOT-EVK
    board

 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts  | 83 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 79 ++++++++++++++++++++
 2 files changed, 162 insertions(+)

-- 
2.34.1


