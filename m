Return-Path: <linux-pci+bounces-36625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ADEB8F5A4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 09:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBCC17E116
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A22F5A08;
	Mon, 22 Sep 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4YdA5Ka"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126D22A7E5;
	Mon, 22 Sep 2025 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527731; cv=none; b=mABbAAqqvjlP08nbPM7ZdshSxd6+HI3dzOKBZknACAAwc5RCx61g85c0buqzZWHNHqnvqM1wzAocoXXczwEMgJz16j5HIIYOfJjS8AzfRBiVdwd0+1pkkrJwelmUfI1LIFeiqjtzKaKnod8E1zZntgMcwC06rxa6yQLkCOkqTnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527731; c=relaxed/simple;
	bh=BHlVCI0RAYek6UwchOkDkXbXFt6NXcfxNN4MdAPfvpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YnQ9vXqCDx2IRCWy3upPnNjab19OOgA43/pjmnx+EOpxBJ4gzr7CAr3hFWXCVmFVnopQSOLRkpLAuJba/e8OzZoPKMNUL0ke73L0lvP0GJp89sxbiesWNH6MG2fTeQRAwMu2s/sxU7vGtUv+cRkcfV1IE9XcRJC3BL4lNXVB7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y4YdA5Ka; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LMhs0S013411;
	Mon, 22 Sep 2025 07:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=q2TTWfPPdRbtXjNcPVyyM613088qz57a8Kp
	5KPxUQb0=; b=Y4YdA5KaE2nPI45odYRkl5USmKTocGlvU3Gh3ss2FFBLm8Hx85P
	phMGbjVvVgqOrMuW5cQL2CEU30xDMytIV2ERQY8kfRgJ+3yibx25DXo0Lf9Qt0XW
	zljKWBBs9ZcQ9C2uYUiNBpFh9715dJhVgoWgZWz4PYhevieZIxi3tyOem2lGr+/z
	zs8fcp5ncVYYFdsAIxVQFfNpeXGlTyui+Dh2HdXmH4bmSkMgmn8Q+USViCVyRnHU
	FC7VIOygcEvPGelC0OrY8ccZvCWPtbnOudqkPQgtIWfqb5zyZsZkjMEc0GN0CZQ1
	ZBUVPPdkxPsxVmCg8rgwnvR+wLyO5amxeQQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499nekupkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:18 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7tGSV022237;
	Mon, 22 Sep 2025 07:55:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 499nbm0545-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:16 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58M7tG53022218;
	Mon, 22 Sep 2025 07:55:16 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 58M7tFDg022210
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:16 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 80C1978F; Mon, 22 Sep 2025 15:55:14 +0800 (CST)
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
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Subject: [PATCH v1 0/4] Add PCIe3 and PCIe5 support for HAMOA-IOT-EVK board
Date: Mon, 22 Sep 2025 15:55:05 +0800
Message-Id: <20250922075509.3288419-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: P5o3jBsPVlON9C_jr5OKaUoqukc0NLmE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MSBTYWx0ZWRfX1Ja8mTfkmE2v
 egs7vPUa8nGcd2XJX2JlRAMSl6OXJa9daa20UqS72FVPaOJs6BUHAuMBy0RMKzV79Uh2/CUBKcm
 KGXpyLvMWbWNGYsXeXfGz7FKG6uWbl2ZYwPf3WPpvUezZgQxjsCiOMN+UxtUFtuRxsiy4JqHjJ/
 L7Aw4//urSI3KGnsS+EmnBBlulC+CjZyoMI1qRF/C0M7y5HsSMkNjK1R3vlYqtIc43Q45FxZi5z
 09W38QQVYYkLKTd2cMLhSFzNGiChXgeWdfzFu+iaVnDiPjtxTxghqxzWQpAORYe5q8WpEAU+wPk
 1FGyh6my6QgkBC4SzWHF6nMcln4hzyaFSQDMzMOuLBYBVDA8Qw2q7dlvvLYT7/pNStiVYDKPsvp
 +Ut0vt7Z
X-Authority-Analysis: v=2.4 cv=b+Oy4sGx c=1 sm=1 tr=0 ts=68d100e7 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=RMFkh6N_GHqejj8ZFKIA:9
X-Proofpoint-GUID: P5o3jBsPVlON9C_jr5OKaUoqukc0NLmE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200041

This patch series adds support for PCIe3 and PCIe5 on the HAMOA-IOT-EVK
board.

PCIe3 is a Gen4 x8 slot intended for external GPU.
PCIe5 is a Gen3 x2 slot designed for external modem connectivity.

To enable these interfaces, the series introduces the necessary device
tree nodes and associated regulator definitions to ensure proper power
sequencing and functionality.

Ziyue Zhang (4):
  arm64: dts: qcom: Add PCIe 5 support for HAMOA-IOT-SOM platform
  arm64: dts: qcom: Add PCIe 5 wwan regulator for HAMOA-IOT-EVK board
  arm64: dts: qcom: Add PCIe 3 support for HAMOA-IOT-SOM platform
  arm64: dts: qcom: Add PCIe 3 regulators for HAMOA-IOT-EVK board

 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts  |  52 +++++++++
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 110 ++++++++++++++++++++
 2 files changed, 162 insertions(+)


base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
-- 
2.34.1


