Return-Path: <linux-pci+bounces-2688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB93E83FD01
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 04:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08D01C22F1C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 03:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362B112E78;
	Mon, 29 Jan 2024 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYkN1Bvj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D243D3AC;
	Mon, 29 Jan 2024 03:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706500195; cv=none; b=DTdTn3Y7ebLgZsa+NM4LDL4CLptMkBjN6O1dZwdO+GcIAkliU/7yiJ8oMdCkD0FLkCjVN5f0qHhE5nE7d0E8+lBaYHAIbknlcGVh6HQs5BkxFYGxGttBwLJL1lkmWLyy9UoGoZMsVIx4M71PTLNoTjHSFHfW/HXb7rfP+GS5otg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706500195; c=relaxed/simple;
	bh=wPg3myQaPF0qFlpHC2hxG+yDxWid8qb2MJ2wr7C9/2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K3WRQtAl2+wPFH5AMCy1350dDpOiCavB5wOFPH/xBrKUyXgd9+LGrCdxzybr64z3s0qJL7HXJEPYGZVocJfoQ9RlbcFJp3XOgD4kQyW7UJaiNIz1A/hTyaBmVbpNIwptMY9AFc6s9eWr/3m7y+VX8pEptYUmVG7X/oVmsAbKAbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYkN1Bvj; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706500193; x=1738036193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wPg3myQaPF0qFlpHC2hxG+yDxWid8qb2MJ2wr7C9/2Y=;
  b=hYkN1Bvj0jgdIxdpfZyr4VF6eOwnfCs7nwcGKLgiOG9wBKbiRFU30PST
   gtb+7b08KIK9i2ilWtvWYATqsroVy7MmzMyAvp3u43wUPidEs//+KEBwY
   sTrESHVcWViC3MrE12GH6B356NyyUjQ0lCYyVR/DlPWx3cykPKbYYAftB
   AVD1bPnjXShXBzNSchobmx8+Mhk2P/kzLXHTqwGiSYjbzpzCOP+DVJqar
   xs06RImP6654a+CZ1HjAcTqwaAQGqq81CutOCHtLLRsI/7oF08oiOXHWM
   Y3kEZHHIZdytsOV8viAFtCMZokln5cclt4zbVryswpjZQgG3xVgEw59pg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="406566972"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="406566972"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 19:49:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="960775230"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="960775230"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orsmga005.jf.intel.com with ESMTP; 28 Jan 2024 19:49:49 -0800
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
Subject: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target device isn't present
Date: Sun, 28 Jan 2024 22:49:24 -0500
Message-Id: <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
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
index 814134e9aa5a..2e214b43725c 100644
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


