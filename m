Return-Path: <linux-pci+bounces-1291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F581C85D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 11:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE3B1C2169B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2714F92;
	Fri, 22 Dec 2023 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zsr/SnHg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2F199CE;
	Fri, 22 Dec 2023 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703241681; x=1734777681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ZVaPMXIMVluHmYj6QShn/+71TLhP8KPWDUOJ9FdycU=;
  b=Zsr/SnHg6dQlQDynm90irSq0eNduEvGmbtP/qE2UP7HeiZ8xgcyHi++k
   HhoZqqU9+gEdJ5XoQQKGutLrWAVMTNJolv32pDIvzxsmD1jEC90xzE8j+
   PDjW1pEvLhbJTRe2fwFzpqqovaRt28JxiZvT8Vos3i1gVqBKpwhh0BNSk
   OddiHqAIfbHPMuXfEnhTepaERsFQx3Ym5sxcp7gC7ypLylfSt6grebuSx
   bekXdw33o9I72Hb9Ys6Sym0uBJ0ftfOwuVjYc97bpNNNCeWrh1aqeg1Qh
   7SlHHwrbUX17uSOgkAtUVxNS1rav4UH0ZGyF9d2bqMd9leTNKylt1px5L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="399924287"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="399924287"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 02:41:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="11430801"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by fmviesa002.fm.intel.com with ESMTP; 22 Dec 2023 02:41:18 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: bhelgaas@google.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	robin.murphy@arm.com,
	lukas@wunner.de
Cc: linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 3/3] iommu/vt-d: abort the devTLB invalidation waiting if device is removed
Date: Fri, 22 Dec 2023 05:41:08 -0500
Message-Id: <20231222104108.18499-4-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231222104108.18499-1-haifeng.zhao@linux.intel.com>
References: <20231222104108.18499-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even the devTLB invalidation request is just submitted and waiting it
to be done/timeout in qi_submit_sync(), it is possible device is removed
or powered-off. try to break it out in such rare but possible case.

This patch is sent for more comment. not tested, only passed compiling.

Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  |  3 ++-
 drivers/iommu/intel/iommu.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23cb80d62a9a..d8637ab93387 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1422,7 +1422,8 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	 */
 	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
 
-	while (qi->desc_status[wait_index] != QI_DONE) {
+	while (qi->desc_status[wait_index] != QI_DONE &&
+			qi->desc_status[wait_index] != QI_ABORT) {
 		/*
 		 * We will leave the interrupts disabled, to prevent interrupt
 		 * context to queue another cmd while a cmd is already submitted
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 897159dba47d..33075d0688bc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4472,10 +4472,46 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	return &iommu->iommu;
 }
 
+static void intel_iommu_abort_devtlib_invalidate(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct q_inval *qi = iommu->qi;
+	struct qi_desc *desc, *idesc;
+	int index, offset, shift;
+	u16 sid, qdep, pfsid
+	unsigned long flags;
+
+	if (!dev_is_pci(info->dev) || !info->ats_enabled || !qi)
+		return;
+	if (!pci_dev_is_disconnected(to_pci_dev(dev)))
+		return;
+
+	sid = info->bus << 8 | info->devfn;
+	qdep = info->ats_qdep;
+	pfsid = info->pfsid;
+
+	raw_spin_lock_irqsave(&qi->q_lock, flags);
+	for (index = 1; index < QI_LENGTH; index++) {
+		offset = index << shift;
+		desc = qi->desc + offset;
+		if (desc->qw0 & QI_IWD_TYPE) {
+			offset = (index-1) << shift;
+			idesc = qi->desc + offset;
+			if (idesc->qw0 & QI_DEV_EIOTLB_SID(sid)) {
+				if (qi->desc_status[index] == QI_IN_USE)
+					qi->desc_status[index] = QI_ABORT;
+			}
+		}
+	}
+	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
+
+}
 static void intel_iommu_release_device(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
+	intel_iommu_abort_devtlib_invalidate(dev);
 	dmar_remove_one_dev_info(dev);
 	intel_pasid_free_table(dev);
 	intel_iommu_debugfs_remove_dev(info);
-- 
2.31.1


