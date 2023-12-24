Return-Path: <linux-pci+bounces-1332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AC281D7F5
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 06:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E111F21B40
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 05:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ABE1856;
	Sun, 24 Dec 2023 05:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faJ/Md4k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35DE46B1;
	Sun, 24 Dec 2023 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703394433; x=1734930433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sULywt8zsfoKfsRdUyCgR8KmLm7/3YpeQ7pKzjInUqY=;
  b=faJ/Md4kMjMI7WdaQCpptBBy4ncj3fq1jgV9gJlv9g7aI/9Lb4JvBNra
   E4aPZP94Xw899iDju72tpNt/DSD3g4eiXm/A5UzBbK+bNBqmHX47/2N1R
   7JCeoJGqDlZdFCc6ik4Kl3TJtCaroR8LyP86mxKCrSuc2zVvJxIuoTjp0
   lUBafoPOe07LaUTpYjWSx+tn3xogOM13nYFH0YM5CqVCYxXeOY7GovBu5
   +dba+o4GQha0pcoXhPHJ+8PpnYSu1mh2whvTCuOPHpdG/PKMGcMNmDUK9
   sjq5odcy8FKewLdrWPRx1K49LAGsiTMk7vbrotsm6A9Z8iYpPsnIC1oEY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="399005142"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="399005142"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 21:07:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="780982582"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="780982582"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by fmsmga007.fm.intel.com with ESMTP; 23 Dec 2023 21:07:11 -0800
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
Subject: [RFC PATCH v6 4/4] iommu/vt-d: break out devTLB invalidation if target device is gone
Date: Sun, 24 Dec 2023 00:06:57 -0500
Message-Id: <20231224050657.182022-5-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231224050657.182022-1-haifeng.zhao@linux.intel.com>
References: <20231224050657.182022-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

to fix the rare case, the in-process safe_removal unpluged device could
be supprise_removed anytime, thus check the target device state if it
is gone, don't wait for the completion/timeout anymore. it might cause
hard lockup or system hang

Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23cb80d62a9a..7a273ee80c49 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1423,6 +1423,13 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
 
 	while (qi->desc_status[wait_index] != QI_DONE) {
+		/*
+		 * if the devTLB invalidation target device is gone, don't wait
+		 * anymore, it might take up to 1min+50%, causes system hang.
+		 */
+		if (type == QI_DIOTLB_TYPE && iommu->flush_target_dev)
+			if (!pci_device_is_present(to_pci_dev(iommu->flush_target_dev)))
+				break;
 		/*
 		 * We will leave the interrupts disabled, to prevent interrupt
 		 * context to queue another cmd while a cmd is already submitted
-- 
2.31.1


