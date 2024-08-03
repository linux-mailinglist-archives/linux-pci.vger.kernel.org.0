Return-Path: <linux-pci+bounces-11221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0431694670C
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 05:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0FFDB21928
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 03:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F180EE556;
	Sat,  3 Aug 2024 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MrS/un8Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44AF6FC1;
	Sat,  3 Aug 2024 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722655561; cv=none; b=VwaPds/vsD7wdWCjVy2yRUWiL1Y3MIBDu4Z0v6CvQpLrsqfEK8eVVCM44L/Jtli2D/Pt/W1jLZbmFJq8SjJ0WvnZA6tUNArCKq30COyeRpsgRR8dY9qvNtt0wMn+944hfDXGx68qv+xkdeUy3qeV72yUtDqXrGlk1Io+OycVg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722655561; c=relaxed/simple;
	bh=HNYkkv+sXMm1J4kh7WdDJ3hcQrC7iseoPfzcI773leU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bt72DnOm/rMdQM+M9kLd7NxZ4ER/TijxYqRNkNL0YxHBe1Q76WcOCbZnELRs/SIFxnibtKJzRDkqSbogS+C8IE4T4gvWT71slNQ6RGWCa3bD6pTTH/gm8vwwgcW44/JnaK0CSgJ+52wMi/E61tPsq1ApQI+qXtQc2OiZDp99VZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MrS/un8Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4732wWqt019779;
	Sat, 3 Aug 2024 03:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JMH68eSD1vE4pWNzjB1FfjxmsW8NPTtdc3prY4rjfkA=; b=MrS/un8QL2XePhNp
	2mxFPdti/ZhS3xa9FfbVLwJVseyfO3tzAyXmLO3M0NGvhx1UYM1yAJk4ce4KewEd
	bM6FsYD5N9bOTtCI3cmIfkWGtFnrodNSgnriZsA3Oy3r4VFe0D2PUq51omgaOKXP
	rT2dNgJX0BBTZORNMa7KVteG6TkSdmU7xEqEa1sXq01zSabDJurrCKw+tBLB6My2
	Lr0xSh3p0+MWy24rgx0U/Cusc0v7zViXBmmBIdfBnOZ4iYEof7DFiCS1+mOII2Ib
	7iFbNyvHM1XDtqscyJCoe3Cm5hwLpGEbIj34CGs0JddPJdDqOTJYUNS9Uv62sg9s
	za4KBA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40rjgck1nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Aug 2024 03:23:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4733NoXM021897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Aug 2024 03:23:50 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 2 Aug 2024 20:23:45 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 3 Aug 2024 08:52:54 +0530
Subject: [PATCH v2 8/8] PCI: pwrctl: Add power control driver for qps615
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240803-qps615-v2-8-9560b7c71369@quicinc.com>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
In-Reply-To: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>
CC: <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722655379; l=18789;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=HNYkkv+sXMm1J4kh7WdDJ3hcQrC7iseoPfzcI773leU=;
 b=knw6owNTQaPBqZi+allSxMXIZddxsRuwXfDR8qIXroDt3mdVopztk3AQQfz96Ttqm0CoZhWYP
 IhG+A7zWdPsCpf7dEZBc06pgieSxjTaLjZ8MOyRBQDYmppnJkoYezmi
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bWI8Hq_eLqSRT0IjZRI88Hz0oSe5eDLj
X-Proofpoint-GUID: bWI8Hq_eLqSRT0IjZRI88Hz0oSe5eDLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_20,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408030020

QPS615 switch needs to be configured after powering on and before
PCIe link was up.

As the PCIe controller driver already enables the PCIe link training
at the host side, stop the link training. Otherwise the moment we turn
on the switch it will participate in the link training and link may come
up before switch is configured through i2c.

The device tree properties are parsed per node under pci-pci bridge in the
driver. Each node has unique bdf value in the reg property, driver
uses this bdf to differentiate ports, as there are certain i2c writes to
select particular port.

Based up on dt property and port, qps615 is configured through i2c.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/pwrctl/Kconfig             |   7 +
 drivers/pci/pwrctl/Makefile            |   1 +
 drivers/pci/pwrctl/pci-pwrctl-qps615.c | 638 +++++++++++++++++++++++++++++++++
 3 files changed, 646 insertions(+)

diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
index 54589bb2403b..6a1352af918c 100644
--- a/drivers/pci/pwrctl/Kconfig
+++ b/drivers/pci/pwrctl/Kconfig
@@ -10,3 +10,10 @@ config PCI_PWRCTL_PWRSEQ
 	tristate
 	select POWER_SEQUENCING
 	select PCI_PWRCTL
+
+config PCI_PWRCTL_QPS615
+	tristate "PCI Power Control driver for QPS615"
+	select PCI_PWRCTL
+	help
+	  Say Y here to enable the pwrctl driver for Qualcomm
+	  QPS615 PCIe switch.
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
index 000000000000..9dabb82787d5
--- /dev/null
+++ b/drivers/pci/pwrctl/pci-pwrctl-qps615.c
@@ -0,0 +1,638 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/pci-pwrctl.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "../pci.h"
+
+#define QPS615_GPIO_CONFIG		0x801208
+#define QPS615_RESET_GPIO		0x801210
+
+#define QPS615_BUS_CONTROL		0x801014
+
+#define QPS615_PORT_L0S_DELAY		0x82496c
+#define QPS615_PORT_L1_DELAY		0x824970
+
+#define QPS615_EMBEDDED_ETH_DELAY	0x8200d8
+#define QPS615_ETH_L1_DELAY_MASK	GENMASK(27, 18)
+#define QPS615_ETH_L1_DELAY_VALUE(x)	FIELD_PREP(QPS615_ETH_L1_DELAY_MASK, x)
+#define QPS615_ETH_L0S_DELAY_MASK	GENMASK(17, 13)
+#define QPS615_ETH_L0S_DELAY_VALUE(x)	FIELD_PREP(QPS615_ETH_L0S_DELAY_MASK, x)
+
+#define QPS615_NFTS_2_5_GT		0x824978
+#define QPS615_NFTS_5_GT		0x82497c
+
+#define QPS615_PORT_LANE_ACCESS_ENABLE	0x828000
+
+#define QPS615_PHY_RATE_CHANGE_OVERRIDE	0x828040
+#define QPS615_PHY_RATE_CHANGE		0x828050
+
+#define QPS615_TX_MARGIN		0x828234
+
+#define QPS615_DFE_ENABLE		0x828a04
+#define QPS615_DFE_EQ0_MODE		0x828a08
+#define QPS615_DFE_EQ1_MODE		0x828a0c
+#define QPS615_DFE_EQ2_MODE		0x828a14
+#define QPS615_DFE_PD_MASK		0x828254
+
+#define QPS615_PORT_SELECT		0x82c02c
+#define QPS615_PORT_ACCESS_ENABLE	0x82c030
+
+#define QPS615_POWER_CONTROL		0x82b09c
+#define QPS615_POWER_CONTROL_OVREN	0x82b2c8
+
+#define QPS615_AXI_CLK_FREQ_MHZ		125
+
+struct qps615_pwrctl_reg_setting {
+	unsigned int offset;
+	unsigned int val;
+};
+
+struct qps615_pwrctl_bdf_info {
+	u16 usp_bdf;
+	u16 dsp1_bdf;
+	u16 dsp2_bdf;
+	u16 dsp3_bdf;
+};
+
+enum qps615_pwrctl_ports {
+	QPS615_USP,
+	QPS615_DSP1,
+	QPS615_DSP2,
+	QPS615_DSP3,
+	QPS615_ETHERNET,
+	QPS615_MAX
+};
+
+struct qps615_pwrctl_cfg {
+	u32 l0s_delay;
+	u32 l1_delay;
+	u32 tx_amp;
+	u32 axi_freq;
+	u8  nfts;
+	bool disable_dfe;
+	bool disable_port;
+};
+
+#define QPS615_PWRCTL_MAX_SUPPLY	6
+
+struct qps615_pwrctl_ctx {
+	struct regulator_bulk_data supplies[QPS615_PWRCTL_MAX_SUPPLY];
+	const struct qps615_pwrctl_bdf_info *bdf;
+	struct qps615_pwrctl_cfg cfg[QPS615_MAX];
+	struct gpio_desc *reset_gpio;
+	struct i2c_client *client;
+	struct pci_pwrctl pwrctl;
+	struct device_link *link;
+};
+
+/*
+ * downstream port power off sequence, hardcoding the address
+ * as we don't know register names for these register offsets.
+ */
+static const struct qps615_pwrctl_reg_setting common_pwroff_seq[] = {
+	{0x82900c, 0x1},
+	{0x829010, 0x1},
+	{0x829018, 0x0},
+	{0x829020, 0x1},
+	{0x82902c, 0x1},
+	{0x829030, 0x1},
+	{0x82903c, 0x1},
+	{0x829058, 0x0},
+	{0x82905c, 0x1},
+	{0x829060, 0x1},
+	{0x8290cc, 0x1},
+	{0x8290d0, 0x1},
+	{0x8290d8, 0x1},
+	{0x8290e0, 0x1},
+	{0x8290e8, 0x1},
+	{0x8290ec, 0x1},
+	{0x8290f4, 0x1},
+	{0x82910c, 0x1},
+	{0x829110, 0x1},
+	{0x829114, 0x1},
+};
+
+static const struct qps615_pwrctl_reg_setting dsp1_pwroff_seq[] = {
+	{QPS615_PORT_ACCESS_ENABLE, 0x2},
+	{QPS615_PORT_LANE_ACCESS_ENABLE, 0x3},
+	{QPS615_POWER_CONTROL, 0x014f4804},
+	{QPS615_POWER_CONTROL_OVREN, 0x1},
+	{QPS615_PORT_ACCESS_ENABLE, 0x4},
+};
+
+static const struct qps615_pwrctl_reg_setting dsp2_pwroff_seq[] = {
+	{QPS615_PORT_ACCESS_ENABLE, 0x8},
+	{QPS615_PORT_LANE_ACCESS_ENABLE, 0x1},
+	{QPS615_POWER_CONTROL, 0x014f4804},
+	{QPS615_POWER_CONTROL_OVREN, 0x1},
+	{QPS615_PORT_ACCESS_ENABLE, 0x8},
+};
+
+static int qps615_pwrctl_i2c_write(struct i2c_client *client,
+				   u32 reg_addr, u32 reg_val)
+{
+	struct i2c_msg msg;
+	u8 msg_buf[7];
+	int ret;
+
+	msg.addr = client->addr;
+	msg.len = 7;
+	msg.flags = 0;
+
+	/* Big Endian for reg addr */
+	reg_addr = cpu_to_be32(reg_addr);
+
+	msg_buf[0] = (u8)(reg_addr >> 8);
+	msg_buf[1] = (u8)(reg_addr >> 16);
+	msg_buf[2] = (u8)(reg_addr >> 24);
+
+	/* Little Endian for reg val */
+	reg_val = cpu_to_le32(reg_val);
+
+	msg_buf[3] = (u8)(reg_val);
+	msg_buf[4] = (u8)(reg_val >> 8);
+	msg_buf[5] = (u8)(reg_val >> 16);
+	msg_buf[6] = (u8)(reg_val >> 24);
+
+	msg.buf = msg_buf;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	return ret == 1 ? 0 : ret;
+}
+
+static int qps615_pwrctl_i2c_read(struct i2c_client *client,
+				  u32 reg_addr, u32 *reg_val)
+{
+	struct i2c_msg msg[2];
+	u8 wr_data[3];
+	u32 rd_data;
+	int ret;
+
+	msg[0].addr = client->addr;
+	msg[0].len = 3;
+	msg[0].flags = 0;
+
+	/* Big Endian for reg addr */
+	reg_addr = cpu_to_be32(reg_addr);
+
+	wr_data[0] = (u8)(reg_addr >> 8);
+	wr_data[1] = (u8)(reg_addr >> 16);
+	wr_data[2] = (u8)(reg_addr >> 24);
+
+	msg[0].buf = wr_data;
+
+	msg[1].addr = client->addr;
+	msg[1].len = 4;
+	msg[1].flags = I2C_M_RD;
+
+	msg[1].buf = (u8 *)&rd_data;
+
+	ret = i2c_transfer(client->adapter, &msg[0], 2);
+	if (ret == 2) {
+		*reg_val = le32_to_cpu(rd_data);
+		return 0;
+	}
+
+	/* If only one message successfully completed, return -ENODEV */
+	return ret == 1 ? -ENODEV : ret;
+}
+
+static int qps615_pwrctl_i2c_bulk_write(struct i2c_client *client,
+					const struct qps615_pwrctl_reg_setting *seq, int len)
+{
+	int ret, i;
+
+	for (i = 0; i < len; i++) {
+		ret = qps615_pwrctl_i2c_write(client, seq[i].offset, seq[i].val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int of_pci_get_bdf(struct device_node *np)
+{
+	u32 reg[5];
+	int error;
+
+	error = of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
+	if (error)
+		return error;
+
+	return (reg[0] >> 8) & 0xffff;
+}
+
+static int qps615_pwrctl_disable_port(struct qps615_pwrctl_ctx *ctx,
+				      enum qps615_pwrctl_ports port)
+{
+	const struct qps615_pwrctl_reg_setting *seq;
+	int ret, len;
+
+	seq = (port == QPS615_DSP1) ? dsp1_pwroff_seq : dsp2_pwroff_seq;
+	len = (port == QPS615_DSP1) ? ARRAY_SIZE(dsp1_pwroff_seq) : ARRAY_SIZE(dsp2_pwroff_seq);
+
+	ret = qps615_pwrctl_i2c_bulk_write(ctx->client, seq, len);
+	if (ret)
+		return ret;
+
+	return qps615_pwrctl_i2c_bulk_write(ctx->client,
+					    common_pwroff_seq, ARRAY_SIZE(common_pwroff_seq));
+}
+
+static int qps615_pwrctl_set_l0s_l1_entry_delay(struct qps615_pwrctl_ctx *ctx,
+						enum qps615_pwrctl_ports port, bool is_l1, u32 ns)
+{
+	u32 rd_val, units;
+	int ret;
+
+	/* convert to units of 256ns */
+	units = ns / 256;
+
+	if (port == QPS615_ETHERNET) {
+		ret = qps615_pwrctl_i2c_read(ctx->client, QPS615_EMBEDDED_ETH_DELAY, &rd_val);
+		if (ret)
+			return ret;
+		rd_val = u32_replace_bits(rd_val, units,
+					  is_l1 ?
+					  QPS615_ETH_L1_DELAY_MASK : QPS615_ETH_L0S_DELAY_MASK);
+		return qps615_pwrctl_i2c_write(ctx->client, QPS615_EMBEDDED_ETH_DELAY, rd_val);
+	}
+
+	ret = qps615_pwrctl_i2c_write(ctx->client, QPS615_PORT_SELECT, BIT(port));
+	if (ret)
+		return ret;
+
+	return qps615_pwrctl_i2c_write(ctx->client,
+				       is_l1 ? QPS615_PORT_L1_DELAY : QPS615_PORT_L0S_DELAY, units);
+}
+
+static int qps615_pwrctl_set_tx_amplitude(struct qps615_pwrctl_ctx *ctx,
+					  enum qps615_pwrctl_ports port, u32 amp)
+{
+	int port_access;
+
+	switch (port) {
+	case QPS615_USP:
+		port_access = 0x1;
+		break;
+	case QPS615_DSP1:
+		port_access = 0x2;
+		break;
+	case QPS615_DSP2:
+		port_access = 0x8;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	struct qps615_pwrctl_reg_setting tx_amp_seq[] = {
+		{QPS615_PORT_ACCESS_ENABLE, port_access},
+		{QPS615_PORT_LANE_ACCESS_ENABLE, 0x3},
+		{QPS615_TX_MARGIN, amp},
+	};
+
+	return qps615_pwrctl_i2c_bulk_write(ctx->client, tx_amp_seq, ARRAY_SIZE(tx_amp_seq));
+}
+
+static int qps615_pwrctl_disable_dfe(struct qps615_pwrctl_ctx *ctx,
+				     enum qps615_pwrctl_ports port)
+{
+	int port_access, lane_access = 0x3;
+	u32 phy_rate = 0x21;
+
+	switch (port) {
+	case QPS615_USP:
+		phy_rate = 0x1;
+		port_access = 0x1;
+		break;
+	case QPS615_DSP1:
+		port_access = 0x2;
+		break;
+	case QPS615_DSP2:
+		port_access = 0x8;
+		lane_access = 0x1;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	struct qps615_pwrctl_reg_setting disable_dfe_seq[] = {
+		{QPS615_PORT_ACCESS_ENABLE, port_access},
+		{QPS615_PORT_LANE_ACCESS_ENABLE, lane_access},
+		{QPS615_DFE_ENABLE, 0x0},
+		{QPS615_DFE_EQ0_MODE, 0x411},
+		{QPS615_DFE_EQ1_MODE, 0x11},
+		{QPS615_DFE_EQ2_MODE, 0x11},
+		{QPS615_DFE_PD_MASK, 0x7},
+		{QPS615_PHY_RATE_CHANGE_OVERRIDE, 0x10},
+		{QPS615_PHY_RATE_CHANGE, phy_rate},
+		{QPS615_PHY_RATE_CHANGE, 0x0},
+		{QPS615_PHY_RATE_CHANGE_OVERRIDE, 0x0},
+
+	};
+
+	return qps615_pwrctl_i2c_bulk_write(ctx->client,
+					    disable_dfe_seq, ARRAY_SIZE(disable_dfe_seq));
+}
+
+static int qps615_pwrctl_set_nfts(struct qps615_pwrctl_ctx *ctx,
+				  enum qps615_pwrctl_ports port, u32 nfts)
+{
+	int ret;
+	struct qps615_pwrctl_reg_setting nfts_seq[] = {
+		{QPS615_NFTS_2_5_GT, nfts},
+		{QPS615_NFTS_5_GT, nfts},
+	};
+
+	ret =  qps615_pwrctl_i2c_write(ctx->client, QPS615_PORT_SELECT, BIT(port));
+	if (ret)
+		return ret;
+
+	return qps615_pwrctl_i2c_bulk_write(ctx->client, nfts_seq, ARRAY_SIZE(nfts_seq));
+}
+
+static int qps615_pwrctl_assert_deassert_reset(struct qps615_pwrctl_ctx *ctx, bool deassert)
+{
+	int ret, val = 0;
+
+	if (deassert)
+		val = 0xc;
+
+	ret = qps615_pwrctl_i2c_write(ctx->client, QPS615_GPIO_CONFIG, 0xfffffff3);
+	if (ret)
+		return ret;
+
+	return qps615_pwrctl_i2c_write(ctx->client, QPS615_RESET_GPIO, val);
+}
+
+static int qps615_pwrctl_parse_device_dt(struct qps615_pwrctl_ctx *ctx, struct device_node *node)
+{
+	enum qps615_pwrctl_ports port;
+	struct qps615_pwrctl_cfg *cfg;
+	struct device_node *np;
+	int bdf, fun_no;
+
+	bdf = of_pci_get_bdf(node);
+	if (bdf < 0) {
+		dev_err(ctx->pwrctl.dev, "Getting BDF failed\n");
+		return 0;
+	}
+
+	fun_no = bdf & 0x7;
+
+	/* In multi function node, ignore function 1 node */
+	if (of_pci_get_bdf(of_get_parent(node)) == ctx->bdf->dsp3_bdf && !fun_no)
+		port = QPS615_ETHERNET;
+	else if (bdf == ctx->bdf->usp_bdf)
+		port = QPS615_USP;
+	else if (bdf == ctx->bdf->dsp1_bdf)
+		port = QPS615_DSP1;
+	else if (bdf == ctx->bdf->dsp2_bdf)
+		port = QPS615_DSP2;
+	else if (bdf == ctx->bdf->dsp3_bdf)
+		port = QPS615_DSP3;
+	else
+		return 0;
+
+	cfg = &ctx->cfg[port];
+
+	if (!of_device_is_available(node)) {
+		cfg->disable_port = true;
+		return 0;
+	};
+
+	of_property_read_u32(node, "qcom,axi-clk-freq-hz", &cfg->axi_freq);
+
+	of_property_read_u32(node, "qcom,l0s-entry-delay-ns", &cfg->l0s_delay);
+
+	of_property_read_u32(node, "qcom,l1-entry-delay-ns", &cfg->l1_delay);
+
+	of_property_read_u32(node, "qcom,tx-amplitude-millivolt", &cfg->tx_amp);
+
+	cfg->disable_dfe = of_property_read_bool(node, "qcom,no-dfe");
+
+	of_property_read_u8(node, "qcom,nfts", &cfg->nfts);
+
+	for_each_child_of_node(node, np)
+		qps615_pwrctl_parse_device_dt(ctx, np);
+
+	of_node_put(np);
+	return 0;
+}
+
+static void qps615_pwrctl_power_off(struct qps615_pwrctl_ctx *ctx)
+{
+	gpiod_set_value(ctx->reset_gpio, 1);
+
+	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+}
+
+static int qps615_pwrctl_power_on(struct qps615_pwrctl_ctx *ctx)
+{
+	struct qps615_pwrctl_cfg *cfg;
+	int ret, i;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret < 0)
+		return dev_err_probe(ctx->pwrctl.dev, ret, "cannot enable regulators\n");
+
+	gpiod_set_value(ctx->reset_gpio, 0);
+
+	if (!ctx->client)
+		return 0;
+
+	/*
+	 * Don't have a way to see if the reset has completed.
+	 * Wait for some time.
+	 */
+	usleep_range(1000, 1001);
+
+	ret = qps615_pwrctl_assert_deassert_reset(ctx, false);
+	if (ret)
+		goto out;
+
+	if (ctx->cfg[QPS615_USP].axi_freq == QPS615_AXI_CLK_FREQ_MHZ) {
+		ret = qps615_pwrctl_i2c_write(ctx->client, QPS615_BUS_CONTROL, BIT(16));
+		if (ret)
+			dev_err(ctx->pwrctl.dev, "Setting axi clk freq failed %d\n", ret);
+	}
+
+	for (i = 0; i < QPS615_MAX; i++) {
+		cfg = &ctx->cfg[i];
+		if (cfg->disable_port) {
+			ret = qps615_pwrctl_disable_port(ctx, i);
+			if (ret) {
+				dev_err(ctx->pwrctl.dev, "Disabling port failed\n");
+				goto out;
+			}
+		}
+
+		if (cfg->l0s_delay) {
+			ret = qps615_pwrctl_set_l0s_l1_entry_delay(ctx, i, false, cfg->l0s_delay);
+			if (ret) {
+				dev_err(ctx->pwrctl.dev, "Setting L0s entry delay failed\n");
+				goto out;
+			}
+		}
+
+		if (cfg->l1_delay) {
+			ret = qps615_pwrctl_set_l0s_l1_entry_delay(ctx, i, true, cfg->l1_delay);
+			if (ret) {
+				dev_err(ctx->pwrctl.dev, "Setting L1 entry delay failed\n");
+				goto out;
+			}
+		}
+
+		if (cfg->tx_amp) {
+			ret = qps615_pwrctl_set_tx_amplitude(ctx, i, cfg->tx_amp);
+			if (ret) {
+				dev_err(ctx->pwrctl.dev, "Setting Tx amplitube failed\n");
+				goto out;
+			}
+		}
+
+		if (cfg->nfts) {
+			ret = qps615_pwrctl_set_nfts(ctx, i, cfg->nfts);
+			if (ret) {
+				dev_err(ctx->pwrctl.dev, "Setting nfts failed\n");
+				goto out;
+			}
+		}
+
+		if (cfg->disable_dfe) {
+			ret = qps615_pwrctl_disable_dfe(ctx, i);
+			if (ret) {
+				dev_err(ctx->pwrctl.dev, "Disabling DFE failed\n");
+				goto out;
+			}
+		}
+	}
+
+	ret = qps615_pwrctl_assert_deassert_reset(ctx, true);
+	if (!ret)
+		return 0;
+
+out:
+	qps615_pwrctl_power_off(ctx);
+	return ret;
+}
+
+static int qps615_pwrctl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
+	struct qps615_pwrctl_ctx *ctx;
+	struct device_node *node;
+	struct pci_bus *bus;
+	int ret;
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
+	node = of_parse_phandle(pdev->dev.of_node, "qcom,qps615-controller", 0);
+	if (node) {
+		ctx->client = of_find_i2c_device_by_node(node);
+		of_node_put(node);
+		if (!ctx->client)
+			return dev_err_probe(dev, -EPROBE_DEFER,
+					     "failed to parse qcom,qps615-controller\n");
+	}
+
+	ctx->bdf = of_device_get_match_data(dev);
+	ctx->pwrctl.dev = dev;
+
+	ctx->supplies[0].supply = "vddc";
+	ctx->supplies[1].supply = "vdd18";
+	ctx->supplies[2].supply = "vdd09";
+	ctx->supplies[3].supply = "vddio1";
+	ctx->supplies[4].supply = "vddio2";
+	ctx->supplies[5].supply = "vddio18";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get supply regulator\n");
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_ASIS);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio), "failed to get reset GPIO\n");
+
+	ctx->link = device_link_add(&bridge->dev, dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+
+	platform_set_drvdata(pdev, ctx);
+
+	qps615_pwrctl_parse_device_dt(ctx, pdev->dev.of_node);
+
+	if (bridge->ops->stop_link)
+		bridge->ops->stop_link(bus);
+
+	ret = qps615_pwrctl_power_on(ctx);
+	if (ret)
+		return ret;
+
+	if (bridge->ops->start_link) {
+		ret = bridge->ops->start_link(bus);
+		if (ret)
+			return ret;
+	}
+
+	return devm_pci_pwrctl_device_set_ready(dev, &ctx->pwrctl);
+}
+
+static void qps615_pwrctl_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct qps615_pwrctl_ctx *ctx = dev_get_drvdata(dev);
+
+	device_link_del(ctx->link);
+	qps615_pwrctl_power_off(ctx);
+}
+
+static const struct qps615_pwrctl_bdf_info bdf_info = {
+	.usp_bdf	= 0x100,
+	.dsp1_bdf	= 0x208,
+	.dsp2_bdf	= 0x210,
+	.dsp3_bdf	= 0x218,
+};
+
+static const struct of_device_id qps615_pwrctl_of_match[] = {
+	{ .compatible = "pci1179,0623", .data = &bdf_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qps615_pwrctl_of_match);
+
+static struct platform_driver qps615_pwrctl_driver = {
+	.driver = {
+		.name = "pwrctl-qps615",
+		.of_match_table = qps615_pwrctl_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe = qps615_pwrctl_probe,
+	.remove_new = qps615_pwrctl_remove,
+};
+module_platform_driver(qps615_pwrctl_driver);
+
+MODULE_AUTHOR("Krishna chaitanya chundru <quic_krichai@quicinc.com>");
+MODULE_DESCRIPTION("Qualcomm QPS615 power control driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


