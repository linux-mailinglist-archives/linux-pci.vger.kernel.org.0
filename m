Return-Path: <linux-pci+bounces-36483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F05B89DEA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FF256210F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D5C313298;
	Fri, 19 Sep 2025 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDjh8UT2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB923112D6
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291759; cv=none; b=rI9UDHkEDMu5qdQ63yrijh9Mm/tMgLMzDSv5hIj96RJPCy+2KGxGWiJi8Os7YqoJ/PVjyzj0xz0pAMT0OZ8QWxjsfgsv1hcndwU1Zfj17O6Ey96WASvBk6F+uynpdMQKRd8B9YQsM9sAoa/ul8oHmpV6+s6eiE+kyZ5KdP60fEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291759; c=relaxed/simple;
	bh=72TZ4VpZjnjV5omSYix6Q/pWpfm0uSkLtsEgwzM6Hz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHNYggW7uryeo0S9KwXVdjUgEXaIDoLf4d3r07nwQfCNe/0KH1QD5u5uujtY6KVTyJNHYjN8B6a+yg8rIy+OuJtbzIYm4nq+kVLOZ9udu3J8hC+9BliFVJT8xD3zJ9b47Ig/cyC2UQf5WW5ccio86TXEyObJcMLzdqIM4v4gRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDjh8UT2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291758; x=1789827758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=72TZ4VpZjnjV5omSYix6Q/pWpfm0uSkLtsEgwzM6Hz4=;
  b=WDjh8UT2r6O2Ao+iHjT7IvRu3EStERkYLc38E09amkWbu5uS3hC+3+hG
   YHhSdemC9Vh+UnWbUGLXtcDl40JpitWKfgyFhkYAeP5Tr0yS21cZMKhu4
   +lemBfVIOU2C+aJYAhv0lReIXYpN3oSWCRpHyakzSjVb9moViCZBBJTxv
   jfFRJwnOoV4b8WTdFp8+FKbgpEBYKfHtAfBGUXQGGErVb02A+cDg2sH9L
   QDxt4sIZI8vJtUMW6g1Wcr0jUGiZw7s2CNwZVo7U3ZHJxUfKp+t52WNZY
   r0XUFwfLA1FVmaQvxdNBn8RDizjteEVAVyB7/aNvEYaJHBS/lTuwp1K3t
   w==;
X-CSE-ConnectionGUID: FbhVCW03QtiXvGqpJaL2hQ==
X-CSE-MsgGUID: wFlCezN+RfeyO2BNMdjE3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750503"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750503"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:36 -0700
X-CSE-ConnectionGUID: QH/VITypRFOUFp/djqPUUg==
X-CSE-MsgGUID: 6ICbZjIeQreBJmwNAbJ+8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176654993"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 02/27] x86/virt/tdx: Move bit definitions of TDX_FEATURES0 to public header
Date: Fri, 19 Sep 2025 07:22:11 -0700
Message-ID: <20250919142237.418648-3-dan.j.williams@intel.com>
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

Move bit definitions of TDX_FEATURES0 to TDX core public header.

Kernel users get TDX_FEATURE0 bitmap via tdx_get_sysinfo(). It is
reasonable to also public the definitions of each bit. TDX Connect
will add new bits and check them in tdx-host module.

Take the oppotunity to change its type to BIT_ULL cause tdx_features0
is explicitly defined as 64 bit in both TDX Module Specification and
TDX core code.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/tdx.h  | 4 ++++
 arch/x86/virt/vmx/tdx/tdx.h | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index cbea169b5fa0..4ce3a302d9ba 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -124,6 +124,10 @@ static __always_inline u64 sc_retry(sc_func_t func, u64 fn,
 #define seamcall_saved_ret(_fn, _args)	sc_retry(__seamcall_saved_ret, (_fn), (_args))
 int tdx_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
+
+/* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
+
 const struct tdx_sys_info *tdx_get_sysinfo(void);
 
 int tdx_guest_keyid_alloc(void);
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 82bb82be8567..c641b4632826 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -84,9 +84,6 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
-/* Bit definitions of TDX_FEATURES0 metadata field */
-#define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
-
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
-- 
2.51.0


