Return-Path: <linux-pci+bounces-2564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8239383D22D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 02:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BFD28A268
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 01:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD4E469D;
	Fri, 26 Jan 2024 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZsOyMVR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6EBE5B;
	Fri, 26 Jan 2024 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233243; cv=none; b=Csoz0jTfCp3Q/nKg0seATY10r4FX5peHozRaPdseu/uxuDwylcSVYiKmdGCWSWQHxTNjKX8W3dw8HbevepK2/4lmHiF41TCDBp8tHIcHv3F3tpv9koYSn+2D1xuUKhB5nx4bUAtiwy0mqNFO8qh2z8uRAhCcWduLN17z4QNHGHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233243; c=relaxed/simple;
	bh=FcKQPcK9DSVvVLptnofw+fKVNv4QmsDqpMonokbwkz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Net+WrS96aNeh2JiCbJCttvaWKEgpk+0vwdrZ/FE86UDB41qdLKI83J/o/2iZL6c3dciTPNMJj4Sve4KETuTZUQJ/klhhKsWh23E0j+6sZnxl6zGZ9zeP/8lJY89kNoK3icVXknCZvpw20wXSB7bUaKpUcs/PKVO0ioKeaeBYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZsOyMVR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706233242; x=1737769242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FcKQPcK9DSVvVLptnofw+fKVNv4QmsDqpMonokbwkz0=;
  b=DZsOyMVRFBgq6h9Ix+AhJEFRBDRy9IYt1Pq38rn6zvJK57FGsNRz7Jjn
   2zq0FN3i09Gnu+UASLTrL0zQB1KA8I/cLSQg/TggWoWmNiyXUwAnN2rrb
   elR+PCTFhpPlYU+xKuQBI5/Z+hZWcGOAbYDKqlqMfswtdE8Rnlj52jsfR
   y9Ybh2BZR9Y41RaYEyg5TPYQ/OOo3Zxa/geSwdTq8TqMl6vTue/MDW4EA
   kqGV1jUX2LaJI64zRT5G1nZgtH4IHqPZi4OCxn/wicztqCsDwfwgKt7yX
   rbxsP5s4yUfmcrlYektoS3Hg1ZjLeqJBvnuYqu79l5D23+eOd+JOal/LV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15718519"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15718519"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 17:40:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2533153"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jan 2024 17:40:39 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	lukas@wunner.de,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH v11 5/5] iommu/vt-d: improve ITE fault handling if target device isn't present
Date: Thu, 25 Jan 2024 20:40:02 -0500
Message-Id: <20240126014002.481294-6-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240126014002.481294-1-haifeng.zhao@linux.intel.com>
References: <20240126014002.481294-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because surprise removal could happen anytime, e.g. user could request safe
removal to EP(endpoint device) via sysfs and brings its link down to do
surprise removal cocurrently. such aggressive cases would cause ATS 
invalidation request issued to non-existence target device, then deadly
loop to retry that request after ITE fault triggered in interrupt context.
this patch aims to optimize the ITE handling by checking the target device
presence state to avoid retrying the timeout request blindly, thus avoid
hard lockup or system hang.

Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 814134e9aa5a..e2d5ea2b0683 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1272,6 +1272,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index,
 {
 	u32 fault;
 	int head, tail;
+	u64 iqe_err, ite_sid;
 	struct q_inval *qi = iommu->qi;
 	int shift = qi_shift(iommu);
 
@@ -1316,6 +1317,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index,
 		tail = readl(iommu->reg + DMAR_IQT_REG);
 		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
 
+		/*
+		 * SID field is valid only when the ITE field is Set in FSTS_REG
+		 * see Intel VT-d spec r4.1, section 11.4.9.9
+		 */
+		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
+		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
+
 		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
 		pr_info("Invalidation Time-out Error (ITE) cleared\n");
 
@@ -1325,6 +1333,16 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index,
 			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
 		} while (head != tail);
 
+		/*
+		 * If got ITE, we need to check if the sid of ITE is the same as
+		 * current ATS invalidation target device, if yes, don't try this
+		 * request anymore if the target device isn't present.
+		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
+		 */
+		if (pdev && ite_sid && !pci_device_is_present(pdev) &&
+			ite_sid == pci_dev_id(pci_physfn(pdev)))
+			return -ETIMEDOUT;
+
 		if (qi->desc_status[wait_index] == QI_ABORT)
 			return -EAGAIN;
 	}
-- 
2.31.1


