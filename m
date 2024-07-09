Return-Path: <linux-pci+bounces-10002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C192BD9E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 17:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46721F2203A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D34E18FDBD;
	Tue,  9 Jul 2024 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T1gPUi8X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E1159209;
	Tue,  9 Jul 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537197; cv=none; b=b9upIjVhJyvc3hvQekIhu/eerMk5GcTmQdZdwoIKZqs13YDbTSQ8PkvbvXKPBdHkA/k2JGpK+Arec1doijPpOIFSoyu574uq2/QrtPKpAwrNwkoEm6m6lS4djXOxiudccO+7dHIyPkws1gjyYE2PIqwZrGiVyxa/eFUjQ/xH1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537197; c=relaxed/simple;
	bh=nXvWlpHqHF441FnOFVRN8eXxo/VFt9vrSrgeUZS86m0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=cOfGaPjPNki9Ww+a4ALnXE6BCp3aQBDlwX5k3x3P7L4P813i3BVz9YwLjvBN0J/kkjPFWrf8xEwYv2nfC0HbMnS3qSofxsagdnjTlvII/kc/h9TRNgFNzPneBrHhmD+HfkMZmwtgcnxlv4JEpsB1acUhg3CyTCnoT+swjvg3suM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T1gPUi8X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469BL5QA001714;
	Tue, 9 Jul 2024 14:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JHm6+Wex/Cc/Ixo/RhKm7J
	kww1zUVKyNmPnW18TIxAc=; b=T1gPUi8Xb4XTqL09/jBfpWC69Ol6NWcnwLQNCY
	su0B1gJHvjeZQPcZGNKd8J6JBsEBiee4hZfXHv3lMraNaNA3Ga4kao+UnUwfM57o
	Y9I4WA0/SVhSYYPYrxNwTjxmMUOCNtWg4OvVpp3IVKjbBwbm8R1J2CDnFddUtA9R
	Zp8Zoh99SsE+wLumV6/qGHM4raT5YomoScVrUEcj2iz7cB4syJExUsPKjT45+CPe
	EFuJsWeQD+I6nyw59FNTk4TYB5L2aTmnD0oy6PU8zF6U+0ZvgdGzPsKx2ub4oQ+m
	+SHJp3uKg+rbrm3CKtBWxFVXAtTV/1fvBJF1w32vkWZems+w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xa66q2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 14:59:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469Exk5f030845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 14:59:46 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 07:59:40 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v2 0/2] PCI: qcom: Add QCS9100 PCIe compatible
Date: Tue, 9 Jul 2024 22:59:28 +0800
Message-ID: <20240709-add_qcs9100_pcie_compatible-v2-0-04f1e85c8a48@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFBQjWYC/zXNQQ6CMBCF4auYri2ZthLAlfcwpKnDAJNogRaJh
 nB3C4nL7y3+t4pIgSmK62kVgRaOPPgEfT4J7J3vSHKTLDToCxRQSdc0dsJYKQA7IpPF4TW6mR9
 PkkiEoIwzJm9EKoyBWv4c9Xud3HOch/A9zha1r/+uAZ2XOWRaFRqglEpOb0Y7k+9a52872GOWv
 kS9bdsPO2dVgbcAAAA=
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720537180; l=1672;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=nXvWlpHqHF441FnOFVRN8eXxo/VFt9vrSrgeUZS86m0=;
 b=L9Pj90AXZiS+7ZbGE93OGjKe2IiQK0wExhteGxxM7B6Q0BPMIEqJwViMGf0xbG5p4ubCiLfpZ
 0eXIuDxXOeyCJPqmcfYhzyirUN1YuCncAqr9RHkcMHGGSOa1ErChZvB
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q0kdTam4V5oNegOCi4DQhSj6VL9I1bme
X-Proofpoint-ORIG-GUID: Q0kdTam4V5oNegOCi4DQhSj6VL9I1bme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=721
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090097

Introduce support for the QCS9100 SoC device tree (DTSI) and the
QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
While the QCS9100 platform is still in the early design stage, the
QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
mounts the QCS9100 SoC instead of the SA8775p SoC.

The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
all the compatible strings will be updated from "SA8775p" to "QCS9100".
The QCS9100 device tree patches will be pushed after all the device tree
bindings and device driver patches are reviewed.

The final dtsi will like:
https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/

The detailed cover letter reference:
https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
Changes in v2:
  - Split huge patch series into different patch series according to
    subsytems
  - Update patch commit message

prevous disscussion here:
[1] v1: https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/

---
Tengfei Fan (2):
      dt-bindings: PCI: Document compatible for QCS9100
      PCI: qcom: Add support for QCS9100 SoC

 Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 5 ++++-
 drivers/pci/controller/dwc/pcie-qcom.c                       | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240709-add_qcs9100_pcie_compatible-ceec013a335d

Best regards,
-- 
Tengfei Fan <quic_tengfan@quicinc.com>


