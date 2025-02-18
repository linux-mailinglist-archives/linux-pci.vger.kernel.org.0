Return-Path: <linux-pci+bounces-21739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A8BA3A01C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 15:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAAD189541A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF0226B0A9;
	Tue, 18 Feb 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pszX8grx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC5326AA96;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889418; cv=none; b=Zey7h+uNC8T3C5zEDjTZsO0qgGF7uEbCU4DrKG6WQg3Q0THhXSXB/YlwCVRoS2hXH6njOgWJ2Fvu/c5q1qtZ7C1kOrbGEDYYplD8uHLTUuHJsueD+g42avON4cvz0NKrPeQsnerTz051OUFQCyFEpATHFM9+DTBkGZ9Gdpfng+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889418; c=relaxed/simple;
	bh=tFuYQ9hrj4YzCLAMjMj9Ggo3laAOabX9PZWDshZl04U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFXnmVVa3MrpttjA1S5OKPtOcoVafV64hZBHCD3I9v51Oj5Tr8LJcq+YKSSu3n42+8d3h9aFFR7gPzHPoh+zY/y/PO9NQOI4Xjk2SN+YT+CO/vsuyLte+vtgKmVO0J4lKLEagEZXZ4/4CvS4ykkpZvO9rEGI/D3MwXR4W9Cm+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pszX8grx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55A12C4CEE8;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739889418;
	bh=tFuYQ9hrj4YzCLAMjMj9Ggo3laAOabX9PZWDshZl04U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pszX8grxihp/7mTiGj9O8pz8rQ1k+07jvdS3INYrRoh3U7bORJ2SZveFgjEDgsj9V
	 AfWNvBbizaM0LQEk573CsQmsAGfj+C0RnwlEmlIdXaPqP2wF/6Mp3DjZYgpf3svsnZ
	 Suiw0HbXZnizmOjbzFXPkmoKFxXIrDTMcMhZv728dgt85VRxHWLPpBSTTdkjw0hwqL
	 Gn5xKdSdhB/AvWVhLXHJOnHXfXdKSj53j5hEpVm7q7Okcgp+Ug2XLEdP/pisusgxJj
	 v2p31cmm7uaPUtQ9QOKhShu72VB7/NaJemVat4qLlChbNXfPYRIId03b1IohDKQVWl
	 WaGD/oCyZLZIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40353C021AF;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 18 Feb 2025 20:06:41 +0530
Subject: [PATCH 2/4] PCI: dwc: Add helper to find the Vendor Specific
 Extended Capability (VSEC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pcie-qcom-ptm-v1-2-16d7e480d73e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=M9WJthaTZXknfPb3HtwggK+nN0/yT7ulurjEGVuJfkQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBntJsHXKdWE8O15AQDIQdT7u8m2BaEWqY5eK3Yl
 IKQcIeh2riJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ7SbBwAKCRBVnxHm/pHO
 9XHjCACSV0ixZHMt4QHkcF/ELFQt95Op2JM1tNpLmUbnyo2ApXOsLFfNkA7/nsPnqeWXQuziAsk
 SqQHgeFy27PnZoYMJBmsWnAeveButQMxWOEWuvVLBeGGEiBV1EH0gCzJMnmjifXjjir2UECSk3p
 /3nFFGK+gDqJdVFOtCPl3C1dlgdS+xYRQjni0GF/nE/iAtk4qdA4yqZTcjQoovF/P/mJTb+RxJV
 uto/1ekr1p0Zb3djsHB+RHTSPhF/K7rxOnEk6XxAzos83BHAbq9Q6++d2X1nw5msgEK5Pk+spJh
 qtsgWY/9PikvilTHIsvk4nSQo8wB6A+sK1i+1PK32qkFxHC+
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

dw_pcie_find_vsec_capability() is used by upcoming DWC APIs to find the
VSEC capabilities like PTM, RAS etc...

Co-developed-by: Shradha Todi <shradha.t@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072..a7c0671c6715 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -16,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/pcie-dwc.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
@@ -283,6 +284,45 @@ u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
 
+static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
+					  u16 vsec_id)
+{
+	u16 vsec = 0;
+	u32 header;
+
+	if (vendor_id != dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
+		return 0;
+
+	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
+						       PCI_EXT_CAP_ID_VNDR))) {
+		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
+		if (PCI_VNDR_HEADER_ID(header) == vsec_id)
+			return vsec;
+	}
+
+	return 0;
+}
+
+static u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci,
+					const struct dwc_pcie_vsec_id *vsec_ids)
+{
+	const struct dwc_pcie_vsec_id *vid;
+	u16 vsec;
+	u32 header;
+
+	for (vid = vsec_ids; vid->vendor_id; vid++) {
+		vsec = __dw_pcie_find_vsec_capability(pci, vid->vendor_id,
+						      vid->vsec_id);
+		if (vsec) {
+			header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
+			if (PCI_VNDR_HEADER_REV(header) == vid->vsec_rev)
+				return vsec;
+		}
+	}
+
+	return 0;
+}
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {

-- 
2.25.1



