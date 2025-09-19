Return-Path: <linux-pci+bounces-36500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D535B89E3C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E888C583D00
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3483314D26;
	Fri, 19 Sep 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaWoq/08"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E31313D78
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291770; cv=none; b=TeursKmB7UuQFLvWpKLHWUzDogCCHKXl89uT0+rLkPk0TKtWu9ubrVF8epOsMwKMjC7CKH3jBwtxYfQKHFB1uKvlrsTIkx8g7yBc10k9RzHcwlMauEGuMV17xciLk/J+kTwV9/MBKKubrot5n97xOAkVMhGTrEg3dpPdR/L41wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291770; c=relaxed/simple;
	bh=8/Eshy47gAat++ekgTj0C2+AZkKJoZa4LghDU9AnPxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/bRRwh6dKJUcVXHGphUgCXA3/AzPy3Ta/ilIh/xmAIvUXuJpo4UzpSv0S7Sfx6FbSYJf0Ruhau6so/+DC+qR6sdLN2CHBVJQCJ+mfHptKedsPJVz005/URoU0D+joTgClO5n/XZ+qDt6ihkldsw+pnRqs5ZG3Pt3kaRqr5z7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaWoq/08; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291769; x=1789827769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/Eshy47gAat++ekgTj0C2+AZkKJoZa4LghDU9AnPxw=;
  b=CaWoq/08estNknzdWIDf5J2eV39la2BpyCqJDevzP4/nEoQ5cW7Rivu2
   5a785fAERTjY5Cg8CbUXknbHZ/6zVeJnIjhU+iuUPiQTGdsWAWdyLVh6m
   E5jWoXvgrmSIuLwJbpCfjbmwWtiR2ruFQ7ryv0qAOPGVcD42xQd3U2XyL
   YbYhIZRXm7cJBDJvcyYRa0KqUWan0xbp30TzYHZWBXx8A38WZaGpcOkg9
   OXl3c/+JNPDfKYjifNRly9y+xRi4k2a6PuvLcwOVprJvhgUuUxztqNuM7
   sA6B52tJUZVFR4knBYHy6cp7kC+zEwlwRcJUg/gIt7lvs9p6p7wes5CuF
   A==;
X-CSE-ConnectionGUID: 8kLid+EoTzepvXMgiDADsg==
X-CSE-MsgGUID: DM4zWvcnQMqix8/K473YZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750561"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750561"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:40 -0700
X-CSE-ConnectionGUID: hzv9gJPBRra745DFTRAMhA==
X-CSE-MsgGUID: HWkuIb+bSSOkdpRLcrRAJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655050"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 19/27] coco/tdx-host: Add a helper to exchange SPDM messages through DOE
Date: Fri, 19 Sep 2025 07:22:28 -0700
Message-ID: <20250919142237.418648-20-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919142237.418648-1-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

TDX host uses this function to exchange TDX Module encrypted data with
devices via SPDM. It is unfortunate that TDX passes raw DOE frames with
headers included and the PCI DOE core wants payloads separated from
headers.

This conversion code is about the same amount of work as teaching the PCI
DOE driver to support raw frames. Unless and until another raw frame use
case shows up, just do this conversion in the TDX TSM driver.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/tdx-host/tdx-host.c | 61 +++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index cdd2a4670c96..f5a869443b15 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -5,11 +5,13 @@
  * Copyright (C) 2025 Intel Corporation
  */
 
+#include <linux/bitfield.h>
 #include <linux/dmar.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/pci-tsm.h>
 #include <linux/sysfs.h>
 #include <linux/tsm.h>
@@ -43,6 +45,65 @@ static struct tdx_link *to_tdx_link(struct pci_tsm *tsm)
 	return container_of(tsm, struct tdx_link, pci.base_tsm);
 }
 
+#define PCI_DOE_DATA_OBJECT_HEADER_1_OFFSET	0
+#define PCI_DOE_DATA_OBJECT_HEADER_2_OFFSET	4
+#define PCI_DOE_DATA_OBJECT_HEADER_SIZE		8
+#define PCI_DOE_DATA_OBJECT_PAYLOAD_OFFSET	PCI_DOE_DATA_OBJECT_HEADER_SIZE
+
+#define PCI_DOE_PROTOCOL_SECURE_SPDM		2
+
+static int __maybe_unused tdx_spdm_msg_exchange(struct tdx_link *tlink,
+						void *request, size_t request_sz,
+						void *response, size_t response_sz)
+{
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	void *req_pl_addr, *resp_pl_addr;
+	size_t req_pl_sz, resp_pl_sz;
+	u32 data, len;
+	u16 vendor;
+	u8 type;
+	int ret;
+
+	/*
+	 * pci_doe() accept DOE PAYLOAD only but request carries DOE HEADER so
+	 * shift the buffers, skip DOE HEADER in request buffer, and fill DOE
+	 * HEADER in response buffer manually.
+	 */
+
+	data = le32_to_cpu(*(__le32 *)(request + PCI_DOE_DATA_OBJECT_HEADER_1_OFFSET));
+	vendor = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, data);
+	type = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, data);
+
+	data = le32_to_cpu(*(__le32 *)(request + PCI_DOE_DATA_OBJECT_HEADER_2_OFFSET));
+	len = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, data);
+
+	req_pl_sz = len * sizeof(__le32) - PCI_DOE_DATA_OBJECT_HEADER_SIZE;
+	resp_pl_sz = response_sz - PCI_DOE_DATA_OBJECT_HEADER_SIZE;
+	req_pl_addr = request + PCI_DOE_DATA_OBJECT_HEADER_SIZE;
+	resp_pl_addr = response + PCI_DOE_DATA_OBJECT_HEADER_SIZE;
+
+	ret = pci_doe(tlink->pci.doe_mb, PCI_VENDOR_ID_PCI_SIG, type,
+		      req_pl_addr, req_pl_sz, resp_pl_addr, resp_pl_sz);
+	if (ret < 0) {
+		pci_err(pdev, "spdm msg exchange fail %d\n", ret);
+		return ret;
+	}
+
+	data = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, vendor) |
+	       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, type);
+	*(__le32 *)(response + PCI_DOE_DATA_OBJECT_HEADER_1_OFFSET) = cpu_to_le32(data);
+
+	len = (ret + PCI_DOE_DATA_OBJECT_HEADER_SIZE) / sizeof(__le32);
+	data = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, len);
+	*(__le32 *)(response + PCI_DOE_DATA_OBJECT_HEADER_2_OFFSET) = cpu_to_le32(data);
+
+	ret += PCI_DOE_DATA_OBJECT_HEADER_SIZE;
+
+	pci_dbg(pdev, "%s complete: vendor 0x%x type 0x%x rsp_sz %d\n",
+		__func__, vendor, type, ret);
+	return ret;
+}
+
 static int tdx_link_connect(struct pci_dev *pdev)
 {
 	return -ENXIO;
-- 
2.51.0


