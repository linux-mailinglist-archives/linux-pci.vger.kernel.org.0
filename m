Return-Path: <linux-pci+bounces-22308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFD5A439B7
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 10:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF7F7A124E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D481267385;
	Tue, 25 Feb 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M023T7U3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245D5263C72
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476122; cv=none; b=tNszOR4yM8ol5csYngA9O8UCxOV5s/himekWuknRRAIjdkoVYYwF3ZJehdRSxIQDqJCsbQh02lsPgupyJrG4SQGAqjlUabR71fUMb6PArM21ORxNQpjEZEdC+Fj0Lq6Of5oplPOyodQ2ChfeBN2KB7l/Pog+RZfH/GitHZTGVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476122; c=relaxed/simple;
	bh=LMnw2grkYulPRTIzz/uk3BUBKeG6SeucXy3zupQY8Lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0+/eRzGypWBf/ZYNEPinyof66oWPjzDX2eYZotLOp3PjxeX1k0A3I0Byj3/VZwnsATlF0u4tjpP9HcnetbFQO6RSqH6yMGLHt/BUJkykadKipbvK0CF3wJ/gNovPgZr9uFS/N3jkdh0GLM1mqaL3m8Yp3Khpm8h4uXd2mbrnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M023T7U3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8KWbf001891
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 09:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A9fZdEtJLTLJ8I/rg1Bh+UlQAgG6IA4uwVW+hCCb4w0=; b=M023T7U3bPOMZASj
	/uS7BmWDLnG08iGcFBTPRKXQWmxfP1XflkDulWwP7jXxYayJVWhCjkICvzwpc1X0
	yuMupGJ/9OXZi5R5FEu0MZvpeYxnu4epS4bonULx10ApqneIUjpU3ko5D7iHx549
	4eYffLU/dPleLfqmNeBMN2BkfX08LViEo7SB14xB4yjHg3wm4alrMa9VgHBr6C9m
	C5kRj4lIXiadQwxanWNKpUDUiQ6weCsuOjEbu76f2FUVIaYr4EcicT5IRPyTNmZw
	rqQ5YyfZPePZP2V6dkpJWCwKkUIFkJ5wRaN6ll1sUpUU0ugxXqvRSupL76ZQ1bWw
	7Wr2eQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y7rk061t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 09:35:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc0bc05bb5so11403981a91.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 01:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476118; x=1741080918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9fZdEtJLTLJ8I/rg1Bh+UlQAgG6IA4uwVW+hCCb4w0=;
        b=q5IF+z6htO+/vrDSHIcJBhnql7k/NSFZ5Qa3wqKCKBqFztzOIYUjRQd2KQCq6Ac3cW
         GtPT3C9539GI9R4wdRLIGY5PoSga8DhzuEzaX+wo6ivtoNG1HQvKhf9U32I1SOeMhoEb
         lJ4/fLTm6wTv/w5b8qRZiypQB+5i+oeeWsicW9bw03NUYe81qpaDYuSKl/sIU3RGQDAg
         NX1tbMbbiBrDHQcAd0U5VLiss5SVINXaQXo1RxpIetssg8UE/cZnL4JHo5YD6WWTbrBf
         pcNxQmepdBU7ERh/rIuf7LTIatc5gy5RI5EsaH14DjIizPOLBXNBg0AcpckYmy6SpXT+
         rLQw==
X-Forwarded-Encrypted: i=1; AJvYcCUGgvRxyrjBeeOBNg4KvDPi6vAjyPn6cvOgB0jG2277wzeQvWVh1cMRo3IrqDjHf/EKzYSNuPpA1n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiV68VbjZSLKHxzs9V3ljSXskv6Kcg1I2kDkY6ZqFxKZyRRBjS
	SQmn42yrZgQb7HSKoyzlN8m8NiqP/KHzm4m55lDm1FZz5m2xf6VFhviyLxPYjtmt03v7+Bp8tF/
	m9A5zgEdxlImIwOQQtD5wOcpuIVFnt3+/lVqXt3LwqNdrpjyM2Kz+xHSgu2o=
X-Gm-Gg: ASbGnctWB0WBoByE+D4Yj1B2ITlNJM3XabJxCXMI2hlfiOeWkZRc47Meae2pdHOOzOQ
	uS2jjoLe4kTcZrjJz1r4N/aUj7TJWDgsnInXfT/iV34wrACV/S736i9lHGeLX4RBqgt4vZ1GXJ5
	PBaSRoj1TXt1r4biPYtLuk/hkDYOEKbn2SueT8EVkz3CREgaUt2vxlVsx/3M9fnWbrmm0jmqCaO
	QGHkE5ROsSsAwQ/+WuLQJvEd9EWN34lrYczAf9BZZd8vb2CG1fGlwFs9xd0x99LXHWXJeHrCziH
	sfaLYAATn/zuGFBqaU2jFFENPq2rPqmsVZNhQW9xq2aZP0At8lA=
X-Received: by 2002:a17:90b:56d0:b0:2f5:747:cbd with SMTP id 98e67ed59e1d1-2fe68ae292bmr4764995a91.18.1740476118009;
        Tue, 25 Feb 2025 01:35:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpKoyaLC9BE0PgW+pLRLJ3ZL5Zr6S+ZXgHJQ0EqFLNIC8xFmJzelvUpI4UhVYHawu5ZXamxQ==
X-Received: by 2002:a17:90b:56d0:b0:2f5:747:cbd with SMTP id 98e67ed59e1d1-2fe68ae292bmr4764958a91.18.1740476117514;
        Tue, 25 Feb 2025 01:35:17 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a3dec52sm1080770a91.20.2025.02.25.01.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:35:17 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 15:04:05 +0530
Subject: [PATCH v4 08/10] PCI: pwrctrl: Add power control driver for tc956x
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-qps615_v4_1-v4-8-e08633a7bdf8@oss.qualcomm.com>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
In-Reply-To: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740476062; l=19426;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=LMnw2grkYulPRTIzz/uk3BUBKeG6SeucXy3zupQY8Lo=;
 b=Cv10bXTLgL5Oc+3lVkZ9LI4O1smWriwz9Z1xqx/d9AISdVgq1ccCvbQUruiIlTfIY3FQAzuDQ
 AM2ZSSmUUD9A7OPZMFTDz23i7s9rFAcwNYmKV8+QYyT8cAR/FWHsPKH
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 22hQGICBqNLlcNwaUQd4myikHnh1AaIm
X-Proofpoint-ORIG-GUID: 22hQGICBqNLlcNwaUQd4myikHnh1AaIm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250066

TC956x is a PCIe switch which has one upstream and three downstream
ports. To one of the downstream ports ethernet MAC is connected as endpoint
device. Other two downstream ports are supposed to connect to external
device. One Host can connect to TC956x by upstream port. TC956x switch
needs to be configured after powering on and before PCIe link was up.

The PCIe controller driver already enables link training at the host side
even before this driver probe happens, due to this when driver enables
power to the switch it participates in the link training and PCIe link
may come up before configuring the switch through i2c. Once the link is
up the configuration done through i2c will not have any affect.To prevent
the host from participating in link training, disable link training on the
host side to ensure the link does not come up before the switch is
configured via I2C.

Based up on dt property and type of the port, tc956x is configured
through i2c.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctrl/Kconfig              |   6 +
 drivers/pci/pwrctrl/Makefile             |   1 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc956x.c | 625 +++++++++++++++++++++++++++++++
 3 files changed, 632 insertions(+)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index 54589bb2403b..ae8a0a39f586 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -10,3 +10,9 @@ config PCI_PWRCTL_PWRSEQ
 	tristate
 	select POWER_SEQUENCING
 	select PCI_PWRCTL
+
+config PCI_PWRCTRL_TC956X
+	tristate "PCI Power Control driver for TC956x PCIe switch"
+	select PCI_PWRCTL
+	help
+	  Say Y here to enable the pwrctrl driver for TC956x PCIe switch.
diff --git a/drivers/pci/pwrctrl/Makefile b/drivers/pci/pwrctrl/Makefile
index 75c7ce531c7e..93f32871260b 100644
--- a/drivers/pci/pwrctrl/Makefile
+++ b/drivers/pci/pwrctrl/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctrl-core.o
 pci-pwrctrl-core-y			:= core.o
 
 obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctrl-pwrseq.o
+obj-$(CONFIG_PCI_PWRCTRL_TC956X)	+= pci-pwrctrl-tc956x.o
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc956x.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc956x.c
new file mode 100644
index 000000000000..bf72bbcae536
--- /dev/null
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc956x.c
@@ -0,0 +1,625 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/pci-pwrctrl.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include "../pci.h"
+
+#define TC956X_GPIO_CONFIG		0x801208
+#define TC956X_RESET_GPIO		0x801210
+
+#define TC956X_BUS_CONTROL		0x801014
+
+#define TC956X_PORT_L0S_DELAY		0x82496c
+#define TC956X_PORT_L1_DELAY		0x824970
+
+#define TC956X_EMBEDDED_ETH_DELAY	0x8200d8
+#define TC956X_ETH_L1_DELAY_MASK	GENMASK(27, 18)
+#define TC956X_ETH_L1_DELAY_VALUE(x)	FIELD_PREP(TC956X_ETH_L1_DELAY_MASK, x)
+#define TC956X_ETH_L0S_DELAY_MASK	GENMASK(17, 13)
+#define TC956X_ETH_L0S_DELAY_VALUE(x)	FIELD_PREP(TC956X_ETH_L0S_DELAY_MASK, x)
+
+#define TC956X_NFTS_2_5_GT		0x824978
+#define TC956X_NFTS_5_GT		0x82497c
+
+#define TC956X_PORT_LANE_ACCESS_ENABLE	0x828000
+
+#define TC956X_PHY_RATE_CHANGE_OVERRIDE	0x828040
+#define TC956X_PHY_RATE_CHANGE		0x828050
+
+#define TC956X_TX_MARGIN		0x828234
+
+#define TC956X_DFE_ENABLE		0x828a04
+#define TC956X_DFE_EQ0_MODE		0x828a08
+#define TC956X_DFE_EQ1_MODE		0x828a0c
+#define TC956X_DFE_EQ2_MODE		0x828a14
+#define TC956X_DFE_PD_MASK		0x828254
+
+#define TC956X_PORT_SELECT		0x82c02c
+#define TC956X_PORT_ACCESS_ENABLE	0x82c030
+
+#define TC956X_POWER_CONTROL		0x82b09c
+#define TC956X_POWER_CONTROL_OVREN	0x82b2c8
+
+#define TC956X_GPIO_MASK		0xfffffff3
+
+#define TC956X_TX_MARGIN_MIN_VAL	400000
+
+struct tc956x_pwrctrl_reg_setting {
+	unsigned int offset;
+	unsigned int val;
+};
+
+enum tc956x_pwrctrl_ports {
+	TC956X_USP,
+	TC956X_DSP1,
+	TC956X_DSP2,
+	TC956X_DSP3,
+	TC956X_ETHERNET,
+	TC956X_MAX
+};
+
+struct tc956x_pwrctrl_cfg {
+	u32 l0s_delay;
+	u32 l1_delay;
+	u32 tx_amp;
+	u8 nfts[2]; /* GEN1 & GEN2*/
+	bool disable_dfe;
+	bool disable_port;
+};
+
+#define TC956X_PWRCTL_MAX_SUPPLY	6
+
+struct tc956x_pwrctrl_ctx {
+	struct regulator_bulk_data supplies[TC956X_PWRCTL_MAX_SUPPLY];
+	struct tc956x_pwrctrl_cfg cfg[TC956X_MAX];
+	struct gpio_desc *reset_gpio;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+	struct pci_pwrctrl pwrctrl;
+};
+
+/*
+ * downstream port power off sequence, hardcoding the address
+ * as we don't know register names for these register offsets.
+ */
+static const struct tc956x_pwrctrl_reg_setting common_pwroff_seq[] = {
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
+static const struct tc956x_pwrctrl_reg_setting dsp1_pwroff_seq[] = {
+	{TC956X_PORT_ACCESS_ENABLE, 0x2},
+	{TC956X_PORT_LANE_ACCESS_ENABLE, 0x3},
+	{TC956X_POWER_CONTROL, 0x014f4804},
+	{TC956X_POWER_CONTROL_OVREN, 0x1},
+	{TC956X_PORT_ACCESS_ENABLE, 0x4},
+};
+
+static const struct tc956x_pwrctrl_reg_setting dsp2_pwroff_seq[] = {
+	{TC956X_PORT_ACCESS_ENABLE, 0x8},
+	{TC956X_PORT_LANE_ACCESS_ENABLE, 0x1},
+	{TC956X_POWER_CONTROL, 0x014f4804},
+	{TC956X_POWER_CONTROL_OVREN, 0x1},
+	{TC956X_PORT_ACCESS_ENABLE, 0x8},
+};
+
+/*
+ * Since all transfers are initiated by the probe, no locks are necessary,
+ * as there are no concurrent calls.
+ */
+static int tc956x_pwrctrl_i2c_write(struct i2c_client *client,
+				    u32 reg_addr, u32 reg_val)
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
+	put_unaligned_be24(reg_addr, &msg_buf[0]);
+
+	/* Little Endian for reg val */
+	put_unaligned_le32(reg_val, &msg_buf[3]);
+
+	msg.buf = msg_buf;
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	return ret == 1 ? 0 : ret;
+}
+
+static int tc956x_pwrctrl_i2c_read(struct i2c_client *client,
+				   u32 reg_addr, u32 *reg_val)
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
+	put_unaligned_be24(reg_addr, &wr_data[0]);
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
+		*reg_val = get_unaligned_le32(&rd_data);
+		return 0;
+	}
+
+	/* If only one message successfully completed, return -EIO */
+	return ret == 1 ? -EIO : ret;
+}
+
+static int tc956x_pwrctrl_i2c_bulk_write(struct i2c_client *client,
+					 const struct tc956x_pwrctrl_reg_setting *seq, int len)
+{
+	int ret, i;
+
+	for (i = 0; i < len; i++) {
+		ret = tc956x_pwrctrl_i2c_write(client, seq[i].offset, seq[i].val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int tc956x_pwrctrl_disable_port(struct tc956x_pwrctrl_ctx *ctx,
+				       enum tc956x_pwrctrl_ports port)
+{
+	struct tc956x_pwrctrl_cfg *cfg  = &ctx->cfg[port];
+	const struct tc956x_pwrctrl_reg_setting *seq;
+	int ret, len;
+
+	if (!cfg->disable_port)
+		return 0;
+
+	if (port == TC956X_DSP1) {
+		seq = dsp1_pwroff_seq;
+		len = ARRAY_SIZE(dsp1_pwroff_seq);
+	} else {
+		seq = dsp2_pwroff_seq;
+		len = ARRAY_SIZE(dsp2_pwroff_seq);
+	}
+
+	ret = tc956x_pwrctrl_i2c_bulk_write(ctx->client, seq, len);
+	if (ret)
+		return ret;
+
+	return tc956x_pwrctrl_i2c_bulk_write(ctx->client,
+					    common_pwroff_seq, ARRAY_SIZE(common_pwroff_seq));
+}
+
+static int tc956x_pwrctrl_set_l0s_l1_entry_delay(struct tc956x_pwrctrl_ctx *ctx,
+						 enum tc956x_pwrctrl_ports port, bool is_l1, u32 ns)
+{
+	u32 rd_val, units;
+	int ret;
+
+	if (!ns)
+		return 0;
+
+	/* convert to units of 256ns */
+	units = ns / 256;
+
+	if (port == TC956X_ETHERNET) {
+		ret = tc956x_pwrctrl_i2c_read(ctx->client, TC956X_EMBEDDED_ETH_DELAY, &rd_val);
+		if (ret)
+			return ret;
+
+		if (is_l1)
+			rd_val = u32_replace_bits(rd_val, units, TC956X_ETH_L1_DELAY_MASK);
+		else
+			rd_val = u32_replace_bits(rd_val, units, TC956X_ETH_L0S_DELAY_MASK);
+
+		return tc956x_pwrctrl_i2c_write(ctx->client, TC956X_EMBEDDED_ETH_DELAY, rd_val);
+	}
+
+	ret = tc956x_pwrctrl_i2c_write(ctx->client, TC956X_PORT_SELECT, BIT(port));
+	if (ret)
+		return ret;
+
+	return tc956x_pwrctrl_i2c_write(ctx->client,
+				       is_l1 ? TC956X_PORT_L1_DELAY : TC956X_PORT_L0S_DELAY, units);
+}
+
+static int tc956x_pwrctrl_set_tx_amplitude(struct tc956x_pwrctrl_ctx *ctx,
+					   enum tc956x_pwrctrl_ports port, u32 amp)
+{
+	int port_access;
+
+	if (amp < TC956X_TX_MARGIN_MIN_VAL)
+		return 0;
+
+	/*  txmargin = (Amp(uV) - 400000) / 3125 */
+	amp = (amp - TC956X_TX_MARGIN_MIN_VAL) / 3125;
+
+	switch (port) {
+	case TC956X_USP:
+		port_access = 0x1;
+		break;
+	case TC956X_DSP1:
+		port_access = 0x2;
+		break;
+	case TC956X_DSP2:
+		port_access = 0x8;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	struct tc956x_pwrctrl_reg_setting tx_amp_seq[] = {
+		{TC956X_PORT_ACCESS_ENABLE, port_access},
+		{TC956X_PORT_LANE_ACCESS_ENABLE, 0x3},
+		{TC956X_TX_MARGIN, amp},
+	};
+
+	return tc956x_pwrctrl_i2c_bulk_write(ctx->client, tx_amp_seq, ARRAY_SIZE(tx_amp_seq));
+}
+
+static int tc956x_pwrctrl_disable_dfe(struct tc956x_pwrctrl_ctx *ctx,
+				      enum tc956x_pwrctrl_ports port)
+{
+	struct tc956x_pwrctrl_cfg *cfg  = &ctx->cfg[port];
+	int port_access, lane_access = 0x3;
+	u32 phy_rate = 0x21;
+
+	if (!cfg->disable_dfe)
+		return 0;
+
+	switch (port) {
+	case TC956X_USP:
+		phy_rate = 0x1;
+		port_access = 0x1;
+		break;
+	case TC956X_DSP1:
+		port_access = 0x2;
+		break;
+	case TC956X_DSP2:
+		port_access = 0x8;
+		lane_access = 0x1;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	struct tc956x_pwrctrl_reg_setting disable_dfe_seq[] = {
+		{TC956X_PORT_ACCESS_ENABLE, port_access},
+		{TC956X_PORT_LANE_ACCESS_ENABLE, lane_access},
+		{TC956X_DFE_ENABLE, 0x0},
+		{TC956X_DFE_EQ0_MODE, 0x411},
+		{TC956X_DFE_EQ1_MODE, 0x11},
+		{TC956X_DFE_EQ2_MODE, 0x11},
+		{TC956X_DFE_PD_MASK, 0x7},
+		{TC956X_PHY_RATE_CHANGE_OVERRIDE, 0x10},
+		{TC956X_PHY_RATE_CHANGE, phy_rate},
+		{TC956X_PHY_RATE_CHANGE, 0x0},
+		{TC956X_PHY_RATE_CHANGE_OVERRIDE, 0x0},
+	};
+
+	return tc956x_pwrctrl_i2c_bulk_write(ctx->client,
+					    disable_dfe_seq, ARRAY_SIZE(disable_dfe_seq));
+}
+
+static int tc956x_pwrctrl_set_nfts(struct tc956x_pwrctrl_ctx *ctx,
+				   enum tc956x_pwrctrl_ports port, u8 *nfts)
+{
+	struct tc956x_pwrctrl_reg_setting nfts_seq[] = {
+		{TC956X_NFTS_2_5_GT, nfts[0]},
+		{TC956X_NFTS_5_GT, nfts[1]},
+	};
+	int ret;
+
+	if (!nfts[0])
+		return 0;
+
+	ret =  tc956x_pwrctrl_i2c_write(ctx->client, TC956X_PORT_SELECT, BIT(port));
+	if (ret)
+		return ret;
+
+	return tc956x_pwrctrl_i2c_bulk_write(ctx->client, nfts_seq, ARRAY_SIZE(nfts_seq));
+}
+
+static int tc956x_pwrctrl_assert_deassert_reset(struct tc956x_pwrctrl_ctx *ctx, bool deassert)
+{
+	int ret, val;
+
+	ret = tc956x_pwrctrl_i2c_write(ctx->client, TC956X_GPIO_CONFIG, TC956X_GPIO_MASK);
+	if (ret)
+		return ret;
+
+	val = deassert ? 0xc : 0;
+
+	return tc956x_pwrctrl_i2c_write(ctx->client, TC956X_RESET_GPIO, val);
+}
+
+static int tc956x_pwrctrl_parse_device_dt(struct tc956x_pwrctrl_ctx *ctx, struct device_node *node,
+					  enum tc956x_pwrctrl_ports port)
+{
+	struct tc956x_pwrctrl_cfg *cfg;
+	int ret;
+
+	cfg = &ctx->cfg[port];
+
+	/* Disable port if the status of the port is disabled. */
+	if (!of_device_is_available(node)) {
+		cfg->disable_port = true;
+		return 0;
+	};
+
+	ret = of_property_read_u32(node, "aspm-l0s-entry-delay-ns", &cfg->l0s_delay);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	ret = of_property_read_u32(node, "aspm-l1-entry-delay-ns", &cfg->l1_delay);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	ret = of_property_read_u32(node, "qcom,tx-amplitude-microvolt", &cfg->tx_amp);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	ret = of_property_read_u8_array(node, "nfts", cfg->nfts, 2);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	cfg->disable_dfe = of_property_read_bool(node, "qcom,no-dfe-support");
+
+	return 0;
+}
+
+static void tc956x_pwrctrl_power_off(struct tc956x_pwrctrl_ctx *ctx)
+{
+	gpiod_set_value(ctx->reset_gpio, 1);
+
+	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+}
+
+static int tc956x_pwrctrl_bring_up(struct tc956x_pwrctrl_ctx *ctx)
+{
+	struct tc956x_pwrctrl_cfg *cfg;
+	int ret, i;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret < 0)
+		return dev_err_probe(ctx->pwrctrl.dev, ret, "cannot enable regulators\n");
+
+	gpiod_set_value(ctx->reset_gpio, 0);
+
+	 /* wait for the internal osc frequency to stablise */
+	usleep_range(10000, 10500);
+
+	ret = tc956x_pwrctrl_assert_deassert_reset(ctx, false);
+	if (ret)
+		goto power_off;
+
+	for (i = 0; i < TC956X_MAX; i++) {
+		cfg = &ctx->cfg[i];
+		ret = tc956x_pwrctrl_disable_port(ctx, i);
+		if (ret) {
+			dev_err(ctx->pwrctrl.dev, "Disabling port failed\n");
+			goto power_off;
+		}
+
+		ret = tc956x_pwrctrl_set_l0s_l1_entry_delay(ctx, i, false, cfg->l0s_delay);
+		if (ret) {
+			dev_err(ctx->pwrctrl.dev, "Setting L0s entry delay failed\n");
+			goto power_off;
+		}
+
+		ret = tc956x_pwrctrl_set_l0s_l1_entry_delay(ctx, i, true, cfg->l1_delay);
+		if (ret) {
+			dev_err(ctx->pwrctrl.dev, "Setting L1 entry delay failed\n");
+			goto power_off;
+		}
+
+		ret = tc956x_pwrctrl_set_tx_amplitude(ctx, i, cfg->tx_amp);
+		if (ret) {
+			dev_err(ctx->pwrctrl.dev, "Setting Tx amplitube failed\n");
+			goto power_off;
+		}
+
+		ret = tc956x_pwrctrl_set_nfts(ctx, i, cfg->nfts);
+		if (ret) {
+			dev_err(ctx->pwrctrl.dev, "Setting nfts failed\n");
+			goto power_off;
+		}
+
+		ret = tc956x_pwrctrl_disable_dfe(ctx, i);
+		if (ret) {
+			dev_err(ctx->pwrctrl.dev, "Disabling DFE failed\n");
+			goto power_off;
+		}
+	}
+
+	ret = tc956x_pwrctrl_assert_deassert_reset(ctx, true);
+	if (!ret)
+		return 0;
+
+power_off:
+	tc956x_pwrctrl_power_off(ctx);
+	return ret;
+}
+
+static int tc956x_pwrctrl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pci_dev *pci_dev = to_pci_dev(dev->parent);
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pci_dev->bus);
+	enum tc956x_pwrctrl_ports port;
+	struct tc956x_pwrctrl_ctx *ctx;
+	int ret, addr;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_index(pdev->dev.of_node, "i2c-parent", 1, &addr);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read i2c-parent property\n");
+
+	ctx->adapter = of_find_i2c_adapter_by_node(of_parse_phandle(dev->of_node, "i2c-parent", 0));
+	of_node_put(dev->of_node);
+	if (!ctx->adapter)
+		return dev_err_probe(dev, -EPROBE_DEFER, "Failed to find I2C adapter\n");
+
+	ctx->client = i2c_new_dummy_device(ctx->adapter, addr);
+	if (IS_ERR(ctx->client)) {
+		dev_err(dev, "Failed to create I2C client\n");
+		i2c_put_adapter(ctx->adapter);
+		return PTR_ERR(ctx->client);
+	}
+
+	ctx->supplies[0].supply = "vddc";
+	ctx->supplies[1].supply = "vdd18";
+	ctx->supplies[2].supply = "vdd09";
+	ctx->supplies[3].supply = "vddio1";
+	ctx->supplies[4].supply = "vddio2";
+	ctx->supplies[5].supply = "vddio18";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret) {
+		dev_err_probe(dev, ret,
+			      "failed to get supply regulator\n");
+		goto remove_i2c;
+	}
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio)) {
+		ret = dev_err_probe(dev, PTR_ERR(ctx->reset_gpio), "failed to get reset GPIO\n");
+		goto remove_i2c;
+	}
+
+	pci_pwrctrl_init(&ctx->pwrctrl, dev);
+
+	port = TC956X_USP;
+	ret = tc956x_pwrctrl_parse_device_dt(ctx, pdev->dev.of_node, port);
+	if (ret) {
+		dev_err(dev, "failed to parse device tree properties: %d\n", ret);
+		goto remove_i2c;
+	}
+
+	/*
+	 * Downstream ports are always children of the upstream port.
+	 * The first node represents DSP1, the second node represents DSP2, and so on.
+	 */
+	for_each_child_of_node_scoped(pdev->dev.of_node, child) {
+		ret = tc956x_pwrctrl_parse_device_dt(ctx, child, port++);
+		if (ret)
+			break;
+		/* Embedded ethernet device are under DSP3 */
+		if (port == TC956X_DSP3)
+			for_each_child_of_node_scoped(child, child1) {
+				ret = tc956x_pwrctrl_parse_device_dt(ctx, child1, port++);
+				if (ret)
+					break;
+			}
+	}
+	if (ret) {
+		dev_err(dev, "failed to parse device tree properties: %d\n", ret);
+		goto remove_i2c;
+	}
+
+	if (!pcie_is_link_active(pci_dev) && bridge->ops->stop_link)
+		bridge->ops->stop_link(pci_dev->bus);
+
+	ret = tc956x_pwrctrl_bring_up(ctx);
+	if (ret)
+		goto remove_i2c;
+
+	if (!pcie_is_link_active(pci_dev) && bridge->ops->start_link) {
+		ret = bridge->ops->start_link(pci_dev->bus);
+		if (ret)
+			goto power_off;
+	}
+
+	ret = devm_pci_pwrctrl_device_set_ready(dev, &ctx->pwrctrl);
+	if (ret)
+		goto power_off;
+
+	platform_set_drvdata(pdev, ctx);
+
+	return 0;
+
+power_off:
+	tc956x_pwrctrl_power_off(ctx);
+remove_i2c:
+	i2c_unregister_device(ctx->client);
+	i2c_put_adapter(ctx->adapter);
+	return ret;
+}
+
+static void tc956x_pwrctrl_remove(struct platform_device *pdev)
+{
+	struct tc956x_pwrctrl_ctx *ctx = platform_get_drvdata(pdev);
+
+	tc956x_pwrctrl_power_off(ctx);
+	i2c_unregister_device(ctx->client);
+	i2c_put_adapter(ctx->adapter);
+}
+
+static const struct of_device_id tc956x_pwrctrl_of_match[] = {
+	{ .compatible = "pci1179,0623"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tc956x_pwrctrl_of_match);
+
+static struct platform_driver tc956x_pwrctrl_driver = {
+	.driver = {
+		.name = "pwrctrl-tc956x",
+		.of_match_table = tc956x_pwrctrl_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe = tc956x_pwrctrl_probe,
+	.remove = tc956x_pwrctrl_remove,
+};
+module_platform_driver(tc956x_pwrctrl_driver);
+
+MODULE_AUTHOR("Krishna chaitanya chundru <quic_krichai@quicinc.com>");
+MODULE_DESCRIPTION("TC956x power control driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


