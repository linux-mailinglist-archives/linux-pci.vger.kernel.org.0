Return-Path: <linux-pci+bounces-1371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2584181DF27
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 09:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AD11F21E38
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 08:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8298186B;
	Mon, 25 Dec 2023 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6Qdk983"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A944107A6;
	Mon, 25 Dec 2023 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703492747; x=1735028747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZwYvHcOe8vw7UWjBi/7Fe5r5f9iUZlNZFiDgjbuH7C8=;
  b=X6Qdk983rwKO0bmHTSNtmu3EYH1bfNjO5CDEDR/MsbObVP23gNznM5Ty
   7gkkyy8tXer661W7G0OVvmhdXVK6RyMe5rV+Em0poWVlduVZxg8i/voms
   5rkurAMl4tLqZus/HSm3Mt0pO8PfLSET/bNxD9/u5Mb42bYPmDN+Yx2Mr
   VZVjbkMUC6eTZt6hYpCue044d13G3gdmz/Y4TET5H8DLzfzgHw9z9IiEV
   jog2C/myWptOSKPwngTZ7rli/u5r6uxNyZL1SLFDaIwT92f5594/l84h4
   JjhGst1RqR9fNBylL56VWBCghWPP2sWUPETVTMyTucr2kIjhzpPTQLg6V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3108189"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="3108189"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 00:25:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="1024856393"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="1024856393"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by fmsmga006.fm.intel.com with ESMTP; 25 Dec 2023 00:25:43 -0800
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
Subject: [RFC PATCH v7 4/4] iommu/vt-d: don't issue device-TLB invalidate request when device is disconnected
Date: Mon, 25 Dec 2023 03:25:32 -0500
Message-Id: <20231225082532.427362-5-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231225082532.427362-1-haifeng.zhao@linux.intel.com>
References: <20231225082532.427362-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Except those aggressive hotplug cases - surpise remove a hotplug device
while its safe removal is requested and handled in process by:

1. pull it out directly.
2. turn off its power.
3. bring the link down.
4. just died there that moment.

etc, in a word, 'gone' or 'disconnected'.

Mostly are regular normal safe removal and surprise removal unplug.
these hot unplug handling process could be optimized for fix the ATS
invalidation hang issue by calling pci_dev_is_disconnected() in function
devtlb_invalidation_with_pasid() to check target device state to avoid
sending meaningless ATS invalidation request to iommu when device is gone.
(see IMPLEMENTATION NOTE in PCIe spec r6.1 section 10.3.1)

For safe removal, device wouldn't be removed until the whole software
handling process is done, it wouldn't trigger the hard lock up issue
caused by too long ATS invalidation timeout wait. in safe removal path,
device state isn't set to pci_channel_io_perm_failure in
pciehp_unconfigure_device() by checking 'presence' parameter, calling
pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will return
false there, wouldn't break the function.

For surprise removal, device state is set to pci_channel_io_perm_failure in
pciehp_unconfigure_device(), means device is already gone (disconnected)
call pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will
return true to break the function not to send ATS invalidation request to
the disconnected device blindly, thus avoid the further long time waiting
triggers the hard lockup.

safe removal & surprise removal

pciehp_ist()
   pciehp_handle_presence_or_link_change()
     pciehp_disable_slot()
       remove_board()
         pciehp_unconfigure_device(presence)

Tested-by: Haorong Ye <yehaorong@bytedance.com>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 1c87fb1b1039..a08bdbec90eb 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -481,6 +481,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	if (!info || !info->ats_enabled)
 		return;
 
+	if (pci_dev_is_disconnected(to_pci_dev(dev)))
+		return;
+
 	sid = info->bus << 8 | info->devfn;
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
-- 
2.31.1


