Return-Path: <linux-pci+bounces-36490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD2B89E00
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906A11C83862
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265BA313D62;
	Fri, 19 Sep 2025 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e91wQdgL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C885313D78
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291764; cv=none; b=Rd9+tcI7Bm6+bO6wLB+d+dNNh0GwnYb5eb45fi10sL08mrfRDcUvuv2WsJs8m7ueoaJOqw13T2L7sk8t2rsXqRiSByxPawPqC4nsgt3wufpQaRIRdMyizl7raZDVteQEn0sq5JR4rOl0fwnFs8Dme3aTIsQ6evAL46IZLzbfTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291764; c=relaxed/simple;
	bh=jZOza2OU4TECo/CUJpLkglSOwD7pcNmDSRnYDyrqlj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/M+fE75d55Ut7fFJ2pwmQmo/jwyjphCLlViOKS7o7F833sfURfnH4qlZkyZnl6fhC3m+CznVv5OcmREfV3miZ+EuV+uunzx3E4VVN5PIVYxrgZCTkyq97yCIeQ6VcF7mVV4VMaMoTgR48V6r1TIzBxTpZpFeYAq9K8JLe7o1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e91wQdgL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291762; x=1789827762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jZOza2OU4TECo/CUJpLkglSOwD7pcNmDSRnYDyrqlj4=;
  b=e91wQdgL5grCiqnHlQiBYBzD18sOmIOlDN2G0N5FqZ4zWdmzo/ALVMb+
   qgYGFlDnyJs2MNq+QNDK7Hg7FXL5w3p2cNZ9CWFGZDnpZ479Nl1bMnUvH
   J356zeMtW8OAJcBeGt8mO0UcCG05hiBpzAQR4D/xoWb8D2A4JbUKVrXlc
   BT7I4UkbKUKTmv7kjoPv9JmgyvdHq+y0ZFBdVSmZvnWGAfw9WH0JsGlLR
   2BluKQcVpiXj98tbrlR4xGU0bfZqSzEtCGuwYwsNTy2Av2fSn4obc/sPY
   zefaTuYXwtIvAH6oEvS+GntcYWtkl2+4ETEBhV6hsARr5hxVFSQ7OTGxu
   g==;
X-CSE-ConnectionGUID: g/RCXQu0TvymAxlKmdfTEQ==
X-CSE-MsgGUID: 9W+AP2Q+SgaAowRrz/aToA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750525"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750525"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:38 -0700
X-CSE-ConnectionGUID: OTo44XKcS5Glu3h9NYGcLg==
X-CSE-MsgGUID: wrJs6IQ3RviN+xitzCgOtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655014"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH 08/27] x86/virt/tdx: Add tdx_enable_ext() to enable of TDX Module Extensions
Date: Fri, 19 Sep 2025 07:22:17 -0700
Message-ID: <20250919142237.418648-9-dan.j.williams@intel.com>
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

tdx_enable() implements a simple state machine with @tdx_module_status to
determine if TDX is already enabled, or failed to enable. Add another state
to that enum (TDX_MODULE_INITIALIZED_EXT) to track if extensions have been enabled.

The extension initialization uses the new TDH.EXT.MEM.ADD and TDX.EXT.INIT
seamcalls.

Note that this extension initialization does not impact existing in-flight
SEAMCALLs that are not implemented by the extension. So only the first user
of an extension-seamcall needs invoke this helper.

Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/tdx.h            |   3 +
 arch/x86/virt/vmx/tdx/tdx.c           | 152 ++++++++++++++++++++++++--
 arch/x86/virt/vmx/tdx/tdx.h           |   1 +
 drivers/virt/coco/tdx-host/tdx-host.c |   7 ++
 4 files changed, 155 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 1f1bcae46bb3..d53260aadb0b 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -124,11 +124,13 @@ static __always_inline u64 sc_retry(sc_func_t func, u64 fn,
 #define seamcall_ret(_fn, _args)	sc_retry(__seamcall_ret, (_fn), (_args))
 #define seamcall_saved_ret(_fn, _args)	sc_retry(__seamcall_saved_ret, (_fn), (_args))
 int tdx_enable(void);
+int tdx_enable_ext(void);
 const char *tdx_dump_mce_info(struct mce *m);
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
 #define TDX_FEATURES0_TDXCONNECT	BIT_ULL(6)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
+#define TDX_FEATURES0_EXT		BIT_ULL(39)
 
 const struct tdx_sys_info *tdx_get_sysinfo(void);
 
@@ -222,6 +224,7 @@ u64 tdh_ext_init(void);
 #else
 static inline void tdx_init(void) { }
 static inline int tdx_enable(void)  { return -ENODEV; }
+static inline int tdx_enable_ext(void) { return -ENODEV; }
 static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
 static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
 static inline const struct tdx_sys_info *tdx_get_sysinfo(void) { return NULL; }
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index d47b2612c816..9d4cebace054 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -122,9 +122,13 @@ static int try_init_module_global(void)
 	if (sysinit_done)
 		goto out;
 
-	/* RCX is module attributes and all bits are reserved */
-	args.rcx = 0;
+	/* TODO: Replace try/fail with new feature enumeration capability */
+	args.rcx = TDX_FEATURES0_TDXCONNECT | TDX_FEATURES0_EXT;
 	sysinit_ret = seamcall_prerr(TDH_SYS_INIT, &args);
+	if (sysinit_ret) {
+		args.rcx = 0;
+		sysinit_ret = seamcall_prerr(TDH_SYS_INIT, &args);
+	}
 
 	/*
 	 * The first SEAMCALL also detects the TDX module, thus
@@ -1443,6 +1447,7 @@ int tdx_enable(void)
 		ret = __tdx_enable();
 		break;
 	case TDX_MODULE_INITIALIZED:
+	case TDX_MODULE_INITIALIZED_EXT:
 		/* Already initialized, great, tell the caller. */
 		ret = 0;
 		break;
@@ -1456,6 +1461,139 @@ int tdx_enable(void)
 }
 EXPORT_SYMBOL_GPL(tdx_enable);
 
+static int enable_tdx_ext(void)
+{
+	u64 r;
+
+	if (!tdx_sysinfo.ext.ext_required)
+		return 0;
+
+	do {
+		r = tdh_ext_init();
+	} while (r == TDX_INTERRUPTED_RESUMABLE);
+
+	if (r != TDX_SUCCESS)
+		return -EFAULT;
+
+	return 0;
+}
+
+static void tdx_ext_mempool_free(struct tdx_page_array *mempool)
+{
+	/*
+	 * Some pages may have been touched by the TDX module.
+	 * Flush cache before returning these pages to kernel.
+	 */
+	wbinvd_on_all_cpus();
+
+	tdx_page_array_free(mempool);
+}
+
+DEFINE_FREE(tdx_ext_mempool_free, struct tdx_page_array *, if (!IS_ERR_OR_NULL(_T)) tdx_ext_mempool_free(_T))
+
+static struct tdx_page_array *tdx_ext_mempool_setup(void)
+{
+	unsigned int nr_pages, nents, offset = 0;
+	u64 tdx_ret;
+
+	nr_pages = tdx_sysinfo.ext.memory_pool_required_pages;
+	if (!nr_pages)
+		return NULL;
+
+	struct tdx_page_array *mempool __free(tdx_page_array_free) =
+		tdx_page_array_alloc(nr_pages, false);
+	if (!mempool)
+		return ERR_PTR(-ENOMEM);
+
+	while (1) {
+		nents = tdx_page_array_fill_root(mempool, offset);
+		if (!nents)
+			break;
+
+		tdx_ret = tdh_ext_mem_add(mempool);
+		if (tdx_ret != TDX_SUCCESS)
+			return ERR_PTR(-EFAULT);
+
+		offset += nents;
+	}
+
+	return no_free_ptr(mempool);
+}
+
+static int init_tdx_ext(void)
+{
+	int ret;
+
+	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
+		return -EOPNOTSUPP;
+
+	struct tdx_page_array *mempool __free(tdx_ext_mempool_free) =
+		tdx_ext_mempool_setup();
+	/* Return NULL is OK, means no need to setup mempool */
+	if (IS_ERR(mempool))
+		return PTR_ERR(mempool);
+
+	ret = enable_tdx_ext();
+	if (ret)
+		return ret;
+
+	/* Extension memory is never reclaimed once assigned */
+	if (mempool)
+		tdx_page_array_ctrl_leak(no_free_ptr(mempool));
+
+	return 0;
+}
+
+static int __tdx_enable_ext(void)
+{
+	int ret;
+
+	ret = init_tdx_ext();
+	if (ret) {
+		pr_debug("module extension initialization failed (%d)\n", ret);
+		tdx_module_status = TDX_MODULE_ERROR;
+		return ret;
+	}
+
+	pr_debug("module extension initialized\n");
+	tdx_module_status = TDX_MODULE_INITIALIZED_EXT;
+
+	return 0;
+}
+
+/**
+ * tdx_enable_ext - Enable TDX module extensions.
+ *
+ * This function assumes the caller has done VMXON.
+ *
+ * This function can be called in parallel by multiple callers.
+ *
+ * Return 0 if TDX module extension is enabled successfully, otherwise error.
+ */
+int tdx_enable_ext(void)
+{
+	int ret;
+
+	mutex_lock(&tdx_module_lock);
+
+	switch (tdx_module_status) {
+	case TDX_MODULE_INITIALIZED:
+		ret = __tdx_enable_ext();
+		break;
+	case TDX_MODULE_INITIALIZED_EXT:
+		ret = 0;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&tdx_module_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tdx_enable_ext);
+
 static bool is_pamt_page(unsigned long phys)
 {
 	struct tdmr_info_list *tdmr_list = &tdx_tdmr_list;
@@ -1709,7 +1847,8 @@ const struct tdx_sys_info *tdx_get_sysinfo(void)
 
 	/* Make sure all fields in @tdx_sysinfo have been populated */
 	mutex_lock(&tdx_module_lock);
-	if (tdx_module_status == TDX_MODULE_INITIALIZED)
+	if (tdx_module_status == TDX_MODULE_INITIALIZED ||
+	    tdx_module_status == TDX_MODULE_INITIALIZED_EXT)
 		p = (const struct tdx_sys_info *)&tdx_sysinfo;
 	mutex_unlock(&tdx_module_lock);
 
@@ -2133,7 +2272,6 @@ u64 tdh_ext_mem_add(struct tdx_page_array *pg_arr)
 	union hpa_list_info info = { 0 };
 	struct tdx_module_args args = { 0 };
 	u64 r;
-	int i;
 
 	tdx_clflush_page_array(pg_arr);
 
@@ -2142,11 +2280,9 @@ u64 tdh_ext_mem_add(struct tdx_page_array *pg_arr)
 	info.last_entry = pg_arr->nents - 1;
 	args.rcx = info.raw;
 
-	for (i = TDX_SEAMCALL_RETRIES; i > 0; i--) {
+	do {
 		r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
-		if (r != TDX_INTERRUPTED_RESUMABLE)
-			break;
-	}
+	} while (r == TDX_INTERRUPTED_RESUMABLE);
 
 	return r;
 }
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index e3b403846863..f4bcfec7fb86 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -95,6 +95,7 @@ struct tdmr_info {
 enum tdx_module_status_t {
 	TDX_MODULE_UNINITIALIZED,
 	TDX_MODULE_INITIALIZED,
+	TDX_MODULE_INITIALIZED_EXT,
 	TDX_MODULE_ERROR
 };
 
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 41813ba352d0..2411c7d34b6b 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -131,6 +131,7 @@ static void unregister_link_tsm(void *data)
 static int tdx_connect_init(struct device *dev)
 {
 	struct tsm_dev *link;
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_TDX_CONNECT))
 		return 0;
@@ -142,6 +143,12 @@ static int tdx_connect_init(struct device *dev)
 	if (!(tdx_sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
 		return 0;
 
+	ret = tdx_enable_ext();
+	if (ret) {
+		dev_dbg(dev, "Enable extension failed\n");
+		return ret;
+	}
+
 	link = tsm_register(dev, &tdx_link_ops);
 	if (IS_ERR(link)) {
 		dev_err(dev, "failed to register TSM: (%pe)\n", link);
-- 
2.51.0


