Return-Path: <linux-pci+bounces-32927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50954B11B33
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 11:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA101765F0
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9BD2D3738;
	Fri, 25 Jul 2025 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KRepqnWK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2B628934A;
	Fri, 25 Jul 2025 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437212; cv=none; b=rimOJpt9CHSxUjOpoJPvaaxp/Dv0oeztBafuyO1b919e6QPuv87iswO8WTu7UoJrcffYQx4L6RovxIMwJvOzDj0IYsEABy/NsFlCG3Onj6CmxEgEe8x+E7eOCTEIsA8K3UY/xO+U+0ba8+BA51tFJaFbB9IzmGJwlKUH06/gyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437212; c=relaxed/simple;
	bh=3rcvwsbb159ScjhsjQ30nqg+iL5jUGSIy24jgJWEL30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NQtZJ98KXrn3PGJ5d/p/xEDff7oo7MbTPSHtJmB2KIMPZp7lzIkZch48B0I4+qJq56LF7fJcstVzPiUCwjUbTGM5D6lXD5YxjwRCZZCQN04BLFQB27UOs1Nq1jZWy34S9ka3E7+nH8nvezysJUWnQdjJwDvzqBaCKrkTxVBEqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KRepqnWK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9VoB4004895;
	Fri, 25 Jul 2025 09:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xcFFl+UAGNhgtwHiIII5/wboyZ8J3btRA0M
	YTheaEZQ=; b=KRepqnWKO3cn2dptvH9Mx7yNPXBymDGXUerQxMy94zsBb9BtmB+
	Le546CpeoehYCUNPVULBfWJvYxhb/hZSMRcX3dO2/lwdozgVSZxfiqsILzQJHQLE
	Hrag1G8+GqKJ+J6eCREGCH30ToQPcRIIv4McICDPns1ueFkdMtXgPRn8fa9ujaVe
	cotbnzqDxF/WC+ILr1P15Rfwumh09URgRgygtEHnTkGQKcos4YtWXNRmfrtPia02
	89hLu6Kz/5ua0LzRMDU5FkdjQoqTEdgUBIqfiDGdPwqFCftEHG4HOchn4f3/vpcf
	XxvKdEe3BNi5PGGUFraAVpnnyTrLMvK265g==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w539m4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:53:16 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9rDAY001542;
	Fri, 25 Jul 2025 09:53:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4804emta1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:53:13 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56P9rDtD001535;
	Fri, 25 Jul 2025 09:53:13 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 56P9rCXx001528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:53:13 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 00DF720D5E; Fri, 25 Jul 2025 17:53:10 +0800 (CST)
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
Subject: [PATCH v6 0/3] pci: qcom: drop unrelated clock and add link_down reset for sa8775p
Date: Fri, 25 Jul 2025 17:52:59 +0800
Message-Id: <20250725095302.3408875-1-ziyue.zhang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=AfKxH2XG c=1 sm=1 tr=0 ts=6883540c cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=5rr6ixAOVb5IYiBHoQ4A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4NCBTYWx0ZWRfX2pvRszl5q2fI
 +oZaAuEpZ+LSyOlCVei4sCDU1MbQzaeMC9U6LMn0ZCKASxyokSYgMOAq1XISQLf6E0f3TloGyO3
 UvVNwaKWHCHj21ZNHCFn0coWJY1MSi5O5XdYsJ79fhr+LXvhyLugT+hucbYh/tOEuMln/9Wm7ep
 3MU6ldQgf62uvFN23mNN3h+fxYRfBTnR1z2QcRUZhHzO2rkJ8viFCgi49HMoKXqgBSRi49uf0ST
 memAoJzNFxtINsdPeDt5ezCWv3G6I8tNYv672IA5zKne1jMF5rsmZCTkmvrOxd5UoxxBSc8BFk4
 Dwy4biUY+ss4N5UA+/dO9f7c2qcFlyW1zF1yw/hg73biBDmXlChqQlhggoNAjpmRc2UzgNmUeav
 OCy9H8KLaFPAmoZZTIYw6yeagKjhUEOzJKUAprHBLqjetuxDcp1s9UuXr9MmJLJDMxtK8vvA
X-Proofpoint-GUID: I8c6Ks2rmeYQPx2WjmNAEtlup0MU8Q0n
X-Proofpoint-ORIG-GUID: I8c6Ks2rmeYQPx2WjmNAEtlup0MU8Q0n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 impostorscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250084

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

Changes in v6:
- Update phy bindings commit msg(Johan)
- Add Acked-by tag
- Link to v5: https://lore.kernel.org/all/20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com/

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

Ziyue Zhang (3):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
  arm64: dts: qcom: sa8775p: remove aux clock from pcie phy
  arm64: dts: qcom: sa8775p: add link_down reset for pcie

 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  4 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 42 ++++++++++++-------
 2 files changed, 28 insertions(+), 18 deletions(-)


base-commit: d7af19298454ed155f5cf67201a70f5cf836c842
-- 
2.34.1


