Return-Path: <linux-pci+bounces-8565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57B4902DD9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 03:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773862812E8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 01:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6DF5684;
	Tue, 11 Jun 2024 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KN7R0Nf2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE734A3C;
	Tue, 11 Jun 2024 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718067941; cv=none; b=bho2fo19GA7ZqzhyZirg+YDOyRFSEKTHRYRwfQQYQdIsGzWRvh5KDfKbuTR0PVgEp5VnPXKJ3493pIS0bnNiIuP34J4tNP4xpnfVBfLvBOCet+MD0GPi7Gmjv4sJV5hXfs7K2y2mftFzl+hi0C25J4jCRynAHiutSQieu5bV/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718067941; c=relaxed/simple;
	bh=ge3WNPChowfJ9xwXV3CX+W31PKAPLwlVcLRe2hvtAG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=pib9NOHRUCzA+PIISewsJ+gXqJB0mhcAdvlBiYTaleVY4mBLb0wbbMUpWDdy5zfOlNXMU9uRv70of4Hnt+vhBsw7l0HlVza8sKXcnfyg5RwgzrZJ4jVlg2LyqSF/mbcF6icnS0DAkvznN4gQnFwbuWDrm8YsMYew8FB7IbKshB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KN7R0Nf2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AEW8tl013033;
	Tue, 11 Jun 2024 01:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iEV+wtttF/HmiLFMR3m0w0
	YXhXQiADJkx45Bd3OvZMM=; b=KN7R0Nf2Nkwy+JOs8ywMg2sxvkJHA146TbSpTs
	xwwDT0xOOTGlL0QuSvr1AkyiL/cXrr00VOMmo6p3qhYBtdXxrJRDYcHYZylKTzR1
	F3AHj5MsR4fKFkt8gUek2dnQzn3MoWW4Ryom050PZ4/oNYou/N8UUgZx5NQyTJP1
	YF+p9itbzUN+G0GKN/Pcisu1Jmwdcu8X8ieumTUzNVARyTU1NoE2OYvLMkzWQj++
	DguTUW8oBk287O60nTIg8r5ZxQEZxyoUPvZTOYLmBB7dnXKqxP1+BIwLTCJ1kOEq
	DgGwRt5Wot5LG12Exn8yKDm2RjnMotE97WMKPrQNSYJ+J5rw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymevxd1b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 01:04:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45B14aYd001761
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 01:04:36 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 18:04:35 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 10 Jun 2024 18:04:34 -0700
Subject: [PATCH] PCI: controller: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240610-md-drivers-pci-controller-v1-1-b998c242df55@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKGiZ2YC/x3MTQqDMBBA4avIrDsQg5TYq5Qu8jOtAzGRGRVBv
 HvTLr/FeycoCZPCoztBaGflWhr6Wwdx8uVDyKkZrLGDufcG54RJeCdRXCJjrGWVmjMJukRuHJy
 3YbTQ+kXozcf//Xw1B6+EQXyJ0++YuWwHzl5XEriuL6EYi92KAAAA
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar
	<alim.akhtar@samsung.com>, Will Deacon <will@kernel.org>,
        Joyce Ooi
	<joyce.ooi@intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier
	<maz@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang
	<jianjun.wang@mediatek.com>,
        Sergio Paracuellos
	<sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "Nirmal
 Patel" <nirmal.patel@linux.intel.com>,
        Jonathan Derrick
	<jonathan.derrick@linux.dev>
CC: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>,
        "Jeff Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7EIM1q206qfKXhpTsEGhgPAi_KLGT2EI
X-Proofpoint-GUID: 7EIM1q206qfKXhpTsEGhgPAi_KLGT2EI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_08,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110006

When ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/dwc/pci-exynos.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pci-host-generic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-altera.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-altera-msi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mediatek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mediatek-gen3.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/vmd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-apple.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mt7621.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Corrections to these descriptions are welcomed. I'm not an expert in
this code so in most cases I've taken these descriptions directly from
code comments, Kconfig descriptions, or git logs.  History has shown
that in some cases these are originally wrong due to cut-n-paste
errors, and in other cases the drivers have evolved such that the
original information is no longer accurate.

Also let me know if any individual changes need to be split into a
separate patch to go through a separate maintainer tree.
---
 drivers/pci/controller/dwc/pci-exynos.c     | 1 +
 drivers/pci/controller/pci-host-common.c    | 1 +
 drivers/pci/controller/pci-host-generic.c   | 1 +
 drivers/pci/controller/pcie-altera-msi.c    | 1 +
 drivers/pci/controller/pcie-altera.c        | 1 +
 drivers/pci/controller/pcie-apple.c         | 1 +
 drivers/pci/controller/pcie-mediatek-gen3.c | 1 +
 drivers/pci/controller/pcie-mediatek.c      | 1 +
 drivers/pci/controller/pcie-mt7621.c        | 1 +
 drivers/pci/controller/vmd.c                | 1 +
 10 files changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index a33fa98a252e..79d83fe85d3b 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -437,5 +437,6 @@ static struct platform_driver exynos_pcie_driver = {
 	},
 };
 module_platform_driver(exynos_pcie_driver);
+MODULE_DESCRIPTION("PCIe host controller driver for Samsung Exynos SoCs");
 MODULE_LICENSE("GPL v2");
 MODULE_DEVICE_TABLE(of, exynos_pcie_of_match);
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 45b71806182d..60f5e328314e 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -96,4 +96,5 @@ void pci_host_common_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_host_common_remove);
 
+MODULE_DESCRIPTION("Generic PCI host driver common code");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index 41cb6a057f6e..cb911863a3cb 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -86,4 +86,5 @@ static struct platform_driver gen_pci_driver = {
 };
 module_platform_driver(gen_pci_driver);
 
+MODULE_DESCRIPTION("Simple, generic PCI host controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index 6ad5427490b5..25ad1717f1d8 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -290,4 +290,5 @@ static void __exit altera_msi_exit(void)
 subsys_initcall(altera_msi_init);
 MODULE_DEVICE_TABLE(of, altera_msi_of_match);
 module_exit(altera_msi_exit);
+MODULE_DESCRIPTION("Altera PCIe MSI support");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index a9536dc4bf96..ef73baefaeb9 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -826,4 +826,5 @@ static struct platform_driver altera_pcie_driver = {
 
 MODULE_DEVICE_TABLE(of, altera_pcie_of_match);
 module_platform_driver(altera_pcie_driver);
+MODULE_DESCRIPTION("Altera PCIe host controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index f7a248393a8f..5850bc84d58d 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -839,4 +839,5 @@ static struct platform_driver apple_pcie_driver = {
 };
 module_platform_driver(apple_pcie_driver);
 
+MODULE_DESCRIPTION("PCIe host bridge driver for Apple system-on-chips");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 975b3024fb08..b7e8e24f6a40 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1091,4 +1091,5 @@ static struct platform_driver mtk_pcie_driver = {
 };
 
 module_platform_driver(mtk_pcie_driver);
+MODULE_DESCRIPTION("MediaTek Gen3 PCIe host controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 48372013f26d..7fc0d7709b7f 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1252,4 +1252,5 @@ static struct platform_driver mtk_pcie_driver = {
 	},
 };
 module_platform_driver(mtk_pcie_driver);
+MODULE_DESCRIPTION("MediaTek PCIe host controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index d97b956e6e57..9989e5e614b9 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -549,4 +549,5 @@ static struct platform_driver mt7621_pcie_driver = {
 };
 builtin_platform_driver(mt7621_pcie_driver);
 
+MODULE_DESCRIPTION("MediaTek MT7621 PCIe controller");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..e4d6ae7241fe 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1128,5 +1128,6 @@ static struct pci_driver vmd_drv = {
 module_pci_driver(vmd_drv);
 
 MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Volume Management Device driver");
 MODULE_LICENSE("GPL v2");
 MODULE_VERSION("0.6");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240610-md-drivers-pci-controller-8de8948a2b92


