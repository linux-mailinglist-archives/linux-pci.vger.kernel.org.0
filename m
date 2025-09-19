Return-Path: <linux-pci+bounces-36496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2207B89E18
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16091C830DE
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7EE314B6F;
	Fri, 19 Sep 2025 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a77JOBXn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668E3148A6
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291767; cv=none; b=EIKQUHshImU/Y0XJ74RoGq6Ed2+pNthnCqonFooXkE3sNGfIm/vK7JqKKyRQk3YITEAECb8LaVLT357fvkRlFZl8BBtfdoOnZUK3P1xd4W2deyWg/inK/69t3a12ltbHunXKMkZOo5JhQvQYejHytS6IBOji+t3K5r4zSfd6n3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291767; c=relaxed/simple;
	bh=e3xfVYwXqJujaSsqSlfONg7/fAh9csyfu+fX/XOZI/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqksLLDPa071rvNnioX1KFNcxoWNF9AM/5fpi27xU6Cefa9y7Zs37AQha0E4MFWfhFXAklHqhWBb5DGC0DMpdqASsJjaR4VJ56n2C/7mP/13Ri5CRfmnXJmLuxb7dJMYejvQ4VTNCvyBy/X2ee603O5Ms1b3ZLO/Crlw529cDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a77JOBXn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291766; x=1789827766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3xfVYwXqJujaSsqSlfONg7/fAh9csyfu+fX/XOZI/E=;
  b=a77JOBXnBrrf/46zVlbRBAXzGhrGIu2SCi6SXZoJhpnrKltUaHzasJEB
   IuL3/nFbrM8Nkf9b+gKqG/gqpOtl9kJoObISci2j/Jcyek1BLgo9IXoPp
   dOZ6UFSB32x+uQ5ptP8GksXNUhj6tduTHPaimdDO+XydRFP15kcQlQfCJ
   tBSCFs9tLTBC4efFNsqW0ptHfhqJmIUojEdMOlfNsb0MYQJ2C58piasKW
   41/VJlQ5+R5VcodQjYqq9if7IgQeKF/rzNdHL8DvjYiatK4OpQ2EdlUqP
   Hz/ISQnrADQKSuo/Pju7rqEhvM5RFhA7j22OIvBIarFmXZa+QrlvOOcwv
   w==;
X-CSE-ConnectionGUID: fMJ3EyIITxqhyAIU7Eb5BQ==
X-CSE-MsgGUID: ecGs/MkKSJyZE3J/vHvt+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750549"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750549"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:39 -0700
X-CSE-ConnectionGUID: Cfc7uiIKTvWdUxIeNi9xNA==
X-CSE-MsgGUID: 5IjVEx5CR8in3qPwY6fbhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655038"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 15/27] x86/virt/tdx: Extend tdx_page_array to support IOMMU_MT
Date: Fri, 19 Sep 2025 07:22:24 -0700
Message-ID: <20250919142237.418648-16-dan.j.williams@intel.com>
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

From: Xu Yilun <yilun.xu@linux.intel.com>

IOMMU_MT is another TDX Module defined structure similar to HPA_ARRAY_T
and HPA_LIST_INFO. The difference is it supports multi-order contiguous
pages. It adds an additional NUM_PAGES field for every multi-order page
entry [1].

Add an dedicated allocation helper for IOMMU_MT. Maybe a general
allocation helper for multi-order is better but could postpond until
another user appears.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/tdx.h  |  2 +
 arch/x86/virt/vmx/tdx/tdx.c | 79 ++++++++++++++++++++++++++++++++++---
 include/linux/mm.h          |  2 +
 3 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index d53260aadb0b..4aae56fa225f 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -155,6 +155,8 @@ void tdx_page_array_ctrl_leak(struct tdx_page_array *array);
 int tdx_page_array_ctrl_release(struct tdx_page_array *array,
 				unsigned int nr_released,
 				u64 released_hpa);
+struct tdx_page_array *
+tdx_page_array_create_iommu_mt(unsigned int iq_order, unsigned int nr_mt_pages);
 
 struct tdx_td {
 	/* TD root structure: */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 9d4cebace054..1061adcc041f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -294,8 +294,15 @@ static int tdx_page_array_fill_root(struct tdx_page_array *array,
 			    TDX_PAGE_ARRAY_MAX_NENTS);
 
 	entries = (u64 *)page_address(array->root);
-	for (i = 0; i < array->nents; i++)
-		entries[i] = page_to_phys(array->pages[offset + i]);
+	for (i = 0; i < array->nents; i++) {
+		struct page *page = array->pages[offset + i];
+
+		entries[i] = page_to_phys(page);
+
+		/* Now only for iommu_mt */
+		if (compound_nr(page) > 1)
+			entries[i] |= compound_nr(page);
+	}
 
 	return array->nents;
 }
@@ -305,7 +312,7 @@ static void tdx_free_pages_bulk(unsigned int nr_pages, struct page **pages)
 	unsigned long i;
 
 	for (i = 0; i < nr_pages; i++)
-		__free_page(pages[i]);
+		put_page(pages[i]);
 }
 
 static int tdx_alloc_pages_bulk(unsigned int nr_pages, struct page **pages)
@@ -456,10 +463,16 @@ static bool tdx_page_array_ctrl_match(struct tdx_page_array *array,
 
 	entries = (u64 *)page_address(array->root);
 	for (i = 0; i < nents; i++) {
-		if (page_to_phys(array->pages[offset + i]) != entries[i]) {
+		struct page *page = array->pages[offset + i];
+		u64 val = page_to_phys(page);
+
+		/* Now only for iommu_mt */
+		if (compound_nr(page) > 1)
+			val |= compound_nr(page);
+
+		if (val != entries[i]) {
 			pr_err("%s entry[%d] [0x%llx] doesn't match page hpa [0x%llx]\n",
-			       __func__, i, entries[i],
-			       page_to_phys(array->pages[offset + i]));
+			       __func__, i, entries[i], val);
 			return false;
 		}
 	}
@@ -494,6 +507,60 @@ int tdx_page_array_ctrl_release(struct tdx_page_array *array,
 }
 EXPORT_SYMBOL_GPL(tdx_page_array_ctrl_release);
 
+struct tdx_page_array *
+tdx_page_array_create_iommu_mt(unsigned int iq_order, unsigned int nr_mt_pages)
+{
+	unsigned int nr_entries = 2 + nr_mt_pages;
+	int ret;
+
+	if (nr_entries > TDX_PAGE_ARRAY_MAX_NENTS)
+		return NULL;
+
+	struct tdx_page_array *array __free(kfree) = kzalloc(sizeof(*array),
+							     GFP_KERNEL);
+	if (!array)
+		return NULL;
+
+	struct page *root __free(__free_page) = alloc_page(GFP_KERNEL |
+							   __GFP_ZERO);
+	if (!root)
+		return NULL;
+
+	struct page **pages __free(kfree) = kcalloc(nr_entries, sizeof(*pages),
+						    GFP_KERNEL);
+	if (!pages)
+		return NULL;
+
+	/* TODO: folio_alloc_node() is preferred, but need numa info */
+	struct folio *t_iq __free(folio_put) = folio_alloc(GFP_KERNEL |
+							   __GFP_ZERO,
+							   iq_order);
+	if (!t_iq)
+		return NULL;
+
+	struct folio *t_ctxiq __free(folio_put) = folio_alloc(GFP_KERNEL |
+							      __GFP_ZERO,
+							      iq_order);
+	if (!t_ctxiq)
+		return NULL;
+
+	ret = tdx_alloc_pages_bulk(nr_mt_pages, pages + 2);
+	if (ret)
+		return NULL;
+
+	pages[0] = folio_page(no_free_ptr(t_iq), 0);
+	pages[1] = folio_page(no_free_ptr(t_ctxiq), 0);
+
+	array->nr_pages = nr_entries;
+	array->pages = no_free_ptr(pages);
+	array->root = no_free_ptr(root);
+
+	tdx_page_array_fill_root(array, 0);
+
+	return no_free_ptr(array);
+}
+EXPORT_SYMBOL_GPL(tdx_page_array_create_iommu_mt);
+
 static int read_sys_metadata_field(u64 field_id, u64 *data)
 {
 	struct tdx_module_args args = {};
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..719cc479f9e7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1360,6 +1360,8 @@ static inline void folio_put(struct folio *folio)
 		__folio_put(folio);
 }
 
+DEFINE_FREE(folio_put, struct folio *, if (_T) folio_put(_T))
+
 /**
  * folio_put_refs - Reduce the reference count on a folio.
  * @folio: The folio.
-- 
2.51.0


