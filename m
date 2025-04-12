Return-Path: <linux-pci+bounces-25708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2109A86A42
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 03:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985C18C66E0
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 01:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D926C5D8F0;
	Sat, 12 Apr 2025 01:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F2BGDaDK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDD158520
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744422680; cv=none; b=jb5yEfvslUlKymLplt8nEfuMyvLBDhKxeK4vCfQdCj1JSbelAbkEU3nJvbRWW72XJvOvO/EttrsM+yfWoEaT7EamaT5coeVRnG/1+MH146Z02d5QfpQ+I0SP9wkhW3PBXV8br9ywUMdJAbCCdXZWULz3asgygOCAs3EaU6c1hrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744422680; c=relaxed/simple;
	bh=AHnAnv0hg4Erke1AjlQieGWuP7RwmRdYJCbcq42AsTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQylnX0JIELGWxIur1Z4rbGMyAGSgaslBqXrJ0Wxu8Nd7rtTQbGWemAA/coThL/ePMLFuBlbc0L4wTj9PmUg03JQKV3iU/5F7gZ2GUIXLakxIHChqR3s56UephcXDpHyaPQ+XNSozZGGK6aozvIwMtYrU/pqD7jBomEUpu0N66o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F2BGDaDK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C1pCfw008429
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BDgdCUfJ30v/LQQdRBvV+1BqjJEa4v/FgnratUOXX1g=; b=F2BGDaDKy0lY7G/k
	d5wfiYPXtkyXE3jxJXc9/TZxSNIE59k0LMxnexxUgpi1/67zEPOtftTZf5grueNK
	9zkd+zM66D7Q4usdB95iCKQnkTLKKssBmrHDxfjxNR/Ew/Mf0vuYuIUxtLCriqwL
	LVbQkFSfhjBzZ8FyoqZRfSxdH4PpBC57Okuq1it+YDRlaoCItbyMhXvwH3A1dCTz
	mi5Ra5cNBQ6zUHIyjy2YbbUu9Y8ktNRuem2u6VLZq1QEY7R/Ept5mXw8qDFYreex
	DN3SkndLXbe9rKQv4dAYmjdH1jyNFhJbeCbayKjDZ5nQnyskVuTNZjyhzSOWV4xN
	E+A0lg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrv6sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:51:13 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-af2f03fcc95so2736903a12.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 18:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744422661; x=1745027461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDgdCUfJ30v/LQQdRBvV+1BqjJEa4v/FgnratUOXX1g=;
        b=r0W1qs3I2Dy6z9ZCDukh2HDsC5k05/Pib5rJOA3Z1A7tEkeTTxiTzcCJNYVTKTzxUS
         1vn0xg7O5OZpG1k2EM6xamm8kiSppfxeGk3rNMXG1ecXl4tehdJoJXi+q46aDgSdVnck
         7RK0kCTuJ5xFNyhJwD/z0U2IEQ0bDy4xj8cuZppfgwRq8SM663dtchPdlaJD1Z+A+4af
         jbPJg8sTqcFxYAHqALu4fHcqrm0BtMu8rn1Xjl87NFv4bv0N8HmcvH0iKwmFpEeb4hDC
         U9OGD1CyDRl5u5gUKtimV0nXYSnWJ2xZny/RSpIjLZ12yt3xsIsGpGgzG2kUL0e7YXvF
         Wt0g==
X-Forwarded-Encrypted: i=1; AJvYcCXv36/REkQMBOyC60qrc0qdJqJcKxE5bLLQdoqiJaI5bdvKT3hycing64rG24SqTINPU7IJMxZVo4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZaRJjXnclYAQDWVcUifMqihXJSMRXb2UwFJ/8El+EUnPohR5A
	28XJiBBZ5PpFy/N9LrWgOGAWAaP+lAG+nkfss+4nfauqAMLRLJcAvKtBP/MWYNTwJdlaAIn3hTy
	ea0CyK8/GQIRuDKw89HHOFjSnvQiJ7HTzbqdYmF3hTGSuQXLCF8PISe2nTGs=
X-Gm-Gg: ASbGncvgYg+OPDjisZk7r8W0J2OCV36rudmNpg3gC4BLM7yYv3J0pGkq+sSmS1zwTPd
	xeUpRNhDpJ8ISH1NXPk2b1pk94OSvpyHC2BFD1aQ+BIPN1VQpTggKttV5x3v2r+skqJvRk1ii0M
	l2ZbesNMcYmHeU3aX+24ablt2BpPIHz71YjCGS6oOAIAz0VeCBjN6BVp2XbQVQ6EqMkErYFuMt2
	pimeQNmOL66oAuCIQUAy+yhd2Qxo/pViQHtp//kgl1lfYrrD8Gm0SGx6x2NsfwLCfN+a8/DPlwb
	fE7mMaQ9Mr+BAOfiMA+bxdKMrvjj8xbUoIAoeB4BN3zcM0Q=
X-Received: by 2002:a05:6a20:2d13:b0:1f5:837b:186a with SMTP id adf61e73a8af0-2017978c69dmr7353188637.6.1744422660618;
        Fri, 11 Apr 2025 18:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECa6V68bxepSL/YtsQ8tnlpk2Tftkz3AapXMGylh8u6+B8rvO4K1XcU5WrFNfidMTks3kkLg==
X-Received: by 2002:a05:6a20:2d13:b0:1f5:837b:186a with SMTP id adf61e73a8af0-2017978c69dmr7353146637.6.1744422659928;
        Fri, 11 Apr 2025 18:50:59 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a3221832sm5516825a12.70.2025.04.11.18.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 18:50:59 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 12 Apr 2025 07:19:57 +0530
Subject: [PATCH v5 8/9] PCI: pwrctrl: Add power control driver for tc9563
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250412-qps615_v4_1-v5-8-5b6a06132fec@oss.qualcomm.com>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
In-Reply-To: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
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
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744422605; l=19950;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=AHnAnv0hg4Erke1AjlQieGWuP7RwmRdYJCbcq42AsTI=;
 b=HvmSq/JOmGQT2U6Vd6x+94qVD1OMa0a7l5+uNsqfWaAXHlz0yP65xolJIoBwh6aRhcvWzXQM3
 42/EFS610O8A83uvmRrVUsRFKcweH9otUt5EmzjLFx/7o8iCI0UT9qL
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: RmNZKlZr-q9VRh-WxE-6408_1J7wOUSs
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f9c711 cx=c_pps a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=KRRJuCyi5i-mN1d0-v8A:9 a=QEXdDO2ut3YA:10 a=RVmHIydaz68A:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: RmNZKlZr-q9VRh-WxE-6408_1J7wOUSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120012

TC9563 is a PCIe switch which has one upstream and three downstream
ports. To one of the downstream ports ethernet MAC is connected as endpoint
device. Other two downstream ports are supposed to connect to external
device. One Host can connect to TC9563 by upstream port. TC9563 switch
needs to be configured after powering on and before PCIe link was up.

The PCIe controller driver already enables link training at the host side
even before this driver probe happens, due to this when driver enables
power to the switch it participates in the link training and PCIe link
may come up before configuring the switch through i2c. Once the link is
up the configuration done through i2c will not have any affect.To prevent
the host from participating in link training, disable link training on the
host side to ensure the link does not come up before the switch is
configured via I2C.

Based up on dt property and type of the port, tc9563 is configured
through i2c.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctrl/Kconfig              |  10 +
 drivers/pci/pwrctrl/Makefile             |   2 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 628 +++++++++++++++++++++++++++++++
 3 files changed, 640 insertions(+)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index 990cab67d41332a8508d4150825c621eb86322c5..d14ef2b0ffd84f9a8c4266fdd57a27f7f3611ca4 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -21,3 +21,13 @@ config PCI_PWRCTL_SLOT
 	  This is a generic driver that controls the power state of different
 	  PCI slots. The voltage regulators powering the rails of the PCI slots
 	  are expected to be defined in the devicetree node of the PCI bridge.
+
+config PCI_PWRCTRL_TC9563
+	tristate "PCI Power Control driver for TC9563 PCIe switch"
+	select PCI_PWRCTL
+	help
+	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
+	  switch.
+
+	  This driver enables power and configures the TC9563 PCIe switch
+	  through i2c.
diff --git a/drivers/pci/pwrctrl/Makefile b/drivers/pci/pwrctrl/Makefile
index ddfb12c5aadf684cf675585b1078ecb7c24649cc..5d0163c75878d5bf702bc6c892fa31bfea5a95e3 100644
--- a/drivers/pci/pwrctrl/Makefile
+++ b/drivers/pci/pwrctrl/Makefile
@@ -7,3 +7,5 @@ obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctrl-pwrseq.o
 
 obj-$(CONFIG_PCI_PWRCTL_SLOT)		+= pci-pwrctl-slot.o
 pci-pwrctl-slot-y			:= slot.o
+
+obj-$(CONFIG_PCI_PWRCTRL_TC9563)	+= pci-pwrctrl-tc9563.o
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
new file mode 100644
index 0000000000000000000000000000000000000000..547c764a6f405a676216309ef6ebcaffbbc3f1d6
--- /dev/null
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -0,0 +1,628 @@
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
+#define TC9563_GPIO_CONFIG		0x801208
+#define TC9563_RESET_GPIO		0x801210
+
+#define TC9563_BUS_CONTROL		0x801014
+
+#define TC9563_PORT_L0S_DELAY		0x82496c
+#define TC9563_PORT_L1_DELAY		0x824970
+
+#define TC9563_EMBEDDED_ETH_DELAY	0x8200d8
+#define TC9563_ETH_L1_DELAY_MASK	GENMASK(27, 18)
+#define TC9563_ETH_L1_DELAY_VALUE(x)	FIELD_PREP(TC9563_ETH_L1_DELAY_MASK, x)
+#define TC9563_ETH_L0S_DELAY_MASK	GENMASK(17, 13)
+#define TC9563_ETH_L0S_DELAY_VALUE(x)	FIELD_PREP(TC9563_ETH_L0S_DELAY_MASK, x)
+
+#define TC9563_NFTS_2_5_GT		0x824978
+#define TC9563_NFTS_5_GT		0x82497c
+
+#define TC9563_PORT_LANE_ACCESS_ENABLE	0x828000
+
+#define TC9563_PHY_RATE_CHANGE_OVERRIDE	0x828040
+#define TC9563_PHY_RATE_CHANGE		0x828050
+
+#define TC9563_TX_MARGIN		0x828234
+
+#define TC9563_DFE_ENABLE		0x828a04
+#define TC9563_DFE_EQ0_MODE		0x828a08
+#define TC9563_DFE_EQ1_MODE		0x828a0c
+#define TC9563_DFE_EQ2_MODE		0x828a14
+#define TC9563_DFE_PD_MASK		0x828254
+
+#define TC9563_PORT_SELECT		0x82c02c
+#define TC9563_PORT_ACCESS_ENABLE	0x82c030
+
+#define TC9563_POWER_CONTROL		0x82b09c
+#define TC9563_POWER_CONTROL_OVREN	0x82b2c8
+
+#define TC9563_GPIO_MASK		0xfffffff3
+
+#define TC9563_TX_MARGIN_MIN_VAL	400000
+
+struct tc9563_pwrctrl_reg_setting {
+	unsigned int offset;
+	unsigned int val;
+};
+
+enum tc9563_pwrctrl_ports {
+	TC9563_USP,
+	TC9563_DSP1,
+	TC9563_DSP2,
+	TC9563_DSP3,
+	TC9563_ETHERNET,
+	TC9563_MAX
+};
+
+struct tc9563_pwrctrl_cfg {
+	u32 l0s_delay;
+	u32 l1_delay;
+	u32 tx_amp;
+	u8 nfts[2]; /* GEN1 & GEN2 */
+	bool disable_dfe;
+	bool disable_port;
+};
+
+#define TC9563_PWRCTL_MAX_SUPPLY	6
+
+struct tc9563_pwrctrl_ctx {
+	struct regulator_bulk_data supplies[TC9563_PWRCTL_MAX_SUPPLY];
+	struct tc9563_pwrctrl_cfg cfg[TC9563_MAX];
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
+static const struct tc9563_pwrctrl_reg_setting common_pwroff_seq[] = {
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
+static const struct tc9563_pwrctrl_reg_setting dsp1_pwroff_seq[] = {
+	{TC9563_PORT_ACCESS_ENABLE, 0x2},
+	{TC9563_PORT_LANE_ACCESS_ENABLE, 0x3},
+	{TC9563_POWER_CONTROL, 0x014f4804},
+	{TC9563_POWER_CONTROL_OVREN, 0x1},
+	{TC9563_PORT_ACCESS_ENABLE, 0x4},
+};
+
+static const struct tc9563_pwrctrl_reg_setting dsp2_pwroff_seq[] = {
+	{TC9563_PORT_ACCESS_ENABLE, 0x8},
+	{TC9563_PORT_LANE_ACCESS_ENABLE, 0x1},
+	{TC9563_POWER_CONTROL, 0x014f4804},
+	{TC9563_POWER_CONTROL_OVREN, 0x1},
+	{TC9563_PORT_ACCESS_ENABLE, 0x8},
+};
+
+/*
+ * Since all transfers are initiated by the probe, no locks are necessary,
+ * as there are no concurrent calls.
+ */
+static int tc9563_pwrctrl_i2c_write(struct i2c_client *client,
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
+static int tc9563_pwrctrl_i2c_read(struct i2c_client *client,
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
+static int tc9563_pwrctrl_i2c_bulk_write(struct i2c_client *client,
+					 const struct tc9563_pwrctrl_reg_setting *seq, int len)
+{
+	int ret, i;
+
+	for (i = 0; i < len; i++) {
+		ret = tc9563_pwrctrl_i2c_write(client, seq[i].offset, seq[i].val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int tc9563_pwrctrl_disable_port(struct tc9563_pwrctrl_ctx *ctx,
+				       enum tc9563_pwrctrl_ports port)
+{
+	struct tc9563_pwrctrl_cfg *cfg  = &ctx->cfg[port];
+	const struct tc9563_pwrctrl_reg_setting *seq;
+	int ret, len;
+
+	if (!cfg->disable_port)
+		return 0;
+
+	if (port == TC9563_DSP1) {
+		seq = dsp1_pwroff_seq;
+		len = ARRAY_SIZE(dsp1_pwroff_seq);
+	} else {
+		seq = dsp2_pwroff_seq;
+		len = ARRAY_SIZE(dsp2_pwroff_seq);
+	}
+
+	ret = tc9563_pwrctrl_i2c_bulk_write(ctx->client, seq, len);
+	if (ret)
+		return ret;
+
+	return tc9563_pwrctrl_i2c_bulk_write(ctx->client,
+					    common_pwroff_seq, ARRAY_SIZE(common_pwroff_seq));
+}
+
+static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct tc9563_pwrctrl_ctx *ctx,
+						 enum tc9563_pwrctrl_ports port, bool is_l1, u32 ns)
+{
+	u32 rd_val, units;
+	int ret;
+
+	if (ns < 256)
+		return 0;
+
+	/* convert to units of 256ns */
+	units = ns / 256;
+
+	if (port == TC9563_ETHERNET) {
+		ret = tc9563_pwrctrl_i2c_read(ctx->client, TC9563_EMBEDDED_ETH_DELAY, &rd_val);
+		if (ret)
+			return ret;
+
+		if (is_l1)
+			rd_val = u32_replace_bits(rd_val, units, TC9563_ETH_L1_DELAY_MASK);
+		else
+			rd_val = u32_replace_bits(rd_val, units, TC9563_ETH_L0S_DELAY_MASK);
+
+		return tc9563_pwrctrl_i2c_write(ctx->client, TC9563_EMBEDDED_ETH_DELAY, rd_val);
+	}
+
+	ret = tc9563_pwrctrl_i2c_write(ctx->client, TC9563_PORT_SELECT, BIT(port));
+	if (ret)
+		return ret;
+
+	return tc9563_pwrctrl_i2c_write(ctx->client,
+				       is_l1 ? TC9563_PORT_L1_DELAY : TC9563_PORT_L0S_DELAY, units);
+}
+
+static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl_ctx *ctx,
+					   enum tc9563_pwrctrl_ports port, u32 amp)
+{
+	int port_access;
+
+	if (amp < TC9563_TX_MARGIN_MIN_VAL)
+		return 0;
+
+	/* txmargin = (Amp(uV) - 400000) / 3125 */
+	amp = (amp - TC9563_TX_MARGIN_MIN_VAL) / 3125;
+
+	switch (port) {
+	case TC9563_USP:
+		port_access = 0x1;
+		break;
+	case TC9563_DSP1:
+		port_access = 0x2;
+		break;
+	case TC9563_DSP2:
+		port_access = 0x8;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	struct tc9563_pwrctrl_reg_setting tx_amp_seq[] = {
+		{TC9563_PORT_ACCESS_ENABLE, port_access},
+		{TC9563_PORT_LANE_ACCESS_ENABLE, 0x3},
+		{TC9563_TX_MARGIN, amp},
+	};
+
+	return tc9563_pwrctrl_i2c_bulk_write(ctx->client, tx_amp_seq, ARRAY_SIZE(tx_amp_seq));
+}
+
+static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl_ctx *ctx,
+				      enum tc9563_pwrctrl_ports port)
+{
+	struct tc9563_pwrctrl_cfg *cfg  = &ctx->cfg[port];
+	int port_access, lane_access = 0x3;
+	u32 phy_rate = 0x21;
+
+	if (!cfg->disable_dfe)
+		return 0;
+
+	switch (port) {
+	case TC9563_USP:
+		phy_rate = 0x1;
+		port_access = 0x1;
+		break;
+	case TC9563_DSP1:
+		port_access = 0x2;
+		break;
+	case TC9563_DSP2:
+		port_access = 0x8;
+		lane_access = 0x1;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	struct tc9563_pwrctrl_reg_setting disable_dfe_seq[] = {
+		{TC9563_PORT_ACCESS_ENABLE, port_access},
+		{TC9563_PORT_LANE_ACCESS_ENABLE, lane_access},
+		{TC9563_DFE_ENABLE, 0x0},
+		{TC9563_DFE_EQ0_MODE, 0x411},
+		{TC9563_DFE_EQ1_MODE, 0x11},
+		{TC9563_DFE_EQ2_MODE, 0x11},
+		{TC9563_DFE_PD_MASK, 0x7},
+		{TC9563_PHY_RATE_CHANGE_OVERRIDE, 0x10},
+		{TC9563_PHY_RATE_CHANGE, phy_rate},
+		{TC9563_PHY_RATE_CHANGE, 0x0},
+		{TC9563_PHY_RATE_CHANGE_OVERRIDE, 0x0},
+	};
+
+	return tc9563_pwrctrl_i2c_bulk_write(ctx->client,
+					    disable_dfe_seq, ARRAY_SIZE(disable_dfe_seq));
+}
+
+static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl_ctx *ctx,
+				   enum tc9563_pwrctrl_ports port, u8 *nfts)
+{
+	struct tc9563_pwrctrl_reg_setting nfts_seq[] = {
+		{TC9563_NFTS_2_5_GT, nfts[0]},
+		{TC9563_NFTS_5_GT, nfts[1]},
+	};
+	int ret;
+
+	if (!nfts[0])
+		return 0;
+
+	ret =  tc9563_pwrctrl_i2c_write(ctx->client, TC9563_PORT_SELECT, BIT(port));
+	if (ret)
+		return ret;
+
+	return tc9563_pwrctrl_i2c_bulk_write(ctx->client, nfts_seq, ARRAY_SIZE(nfts_seq));
+}
+
+static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl_ctx *ctx, bool deassert)
+{
+	int ret, val;
+
+	ret = tc9563_pwrctrl_i2c_write(ctx->client, TC9563_GPIO_CONFIG, TC9563_GPIO_MASK);
+	if (ret)
+		return ret;
+
+	val = deassert ? 0xc : 0;
+
+	return tc9563_pwrctrl_i2c_write(ctx->client, TC9563_RESET_GPIO, val);
+}
+
+static int tc9563_pwrctrl_parse_device_dt(struct tc9563_pwrctrl_ctx *ctx, struct device_node *node,
+					  enum tc9563_pwrctrl_ports port)
+{
+	struct tc9563_pwrctrl_cfg *cfg;
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
+static void tc9563_pwrctrl_power_off(struct tc9563_pwrctrl_ctx *ctx)
+{
+	gpiod_set_value(ctx->reset_gpio, 1);
+
+	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+}
+
+static int tc9563_pwrctrl_bring_up(struct tc9563_pwrctrl_ctx *ctx)
+{
+	struct tc9563_pwrctrl_cfg *cfg;
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
+	ret = tc9563_pwrctrl_assert_deassert_reset(ctx, false);
+	if (ret)
+		goto power_off;
+
+	for (i = 0; i < TC9563_MAX; i++) {
+		cfg = &ctx->cfg[i];
+		ret = tc9563_pwrctrl_disable_port(ctx, i);
+		if (ret) {
+			dev_err(ctx->pwrctrl.dev, "Disabling port failed\n");
+			goto power_off;
+		}
+
+		ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(ctx, i, false, cfg->l0s_delay);
+		if (ret) {
+			dev_err(ctx->pwrctrl.dev, "Setting L0s entry delay failed\n");
+			goto power_off;
+		}
+
+		ret = tc9563_pwrctrl_set_l0s_l1_entry_delay(ctx, i, true, cfg->l1_delay);
+		if (ret) {
+			dev_err(ctx->pwrctrl.dev, "Setting L1 entry delay failed\n");
+			goto power_off;
+		}
+
+		ret = tc9563_pwrctrl_set_tx_amplitude(ctx, i, cfg->tx_amp);
+		if (ret) {
+			dev_err(ctx->pwrctrl.dev, "Setting Tx amplitube failed\n");
+			goto power_off;
+		}
+
+		ret = tc9563_pwrctrl_set_nfts(ctx, i, cfg->nfts);
+		if (ret) {
+			dev_err(ctx->pwrctrl.dev, "Setting nfts failed\n");
+			goto power_off;
+		}
+
+		ret = tc9563_pwrctrl_disable_dfe(ctx, i);
+		if (ret) {
+			dev_err(ctx->pwrctrl.dev, "Disabling DFE failed\n");
+			goto power_off;
+		}
+	}
+
+	ret = tc9563_pwrctrl_assert_deassert_reset(ctx, true);
+	if (!ret)
+		return 0;
+
+power_off:
+	tc9563_pwrctrl_power_off(ctx);
+	return ret;
+}
+
+static int tc9563_pwrctrl_probe(struct platform_device *pdev)
+{
+	struct pci_host_bridge *bridge = to_pci_host_bridge(pdev->dev.parent);
+	struct pci_dev *pci_dev = to_pci_dev(pdev->dev.parent);
+	struct pci_bus *bus = bridge->bus;
+	struct device *dev = &pdev->dev;
+	enum tc9563_pwrctrl_ports port;
+	struct tc9563_pwrctrl_ctx *ctx;
+	struct device_node *i2c_node;
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
+	i2c_node = of_parse_phandle(dev->of_node, "i2c-parent", 0);
+	ctx->adapter = of_find_i2c_adapter_by_node(i2c_node);
+	of_node_put(i2c_node);
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
+	port = TC9563_USP;
+	ret = tc9563_pwrctrl_parse_device_dt(ctx, pdev->dev.of_node, port);
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
+		ret = tc9563_pwrctrl_parse_device_dt(ctx, child, port++);
+		if (ret)
+			break;
+		/* Embedded ethernet device are under DSP3 */
+		if (port == TC9563_DSP3)
+			for_each_child_of_node_scoped(child, child1) {
+				ret = tc9563_pwrctrl_parse_device_dt(ctx, child1, port++);
+				if (ret)
+					break;
+			}
+	}
+	if (ret) {
+		dev_err(dev, "failed to parse device tree properties: %d\n", ret);
+		goto remove_i2c;
+	}
+
+	if (!pcie_link_is_active(pci_dev) && bridge->ops->stop_link)
+		bridge->ops->stop_link(bus);
+
+	ret = tc9563_pwrctrl_bring_up(ctx);
+	if (ret)
+		goto remove_i2c;
+
+	if (!pcie_link_is_active(pci_dev) && bridge->ops->start_link) {
+		ret = bridge->ops->start_link(bus);
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
+	tc9563_pwrctrl_power_off(ctx);
+remove_i2c:
+	i2c_unregister_device(ctx->client);
+	i2c_put_adapter(ctx->adapter);
+	return ret;
+}
+
+static void tc9563_pwrctrl_remove(struct platform_device *pdev)
+{
+	struct tc9563_pwrctrl_ctx *ctx = platform_get_drvdata(pdev);
+
+	tc9563_pwrctrl_power_off(ctx);
+	i2c_unregister_device(ctx->client);
+	i2c_put_adapter(ctx->adapter);
+}
+
+static const struct of_device_id tc9563_pwrctrl_of_match[] = {
+	{ .compatible = "pci1179,0623"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tc9563_pwrctrl_of_match);
+
+static struct platform_driver tc9563_pwrctrl_driver = {
+	.driver = {
+		.name = "pwrctrl-tc9563",
+		.of_match_table = tc9563_pwrctrl_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe = tc9563_pwrctrl_probe,
+	.remove = tc9563_pwrctrl_remove,
+};
+module_platform_driver(tc9563_pwrctrl_driver);
+
+MODULE_AUTHOR("Krishna chaitanya chundru <quic_krichai@quicinc.com>");
+MODULE_DESCRIPTION("TC956x power control driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


