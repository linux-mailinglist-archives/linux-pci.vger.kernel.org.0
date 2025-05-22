Return-Path: <linux-pci+bounces-28251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B84AC0148
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 02:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150E34E2A77
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 00:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0568D517;
	Thu, 22 May 2025 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LCJb5/p3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B083214
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872885; cv=none; b=Ta/jZEKioLn2mBD4D2EGCuq6c/HsButK1ospxq17C8EpSv2yiSy4XoaTJMF3cROvAZtPYG1qJ+6uq/oGa/JKzFpXoCptnRrNmu1psSXX90TMQ3WOLkwkUYEp/+N+t2d09wmqNCzK4MGNlQWsKxMjyN+UE5Kk0BdgAmt7x6DG/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872885; c=relaxed/simple;
	bh=nMNcfhLndVSZaWwF7hUP+mx0e9T9QX8l/caUTIzV3Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQ8m6u31jMKBqEQJK3PSAVFPQfxpUIHru43BveNm6LfJLMIZamraH5t/BzStwraEqkgYL3Z6cNj02q+WxPhxt7S8Y+YgI86dyGeEkDFVtlUUJwhoEvukxKULUm4LHh+oTrcflUd/uKCFm5cbFnV0OoSVN2MmkAl8rny5+VdEJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LCJb5/p3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHVTw5016898
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 00:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0wt/gxAtrk6
	6qf3nfzA+PWfV99jzSoP5D0OKYMZ6YA8=; b=LCJb5/p3/KlPJpt0kOp++zrE8hL
	sHjomMMY8dRc2q3GC1noKdYlbAXiav8ZmPyHQJ5Gw78j3u0JiouJVe2euRzq4I2b
	FXGnvr+tm0KN0/lrlgIzwCPsFxVgn0n8uEmIucdMJ3aQaRKeb2FWjgu6lLyVPoqG
	Cg7YG1df0yae6EAT3ZKjE8NrJ1dlpKF3vAOqmZzoBQrhuv5z7Pz0grcaOYZ5yDeS
	Js5vGvGtL49/0gKtgHLWEEHGTbmes2yFbMJSipg57DRNKFUys5OeRk2l9xg8EPtP
	mEo2y/5P6PMn7XYQc5LvVaqLoqHIyWVSf80/kx/3Jhoj9yXY23+WTyovwvw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9vhgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 00:14:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-30ed6bd1b4cso5872467a91.0
        for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 17:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747872881; x=1748477681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wt/gxAtrk66qf3nfzA+PWfV99jzSoP5D0OKYMZ6YA8=;
        b=badJcEdwCeJp9SiGWfKGT9ocTEojxwVuY7Wj5PauWMH0esJNYZpZsPZXO7bcEnpxjy
         eVQYQhy8IBvDCPru01HeSVHH8PxJvK4vrAOxiD33JrxoFcHJLwH1NvbDYpmW6ATBAUDd
         e+44DxqItxmhw2AObTQo8kmZKjRf50i2Vi31p0yHAi5wQsVXfx1HgdQCiqg5zHuIoznb
         ZXc7pwLFZgIJMdFPDDHmcbr3eeVsVLf+oa7GRoEzVxH2/lZQa11c98DhkS+Obz/PWEUw
         dScLzrfdDbQfdW0IVsQooofK8v6hUYWTe4yWI7FULk595CAXedLqYuIbKugZ1DI3oHvN
         CysA==
X-Gm-Message-State: AOJu0YzpGQ5kDjAfQ5F//X2WpEL4Dk9XLW9iGBchv4HEVOwm/+MCCCuj
	3R7pqxZ2+7zfEy2iQ5POd3jrq5Axs/MuSFzAcxBZ5jOMGrU6flg80VIB4XMGh7ts4WBQErpGCCG
	PpwcOAlikofweCCPlge1ATYQJr9dTuxRwtrYmdoX2hwjJxbpEfqkvij6Sabn9jyrBjTmkJjM=
X-Gm-Gg: ASbGnctudxBEg6d5av0YwZCuxaE7XoVegSO/gVA3iQGCsZWJU9uuIQEqDsOUbgnFikK
	+4Y+Lc8UWo95CO1U44DFhJSntOBf2gpu+TuUSEwLYjbUTw3sc48xjUjp7xkeJl4LERHhD9Oyz2n
	XJGJj0T6bSwtGwAFCm7Hz9mtcPlasMW78rW7L2CFh6Q1C97TeTQk388shQ4TAr+pGfKhgDgaMYa
	BgE0mpvYOgdLp+47dLFH5d+kFz9n7kSE6jsggB0EaZpEFuD3zNNnhJxBJ2CaNNyPAKzeiC0e2T+
	FMsXykM0nQs+bqy7y33eH7ygCnmaUgZsrHXcujWDJFsK7X3aos6NfdeKnEawEQ==
X-Received: by 2002:a17:90b:52c5:b0:2f2:a664:df20 with SMTP id 98e67ed59e1d1-30e830ca279mr35177114a91.7.1747872880721;
        Wed, 21 May 2025 17:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2wgsuQGaz+C0jblpeyM+oe1ytmP5yScHwvWn7GeOv1/OzOxKJBeJfvPoeFXQLkSAk1xELtA==
X-Received: by 2002:a17:90b:52c5:b0:2f2:a664:df20 with SMTP id 98e67ed59e1d1-30e830ca279mr35177062a91.7.1747872880293;
        Wed, 21 May 2025 17:14:40 -0700 (PDT)
Received: from hu-mrana-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f3651611bsm4617101a91.49.2025.05.21.17.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 17:14:39 -0700 (PDT)
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, andersson@kernel.org,
        manivannan.sadhasivam@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
        quic_nkela@quicinc.com, quic_shazhuss@quicinc.com,
        quic_msarkar@quicinc.com, quic_nitegupt@quicinc.com,
        Mayank Rana <mayank.rana@oss.qualcomm.com>
Subject: [PATCH v4 4/4] PCI: qcom: Add support for Qualcomm SA8255p based PCIe root complex
Date: Wed, 21 May 2025 17:14:25 -0700
Message-Id: <20250522001425.1506240-5-mayank.rana@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250522001425.1506240-1-mayank.rana@oss.qualcomm.com>
References: <20250522001425.1506240-1-mayank.rana@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=682e6c72 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=-evKrK6A_rNxfzosICwA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: yUT218SQ0SkTKSr1fMc_7rufbRB38-s0
X-Proofpoint-GUID: yUT218SQ0SkTKSr1fMc_7rufbRB38-s0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDAwMCBTYWx0ZWRfX9M7M4y1PerzP
 5kbfdVlmVLw+FrOGo5D6L5nkcEuvk6x+SwJdqkk/VpB8Gs6XLi9g36cRefbDoB7sEUQ7gbfRTH9
 QUNw8STtNJXQjsCG9cmQ1AVleg07DP8lTeHPbG7iB/NvmegR18f7oq4WxJ0oPbPPJcV/fX2rqbV
 P8cMQZm0P1AzitQHcvem3gRFuxDjF1SCzG9O5+4OiWqGcgVQDpJHec4cZe0j/uW8cgjqZ21PjVB
 ++Hn5sYab2i63gpa2H+WeWiqzJPUvDSJLJiQFwtCtKPmZs2DIBRZ34ZpCZPVlZ4CVPME2/Oe4FY
 gLPYAqsE+B6iVIZXhSK4Ka9S85jDwlcCeI69s2oLRM5K4wrwH4XaQaPn3WM6KVucXhrqtOslzc1
 C67l+w64rkJ6dfzVgYRVWzC2324zfeRY1Lzit4Mx09tUMxbX4gra6e01siH7v8IIP/J/VmjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220000

Add functionality to enable resource management through firmware and
enumerate ECAM compliant root complex on SA8255p ride platform, where
PCIe root complex is firmware managed and configured into ECAM
compliant mode.

Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/Kconfig     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 114 +++++++++++++++++++++++--
 2 files changed, 106 insertions(+), 9 deletions(-)

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
index dc102d8bd58c..d32b91d5addd 100644
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
@@ -255,10 +257,12 @@ struct qcom_pcie_ops {
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
 
@@ -1426,6 +1430,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
 	.no_l0s = true,
 };
 
+static const struct qcom_pcie_cfg cfg_fw_managed = {
+	.firmware_managed = true,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1577,6 +1585,50 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
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
@@ -1591,11 +1643,51 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
+		cfg = pci_host_common_init(dev, bridge, &pci_qcom_ecam_ops);
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
@@ -1604,11 +1696,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
@@ -1751,9 +1838,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
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
@@ -1807,9 +1898,13 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 
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
@@ -1843,6 +1938,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
+	{ .compatible = "qcom,pcie-sa8255p", .data = &cfg_fw_managed },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
 	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
-- 
2.25.1


