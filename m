Return-Path: <linux-pci+bounces-36487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD60B89DED
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25863B16F5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3EF313D75;
	Fri, 19 Sep 2025 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1d20k5a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74494313548
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291762; cv=none; b=tErofMVcCIQXSri38FvvmttiS+YXxtTZ1Ik02pgtKkdURYpZpSesxAh3pGCRzPFawW0E14AozwBZ04hGHiS95lPkstZ9qt0hgF1Zzl1vUlEOdCQ9tFw0qFNx8Xp/vafuut8RVVHcY5HGMaDlKlh0DRNmeaxYEsyRo8NUI1yRHow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291762; c=relaxed/simple;
	bh=Srxs1ek3tMOeN/uFoL0zHIWIGyW0isQgQ4lzPMfUA3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IE9Tf/8vXlaHfhBfWlY1EL8PUw4CCkUBxjBtyb46WLdU+1cOmxS6wK7Y84d1Zf0MJd++B4F/1DzKAlWaR8X7kyh5NuWV3q/8AYP7jedwOmZaE6uTMRcvc0eIF6uUuAzVsnYaYF7CFSWSMTB2SNoMB6BBJoGjQcmbehpsbZM35+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1d20k5a; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291760; x=1789827760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Srxs1ek3tMOeN/uFoL0zHIWIGyW0isQgQ4lzPMfUA3M=;
  b=h1d20k5aQMizndbJ7YRqWbFHGZxcwWJ2IwiegTYgCn1xEZ6D6L5vtpuL
   wuEhcPyDCFeg2bnd3wKBWkjCYfaYbm7uCC7MsWpwFA4BEfScuviqZXQqB
   Ee09kCDkUl5V9Qj1uyQsevl1908zSPs7iFcFr8KHb7gsAPXvJXKEjkl/B
   3oY+hCP/Qev94fL3kT9Q/CXIxsmp8hxTS4IhQB/gB3eOUjj++xS9MwTDg
   48VKf3X+X/y6NT9jnViqOqoe+eQQzX9LpifxMMljwrAQ6bjQ7KJzeehfF
   AQydu09DyVOICf9xAMHUT5uQPP5pQbF4uO8nqsl9ywE2Fsb20sqAkafqg
   w==;
X-CSE-ConnectionGUID: QutJ3SfwQKi+8L+KKtLRew==
X-CSE-MsgGUID: RraDlTeERVaFXJsnMyT/tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750518"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750518"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:37 -0700
X-CSE-ConnectionGUID: RVqlLIO0Q5KmmhynJUASIQ==
X-CSE-MsgGUID: rwinL5chS668REkKN49LgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655007"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 06/27] x86/virt/tdx: Add SEAMCALL wrappers for TDH.EXT.MEM.ADD and TDH.EXT.INIT
Date: Fri, 19 Sep 2025 07:22:15 -0700
Message-ID: <20250919142237.418648-7-dan.j.williams@intel.com>
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

Add the two SEAMCALLs for TDX Module Extension initialization.

TDH.EXT.MEM.ADD add pages to a shared memory pool for extensions to
consume. The number of pages required is published in the
MEMORY_POOL_REQUIRED_PAGES field from TDH.SYS.RD. Then on TDX.EXT.INIT, the
extensions consume from the pool and initialize.

TDH.EXT.MEM.ADD is the first user of tdx_page_array. It provides pages
to TDX Module as control (private) pages. A tdx_clflush_page_array()
helper is introduced to flush shared cache before SEAMCALL, to avoid
shared cache write back damages these private pages.

TDH.EXT.MEM.ADD uses HPA_LIST_INFO as parameter so could leverage the
'first_entry' field to simplify the interrupted - retry flow. Include
the retry handling in the wrapper so users don't have to care about
partial page adding and 'first_entry'.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/tdx.h  |  2 ++
 arch/x86/virt/vmx/tdx/tdx.c | 49 +++++++++++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h |  2 ++
 3 files changed, 53 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index fbd50df216af..1f1bcae46bb3 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -217,6 +217,8 @@ u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, u64 level, u64 *ext_err1, u6
 u64 tdh_phymem_cache_wb(bool resume);
 u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td);
 u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page);
+u64 tdh_ext_mem_add(struct tdx_page_array *pg_arr);
+u64 tdh_ext_init(void);
 #else
 static inline void tdx_init(void) { }
 static inline int tdx_enable(void)  { return -ENODEV; }
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index bc5b8e288546..d47b2612c816 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2110,3 +2110,52 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
 	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
 }
 EXPORT_SYMBOL_GPL(tdh_phymem_page_wbinvd_hkid);
+
+static void tdx_clflush_page_array(struct tdx_page_array *array)
+{
+	for (int i = 0; i < array->nents; i++)
+		tdx_clflush_page(array->pages[array->offset + i]);
+}
+
+union hpa_list_info {
+	struct {
+		u64 rsvd0:3;
+		u64 first_entry:9;
+		u64 hpa:40;
+		u64 rsvd1:3;
+		u64 last_entry:9;
+	};
+	u64 raw;
+};
+
+u64 tdh_ext_mem_add(struct tdx_page_array *pg_arr)
+{
+	union hpa_list_info info = { 0 };
+	struct tdx_module_args args = { 0 };
+	u64 r;
+	int i;
+
+	tdx_clflush_page_array(pg_arr);
+
+	info.raw = page_to_phys(pg_arr->root);
+	info.first_entry = 0;
+	info.last_entry = pg_arr->nents - 1;
+	args.rcx = info.raw;
+
+	for (i = TDX_SEAMCALL_RETRIES; i > 0; i--) {
+		r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
+		if (r != TDX_INTERRUPTED_RESUMABLE)
+			break;
+	}
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(tdh_ext_mem_add);
+
+u64 tdh_ext_init(void)
+{
+	struct tdx_module_args args = {};
+
+	return seamcall(TDH_EXT_INIT, &args);
+}
+EXPORT_SYMBOL_GPL(tdh_ext_init);
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index c641b4632826..e3b403846863 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -46,6 +46,8 @@
 #define TDH_PHYMEM_PAGE_WBINVD		41
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG			45
+#define TDH_EXT_INIT			60
+#define TDH_EXT_MEM_ADD			61
 
 /*
  * SEAMCALL leaf:
-- 
2.51.0


