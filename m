Return-Path: <linux-pci+bounces-28443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332FAAC4949
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 09:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7250B17AFDE
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 07:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6110A225414;
	Tue, 27 May 2025 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BdxKKiDk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2A01EA7DF;
	Tue, 27 May 2025 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748330464; cv=none; b=kovsc0hvTfD36hZx3h25zxh1OSstQEP92rvb9s6f+M2Oz8gh1rA1xTzVVbAMHIFznt1QUsQd5AqDOiVpQ6VXnmzT5vGUQZ3i/IAZ1tFN0Lo7BPanLUsL/bnmrNX2wPpbMCs7X88aJjq5kZJXPRYEdfO4dUxIdl27ZodWwhpkzqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748330464; c=relaxed/simple;
	bh=L0e9W9YV1UaeqxD6hL087tuo3eB/tosYyT7whElV4h8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ru0fdFWMqsyGxoa9lZrz/2Xnd6lWw2+JBLXwir7Exa+o/kY2Jo/JLc4JkyWlMgYti5pfM4p3XBH+/1na7MOjK130ErpwKe0N72tSQQjBrrgmaZAxmFAdM7EBG8YiG/f0Sir8gxxaUXFp7xV9NBanLcuRQj1pXnKpZq56c9zwnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BdxKKiDk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QMC8Gh027572;
	Tue, 27 May 2025 07:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vXLWBrAPHYOKMWfPcah4/KdLo/tLyhzeM4q
	gkaB9mcc=; b=BdxKKiDkVCge7N7uMfFzqUwFH2grKdhUWjY5gQwFUiDqgnnSKb3
	d8slv0LdE89CLhmBVkWMVeYio+OysKCozNanR/cMlR9J3kkeGkY4Gfgl1hHflrq2
	qllk96kpUhyCIRCaFre8KSTFAa9aWeIf2s3TvX6rbMtE7wMxWnd6HoWcOg4AJZAF
	uI23R1POS1J3OLe2iQxMbVk4nYG3eL2D0in3ck6sP0FnxFv/NaZGstBsdqtXYKGo
	ilFzedaLuCvTHSNbYJGJNL+dmAfPSQ+rCwleau1LYBARgc3Moqln5qbRYcKTtAod
	x8+DKhgdN9h7zwK4+h43JMVaA2OTvSREAgQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6g8wyur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:20:44 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 54R7HXcY028192;
	Tue, 27 May 2025 07:20:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 46u76kypsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:20:41 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54R7KfRJ031372;
	Tue, 27 May 2025 07:20:41 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 54R7KeXC031363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:20:41 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 6970534FD; Tue, 27 May 2025 15:20:39 +0800 (CST)
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
Subject: [PATCH v5 0/4] pci: qcom: Add QCS615 PCIe support
Date: Tue, 27 May 2025 15:20:32 +0800
Message-Id: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=683567cc cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=Vf7fM4WGy8ubjBm1pJIA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: mbQNpZT7pHYL6pgp6u0sCGvDrPGO6Oy1
X-Proofpoint-GUID: mbQNpZT7pHYL6pgp6u0sCGvDrPGO6Oy1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1OCBTYWx0ZWRfX7c2mdtG64O8t
 ItVoKgHe6GhJE0GjG0qQwZcPUzU81REzrrPEy1XM11IyburPiXK7pTDgkv6+CmVBri+SOHmtb5p
 pBE+edxy3vFystk+0IoxD6ZyIlbWfpVrWR4TcyyGDYJqFQP0X++R2dm3B1PV5K8jwIFMKpFoF6H
 UDE3+goBaZXuslhMvGeUoHRNob7NWW5NXyrduRszRegs0gs3qTemVymz+4FmARu6s7rteXMl0Xj
 BMHhkA3Dua1FzREXH5JmK304i6qhWWfGbzqtYIZiI907Ux4Jxefvr2fG9kOTCvduua4lfiD3zIv
 LkG+wBEffw7CVF3l228xPJc8EbqutcUfLjBmI9SwPa5QAJJZYt6R3o854zkHnWOCZiRghwJ9BqX
 p+dtZhPcW3bSPPRD7EOAz0p91r826o3iEEmiGfRhuD4maZ3vMI3ItceTXO13r4y/4DOftxor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=633
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270058

This series adds document, phy, configs support for PCIe in QCS615.

This series depend on the dt-bindings change
https://lore.kernel.org/all/20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com/

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
Have following changes:
	- Add a new Document the QCS615 PCIe Controller
	- Add configurations in devicetree for PCIe, including registers, clocks, interrupts and phy setting sequence.
	- Add configurations in devicetree for PCIe, platform related gpios, PMIC regulators, etc.

Changes in v5:
- Drop qcs615-pcie.yaml and use sm8150, as qcs615 is the downgraded
  version of sm8150, which can share the same yaml.
- Drop compatible enrty in driver and use sm8150's enrty (Krzysztof)
- Fix the DT format problem (Konrad)
- Link to v4: https://lore.kernel.org/all/20250507031559.4085159-1-quic_ziyuzhan@quicinc.com/

Changes in v4:
- Fixed compile error found by kernel test robot(Krzysztof)
- Update DT format (Konrad & Krzysztof)
- Remove QCS8550 compatible use QCS615 compatible only (Konrad)
- Update phy dt bindings to fix the dtb check errors.
- Link to v3: https://lore.kernel.org/all/20250310065613.151598-1-quic_ziyuzhan@quicinc.com/

Changes in v3:
- Update qcs615 dt-bindings to fit the qcom-soc.yaml (Krzysztof & Dmitry)
- Removed the driver patch and using fallback method (Mani)
- Update DT format, keep it same with the x1e801000.dtsi (Konrad)
- Update DT commit message (Bojor)
- Link to v2: https://lore.kernel.org/all/20241122023314.1616353-1-quic_ziyuzhan@quicinc.com/

Changes in v2:
- Update commit message for qcs615 phy
- Update qcs615 phy, using lowercase hex
- Removed redundant function
- split the soc dtsi and the platform dts into two changes
- Link to v1: https://lore.kernel.org/all/20241118082619.177201-1-quic_ziyuzhan@quicinc.com/

Krishna chaitanya chundru (2):
  arm64: dts: qcom: qcs615: enable pcie
  arm64: dts: qcom: qcs615-ride: Enable PCIe interface

Ziyue Zhang (2):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
    for QCS615
  dt-bindings: PCI: qcom,pcie-sm8150: document qcs615

 .../bindings/pci/qcom,pcie-sm8150.yaml        |   7 +-
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   2 +-
 arch/arm64/boot/dts/qcom/qcs615-ride.dts      |  42 +++++
 arch/arm64/boot/dts/qcom/qcs615.dtsi          | 146 ++++++++++++++++++
 4 files changed, 195 insertions(+), 2 deletions(-)


base-commit: ac12494a238dba00fe8d1459fcf565f9877960f1
-- 
2.34.1


