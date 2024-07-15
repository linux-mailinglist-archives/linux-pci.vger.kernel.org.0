Return-Path: <linux-pci+bounces-10298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B605931A1C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FC0283418
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 18:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554516A357;
	Mon, 15 Jul 2024 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q60kSvph"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62426E61B;
	Mon, 15 Jul 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067295; cv=none; b=hsGGJO7/mX90HKX/pPBF3r0gvJwB1FEb+nwg5eOFub2ROyDWp9wJGIaBGlCsltSE8EyoIo1d7q9GsWLQv6E86O0lN1rcYcsJsKrbDRuKpjeGZBjqMg97lvXDCSXqjtYaD1VSOY3KptsFPXsbESorbjdm28IClR0yb8r0iXbR2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067295; c=relaxed/simple;
	bh=GsFSFiK+aj+yQoi1frw7uVd0xhFPQHzitvU8lWv5Vx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGbUB1zgPAUpoTATr3y2/8t0QQAVWxmqb59KhtK7TCaWqxjvC4eYlpM2cmmqKWz7TSCMhmKyemRJ/45o/XjSqwRjoE5qlFuozMqgHPyfGK1+nZQRhw4mLAzxPWQJeoALG1gl4SzbCa2ilOH8wHhHNNUPfD1JxXh+lw09Pxl8+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q60kSvph; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH8gjl029987;
	Mon, 15 Jul 2024 18:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=c7owLXpFna1dFjNdHfNbwtJ+
	e/sHELDIGCOsgbwDi7k=; b=Q60kSvphq2xIVOGd4LV5oa54fKfTyzVPQZTUg6UU
	SDAdRUVEtPV+T8GKsA9WF36A07JAtNX1ETPFg6hg7yy8b1553waS+yPYhNnhvGNp
	gnymCGcyeXESc8S7MRYWIhUlahyh2QA/mv+tflu76YiRgrhJ4IYXpeyEqu+ZXNEo
	/0NLvTuPgW5me+RwLwicqiaj6NAvB4HI/IrPWvO+/OmKD/YIov5AcXzJHdMuxidX
	i0chdbyg6s4Xcr+/cUpJmMP8HnHaWU4zE41aOssiFDK7hoWw7KRhcuIVR+SsHtiA
	VG9bsYqQ1wEDoZcAcayRQ7R7Hj65y6bbDOgeFuZOLoIZbw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bf9ed68k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46FIDsbr003669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:54 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Jul 2024 11:13:53 -0700
From: Mayank Rana <quic_mrana@quicinc.com>
To: <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <cassel@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <s-vadapalli@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>, Mayank Rana <quic_mrana@quicinc.com>
Subject: [PATCH V2 7/7] PCI: host-generic: Add dwc PCIe controller based MSI controller usage
Date: Mon, 15 Jul 2024 11:13:35 -0700
Message-ID: <1721067215-5832-8-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GHBMqoNpPxgEnql2LIncftsiqsmH4MN-
X-Proofpoint-GUID: GHBMqoNpPxgEnql2LIncftsiqsmH4MN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407150142

Add usage of Synopsys Designware PCIe controller based MSI controller to
support MSI functionality with ECAM compliant Synopsys Designware PCIe
controller. To use this functionality add device compatible string as
"snps,dw-pcie-ecam-msi".

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 drivers/pci/controller/pci-host-generic.c | 92 ++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index c2c027f..457ae44 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -8,13 +8,73 @@
  * Author: Will Deacon <will.deacon@arm.com>
  */
 
-#include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_address.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+#include "dwc/pcie-designware-msi.h"
+
+struct dw_ecam_pcie {
+	void __iomem *cfg;
+	struct dw_msi *msi;
+	struct pci_host_bridge *bridge;
+};
+
+static u32 dw_ecam_pcie_readl(void *p_data, u32 reg)
+{
+	struct dw_ecam_pcie *ecam_pcie = (struct dw_ecam_pcie *)p_data;
+
+	return readl(ecam_pcie->cfg + reg);
+}
+
+static void dw_ecam_pcie_writel(void *p_data, u32 reg, u32 val)
+{
+	struct dw_ecam_pcie *ecam_pcie = (struct dw_ecam_pcie *)p_data;
+
+	writel(val, ecam_pcie->cfg + reg);
+}
+
+static struct dw_ecam_pcie *dw_pcie_ecam_msi(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dw_ecam_pcie *ecam_pcie;
+	struct dw_msi_ops *msi_ops;
+	u64 addr;
+
+	ecam_pcie = devm_kzalloc(dev, sizeof(*ecam_pcie), GFP_KERNEL);
+	if (!ecam_pcie)
+		return ERR_PTR(-ENOMEM);
+
+	if (of_property_read_reg(dev->of_node, 0, &addr, NULL) < 0) {
+		dev_err(dev, "Failed to get reg address\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	ecam_pcie->cfg = devm_ioremap(dev, addr, PAGE_SIZE);
+	if (ecam_pcie->cfg == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	msi_ops = devm_kzalloc(dev, sizeof(*msi_ops), GFP_KERNEL);
+	if (!msi_ops)
+		return ERR_PTR(-ENOMEM);
+
+	msi_ops->readl_msi = dw_ecam_pcie_readl;
+	msi_ops->writel_msi = dw_ecam_pcie_writel;
+	msi_ops->pp = ecam_pcie;
+	ecam_pcie->msi = dw_pcie_msi_host_init(pdev, msi_ops, 0);
+	if (IS_ERR(ecam_pcie->msi)) {
+		dev_err(dev, "dw_pcie_msi_host_init() failed\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	dw_pcie_msi_init(ecam_pcie->msi);
+	return ecam_pcie;
+}
+
 static const struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
 	.bus_shift	= 16,
 	.pci_ops	= {
@@ -73,6 +133,9 @@ static const struct of_device_id gen_pci_of_match[] = {
 	{ .compatible = "snps,dw-pcie-ecam",
 	  .data = &pci_dw_ecam_bus_ops },
 
+	{ .compatible = "snps,dw-pcie-ecam-msi",
+	  .data = &pci_generic_ecam_ops },
+
 	{ },
 };
 MODULE_DEVICE_TABLE(of, gen_pci_of_match);
@@ -80,6 +143,7 @@ MODULE_DEVICE_TABLE(of, gen_pci_of_match);
 static int gen_pcie_ecam_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct dw_ecam_pcie *ecam_pcie = NULL;
 	int ret = 0;
 
 	if (!IS_ERR_OR_NULL(dev->pm_domain)) {
@@ -94,14 +158,30 @@ static int gen_pcie_ecam_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (of_device_is_compatible(dev->of_node, "snps,dw-pcie-ecam-msi")) {
+		ecam_pcie = dw_pcie_ecam_msi(pdev);
+		if (IS_ERR(ecam_pcie)) {
+			ret = -ENODEV;
+			goto err;
+		}
+	}
+
 	ret = pci_host_common_probe(pdev);
 	if (ret) {
 		dev_err(dev, "pci_host_common_probe() failed:%d\n", ret);
 		goto err;
 	}
 
+	if (ecam_pcie) {
+		ecam_pcie->bridge = platform_get_drvdata(pdev);
+		platform_set_drvdata(pdev, ecam_pcie);
+	}
+
 	return ret;
 err:
+	if (!IS_ERR_OR_NULL(ecam_pcie))
+		dw_pcie_free_msi(ecam_pcie->msi);
+
 	if (!IS_ERR_OR_NULL(dev->pm_domain))
 		pm_runtime_put_sync(dev);
 	return ret;
@@ -109,7 +189,17 @@ static int gen_pcie_ecam_probe(struct platform_device *pdev)
 
 static void gen_pcie_ecam_remove(struct platform_device *pdev)
 {
+	struct dw_ecam_pcie *ecam_pcie = NULL;
+
+	if (of_device_is_compatible(pdev->dev.of_node, "snps,dw-pcie-ecam-msi")) {
+		ecam_pcie = platform_get_drvdata(pdev);
+		platform_set_drvdata(pdev, ecam_pcie->bridge);
+	}
+
 	pci_host_common_remove(pdev);
+	if (ecam_pcie)
+		dw_pcie_free_msi(ecam_pcie->msi);
+
 	if (pdev->dev.pm_domain)
 		pm_runtime_put_sync(&pdev->dev);
 }
-- 
2.7.4


