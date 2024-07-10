Return-Path: <linux-pci+bounces-10066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4257592D072
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE400B28722
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 11:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E9E18FDD5;
	Wed, 10 Jul 2024 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F+J7P5MT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422E18FDB1;
	Wed, 10 Jul 2024 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610202; cv=none; b=Nf5v/8U80sTRT7df0+vwT1YnborOJNgMZJtmGqVZZ/WYC8HsdEyLUWOBGL63T+XKUmp60MhaY/lEWqRiJyBwb2SRbVkZfDIu9T7uv8mwmBzsYks9rWD9+qMlKSFhqRxUwQMszoN1PB2LhBzekdZp6HQ5Dq5banMj+qUbkrKqnaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610202; c=relaxed/simple;
	bh=uDx/qr8T53j8QG9+AX/cxRZ0fvEV0MUjVh9NbwXBST8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kEL9Z++lbOVHJ/nHDC4qvDSyfAcnDRSumkDb2ZcKo8UCuQLzaTia0Ng2SNAiepdDEpsJqIyoGxzfWZO6L5PBVi5AqUxF2X1V6gDOqKLFEF2Uqg88CgxjReKRKs2gINRijpfWSh5hZhEhM+ZdpokrJLi2HVz/SXjtnmZ3Tio3bdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F+J7P5MT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A8Z2Iv012874;
	Wed, 10 Jul 2024 11:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X8cjMTXcox8m3NPOkA8a/E1JBaOaqejSji5syS36ki4=; b=F+J7P5MTemVHAemG
	BSIrIn+OIM+Uy0JtIWRuBYH37sxhHCl5KHVRGAq03BLtyWeJHKqnUaDtPQ0y3cOy
	WCPfEV5GwiLj3eLvd20h82lOOL/IVVKRFQKdLVFAAuPLas1pEx8VUqM/ivKzueLd
	jinrWDAFcKGcKjFprj/0j0c0Y68bvLAkVcdej2UuD6OZodefkPF8Ze5voLMcTkQP
	rMay6EGL3GBx/whnvWnqrumROdYjOqNiXoEE0J4RDH5t8rcCDMIu2DMXpgX4RfRj
	KNKCZKTTgTvbELwGOrbg/dJ6AV2jFgkWWcMA8aYt1Jk9tiyr6kdleiGp6ZbrtLQr
	Ql2G9g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4091jdke6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:16:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46ABGX6q005713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:16:33 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 04:16:27 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 10 Jul 2024 16:46:10 +0530
Subject: [PATCH v6 3/5] PCI: qcom-ep: Add wake up host op to dw_pcie_ep_ops
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240710-wakeup_host-v6-3-ef00f31ea38d@quicinc.com>
References: <20240710-wakeup_host-v6-0-ef00f31ea38d@quicinc.com>
In-Reply-To: <20240710-wakeup_host-v6-0-ef00f31ea38d@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720610170; l=2055;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=uDx/qr8T53j8QG9+AX/cxRZ0fvEV0MUjVh9NbwXBST8=;
 b=GzHBAp3aeM7mkPaZOziPUGOcmwTmjB63HODT8g9AGs/J0w9q4o12pQlr9RmZDnb59NaBn5+eC
 pbDYfgAGCXBA+r7Nyt4e5bJJXPmNb+TpzeUMDlZiZUjhb1PS8XgXAqw
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YdDlitXaJlIaWKal9F3bGljH2EbXo3p8
X-Proofpoint-ORIG-GUID: YdDlitXaJlIaWKal9F3bGljH2EbXo3p8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407100077

Add wakeup host op to dw_pcie_ep_ops to wake up host.
If the wakeup type is PME, then trigger inband PME by writing to the PARF
PARF_PM_CTRL register, otherwise toggle #WAKE.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 627a33a1c5ca..d17e8542d07a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -97,6 +97,7 @@
 /* PARF_PM_CTRL register fields */
 #define PARF_PM_CTRL_REQ_EXIT_L1		BIT(1)
 #define PARF_PM_CTRL_READY_ENTR_L23		BIT(2)
+#define PARF_PM_CTRL_XMT_PME			BIT(4)
 #define PARF_PM_CTRL_REQ_NOT_ENTR_L1		BIT(5)
 
 /* PARF_MHI_CLOCK_RESET_CTRL fields */
@@ -817,10 +818,34 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
+static bool qcom_pcie_ep_wakeup_host(struct dw_pcie_ep *ep, u8 func_no, bool send_pme)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
+	struct device *dev = pci->dev;
+	u32 val;
+
+	if (send_pme) {
+		dev_dbg(dev, "Waking up the host using PME\n");
+		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
+		writel_relaxed(val | PARF_PM_CTRL_XMT_PME, pcie_ep->parf + PARF_PM_CTRL);
+		writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
+
+	} else {
+		dev_dbg(dev, "Waking up the host by toggling WAKE#\n");
+		gpiod_set_value_cansleep(pcie_ep->wake, 1);
+		usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
+		gpiod_set_value_cansleep(pcie_ep->wake, 0);
+	}
+
+	return true;
+}
+
 static const struct dw_pcie_ep_ops pci_ep_ops = {
 	.init = qcom_pcie_ep_init,
 	.raise_irq = qcom_pcie_ep_raise_irq,
 	.get_features = qcom_pcie_epc_get_features,
+	.wakeup_host = qcom_pcie_ep_wakeup_host,
 };
 
 static int qcom_pcie_ep_probe(struct platform_device *pdev)

-- 
2.42.0


