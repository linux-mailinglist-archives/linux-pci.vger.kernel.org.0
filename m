Return-Path: <linux-pci+bounces-27314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D39C1AAD3DD
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 05:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35491BA387B
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 03:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E5E1C1F0D;
	Wed,  7 May 2025 03:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mpA2tUk1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA278C9C;
	Wed,  7 May 2025 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587778; cv=none; b=gQJ0IHm4my20BZQ9tk96K3YJxAstgJK6q2UVi+cNDV/mD7h5p4UCy/N06QL/WT/WpXTob+Oj4TVgkq2WQoFk7IIl3WYcnhx2Fkc3eirO+XWBuvnTSM6n8mS9pFnd21qtULGArl8JmfkxqFZp0/Pk/1GHJEkKSOoami7+w9WjdEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587778; c=relaxed/simple;
	bh=aRA8G8kfuPm9Z8/s5uKlLjMsLkCpE5T4/nZtKMFn5YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lEXtpGR+3rnawPlvJQFD4WIG5MlT6rPi3VpXqzcuGBdOF8XPtg5Ijaj9GY1EHcALL9rnw/4iehqAP2W7ooEW+CDVtyN2iPXVnaazS0F8EYfpA93SQoio1KgxIN836YbKAFMswXsAPzIMGVHcfGDzxvb0CKeJ5TViiQuS5NyZK1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mpA2tUk1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471H848021660;
	Wed, 7 May 2025 03:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zYokss55O/GLnxeuzWbIBOYOR9Rnc5WYu8j
	+xMV1+xY=; b=mpA2tUk1cHhaNbX9f3jboLRKCYUmTYRx35Nv4exrUaloUvxB+MP
	0hHV8shgii6Xl5eOKSEfF4KZsZFtVlnZ0Nti16yFMEefuglKvsTMdstf/DupuwS4
	cUatwFYTQSn9UQ+sUabOpkAkLW92y4S5d7FD+mkugTwJGI7ZoNTgHf2XUkEF8t+S
	6MqzSlGGvtsNBvTVi2yayj9tZ5209BzINaQNK4SA/umfEyFjDppFFIdJReMEpBk4
	/LIzB9/dO2QZAzL79AoSyga0+WGugjJZvyfTd6mzximWfYHphrmlRAml9c/dtaQS
	Wj13MtM/H34uiLUehwFDnmjAsupJQf1cX9g==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46fdwtu1ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:16:05 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5473DacF010261;
	Wed, 7 May 2025 03:16:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46dc7m60td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:16:03 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5473G3Pi012810;
	Wed, 7 May 2025 03:16:03 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5473G2eL012800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:16:03 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 82F052F34; Wed,  7 May 2025 11:16:01 +0800 (CST)
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
Subject: [PATCH v4 0/5] pci: qcom: Add QCS615 PCIe support
Date: Wed,  7 May 2025 11:15:54 +0800
Message-Id: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=VPPdn8PX c=1 sm=1 tr=0 ts=681ad076 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=FMqLFO0IG5DNS-mwCd0A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pPUoP7yaSUtiK8mPO8xKwoVYiaBCdh58
X-Proofpoint-ORIG-GUID: pPUoP7yaSUtiK8mPO8xKwoVYiaBCdh58
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDAyOCBTYWx0ZWRfX7Wss9tuBTx67
 Ai9x9uwy+aHLK3dDCbv2tktNM3nb/ZaboBz9VqQrYyluv4eFqazJKzeLMtVfIuFZROko0ezr5vs
 e3Y+tvPq1irsdCiJkk1uwrTMv0SnwoGuFD1NAp8IMjfGehKCXRcyOYYuebPQgsGjkYVeskIy1PR
 6VJKlIih+liveFnNPevmlCNADLQf+NA7loIwHc1vVKAb3ITzFQOPpeTouQHDGUGnAMSRFeFpAYY
 y7yEHsJDZLhtXyToPhSmvlUxVOYUulIjekk02SEV+A3Sc0KoEhRIWShyjR3CfBLqoB6OuPayXel
 C+AJepF73TSOrBBVvOVlJyg304RVqA1TreOVrH/9MygbQiA9LtVzM3S9qCOjTYQC2e+RE/sMcrT
 IBd2UqTzE+8LqZypjoxXuTfA11B+a//oOlCsRNc5LLMi9y7FAc92mFPTuQRzvwBqC3dynmqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=427 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070028

This series adds document, phy, configs support for PCIe in QCS615.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
Have following changes:
	- Add a new Document the QCS615 PCIe Controller
	- Add configurations in devicetree for PCIe, including registers, clocks, interrupts and phy setting sequence.
	- Add configurations in devicetree for PCIe, platform related gpios, PMIC regulators, etc.

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

Krishna chaitanya chundru (3):
  dt-bindings: PCI: qcom: Document the QCS615 PCIe Controller
  arm64: dts: qcom: qcs615: enable pcie
  arm64: dts: qcom: qcs615-ride: Enable PCIe interface

Ziyue Zhang (2):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
    for QCS615
  PCI: qcom: Add support for QCS615 SoC

 .../bindings/pci/qcom,qcs615-pcie.yaml        | 165 ++++++++++++++++++
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   2 +-
 arch/arm64/boot/dts/qcom/qcs615-ride.dts      |  42 +++++
 arch/arm64/boot/dts/qcom/qcs615.dtsi          | 146 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 5 files changed, 355 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,qcs615-pcie.yaml


base-commit: 8fd51b270d58f8b05aa58841ec38c8a6b4ab09ca
-- 
2.34.1


