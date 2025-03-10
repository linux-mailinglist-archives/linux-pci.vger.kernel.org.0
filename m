Return-Path: <linux-pci+bounces-23272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47069A58C08
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 07:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61987A3EB6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 06:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AA21DD0DC;
	Mon, 10 Mar 2025 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fjrGECq+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D961D7989;
	Mon, 10 Mar 2025 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741588297; cv=none; b=nXHYKyGoekxWU3mvynF53yoNmwm1Zyr0kWwrSBJnJeNUwza5vV3kfs3Hy0hQoUYVRRjLRAOPJ0CvxG5TAV2lVNEkBdIZNNzesk9IYbC3fnx3KPUvfSbV2/4bPo76FLPO4ltfAmFHlBYnd9wWJHK8/aJJizqo5g4NNSXMAT4UShk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741588297; c=relaxed/simple;
	bh=OvZuaUhi9xuMOVrix4zxXYOdoru9rGCOGh2ItydCSn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FWPxDVFPwW6Q5UbgpM2P9xpaILKKJw+e6h3yWGUzmgwiXvb2Z+C/DfZLOESDSrzEXNHbdem5SPKhsTmTUOcWZVL58b95OKlwQh7Hj1qtPkpK+rEOqujFjni80qaybfUMhmxIOaVL8PvcF5hOBdYiQbVdjO23cJ4l2jvW1nr9SME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fjrGECq+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A0NHW2010043;
	Mon, 10 Mar 2025 06:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mPhwJjtbJrss1ksQWKfZCY5ugnmZ/AD4n4/
	dI1xSZVg=; b=fjrGECq+e7i1PTPuXfjeapwXYCSELKy05Ty/R6p/C8zpKlJgR0A
	g+FUiPefDc5wObKkAS+Gieu6qCAp4RuObXPGwXVb6aPqTL5EjXySjnrWILtXLwcJ
	tAKA36HXfLwDasQLNMrfBvZU9OtYYjIRK6bEmF1VYLQH7d3WqTl77IZifyVix1/0
	OBXK/DdsyxgxjgfZVZtjgv3fIQgoVvYF8dUkomoKjRwgQyHVYw7LPDC0HYN+y4rf
	XmuaTzmJazy+Q5d9f4awDrPkbGwVpioqWtzKjLIjmOQDPurgIL90VoToh95Vcwob
	0xLmvMCSiPvpS9AmvJgDIOI8zv3t91vR28g==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ewpkqex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 06:31:10 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 52A6V806011075;
	Mon, 10 Mar 2025 06:31:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 458yu87f2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 06:31:08 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52A6V8PY011070;
	Mon, 10 Mar 2025 06:31:08 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 52A6V709011067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 06:31:08 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 7042D27C6; Mon, 10 Mar 2025 14:31:06 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org
Cc: quic_ziyuzhan@quicinc.com, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v4 0/8] pci: qcom: Add QCS8300 PCIe support
Date: Mon, 10 Mar 2025 14:30:55 +0800
Message-Id: <20250310063103.3924525-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-GUID: _NaMtD_mFuwSwvtEmGUGB9iCP8_BpM5t
X-Proofpoint-ORIG-GUID: _NaMtD_mFuwSwvtEmGUGB9iCP8_BpM5t
X-Authority-Analysis: v=2.4 cv=C5sTyRP+ c=1 sm=1 tr=0 ts=67ce872e cx=c_pps a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8 a=Rx9dfpPETavtrPkqVs0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=703 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100049

This series adds document, phy, configs support for PCIe in QCS8300.
The series depend on the following devicetree.

PCIe SMMU:
https://lore.kernel.org/all/20250206-qcs8300-pcie-smmu-v1-1-8eee0e3585bc@quicinc.com/

Have follwing changes:
	- Document the QMP PCIe PHY on the QCS8300 platform.
	- Add dedicated schema for the PCIe controllers found on QCS8300.
	- Add compatible for qcs8300 platform.
	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
Changes in v4:
- Add received tag
- Fixed compile error found by kernel test robot
- Link to v3: https://lore.kernel.org/lkml/202412211301.bQO6vXpo-lkp@intel.com/T/#mdd63e5be39acbf879218aef91c87b12d4540e0f7

Changes in v3:
- Add received tag(Rob & Dmitry)
- Update pcie_phy in gcc node to soc dtsi(Dmitry & Konrad)
- remove pcieprot0 node(Konrad & Mani)
- Fix format comments(Konrad)
- Update base-commit to tag: next-20241213(Bjorn)
- Corrected of_device_id.data from 1.9.0 to 1.34.0.
- Link to v2: https://lore.kernel.org/all/20241128081056.1361739-1-quic_ziyuzhan@quicinc.com/

Changes in v2:
- Fix some format comments and match the style in x1e80100(Konrad)
- Add global interrupt for PCIe0 and PCIe1(Konrad)
- split the soc dtsi and the platform dts into two changes(Konrad)
- Link to v1: https://lore.kernel.org/all/20241114095409.2682558-1-quic_ziyuzhan@quicinc.com/

Ziyue Zhang (8):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS8300 QMP
    PCIe PHY Gen4 x2
  phy: qcom-qmp-pcie: add dual lane PHY support for QCS8300
  dt-bindings: PCI: qcom,pcie-sa8775p: document qcs8300
  PCI: qcom: Add QCS8300 PCIe support
  arm64: dts: qcom: qcs8300: enable pcie0
  arm64: dts: qcom: qcs8300: enable pcie0 interface
  arm64: dts: qcom: qcs8300: enable pcie1
  arm64: dts: qcom: qcs8300: enable pcie1 interface

 .../bindings/pci/qcom,pcie-sa8775p.yaml       |   7 +-
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   2 +
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  80 +++++
 arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 289 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |  89 ++++++
 6 files changed, 465 insertions(+), 3 deletions(-)


base-commit: cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d
-- 
2.34.1


