Return-Path: <linux-pci+bounces-36494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF570B89E15
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA77189DB1F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D3C313E30;
	Fri, 19 Sep 2025 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZiyMFIE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87872313E3D
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291767; cv=none; b=u0s74LTx+Tspp/c5hQqMKKFOyZrH77blaIKHODDjTCdon56nbk81ihIZ+VtTV6gGGgzKDYhoZSugjV3GtpVSv+l25bakk6HF0e5wb8iZYfzk6rEYq59MxASg+RKMS3gBF3yVzZPiWFSbFEiT9v5UaQg7Ie4u6wwurQvlw/vpGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291767; c=relaxed/simple;
	bh=oGBBuGbInNhB5lho2xIBMMPvAzNyE4JN5rZbNu2/hnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tm1JTypzpcPAmIINpCCVMsaFNMUR/tKQLIP+nG30EMslPdkeVVRZv2Bq0hTj9BjGPPuKJ6klZapPF1RymuprXvjjlkPErT1/6XeBuXEKR7n43zPsuur4XbMmkXmwFkw6xY1O+/oC8FPDA9YpI4KVOyjmkXr9IJSGcCBZJaIyvJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZiyMFIE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291765; x=1789827765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oGBBuGbInNhB5lho2xIBMMPvAzNyE4JN5rZbNu2/hnw=;
  b=cZiyMFIE/2BTvYG0eheQZbehMrE717tNq626NCEDszKtB+h1KFdpo9sS
   ZNk8Heo9wi2QkQE2BokhMJIeIY9MqhDYAOHbEAALmgMYyUVhRrkmYAk8D
   qxzh9jSFCm7eJR/uChMe6l6ErOqM5RRrNDeRHIAWmZQJNUvWGg8/G1899
   8/ZiHPBi71sMQFVjt8sH8F5WGB8FCvWOzp3GQ9c+BW84bdO35EVNcrRRd
   bxU68RTkKP4tI3js9GNgY8/v4LYLz0+gEnAYqgY08XT7s457bKELFGjfm
   rwBZXQ/btag2czvUPDzhuUgj0TV90R6Ss+2dHo9W2gRMF8AYt7vHszxkX
   w==;
X-CSE-ConnectionGUID: HM/Mxz1fSI+O8IHfbtVuEw==
X-CSE-MsgGUID: /eEQcfG7TueJ7ot1enEAVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750543"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750543"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:39 -0700
X-CSE-ConnectionGUID: a1XxVkQsR8a+FdRD6gA7+g==
X-CSE-MsgGUID: GYLDOE+uT4ObvrX1rAlT1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655030"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 13/27] iommu/vt-d: Reserve the MSB domain ID bit for the TDX module
Date: Fri, 19 Sep 2025 07:22:22 -0700
Message-ID: <20250919142237.418648-14-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919142237.418648-1-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

The Intel TDX Connect Architecture Specification defines some enhancements
for the VT-d architecture to introduce IOMMU support for TEE-IO requests.
Section 2.2, 'Trusted DMA' states that:

I/O TLB and DID Isolation – When IOMMU is enabled to support TDX Connect,
the IOMMU restricts the VMM’s DID setting, reserving the MSB bit for the
TDX module. The TDX module always sets this reserved bit on the trusted
DMA table. IOMMU tags IOTLB, PASID cache, and context entries to indicate
whether they were created from TEE-IO transactions, ensuring isolation
between TEE and non-TEE requests in translation caches.

Reserve the MSB in the domain ID for the TDX module's use.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
[djbw: todo: replace SOC table with ACPI table detect]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/iommu/intel/dmar.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index a54934c0536f..3ae177463774 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -29,6 +29,8 @@
 #include <linux/numa.h>
 #include <linux/limits.h>
 #include <asm/irq_remapping.h>
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 
 #include "iommu.h"
 #include "../irq_remapping.h"
@@ -1033,6 +1035,31 @@ static int map_iommu(struct intel_iommu *iommu, struct dmar_drhd_unit *drhd)
 	return err;
 }
 
+static bool platform_is_tdxc_enhanced(void)
+{
+	return (boot_cpu_data.x86_vfm == INTEL_GRANITERAPIDS_D ||
+		boot_cpu_data.x86_vfm == INTEL_GRANITERAPIDS_X);
+}
+
+static unsigned long iommu_calculate_max_domain_id(struct intel_iommu *iommu)
+{
+	unsigned long ndoms = cap_ndoms(iommu->cap);
+
+	/*
+	 * Intel TDX Connect Architecture Specification, Section 2.2 Trusted DMA
+	 *
+	 * When IOMMU is enabled to support TDX Connect, the IOMMU restricts
+	 * the VMM’s DID setting, reserving the MSB bit for the TDX module. The
+	 * TDX module always sets this reserved bit on the trusted DMA table.
+	 */
+	if (platform_is_tdxc_enhanced() && (iommu->ecap & BIT_ULL(50))) {
+		pr_info_once("Most Significant Bit of domain ID reserved.\n");
+		return ndoms >> 1;
+	}
+
+	return ndoms;
+}
+
 static int alloc_iommu(struct dmar_drhd_unit *drhd)
 {
 	struct intel_iommu *iommu;
@@ -1099,7 +1126,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	spin_lock_init(&iommu->lock);
 	ida_init(&iommu->domain_ida);
 	mutex_init(&iommu->did_lock);
-	iommu->max_domain_id = cap_ndoms(iommu->cap);
+	iommu->max_domain_id = iommu_calculate_max_domain_id(iommu);
 
 	ver = readl(iommu->reg + DMAR_VER_REG);
 	pr_info("%s: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
-- 
2.51.0


