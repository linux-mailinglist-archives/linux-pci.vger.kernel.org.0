Return-Path: <linux-pci+bounces-28532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E10AC76C5
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 05:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E619E49C8
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 03:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13B2522B6;
	Thu, 29 May 2025 03:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BkALzi+B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA051248F57;
	Thu, 29 May 2025 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490876; cv=none; b=L2svgzwkx96AthpfvXLkBVFcuXg/QmlWHZc4p+MCh2H6A3c85aR3sYEE4jn/vmWm3ZqqsHCr6aWoqgcQkDohBubimD2IJJau5SZe3C/pQ1e1ALlZplT6eHJb5qlTDYN+9SeMaLpmFbnSSHZvST0PLMGVitUFrPNRQcghnqqvcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490876; c=relaxed/simple;
	bh=P51RspfzGpdHpBrfvugI3IiiMtsKcraElLsLNaeJz80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t3UP5zLIPEZqzQRE7YqlKb8k3cteBF1JyInomIShhc4mECu9sga1tsmW7Li92rBx4uo2ECMBtfuFMhpV4JyupI3l+yCIvmgiCbnrepm9RzTfzys6KfWVuQbDZJ7gyiLKNvd9VpgJx64ah7pzdRli7b9YM6UbuecO9ifPioOoVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BkALzi+B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SJAJQl005112;
	Thu, 29 May 2025 03:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1G2vijzDb6ASBTZNBwxt3G7LThp+7H8Yhyj
	ZoGVmMpg=; b=BkALzi+BrUtJaA9Q0qee+6ZSX8Q4Ki3E2kuDjbp5tuDpjVuVdtT
	5q0vaWG9TAOqZC9DSTT+qxCDyjw49Ap5l55zNQn1fLjAb2Ug2emHiquR5yYt7OOI
	3/Yj1OlY4vHIzOBTUt4F897fZAWlnPliUxtRCABnYFNJib3uiX4PnNegsJDcccID
	VCbs2AmLAt6o1r51O9NJJ9X6rwo8ONRfUug50g9rUJF8VJQLMmSHqgIMgKg1omvc
	luvOp6T1p/BdAGzyjF2zaXPJpKTOH2YhxA9T0Rr148AZA9FlCH9fz+2mY3jxkfYB
	MNSbxKS2e3cWNTHvX8swHVMtfoSAdOZnHkA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x8d7920m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:54:23 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 54T3sKRf011609;
	Thu, 29 May 2025 03:54:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46u76mdp1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:54:20 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54T3sK29011592;
	Thu, 29 May 2025 03:54:20 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 54T3sJjV011587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:54:20 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 5F6C83151; Thu, 29 May 2025 11:54:18 +0800 (CST)
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
Subject: [PATCH v1 0/4] pci: qcom: drop unrelated clock and add link_down reset for sa8775p
Date: Thu, 29 May 2025 11:54:12 +0800
Message-Id: <20250529035416.4159963-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-GUID: w3Wy0xEt0JrtV_tt5G3n9cJWMJg4-yDg
X-Proofpoint-ORIG-GUID: w3Wy0xEt0JrtV_tt5G3n9cJWMJg4-yDg
X-Authority-Analysis: v=2.4 cv=X8pSKHTe c=1 sm=1 tr=0 ts=6837da6f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=MwwM2Iz_yP08XZX32zwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDAzNSBTYWx0ZWRfX8rkUVQ1/IPvw
 vg5KGfckWU1Bus4jiCNegTL7B9W2GvQZswXl8R9aOP2hmhJMLVqiX4JLkVOfir4bBuTjYKKdQUQ
 xrnrk3d71gb3AwoHinG7JIMK6MyMoNxTufNmW4vMDzpSTfMZ8G985p+/xtyORPjapINI3TwleKN
 FHsVRYwCCmc1GdKP/1ZguNI2Iqzr8a1C/kvF8BiS2YXEI4MBE5fgA/+D1w2NmdnrB44Zh6/amOJ
 QTlXb1YfLna1zSKIKopjWrsahXCqY9agoxy7yaVyRKCkaDeLmSSYk6remrI4/OjpPjPn1h3mQaN
 9BLiYeEi8NnPV1ZIpeCWy6Lo8oYUZAU+9nExlcr6Q5mmNyulwsBCeK8gL6M4vQ/U+rcHAwelT/B
 VVkbuI0FbMeAnF7C1G3ZFvhgnTmxO95VPyFDH2V20rRZW9MOdLyQ6FpWq+y43dYEKf2S289m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_01,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=862 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290035

This series drop gcc_aux_clock in pcie phy, the pcie aux clock should 
be gcc_phy_aux_clock. And sa8775p platform support link_down reset in
hardware, so add it for both pcie0 and pcie1 to provide a better user
experience.

Have follwing changes:
  - Update pcie phy bindings for sa8775p.
  - Document link_down reset.
  - Remove aux clock from pcie phy.
  - Add link_down reset for pcie.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---

Ziyue Zhang (4):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
    for sa8775p
  dt-bindings: PCI: qcom,pcie-sa8775p: document link_down reset
  arm64: dts: qcom: sa8775p: remove aux clock from pcie phy
  arm64: dts: qcom: sa8775p: add link_down reset for pcie

 .../bindings/pci/qcom,pcie-sa8775p.yaml       | 13 ++++--
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  4 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 42 ++++++++++++-------
 3 files changed, 37 insertions(+), 22 deletions(-)


base-commit: 3be1a7a31fbda82f3604b6c31e4f390110de1b46
-- 
2.34.1


