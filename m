Return-Path: <linux-pci+bounces-14485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 491B199D4A0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 18:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAFDCB255D7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAB71AE01F;
	Mon, 14 Oct 2024 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jW5/jYIv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E428FC;
	Mon, 14 Oct 2024 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923208; cv=none; b=M7rHiuOEgl+Ou3Md1F6bCLML41FOmEl3SXE4l/s8wQROBglZgIy3vfqx+4nev1Zg0Be7pq3cbec738D7L1UHvOKYKpRdsS9Wl+h31VVNaAunnxzl4OT4d5yPjog5fIkoQ0KQatrasGfQBWYSV4xcI/8Ae1Y2pfj1oMhLr1JFl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923208; c=relaxed/simple;
	bh=k9Br7NGn1JUJDdpw4cdkfc2viP9z4pXwuv/4rditTgM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t+KyLzsoX16fXoJHHAFGcd9XCbD+pB4+CZDutjGZo7VcBnSLsnXfdZOO7/NlndSdUr9lMCnII53T7LvArbQ2l1vSBkaj/lM0U7c//CUaUiH8wYKNu9JxvjhEK0pWMhEW/JgFA2xAJ68kZblJhqxdSIhhPPz2d0tfbprsNDjLGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jW5/jYIv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAjHBR029461;
	Mon, 14 Oct 2024 16:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tcbhP5eT086myskRJMszrU
	ovLk1dvJ9QFpMPp6xbhxM=; b=jW5/jYIvnNMLYuKcwxMW2YdqWSV34aBeQz1nCJ
	WqrnEtRU9c8i17xDveNtcnRJ+rozNO8Fc6I5/tlyu18A0Ub0JNFxIngRKdk3Wnn1
	k8p5cVqW8j5Bui/GNCoyLzBU388/Lu1TSYqVvQfHk89CxSnVP7F0TVEv4HoqbnLP
	IfgsfaBUn3IrdBhIeKCkxmcB/JWMeP4pgn4+nKpSjlFXyzmJTqvCp6J65HUpfs5T
	+okBxKL1bcMe6Mwl4+Jnwhm1/KiUBum8Wt7WJy0QSw7dWMDYjbEO8SzUqCr+qZdL
	fZGBG+JnoCU7cOlCNe55sCRaJi8bC9o7LXVHzPY9XOLrHCPw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427jd8vx0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 16:26:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49EGQQr0000507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 16:26:26 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Oct 2024 09:26:26 -0700
From: Mayank Rana <quic_mrana@quicinc.com>
To: <kevin.xie@starfivetech.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_krichai@quicinc.com>, Mayank Rana <quic_mrana@quicinc.com>,
        "Marek
 Szyprowski" <m.szyprowski@samsung.com>
Subject: [PATCH v3] PCI: starfive: Enable PCIe controller's runtime PM  before probing host bridge
Date: Mon, 14 Oct 2024 09:26:07 -0700
Message-ID: <20241014162607.1247611-1-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FeoM34QLfoUxiLkmq9s0PbLfuQAorsip
X-Proofpoint-ORIG-GUID: FeoM34QLfoUxiLkmq9s0PbLfuQAorsip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140118

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
v2->v3:
- Update commit description based on Mani's feedback
- Updated Reviewed-by tag
Link to v2: https://patchwork.kernel.org/project/linux-pci/patch/20241011235530.3919347-1-quic_mrana@quicinc.com/

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


