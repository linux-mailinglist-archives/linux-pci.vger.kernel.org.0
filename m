Return-Path: <linux-pci+bounces-13321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063D597D40F
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 12:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FCF1C213F4
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02832209D;
	Fri, 20 Sep 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WQNr5PAk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD11BC49;
	Fri, 20 Sep 2024 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726827504; cv=none; b=A4hc7E0I5taAxZBjdtHoMfdSnBo/PHKasrHtdAI16K1UgUK12aFnFtvDUnp3WeWvAc2RLTBlG2rgL6nQfngCLAGtvVljwBjK1VvnW/mfZSzBNqnr0sXSJQWt0D7Do/fwvxMhwDwYfw5CWNWHqPg94gJ2ZhWjJRzc+t4EcGoeOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726827504; c=relaxed/simple;
	bh=5+mE99vUEO86YNsz7eLxuhzYb3eg7bR6IaZK1B1r8mQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=qrRxxHDoVQ/KrMndJB3aJJj0JnGrCw5Lcf7ycAC7+05ck3d+vIKg7ZEKt1NMg6xuwpUDvVygNUF5AwyXQKUxaYUr8owUiPfmO4qYcXB2bMV30GVhSUSeylB32Z2DZWd95/qeRCJTRLkxbW2iaTXF4DEdj36rFEYXPCOrLIOgoSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WQNr5PAk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K8I5Um003084;
	Fri, 20 Sep 2024 10:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=y7LxHpfVp1Mq4iqv+Exi9v
	PM3Trh8VRLQFr7D4gTiYI=; b=WQNr5PAksmvMAmmbY1hgHC5Dh2ZbOP+lQWjZyF
	sjRi86PP1T0Y5qS/daqDj44VlMxfn5/ZkE3UIVSmJGZHwMtIDp99aFDxyxvkGudo
	7ZkC6prrU+aHUeUqM+Bk1J24KKlZ7sNekorVunIUb72B5EFLKhY/kNjXNQEubIMR
	QQrRCpWGvwIp+ZORZEIaZoXXTiikMIu5oTu632hIrTFOzQtBVqqhG8y4FX4oam/B
	LWI5wFkg4Cgq7EqJfTvqHNnIR498jhLTEMTpN41JzncDiSvsa3vuQCkzVTBwBZ7f
	hSa0W2yK8/YKtPAthPCONRrmhStiR2PZAjyxVGBdV0QaOeIA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4hf8n07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 10:18:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48KAIDnF015769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 10:18:13 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Sep 2024 03:18:08 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v2 0/2] PCI: qcom: Skip wait for link up if global IRQ
 handler is present
Date: Fri, 20 Sep 2024 15:47:58 +0530
Message-ID: <20240920-remove_wait-v2-0-7c0fcb3b581d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANZL7WYC/2XM0Q6CIBiG4VtxHEcDBpoddR/NNYWf/A+UAqOa4
 95DVweuw+/b3mcmATxCIMdiJh4iBnRjHmJXEN234xUomryJYEKymnPqYXARLs8WJ9oaWQp5MLq
 2jOTi5sHia9XOTd49hsn594pHvrw/R2ycyCmndWWl7awynVGn+wM1jnqv3bDA36r6r6QqjVCKd
 1qxTdWklD65D3am3gAAAA==
To: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_mrana@quicinc.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726827488; l=1232;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=5+mE99vUEO86YNsz7eLxuhzYb3eg7bR6IaZK1B1r8mQ=;
 b=hDP1REtSK1o650lpZFEB6L0HFBxfTJ4y+djKtZpfkvD8MP0LeE3y/cy4DzHszjwVKXrS/SK54
 Ao8iEYoS7vOBbPwGSAJbPMMS8JDG4LD/BorN6bPg5mUlMmktnOag3pB
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Crr89QNzf3_jbUeWkAO5EQUIUXBIbt_Y
X-Proofpoint-GUID: Crr89QNzf3_jbUeWkAO5EQUIUXBIbt_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=6 lowpriorityscore=6 spamscore=0 clxscore=1011
 mlxlogscore=560 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409200072

In scenarios where a global IRQ handler is available to manage link up
interrupts, it may not be necessary to wait for the link to be up
during PCI initialization. This change helps in reducing the overall
bootup time.

As part of the PCIe link up event, the ICC and OPP values are updated.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes in v2:
- Updated the bypass_link_up_wait name to linkup_irq  & added comment as
  suggested (mani).
- seperated the icc and opp update patch (mani).
- Link to v1: https://lore.kernel.org/r/20240917-remove_wait-v1-1-456d2551bc50@quicinc.com

---
Krishna chaitanya chundru (2):
      PCI: qcom: Skip wait for link up if global IRQ handler is present
      PCI: qcom: Update ICC and OPP values during link up event

 drivers/pci/controller/dwc/pcie-designware-host.c | 11 +++++++++--
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c            |  7 ++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)
---
base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
change-id: 20240911-remove_wait-ad46248dc9f0

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


