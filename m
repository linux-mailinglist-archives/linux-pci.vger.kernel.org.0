Return-Path: <linux-pci+bounces-32933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED3EB11C37
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 12:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61A94E4122
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378E52DC348;
	Fri, 25 Jul 2025 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hh6ujQXk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927F02DA777;
	Fri, 25 Jul 2025 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438980; cv=none; b=TptoTEHaX3w6cmUXF//q6UBJxyA95p6j7RoRuTdtpOdVz+1/ubZNa+C88UPXq56YndO93Dt900uXUP2TqCV4b/Sk0TrHw95braxWWe9kha7DCvMI4sYc8LotN3maRwEloiDjHdeY4XVjy8mzWdFKv5AuUJmgu4Ii019VQGC5ATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438980; c=relaxed/simple;
	bh=DoBptU7WgQjjp3I2VdAKCGZvrHgfiOMQFawDaIBPBOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C5ieqhEBOZFS+PGOLUParbLhSibkWjMRJhvjIWXB2q+ebyzggyA4HXFqBkNrxSNfIxT7c9DKMK6pQeM4wmerVsYgFcQhkWpSNMS3g/vY87MvmLQ//Bp8PE6o8TONYbLxAijimLKf2pMYmRWefywaNcjftu9JEsz9f3iL45HTQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hh6ujQXk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9JXb1025827;
	Fri, 25 Jul 2025 10:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iIbZHbS9s9W6ttGKX/iKrJbEeTlLeZNA0hs
	TF5Hj6BY=; b=hh6ujQXkCl1w/fwCbBcmzIrCNP7oJRkv/v+nPQVWj38C2Bftq0k
	auTknlIB9qxlYNAyLOGbVMp8Qeun2pB4p8bvYl5+SbdnTWZuz5D6cewMEKGR1VWD
	fXt0ulbryhiBPKBL4aJv4IKtQAq9G64506aqQzgSVHBNLI8pPLnVyVSShQjRsxkA
	kS8KsHq1ZV78La+5ljVwfW5q8HJKNlMNn+hbX+jxHMkzZbzD6+Sr78ciPzXQDHvZ
	q4HXYwO3O9ClEqenUSkMKLDraHlLXVWYQMM593PrZWqTf95qQGd5Rh8dMq90azEd
	80WMvPf6kPkQUolPV4nNqQkw2yvZWLqPwiA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w30spkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:22:48 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56PAMYeH027666;
	Fri, 25 Jul 2025 10:22:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4804emsyu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:22:34 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56PAMYGq027650;
	Fri, 25 Jul 2025 10:22:34 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 56PAMX8Z027644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:22:34 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id DC1BA210CE; Fri, 25 Jul 2025 18:22:32 +0800 (CST)
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
Subject: [PATCH v7 0/3] pci: qcom: drop unrelated clock and add link_down reset for sa8775p
Date: Fri, 25 Jul 2025 18:22:28 +0800
Message-Id: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=WtArMcfv c=1 sm=1 tr=0 ts=68835af8 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=5rr6ixAOVb5IYiBHoQ4A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5Qn9hx-4didi1S5_QmRg8LsScOF2GS54
X-Proofpoint-ORIG-GUID: 5Qn9hx-4didi1S5_QmRg8LsScOF2GS54
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4OCBTYWx0ZWRfXz4oCkU5nm/ZI
 uMclcfVO1gENEt5OM8cgVfLIGAhKMy/rnRC8yfVmdCoEFm8CHVyyu/WFVmIvz7YgKGPrU03HWAv
 97qpPOC6uHt/YjtRgbHeTMhU5k8qMVDyQQEz3GFF5dZTTIF1dTKulySqI2xG8KYvUC+O/mDWzcO
 J17dfUKmJYYxBclKvI5KxTVSriys3LYCr+GDNQce3RW3xp9g6bMVW4k1ZaMf45dAChFufKh1/65
 suzVNFbg5Evqj6fH0wE0MqL1rXWbbquh3fWOC7NsJNNIMevItUfJSxgCs9i6P6epkavhK06rHWI
 aLElJt2iKZrUKkiW+kJH5ae/LfSWJLfnFuAKN1YBXHU0apFZiW6cuX/ks4+hgV5BE0Kh5otVM+i
 tOr5CdmWzHdTNF82t09Edr+UHr5KM8f76w0J9ZwEkCrE105Ssx19Xmp26UGOMz/IFHo+LPle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250088

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

Changes in v7:
- Fixed rebase confict
- Link to v6: https://lore.kernel.org/all/20250725095302.3408875-1-ziyue.zhang@oss.qualcomm.com/

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


