Return-Path: <linux-pci+bounces-36499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC6DB89E21
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468D93B5E63
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC11314B9F;
	Fri, 19 Sep 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDn02Yw+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02276314B70
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291769; cv=none; b=py7TcUSKjMUfZ7ZLJ1zdXJqvDPBvNfCB4izu1aSXwQOnDqF3Nilba7EJGopn85UtCz5mwZx9w0FBVIQ/8JCp0LbDvTzcIv1T+LtERoF/cWJMxEY7zivvb7NDDYe8TeaF7jn2ny8ZNeqtpb0lNqBDFR5s98vDalZftEUgE3htdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291769; c=relaxed/simple;
	bh=3gie8v6fJdM+HUedCG4ZohIta3K4VctlafuHNXLBBJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOX7zEpUHI2A18R5zSKFoV2CgcHh5K7kLVNG642nkmhlPDg4qc19GjeD7cPz6Kz3wcLjZ4a0F8IMxxHNd0ECxb0TBgvJvyn5VkIS+viP5TGVZ4Ct2JOCaxAy94UK0pyZKWDeYmXZv0NyAMN4i1oVfRAWDJHOmlh7HG0v72JNRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDn02Yw+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291768; x=1789827768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3gie8v6fJdM+HUedCG4ZohIta3K4VctlafuHNXLBBJQ=;
  b=dDn02Yw+pljon1eULXUSyXJ8lzSE5acGscxGj4uEUyf6iFSgZqCVJtuw
   lFH9d99oHOrbnZVr8QXhz931BiKQp/+GTvyHp08xB7F7eY5iaBzbisU6Y
   4+l7OMuw5NBZfMSkTF3TwXOve3I5KvUiGiQOllp+XofqjaNTfSxyMfQ0h
   JmJQDYi0BtoIQNhKVTPNzsm9WpVTjOrNVD6u5lzjMjCpx9KZfe8QXHEn1
   6PzUnqhhQnuc/GY2+dmp4Hi17FHLB1Rex0wnsKi86ZKw1jh3n5nDjkvG/
   CFWarIRGvyjkWkfu8zpeSd38U4k6pP6kXL/MIfdmUGAuT6GE5/pbr8Xhx
   A==;
X-CSE-ConnectionGUID: yqUgSgd/TaGbX/pv4hiTpA==
X-CSE-MsgGUID: Ymn0yh/fTkyXr00ucYEj1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750558"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750558"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:40 -0700
X-CSE-ConnectionGUID: XpI7uzqwT/+M12SbWMouhw==
X-CSE-MsgGUID: bXMY7kFfRRKvjeRq9PEyVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655047"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 18/27] coco/tdx-host: Setup all trusted IOMMUs on TDX Connect init
Date: Fri, 19 Sep 2025 07:22:27 -0700
Message-ID: <20250919142237.418648-19-dan.j.williams@intel.com>
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

From: Xu Yilun <yilun.xu@linux.intel.com>

Setup all trusted IOMMUs on TDX Connect initialization and clear all on
TDX Connect removal.

Trusted IOMMU setup is the pre-condition for all following TDX Connect
operations such as SPDM/IDE setup. It is more of a platform
configuration than a standalone IOMMU configuration, so put the
implementation in tdx-host driver.

There is no dedicated way to enumerate which IOMMU devices support
trusted operations. The host has to call TDH.IOMMU.SETUP on all IOMMU
devices and tell their trusted capability by the return value.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/tdx-host/tdx-host.c | 90 +++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 2411c7d34b6b..cdd2a4670c96 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2025 Intel Corporation
  */
 
+#include <linux/dmar.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -128,6 +129,85 @@ static void unregister_link_tsm(void *data)
 	tsm_unregister(link_dev);
 }
 
+static DEFINE_XARRAY(tlink_iommu_xa);
+
+static void tdx_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt)
+{
+	u64 r;
+
+	r = tdh_iommu_clear(iommu_id, iommu_mt);
+	if (r) {
+		pr_err("%s fail to clear tdx iommu\n", __func__);
+		goto leak;
+	}
+
+	if (tdx_page_array_ctrl_release(iommu_mt, iommu_mt->nr_pages,
+					page_to_phys(iommu_mt->root))) {
+		pr_err("%s fail to release metadata pages\n", __func__);
+		goto leak;
+	}
+
+	return;
+
+leak:
+	tdx_page_array_ctrl_leak(iommu_mt);
+}
+
+static int tdx_iommu_enable_one(struct dmar_drhd_unit *drhd)
+{
+	unsigned int nr_pages = tdx_sysinfo->connect.iommu_mt_page_count;
+	u64 r, iommu_id;
+	int ret;
+
+	struct tdx_page_array *iommu_mt __free(tdx_page_array_free) =
+		tdx_page_array_create_iommu_mt(1, nr_pages);
+	if (!iommu_mt)
+		return -ENOMEM;
+
+	do {
+		r = tdh_iommu_setup(drhd->reg_base_addr, iommu_mt, &iommu_id);
+	} while (r == TDX_INTERRUPTED_RESUMABLE);
+
+	/* This drhd doesn't support tdx mode, skip. */
+	if ((r & TDX_SEAMCALL_STATUS_MASK)  == TDX_OPERAND_INVALID)
+		return 0;
+
+	if (r) {
+		pr_err("fail to enable tdx mode for DRHD[0x%llx]\n",
+		       drhd->reg_base_addr);
+		return -EFAULT;
+	}
+
+	ret = xa_insert(&tlink_iommu_xa, (unsigned long)iommu_id,
+			no_free_ptr(iommu_mt), GFP_KERNEL);
+	if (ret) {
+		tdx_iommu_clear(iommu_id, iommu_mt);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void tdx_iommu_disable_all(void *data)
+{
+	struct tdx_page_array *iommu_mt;
+	unsigned long iommu_id;
+
+	xa_for_each(&tlink_iommu_xa, iommu_id, iommu_mt)
+		tdx_iommu_clear(iommu_id, iommu_mt);
+}
+
+static int tdx_iommu_enable_all(void)
+{
+	int ret;
+
+	ret = do_for_each_drhd_unit(tdx_iommu_enable_one);
+	if (ret)
+		tdx_iommu_disable_all(NULL);
+
+	return ret;
+}
+
 static int tdx_connect_init(struct device *dev)
 {
 	struct tsm_dev *link;
@@ -149,6 +229,16 @@ static int tdx_connect_init(struct device *dev)
 		return ret;
 	}
 
+	ret = tdx_iommu_enable_all();
+	if (ret) {
+		dev_err(dev, "Enable tdx iommu failed\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, tdx_iommu_disable_all, NULL);
+	if (ret)
+		return ret;
+
 	link = tsm_register(dev, &tdx_link_ops);
 	if (IS_ERR(link)) {
 		dev_err(dev, "failed to register TSM: (%pe)\n", link);
-- 
2.51.0


