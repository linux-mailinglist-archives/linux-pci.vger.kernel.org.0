Return-Path: <linux-pci+bounces-30590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D2AE7B39
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 11:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547F25A2E68
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 09:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ACE286D50;
	Wed, 25 Jun 2025 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GxJsECNk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2A285CBF;
	Wed, 25 Jun 2025 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842073; cv=none; b=gS3PAIH6ZUTOaYAIW105TtdrcUxcCwaAvVdFo/7TaPLCaMqRhWttheidB4oClUy1IKbJk1W/JosbtIvwWQcVjdiZutc+qDsXfpPGeu/T0CzKiPnIOfNexAHz/uf2Ft7T8R5QzxGanz23TivOI+HX6SyRC1yujJzJacb2pGwjl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842073; c=relaxed/simple;
	bh=fP/84LHS/W0DT52qf3inCcJK592VuRpUV10LjjJ5fm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NAuWykcjOlQmKddssLKEnLNzwSu/R/vpMbT8uMpqmi6D8sAzS/ALDLzmT2YWI1OoCKs8KXNM9f99ymlUDzefaXhq3Cc9B9UoBvGDbKjJzpBFfD1B+Qgjk3uWM7nfFaVztJbqCX92RR2opmwsIUHxHPuOtg3rFEUUSnzEGyOPh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GxJsECNk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P1rrr0000866;
	Wed, 25 Jun 2025 09:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wGZFgG3XtGSDeKB/aede24FMpzwsuWbJ+ZH
	QY79BogQ=; b=GxJsECNkTqH5FhFfyRt+qN/aCMyu+eH/f3Jcq2MlvH7LjC34NW9
	ILrp4AIcIHyXDiULYNDy3V9T643yamZ/XPOyFxAkW4929xPbhPaDQeT9RSMcH6ZI
	doHKpqkclS4SKFkCdnQDMjq9N/GbyBY06ZGD/Cq+/HbRjGV4ShigUVXJ0orAQGbU
	ynElLTLUZbjuItvdJvU3n/EE0A57lINHN/0AjhBYv0lmk20fsf/8SQaHUo+t2A9a
	/66X1nXr6WgpNQVdnZYsUH/FLCbEloMmhs3yNAS30Utagw2+pBYr6IGCQkA04Jml
	Ow/kPzlnjjkRESVmue0aBUIguho0RYRo67g==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcmruyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:01:02 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P910LG032352;
	Wed, 25 Jun 2025 09:01:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47dntmargg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:01:00 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P90xm3032336;
	Wed, 25 Jun 2025 09:00:59 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 55P90xrU032335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:00:59 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 109EE3831; Wed, 25 Jun 2025 17:00:58 +0800 (CST)
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
Subject: [PATCH v3 0/4] pci: qcom: drop unrelated clock and add link_down reset for sa8775p
Date: Wed, 25 Jun 2025 17:00:44 +0800
Message-Id: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-GUID: NwOXRmjptddIkFTxiDAjdlc46YhSnpnP
X-Proofpoint-ORIG-GUID: NwOXRmjptddIkFTxiDAjdlc46YhSnpnP
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=685bbace cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=5rr6ixAOVb5IYiBHoQ4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2NyBTYWx0ZWRfX0QC++6QezZOd
 1cTpVuf01KKs5FBo0k1O2wA0whUiS0PYAKvg5ars9nPbxhAShIIz0IbIspMtF+jAEX1elV8LaU1
 qMcmAibWJiHj+dT2GAKYzQYkLXsMk3m9aMTRbtZlADNWWVsKzGup00vyRfbo/w3/hC3P0OGM4pi
 hfSk0F/xMFxpauRkgFiU6u86KCRJR9/9cV0KLLFkz3zyrrQf51w/4xRBNZqH7hFWfoFE/b5y7CZ
 fPmMLTycIAWQ5ksno0/YuVGONsyz7XXgW1GTL/mjifLLoYvleQarwQDRNpkTpuFP6buR1bl1c3K
 CiV4wzgHJNKNkcapczlnJcDNgnFEtdgLFUaf5lXdG57qOlw6+f9LZJwIbrczpNo8v9Vj8OU06mb
 bKTIUuYp6uvlKYdxYtagXr0d34QNjySUg15LF6NXQNDXQ1qxqxASddzDI1W1wbrNehbkvj0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250067

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

 .../bindings/pci/qcom,pcie-sa8775p.yaml       | 13 ++++--
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  7 ++--
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 42 ++++++++++++-------
 3 files changed, 38 insertions(+), 24 deletions(-)


base-commit: 5d4809e25903ab8e74034c1f23c787fd26d52934
-- 
2.34.1


