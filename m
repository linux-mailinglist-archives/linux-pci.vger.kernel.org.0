Return-Path: <linux-pci+bounces-29903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFA8ADBD13
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 00:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3115B172C52
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 22:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9E7221FDA;
	Mon, 16 Jun 2025 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UZb+aD9/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607392264AB
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113794; cv=none; b=L468V5oO+x+i7RDJ2zJaD4dnqVyaxYNPdBkfV2RaZG+hovXXryenFdr9bcHV8xbxZbQF3hM/XTcvDSFDRuWm+2fywAngPeJMFfWJZh8t8xaMaeBZ8/aWoCPclhKXeehn27syJLcdkyjj+9gw1RBg6zK3iN2vHI+Qk1Y2na9xBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113794; c=relaxed/simple;
	bh=IVJlWT67NFwATC1aEaSSOc0rJVa9EvYX/VHrE9HgMiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ddEXM22L0BkNURWfGjo2Qnoh16weAV8wuseFtYtMXC0ep5KHA6A/wTM6HJia5xIYImMdWT4XU0DK5fpgS7u3q0Py8Eoi8Q/F2OEm47+E5hBtosfiUGTOtLU3+VtnxpX2qVitgcD4sxIopAY/kgl1oPilGzKaFW1mDwh33I06by8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UZb+aD9/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GGTgJm019473
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qUeqc8OEENG
	/vdcvWcALgf+8+R5rytQKKW7bjizdq0M=; b=UZb+aD9/1+/tpYg5qjrxnum+yfI
	CvsZGJVorPdraqhljtgWd24DLHOluTGa29RnZ1zwMDnblvDrCBrYwtioOga3+4oA
	l1LH/JeJWehwKa2oYj8s4AbndMBiY+tcpSeFUs70oG8BWORooidH1LZdbSM+6rsx
	l8XdtHL14U4MaLeICNsN/SVJ+cUVHjGjxIGhUhvXc9/e2x8XjHA/2zV21Lls2x3c
	hZGRX3cGTM3LoV+Grfe7U88CWxt0WsQUZYrx05X4F1xAJiBu1HNHVBY1UoKx4eUl
	gi9NFKcLkDHU1UvVjPP28hdzyisWRFJ8sMtDWliWlBneHkLhaMf7lVorauw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791h962qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:11 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7489d1f5e9fso3609709b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 15:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750113790; x=1750718590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUeqc8OEENG/vdcvWcALgf+8+R5rytQKKW7bjizdq0M=;
        b=OadGGSlAE4fU+VU/8cEaZJq6gXt+nmiDmUbYiDVZNio0hhwp5U1PqRcsNYnOJDq9uu
         sdVSV7XuVwJcPQoVd1BQocYuhiWCqEj10y7LHkKo5xsHnmKMCG+NPV79JLvEn2nyEyyE
         9H1W4CyNrox07V5U9ubC4HULokpSvB0JnS+vQDV2YweansmB0Tbs9A8ojhxpE+z8Ok4O
         JVO/Y/mjgh2fQjiNnp43Si1mLuWvs9fSmJxDtoqf38lT+iHa5PHfx+KroRL61Hr1szxY
         chFVksTNgMI+3JHRDt+TivxyuL0Z4xFoFqXfriW+P6mXfANpuGnhd5IdQfpFlrQkYjvH
         1aRQ==
X-Gm-Message-State: AOJu0Yzgda5+JYBlT+lVULNDisxDPZ9Ok/eQYWK8VmxN8ph7EN4XBvBm
	M88xISb9z0S20h5t+vZPj8hgL+Lrw+ixJGxWpP6CY0jBIAmX34YR/IWa5sTmEqQVzc7JuYaafZK
	X0eCZt/Sy8VFhOYiBP4mTwTaYz/Yrqongzy4Pi8j6x5W82vUWRn2qfoPEvvPVaD7QTZoBCy4=
X-Gm-Gg: ASbGncuuf+nGfnfI/FBsUJmMWAm+c4iozpv3InaOiq9Y8ERx7ktBNgBEw6nBzrL2mDM
	TJ4RVUbIpQCwc/GOjs4jbnKu5chIjgag8Ir9KTTEV0q/XCj7A+p6JQ7nCguTUm2jJlJ+16xM0kr
	jUcXfVFG5fI+8RbhN7bPlBav9piUCJs6kFd/2eEhaPbZoAtudZaqwedu8gMSctgqWE+8kRpraQd
	ghNDGvFKpprZ5d8Zp53PcG4GHFjwQfml9DfTsX3LTvW51Px5nnL3mBQ1EFHvBxEvo80bzUZC9Th
	/+MML/dr7THNoZz++xMfohBHHcm+L5e46nKGJ6erZXmInCuH8FeUimOtdCyPDSEeIAwjzeEy
X-Received: by 2002:a05:6a00:b4b:b0:742:a91d:b2f5 with SMTP id d2e1a72fcca58-7489cffc1d9mr14008191b3a.13.1750113789738;
        Mon, 16 Jun 2025 15:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2aXV8oJypsRpDZPxj/05U7LtypB1Xusvh4lhxZelcO73oGUX5Ap4PiwGb7EjTXdxp3P6rGA==
X-Received: by 2002:a05:6a00:b4b:b0:742:a91d:b2f5 with SMTP id d2e1a72fcca58-7489cffc1d9mr14008153b3a.13.1750113789276;
        Mon, 16 Jun 2025 15:43:09 -0700 (PDT)
Received: from hu-mrana-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083029sm7405077b3a.81.2025.06.16.15.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 15:43:08 -0700 (PDT)
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, will@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        andersson@kernel.org, mani@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
        quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
        quic_nitegupt@quicinc.com, Mayank Rana <mayank.rana@oss.qualcomm.com>
Subject: [PATCH v5 4/4] PCI: qcom: Add support for Qualcomm SA8255p based PCIe root complex
Date: Mon, 16 Jun 2025 15:42:59 -0700
Message-Id: <20250616224259.3549811-5-mayank.rana@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616224259.3549811-1-mayank.rana@oss.qualcomm.com>
References: <20250616224259.3549811-1-mayank.rana@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JfizfUnogGKnEsr3nLIQKLEFN4LkJBVp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE2MiBTYWx0ZWRfXw2MaYJujlAG3
 T163a9vmrz95CFORfjY4CRIMHAAEcOouVyrUBD2AI0AFZ3shMJcAyjXQ8gBB4OJU87epjrF+gY1
 jfDtpGaPWEZjDGvqP2Np1y+QuwYV3Pmgi6MWl72y5xI1X1kg4/b73URUMn/CNDfWeBIB748+QC8
 fZyM3Ipm/802lddQL8kpHrfppq5yN3+wtCW21yKYNcbUrQALvZrYwxB7mVS/b5gBsFdctbl9THz
 nxClR80BjYvv4zMtrn5OyVDFWuq9yN36Qe7xzAIZFXG8x8q8uQQBvkdTHY3DcNMofHHEX+OPGQR
 /BnxWZ5Egn36QENe3KgQAanro36iNa8SXuj/x8+SZ6otrCWXIDJfc3RBv04A0XCnwMicvzXwC02
 bLSkspwIyD5GK58H32DpOMgDNf06W0a4b7HyzZikoXF33+DjUrBuUfwnrlwJivoxc7kPiCG2
X-Authority-Analysis: v=2.4 cv=UL/dHDfy c=1 sm=1 tr=0 ts=68509dff cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=2qsEFDsomqtw1e5O1FYA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: JfizfUnogGKnEsr3nLIQKLEFN4LkJBVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_11,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160162

Add functionality to enable resource management through firmware and
enumerate ECAM compliant root complex on SA8255p ride platform, where
PCIe root complex is firmware managed and configured into ECAM
compliant mode.

Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/Kconfig     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 116 +++++++++++++++++++++++--
 2 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index d9f0386396ed..ce04ee6fbd99 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -296,6 +296,7 @@ config PCIE_QCOM
 	select PCIE_DW_HOST
 	select CRC8
 	select PCIE_QCOM_COMMON
+	select PCI_HOST_COMMON
 	help
 	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
 	  PCIe controller uses the DesignWare core plus Qualcomm-specific
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c789e3f85655..0c20e9e78e4d 100644
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
@@ -34,6 +36,7 @@
 #include <linux/units.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 #include "pcie-qcom-common.h"
 
@@ -255,10 +258,12 @@ struct qcom_pcie_ops {
   * @ops: qcom PCIe ops structure
   * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
   * snooping
+  * @firmware_managed: Set if ecam compliant PCIe root complex is firmware managed
   */
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
 	bool override_no_snoop;
+	bool firmware_managed;
 	bool no_l0s;
 };
 
@@ -1426,6 +1431,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
 	.no_l0s = true,
 };
 
+static const struct qcom_pcie_cfg cfg_fw_managed = {
+	.firmware_managed = true,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1579,6 +1588,50 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
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
+	return devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
+}
+
+/* ECAM ops */
+static const struct pci_ecam_ops pci_qcom_ecam_ops = {
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
@@ -1593,11 +1646,52 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
+		/* Parse and map our configuration space windows */
+		cfg = pci_host_common_ecam_create(dev, bridge,
+				&pci_qcom_ecam_ops);
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
@@ -1606,11 +1700,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
@@ -1756,9 +1845,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 static int qcom_pcie_suspend_noirq(struct device *dev)
 {
-	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	struct qcom_pcie *pcie;
 	int ret = 0;
 
+	pcie = dev_get_drvdata(dev);
+	if (!pcie)
+		return 0;
+
 	/*
 	 * Set minimum bandwidth required to keep data path functional during
 	 * suspend.
@@ -1812,9 +1905,13 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 
 static int qcom_pcie_resume_noirq(struct device *dev)
 {
-	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	struct qcom_pcie *pcie;
 	int ret;
 
+	pcie = dev_get_drvdata(dev);
+	if (!pcie)
+		return 0;
+
 	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
 		ret = icc_enable(pcie->icc_cpu);
 		if (ret) {
@@ -1849,6 +1946,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
+	{ .compatible = "qcom,pcie-sa8255p", .data = &cfg_fw_managed },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
 	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
-- 
2.25.1


