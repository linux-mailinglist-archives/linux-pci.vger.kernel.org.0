Return-Path: <linux-pci+bounces-29910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36802ADBF0C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 04:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EF4174C27
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 02:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A9B238179;
	Tue, 17 Jun 2025 02:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hVppGTYN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB52F211711;
	Tue, 17 Jun 2025 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750126610; cv=none; b=qs0GXLWksANe3XHqa+hxM4zKXc3vvSUJaiUy1TBSO6+ky13hXNsSyYqVBsbX4EKoK93Ru1PftfN2dQiphybyt8HD2WOIynV91MFzQMfG+SRIR1IgtgCRktuBB8Qsa0kB+XtJNNQgH1rLTECSqT+Lwlxw10w4MaKWsyOhoCnJ9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750126610; c=relaxed/simple;
	bh=Nmko7DJux8OrTyv2gbSVLIY/2i/hHpUOyPM4bzTYyUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZVl0ncsRPqpT4D9exzPqm0tmth6CUZr5qCWLHc2Hcl5BFQIXOaSKEEwmbwsifP+KlbibCrSe3zhI5xSOf1VOPl1qn/eY+dqtnp/C2px4pNxVP8asfW+MO6qf8t03KqrvfWMMzRuydVLp5ZHgOdunLIGhvedBM9rfGtc17sStsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hVppGTYN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GKBjZZ027995;
	Tue, 17 Jun 2025 02:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TKGAFYYPDUMJpcbkODvVrxaf/uzW/GXvT69
	j6eAShYc=; b=hVppGTYNg7kw+W7YlTxGvTYqHG/hJjidL693tfWyWDOGXu7hP7x
	lLPfRRgt5Zen7hdBy4vO8xtgqNts8uldg6Ub+ZMCLcwgT/4iEg8SLgooD5gS10d9
	sz1sFSUgvSXwHxrdO0gO4xeg2TmWf8ixcnR/4Y4qeHOBuaUEPVqdBRCfOQS5mMKV
	bVhpepMqc3EMb01RvwKNjWtKZkM995NEsNte3++dVQFi9Ii9yCoH+FK++GzCi6EC
	d25i7fq/7ZvnZCcJgDEf3wfo6raoPEM2YNulZitV/MtWrqwC2HZbDOpD0lIh9mUX
	lvmYKDZEH0QqfXwGF9KXV/rrv7UV2CQTPcw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hcxh22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 02:16:31 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55H2GTcK014423;
	Tue, 17 Jun 2025 02:16:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 479jt4gb0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 02:16:29 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55H2GSYG014404;
	Tue, 17 Jun 2025 02:16:28 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 55H2GSpd014397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 02:16:28 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id C56733658; Tue, 17 Jun 2025 10:16:26 +0800 (CST)
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
Subject: [PATCH v2 0/4] pci: qcom: drop unrelated clock and add link_down reset for sa8775p
Date: Tue, 17 Jun 2025 10:16:13 +0800
Message-Id: <20250617021617.2793902-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDAxOCBTYWx0ZWRfX07nNaR+iYq45
 20qWYp9OpFb/gT/t0bs1hHZgAcoT6yKRu2Hj+DAPAmC1cl/RIt/5Jb8+/lBu0s6q/3TIGVJCDSv
 XgWmZSkYpM8lbAbE9RJ+ZJM6MJo8cL/zRtypfL42Dq/WhplbYaXQshwltTbcefRuWin5xgvEOmb
 4y5z8pZPwQxmGd0Ozyz0JAhhr++wVwu4x6helqkfnZtFa0/c6Sd5nLL8BA1kejbo53oxLNefGlQ
 HiYQzQXnPuH4U3NJlZz6PunCuAoc5Ab28fpklnWIJVEk0WV/v1y253MfyDQ0xiEHGJtjb17OE4R
 TTU7qwlPwamllDdLrLYvHJZaZmrlhwz91uh48gH8M6rbneyxuGfmHUnLZUc7npJpu7FUwS7ewrg
 +6UUGTSI9w+h2ACi5VrC3qSy4D/w2MgTnQ7ZWJVPY2YaORGgjq0N8zqlF+LuJ+fJZzXVu0Ob
X-Authority-Analysis: v=2.4 cv=PtaTbxM3 c=1 sm=1 tr=0 ts=6850cfff cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=MwwM2Iz_yP08XZX32zwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: b5Ga7YqrvwqvNIY3ssx0j50fpB0h-rzW
X-Proofpoint-GUID: b5Ga7YqrvwqvNIY3ssx0j50fpB0h-rzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=961 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170018

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

Changes in v2:
- Change link_down reset from optional to mandatory(Konrad)
- Link to v1: https://lore.kernel.org/all/20250529035416.4159963-1-quic_ziyuzhan@quicinc.com/


Ziyue Zhang (4):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
    for sa8775p
  dt-bindings: PCI: qcom,pcie-sa8775p: document link_down reset
  arm64: dts: qcom: sa8775p: remove aux clock from pcie phy
  arm64: dts: qcom: sa8775p: add link_down reset for pcie

 .../bindings/pci/qcom,pcie-sa8775p.yaml       | 13 ++++--
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  4 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 42 ++++++++++++-------
 3 files changed, 37 insertions(+), 22 deletions(-)


base-commit: 4f27f06ec12190c7c62c722e99ab6243dea81a94
-- 
2.34.1


