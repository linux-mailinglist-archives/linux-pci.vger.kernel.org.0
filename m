Return-Path: <linux-pci+bounces-16170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DEC9BF8F8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 23:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D715B229D4
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DAA20CCD6;
	Wed,  6 Nov 2024 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e8vktU4V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E2A20C48E;
	Wed,  6 Nov 2024 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931254; cv=none; b=ZqCuiWrUxyd1o6V+o418U9XuacOBdWU9gxur2VgHPye7DuGMUABfzef8ECM/gLST+9wz2OV3v2L5S9ugX3p6K9QuWHzpskpqiXeGJE1vRvM7Ze+7RoYpkx+6VrMWJgZlMwISce3rIKXDOLHxzHPeXSe4mjExy8uv5MnLFdVMr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931254; c=relaxed/simple;
	bh=rTLsE1kldVPsuTTbdVYCd0WFm5cpz7uOaVeMlPNdVbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMSFMPO0iNlYsU2lVQP6ePHCa4epgEzuCmxEaBK3cpDfriwpvi10RWmpCUBVdEB0t3Ij98yJOzKxgL9SGORtNM4GMDCsaXSztc/0/WnwEvTQDmxlrx2GS8aFxgnKfp1RB6k21AjVk82DJyE1/pixcioOSc1NLcobNuqoucmILyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e8vktU4V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6KwCk0016645;
	Wed, 6 Nov 2024 22:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5nR6+V6U7q0J7E2kZg8qsGgrETSooB11Sn3Bhng7/uo=; b=e8vktU4V9ujGREw4
	+kPEtu98leAAZ8vRum1WQc0Y1qxdaNofBOM/p3oKQA6fSRLdbC5ZNDaxDqVIvbLb
	G3bQdnDdB5OQZcyVKgRlESD6wfWDYNRsOL5jysXhf9r4kV0rdPILm9j/hJiQ7ctC
	09lHO/4EclHoqKzlKoyo4sLypATPfP9c2+89qYZsFyUlLQE2SkJdQZDXyfh4ok90
	69WYDUZGpR1fGsXFOYjlRNwNVoo3E3qVDpxfAYJaq9TU+9f/OnaqvZProOAxkSVY
	0j5Zxm9/1n3/UvaKSBENa5W5PdTylmLkI+FaZOg2Dfp60u94aEfvX/cRTbVew9wS
	I3NmgA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qvg3u8jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 22:14:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6ME5M1011726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 22:14:05 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 6 Nov 2024 14:14:05 -0800
From: Mayank Rana <quic_mrana@quicinc.com>
To: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_krichai@quicinc.com>,
        Mayank Rana
	<quic_mrana@quicinc.com>
Subject: [PATCH v3 4/4] PCI: qcom: Add Qualcomm SA8255p based PCIe root complex functionality
Date: Wed, 6 Nov 2024 14:13:41 -0800
Message-ID: <20241106221341.2218416-5-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106221341.2218416-1-quic_mrana@quicinc.com>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0bfY7odcx6WSLLzI9n4dO-rIcgJR0G0U
X-Proofpoint-GUID: 0bfY7odcx6WSLLzI9n4dO-rIcgJR0G0U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060170

On SA8255p ride platform, PCIe root complex is firmware managed as well
configured into ECAM compliant mode. This change adds functionality to
enable resource management (system resource as well PCIe controller and
PHY configuration) through firmware, and enumerating ECAM compliant root
complex.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 drivers/pci/controller/dwc/Kconfig     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 116 +++++++++++++++++++++++--
 2 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..0fe76bd39d69 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -275,6 +275,7 @@ config PCIE_QCOM
 	select PCIE_DW_HOST
 	select CRC8
 	select PCIE_QCOM_COMMON
+	select PCI_HOST_COMMON
 	help
 	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
 	  PCIe controller uses the DesignWare core plus Qualcomm-specific
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ef44a82be058..2cb74f902baf 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -21,7 +21,9 @@
 #include <linux/limits.h>
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
+#include <linux/pci-ecam.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
@@ -254,10 +256,12 @@ struct qcom_pcie_ops {
   * @ops: qcom PCIe ops structure
   * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
   * snooping
+  * @firmware_managed: Set if PCIe root complex is firmware managed
   */
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
 	bool override_no_snoop;
+	bool firmware_managed;
 	bool no_l0s;
 };
 
@@ -1415,6 +1419,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
 	.no_l0s = true,
 };
 
+static const struct qcom_pcie_cfg cfg_fw_managed = {
+	.firmware_managed = true,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1566,6 +1574,51 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void qcom_pci_free_msi(void *ptr)
+{
+	struct dw_pcie_rp *pp = (struct dw_pcie_rp *)ptr;
+
+	if (pp && pp->has_msi_ctrl)
+		dw_pcie_free_msi(pp);
+}
+
+static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
+{
+	struct device *dev = cfg->parent;
+	struct dw_pcie_rp *pp;
+	struct dw_pcie *pci;
+	int ret;
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+	pp = &pci->pp;
+	pci->dbi_base = cfg->win;
+	pp->num_vectors = MSI_DEF_NUM_VECTORS;
+
+	ret = dw_pcie_msi_host_init(pp);
+	if (ret)
+		return ret;
+
+	pp->has_msi_ctrl = true;
+	dw_pcie_msi_init(pp);
+
+	ret = devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
+	return ret;
+}
+
+/* ECAM ops */
+const struct pci_ecam_ops pci_qcom_ecam_ops = {
+	.init		= qcom_pcie_ecam_host_init,
+	.pci_ops	= {
+		.map_bus	= pci_ecam_map_bus,
+		.read		= pci_generic_config_read,
+		.write		= pci_generic_config_write,
+	}
+};
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
@@ -1580,11 +1633,52 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	char *name;
 
 	pcie_cfg = of_device_get_match_data(dev);
-	if (!pcie_cfg || !pcie_cfg->ops) {
-		dev_err(dev, "Invalid platform data\n");
+	if (!pcie_cfg) {
+		dev_err(dev, "No platform data\n");
+		return -EINVAL;
+	}
+
+	if (!pcie_cfg->firmware_managed && !pcie_cfg->ops) {
+		dev_err(dev, "No platform ops\n");
 		return -EINVAL;
 	}
 
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		goto err_pm_runtime_put;
+
+	if (pcie_cfg->firmware_managed) {
+		struct pci_host_bridge *bridge;
+		struct pci_config_window *cfg;
+
+		bridge = devm_pci_alloc_host_bridge(dev, 0);
+		if (!bridge) {
+			ret = -ENOMEM;
+			goto err_pm_runtime_put;
+		}
+
+		of_pci_check_probe_only();
+		/* Parse and map our Configuration Space windows */
+		cfg = gen_pci_init(dev, bridge, &pci_qcom_ecam_ops);
+		if (IS_ERR(cfg)) {
+			ret = PTR_ERR(cfg);
+			goto err_pm_runtime_put;
+		}
+
+		bridge->sysdata = cfg;
+		bridge->ops = (struct pci_ops *)&pci_qcom_ecam_ops.pci_ops;
+		bridge->msi_domain = true;
+
+		ret = pci_host_probe(bridge);
+		if (ret) {
+			dev_err(dev, "pci_host_probe() failed:%d\n", ret);
+			goto err_pm_runtime_put;
+		}
+
+		return ret;
+	}
+
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
@@ -1593,11 +1687,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
-	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
-		goto err_pm_runtime_put;
-
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
@@ -1739,9 +1828,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 static int qcom_pcie_suspend_noirq(struct device *dev)
 {
-	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	struct qcom_pcie *pcie;
 	int ret = 0;
 
+	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8255p"))
+		return 0;
+
+	pcie = dev_get_drvdata(dev);
 	/*
 	 * Set minimum bandwidth required to keep data path functional during
 	 * suspend.
@@ -1795,9 +1888,13 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 
 static int qcom_pcie_resume_noirq(struct device *dev)
 {
-	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	struct qcom_pcie *pcie;
 	int ret;
 
+	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8255p"))
+		return 0;
+
+	pcie = dev_get_drvdata(dev);
 	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
 		ret = icc_enable(pcie->icc_cpu);
 		if (ret) {
@@ -1830,6 +1927,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
+	{ .compatible = "qcom,pcie-sa8255p", .data = &cfg_fw_managed },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
 	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
-- 
2.25.1


