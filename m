Return-Path: <linux-pci+bounces-10067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171E092D06B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A361C217CF
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 11:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA46190485;
	Wed, 10 Jul 2024 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QjjaP2Ev"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0818FDB8;
	Wed, 10 Jul 2024 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610204; cv=none; b=cNj0hmzFCLBsDdY7Q3VxiRm1pLjWu1N3RgLgbhBN8xy7w7AaZLdO4+cRoiGlVEnLz5z5GBHnPirfPkY9B6qZrd71hfIPMPazBgDgWzIkkTKFSb7d6+obBCGD40LOrzQUPc1bnYl882nFDXYOkSgUY1jVdjDGJjH2uYmV4l9+cdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610204; c=relaxed/simple;
	bh=r8QytOePkTEZVCs2LBZ0SFa0RCHJwJbo5ta6H0vboiA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=t/tFFyosLljeA0Js8s6cJF7M1gc298mVlRgcIEafA+/eL8TkmJqcvM2XMWC2T0pDXopHxT2Ya4zX1iZDbX6STT/JucGav3pdlA7DCL4z4lbGDzK5M6wWyJInoYuf+sFdmD/jN+ThVrPQCfO2uJHEE5CYlSz8BArsdpYfPzQ0Gvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QjjaP2Ev; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A78XXP025652;
	Wed, 10 Jul 2024 11:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1Qr29arU9YM+UDsPsgqFkS
	QwVNnU31xc2/gXBRmu4ec=; b=QjjaP2EvpfWNntWKlwtO00bj+r1q9fBGF3+YRf
	tid1g1hySnOGmaFdS7DxYoQ+36U3VYDHBgO3dWaNSIdEcPPC0JMUDj5M5qgxWhtU
	fn0Tgte2jJ2nGxVJ/bL6gxUgdcT39zLm5uOcv4ai5ID93dfvTMNcNRGrEs5VcjWQ
	yx37nUEzQ93KKc6w5+g87mPuGE8vTI7tG4Wz0f7jjFAB3gq0nATeMmdGWNsPnW7e
	ys/HRhF9249iR6mhiaJZQKVUbS5L60XbSWvpsuN1naS/im+LokV/Rp9ianZVs5qF
	c4Dg6XcxsXafEIieIb+rAUwyq4B0r94309MH2rYe2zjPzb9A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4091jdke63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:16:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46ABGG1O004084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:16:16 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 04:16:11 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v6 0/5] PCI: EPC: Add support to wake up host from D3
 states
Date: Wed, 10 Jul 2024 16:46:07 +0530
Message-ID: <20240710-wakeup_host-v6-0-ef00f31ea38d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHdtjmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDIxMDc0MD3fLE7NTSgviM/OISXaMkS1MLI5Nkg6TkNCWgjoKi1LTMCrBp0bG
 1tQAg7k5EXQAAAA==
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>,
        "Krishna chaitanya
 chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720610170; l=2675;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=r8QytOePkTEZVCs2LBZ0SFa0RCHJwJbo5ta6H0vboiA=;
 b=NLDbUAJ2ehUlBTIGcAux90I/d0zt5PZp/BeBehOFrdY28JLzdAde+jpol2332b5PNjmkC8y7Z
 aTwHi1bzofJButnPwiOBeUhvjd/SgtKDjimovwzYPypVwJYshnwUKMR
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PxmjERrOPNZGCrwgg1Cp9_EaZ4D5Gh06
X-Proofpoint-ORIG-GUID: PxmjERrOPNZGCrwgg1Cp9_EaZ4D5Gh06
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=901
 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407100077

Here we propose this patch series to add support in PCI endpoint
driver to wake up host from D3 states.

As endpoint cannot send any data/MSI when the D-state is in
D3Cold or D3hot. Endpoint needs to bring the device back to D0
to send any kind of data.

For this endpoint needs to send inband PME the device is in D3hot
state or toggle wake when the device is D3 cold and vaux is not supplied.

Based on the D-state the EPF driver decides to wake host either by
toggling wake or by sending PME.

When the MHI state is in M3 MHI driver will wakeup the host using the
wakeup op.

This change is dependent on this series PCI: endpoint: add D-state change notifier
support
https://lore.kernel.org/all/20240710-dstate_notifier-v7-0-8d45d87b2b24@quicinc.com/T/#t

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes from v5:
	- rebased on linux next.
	- Link to v5: https://lore.kernel.org/linux-pci/1690952359-8625-4-git-send-email-quic_krichai@quicinc.com/T/#
Changes from v4:
	- removed the enum to select to send PME or toggle wake and use bool variable in 
	  the api itself as suggested by mani.
Changes from v3:
	- changed the bool return type to int for waking the host in mhi ep driver
	 as suggested by dan and bjorn.
	- Changed commit logs as suggested by bjorn.
Changes from v2:
        - Addressed review comments made by mani.
Changes from v1:
        - Moved from RFC patch to regular patch
        - Inclueded EPF patch and added a new op patch to notify D-state change.

---
Krishna chaitanya chundru (5):
      PCI: endpoint: Add wakeup host API to EPC core
      PCI: dwc: Add wakeup host op to pci_epc_ops
      PCI: qcom-ep: Add wake up host op to dw_pcie_ep_ops
      PCI: epf-mhi: Add wakeup host op
      bus: mhi: ep: wake up host if the MHI state is in M3

 Documentation/PCI/endpoint/pci-endpoint.rst     |  6 +++++
 drivers/bus/mhi/ep/main.c                       | 28 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 ++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c       | 25 +++++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-mhi.c    | 11 +++++++++
 drivers/pci/endpoint/pci-epc-core.c             | 30 +++++++++++++++++++++++++
 include/linux/mhi_ep.h                          |  1 +
 include/linux/pci-epc.h                         |  5 +++++
 9 files changed, 119 insertions(+)
---
base-commit: 4e0938fbb7efe1df1e57c0450a840d9605734c27
change-id: 20240710-wakeup_host-2b95824c0bcf

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


