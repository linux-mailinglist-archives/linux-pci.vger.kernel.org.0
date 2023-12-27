Return-Path: <linux-pci+bounces-1413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D981EBC7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 04:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6931C214B9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 03:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F166ADC;
	Wed, 27 Dec 2023 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LkW0G+vt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281B53A2;
	Wed, 27 Dec 2023 03:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703646578; x=1735182578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j/T+SOs8L50I/SYkHNNInG3FDvDRf0TdTRaMpBdX4aM=;
  b=LkW0G+vtlU5Jmbvydo7UadLiUrH2RQfQMnWmJa3BVUOff8r6oWt5N/ZD
   JGuaK/TFK2WhRffmz/kIh9e0aN8z/vaV9hefaZxp7AX6m6gM+vgX/Ai5A
   u0vlBudP+y8b5P92ROMw+cJ/LIZJQIQMjgEDYeBY7idUKAGgvmf0lPs17
   u+Yp4l1ef8lmzYhJcaYy69PC96ezW9KXTQut19zt+PXCI2q3hCKFq5IpK
   pAEYyVx+SBf5Af83mbqvcyUt1Dbs2I3ZclmDuuOVPo/Kd9EZrVoVjZ5oQ
   akkgIJiqKPlw1MmvBXP+PjUDUmigfpDIK+YZCg2xoFQMaL6rJpBtlBAYv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="15077255"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="15077255"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 19:09:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="19839134"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by orviesa002.jf.intel.com with ESMTP; 26 Dec 2023 19:09:34 -0800
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
Subject: [RFC PATCH v8 5/5] iommu/vt-d: don't loop for timeout device-TLB invalidation request forever
Date: Tue, 26 Dec 2023 22:09:18 -0500
Message-Id: <20231227030918.536413-6-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231227030918.536413-1-haifeng.zhao@linux.intel.com>
References: <20231227030918.536413-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the device-TLB invalidation (ATS invalidation) timeout happens, the
qi_submit_sync() will restart and loop for the invalidation request
forever till it is done, it will block another invalidation thread such
as the fq_timer to issue invalidation request, cause the system lockup as
following

#11 [fffffe0000b1def0] end_repeat_nmi at ffffffffaa6015f8

[exception RIP: native_queued_spin_lock_slowpath+92]

RIP: ffffffffa9d1025c RSP: ffffb202f268cdc8 RFLAGS: 00000002

RAX: 0000000000000101 RBX: ffffffffab36c2a0 RCX: 0000000000000000

RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffab36c2a0

RBP: ffffffffab36c2a0 R8: 0000000000000001 R9: 0000000000000000

R10: 0000000000000010 R11: 0000000000000018 R12: 0000000000000000

R13: 0000000000000004 R14: ffff9e10d71b1c88 R15: ffff9e10d71b1980

ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018

--- ---

#12 [ffffb202f268cdc8] native_queued_spin_lock_slowpath at ffffffffa9d1025c

#13 [ffffb202f268cdc8] do_raw_spin_lock at ffffffffa9d121f1

#14 [ffffb202f268cdd8] _raw_spin_lock_irqsave at ffffffffaa51795b

#15 [ffffb202f268cdf8] iommu_flush_dev_iotlb at ffffffffaa20df48

#16 [ffffb202f268ce28] iommu_flush_iova at ffffffffaa20e182

#17 [ffffb202f268ce60] iova_domain_flush at ffffffffaa220e27

#18 [ffffb202f268ce70] fq_flush_timeout at ffffffffaa221c9d

#19 [ffffb202f268cea8] call_timer_fn at ffffffffa9d46661

#20 [ffffb202f268cf08] run_timer_softirq at ffffffffa9d47933

#21 [ffffb202f268cf98] __softirqentry_text_start at ffffffffaa8000e0

#22 [ffffb202f268cff0] asm_call_sysvec_on_stack at ffffffffaa60114f

--- ---

(the left part of exception see the hotplug case of ATS capable device)

If one endpoint device just no response to the device-TLB invalidation
request, but is not gone, it will bring down the whole system, to avoid
such case, don't try the timeout device-TLB request forever.

and as synchronous program model of current qi_submit_sync() implementation
we couldn't wait for the enough time as PCIe spec said 1min+50%, just break
it in current sync model. (PCIe spec r6.1, sec 10.3.1)

Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 76903a8bf963..206ab0b7294f 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1457,7 +1457,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	reclaim_free_desc(qi);
 	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
 
-	if (rc == -EAGAIN)
+	if (rc == -EAGAIN && type !=QI_DIOTLB_TYPE && type != QI_DEIOTLB_TYPE)
 		goto restart;
 
 	if (iotlb_start_ktime)
-- 
2.31.1


