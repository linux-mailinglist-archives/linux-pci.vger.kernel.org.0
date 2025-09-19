Return-Path: <linux-pci+bounces-36503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6501BB89E33
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D091C85555
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D6E315760;
	Fri, 19 Sep 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9yuI8j2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33D314D32
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291772; cv=none; b=Cz4x46D9ZhOD0X8zSDNa2mLxek1Bb5YFOco4Nvd9aMvw8V8T5qM3vm1spaHzWotta5o3z4edihGPXK5h3p15KYJ03/0sZB0ZUjeH342XXQkA9nltjHRvsJMgF8wIN6SKMXIvTqB9b4nNK3vgdVr0IrpGa+QNFzyBjRhN3HJpDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291772; c=relaxed/simple;
	bh=OlIfUyI5L28rdDke9Ose4fEBlJw7E73z/r9+1lrZ+f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTzJYqcQmo3/d0Sq/7qQrR/67q1Kdaw2jotXBx9nJSVOJMdyckx89jOj7FJXyrvOrNGOpvrUtruj4t11/nPmoAHRV1alFw14q6CUvdpJ3J+XlSn1M4soo/0fn4973VwgG911fV3rYFpnEQPRqVAoy271asdJ4L0MoD5ABuij1D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9yuI8j2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291771; x=1789827771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OlIfUyI5L28rdDke9Ose4fEBlJw7E73z/r9+1lrZ+f0=;
  b=C9yuI8j2cqdbhyD9wzEbkKF/Uj409sWP70AFZvhxTLFI5tNf0DYGfV4I
   rpDG9hg6RLjp7OYSIRR8fk9HSqkp+yUr9ZhVGaIGqSkz/0vls1nLxfbvZ
   ozvlK7OGRlF+XPoRwgvZD8hMD9W1aRPIDrrDHGeIYk2AiSxpTkC39RNQE
   +czjWrDvHp6BxGeO3mIEqmDXiUuOA3IkvlcQck0gHzfjsKSEcMDKL9EF7
   lepMWpxgshJifh7UvtZqxcFvFOUTkSmhzuxU19bda1U238KRUJ1HT+ACM
   iSzl4m3uuve+PWIk9dqA9GWN8+GZ6mXX8QpUEVT99j7Gvv+Bmg8xI2hlA
   w==;
X-CSE-ConnectionGUID: vr8g1tY8Q32EML3bRDemaw==
X-CSE-MsgGUID: 32o/upVsTreAyvbtzCXhHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750572"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750572"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:41 -0700
X-CSE-ConnectionGUID: Zhglm3MfTbGZzGM2suU//A==
X-CSE-MsgGUID: AVLfDwBWR524E0xGMMf/5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655059"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 22/27] coco/tdx-host: Implement SPDM session setup
Date: Fri, 19 Sep 2025 07:22:31 -0700
Message-ID: <20250919142237.418648-23-dan.j.williams@intel.com>
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

Implementation for a most straightforward SPDM session setup, using all
default session options. Retrieve device info data from TDX Module which
contains the SPDM negotiation results.

TDH.SPDM.CONNECT/DISCONNECT are TDX Module Extension introduced
SEAMCALLs which can run for longer periods and interruptible. But there
is resource constraints that limit how many SEAMCALLs of this kind can
run simultaneously. The current situation is One SEAMCALL at a time. [*]
Otherwise TDX_OPERAND_BUSY is returned. To avoid "broken indefinite"
retry, a tdx_ext_lock is used to guard these SEAMCALLs.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/tdx_errno.h      |   2 +
 drivers/virt/coco/tdx-host/tdx-host.c | 275 +++++++++++++++++++++++++-
 2 files changed, 276 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tdx_errno.h b/arch/x86/include/asm/tdx_errno.h
index 6a5f183cf119..86d011cb753e 100644
--- a/arch/x86/include/asm/tdx_errno.h
+++ b/arch/x86/include/asm/tdx_errno.h
@@ -27,6 +27,8 @@
 #define TDX_EPT_WALK_FAILED			0xC0000B0000000000ULL
 #define TDX_EPT_ENTRY_STATE_INCORRECT		0xC0000B0D00000000ULL
 #define TDX_METADATA_FIELD_NOT_READABLE		0xC0000C0200000000ULL
+#define TDX_SPDM_SESSION_KEY_REQUIRE_REFRESH	0xC0000F4500000000ULL
+#define TDX_SPDM_REQUEST			0xC0000F5700000000ULL
 
 /*
  * TDX module operand ID, appears in 31:0 part of error code as
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 0d052a1acf62..258539cf0cdf 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -16,6 +16,7 @@
 #include <linux/sysfs.h>
 #include <linux/tsm.h>
 #include <linux/device/faux.h>
+#include <linux/vmalloc.h>
 #include <asm/cpu_device_id.h>
 #include <asm/tdx.h>
 #include <asm/tdx_global_metadata.h>
@@ -36,8 +37,34 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
  */
 static const struct tdx_sys_info *tdx_sysinfo;
 
+#define TDISP_FUNC_ID		GENMASK(15, 0)
+#define TDISP_FUNC_ID_SEGMENT		GENMASK(23, 16)
+#define TDISP_FUNC_ID_SEG_VALID		BIT(24)
+
+static inline u32 tdisp_func_id(struct pci_dev *pdev)
+{
+	u32 func_id;
+
+	func_id = FIELD_PREP(TDISP_FUNC_ID_SEGMENT, pci_domain_nr(pdev->bus));
+	if (func_id)
+		func_id |= TDISP_FUNC_ID_SEG_VALID;
+	func_id |= FIELD_PREP(TDISP_FUNC_ID,
+			      PCI_DEVID(pdev->bus->number, pdev->devfn));
+
+	return func_id;
+}
+
 struct tdx_link {
 	struct pci_tsm_pf0 pci;
+	u32 func_id;
+	struct page *in_msg;
+	struct page *out_msg;
+
+	u64 spdm_id;
+	struct page *spdm_conf;
+	struct tdx_page_array *spdm_mt;
+	unsigned int dev_info_size;
+	void *dev_info_data;
 };
 
 static struct tdx_link *to_tdx_link(struct pci_tsm *tsm)
@@ -104,13 +131,218 @@ static int __maybe_unused tdx_spdm_msg_exchange(struct tdx_link *tlink,
 	return ret;
 }
 
+static int tdx_spdm_session_keyupdate(struct tdx_link *tlink);
+
+static int tdx_link_event_handler(struct tdx_link *tlink,
+				  u64 tdx_ret, u64 out_msg_sz)
+{
+	int ret;
+
+	if (tdx_ret == TDX_SUCCESS)
+		return 0;
+
+	if (tdx_ret == TDX_INTERRUPTED_RESUMABLE)
+		return -EAGAIN;
+
+	if (tdx_ret == TDX_SPDM_REQUEST) {
+		ret = tdx_spdm_msg_exchange(tlink,
+					    page_address(tlink->out_msg),
+					    out_msg_sz,
+					    page_address(tlink->in_msg),
+					    PAGE_SIZE);
+		if (ret < 0)
+			return ret;
+
+		return -EAGAIN;
+	}
+
+	if (tdx_ret == TDX_SPDM_SESSION_KEY_REQUIRE_REFRESH) {
+		/* keyupdate won't trigger this error again, no recursion risk */
+		ret = tdx_spdm_session_keyupdate(tlink);
+		if (ret)
+			return ret;
+
+		return -EAGAIN;
+	}
+
+	return -EFAULT;
+}
+
+/*
+ * Currently TDX Module extension introduced SEAMCALLs can't be executed in
+ * parallel and can fail with TDX_OPERAND_BUSY. Use a global mutex to serialize
+ * them.
+ */
+static DEFINE_MUTEX(tdx_ext_lock);
+
+enum tdx_spdm_mng_op {
+	TDX_SPDM_MNG_HEARTBEAT = 0,
+	TDX_SPDM_MNG_KEY_UPDATE = 1,
+	TDX_SPDM_MNG_RECOLLECT = 2,
+};
+
+static int tdx_spdm_session_mng(struct tdx_link *tlink,
+				enum tdx_spdm_mng_op op)
+{
+	u64 r, out_msg_sz;
+	int ret;
+
+	guard(mutex)(&tdx_ext_lock);
+	do {
+		r = tdh_spdm_mng(tlink->spdm_id, op, NULL, tlink->in_msg,
+				 tlink->out_msg, NULL, &out_msg_sz);
+		ret = tdx_link_event_handler(tlink, r, out_msg_sz);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
+static int tdx_spdm_session_keyupdate(struct tdx_link *tlink)
+{
+	return tdx_spdm_session_mng(tlink, TDX_SPDM_MNG_KEY_UPDATE);
+}
+
+static void *tdx_dup_array_data(struct tdx_page_array *array,
+				unsigned int data_size)
+{
+	unsigned int npages = (data_size + PAGE_SIZE - 1) / PAGE_SIZE;
+	void *data, *dup_data;
+
+	if (npages > array->nr_pages)
+		return NULL;
+
+	data = vm_map_ram(array->pages, npages, -1);
+	if (!data)
+		return NULL;
+
+	dup_data = kmemdup(data, data_size, GFP_KERNEL);
+	vm_unmap_ram(data, npages);
+
+	return dup_data;
+}
+
+static int tdx_spdm_session_connect(struct tdx_link *tlink,
+				    struct tdx_page_array *dev_info)
+{
+	u64 r, out_msg_sz;
+	int ret;
+
+	guard(mutex)(&tdx_ext_lock);
+	do {
+		r = tdh_spdm_connect(tlink->spdm_id, tlink->spdm_conf,
+				     tlink->in_msg, tlink->out_msg,
+				     dev_info, &out_msg_sz);
+		ret = tdx_link_event_handler(tlink, r, out_msg_sz);
+	} while (ret == -EAGAIN);
+
+	if (ret)
+		return ret;
+
+	tlink->dev_info_size = out_msg_sz;
+	return 0;
+}
+
+static void tdx_spdm_session_disconnect(struct tdx_link *tlink)
+{
+	u64 r, out_msg_sz;
+	int ret;
+
+	guard(mutex)(&tdx_ext_lock);
+	do {
+		r = tdh_spdm_disconnect(tlink->spdm_id, tlink->in_msg,
+					tlink->out_msg, &out_msg_sz);
+		ret = tdx_link_event_handler(tlink, r, out_msg_sz);
+	} while (ret == -EAGAIN);
+
+	WARN_ON(ret);
+
+	tlink->dev_info_size = 0;
+}
+
+static int tdx_spdm_create(struct tdx_link *tlink)
+{
+	unsigned int nr_pages = tdx_sysinfo->connect.spdm_mt_page_count;
+	u64 spdm_id, r;
+
+	struct tdx_page_array *spdm_mt __free(tdx_page_array_free) =
+		tdx_page_array_create(nr_pages, true);
+	if (!spdm_mt)
+		return -ENOMEM;
+
+	r = tdh_spdm_create(tlink->func_id, spdm_mt, &spdm_id);
+	if (r)
+		return -EFAULT;
+
+	tlink->spdm_id = spdm_id;
+	tlink->spdm_mt = no_free_ptr(spdm_mt);
+	return 0;
+}
+
+static void tdx_spdm_delete(struct tdx_link *tlink)
+{
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	unsigned int nr_released;
+	u64 released_hpa, r;
+
+	r = tdh_spdm_delete(tlink->spdm_id, tlink->spdm_mt, &nr_released, &released_hpa);
+	if (r) {
+		pci_err(pdev, "fail to delete spdm\n");
+		goto leak;
+	}
+
+	if (tdx_page_array_ctrl_release(tlink->spdm_mt, nr_released, released_hpa)) {
+		pci_err(pdev, "fail to release metadata pages\n");
+		goto leak;
+	}
+
+	goto out;
+
+leak:
+	tdx_page_array_ctrl_leak(tlink->spdm_mt);
+out:
+	tlink->spdm_mt = NULL;
+}
+
 static void tdx_spdm_session_teardown(struct tdx_link *tlink)
 {
+	kfree(tlink->dev_info_data);
+
+	if (tlink->dev_info_size)
+		tdx_spdm_session_disconnect(tlink);
+
+	if (tlink->spdm_mt)
+		tdx_spdm_delete(tlink);
 }
 
+DEFINE_FREE(tdx_spdm_session_teardown, struct tdx_link *, if (_T) tdx_spdm_session_teardown(_T))
+
 static int tdx_spdm_session_setup(struct tdx_link *tlink)
 {
-	return -EOPNOTSUPP;
+	unsigned int nr_pages = tdx_sysinfo->connect.spdm_max_dev_info_pages;
+	int ret;
+
+	struct tdx_link *__tlink __free(tdx_spdm_session_teardown) = tlink;
+	ret = tdx_spdm_create(tlink);
+	if (ret)
+		return ret;
+
+	struct tdx_page_array *dev_info __free(tdx_page_array_free) =
+		tdx_page_array_create(nr_pages, true);
+	if (!dev_info)
+		return -ENOMEM;
+
+	ret = tdx_spdm_session_connect(tlink, dev_info);
+	if (ret)
+		return ret;
+
+	tlink->dev_info_data = tdx_dup_array_data(dev_info,
+						  tlink->dev_info_size);
+	if (!tlink->dev_info_data)
+		return -ENOMEM;
+
+	tlink = no_free_ptr(__tlink);
+
+	return 0;
 }
 
 static void tdx_ide_stream_teardown(struct tdx_link *tlink)
@@ -160,11 +392,26 @@ static void tdx_link_disconnect(struct pci_dev *pdev)
 	__tdx_link_disconnect(tlink);
 }
 
+struct spdm_config_info_t {
+	u32 vmm_spdm_cap;
+#define SPDM_CAP_HBEAT          BIT(13)
+#define SPDM_CAP_KEY_UPD        BIT(14)
+	u8 spdm_session_policy;
+	u8 certificate_slot_mask;
+	u8 raw_bitstream_requested;
+	u8 reserved[];
+} __packed;
+
 static struct pci_tsm_ops tdx_link_ops;
 
 static struct pci_tsm *tdx_link_pf0_probe(struct tsm_dev *tsm_dev,
 					  struct pci_dev *pdev)
 {
+	const struct spdm_config_info_t spdm_config_info = {
+		/* use a default configuration, may require user input later */
+		.vmm_spdm_cap = SPDM_CAP_KEY_UPD,
+		.certificate_slot_mask = 0xff,
+	};
 	int rc;
 
 	struct tdx_link *tlink __free(kfree) =
@@ -176,6 +423,29 @@ static struct pci_tsm *tdx_link_pf0_probe(struct tsm_dev *tsm_dev,
 	if (rc)
 		return NULL;
 
+	tlink->func_id = tdisp_func_id(pdev);
+
+	struct page *in_msg_page __free(__free_page) =
+		alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!in_msg_page)
+		return NULL;
+
+	struct page *out_msg_page __free(__free_page) =
+		alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!out_msg_page)
+		return NULL;
+
+	struct page *spdm_conf __free(__free_page) =
+		alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!spdm_conf)
+		return NULL;
+
+	memcpy(page_address(spdm_conf), &spdm_config_info, sizeof(spdm_config_info));
+
+	tlink->in_msg = no_free_ptr(in_msg_page);
+	tlink->out_msg = no_free_ptr(out_msg_page);
+	tlink->spdm_conf = no_free_ptr(spdm_conf);
+
 	return &no_free_ptr(tlink)->pci.base_tsm;
 }
 
@@ -183,6 +453,9 @@ static void tdx_link_pf0_remove(struct pci_tsm *tsm)
 {
 	struct tdx_link *tlink = to_tdx_link(tsm);
 
+	__free_page(tlink->in_msg);
+	__free_page(tlink->out_msg);
+	__free_page(tlink->spdm_conf);
 	pci_tsm_pf0_destructor(&tlink->pci);
 	kfree(tlink);
 }
-- 
2.51.0


