Return-Path: <linux-pci+bounces-32509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B98F0B09D9B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 10:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331251C208D6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 08:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D692221F2D;
	Fri, 18 Jul 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TsXza3NL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B337249F9;
	Fri, 18 Jul 2025 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826658; cv=none; b=QtYfaalCjhBI61BBu2cp1L2CNdTktrq84hE7qAFi3yaVV/3ybVW24JJUsnmLMTcr7OySkIK6QOnULwCgyhmYDmn8zPs+Vkxog1HH1WD5Ig6flGci5N0oY91yyBpXL7bD6Ys1rhWOMT0NNFLrNUEZaWF0hupRhW+KJ1lK9PLq+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826658; c=relaxed/simple;
	bh=kXFwApLd85BRzVEkUUsp8n0ZO1knXTKxnCQ0MHKgUdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jjky8674QNnrWjHtHE+L/C8BUBdhQelQ436lcvUI4W7YwPsS//rjVDdgJr9DQHGEICDLRnGV71ecwBDHJd0+L/cKAev2+jVfd3fkulTMlnSQgLC867m5Y5nnt7UDW+ihqKGtRNbNa9cdxTfI7qxgmDk1YSW30LOXxGN4d/RtX34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TsXza3NL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7g5F9032260;
	Fri, 18 Jul 2025 08:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zgBS2MhajMN2+QNHiURetzr/7oqOIp4hfRB
	oUaurHH0=; b=TsXza3NL8qGNqJ9fcPhqULSn8Pqh2OemIY4Njhed03gQUq4SuUW
	0OG5O99ReMHubgG5jKR9DlLn62VaG00SsGLSmej7OhHetiZPzWoR+glcpZ2DFCXQ
	lRJZ8T37uZLlh9xZL+2fvxdo+GwH/q1G9HQ4E7Vc1NJc3iNqB/gZXSC080bKEkXA
	tY6AC70oPnqMEcS1iRLxNDmGWJRoBQiEQvQFkiYL0i143Y57qjMPWF/FyiDVzbSQ
	l2zd8idD+NDogU2gQXX3R14fRzAxijGhIkoIkiph+k4AHmNqvA5IOE2qCbDv3ENu
	IR3Yi4DlrVVpkJpiL+bwZPI458GwUrr/i7w==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug38avm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 08:17:24 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8HMZF025160;
	Fri, 18 Jul 2025 08:17:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47ugsn10hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 08:17:22 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56I8HL7v025150;
	Fri, 18 Jul 2025 08:17:21 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 56I8HLgM025147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 08:17:21 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id C3C0F20EA1; Fri, 18 Jul 2025 16:17:19 +0800 (CST)
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
Subject: [PATCH v5 0/4] pci: qcom: drop unrelated clock and add link_down reset for sa8775p
Date: Fri, 18 Jul 2025 16:17:14 +0800
Message-Id: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA2NCBTYWx0ZWRfX+WScg3V6bQJ5
 52TQ/l1M6Jinxd4ntDXHGGQAsfRPk39e8C975QhJsVhLOq+vkWTfqLuDGZOaXJr64UxItYE+hS/
 ZjW1lSJGwzxAP09dXlV2BGQHrd/CTOzAfap+Cu8mSwUqkQ4D7wpofOr4l5WaF7PiRvmTL6yKaOw
 yRFtRs00F7Hji2tpLvRpHZiEdjUV18j5yCs1ongPZRo7Lz1NgZLYKafn6WZ+/EdWT4hcFlFwkoj
 67rp6x9CSW1y4hJV2nasVQExq3hM0WqKpDAYxFjcQ6Due8Nc1RSE496a1owWzLIxsgSDusApzKl
 8S10hpATOmLZS9SG0ROY8zUL7nL4ikhzSrzaEaO1zL1d3+WwrJ8JO4TsB7B8v1vRd4gloqKsdwi
 etRq85b6yozOAdHzjli0gHBYEjjz1cChWgMDELag6Pxt9SxavRA12ogWYxXcYco77cTV1Y0N
X-Proofpoint-GUID: 1NrsIdLYSXwFVWRuuTNTBiL4qej9YqUF
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=687a0314 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=5rr6ixAOVb5IYiBHoQ4A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 1NrsIdLYSXwFVWRuuTNTBiL4qej9YqUF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180064

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

Changes in v5:
- Update phy bindings(Johan)
- Link to v4: https://lore.kernel.org/all/20250718071207.160988-1-ziyue.zhang@oss.qualcomm.com/

Changes in v4:
- Update phy bindings, and commit msg(Johan)
- Add ABI break commit msg
- Link to v3: https://lore.kernel.org/linux-arm-msm/20250625090048.624399-1-quic_ziyuzhan@quicinc.com/

Changes in v3:
- Update phy bindings, remove phy_aux clock (Johan)
- Update DT binding's description (Johan)
- Link to v2: https://lore.kernel.org/all/20250617021617.2793902-1-quic_ziyuzhan@quicinc.com/

Changes in v2:
- Change link_down reset from optional to mandatory(Konrad)
- Link to v1: https://lore.kernel.org/all/20250529035416.4159963-1-quic_ziyuzhan@quicinc.com/

Ziyue Zhang (4):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
  dt-bindings: PCI: qcom,pcie-sa8775p: document link_down reset
  arm64: dts: qcom: sa8775p: remove aux clock from pcie phy
  arm64: dts: qcom: sa8775p: add link_down reset for pcie

 .../bindings/pci/qcom,pcie-sa8775p.yaml       | 11 +++--
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  4 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 42 ++++++++++++-------
 3 files changed, 36 insertions(+), 21 deletions(-)


base-commit: 024e09e444bd2b06aee9d1f3fe7b313c7a2df1bb
-- 
2.34.1


