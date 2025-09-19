Return-Path: <linux-pci+bounces-36504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE63B89E39
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315171CC24F8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED9C314B70;
	Fri, 19 Sep 2025 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyRhNXY3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6889314D09
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291773; cv=none; b=uXUM3Psug76q4Jv6mdQMRki7VqxKjxqCqworqpbfEYni+8Gxm+5YQqa2IO8s2YBK/IiQVFGcXDnqyjcisnB6pG/704nf1KrOfARCav2oRFWn3vOHJDhvjRyNRNqPavnryxJIvbrs8VbvvZ7ljl4ulNo01OedlzOZRwyVrsFZDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291773; c=relaxed/simple;
	bh=s+VrYPifGniCAEB53fvfse9O+pwjCsASQjwtx05DMPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctNOXXKWEnC8EcCWuqHQ75qB6mhAmhCth2aTQQqmHB/Yju1kZ7V57Il50X+ynFb+Z+DhyzvygKq0R9v/akJuCSIw5rFH90CkK1t6Yw15fh6XkcdDXM6xKrKKzn5AhG4ek+FhrSxKL19/l1dbZs6Y+jFSf+ZTjYBQW0CTT7jqD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyRhNXY3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291769; x=1789827769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s+VrYPifGniCAEB53fvfse9O+pwjCsASQjwtx05DMPw=;
  b=gyRhNXY3jseEBFeei+w5xhKrPJ6ktbH9Y20Wfwv4SjCsUCXg9FCrjTFr
   JUiQi3aZ2HUYJ+aW/73P7Pd6Rlb8402GZXzKGhysHFlHmXHy0Od/G8lBy
   5hT9ikrefEVoaUfOWfCSuCUfAANN4nQdrvndebEVlYjZueMyZczRyUjX5
   RcM77YziLUiYXaVzlA1a6cFif7geA7JBD314Ol1RsN9CL6/AW8lhst7GB
   HeKwbqzlL/jv8tU4qyAe/VMaynHzdH/Di+TnwPLLxDxQcEg8r99/TKEmx
   p1HeGj8WRGncUBMmG7xAjQwFcsMiPbVyD/BeupMfpb28tj4xwIIXNG5vc
   w==;
X-CSE-ConnectionGUID: RHxUKMAaSaWd66Rtbtmihg==
X-CSE-MsgGUID: YNULLlYqSeC3CnSIv8NpmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750569"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750569"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:40 -0700
X-CSE-ConnectionGUID: ecfajrtDQxe31D5DbD8vQQ==
X-CSE-MsgGUID: 5pY6XD+1Qraq1Icls7ovOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655056"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 21/27] x86/virt/tdx: Add SEAMCALL wrappers for SPDM management
Date: Fri, 19 Sep 2025 07:22:30 -0700
Message-ID: <20250919142237.418648-22-dan.j.williams@intel.com>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Add several SEAMCALL wrappers for SPDM management. TDX Module requires
HPA_ARRAY_T structure as input/output parameters for these SEAMCALLs.
So use tdx_page_array as for these wrappers.

- TDH.SPDM.CREATE creates SPDM session metadata buffers for TDX Module.
- TDH.SPDM.DELETE destroys SPDM session metadata and returns these
  buffers to host, after checking no reference attached to the metadata.
- TDH.SPDM.CONNECT establishes a new SPDM session with the device.
- TDH.SPDM.DISCONNECT tears down the SPDM session with the device.
- TDH.SPDM.MNG supports three SPDM runtime operations: HEARTBEAT,
  KEY_UPDATE and DEV_INFO_RECOLLECTION.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/tdx.h  |  11 +++
 arch/x86/virt/vmx/tdx/tdx.c | 133 ++++++++++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h |   5 ++
 3 files changed, 149 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 5f2bc970cf25..97e0d7a1f38d 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -225,6 +225,17 @@ u64 tdh_ext_mem_add(struct tdx_page_array *pg_arr);
 u64 tdh_ext_init(void);
 u64 tdh_iommu_setup(u64 vtbar, struct tdx_page_array *iommu_mt, u64 *iommu_id);
 u64 tdh_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt);
+u64 tdh_spdm_create(u64 func_id, struct tdx_page_array *spdm_mt, u64 *spdm_id);
+u64 tdh_spdm_delete(u64 spdm_id, struct tdx_page_array *spdm_mt,
+		    unsigned int *nr_released, u64 *released_hpa);
+u64 tdh_spdm_connect(u64 spdm_id, struct page *spdm_conf,
+		     struct page *spdm_rsp, struct page *spdm_req,
+		     struct tdx_page_array *spdm_out, u64 *spdm_req_or_out_len);
+u64 tdh_spdm_disconnect(u64 spdm_id, struct page *spdm_rsp,
+			struct page *spdm_req, u64 *spdm_req_len);
+u64 tdh_spdm_mng(u64 spdm_id, u64 spdm_op, struct page *spdm_param,
+		 struct page *spdm_rsp, struct page *spdm_req,
+		 struct tdx_page_array *spdm_out, u64 *spdm_req_or_out_len);
 #else
 static inline void tdx_init(void) { }
 static inline int tdx_enable(void)  { return -ENODEV; }
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 0f34009411fb..86dd855d7361 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2390,3 +2390,136 @@ u64 tdh_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt)
 	return seamcall_ret(TDH_IOMMU_CLEAR, &args);
 }
 EXPORT_SYMBOL_GPL(tdh_iommu_clear);
+
+union hpa_array_t {
+	struct {
+		u64 rsvd0:12;
+		u64 pfn:40;
+		u64 rsvd1:3;
+		u64 array_size:9;
+	};
+	u64 raw;
+};
+
+static u64 hpa_array_t_assign_raw(struct tdx_page_array *array)
+{
+	union hpa_array_t hat;
+
+	if (array->root) {
+		hat.raw = page_to_phys(array->root);
+		hat.array_size = array->nents - 1;
+	} else {
+		hat.raw = page_to_phys(array->pages[0]);
+	}
+
+	return hat.raw;
+}
+
+static u64 hpa_array_t_release_raw(struct tdx_page_array *array)
+{
+	if (array->root)
+		return page_to_phys(array->root);
+
+	return 0;
+}
+
+u64 tdh_spdm_create(u64 func_id, struct tdx_page_array *spdm_mt, u64 *spdm_id)
+{
+	struct tdx_module_args args = {
+		.rcx = func_id,
+		.rdx = hpa_array_t_assign_raw(spdm_mt)
+	};
+	u64 r;
+
+	tdx_clflush_page_array(spdm_mt);
+
+	r = seamcall_ret(TDH_SPDM_CREATE, &args);
+
+	*spdm_id = args.rcx;
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(tdh_spdm_create);
+
+u64 tdh_spdm_delete(u64 spdm_id, struct tdx_page_array *spdm_mt,
+		    unsigned int *nr_released, u64 *released_hpa)
+{
+	struct tdx_module_args args = {
+		.rcx = spdm_id,
+		.rdx = hpa_array_t_release_raw(spdm_mt),
+	};
+	union hpa_array_t released;
+	u64 r;
+
+	r = seamcall_ret(TDH_SPDM_DELETE, &args);
+	if (r < 0)
+		return r;
+
+	released.raw = args.rcx;
+	*nr_released = released.array_size + 1;
+	*released_hpa = released.pfn << PAGE_SHIFT;
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(tdh_spdm_delete);
+
+u64 tdh_spdm_connect(u64 spdm_id, struct page *spdm_conf,
+		     struct page *spdm_rsp, struct page *spdm_req,
+		     struct tdx_page_array *spdm_out, u64 *spdm_req_or_out_len)
+{
+	struct tdx_module_args args = {
+		.rcx = spdm_id,
+		.rdx = page_to_phys(spdm_conf),
+		.r8 = page_to_phys(spdm_rsp),
+		.r9 = page_to_phys(spdm_req),
+		.r10 = hpa_array_t_assign_raw(spdm_out),
+	};
+	u64 r;
+
+	r = seamcall_ret(TDH_SPDM_CONNECT, &args);
+
+	*spdm_req_or_out_len = args.rcx;
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(tdh_spdm_connect);
+
+u64 tdh_spdm_disconnect(u64 spdm_id, struct page *spdm_rsp,
+			struct page *spdm_req, u64 *spdm_req_len)
+{
+	struct tdx_module_args args = {
+		.rcx = spdm_id,
+		.rdx = page_to_phys(spdm_rsp),
+		.r8 = page_to_phys(spdm_req),
+	};
+	u64 r;
+
+	r = seamcall_ret(TDH_SPDM_DISCONNECT, &args);
+
+	*spdm_req_len = args.rcx;
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(tdh_spdm_disconnect);
+
+u64 tdh_spdm_mng(u64 spdm_id, u64 spdm_op, struct page *spdm_param,
+		 struct page *spdm_rsp, struct page *spdm_req,
+		 struct tdx_page_array *spdm_out, u64 *spdm_req_or_out_len)
+{
+	struct tdx_module_args args = {
+		.rcx = spdm_id,
+		.rdx = spdm_op,
+		.r8 = spdm_param ? page_to_phys(spdm_param) : -1,
+		.r9 = page_to_phys(spdm_rsp),
+		.r10 = page_to_phys(spdm_req),
+		.r11 = spdm_out ? hpa_array_t_assign_raw(spdm_out) : -1,
+	};
+	u64 r;
+
+	r = seamcall_ret(TDH_SPDM_MNG, &args);
+
+	*spdm_req_or_out_len = args.rcx;
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(tdh_spdm_mng);
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 13d11c8ad33d..eb67fd9d1f55 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -50,6 +50,11 @@
 #define TDH_EXT_MEM_ADD			61
 #define TDH_IOMMU_SETUP			128
 #define TDH_IOMMU_CLEAR			129
+#define TDH_SPDM_CREATE			130
+#define TDH_SPDM_DELETE			131
+#define TDH_SPDM_CONNECT		142
+#define TDH_SPDM_DISCONNECT		143
+#define TDH_SPDM_MNG			144
 
 /*
  * SEAMCALL leaf:
-- 
2.51.0


