Return-Path: <linux-pci+bounces-10062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1234292D029
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43EB81C215FF
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4191A18FC9B;
	Wed, 10 Jul 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nhCfGdwW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26C18FC93;
	Wed, 10 Jul 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609729; cv=none; b=qHEK3ehOTo81xSdTbFKkxHEjHxvL6nYM13t/8RIlKIYV0Sy6J9g/UNoXv+mf9MoLWdjkv30tDYs2GRStupi1tCfra/VLUOHQrBpqkBqQw3fgJs6h6jPi6VmbxTfjFvRlJoKN+Zjs2LzE1ez81BJkIaTF3g+KW4EXiPKD3W9B7zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609729; c=relaxed/simple;
	bh=XOduevt12KJoM7kk2G+iH0+X8pg3PXAFyEyZo4rarLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=soE2se2LhQAU9kFK1j+H22lU7QYQLzh28JH+6MYKOucuk7QsUuAdy1R1ztpYPv9KffBy0xUJ0OADxK8sOEwWNAJjxJn+MwqCQYeicF3k3j8jxeat4iM+pxoP5dZZLqogb8Cs9QJ/2l4KZWH1ITzZIEq358ITZGLzOOBwqb+jqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nhCfGdwW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A1r67I023826;
	Wed, 10 Jul 2024 11:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wd8RUShlifszI5a0jnf64KZlAVHX2xPTDOgscwTojIo=; b=nhCfGdwWI7N3NEss
	BlL5GgLh9GeJ+TpXp+R0tVGwh/quWUYtcaLMXXLqAVD0/VFL+VvgsPIAp8iN8ovz
	f+iUVft7sHzkxnk96TdH22GW6ZtpEXs7iSqLR0jh54Ij2AZgecKV0tkbwSt5X6sN
	Tpdqh9QRzECYN+/yVH51mw2VhfDqTtk121/LFUK660ZEuLVmZA2G2/KgjvsVgGiV
	d4Me+uVXfLVMuLoyQN1U1cxJnQIUXdKqOF50NAxvxp7JVTlSpFWWqg4GU9K0Kyjn
	29s/d+SwIYYDL0XbMVvzoYaiYOVoQH06896z+btIwvJWUCvb5TREv+keVki2/yER
	J03CBg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgws4ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:08:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46AB8ZrK019132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:08:35 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 04:08:30 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 10 Jul 2024 16:38:15 +0530
Subject: [PATCH v7 2/4] PCI: qcom-ep: Add support for D-state change
 notification
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240710-dstate_notifier-v7-2-8d45d87b2b24@quicinc.com>
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
 chundru" <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720609699; l=1753;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=XOduevt12KJoM7kk2G+iH0+X8pg3PXAFyEyZo4rarLQ=;
 b=wWADPoXYJKHEu6BYwolVaoxg1v3AEgMxQj23Sp1uJDpkuA93xi3CyxJ5fCwgZKj/vnMB4CXP+
 luLRziCEAaoCu3RUf1NpPEhJhGCRDN0EjzsDU0oSyW7Dguwhkx/r8xF
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f1RTkZDtVzx4dkzRIHuT_uUgAWqkmOPm
X-Proofpoint-ORIG-GUID: f1RTkZDtVzx4dkzRIHuT_uUgAWqkmOPm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100076

Add support to pass D-state change notification to Endpoint
function driver.
Read perst value to determine if the link is in D3Cold/D3hot.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 236229f66c80..817fad805c51 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -648,6 +648,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	struct device *dev = pci->dev;
 	u32 status = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
 	u32 mask = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_MASK);
+	pci_power_t state;
 	u32 dstate, val;
 
 	writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);
@@ -671,11 +672,16 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
 					   DBI_CON_STATUS_POWER_STATE_MASK;
 		dev_dbg(dev, "Received D%d state event\n", dstate);
-		if (dstate == 3) {
+		state = dstate;
+		if (dstate == PCI_D3hot) {
 			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
 			val |= PARF_PM_CTRL_REQ_EXIT_L1;
 			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
+
+			if (gpiod_get_value(pcie_ep->reset))
+				state = PCI_D3cold;
 		}
+		pci_epc_dstate_notify(pci->ep.epc, state);
 	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
 		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
 		dw_pcie_ep_linkup(&pci->ep);

-- 
2.42.0


