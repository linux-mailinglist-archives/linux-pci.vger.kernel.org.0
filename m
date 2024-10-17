Return-Path: <linux-pci+bounces-14803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAAC9A2705
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 17:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3020F2819ED
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5818B1E0B67;
	Thu, 17 Oct 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fGGsTqSo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F81E04AC;
	Thu, 17 Oct 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179388; cv=none; b=Vl6i14LH0JW9X48ZZAWy2GesebXlK2Kq4l6VPIamJVjzNYRlRnr7TrUiv3C66/McTxauXpULvk05tVUw6XtRqy4WsKorjK+Jr8kWodWfOznQZzV5/CLm4X5juwbKkHLmVp8QvrM04e6auGRd/6yOfV8KkXWzV8j3xcE0OgjRHvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179388; c=relaxed/simple;
	bh=FYFwF9IQhF/2ZpIDY/IKE6CrMGovTmqBCt3qf0VGisQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QKeDFict+NGLIbopWMQJ0Em6gy9yruF1srWu1DaC6ApzL6CEo3tLOOjm73GDdIBb16+dOgtjWJ1mxYUu7ruFPcb28iTThT3tnvordaHih1Jw7KJc5vrZkwcxNeCjMnZ/t0waoMfrqqS1kjOmBXv2GYzdIJzBtaEQAM+eOZiKiNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fGGsTqSo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H8ca8k027127;
	Thu, 17 Oct 2024 15:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oNGIvHQaSnaO1ycWZmCc8iBgwhg4leyZmHFIVZzwFmw=; b=fGGsTqSo5a2asN3C
	EZQ+UbCcg4cEIxydlA0+yVut79xzROpPi0tPsHOOCQNaciShdf6VDdkuggraoZkd
	YIXE5WZrNAyeY8B1Izg/rEiqTXEqeNw98X5Ql06H4KT8RuLzoHHTWqRP1BUdE8at
	FFe+b/EreK0mhQJkP5FV8Q1rpswscTo6lD4+xnN4bPAlc3FS1Ab+yh/S52M4y24M
	tM76Ks/O1e82Yk/OVvdkpwLzRJrferQyNO7PAWav8Wr4mcag3k0wBOknSPZxOjYf
	pKr2M1nkcftO6tfcFwgw0jQhvwj/dP1D2vQDcldQlQ/9dxeFWaVmWjFOA2u8Iet+
	ncO33g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ay8j958h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 15:36:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HFa1KZ020141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 15:36:01 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Oct 2024 08:35:57 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Thu, 17 Oct 2024 21:05:50 +0530
Subject: [PATCH v6 1/2] PCI: starfive: Enable PCIe controller's runtime PM
 before probing host bridge
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241017-runtime_pm-v6-1-55eab5c2c940@quicinc.com>
References: <20241017-runtime_pm-v6-0-55eab5c2c940@quicinc.com>
In-Reply-To: <20241017-runtime_pm-v6-0-55eab5c2c940@quicinc.com>
To: Kevin Xie <kevin.xie@starfivetech.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <Markus.Elfring@web.de>, <quic_mrana@quicinc.com>, <rafael@kernel.org>,
        <m.szyprowski@samsung.com>, <linux-pm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna
 chaitanya chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729179352; l=2328;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=LkSUXnpskxUCZXdVOigHiYq2slUxJStDgoZTxaSv+A4=;
 b=n2vYAjq1ecfh5OficIcWIjMruvqJXJbPO2aCagiY96l+paubKmxLA2SczzeuCMMCWYLJrw4v1
 gr6KsYueCJoB5XkIkZgrmINOh31MlQi2Lbzy93eZ7tngj3TVMxZ1ER3
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bKQ5105LXRbzbSTkAg4MAZZdNpfvx5og
X-Proofpoint-ORIG-GUID: bKQ5105LXRbzbSTkAg4MAZZdNpfvx5og
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170107

From: Mayank Rana <quic_mrana@quicinc.com>

PCIe controller device (i.e. PCIe starfive device) is parent to PCIe host
bridge device. To enable runtime PM of PCIe host bridge device (child
device), it is must to enable parent device's runtime PM to avoid seeing
the below warning from PM core:

pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device
with active children

Fix this issue by enabling starfive pcie controller device's runtime PM
before calling pci_host_probe() in plda_pcie_host_init().

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
v3->v6:
- no change
Link to v3: https://patchwork.kernel.org/project/linux-pci/patch/20241014162607.1247611-1-quic_mrana@quicinc.com/
v2->v3:
- Update commit description based on Mani's feedback
- Updated Reviewed-by tag
Link to v2: https://patchwork.kernel.org/project/linux-pci/patch/20241011235530.3919347-1-quic_mrana@quicinc.com/

v1->v2: Updated commit description based on Bjorn's feedback
Link to v1: https://patchwork.kernel.org/project/linux-pci/patch/20241010202950.3263899-1-quic_mrana@quicinc.com/
---
 drivers/pci/controller/plda/pcie-starfive.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index c9933ecf6833..0564fdce47c2 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -404,6 +404,9 @@ static int starfive_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	plda->host_ops = &sf_host_ops;
 	plda->num_events = PLDA_MAX_EVENT_NUM;
 	/* mask doorbell event */
@@ -413,11 +416,12 @@ static int starfive_pcie_probe(struct platform_device *pdev)
 	plda->events_bitmap <<= PLDA_NUM_DMA_EVENTS;
 	ret = plda_pcie_host_init(&pcie->plda, &starfive_pcie_ops,
 				  &stf_pcie_event);
-	if (ret)
+	if (ret) {
+		pm_runtime_put_sync(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
 		return ret;
+	}
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
 	platform_set_drvdata(pdev, pcie);
 
 	return 0;

-- 
2.34.1


