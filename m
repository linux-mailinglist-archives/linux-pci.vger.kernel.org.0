Return-Path: <linux-pci+bounces-35002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 618E8B39CB9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E131C82A80
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE16730FF37;
	Thu, 28 Aug 2025 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iyqNuXba"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1850331AF1D
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383065; cv=none; b=knWM9t4R4NVy1wQzIC7pEdSL5owIN9QyuoS2WJjhRaPNCYOuPyIdaSqnmbT/5bQy3z03fy8f7K3+oguIMVrseLgtDqXzKTZghsmzZiuF1KxC/Aar1eBPOsNxnZUvyeISIEPasZMCDeefS9X3IhAllEU0LmsX+OPyUppDLS+D56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383065; c=relaxed/simple;
	bh=kdTgcSdIoNBGkGoieABnNAZ5pXgR59yEOR56cAPHpLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sojac2z9S94tCLzC0J+m8LR4AhJ8vb7cwjj4z8iaDsCRli4Sle10HAY/3ShMDFhe6c67BL6LZtSoOp2dv1c82PtZIK4wTF0R5d1eW8h3yoriEydJsJlP10j8ipE19hGqI55+Qt1qxxqDc0Qp4Vuo93MRuOXN8GdJ6PpQUGfIqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iyqNuXba; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SAui6u021327
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	23tMkQ+vPqgK8R2KKEysBsD8dDFMuSOYxbj+HW3Ru2c=; b=iyqNuXbaoMf5Eg+8
	KH2hlrnTnY2B9eJ/UYXIt7UWPCCLzj1jr4JrFPf3IdE3zBZxM4iTNy2qirP/KMGc
	ZACCE1rBys9fP2qElf7Kby0mQ9v+PcS+9mOATNO5wv1aGHSTr4ScYZyg6p8VjKlr
	5y3/eoOJDgCXX5MEx1YBHFFvCu0laggESkTevh6w7mVsJJ490ct4SPt/X4DODFQD
	rUmACJn5gaSMuH4i/oKx4GJds8eMLHGimur5sCXs8BFPd3CpangDkk5E1OyuKoCB
	IYxIc0QKzNJb4sWRO8xIDnKrr7TTi9TyTDCNotaQXFRn61mF74kt4zClRfrpfF1Z
	CMdpQA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we7ums-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:11:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3276f51798dso2300614a91.1
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 05:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383059; x=1756987859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23tMkQ+vPqgK8R2KKEysBsD8dDFMuSOYxbj+HW3Ru2c=;
        b=WQf9xT+cYWx4/C30M59TOfwCDURWTOhv4OtmbLwO9Hlja1Be+W04Ea2M4lCro3oJfv
         OcSP4ViOAnTj/uuJHYsOOd9aN/X4FjkC25bG5XePsQQZAQJD6MB0+liZqvEYAQjvpnSm
         4j9CVTRl/7u6GfTscDBUO3dfBq42qLnoc/hnv13umd223co/CEzqOeVhfdHKaQrCRAua
         9JQzpsjT5DHqh5c8ffYaiKrgcN1F0r7+jRBHSshyuad0RtjWzct/U8ZK/FbQ99Zl/xSh
         Telc1E1DWZ1RIdUMZtt5tqnocr1DDo0FANFokoGjxl2SgOONM8MjwVLYzjx6lFF4V3vl
         D3gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoMGp60XrXpWloJUxiceuw1LPpFesZeN6MEwUMatBcG/+WvIQWcDTuh4KqGMDTBTjI6tddo1quizQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/W87O6ijzRUAnn3BQvzy6k/m6NmPStif9jhmqsiNgEMKnr8V
	7P5SXGJxy/tHqQsMmswotxp8p76rmhSRRtfEWjz2djcjF+2TfoRknm1ufFMS4tYQdb5cHD6jOT3
	d5iTPFRBGR7FAv3n69xPJj6K8r56ASuHG1iFYL17jQKEImRNG1tyYmOoH219sKqs=
X-Gm-Gg: ASbGncui9lF7+kI/VmnyrwXKl+7kCtbEPLYNSbKn1SwmX0Bb+/x0KZjT7jpU6qtAeKU
	GgkuBAQVJcb5jVdDBHXY25FqSiklfCKyAf7j+ATojFd6pl71igYeDMUUlXBVaJ0z6pj1ifZKqOG
	2hy12eYB5eT9LdL/vLFqC3ehTLzsr6qPZsX/dJJQzCeTJhM4x8TZsoP8Zv+Y14lzZ3LeXjA+RaP
	VDEJIyojYt7ijqw87wOODx3nH2dCP4PNkAC3uIvpGFiAyBLVFe2AdWulKntgaRoyh+2NxL/I9oQ
	OKObram5vVB7rlQ7rUh18P5Xk++yTdRZ8+KNCl2Djocg8J+aMm0LO3Uc9PPI1VafFOmrj8Kq8pk
	=
X-Received: by 2002:a17:90b:35c2:b0:312:dbcd:b94f with SMTP id 98e67ed59e1d1-3275085e802mr10871179a91.11.1756383058826;
        Thu, 28 Aug 2025 05:10:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLaZtAJvq97aI80ACYUccRo/rWadcnD3cbkkBRtkfGsoA6sn9TxPO+8AZNo+Kd7Hihhotzgw==
X-Received: by 2002:a17:90b:35c2:b0:312:dbcd:b94f with SMTP id 98e67ed59e1d1-3275085e802mr10871106a91.11.1756383058029;
        Thu, 28 Aug 2025 05:10:58 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm4019070a91.0.2025.08.28.05.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:10:57 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 17:39:05 +0530
Subject: [PATCH v6 8/9] PCI: pwrctrl: Add power control driver for tc9563
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-qps615_v4_1-v6-8-985f90a7dd03@oss.qualcomm.com>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
In-Reply-To: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756382994; l=20344;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kdTgcSdIoNBGkGoieABnNAZ5pXgR59yEOR56cAPHpLk=;
 b=/HGpc+tCZvcjenVfJK3zS6G6/Ypk7e1zQmivygbWdXsGZGaUY6uv0z98cIuEBVLj0e0Wb9+kN
 Ag8w3gWgPSuDKddazt8ELoXvHMD0Chci5c8DDBGRj92+ihvi/6I8YCp
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: h9P7PhRz9eJ0L2zLtkA0VKURsLHvchrw
X-Proofpoint-ORIG-GUID: h9P7PhRz9eJ0L2zLtkA0VKURsLHvchrw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX47AAZiI5KBbV
 I1nrP0sT2ogLziPOMDF29rG5vpaUCHRnpxZKVcpGd3/6Mwio9vhCCn5DEGBh76qD07m2Wfhe9WD
 9D+vha6Pn1N4g6H+jJLUktHlf9Kr859IbeGi1ABZzUWrQKxqNXqb0gjLMx9R0+jDnkuvK9lmKwn
 SDbVx7cBmo13GI7HyRKZ7PPdMGsBtEj74RMLJ0lCLo0/yrXEQRve6gWkc9zgerCdRy4h2TyQ5u8
 RTlhVqPoybvJYFpFnjXzRb/KmkOrn+UmLqf1g/Re3dtyEYxHmulrmzlDC6wPNNFaBLD4U7TqM2P
 t18UOmNR2MOU3KcYZgpoJ0VpNd7Tk7H5M3rql84Vco8QV7NfghaZ6izUgU3DGvKCSGLH83eTYjC
 FA44xIbP
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68b04755 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=KRRJuCyi5i-mN1d0-v8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

TC9563 is a PCIe switch which has one upstream and three downstream
ports. To one of the downstream ports integrated ethernet MAC is connected
as endpoint device. Other two downstream ports are supposed to connect to
external device. One Host can connect to TC9563 by upstream port. TC9563
switch needs to be configured after powering on and before the PCIe link
was up.

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
 drivers/pci/pwrctrl/Kconfig              |  13 +
 drivers/pci/pwrctrl/Makefile             |   2 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 637 +++++++++++++++++++++++++++++++
 3 files changed, 652 insertions(+)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index 6956c18548114ce12247b560f1ef159eb7e90b10..32e3c7275529349b854412a109e73eee731b9565 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -22,6 +22,19 @@ config PCI_PWRCTRL_SLOT
 	  PCI slots. The voltage regulators powering the rails of the PCI slots
 	  are expected to be defined in the devicetree node of the PCI bridge.
 
+config PCI_PWRCTRL_TC9563
+	tristate "PCI Power Control driver for TC9563 PCIe switch"
+	select PCI_PWRCTRL
+	help
+	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
+	  switch.
+
+	  This driver enables power and configures the TC9563 PCIe switch
+	  through i2c.TC9563 is a PCIe switch which has one upstream and three
+	  downstream ports. To one of the downstream ports integrated ethernet
+	  MAC is connected as endpoint device. Other two downstream ports are
+	  supposed to connect to external device.
+
 # deprecated
 config HAVE_PWRCTL
 	bool
diff --git a/drivers/pci/pwrctrl/Makefile b/drivers/pci/pwrctrl/Makefile
index a4e5808d7850ceb0ca272731e5539e1dfc564e43..13b02282106c2bdbf884f487534f7466047c7fcf 100644
--- a/drivers/pci/pwrctrl/Makefile
+++ b/drivers/pci/pwrctrl/Makefile
@@ -7,3 +7,5 @@ obj-$(CONFIG_PCI_PWRCTRL_PWRSEQ)	+= pci-pwrctrl-pwrseq.o
 
 obj-$(CONFIG_PCI_PWRCTRL_SLOT)		+= pci-pwrctrl-slot.o
 pci-pwrctrl-slot-y			:= slot.o
+
+obj-$(CONFIG_PCI_PWRCTRL_TC9563)	+= pci-pwrctrl-tc9563.o
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
new file mode 100644
index 0000000000000000000000000000000000000000..63e719fa3589a6312c7a526db84cf3573d0ac8a0
--- /dev/null
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -0,0 +1,637 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
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
+static const char *const tc9563_supply_names[TC9563_PWRCTL_MAX_SUPPLY] = {
+	"vddc",
+	"vdd18",
+	"vdd09",
+	"vddio1",
+	"vddio2",
+	"vddio18",
+};
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
+	ret = of_property_read_u8_array(node, "n-fts", cfg->nfts, 2);
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
+	 /*
+	  * From TC9563 PORSYS rev 0.2, figure 1.1 POR boot sequence
+	  * wait for 10ms for the internal osc frequency to stabilize.
+	  */
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
+			dev_err(ctx->pwrctrl.dev, "Setting Tx amplitude failed\n");
+			goto power_off;
+		}
+
+		ret = tc9563_pwrctrl_set_nfts(ctx, i, cfg->nfts);
+		if (ret) {
+			dev_err(ctx->pwrctrl.dev, "Setting N_FTS failed\n");
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
+	for (int i = 0; i < TC9563_PWRCTL_MAX_SUPPLY; i++)
+		ctx->supplies[i].supply = tc9563_supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, TC9563_PWRCTL_MAX_SUPPLY, ctx->supplies);
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


