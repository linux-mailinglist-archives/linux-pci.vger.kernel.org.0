Return-Path: <linux-pci+bounces-10063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B28992D032
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1B51F25694
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 11:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0B191493;
	Wed, 10 Jul 2024 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RFHEYJUB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B2C191464;
	Wed, 10 Jul 2024 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609733; cv=none; b=pxZOYddGSuK447yPGUN0jWE5762Ppo+mMhAh9zS6Qn32uiT65WDRva1dqBo/7ySoNvnC1JKrdIO0xODdjIHqLZNbJK05afltD7od/0dimvRfztyYH2v7WsCUWCkwgaOP99BV/fktZIuKYtPgqJ2yJF6WsdtVWaty0T/ZxUj+x+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609733; c=relaxed/simple;
	bh=w9gnQmyl5A12feNUHfhRuEpH+/zjXWf3KW3p4lBJy2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PqEA4Ghz3p4DXilXADASPVOlCago/0WcVaR668Z8RhKmzfXKWZFCbmnVbBAn2c8TEryKcV6QYpZqK3/nrXmdFDQHfeow0x0Wl76Jdf2gHlg9bgeuNRuT03IuLUs4hQU2ck56TNFDZO6tc6FrZzHj1FiC24GyL3uwulSnHuwjIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RFHEYJUB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A3F78V003892;
	Wed, 10 Jul 2024 11:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/9iAwqi9erBXHpKZzSP0R0d36nSwNngqXaL2NVc/U9s=; b=RFHEYJUBiNGSXmbK
	z+gPZEh8QgYAOQ2XxNKvc3ZnQ+Jyaraz+ZY6+4sC0jNoLK3GTjRIniZqDCWk3xLz
	mgRWAlIolnBRqj3VoD5mp2Fo5qwgxNTQukEWcKXvrPLpeuNIQB9XEAW21VUqFypq
	KA/uyRqdG4LpJkuGhV8lMKdLT6WancJe5+TvbFgTTL27xCfq2E066VMiU5/GavJp
	9eq4Oy9/G0bYSIl8Icdp0RshLWddyhxArmHH1LaNhaJ0dPbZTXNvKZ/pP0+0oazB
	XNAGnMfit89LK6RK8ro7bI6bLQGceQRFStHdfB5dsWG7eRwaF9WvlYTMDG3ccdov
	sszQYA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 408w0rbyf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:08:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46AB8eeG026021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:08:40 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 04:08:35 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 10 Jul 2024 16:38:16 +0530
Subject: [PATCH v7 3/4] PCI: qcom-ep: Print D-state name to distinguish
 D3hot/D3cold
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240710-dstate_notifier-v7-3-8d45d87b2b24@quicinc.com>
References: <20240710-dstate_notifier-v7-0-8d45d87b2b24@quicinc.com>
In-Reply-To: <20240710-dstate_notifier-v7-0-8d45d87b2b24@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring
	<robh@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>,
        "Krishna chaitanya
 chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720609699; l=1363;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=w9gnQmyl5A12feNUHfhRuEpH+/zjXWf3KW3p4lBJy2Y=;
 b=a2yZBqb6puFfVY0WmOsaDIg3b0XtRtmrSj3LKau8qBU1WId1IyDmHrSmCxYnEuG0sHVGo3gWy
 2wd82/JlcvaDxTwxaXW6EiGs/aBZJVJtLjpfhWVrU6nT8f/2ohkt53Z
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NQU-whWjXRBSU-8Fez3ZiI-akkRy1QzD
X-Proofpoint-GUID: NQU-whWjXRBSU-8Fez3ZiI-akkRy1QzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=812
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100076

Now that the state event is stored as pci_power_t, use the PCI helper
pci_power_name() to print the state event.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 817fad805c51..627a33a1c5ca 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -671,7 +671,6 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_DSTATE_CHANGE, status)) {
 		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
 					   DBI_CON_STATUS_POWER_STATE_MASK;
-		dev_dbg(dev, "Received D%d state event\n", dstate);
 		state = dstate;
 		if (dstate == PCI_D3hot) {
 			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
@@ -681,6 +680,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 			if (gpiod_get_value(pcie_ep->reset))
 				state = PCI_D3cold;
 		}
+		dev_dbg(dev, "Received %s event\n", pci_power_name(state));
 		pci_epc_dstate_notify(pci->ep.epc, state);
 	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
 		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");

-- 
2.42.0


