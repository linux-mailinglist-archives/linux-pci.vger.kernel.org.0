Return-Path: <linux-pci+bounces-40331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34695C34CE7
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 10:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E65F5651DA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F9E313E31;
	Wed,  5 Nov 2025 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8OO1Pr+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NZ0dijXT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362FD2FF164
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334223; cv=none; b=MjCGodHmayAY2dpII7rwwZ+EuzJRLpiW3XidvD+33pCJ+eL/3FqSknPA/nWZ6Rpq/0CfBLS/5VGXSHj5wgyXXLYDcklzXNB5w1V7N3Cu/ofFNWF0Qfr4279AooQCCOfVpACD6UQuH17d1/UYdpSmtWtOkROzYvvcopD9Y3+7EgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334223; c=relaxed/simple;
	bh=lxfnNvznOLNH3wJtE9qJQ2eIkCun9KOQbBjwFBEZthw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MkM0qIDVgBL9OKtax2QOs6UkIqxjSRuDYEORuA8C5gyfrycBi1hlYpgEVd/Nj043ZWLq/e7mcnq9T8KJlViJS67rDNgunYmYsanAgI/ApPaw+sqmwKzdagTw07eqY1So5cDrfvwvEbUoxpCb2ay7fCmqDIBHvLQeWJJsp09GdAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l8OO1Pr+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NZ0dijXT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A57xT5Y3165840
	for <linux-pci@vger.kernel.org>; Wed, 5 Nov 2025 09:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9BY18Ay9QO6HeFXDmCB5iQgxLMLWXgoQWG17t0/ypi4=; b=l8OO1Pr+w2QUqw2T
	rzeJ7UEnNZxfQ1/6WJkbwL+xd5zx5LaHbslt1i4D8oFy0kqdobqL0AWHv4XN2Ozb
	kXWmjaaenshzehOpXRkrICJPDPZpU3IYr4lP/NKn0Qw3WmQJASvaL8aM6K0tD0Aj
	oZ5x4yy4DOJ4bHjh5r2JACC0NGc851tje/CZGZgFRLU/myKw8YZ3w/h3RrqEqP5U
	GjEMYjwUw7DcZNfT/6ivxPhcY1bs1bL73PN4603rj6eUIIfzPKCWPpBWJlaTIL7a
	RuYhYtn3SLvdRip1EyWtz4FF8x3pZcozTqQkeJFl6W1ZqGswZIX7nieSv+B9aq6M
	YJ5KAA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ketk23t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 09:16:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-341661973daso2723820a91.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 01:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762334219; x=1762939019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BY18Ay9QO6HeFXDmCB5iQgxLMLWXgoQWG17t0/ypi4=;
        b=NZ0dijXTqxbPHMe6IADi/leNOuYQERS5sgvwh947kYvt3F8qMJR2kWy/C/a91eeWQ9
         Zqm3ssmi2Agg2VNQVWkJMIsIilhhrQfAc8FTxjtlD2JXZ9NEd3nKdp5JBWE8hUd5LKT1
         IgNA1vvHhGiPdGnVdbCr0HYFJ7jwuebffBpQyZDI81rvDf9rT0n9yRzX4pT1GG6uNmmo
         Y/jTO7xY6pdHVH4U/0TsNFKwJoT+YeNC7ZgyXtwuB0XX+yeUg5aGhNHG1KvzN9UmjwMj
         rynQJ/v2vVDxKeCTkw3+UE2WTI0UjLpjsK7VJ+5EmTB8PWEqwxKflw5sp+ZQvpTV0QSK
         DhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334219; x=1762939019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BY18Ay9QO6HeFXDmCB5iQgxLMLWXgoQWG17t0/ypi4=;
        b=Cl1ueURWfCr2GI1kNGJzpWtMNe4miu2cWjS1tIYDrxWX5j9WxomEagb1bdspf3RzuE
         Qng3Asbx+Mxt2srGqSvPMP2BBGP81Xz/xoRyEjfi/yGUEfMhZYFjmywouGhxz7gYY7Oq
         BLuMFwzvtRD4qCDcewBl0KvWLPoyNlZkm36YR7SkkTNWyk9C/McOESXA1uhf93+fbHst
         QdgqTdRUzNNOllU1z13+gAmtJc/BAxUgRy0bsGkvdLUIkgBfrsbmVg9PxEMSja+qkq5q
         4Zl36AeAgRk535kq5xHvbssd5Vqza8Fz/CBzZPBdsihN9ULyxNBwbIcujMphGnGszdJk
         nyCA==
X-Forwarded-Encrypted: i=1; AJvYcCVUig0V0ILXBRcwX9SikxPhsPXzQAGuJQjnuT9YORgya+CSMnn8Uaouc3S+BVz95RGCa1eF38Bco6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHK7JL9qqHJqOThSVtOBKqHxjHqbP5eGoI3dh0kxODFKPHUgT
	S0hVGGTzs9q894SwNfhGlH676T8qNQb3jxWy/pZPhnfUvsgtYRm6h4S+U2xgGq+3SpHXje7pnIf
	K4ld4NvrsJCe54fuatTr/YsgEm87ONLdD44dSKDBAxlET/lZEYLX7EasU31zulo0=
X-Gm-Gg: ASbGncv+a537QxEmlVfmVi1p2upq7krsNq0jJRnMY5rl8bFlykOPekMKTc0EmaJDr6f
	RGlYsejj3h1QUP/f7sopXnWu2c3v9y41liAFwZgXF0gD/iMXWPVfSoZhxk4Z4Srwlu3BHB8JR/d
	OcQGnbv3ESOQb+GR2b4gC09jx7WTV7iPB+/wEg7FOQ8YT/bODu1njfheQaAbfPonmM9VUfiUP/W
	8r/Mt79iUmPZkbiuciPnaK5jg8TGpMCR7lwqHo9sjWh8fG8Fowh3wZ9K7j22PFxEBRLe+bhOnb9
	MF2BhLZw97k6DB4Q8YlJ9xpZM3hdFGW78ISMH0tsGPod/qtDwWtlrt4dyA8t59wAA8Ryg/RgV2S
	zV718vTE2J73+Y/T+b7+n7tnrd3aa
X-Received: by 2002:a17:90b:48ca:b0:340:bfcd:6af8 with SMTP id 98e67ed59e1d1-341a6bfb6bdmr3006793a91.4.1762334218431;
        Wed, 05 Nov 2025 01:16:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKJhLn7P20MHnaF2lSocg1hIj2BoJNGSeY2P/QuEBxQZEn+Q+rm1gcYAX/apj7eTvwoUyNRA==
X-Received: by 2002:a17:90b:48ca:b0:340:bfcd:6af8 with SMTP id 98e67ed59e1d1-341a6bfb6bdmr3006767a91.4.1762334217932;
        Wed, 05 Nov 2025 01:16:57 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417a385563sm2274249a91.0.2025.11.05.01.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:16:57 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 14:45:52 +0530
Subject: [PATCH 4/4] power: sequencing: Add the Power Sequencing driver for
 the PCIe M.2 connectors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-pci-m2-v1-4-84b5f1f1e5e8@oss.qualcomm.com>
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
In-Reply-To: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7041;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=lxfnNvznOLNH3wJtE9qJQ2eIkCun9KOQbBjwFBEZthw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpCxXoqyQNKc1YDTRJOAiLbRWTNHfIQDpoDikcb
 7I0QY7J4dSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQsV6AAKCRBVnxHm/pHO
 9T5lB/9e1Ptnw12dhC7Bbv7HkDK+rPmYh2e24YDYb266Seuczy0ibRnGhnSFhnZNq/Nq8s0GcwU
 FM4QdQTZg8wrwA/MA47yPaRjDmpsDeHakI/kryqrxD2nTmpSqDpIlQtJ6eFDinBr2lcAzc6kEZs
 2gHUv6Zy6jengUJ0zq600KmWgX2DiAw6Y68DXL++w6iD2nzh0a5Ubbk/Q2Dtz9Oa/gEc4zSp2tp
 SugyDKGyafl39/S6auRryHRacuihMEsHcguk6GU4gp8P6cEVAQq0Qdmfmca4uoziYHuwKnzptgu
 zjIPm/fsKhkwUV7ybL3Cs8VVkMmbfG4EVC7oSOuuZpKixG9r
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA2OSBTYWx0ZWRfX3bX7wyKppE7i
 CZMZLj78r1mAj3RPVmtivux3AjOOyXf5TmWCYbpohD43WZVECCuL8A7CDFwGuBzvFi590WBf48f
 fXtHMs/FUhIkstWhR/2kcFOVLoT97YXksMmHvdweMFjNhvje5dZhh4rQEA/xOXVlO4bQDXboKwm
 RrZ9zUricBc7+FTlQBlfX4Q2cLiTn4ctdURvn8eFuE5nN0T4XwiL/h51RE53aG1/9jk3OgH28s3
 rLDp8MSBVOpNtVj3e/UaAPSeppSjX5P/sUrd+VqgBAR2CADOIW1T35ieH+p5LS5RHWR6B6psOCH
 z91R++JBRw3zz5xSvga5w4i8ZvpkKNcMkGTqn1r/iNP5fv/dbuU/r+0VdASdcUx+6otKl4Ek39m
 K4JijzT/6VgMphpN6e5DDXbOUn10UQ==
X-Proofpoint-GUID: HNUeerJkNhhH5dlvZS9WJAShh0q9D7LD
X-Authority-Analysis: v=2.4 cv=IdSKmGqa c=1 sm=1 tr=0 ts=690b160b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=adoi+G5QptZiRYWGMQz2cA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=OecXa5kVODwZ4gSi3wAA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: HNUeerJkNhhH5dlvZS9WJAShh0q9D7LD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050069

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
 drivers/power/sequencing/pwrseq-pcie-m2.c | 138 ++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..9b3f689d1f50c62afa3772a0c6802f99a98ac2de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20474,6 +20474,13 @@ F:	Documentation/driver-api/pwrseq.rst
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
index 280f92beb5d0ed524e67a28d1c5dd264bbd6c87e..f5fff84566ba463b55d3cd0c07db34c82f9f1e31 100644
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
index 96c1cf0a98ac54c9c1d65a4bb4e34289a3550fa1..0911d461829897c5018e26dbe475b28f6fb6914c 100644
--- a/drivers/power/sequencing/Makefile
+++ b/drivers/power/sequencing/Makefile
@@ -5,3 +5,4 @@ pwrseq-core-y				:= core.o
 
 obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)	+= pwrseq-qcom-wcn.o
 obj-$(CONFIG_POWER_SEQUENCING_TH1520_GPU) += pwrseq-thead-gpu.o
+obj-$(CONFIG_POWER_SEQUENCING_PCIE_M2)	+= pwrseq-pcie-m2.o
diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
new file mode 100644
index 0000000000000000000000000000000000000000..b9f68ee9c5a377ce900a88de86a3e269f9c99e51
--- /dev/null
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -0,0 +1,138 @@
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
+	return PWRSEQ_MATCH_OK;
+}
+
+static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwrseq_pcie_m2_ctx *ctx;
+	struct pwrseq_config config;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->pdata = of_device_get_match_data(dev);
+	if (!ctx->pdata)
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to obtain platform data\n");
+
+	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev), &ctx->regs);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to get all regulators\n");
+
+	ctx->num_vregs = ret;
+
+	memset(&config, 0, sizeof(config));
+
+	config.parent = dev;
+	config.owner = THIS_MODULE;
+	config.drvdata = ctx;
+	config.match = pwrseq_pcie_m2_match;
+	config.targets = ctx->pdata->targets;
+
+	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
+	if (IS_ERR(ctx->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
+				     "Failed to register the power sequencer\n");
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


