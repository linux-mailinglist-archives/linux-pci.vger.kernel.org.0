Return-Path: <linux-pci+bounces-27308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19ECAAD3BF
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 05:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361BC466CC3
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 03:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167991C1F0D;
	Wed,  7 May 2025 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bNSqcUdw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01C149C64;
	Wed,  7 May 2025 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587440; cv=none; b=uAdg1vs1lU47N4WtSP8xBVM8LjvtxNt6VWwX99HKMqKcjFoG7zsjqfodJq2VdzA/tBpTlA0u6csT+YfHMAqsBXRBkeWA/8oEMZJjUqxGu8Eem6n9JqTK11bGoLsg7uGf5nREKuLrfB7is0UKWEqnXA6zxFYngU/zupTC+BYdknM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587440; c=relaxed/simple;
	bh=DWEmIOytz3yC00TLxNrVLLYTKH/K0CAb+J1GNPxT0fI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AMmtNc5BLWbBYg43YtihyxoG849ISjk4rJQrAPoWRv0tdQ4ALN5Kg3zhi60VuFGQN+m4H1qVaSeP4dXhrDjRoiEVc5YtUytWcS+5QaQu+596xy9TXqZ/KwEP8CQoB0Ro1IF0Lk6oFKx/6XIJiNMGAqxpA+W6MbXuos3y6Gy4g9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bNSqcUdw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471GsHT021933;
	Wed, 7 May 2025 03:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vCgZmuG7SF+Td0O33w0zlWSZ0RlRkj6sKgR
	rerRaWIQ=; b=bNSqcUdwreFY2FUiauMB2OJGw3cml/FvD92LrBKyVP2Cc2Eow56
	9q9w2V95ZVJBr5AyNV08urvRslBEmSNFDEzfsPPVHBus7s4VLZJCKrvuZBQpNWsF
	APzzZuAo5puAI5iZk8apiAl1gULo91jDgC1L49oZokDWQNh0qDAQOF0HU8Q2uQeY
	mZ3SutIZp64hE3Lex902R6SyMm181JFW+Oue5iz0pFIGtFPIlSoRok0EAjgsyva8
	GxTOabpkRipXkaCw4ncIVF0ZVAJWhpDj/1VWHwE3Pw8ZvC8Qb0RK3ea4m+3UBc+8
	TfixBdXTnSvRyXXyt4ke+CrkcsX9+XZPrqQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5uuv9w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:10:25 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5473ANlT005958;
	Wed, 7 May 2025 03:10:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46dc7m5ysb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:10:23 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5473ANYP005884;
	Wed, 7 May 2025 03:10:23 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5473AMGX005700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:10:23 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 614212F3B; Wed,  7 May 2025 11:10:21 +0800 (CST)
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
Subject: [PATCH v5 0/6] pci: qcom: Add QCS8300 PCIe support
Date: Wed,  7 May 2025 11:10:13 +0800
Message-Id: <20250507031019.4080541-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=L9cdQ/T8 c=1 sm=1 tr=0 ts=681acf22 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=QyXUC8HyAAAA:8 a=NVt-qORIiALRBcsd3-8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: GLqQMwSefUQvGc1dYT0vr3IILhZmMYaJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDAyNyBTYWx0ZWRfX/ztqb3d67J/I
 oeCPFdwfxgJrLdXanmMWby+nUDpzbbE2yFEOD8/I4iCl3R9iFRSsV9J+ojtxZsdSG6cZh8l8m1w
 K4Lh2IhMqO/m8avANnYsH12q5A9Qsw8ppMsOaKDklMHjKW2NzefowAzyYhMIy/+L6/nMqUFokJV
 NAQ60RrYNbuDpLaTO9pjqikwpMAVO2/Xj4fSIPXuUg+1ECF/1hxnnOgRrmcOteEJFPMa01UyRbM
 v3Evgvdyxwk0Pl+tyyjAxGDiZhrDONNg95F12Upz8du17cwM8Hc6A8l4825h1d9ndnXRJuwK4Qo
 k7y60D/RRueZAzcC+6eRKjOhAsE/a0JqWmOKGLSjrT/9E8VrQD8SPjLx0bXFv8r+FxmedbIUCPb
 cQKL9xMdTNhzbKLk/fX3vXzufPTud3zsY77NNBxVSl1iyoYSeA4fWz2U7xT64J/sywps8jl6
X-Proofpoint-ORIG-GUID: GLqQMwSefUQvGc1dYT0vr3IILhZmMYaJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=800 spamscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070027

This series adds document, phy, configs support for PCIe in QCS8300.
The series depend on the following devicetree.

This series depends on PCIe SMMU for QCS8300:
https://lore.kernel.org/all/dc535643-235d-46e9-b241-7d7b0e75e6ac@oss.qualcomm.com/

Have follwing changes:
	- Add dedicated schema for the PCIe controllers found on QCS8300.
	- Add compatible for qcs8300 platform.
	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
Changes in v5:
- Add QCOM PCIe controller version in commit msg (Mani)
- Modify platform dts change subject (Dmitry)
- Update bindings to fix the dtb check errors.
- Remove qcs8300 compatible in driver, do not need it (Dmitry)
- Fixed compile error found by kernel test robot
- Link to v4: https://lore.kernel.org/linux-phy/20241220055239.2744024-1-quic_ziyuzhan@quicinc.com/

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

Ziyue Zhang (6):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
    for sa8775p
  dt-bindings: PCI: qcom,pcie-sa8775p: document qcs8300
  arm64: dts: qcom: qcs8300: enable pcie0
  arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
  arm64: dts: qcom: qcs8300: enable pcie1
  arm64: dts: qcom: qcs8300-ride: enable pcie1 interface

 .../bindings/pci/qcom,pcie-sa8775p.yaml       |  26 +-
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   4 +-
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  80 +++++
 arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 297 +++++++++++++++++-
 4 files changed, 396 insertions(+), 11 deletions(-)


base-commit: a269b93a67d815c8215fbfadeb857ae5d5f519d3
-- 
2.34.1


