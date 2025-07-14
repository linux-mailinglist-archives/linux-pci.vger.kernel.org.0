Return-Path: <linux-pci+bounces-32049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AD7B038E0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 10:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B12D3BB97B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B9223B628;
	Mon, 14 Jul 2025 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RDQTXOKv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4F20DD48;
	Mon, 14 Jul 2025 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480948; cv=none; b=GD1v5nWow1I+8RIHnAOLTw8K+Aa0IhFpOaY2BUw9vlEnN6VauOCne7BY40n815dHqZ3/a8ddbQfy5JaCWCvQijLNtvW5pRqmyx1r6+AHT/fB/FrkYxBnfc7xV/E/C1ECgaQdbQ4oPVa2xynAd/f/SEnT+e9lQiofATnut5Q6IZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480948; c=relaxed/simple;
	bh=KuMMslkfTw+fLPIm6gnXL1NULalXDTPuHrO1Y0/YPm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tIpYW/yiIR/+YEPnyPEr7q6A3aji9x0dEy0hToa6nPar/h2pOR8DmAtItKtZLlGSNfInhp6lnR9P8kmSYjDUADhQtxZLIVg0LaVfd3XES9VjCRi+WPvqvi+K2yJz1Gf4CnHl0S7SBJCr6GlUVlB+39FWhZTDmfx7c3dLn8T1rYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RDQTXOKv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E67U0j005599;
	Mon, 14 Jul 2025 08:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=RZr8xRqmhXh+Ssrh2y9hkF4my5RlRW+8nic
	pY+RLZLc=; b=RDQTXOKvcbcMXrdstm92x7RwmXqbpdmx19ORtrkK0rwbGgVeIk9
	a976ZVz79fd8tCvix1sOlMYnra/PFuPIr+1VJVAjPSgyltvlIkw9ANH1fsZSuA4j
	ghugastju+Utql+FDTfDUhdHqbA/Y8Zoc68yB1XJwh1lw3mt0IGznarcPhjE+bnr
	SGSPldKpCtPYhMuUC5aDDONdV5riUgxWbRCqQ5GTwq+X7K4zyBkTsYtnBx24+TVT
	QFqLt18QNnF6rNuu43Ddu8ioWtPD/yw4meSIjpQjF2u9Ul6/Nlut0xdlBPChnHX1
	Wf4q2iIHuG6AJZSxtLlhnwqEU+xjwWQEKMQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47vvb0rcaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:15:35 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56E8FXu8021303;
	Mon, 14 Jul 2025 08:15:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47ugsm5xje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:15:33 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56E8FWWW021291;
	Mon, 14 Jul 2025 08:15:32 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 56E8FWMN021285
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:15:32 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 09E5720F21; Mon, 14 Jul 2025 16:15:31 +0800 (CST)
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
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v8 0/5] pci: qcom: Add QCS8300 PCIe support
Date: Mon, 14 Jul 2025 16:15:24 +0800
Message-Id: <20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: EPt3KMEO6iFgZiazfAgruWwvilFxpKrz
X-Authority-Analysis: v=2.4 cv=B8e50PtM c=1 sm=1 tr=0 ts=6874bca7 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8
 a=MByrn4WnkjAl5ObW7ywA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: EPt3KMEO6iFgZiazfAgruWwvilFxpKrz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA0OCBTYWx0ZWRfX/ISqbV7EJklm
 EgZ4gvkV3+H/wlEIXqY2R7o3zpOQ3LcHg21E4S5LazbrHE7NA8l+9vH8OJ9Bt/ztJt3U10zdQtN
 iVHFTn5NKkWqhBMn3mhIDp47nzwrb0L+vAUHKCIyfq2ro5Jbeszsrm3brpKj3lzglwTi5fXJAJV
 bWXvFJAWxwDZ1gog8TFmqQdiZQyXBJSE/DjVu8OW0ZhGsvBramGvHLnSs0Te17RGOjX5T3kSyTU
 vmMB/PhewBOZCSpadtrLmYiG5+dckxNU31BQclGJFllI6pSgV/G1Hymxru3xKf3EvzYa3vq2ayR
 e14Yxzn6Fboshk0gfZIR8U4KMJCIRau5wYmfl25qfpd9FzpaJGPDXzxasqGWHTSwZf9+IbgxS1p
 dqCJ/JcjJSSspHFHUAncXDcCckul7go7TKNsxopysmvxxFWFl8M8BW4XcrWGNkgIC48uys97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140048

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
Changes in v8:
- rebase sc8280xp-qmp-pcie-phy change to solve conflicts.
- Add Fixes tag to phy change (Johan)
- Link to v7: https://lore.kernel.org/all/20250625092539.762075-1-quic_ziyuzhan@quicinc.com/

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

 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   2 +-
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  80 +++++
 arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 296 +++++++++++++++++-
 3 files changed, 375 insertions(+), 3 deletions(-)


base-commit: b551c4e2a98a177a06148cf16505643cd2108386
-- 
2.34.1


