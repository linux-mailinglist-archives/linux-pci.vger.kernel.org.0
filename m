Return-Path: <linux-pci+bounces-3854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D4E85F3D5
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 10:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16CC1F24DF3
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABEA374FD;
	Thu, 22 Feb 2024 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="An46a9oW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2C374E6;
	Thu, 22 Feb 2024 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592612; cv=none; b=DaS8AV9PdNlFIVAH7HWKcdxoAhKy3/dC1EyVX8d/ez4XMNQPo031iiAxquPOer2S99BXEF+8kmg0yoZ7CerC6SQh68uUFYjRZckNDwmM5sU2L0flZAk0qry836mXjAVlS/I6XVwprmdbrlCW1oX9Kr+IPI9JJBTEpM60Pr488+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592612; c=relaxed/simple;
	bh=Ufbfc9qGqnc9GmviuGU5ACXNF84S20F4WyXi3i5SB2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKos6oZ/fgEePtEhTTiZBi8czhxej1HUK9epkaq48jSVE0Viv9hMXFaw0DOYqaoTcu7AUkvcONJEHBDwKQHYWIoduwoilQoGdEyj6FosEOGg1nmFZ60o7I7nU6+jx66BH5y7dHLcp/wHGy2yJojjJmkTsTN/K6/O+DJjVhC/nOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=An46a9oW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708592612; x=1740128612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ufbfc9qGqnc9GmviuGU5ACXNF84S20F4WyXi3i5SB2A=;
  b=An46a9oWu7+08JXZGZIDKX428jFFteAKwCuhJuUnQTlRKL8uZKKXLAR1
   SGmAl4qwqkm4XFYI0jBEXRM/+G7fHZmEGSSkQ85P9gfBfEo2GvdM54Are
   MPXXoSVpdC1wk7cRd95j2noF8mvbRmkFuR28KxiT50V+Xmvz3J/ATA+tJ
   AtvJQ3myqfeLEOGccmadheoOfvLtzrzHE60zU8PpOMzqcUw/kNMIEPEpK
   5z2E1evEB4g/sqES/E5Snd3CcIWjfMwgo3Xr7o+gwQxGqfo/COdCeQjax
   BZW55863HAKWhGsXyt5uVS+BzSp3NXVgpYLUBWYhDNLbH4h84cr63HXdg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25264497"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25264497"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 01:03:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10122703"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orviesa003.jf.intel.com with ESMTP; 22 Feb 2024 01:03:27 -0800
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
	dan.carpenter@linaro.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH v13 3/3] iommu/vt-d: improve ITE fault handling if target device isn't valid
Date: Thu, 22 Feb 2024 04:02:51 -0500
Message-Id: <20240222090251.2849702-4-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
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

Devices are valid ATS invalidation request target only when they reside
in the iommu->device_rbtre (probed, not released) and present.

Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d14797aabb7a..d01d68205557 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1273,6 +1273,9 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 {
 	u32 fault;
 	int head, tail;
+	u64 iqe_err, ite_sid;
+	struct device *dev = NULL;
+	struct pci_dev *pdev = NULL;
 	struct q_inval *qi = iommu->qi;
 	int shift = qi_shift(iommu);
 
@@ -1317,6 +1320,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
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
 
@@ -1326,6 +1336,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
 		} while (head != tail);
 
+		/*
+		 * If got ITE, we need to check if the sid of ITE is one of the
+		 * current valid ATS invalidation target devices, if no, or the
+		 * target device isn't presnet, don't try this request anymore.
+		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
+		 */
+		if (ite_sid) {
+			dev = device_rbtree_find(iommu, ite_sid);
+			if (!dev || !dev_is_pci(dev))
+				return -ETIMEDOUT;
+			pdev = to_pci_dev(dev);
+			if (!pci_device_is_present(pdev) &&
+				ite_sid == pci_dev_id(pci_physfn(pdev)))
+				return -ETIMEDOUT;
+		}
 		if (qi->desc_status[wait_index] == QI_ABORT)
 			return -EAGAIN;
 	}
-- 
2.31.1


