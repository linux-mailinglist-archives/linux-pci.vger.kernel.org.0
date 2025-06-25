Return-Path: <linux-pci+bounces-30597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 260F5AE7D76
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 11:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F81F1895E3D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 09:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9724629B201;
	Wed, 25 Jun 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E0dpKrt0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CC2701D1;
	Wed, 25 Jun 2025 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843558; cv=none; b=E2Sv6H6CqFAue+d+XVlSigW17nZG65fEOqriAekSPQfBTT5SSjSiuNhBgcSVDrfvBkTCRfdANjZ7XxYh0URPEcJZXMCWdF4Kso2QNGLyXKKA9zCT+KAuKRWL12zXxC6Yc5Y78U7pVLGXYddjc2skZChYnm0+vTgoF+LGJFQy8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843558; c=relaxed/simple;
	bh=B4Ul5a9SEzNRRYUEPLdXZNFngrrAtxa6MFd8xfi83q8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kXsew8BDPJg/b64KZ20iuLgwDG1ELydSTi+uGhST4u2b9CRv79QQeFjeSUBpYceBFQ/GMma5Thx10ysYy4ATDKJ4N1m05o0B551DhlotR7ekpHnvTOPi2oSXPIZJnIpT+bIjWCwDixPc3ub+gXnApHp/DtvMbth+95iwwaOifkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E0dpKrt0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P62hlB027443;
	Wed, 25 Jun 2025 09:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=E0uuj1f8QD5sdFb1JE1xG6Z88AYiMpUcpN1
	5kfiXaEw=; b=E0dpKrt0DyvndoNZs4Erz/T9vbFf8J72XUi/dkH+BXPb3q4OvPM
	jhm2819ie/zU3W2ONJRNHXKRmIzSxxz4dFzgXf+vejdI1EJGPVIl3nDVyK29djKr
	RabJ/WvFyHln4ks2ieGibEKjJ2Z3qmLVdtieUTETJlNwqB2r1o08xzrswT9DieTF
	XhfaGZOjve4BsO7g9jFzUCUlwGfhQK8yuWf4FylriOaQ/R6eGKiBzZbNoA6z2y8z
	TAWoPlfl5qi9ZxRLF2IEeh1yZAwPQb6aNe7WOzdZHdG3+wPjtMbvzNtI/xwP/FZV
	07rP7XKF9PBiPzNS25Z+8jen9+lyjVbbyLw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4rhd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:25:46 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P9PiTT024627;
	Wed, 25 Jun 2025 09:25:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47dntmauxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:25:44 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P9Pigs024613;
	Wed, 25 Jun 2025 09:25:44 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 55P9Ph9i024611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:25:44 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id B94693839; Wed, 25 Jun 2025 17:25:42 +0800 (CST)
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
Subject: [PATCH v7 0/5] pci: qcom: Add QCS8300 PCIe support
Date: Wed, 25 Jun 2025 17:25:34 +0800
Message-Id: <20250625092539.762075-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685bc09b cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8
 a=Rx9dfpPETavtrPkqVs0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Fzs9ensYebGxQQ65j0cy7VyuRu9zVkeH
X-Proofpoint-ORIG-GUID: Fzs9ensYebGxQQ65j0cy7VyuRu9zVkeH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA3MCBTYWx0ZWRfX7JRzxpbnUjru
 BUs1fzOK5ckgPPdXw/IkNR0j0VD3L0SBPygSmWfzEeEq9PXOYfHaUAPSrBN2pz3F6ILwBDOBMKo
 jAFoA6vK8lXnz/h0QJumFJ5MNi3R1aaR9MOOELU5itETz99KaZLFgGBPEn/Z7Jz7MawxJMh6aAC
 HF3xg0M8Gnijhp5whGwyh8x4BUDHxGzpAVNoNS2W0xQlDDU2q9RdVhc7JmFB0lFwWoUTY4cuqWj
 JjhX06cNRRXnMEtdgsNnsBquK6v2EJlB+nxhlvXLgSFoB8IipqOcqD0jiZ7M5p+R9f2F853KuZl
 WbHyOh9xSag5vEtJz/yWHrTcR57Om3xOgg4hcfSyosxuGguYGBzkshJV9fyfkQt4xrbezzjrIci
 kCSNdUUt7da9BruSdaQ8YLchcKzvHMXGOb2or/k2vNeDOKV5XqIyTPpm+7qS03K/eEpXja0G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250070

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
Changes in v7:
- rebase qcs8300-ride.dtsi change to solve conflicts.
- Link to v6: https://lore.kernel.org/all/20250529035635.4162149-1-quic_ziyuzhan@quicinc.com/

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


Ziyue Zhang (5):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
    for qcs8300
  arm64: dts: qcom: qcs8300: enable pcie0
  arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
  arm64: dts: qcom: qcs8300: enable pcie1
  arm64: dts: qcom: qcs8300-ride: enable pcie1 interface

 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  14 +-
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  80 +++++
 arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 296 +++++++++++++++++-
 3 files changed, 375 insertions(+), 15 deletions(-)


base-commit: 9354e82d5fd77af919dc8559806253b70db77eb2
-- 
2.34.1


