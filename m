Return-Path: <linux-pci+bounces-1519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911CC81FA36
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 18:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38B91C235B9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 17:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2D5107A4;
	Thu, 28 Dec 2023 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZbZ+3dE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F088101F8;
	Thu, 28 Dec 2023 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703783117; x=1735319117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jb+k8qBAZn8bvLkpS7teeQRWVoilRckn2xon7o68bg0=;
  b=IZbZ+3dE3xMZ4S3gwR/awDmWE4JPqw1afQoV07tEgeRoYU204FRmO+f7
   4Mg/JBS8ntPrTVp0GZQBDXcymhUleZ6Tavm6bBJxGmf/VlKZUhLL60WS9
   f+6oQKd6xKhxaVRip073tShkxkiOYzgKxJ02iafrtGhQLHdg61QQBej8J
   1UsCA7vQFQEMfrCbG6CH1OH6sO1k83OhE/N4JCMVDzl7TC9h3LIsajzIf
   HLMbrkt5DKh9py/mmBoP+e249PzfEp2Dpnos50hjKtXYPSUPvDZuSpkUM
   Itm/TEtqYLHn+811hFQSIlm9QKE2Cc3adHR/7NXIbHYBSKf2xHy+j/ZKN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="10123477"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="10123477"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 09:05:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="848992501"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="848992501"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by fmsmga004.fm.intel.com with ESMTP; 28 Dec 2023 09:05:13 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: kevin.tian@intel.com,
	bhelgaas@google.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	robin.murphy@arm.com,
	lukas@wunner.de
Cc: linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v10 5/5] iommu/vt-d: don't loop for timeout ATS Invalidation request forever
Date: Thu, 28 Dec 2023 12:05:04 -0500
Message-Id: <20231228170504.720794-3-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231228170504.720794-1-haifeng.zhao@linux.intel.com>
References: <20231228170504.720794-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the ATS Invalidation request timeout happens, the qi_submit_sync()
will restart and loop for the invalidation request forever till it is
done, it will block another Invalidation thread such as the fq_timer
to issue invalidation request, cause the system lockup as following

[exception RIP: native_queued_spin_lock_slowpath+92]

RIP: ffffffffa9d1025c RSP: ffffb202f268cdc8 RFLAGS: 00000002

RAX: 0000000000000101 RBX: ffffffffab36c2a0 RCX: 0000000000000000

RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffab36c2a0

RBP: ffffffffab36c2a0 R8: 0000000000000001 R9: 0000000000000000

R10: 0000000000000010 R11: 0000000000000018 R12: 0000000000000000

R13: 0000000000000004 R14: ffff9e10d71b1c88 R15: ffff9e10d71b1980

ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018

(the left part of exception see the hotplug case of ATS capable device)

If one endpoint device just no response to the ATS Invalidation request,
but is not gone, it will bring down the whole system, to avoid such
case, don't try the timeout ATS Invalidation request forever.

Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 0a8d628a42ee..9edb4b44afca 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1453,7 +1453,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	reclaim_free_desc(qi);
 	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
 
-	if (rc == -EAGAIN)
+	if (rc == -EAGAIN && type !=QI_DIOTLB_TYPE && type != QI_DEIOTLB_TYPE)
 		goto restart;
 
 	if (iotlb_start_ktime)
-- 
2.31.1


