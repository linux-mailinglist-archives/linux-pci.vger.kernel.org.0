Return-Path: <linux-pci+bounces-42249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291AC91B66
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 11:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0995534CC08
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1CD30DD37;
	Fri, 28 Nov 2025 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OA5l8Xnh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D42DEA95;
	Fri, 28 Nov 2025 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764326989; cv=none; b=aVs/vMkZXNJhi0EQf9Zw6MzbajHPSPI+abgSIvUWHFQd4EVEV0Z+6pJa0C2bvo4qVyBBz14/Z2HGiQwvdU6iEoJaGPC+jkzbeXvIB4VHCOSn2X5qPzmm9lzRMZSSe8iaj4dA95iKxpJiV1f9DvAEw4h/e97BOBXxJJYkCFmYogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764326989; c=relaxed/simple;
	bh=XgYHgTJif0Kt4tQ0ots92qx7+sf8k9cuvqs9xCd4zvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RFHo8V15shbIUXb8J2jK0kcgasU4KCbQsEnKIkSIoJvnLf+V1aEQmR4Eq2DwMyGstvlHHpv39zcBxrLEgxKl3hxI1+hIg09cMeS5hEGc6iA40dDLAErTP8tsXAntBmQAewwLVzxDiajMJz1KQQj5zY0b4Y/Gq+yyvKEdTKjFWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OA5l8Xnh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS8NvIR4191713;
	Fri, 28 Nov 2025 10:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VnO1XI5Z6djcuLYGOcp4ZXXOOQJxWEIAn6r
	C1Y2MO8c=; b=OA5l8XnhuT5GWNkgEdwViVcXjUBdKMT8E6aDpYakaXQ46/XGPkY
	ogESpyttv9reK8Wnjd9BMA31WWhKMmfmvyuye9tba8iV0Z9gRjbsXBXX/VV6m1zJ
	Oo5LjDRpXsrTTAJXVNamIYJdXcWRTbxNvEiaYU4qQSUyo/tUxiV4bsqWR7D9edjc
	KUCwzI99NacRa5t9aX3zfLkiH9aco+dUilO8cF/SFU4cA8yNyu65PUvt4a7iieoC
	3pZTpkGckL0wJvbUSvwC7UKm+gcz91jSqof0mQg73ASJ9hC3B2Yrek5BS2F9Berx
	zZgaRsxCevTwsMwpF8j0JK010lXTJAk9AIQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aq58fgwhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 10:49:37 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ASAnYqF023536;
	Fri, 28 Nov 2025 10:49:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4ak68mwd7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 10:49:34 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ASAnXw1023524;
	Fri, 28 Nov 2025 10:49:33 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5ASAnX3T023515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 10:49:33 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 189C676F; Fri, 28 Nov 2025 18:49:32 +0800 (CST)
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
Subject: [PATCH v15 0/6] pci: qcom: Add QCS8300 PCIe support
Date: Fri, 28 Nov 2025 18:49:22 +0800
Message-Id: <20251128104928.4070050-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-GUID: pKyA0y3VMVUaOLvbIzSGhU7Y_4eX1dDo
X-Proofpoint-ORIG-GUID: pKyA0y3VMVUaOLvbIzSGhU7Y_4eX1dDo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA3OCBTYWx0ZWRfX/132emUBaExB
 PSkCdRtoc2SOS7ThQplK3IZqtMVEtOvRNqCcy61rep2CQDdGImFa8rN8gS4Lxx6qYEeEYQWqtN7
 lyUTCmGGkyJ41UixOkORmE2IqXTIxXq9u/GYfL/NDu5bEQyTCGKS9Go4jlKgF5YgtvLXpBaurM+
 SUN5wae6vMt0R0Ps49uMV6LaIQGL2zbtJ05K1aU7RYikxgrcjj7GdJQ9Z1BCekzgVQIBxX5wnND
 T0H5aRQnzWYHAluOVvH2pOmqfa5iA4GuU438jCc7teupJ3c5QykLTwh8MR8rTI9OUnFL6U6DJIc
 VGAvx2yENXRV9+XezRvgjZpKkED+UPstk8S0nD2kwvQumY05w0BEq2x/FPAh37V/abDoUwhzzid
 K2f2QIhw/YO9sJ63m3vjKHV7DJsbDA==
X-Authority-Analysis: v=2.4 cv=E6DAZKdl c=1 sm=1 tr=0 ts=69297e41 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8 a=0l7i4LX0jF_Ij28KvGoA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280078

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
Changes in v15:
- rebase patches
- fix incorrect indentation (Dmitry)
- Add patches for monaco-evk enablement
- Link to v14: https://lore.kernel.org/all/20251024095609.48096-1-ziyue.zhang@oss.qualcomm.com/

Changes in v14:
- rebase patches
- Link to v13: https://lore.kernel.org/all/20250908073848.3045957-1-ziyue.zhang@oss.qualcomm.com/

Changes in v13:
- Fix dtb error
- Link to v12: https://lore.kernel.org/all/20250905071448.2034594-1-ziyue.zhang@oss.qualcomm.com/

Changes in v12:
- rebased pcie phy bindings
- Link to v11: https://lore.kernel.org/all/20250826091205.3625138-1-ziyue.zhang@oss.qualcomm.com/

Changes in v11:
- move phy/perst/wake to pcie bridge node (Mani)
- Link to v10: https://lore.kernel.org/all/20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com/

Changes in v10:
- Update PHY max_items (Johan)
- Link to v9: https://lore.kernel.org/all/20250725104037.4054070-1-ziyue.zhang@oss.qualcomm.com/

Changes in v9:
- Fix DTB error (Vinod)
- Link to v8: https://lore.kernel.org/all/20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com/

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

Sushrut Shree Trivedi (1):
  arm64: dts: qcom: monaco-evk: Enable PCIe0 and PCIe1.

Ziyue Zhang (5):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
    for qcs8300
  arm64: dts: qcom: qcs8300: enable pcie0
  arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
  arm64: dts: qcom: qcs8300: enable pcie1
  arm64: dts: qcom: qcs8300-ride: enable pcie1 interface

 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  17 +-
 arch/arm64/boot/dts/qcom/monaco-evk.dts       |  85 ++++
 arch/arm64/boot/dts/qcom/monaco.dtsi          | 374 +++++++++++++++++-
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  84 ++++
 4 files changed, 543 insertions(+), 17 deletions(-)

-- 
2.34.1


