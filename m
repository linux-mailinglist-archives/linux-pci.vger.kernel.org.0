Return-Path: <linux-pci+bounces-14347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1C99AF8F
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 01:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5632845D8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 23:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038471E412E;
	Fri, 11 Oct 2024 23:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o59QYlb9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07B1CF5E9;
	Fri, 11 Oct 2024 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728690978; cv=none; b=WpMeyJp1dUl1VBQ8ShFJfv2VUJcR5qnWo1hevTsdm51zRfyBxsD38Hh0qldTxBnq20cF4AVvQiqL3lZ4kVWdOKLFlpAeGaHiWdRfhC85f6ZMPnvpM22RM6mpUetqzpPaG1ep14spAQXlX6a2cmsODCcYQU/X2TfGypWEmxJKWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728690978; c=relaxed/simple;
	bh=5ZeN+w1TlKpQAXQgtvr0eMbGMhoWYZLtATm+VLysGFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N5M0IljyGlQ0atigWmDAlhxsyvf8mUhmckjtpUMhqzQqLTwl/yzDWZYKT9E44D+Vq413qVZxz/vuvD/3qp7V3p0oky7cYFp7CTCPpnswaEk8WMEu10p/RZeXbCbnVvV4w0EdoTsJKhzADjAXB9ub0fiywFCnB3Laaf2mkJ96A2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o59QYlb9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BMJX6k020808;
	Fri, 11 Oct 2024 23:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DdO/8oZ8WDuh2PYHuntokC
	1urhIvqwT2jVcBmKB6Lh8=; b=o59QYlb9siv/y7NQvReRwjlSo5hA9/2BFw4w+o
	AyND7RziEwI9WOhPGhYd9mN++bK1NiLQkg6BXYnGSBtr4UpQSjtciRj8TdEZhtqn
	8WQVGbIQEUXkn0E0xGEqHBfjRJ6RUfAL2WJriBUszagBlO000P8hb3b8EEDohxlk
	M3pQMQU2CXVrQYH3VHxxVAGyqpZ+zD+COIzH3C0q3mMsKGrnLvwCU6atOB3QF5YC
	ah6/kmzGy5SZXaXOmn8PpKeVGEnoS24ah0yj6aEYFADRIXgd9eUi5wU6/NlvJMK7
	w5C8LZUM6aly4SHw6C9kZjlUn9D3Mo88NiyWf0US2lUKaQJQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426t7su562-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 23:55:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49BNtjW2029203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 23:55:45 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 11 Oct 2024 16:55:45 -0700
From: Mayank Rana <quic_mrana@quicinc.com>
To: <kevin.xie@starfivetech.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_krichai@quicinc.com>, Mayank Rana <quic_mrana@quicinc.com>,
        "Marek
 Szyprowski" <m.szyprowski@samsung.com>
Subject: [PATCH v2] PCI: starfive: Enable PCIe controller's runtime PM  before probing host bridge
Date: Fri, 11 Oct 2024 16:55:30 -0700
Message-ID: <20241011235530.3919347-1-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QnJJYOInGiRbo6vFN01FGD5MtSZjHDI2
X-Proofpoint-ORIG-GUID: QnJJYOInGiRbo6vFN01FGD5MtSZjHDI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110166

PCIe controller device (i.e. PCIe starfive device) is parent to PCIe host
bridge device. To enable runtime PM of PCIe host bridge device (child
device), it is must to enable parent device's runtime PM to avoid seeing
WARN_ON as "Enabling runtime PM for inactive device with active children".
Fix this issue by enabling starfive pcie controller device's runtime PM
before calling into pci_host_probe() through plda_pcie_host_init().

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
v1->v2: Updated commit description based on Bjorn's feedback
Link to v1: https://patchwork.kernel.org/project/linux-pci/patch/20241010202950.3263899-1-quic_mrana@quicinc.com/
 
 drivers/pci/controller/plda/pcie-starfive.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 0567ec373a3e..e73c1b7bc8ef 100644
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
2.25.1


