Return-Path: <linux-pci+bounces-36486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0382B89DFD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392225655BC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D2C310635;
	Fri, 19 Sep 2025 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ez3lfB9B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5E31329B
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291762; cv=none; b=acHzWGqvygP0DrkkZPv0Tywt/TfgOe8mUODsodaYKukJXQa1hXwXzlJ/nPrP9trwfk5XXOIhyFifdgOtbis6+D9KdmhcJ+y5coAH96Xvl6Dn+1JboTCm78GY/XV9bTqT/pPJ6yt8qedDcWODNn8iLd5S7oz2SLD+qwcKwjg7ksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291762; c=relaxed/simple;
	bh=MzZBK9Ogcv5tHukzMvTX3584EHxgB8gPuCS3w60iHZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdhLKIRsGPVZ0i7JWP7qzAETpq72dl/IT3xA1F6+87bUp2/4Oa/AIOpMlvYlrv8bX8H4TulPA6FCQCpe/uz9S/Orqd6F8BLO0TeCUkkTAb16CXZ5Mlw89s1S3kLD+RLlFRyXXQy+oqEQYNB6Li+OIIRw1xKB+RnX4OEPc6Cjjtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ez3lfB9B; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291760; x=1789827760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MzZBK9Ogcv5tHukzMvTX3584EHxgB8gPuCS3w60iHZ4=;
  b=ez3lfB9BTWa9utOVzrpOCDRrkBL1S7t0xKgoDJrpkf1D4rOIY9f0cWZm
   OEM/NvFUDUcGafzowDHfzUXywdJg7khTelVTklnJKzS9+zl/qUfWUOZ2R
   jBTi9ippPd0EkozG9ULmW1CnLpmyQCH+99vUd9dsAIGfg+aPq94Z/unS1
   S2KPwkuaKjYrKIgcYeDsj6ASrbaGi+NLj+HK/QJ6PUyU306tsUXRtgfDG
   60AgCq4/PrOTeJm2QtI5QSqAEV7XZBk9ucrppthZ1J+tPmfyN9TuiU2wj
   f3gGP471NyFMWwNZQz9g72bjAHrApF5dg/gC8IeIBk8lScKs4PNs4rYHR
   Q==;
X-CSE-ConnectionGUID: /fyEMnMsR5y/NCs4mxxYRA==
X-CSE-MsgGUID: 48YJ+hO0RqmbQ/pQw1BpOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750514"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750514"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:37 -0700
X-CSE-ConnectionGUID: 89nEZeESS82/farUxzly8w==
X-CSE-MsgGUID: uPPjgViMThSaYGC3dEH85A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655004"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH 05/27] x86/virt/tdx: Add tdx_page_array helpers for new TDX Module objects
Date: Fri, 19 Sep 2025 07:22:14 -0700
Message-ID: <20250919142237.418648-6-dan.j.williams@intel.com>
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

Add struct tdx_page_array definition for new TDX Module object
types - HPA_ARRAY_T and HPA_LIST_INFO. They are used as input/output
parameters in newly defined SEAMCALLs. Also define some helpers to
allocate, setup and free tdx_page_array.

HPA_ARRAY_T and HPA_LIST_INFO are similar in most aspects. They both
represent a list of pages for TDX Module accessing. There are several
use cases for these 2 structures:

 - As SEAMCALL inputs. They are claimed by TDX Module as control pages.
 - As SEAMCALL outputs. They were TDX Module control pages and now are
   released.
 - As SEAMCALL inputs. They are just medium for exchanging data blobs
   in one SEAMCALL. TDX Module will not hold them as control pages.

The 2 structures both need a 'root page' which contains a list of HPAs.
They compress the HPA of the root page and the number of valid HPAs into
a 64 bit raw value for SEAMCALL parameters. The root page is always a
medium for passing data pages, TDX Module never keeps the root page.

A main difference is HPA_ARRAY_T requires singleton mode when
containing just 1 functional page (page0). In this mode the root page is
not needed and the HPA field of the raw value directly points to the
page0.

Another small difference is HPA_LIST_INFO contains a 'first entry' field
which could be filled by TDX Module. This simplifies host by providing
the same structure when re-invoke the interrupted SEAMCALL. No need for
host to touch this field.

Typical usages of the tdx_page_array:

1. Add control pages:
 - struct tdx_page_array *array = tdx_page_array_create(nr_pages, ...);
 - seamcall(TDH_XXX_CREATE, array, ...);

2. Release control pages:
 - seamcall(TDX_XXX_DELETE, array, &nr_released, &released_hpa);
 - tdx_page_array_ctrl_release(array, nr_released, released_hpa);

3. Exchange data blobs:
 - struct tdx_page_array *array = tdx_page_array_create(nr_pages, ...);
 - seamcall(TDX_XXX, array, ...);
 - Read data from array.
 - tdx_page_array_free(array);

4. Note the root page contains 512 HPAs at most, if more pages are
   required, refilling the tdx_page_array is needed.

 - struct tdx_page_array *array = tdx_page_array_alloc(nr_pages, ...);
 - for each 512-page bulk
   - tdx_page_array_fill_root(array, offset);
   - seamcall(TDH_XXX_ADD, array, ...);

In case 2, SEAMCALLs output the released page array in the form of
HPA_ARRAY_T or PAGE_LIST_INFO. tdx_page_array_ctrl_release() is
responsible for checking if the output pages match the original input
pages. If failed to match, the safer way is to leak the control pages,
tdx_page_array_ctrl_leak() should be called.

The usage of tdx_page_array will be in following patches.

Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/tdx.h  |  18 +++
 arch/x86/virt/vmx/tdx/tdx.c | 221 ++++++++++++++++++++++++++++++++++++
 include/linux/gfp.h         |   2 +
 3 files changed, 241 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 732e1e7fd556..fbd50df216af 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -136,6 +136,24 @@ int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
 
+struct tdx_page_array {
+	unsigned int nr_pages;
+	struct page **pages;
+
+	unsigned int offset;
+	unsigned int nents;
+	struct page *root;
+};
+
+void tdx_page_array_free(struct tdx_page_array *array);
+DEFINE_FREE(tdx_page_array_free, struct tdx_page_array *, if (_T) tdx_page_array_free(_T))
+struct tdx_page_array *
+tdx_page_array_create(unsigned int nr_pages, bool allow_singleton);
+void tdx_page_array_ctrl_leak(struct tdx_page_array *array);
+int tdx_page_array_ctrl_release(struct tdx_page_array *array,
+				unsigned int nr_released,
+				u64 released_hpa);
+
 struct tdx_td {
 	/* TD root structure: */
 	struct page *tdr_page;
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index ada2fd4c2d54..bc5b8e288546 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -269,6 +269,227 @@ static int build_tdx_memlist(struct list_head *tmb_list)
 	return ret;
 }
 
+#define TDX_PAGE_ARRAY_MAX_NENTS	(PAGE_SIZE / sizeof(u64))
+
+static int tdx_page_array_fill_root(struct tdx_page_array *array,
+				    unsigned int offset)
+{
+	unsigned int i;
+	u64 *entries;
+
+	if (offset >= array->nr_pages)
+		return 0;
+
+	if (!array->root) {
+		array->nents = 1;
+		return array->nents;
+	}
+
+	array->offset = offset;
+	array->nents = umin(array->nr_pages - offset,
+			    TDX_PAGE_ARRAY_MAX_NENTS);
+
+	entries = (u64 *)page_address(array->root);
+	for (i = 0; i < array->nents; i++)
+		entries[i] = page_to_phys(array->pages[offset + i]);
+
+	return array->nents;
+}
+
+static void tdx_free_pages_bulk(unsigned int nr_pages, struct page **pages)
+{
+	unsigned long i;
+
+	for (i = 0; i < nr_pages; i++)
+		__free_page(pages[i]);
+}
+
+static int tdx_alloc_pages_bulk(unsigned int nr_pages, struct page **pages)
+{
+	unsigned int filled, done = 0;
+
+	do {
+		filled = alloc_pages_bulk(GFP_KERNEL, nr_pages - done,
+					  pages + done);
+		if (!filled) {
+			tdx_free_pages_bulk(done, pages);
+			return -ENOMEM;
+		}
+
+		done += filled;
+	} while (done != nr_pages);
+
+	return 0;
+}
+
+void tdx_page_array_free(struct tdx_page_array *array)
+{
+	if (!array)
+		return;
+
+	if (array->root)
+		__free_page(array->root);
+
+	tdx_free_pages_bulk(array->nr_pages, array->pages);
+	kfree(array->pages);
+	kfree(array);
+}
+EXPORT_SYMBOL_GPL(tdx_page_array_free);
+
+static struct tdx_page_array *
+tdx_page_array_alloc(unsigned int nr_pages, bool allow_singleton)
+{
+	int ret;
+
+	if (!nr_pages)
+		return NULL;
+
+	struct tdx_page_array *array __free(kfree) = kzalloc(sizeof(*array),
+							     GFP_KERNEL);
+	if (!array)
+		return NULL;
+
+	struct page *root __free(__free_page) = NULL;
+	if (!allow_singleton || nr_pages != 1) {
+		root = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!root)
+			return NULL;
+	}
+
+	struct page **pages __free(kfree) = kcalloc(nr_pages, sizeof(*pages),
+						    GFP_KERNEL);
+	if (!pages)
+		return NULL;
+
+	ret = tdx_alloc_pages_bulk(nr_pages, pages);
+	if (ret)
+		return NULL;
+
+	array->nr_pages = nr_pages;
+	array->pages = no_free_ptr(pages);
+	array->root = no_free_ptr(root);
+
+	return no_free_ptr(array);
+}
+
+/*
+ * For holding less than TDX_PAGE_ARRAY_MAX_NENTS (512) pages.
+ *
+ * If more pages are required, use tdx_page_array_alloc() and
+ * tdx_page_array_fill_root() to build tdx_page_array chunk by chunk.
+ */
+struct tdx_page_array *
+tdx_page_array_create(unsigned int nr_pages, bool allow_singleton)
+{
+	int filled;
+
+	if (nr_pages > TDX_PAGE_ARRAY_MAX_NENTS)
+		return NULL;
+
+	struct tdx_page_array *array __free(tdx_page_array_free) =
+		tdx_page_array_alloc(nr_pages, allow_singleton);
+	if (!array)
+		return NULL;
+
+	filled = tdx_page_array_fill_root(array, 0);
+	if (filled != nr_pages)
+		return NULL;
+
+	return no_free_ptr(array);
+}
+EXPORT_SYMBOL_GPL(tdx_page_array_create);
+
+/*
+ * Call this function when failed to reclaim the control pages. The root page
+ * and the holding structures can still be freed.
+ */
+void tdx_page_array_ctrl_leak(struct tdx_page_array *array)
+{
+	if (array->root)
+		__free_page(array->root);
+
+	kfree(array->pages);
+	kfree(array);
+}
+EXPORT_SYMBOL_GPL(tdx_page_array_ctrl_leak);
+
+static bool tdx_page_array_ctrl_match(struct tdx_page_array *array,
+				      unsigned int offset,
+				      unsigned int nr_released,
+				      u64 released_hpa)
+{
+	unsigned int nents;
+	u64 *entries;
+	int i;
+
+	if (offset >= array->nr_pages)
+		return 0;
+
+	nents = umin(array->nr_pages - offset, TDX_PAGE_ARRAY_MAX_NENTS);
+
+	if (nents != nr_released) {
+		pr_err("%s nr_released [%d] doesn't match page array nents [%d]\n",
+		       __func__, nr_released, nents);
+		return false;
+	}
+
+	if (!array->root) {
+		if (page_to_phys(array->pages[0]) != released_hpa) {
+			pr_err("%s released_hpa [0x%llx] doesn't match page0 hpa [0x%llx]\n",
+			       __func__, released_hpa,
+			       page_to_phys(array->pages[0]));
+			return false;
+		}
+
+		return true;
+	}
+
+	if (page_to_phys(array->root) != released_hpa) {
+		pr_err("%s released_hpa [0x%llx] doesn't match root page hpa [0x%llx]\n",
+		       __func__, released_hpa, page_to_phys(array->root));
+		return 0;
+	}
+
+	entries = (u64 *)page_address(array->root);
+	for (i = 0; i < nents; i++) {
+		if (page_to_phys(array->pages[offset + i]) != entries[i]) {
+			pr_err("%s entry[%d] [0x%llx] doesn't match page hpa [0x%llx]\n",
+			       __func__, i, entries[i],
+			       page_to_phys(array->pages[offset + i]));
+			return false;
+		}
+	}
+
+	return true;
+}
+
+/* For releasing control pages which are created by tdx_page_array_create() */
+int tdx_page_array_ctrl_release(struct tdx_page_array *array,
+				unsigned int nr_released,
+				u64 released_hpa)
+{
+	int i;
+	u64 r;
+
+	if (WARN_ON(array->nr_pages > TDX_PAGE_ARRAY_MAX_NENTS))
+		return -EINVAL;
+
+	if (WARN_ON(!tdx_page_array_ctrl_match(array, 0, nr_released,
+					       released_hpa)))
+		return -EFAULT;
+
+	for (i = 0; i < array->nr_pages; i++) {
+		r = tdh_phymem_page_wbinvd_hkid(tdx_global_keyid,
+						array->pages[i]);
+		if (WARN_ON(r))
+			return -EFAULT;
+	}
+
+	tdx_page_array_free(array);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_page_array_ctrl_release);
+
 static int read_sys_metadata_field(u64 field_id, u64 *data)
 {
 	struct tdx_module_args args = {};
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 5ebf26fcdcfa..f0a651155872 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -385,6 +385,8 @@ extern void free_pages(unsigned long addr, unsigned int order);
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr), 0)
 
+DEFINE_FREE(__free_page, struct page *, if (_T) __free_page(_T))
+
 void page_alloc_init_cpuhp(void);
 int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
-- 
2.51.0


