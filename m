Return-Path: <linux-pci+bounces-9305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8128691811A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 14:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B101C21C94
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4C5183066;
	Wed, 26 Jun 2024 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kbChIP5I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1616181D1B;
	Wed, 26 Jun 2024 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405523; cv=none; b=f98IrrI4s9bM/cBEvWDOPfNt2mc8yd64TBn7H8l3ExyxCbvx1oe6svSqsOaPIaO2ipkq2nWfWkiC6b0SdGVt5TPxQ1DeDwNamdUVsDp1cO7GcAEEK/g8Yo0IXGsua/oiFpoBRJseLWn8HC1Px1AVVR6rV9gQOM9QE2jWYlRcZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405523; c=relaxed/simple;
	bh=GH1ZIcjQdgYwfp8z77xEv6s9RCk4oE8cin2OQE9YM+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Go5JNi+/VkWIZy1KkWC/1CCBcrRpMOb4VtpRjkD1Sy4ezWEpxDJDJopE6sSP9o2eOdt3JMDurzcQw9W3hrsKThrYB5DH9o1HQRwF9OnbW5afOv+vX7umIZozpu4TYzwXNugcqRxbiV92R19LkUk7vrODCPlSfc0nd8RPFcxmhiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kbChIP5I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfTG8015132;
	Wed, 26 Jun 2024 12:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HevpUpkwNBLSA+8wnxcLcvX3RVHH1e2jXRCkIe+vv5o=; b=kbChIP5ItNqLKUuL
	MrUbKSrrpg+vXe1nWXGH6aiJgyr+WNhpsrN7HBTUUGsdm+Ndz47KxoUqep5AWF6R
	AyaEl8WBTORt7hHsfOsca/klDWbxME/boiV9wRZ1t+OSdQXFOguOPy24yC58Kt1W
	PlfCB0Zw6HkFeJVePCQZz24WT5yNpbC2bStbcTpXt17xoeYcyJl7eKNGTDIof5+r
	+7Nv5Jrjihx/vDLl2czdCDL/kquOO+fz6guCnkpAHtV/UzexqYgfSdzw48HTCSBw
	O2UoA6kd828Ig1fVD40UgLkC/8h2i9vBmVe3j3/XdFe47cx7LvCe7XexJBG8ZjyH
	IIwQew==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqshsna3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:38:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QCcXlt003018
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:38:33 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 05:38:28 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 26 Jun 2024 18:07:55 +0530
Subject: [PATCH RFC 7/7] pci: pwrctl: Add power control driver for qps615
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-qps615-v1-7-2ade7bd91e02@quicinc.com>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
In-Reply-To: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
CC: <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719405471; l=9545;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=GH1ZIcjQdgYwfp8z77xEv6s9RCk4oE8cin2OQE9YM+g=;
 b=igys+2Y9iLjg6uLmopQAM0IqONOCRY5LiHavrftNwD8fH69dFlEerEAREcFPVbhA32B3A4Rwv
 4khExXq9KcxDKjZLwqLfE7f+deIm6Ras3XZQC3UN8iUFfWL/aIKeH5O
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JktbPvjJgskeN9Fb6quZ90PaFemNAWKB
X-Proofpoint-GUID: JktbPvjJgskeN9Fb6quZ90PaFemNAWKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260094

QPS615 switch needs to configured after powering on and before
PCIe link was up.

As the PCIe controller driver already enables the PCIe link training
at the host side, stop the link training.
Otherwise the moment we turn on the switch it will participate in
the link training and link may come before switch is configured through
i2c.

The switch can be configured different ways like changing de-emphasis
settings of the switch, disabling unused ports etc and these settings
can vary from board to board, for that reason the sequence is taken
from the firmware file which contains the address of the slave, to address
and data to be written to the switch. The driver reads the firmware file
and parses them to apply those configurations to the switch.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/pwrctl/Kconfig             |   7 +
 drivers/pci/pwrctl/Makefile            |   1 +
 drivers/pci/pwrctl/pci-pwrctl-qps615.c | 278 +++++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+)

diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
index f1b824955d4b..a419b250006d 100644
--- a/drivers/pci/pwrctl/Kconfig
+++ b/drivers/pci/pwrctl/Kconfig
@@ -14,4 +14,11 @@ config PCI_PWRCTL_PWRSEQ
 	  Enable support for the PCI power control driver for device
 	  drivers using the Power Sequencing subsystem.
 
+config PCI_PWRCTL_QPS615
+	tristate "PCI Power Control driver for QPS615"
+	select PCI_PWRCTL
+	help
+	  Enable support for the PCI power control driver for QPS615 and
+	  configures it.
+
 endmenu
diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
index d308aae4800c..ac563a70c023 100644
--- a/drivers/pci/pwrctl/Makefile
+++ b/drivers/pci/pwrctl/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctl-core.o
 pci-pwrctl-core-y			:= core.o
 
 obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctl-pwrseq.o
+obj-$(CONFIG_PCI_PWRCTL_QPS615)		+= pci-pwrctl-qps615.o
diff --git a/drivers/pci/pwrctl/pci-pwrctl-qps615.c b/drivers/pci/pwrctl/pci-pwrctl-qps615.c
new file mode 100644
index 000000000000..1f2caf5d7da2
--- /dev/null
+++ b/drivers/pci/pwrctl/pci-pwrctl-qps615.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci-pwrctl.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "../pci.h"
+
+struct qcom_qps615_pwrctl_i2c_setting {
+	u32 slv_addr;
+	u32 reg_addr;
+	u32 val;
+};
+
+struct qcom_qps615_pwrctl_ctx {
+	struct i2c_adapter *adapter;
+	struct pci_pwrctl pwrctl;
+	struct device_link *link;
+	struct regulator *vdd;
+};
+
+/* write 32-bit value to 24 bit register */
+static int qps615_switch_i2c_write(struct qcom_qps615_pwrctl_ctx *ctx, u32 slv_addr, u32 reg_addr,
+				   u32 reg_val)
+{
+	struct i2c_msg msg;
+	u8 msg_buf[7];
+	int ret;
+
+	msg.addr = slv_addr;
+	msg.len = 7;
+	msg.flags = 0;
+
+	/* Big Endian for reg addr */
+	msg_buf[0] = (u8)(reg_addr >> 16);
+	msg_buf[1] = (u8)(reg_addr >> 8);
+	msg_buf[2] = (u8)reg_addr;
+
+	/* Little Endian for reg val */
+	msg_buf[3] = (u8)(reg_val);
+	msg_buf[4] = (u8)(reg_val >> 8);
+	msg_buf[5] = (u8)(reg_val >> 16);
+	msg_buf[6] = (u8)(reg_val >> 24);
+
+	msg.buf = msg_buf;
+	ret = i2c_transfer(ctx->adapter, &msg, 1);
+	return ret == 1 ? 0 : ret;
+}
+
+/* read 32 bit value from 24 bit reg addr */
+static int qps615_switch_i2c_read(struct qcom_qps615_pwrctl_ctx *ctx, u32 slv_addr, u32 reg_addr,
+				  u32 *reg_val)
+{
+	u8 wr_data[3], rd_data[4] = {0};
+	struct i2c_msg msg[2];
+	int ret;
+
+	msg[0].addr = slv_addr;
+	msg[0].len = 3;
+	msg[0].flags = 0;
+
+	/* Big Endian for reg addr */
+	wr_data[0] = (u8)(reg_addr >> 16);
+	wr_data[1] = (u8)(reg_addr >> 8);
+	wr_data[2] = (u8)reg_addr;
+
+	msg[0].buf = wr_data;
+
+	msg[1].addr = slv_addr;
+	msg[1].len = 4;
+	msg[1].flags = I2C_M_RD;
+
+	msg[1].buf = rd_data;
+
+	ret = i2c_transfer(ctx->adapter, &msg[0], 2);
+	if (ret != 2)
+		return ret;
+
+	*reg_val = (rd_data[3] << 24) | (rd_data[2] << 16) | (rd_data[1] << 8) | rd_data[0];
+
+	return 0;
+}
+
+static int qcom_qps615_pwrctl_init(struct qcom_qps615_pwrctl_ctx *ctx)
+{
+	struct device *dev = ctx->pwrctl.dev;
+	struct qcom_qps615_pwrctl_i2c_setting *set;
+	const struct firmware *fw;
+	const u8 *pos, *eof;
+	int ret;
+	u32 val;
+
+	ret = request_firmware(&fw, "qcom/qps615.bin", dev);
+	if (ret < 0) {
+		dev_err(dev, "firmware loading failed with ret %d\n", ret);
+		return ret;
+	}
+
+	if (!fw) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	pos = fw->data;
+	eof = fw->data + fw->size;
+
+	while (pos < (fw->data + fw->size)) {
+		set = (struct qcom_qps615_pwrctl_i2c_setting *)pos;
+
+		ret = qps615_switch_i2c_write(ctx, set->slv_addr, set->reg_addr, set->val);
+		if (ret) {
+			dev_err(dev,
+				"I2c write failed for slv addr:%x at addr%x with val %x ret %d\n",
+				set->slv_addr, set->reg_addr, set->val, ret);
+			goto err;
+		}
+
+		ret = qps615_switch_i2c_read(ctx,  set->slv_addr, set->reg_addr, &val);
+		if (ret) {
+			dev_err(dev, "I2c read failed for slv addr:%x at addr%x ret %d\n",
+				set->slv_addr, set->reg_addr, ret);
+			goto err;
+		}
+
+		if (set->val != val) {
+			dev_err(dev,
+				"I2c read's mismatch for slv:%x at addr%x exp%d got%d\n",
+				set->slv_addr, set->reg_addr, set->val, val);
+			goto err;
+		}
+		pos += sizeof(struct qcom_qps615_pwrctl_i2c_setting);
+	}
+
+err:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int qcom_qps615_power_on(struct qcom_qps615_pwrctl_ctx *ctx)
+{
+	int ret;
+
+	ret = regulator_enable(ctx->vdd);
+	if (ret) {
+		dev_err(ctx->pwrctl.dev, "cannot enable vdda regulator\n");
+		return ret;
+	}
+
+	ret = qcom_qps615_pwrctl_init(ctx);
+	if (ret)
+		regulator_disable(ctx->vdd);
+
+	return ret;
+}
+
+static int qcom_qps615_power_off(struct qcom_qps615_pwrctl_ctx *ctx)
+{
+	return regulator_disable(ctx->vdd);
+}
+
+static int qcom_qps615_pwrctl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = pdev->dev.of_node;
+	struct qcom_qps615_pwrctl_ctx *ctx;
+	struct device_node *adapter_node;
+	struct pci_host_bridge *bridge;
+	struct i2c_adapter *adapter;
+	struct pci_bus *bus;
+
+	bus = pci_find_bus(of_get_pci_domain_nr(dev->parent->of_node), 0);
+	if (!bus)
+		return -ENODEV;
+
+	bridge = pci_find_host_bridge(bus);
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	adapter_node = of_parse_phandle(node, "switch-i2c-cntrl", 0);
+	if (adapter_node) {
+		adapter = of_get_i2c_adapter_by_node(adapter_node);
+		__free(adapter_node);
+		if (!adapter)
+			return dev_err_probe(dev, -EPROBE_DEFER,
+					     "failed to parse switch-i2c-cntrl\n");
+	}
+
+	ctx->pwrctl.dev = dev;
+	ctx->adapter = adapter;
+	ctx->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(ctx->vdd))
+		return dev_err_probe(dev, PTR_ERR(ctx->vdd),
+				     "failed to get vdd regulator\n");
+
+	ctx->link = device_link_add(&bridge->dev, dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+
+	platform_set_drvdata(pdev, ctx);
+
+	bridge->ops->stop_link(bus);
+	qcom_qps615_power_on(ctx);
+	bridge->ops->start_link(bus);
+
+	return devm_pci_pwrctl_device_set_ready(dev, &ctx->pwrctl);
+}
+
+static const struct of_device_id qcom_qps615_pwrctl_of_match[] = {
+	{
+		.compatible = "pci1179,0623",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qcom_qps615_pwrctl_of_match);
+
+static int pci_pwrctl_suspend_noirq(struct device *dev)
+{
+	struct pci_bus *bus = pci_find_bus(of_get_pci_domain_nr(dev->parent->of_node), 0);
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
+	struct qcom_qps615_pwrctl_ctx *ctx = dev_get_drvdata(dev);
+
+	bridge->ops->stop_link(bus);
+	qcom_qps615_power_off(ctx);
+
+	return 0;
+}
+
+static int pci_pwrctl_resume_noirq(struct device *dev)
+{
+	struct pci_bus *bus = pci_find_bus(of_get_pci_domain_nr(dev->parent->of_node), 0);
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
+	struct qcom_qps615_pwrctl_ctx *ctx = dev_get_drvdata(dev);
+
+	qcom_qps615_power_on(ctx);
+	bridge->ops->start_link(bus);
+
+	return 0;
+}
+
+static void qcom_qps615_pwrctl_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct qcom_qps615_pwrctl_ctx *ctx = dev_get_drvdata(dev);
+
+	device_link_del(ctx->link);
+	pci_pwrctl_suspend_noirq(dev);
+}
+
+static const struct dev_pm_ops pci_pwrctl_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(pci_pwrctl_suspend_noirq, pci_pwrctl_resume_noirq)
+};
+
+static struct platform_driver qcom_qps615_pwrctl_driver = {
+	.driver = {
+		.name = "pwrctl-qps615",
+		.of_match_table = qcom_qps615_pwrctl_of_match,
+		.pm = &pci_pwrctl_pm_ops,
+	},
+	.probe = qcom_qps615_pwrctl_probe,
+	.remove_new = qcom_qps615_pwrctl_remove,
+};
+module_platform_driver(qcom_qps615_pwrctl_driver);
+
+MODULE_AUTHOR("Krishna chaitanya chundru <quic_krichai@quicinc.com>");
+MODULE_DESCRIPTION("Qualcomm QPS615 power control driver");
+MODULE_LICENSE("GPL");

-- 
2.42.0


