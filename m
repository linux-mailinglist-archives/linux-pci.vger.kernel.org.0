Return-Path: <linux-pci+bounces-21738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A833BA3A035
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 15:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEBB3B5FC9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 14:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1858B26B0A6;
	Tue, 18 Feb 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnaEI9PN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE826AA94;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889418; cv=none; b=Je2xI8yv9X6fW22w+myjeeg1gPbTt15Fx5nKDoq1Yq+reiUTzVAKvHZpJVcIkqd/eERA5vMQ0LJWgmJKBnYWnHpZJQbHeiLSdu7V32Dpb8VpFIypE7RtSNb56nzI/6kJeSGn9rPqDyIWyk63rQFZvRlz70DNliLtkDk64svBOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889418; c=relaxed/simple;
	bh=o4GSDwcgCMz6AI4qFmm6hqFIO8SQo/fCcVqaBA7mmiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hDxeQmHDnkZt6MHaYQpUnnxGAkreKkdBg7xmxTy5HpdwDJ9xNLP+qcu/mObu28aiyHUHTjeNBtB8DnYXTtH9qF8HlrdbWFjb2nQ9nBFU8+GQ+GiZCVPFqfTFxfQDGYv7QjWyvPHvs/bgieeQIlx/WBw99E36z6n9TqSEsjYtjeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnaEI9PN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42349C4CEE6;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739889418;
	bh=o4GSDwcgCMz6AI4qFmm6hqFIO8SQo/fCcVqaBA7mmiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TnaEI9PNS6TDXzIPducf6m7rFu5FiYShedTbFhQZN5UbBqQqzjIqcU13fDgVoSafu
	 imVxDSeAkxrcmzB4bGtEHn3hV9Cp4EnZBP66WaxvBwMM6TEi/dHOEeQHfRTQldeJaK
	 IYLv+tPSpYSmXgZ6J7PMwniTFcsc2kHMF7hVysuzQFBrk5cjLm0z8x+UJ8d3P5s0vR
	 ON7uOcZnSaPLdgt0l4pMT+z36dI2FtUpZlZm5f4B88SECkVHX2mAza/x6q5SOseKJR
	 oyGYVUwsOGcKaH7E6sI2MxKGzQduY3KE6rtGEinVF+YOxR/8wVSf7rrHQExrXB0gDi
	 +3eck03/JPvVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB4CC021AD;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 18 Feb 2025 20:06:40 +0530
Subject: [PATCH 1/4] perf/dwc_pcie: Move common DWC struct definitions to
 'pcie-dwc.h'
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pcie-qcom-ptm-v1-1-16d7e480d73e@linaro.org>
References: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
In-Reply-To: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>, 
 Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3403;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=6d2Yb8pZtN0A+yfWOqcZ9eUeZfdnTNPaYMX4prFPOcU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBntJsHNIhzToT44AY+uhNUlCsCN6bOgu98Qogla
 8fEUJTYaTeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ7SbBwAKCRBVnxHm/pHO
 9WZ0B/9Nin9btaLnESIchxC1r4blWqXKP9BhZLaYFCxr61YM/Ph8gTp0V8EHuv2b7Va1fr0QWky
 5PGPDx8LXDlVdLyoPq0tz0t1jnv6USht1n+8SCWYLUAwUfMNU2iXopohMhcY3flFWFgGmOqatQq
 MC5k05B6r4WatPiN/s1AIbo8QlGoAp/nPJsgttnQrtWvKcuA84LYi01Hg0XZBt7fuTzr3hyY8nY
 7Yys0rTVKtBQn6s6eCcPu7I7fBpcgpfuHAAjHfpsPry7KpQxAK8KweQ+1xrzA2Iu6GzKJ90T2Ib
 Mpp00V379HiuU/qgoo7PcgX/ik+4LfjwG993avYaYGYGEue5
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Since these are common to all Desginware PCIe IPs, move them to a new
header, 'pcie-dwc.h' so that other drivers could make use of them.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS                 |  1 +
 drivers/perf/dwc_pcie_pmu.c | 23 ++---------------------
 include/linux/pcie-dwc.h    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..b4d09d52a750 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18123,6 +18123,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
 F:	drivers/pci/controller/dwc/*designware*
+F:	include/linux/pcie-dwc.h
 
 PCI DRIVER FOR TI DRA7XX/J721E
 M:	Vignesh Raghavendra <vigneshr@ti.com>
diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index cccecae9823f..05b37ea7cf16 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/pcie-dwc.h>
 #include <linux/perf_event.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -99,26 +100,6 @@ struct dwc_pcie_dev_info {
 	struct list_head dev_node;
 };
 
-struct dwc_pcie_pmu_vsec_id {
-	u16 vendor_id;
-	u16 vsec_id;
-	u8 vsec_rev;
-};
-
-/*
- * VSEC IDs are allocated by the vendor, so a given ID may mean different
- * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
- */
-static const struct dwc_pcie_pmu_vsec_id dwc_pcie_pmu_vsec_ids[] = {
-	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
-	  .vsec_id = 0x02, .vsec_rev = 0x4 },
-	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
-	  .vsec_id = 0x02, .vsec_rev = 0x4 },
-	{ .vendor_id = PCI_VENDOR_ID_QCOM,
-	  .vsec_id = 0x02, .vsec_rev = 0x4 },
-	{} /* terminator */
-};
-
 static ssize_t cpumask_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -529,7 +510,7 @@ static void dwc_pcie_unregister_pmu(void *data)
 
 static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
 {
-	const struct dwc_pcie_pmu_vsec_id *vid;
+	const struct dwc_pcie_vsec_id *vid;
 	u16 vsec;
 	u32 val;
 
diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
new file mode 100644
index 000000000000..261ae11d75a4
--- /dev/null
+++ b/include/linux/pcie-dwc.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021-2023 Alibaba Inc.
+ *
+ * Copyright 2025 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#ifndef LINUX_PCIE_DWC_H
+#define LINUX_PCIE_DWC_H
+
+#include <linux/pci_ids.h>
+
+struct dwc_pcie_vsec_id {
+	u16 vendor_id;
+	u16 vsec_id;
+	u8 vsec_rev;
+};
+
+/*
+ * VSEC IDs are allocated by the vendor, so a given ID may mean different
+ * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
+ */
+static const struct dwc_pcie_vsec_id dwc_pcie_pmu_vsec_ids[] = {
+	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_QCOM,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{} /* terminator */
+};
+
+#endif /* LINUX_PCIE_DWC_H */

-- 
2.25.1



