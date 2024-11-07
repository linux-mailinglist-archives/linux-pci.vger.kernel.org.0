Return-Path: <linux-pci+bounces-16200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E239BFF78
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 08:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E453B283FAA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 07:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A5719992D;
	Thu,  7 Nov 2024 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eiTX2o2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2417DE36;
	Thu,  7 Nov 2024 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966388; cv=none; b=sc5qQz2iAINGI/ld000jMgU9g1IP9fPNVGtJJ2Tuadr9VLCD3qlsiH7qv5XEyT4e3+j72H2mM5viaiQ3QHdjlsAmS238AYmcC2ADgXI/CE+J5PtW4ZekI3BgU7olpajfxpuvYHOq4dMGTWHSMIczMseGnxx/OHMnQ7Mo252kx8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966388; c=relaxed/simple;
	bh=O3P+QT8RqJpciDPv0u8HzpYTQchGjvvDTB1vWGDNx9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=NiGOfUb1E84Yt30PU+1A9RlVkB6qI8FX3L0ohZQBsP8I8SPkI8LDOm72BEGYFEc6/i+6LdqfKP5AZyNE3oVw5GLYiLMjDdxzZlwbCHyFrU9H6nE8jU1jHDffKccOP1giRigrHMYOfRcXuvkqcQSMpv6bQCky3Bp0i6+rKJRX2zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eiTX2o2H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A741Klr002000;
	Thu, 7 Nov 2024 07:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=d6d278GifGfNmgfl6SgiM2
	wyCkICizf2JQ410uFCu4M=; b=eiTX2o2HL5H9ANeNxHrOBe1+lRnQpgsrWqMZN3
	sg0enC6ojdHldvAGCMhKr4EIxb71gbjapLf8QGJdDb4aSsCCC1bwArNx9NjnRzFb
	mu0Hb+JJN6Baac7RZuYUuh1Ku2+SYv+UIZTQECw0Z9nM6mCev2jOWiqjM4GzU6+y
	cqKh5HQnx3r0AwIRZ2krYrczEBZ2bt2CtL1KdB0gdf344yrLV6Xxl7jhtE6bemfP
	LqpZhCAbAlYlkIzTfwK+oilwZKhsMokMnYxuOtR4NdmPyswYvvnEdVrtCp8L7GoJ
	vL5p0b/zLzI+2lB1pxVWRr62jZw/AfJTdT/eNdRGgEBAkQCg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r072m0fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 07:59:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A77xMcW001137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 07:59:22 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 6 Nov 2024 23:59:18 -0800
From: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Date: Thu, 7 Nov 2024 13:29:15 +0530
Subject: [PATCH RESEND] iommu/of: Fix pci_request_acs() before enumerating
 PCI devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFJzLGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwNz3YLkzPjE5OL4tMwKXSMjY8tUg7QkQ3MzCyWgjoKiVKAw2LRopSD
 XYFc/F6XY2loAnsqmrWUAAAA=
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin
 Murphy" <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: Joerg Roedel <jroedel@suse.de>, Rob Herring <robh@kernel.org>,
        "Marek
 Szyprowski" <m.szyprowski@samsung.com>,
        Anders Roxell
	<anders.roxell@linaro.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Xingang Wang
	<wangxingang5@huawei.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nbmcMKrkHS8BS2iYeBLUo55vRVtzp7rt
X-Proofpoint-GUID: nbmcMKrkHS8BS2iYeBLUo55vRVtzp7rt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070060

From: Xingang Wang <wangxingang5@huawei.com>

When booting with devicetree, the pci_request_acs() is called after the
enumeration and initialization of PCI devices, thus the ACS is not
enabled. And ACS should be enabled when IOMMU is detected for the
PCI host bridge, so add check for IOMMU before probe of PCI host and call
pci_request_acs() to make sure ACS will be enabled when enumerating PCI
devices.

Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when configuring IOMMU linkage")
Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
Earlier this patch made it to linux-next but got dropped later as it
broke PCI on ARM Juno R1 board. AFAICT, this issue is never root caused,
so resending this patch to get attention again.

https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com/

The original problem that is being fixed by this patch still exists. In
my use case, all the PCI VF(s) assigned to a VM are sharing the same
group since these functions are attached under a Multi function PCIe root port 
emulated by the QEMU. This patch fixes that problem.
---
 drivers/iommu/of_iommu.c | 1 -
 drivers/pci/of.c         | 8 +++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e7a6a1611d19..f19db52388f5 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -141,7 +141,6 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 			.np = master_np,
 		};
 
-		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
 		of_pci_check_device_ats(dev, master_np);
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index dacea3fc5128..dc90f4e45dd3 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -637,9 +637,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
 {
-	if (!dev->of_node)
+	struct device_node *node = dev->of_node;
+
+	if (!node)
 		return 0;
 
+	/* Detect IOMMU and make sure ACS will be enabled */
+	if (of_property_read_bool(node, "iommu-map"))
+		pci_request_acs();
+
 	bridge->swizzle_irq = pci_common_swizzle;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 

---
base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
change-id: 20241107-pci_acs_fix-2239e0fb1768

Best regards,
-- 
Pavankumar Kondeti <quic_pkondeti@quicinc.com>


