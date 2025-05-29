Return-Path: <linux-pci+bounces-28534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E3BAC76D1
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 05:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE024E68D1
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 03:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EDF24DFF4;
	Thu, 29 May 2025 03:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pDBeFSVi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41C2417D9;
	Thu, 29 May 2025 03:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491012; cv=none; b=EBl1OM2ExnY6hZY5w2o38RvZUWUk59T3mwrQhTbBdKXHEnF/fK3BMRGQHZZ6A29FtywF4an93obAFPaUDNk5V5Fe348BWLgAl2LQIe1bDqhX7LO0b4kRp1eQ2FNdZ5nQvbM152ggTxU9KYPPWkrLGjaUbVZkYzLRhI7J4CkpyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491012; c=relaxed/simple;
	bh=HlMxjN1rhbUQG9kzZ9xQceQmjB3QNlzQysF7zPqmn8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=urYrgewa+pq9Oogx8cONES5M0Z+jylSVSyNxQ0vfrxTVQ4YTzEwNYI+d9OeO1THid6Po/5Ox2bU4oIr+3vwrKqox25S0jolPckRPReZT1JRv4zL84DKe1MHYo04PKzdcnkdHY2Pv9z351uNaL+YvhwXIDZyPuNCmQKJWsLs0QOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pDBeFSVi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SHmgLa001002;
	Thu, 29 May 2025 03:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vQDOhTTOAcRXply+Pu9Czab0u/odqwsF2SK
	QvQrlP/k=; b=pDBeFSVi5/MMh/9o6x9U6TTF7JufGcWMFqlzCGi+OtowRd33yEC
	lphtDfnZmtV8GaCIvBAFYmFWEUAs5+vQNocAF+VI+vVN3/OnJEk5iaF7R3O5c62N
	LEghcUCB/UpxgGhHXqi2Gnd1HP8XzQCJ4zJgnq4TmKT8KJ/rdgvN4otElh1qTdmA
	UBVjtb8nh8pcxqhtuVKGYfRF6dZNaMykD6PALJi0IY2FwuJiQqohAk5byQR5qkCN
	FQxsC+W1SwHndy7y9gon9hkjVQtVhUaNtjm+DJFk5k30YgG1uo23a/SBHKj1/qZg
	kK/3gHbDh/sm9JFtCkEPTSsmeEXC17GvDYg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u5ek48xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:56:42 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 54T3sLZb011619;
	Thu, 29 May 2025 03:56:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46u76mdpe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:56:39 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54T3udkN013251;
	Thu, 29 May 2025 03:56:39 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 54T3ucxe013239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:56:39 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 75E783153; Thu, 29 May 2025 11:56:37 +0800 (CST)
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
Subject: [PATCH v6 0/6] pci: qcom: Add QCS8300 PCIe support
Date: Thu, 29 May 2025 11:56:29 +0800
Message-Id: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=GIgIEvNK c=1 sm=1 tr=0 ts=6837dafa cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8
 a=Rx9dfpPETavtrPkqVs0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Uyk2CZPwfcyF09NTbJQ03NPVvpYUcVks
X-Proofpoint-GUID: Uyk2CZPwfcyF09NTbJQ03NPVvpYUcVks
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDAzNSBTYWx0ZWRfXx4Wyi7QQSDTy
 +I7vdsna3jUELiv0K3cE2pgBX/Kffv9xxCaItQU4GxijaYj8eqeqjDGqgofuaADojpm+vMAOOmV
 MOCZHwiMIYla1rZ1ovU0HtNv6vlqpHTCo13mgvqnvTqlfZugazHL7/+X+Kz8OiVt7O2YoX4IaPJ
 VJEgYGrxsCK5J7NBHfa2UWPngJ8tvdW3ezIXBEJ2V4SwT3X7i0yxHILpH8RfPfayj/+jEzWMANy
 nzBUuZN8WIeyE9drFKoXRFgJu7TEdZ4OH4WpsRmH2H4oDqQJ/y1u4WepPk3WTKXVWMdgUlClosv
 YuF9Jpr/Pw3FDTYsZ2f4WI9NeMObNWIe1b5RiibLymhtyQLCp3PLhpU/EKDGmMJHeFP18ztkC9Z
 QpfrUVtdRrNxqAJAokJMUpkYy05tuRb2uajrCBdao6J3CgBOw1d6oLz2wdeQgdZ1KrjBpXjw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_01,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290035

This series depend on the sa8775p gcc_aux_clock and link_down reset change
https://lore.kernel.org/all/20250529035416.4159963-1-quic_ziyuzhan@quicinc.com/

This series adds document, phy, configs support for PCIe in QCS8300.
It also adds 'link_down' reset for sa8775p.

Have follwing changes:
	- Add dedicated schema for the PCIe controllers found on QCS8300.
	- Add compatible for qcs8300 platform.
	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
Changes in v6:
- move the qcs8300 and sa8775p phy compatibility entry into the list of PHYs that require six clocks
- Update QCS8300 and sa8775p phy dt, remove aux clock.
- Fixed compile error found by kernel test robot
- Link to v5: https://lore.kernel.org/all/20250507031019.4080541-1-quic_ziyuzhan@quicinc.com/

Changes in v5:
- Add QCOM PCIe controller version in commit msg (Mani)
- Modify platform dts change subject (Dmitry)
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
    for qcs8300
  dt-bindings: PCI: qcom,pcie-sa8775p: document qcs8300
  arm64: dts: qcom: qcs8300: enable pcie0
  arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
  arm64: dts: qcom: qcs8300: enable pcie1
  arm64: dts: qcom: qcs8300-ride: enable pcie1 interface

 .../bindings/pci/qcom,pcie-sa8775p.yaml       |   7 +-
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  14 +-
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  80 +++++
 arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 296 +++++++++++++++++-
 4 files changed, 381 insertions(+), 16 deletions(-)


base-commit: 47974c65c7bfb29cce6cb13ec35760299e02d553
-- 
2.34.1


