Return-Path: <linux-pci+bounces-43778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE228CE5351
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 18:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 737943051175
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D489E223708;
	Sun, 28 Dec 2025 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ITJDfl7B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E49hBQEa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CFD2236E0
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766941312; cv=none; b=F1eui3ng41Cw5C7EfAGwJBqFlNdjFITJDXM7I9iaGya5KH6ZJCEkeVUx17LL1FFRfn44gTA40p90fUpk05vxiFCv8hZVPg97Weh+EOJS41l2eoDWD1Rz/kRG3fQP/z/Mw/PN+c5GFtMiJymE5Y9ta14gpJr7R3Gcdhy9vAmCS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766941312; c=relaxed/simple;
	bh=YDOJ/NTVDZQEW6th5GrtjXuNNG90jTG+ctIlTugC3ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pQPvAXqvKb3UbMScWKP5BZIBqYzpB60hGRKSSWyR8JRqPqN6gBBy09fLw13Jhhj1s5iKm8kntErCWKPIItmdrfkud/DSnMwiNCDRc0pxEYkEdkpBWe/MbDol9o4mOI/QCQMuFLs2Pb85MeTVQLvcELqis3f99PvmppyAHwAtFwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ITJDfl7B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E49hBQEa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSGTBBP2539579
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 17:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5O2+Zc711Tjme8do/WmAI11+QPQ8k1FetdQlFcUYAJw=; b=ITJDfl7BIl9vgjIQ
	cugNJpKyGw2vLhVIMFstwOd3m58ozcyr5BFbX8rJAhIMYpb0WvD36Mg+K+uVmq8O
	Dt3hEhgA+mjo6BuMhRVULlQe/M/5xtihIN0tcpXXhhwx4L1n+WnYt7xLOzfgGmdF
	cW4YBrQtR1cuS6FdEGjBUyNZKN1i3Uv4Fh1dJ1ZM0tm8FVU3YR1Vs4jZi7Odt7aH
	jH9mMj4EJelcKyAgPKote05VJ4J/vtWvRiVHLBLovRHofc4wlU3zwy2AGODS5Z/A
	5hlt4JJpOo1C0jZh2aTbrsu2TSIf9oASs1lehHuvOY9b7rzZgm6sr4Qru9LtMdXW
	UZNBWQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba4tntnjw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 17:01:49 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b9c91b814cso19177946b3a.2
        for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 09:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766941308; x=1767546108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5O2+Zc711Tjme8do/WmAI11+QPQ8k1FetdQlFcUYAJw=;
        b=E49hBQEajr5hTK/6Wwdub2SHe+oaXZe1cynZag8rg/rbneUeWS+cM7CDCY0yDwgAbu
         4SV4VqxIyHaXuAxR5HUBeMfKCDD6ZScQnVO9OvkCDR9+PZajVWWSxpGKcmyXcKbJeGzl
         nyI54zwqXJvxQk0iRGcGMwjVDprJdePhLOe16nXTlN2KfMpepXhkROTwLNdIaIQQIOfh
         BqTrtQbm0t0OkLsm8FoKqqZb7dVogS6D2JMpiHpfFVB7X2wmo/zRGleb9WDFlgQyqi8V
         Sgra8sOxriUB5q/HAKsW4XDZcsPWMesO0goCGOxobeH1S1sLn5yHWLWxXmATo4ztLti5
         Ruvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766941308; x=1767546108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5O2+Zc711Tjme8do/WmAI11+QPQ8k1FetdQlFcUYAJw=;
        b=pMn2g0XakTH2cDCibH7zsxrjhkl6WWB4dK2Kkz+g6zWwqr/WiLXkvdbkhl49i/lqrc
         xdt98UucQvys722tsvip5jCSxVI3Pbke16u7qnnPmdaPKLiARjJVF/ZKfmodBPwoyEv7
         BU/OFZtnqViFAowQ/64xtUJxtJCAxM40LO52J+iMrOCTasbV3gYC5O0GQLBO6c0O9q5D
         NuZFf2Aq9Dc2MMFl/2YTxLhjYSaVHmAZUefyvCuWl8LJBgxOzGcMRBNxt5soHfVumn60
         RBeJz5FWCdpyuFTSrG1EnRG7iCy/bQf9vk20u36aqb0A7REMR8JqQQm1cMwaEnTGAeRP
         HZSA==
X-Forwarded-Encrypted: i=1; AJvYcCVIwMrcq3uYydVFahhap0zr0w5rGJOEJiTxHx1k4EhYfJi5z7J4GMko7SruzpW79cRz8GuPJ08rjEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSTZ1qsGG+UpuirNtI+QZh5cRDX/awWKmiRC760e4JwMOx74tG
	+xuItMn85Rl3U69HVky3u4vMCBq6oTJkWeY856Lc3332scSCj0hyZ/lm5yfMPf6Tgbq2lxihBGM
	V7U2il/zOF8xaG967RIh4yKLzv4+q5G9OPhb/EOWvueQyYAo69UXCMHy+JRKWeDE=
X-Gm-Gg: AY/fxX6JQDPgfOP9wzTSYlckFsjXjJTM7tU5cB6Bfp8NrspvdjyJSzc+VNeKsNNu/KV
	oP72lDnhN68KvqJEKr8cNAcuhD5/N4ml0/bx17Qz2z6FabCD9O8ptzLz7bTl0xgY0N9tLAIheM8
	DBaYm1d8KykGFi+XdCPUNJnTozyAyb25ea0pGDnwcenJtq/LOE6e1DUROi+Pk/Ypi4r2aVnUD/A
	Y/0jJQEBd+L5wUxFvxtLZUzffKNU8LQAkElRTHfrNL1/9HHf9fr0n36qx4yAymc0zfZKRvPSLg9
	7o3YHdMxdpafVCmI29OtvlUVhVFRl7xPzkjGs+wo+H1cN64IhXfBU7Svwn/b9XDaqtNYRC510Kl
	3v1utPEB+v1c5Ui/JZ2ItKc/ygk+dCUoS9vw=
X-Received: by 2002:aa7:8703:0:b0:800:902d:9fdb with SMTP id d2e1a72fcca58-800902dc39bmr17814005b3a.5.1766941307909;
        Sun, 28 Dec 2025 09:01:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrFBAwpRDeK5SpGMu/WURMQFkmH/rBO1N5gl3+Rtim67wxOerSuh7rYUNCU/Yz175dCg6eEQ==
X-Received: by 2002:aa7:8703:0:b0:800:902d:9fdb with SMTP id d2e1a72fcca58-800902dc39bmr17813995b3a.5.1766941307368;
        Sun, 28 Dec 2025 09:01:47 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:90aa:5191:e297:e185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7ae354easm27053925b3a.16.2025.12.28.09.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:01:46 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:31:05 +0530
Subject: [PATCH v4 5/5] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-pci-m2-v4-5-5684868b0d5f@oss.qualcomm.com>
References: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
In-Reply-To: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7625;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=YDOJ/NTVDZQEW6th5GrtjXuNNG90jTG+ctIlTugC3ps=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpUWJZMkE1gKu3pRx1PbBdCNpryzEyM3Tv+/xho
 V/ATsJ7h3OJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVFiWQAKCRBVnxHm/pHO
 9SJ7B/9hLXgm1uzuIo0dlmCZ0CFsbqpnwhntFVWC6f0XPx2ASivaQXJ7V5E9xZgGZ2BwY2JN72u
 YRvsU5yg7DxHEJ4rvBIlNf3O+kxKFq9Sw502o+nPYSsDHSHUjYOJN27eM9EskkFhlDaUWCOXANw
 HOHe1DEH5x9/Db4YKBmckyoYRXePABE72c2QV+R5M7VoJ7PTr3C4yYdm7I3htrLalC9QODUtMtF
 lYSQ8wHzTPm7DmFT6oDlwKrof2XDfTQP0bWPPavsN+CHrqNG2HgE41umUCkT2YT9gkA7t1d2myC
 Zy7SnGPW8M5+EY1ioyiNUufswuki5uv2VLJ/am4MubMQwEcq
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Authority-Analysis: v=2.4 cv=G+YR0tk5 c=1 sm=1 tr=0 ts=6951627d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=Mi8d0xCGeq3gkRWnbWsA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: ptRS7sbhrbdQNzBhXKJY5I1TIzK9n7tg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1NiBTYWx0ZWRfX4YJAdABGpJfl
 W6tb8RUp3ZJGna9KJE+Ywd8br5082V3I+WxDb0uBvVGB0f7JY0nBh6mdIwq4rC1inlQu1Gqt/+7
 Bu/CoR2QrCZl3v1yOHW/IaXKuX401VBqJJusBS9i1SrSyEajHEMgC0fqpMnQpAc1IKeWF4Tp0QZ
 LuxRgEMPHIMiZDdOc2yQU/cwMpVGk43vMSht8Huj4ODK8p/KaxIkhf7iBLUbJUX//fF4BM0Mjuw
 OfDxLqwV5eHu9/cvj9gzdtwjFLLTpisY/V9PziFMambPMZ3rpZ+CHv2+6NR5A0Ag8Ec/odxMEkj
 sMBeu0TvWw4zzgQa8ddLYNrzJfuTMKCeCbJ7qkGiONnzX9jmw/FAIvwfOfdlDP4uPkezAxFp2xV
 3ueHQDpaSnkWLAIc+obPiwNNgaD0+qIBnyj8Mg2UaT6SmYYx3MwyKK2L6PCuIW6rlXqhjLwTWxl
 PaqDTBAmjvL5+Lp/RRA==
X-Proofpoint-ORIG-GUID: ptRS7sbhrbdQNzBhXKJY5I1TIzK9n7tg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512280156

This driver is used to control the PCIe M.2 connectors of different
Mechanical Keys attached to the host machines and supporting different
interfaces like PCIe/SATA, USB/UART etc...

Currently, this driver supports only the Mechanical Key M connectors with
PCIe interface. The driver also only supports driving the mandatory 3.3v
and optional 1.8v power supplies. The optional signals of the Key M
connectors are not currently supported.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 MAINTAINERS                               |   7 ++
 drivers/power/sequencing/Kconfig          |   8 ++
 drivers/power/sequencing/Makefile         |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c | 160 ++++++++++++++++++++++++++++++
 4 files changed, 176 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..2eb7b6d26573 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20791,6 +20791,13 @@ F:	Documentation/driver-api/pwrseq.rst
 F:	drivers/power/sequencing/
 F:	include/linux/pwrseq/
 
+PCIE M.2 POWER SEQUENCING
+M:	Manivannan Sadhasivam <mani@kernel.org>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
+F:	drivers/power/sequencing/pwrseq-pcie-m2.c
+
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index 280f92beb5d0..f5fff84566ba 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -35,4 +35,12 @@ config POWER_SEQUENCING_TH1520_GPU
 	  GPU. This driver handles the complex clock and reset sequence
 	  required to power on the Imagination BXM GPU on this platform.
 
+config POWER_SEQUENCING_PCIE_M2
+	tristate "PCIe M.2 connector power sequencing driver"
+	depends on OF || COMPILE_TEST
+	help
+	  Say Y here to enable the power sequencing driver for PCIe M.2
+	  connectors. This driver handles the power sequencing for the M.2
+	  connectors exposing multiple interfaces like PCIe, SATA, UART, etc...
+
 endif
diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
index 96c1cf0a98ac..0911d4618298 100644
--- a/drivers/power/sequencing/Makefile
+++ b/drivers/power/sequencing/Makefile
@@ -5,3 +5,4 @@ pwrseq-core-y				:= core.o
 
 obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)	+= pwrseq-qcom-wcn.o
 obj-$(CONFIG_POWER_SEQUENCING_TH1520_GPU) += pwrseq-thead-gpu.o
+obj-$(CONFIG_POWER_SEQUENCING_PCIE_M2)	+= pwrseq-pcie-m2.o
diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
new file mode 100644
index 000000000000..4835d099d967
--- /dev/null
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
+ */
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pwrseq/provider.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+struct pwrseq_pcie_m2_pdata {
+	const struct pwrseq_target_data **targets;
+};
+
+struct pwrseq_pcie_m2_ctx {
+	struct pwrseq_device *pwrseq;
+	struct device_node *of_node;
+	const struct pwrseq_pcie_m2_pdata *pdata;
+	struct regulator_bulk_data *regs;
+	size_t num_vregs;
+	struct notifier_block nb;
+};
+
+static int pwrseq_pcie_m2_m_vregs_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
+}
+
+static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return regulator_bulk_disable(ctx->num_vregs, ctx->regs);
+}
+
+static const struct pwrseq_unit_data pwrseq_pcie_m2_vregs_unit_data = {
+	.name = "regulators-enable",
+	.enable = pwrseq_pcie_m2_m_vregs_enable,
+	.disable = pwrseq_pcie_m2_m_vregs_disable,
+};
+
+static const struct pwrseq_unit_data *pwrseq_pcie_m2_m_unit_deps[] = {
+	&pwrseq_pcie_m2_vregs_unit_data,
+	NULL
+};
+
+static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {
+	.name = "pcie-enable",
+	.deps = pwrseq_pcie_m2_m_unit_deps,
+};
+
+static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
+	.name = "pcie",
+	.unit = &pwrseq_pcie_m2_m_pcie_unit_data,
+};
+
+static const struct pwrseq_target_data *pwrseq_pcie_m2_m_targets[] = {
+	&pwrseq_pcie_m2_m_pcie_target_data,
+	NULL
+};
+
+static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_m_of_data = {
+	.targets = pwrseq_pcie_m2_m_targets,
+};
+
+static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
+				 struct device *dev)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	struct device_node *endpoint __free(device_node) = NULL;
+
+	/*
+	 * Traverse the 'remote-endpoint' nodes and check if the remote node's
+	 * parent matches the OF node of 'dev'.
+	 */
+	for_each_endpoint_of_node(ctx->of_node, endpoint) {
+		struct device_node *remote __free(device_node) =
+				of_graph_get_remote_port_parent(endpoint);
+		if (remote && (remote == dev_of_node(dev)))
+			return PWRSEQ_MATCH_OK;
+	}
+
+	return PWRSEQ_NO_MATCH;
+}
+
+static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwrseq_pcie_m2_ctx *ctx;
+	struct pwrseq_config config = {};
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->of_node = dev_of_node(dev);
+	ctx->pdata = device_get_match_data(dev);
+	if (!ctx->pdata)
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to obtain platform data\n");
+
+	/*
+	 * Currently, of_regulator_bulk_get_all() is the only regulator API that
+	 * allows to get all supplies in the devicetree node without manually
+	 * specifying them.
+	 */
+	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev), &ctx->regs);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to get all regulators\n");
+
+	ctx->num_vregs = ret;
+
+	config.parent = dev;
+	config.owner = THIS_MODULE;
+	config.drvdata = ctx;
+	config.match = pwrseq_pcie_m2_match;
+	config.targets = ctx->pdata->targets;
+
+	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
+	if (IS_ERR(ctx->pwrseq)) {
+		regulator_bulk_free(ctx->num_vregs, ctx->regs);
+		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
+				     "Failed to register the power sequencer\n");
+	}
+
+	return 0;
+}
+
+static const struct of_device_id pwrseq_pcie_m2_of_match[] = {
+	{
+		.compatible = "pcie-m2-m-connector",
+		.data = &pwrseq_pcie_m2_m_of_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pwrseq_pcie_m2_of_match);
+
+static struct platform_driver pwrseq_pcie_m2_driver = {
+	.driver = {
+		.name = "pwrseq-pcie-m2",
+		.of_match_table = pwrseq_pcie_m2_of_match,
+	},
+	.probe = pwrseq_pcie_m2_probe,
+};
+module_platform_driver(pwrseq_pcie_m2_driver);
+
+MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>");
+MODULE_DESCRIPTION("Power Sequencing driver for PCIe M.2 connector");
+MODULE_LICENSE("GPL");

-- 
2.48.1


