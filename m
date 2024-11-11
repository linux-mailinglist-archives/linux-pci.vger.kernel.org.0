Return-Path: <linux-pci+bounces-16437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C9C9C39D5
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 09:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595E9B21677
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 08:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3674F16C453;
	Mon, 11 Nov 2024 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GKoDbxpz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC23158533;
	Mon, 11 Nov 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314539; cv=none; b=p7cBCk5JzJNEKYibQRIeyqPkzHpMV4j3D55i4Zzmi3ZDT2rBPGHk5FIdtDoE5Ogdsbztcxi5BH1+1i3/0IHLWVLWkqw9eU8mkQ9H0mwPzFavmGeeCC8rhhNRO1ULT2a4LQGpDADdziGo/lrvjCZpfgMQUG9pM0qYdIkprOA5g60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314539; c=relaxed/simple;
	bh=FYFwF9IQhF/2ZpIDY/IKE6CrMGovTmqBCt3qf0VGisQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PDCH5du4nyK0lmjLIGWh+AsVnCGC/tGGcrwV2msiXUmsjIvhSNA3uWmsdCHq9UVXaWb9tqiloJkGzIDH8+ZjP9GC7eMvprQICSr4VK3xEO0PLAuMKbOU80fRHvJm35QwDl1Or5e5bg80cv3ZGV6rjbeOS8LGfcWVxzv1GZggFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GKoDbxpz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAMQlPV031792;
	Mon, 11 Nov 2024 08:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oNGIvHQaSnaO1ycWZmCc8iBgwhg4leyZmHFIVZzwFmw=; b=GKoDbxpzBDwBaxSx
	mJjt7d1WrXT3Pgxrc5QH0pgZwpdlegvTcXWasKt+nNaQHBo5xEh8HF7VnSh9k+Ex
	fTgC8AwyRlBIGI94BZxLSXNnOjtBcFYNmIvQkpNUemHLPWAjGLL2alGCJ5fMlVrP
	dU9JLsC25nbr21+PbCFyhn9xCe2zdQK8fHF1VdRwzt3SW5nml3zFaM7qpBRViIIl
	uG3Py9Wqk8EYozcXVrGPkd566DrlZDGYL7iOww/GrcAxyWnPhpEJcXldRn0nMgh1
	7f8mY2McqI4pmeDC+YowJB0UBZ/aiF382amMX5AlTPWclvSk1cz3ZGO/atvSY6lH
	49xJfQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t1183kxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 08:42:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AB8g42e013452
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 08:42:04 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 00:42:00 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Mon, 11 Nov 2024 14:11:52 +0530
Subject: [PATCH v7 1/2] PCI: starfive: Enable PCIe controller's runtime PM
 before probing host bridge
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241111-runtime_pm-v7-1-9c164eefcd87@quicinc.com>
References: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
In-Reply-To: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731314516; l=2328;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=LkSUXnpskxUCZXdVOigHiYq2slUxJStDgoZTxaSv+A4=;
 b=u1VsbdYGpV+Ps5X2MpD+63Cchas25RaV5HTsyz8v6hOkhg+zf5wGX031Vr2/wNqe7FW4fi7qj
 RWcgycDwczUBgGY9YLTZISmYsvBJ138aeJr0dCfkSCcPjaliCoA/FZs
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: An1NOA8y9oJ9KngL8gLHNsjTIEgGVQRV
X-Proofpoint-GUID: An1NOA8y9oJ9KngL8gLHNsjTIEgGVQRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110073

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


