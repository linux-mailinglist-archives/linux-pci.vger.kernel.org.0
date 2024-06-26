Return-Path: <linux-pci+bounces-9326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE61091882E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 19:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367FA1F2117D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A425918FDC6;
	Wed, 26 Jun 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oWTPPIh2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C8F18FDC3;
	Wed, 26 Jun 2024 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421667; cv=none; b=NgTZs2wt01Ncvip9/BadwJsX5QEkf7n2+W4OX5kFw4K4Mk/ThCE7u6RFDbvfnbGZM11CQhLCCFp6RHST1I7JxeSQL3Lptzc4iCJiboqNvN8W0CIve/o7PzCyrRGqIavVj3eLtGv1VbppadX22e39cBT179JV1L/LVoQJMitNLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421667; c=relaxed/simple;
	bh=oxQZkX3Fk10UtY8kTR8wn4YJhoUPmskzn0OLNWOBAWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=F8CWlUZlTx+33BAlgQdhq8Pa9A4PqIAzlDRrLMoSznMXHSKRDW2QrBuwHmeNBPyUtsZzgfGbe1/KSrfeh7LGYeyd+ZpCmXmplrL/hL5aiKAq6Oz5Dj2EJ7iypqDJsT6OD1hFNk7at3eYeVZvlYR+q01z+n4MGnM6seQRzgzofN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oWTPPIh2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfJcS029739;
	Wed, 26 Jun 2024 17:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7WuQrotKCjs+y+VTNTpnxm
	SDTsA4KaqgNw6FEkiGJ+U=; b=oWTPPIh2ir48moBu8/0Lw+aZ1+oh1ItKN0gqdM
	Jrh3q/a2zc/0J00QZUpubzaE96o5a1NLtCwQVIDoOSGP/aXZnkzthD49jKGFI4Ou
	/brEshgg7Xz1M/7qLW/W/fp48oyhhErcvtxrsci1mWvP/s9ODHEs7ja5/oJ8vQQZ
	ihMn3YCc926OyEoOq9Zy3OMVkS4NqQCY/RVfmV5seAlAHNyDvCJdPOMQx22OJNot
	2nK/mbj21bRMWSLMwCYljYOwmm7MMFYNMc5+b9tOmZsKu8da4nh5FFMH4DIdku+s
	5F9XSpG9kAI1NmQErJa072GNQNFhGp8aYzsb/3Wfx3rXBfBQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400c469veg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 17:07:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QH73ww014766
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 17:07:03 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 10:07:03 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 26 Jun 2024 10:07:01 -0700
Subject: [PATCH v2] PCI: controller: add missing MODULE_DESCRIPTION()
 macros
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-md-drivers-pci-controller-v2-1-94c811db7a51@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALVKfGYC/42OTQ6CMBCFr0K6dgw0YIor72FY9GeQSaDVKTQYw
 t0tnMDll7z3vbeJiEwYxb3YBGOiSMFnkJdC2EH7FwK5zEKWsi5vVQmTA8eUkCO8LYENfuYwjsi
 gHKq2VlqaVorcfzP2tJ7uZ5fZ6IhgWHs7HMaR/LLCpOOMfMQHinPg7/kkVUfpn9FUQQWmbZWVt
 XR90zw+C1ny9mrDJLp933+azXEq4wAAAA==
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
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Pp_ugrtXN2NnNxBk5z3CSJw--DMyIJx1
X-Proofpoint-GUID: Pp_ugrtXN2NnNxBk5z3CSJw--DMyIJx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_08,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260125

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

Acked-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com> # MT7621
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
Changes in v2:
- no changes to the actual patch, just rebased to recent linus/master
  and collected the tags received so far
- Link to v1: https://lore.kernel.org/r/20240610-md-drivers-pci-controller-v1-1-b998c242df55@quicinc.com
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
base-commit: 55027e689933ba2e64f3d245fb1ff185b3e7fc81
change-id: 20240610-md-drivers-pci-controller-8de8948a2b92


