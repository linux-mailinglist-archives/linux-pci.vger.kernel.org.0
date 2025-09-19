Return-Path: <linux-pci+bounces-36485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F18B89DEC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF9F1C82F99
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE1230B52E;
	Fri, 19 Sep 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhwlO7KJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90DA310635
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291761; cv=none; b=fwoiO3hyWXhWntz/x4YcCEnGw6e6dd5cZhPa97lnwMH0ockKYLoH5Lt2yNp4PAWjQY+fVMlHIrnul/uEzA+RYFJDFbnO6iIT9lB5k4Z7eek5oihSc2bwGwv12yMAQUtdlbxqkqUYd3iC38+NAq/W2v6qFaY3pWdLFDos0a59X7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291761; c=relaxed/simple;
	bh=g9IjPxPsON+SaT2tgVjDAwkg4e10sRFKLEmmIkbX7vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2MlClLV3hrHrhrZYQ4BXaCsjY+59k2au59ooM96hIhTHPGbrkBYtzEbtguCdWmF/pT2jX8gnV1UBENm/Gx1/YPuAcX7uMShvwteNdHKn8Ft13EdJcnbfbkl9kLKAPceCWQY/szC3NtQf4yHKXAs8iI5juppvO94N40+aeuZgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhwlO7KJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291759; x=1789827759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g9IjPxPsON+SaT2tgVjDAwkg4e10sRFKLEmmIkbX7vI=;
  b=YhwlO7KJXmawTv1ye6XeI0++x10hA1DHHvfvnKJJGmx5fbfgEZlnQOsV
   MaUhJoiI6w+vnZaMweLggTYPDhQEIY/+4rjrUsXE/eKEPXJTirXwPfJoZ
   RIYmxk7YDmnCSKk5gT8WZHmrnzMOMCv+YYi8L6kbsgXOvM6gS4Cvv7GNM
   0ZNxeLJUK5sofRUj3d3NpQ0H0tXvH9mnvutTieGV9cGo79mze/9A3mDA/
   aDkZ/RM7eNzIhxhJIiiOlk+z8eXHGh5mCywYVqZeFOHP5XExl9QujVzzV
   UTtWrVEpTFxROZ/t1NCC0GQbRp4jEJDDJt0DqTauHGde03O/SZzZEZthi
   w==;
X-CSE-ConnectionGUID: G6kQSeV+QGWobFub4VBV4Q==
X-CSE-MsgGUID: FGLwdCvXSo2wS9f2Cl5/qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750511"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750511"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:36 -0700
X-CSE-ConnectionGUID: ok/mXfMMR2uslYY79CEtrA==
X-CSE-MsgGUID: XMRJr6tiT0KFbaov/MqIXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176654999"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 04/27] x86/virt/tdx: Move tdx_errno.h from KVM to public place
Date: Fri, 19 Sep 2025 07:22:13 -0700
Message-ID: <20250919142237.418648-5-dan.j.williams@intel.com>
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

Move these TDX Module defined error code from KVM to public place.

SEAMCALL helpers (defined in TDX core, tdh_*()) returns these error code
to kernel users. It is reasonable to also public the definitions of each
error code. TDX core itself will use these error code when enabling
optional features (e.g. TDX Module extensions). TDX Connect will also use
them in tdx-host module.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/tdx.h                    | 1 +
 arch/x86/{kvm/vmx => include/asm}/tdx_errno.h | 6 +++---
 arch/x86/kvm/vmx/tdx.h                        | 1 -
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/x86/{kvm/vmx => include/asm}/tdx_errno.h (93%)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 166795e34c8f..732e1e7fd556 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -10,6 +10,7 @@
 #include <asm/errno.h>
 #include <asm/ptrace.h>
 #include <asm/trapnr.h>
+#include <asm/tdx_errno.h>
 #include <asm/shared/tdx.h>
 
 /*
diff --git a/arch/x86/kvm/vmx/tdx_errno.h b/arch/x86/include/asm/tdx_errno.h
similarity index 93%
rename from arch/x86/kvm/vmx/tdx_errno.h
rename to arch/x86/include/asm/tdx_errno.h
index 6ff4672c4181..6a5f183cf119 100644
--- a/arch/x86/kvm/vmx/tdx_errno.h
+++ b/arch/x86/include/asm/tdx_errno.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* architectural status code for SEAMCALL */
 
-#ifndef __KVM_X86_TDX_ERRNO_H
-#define __KVM_X86_TDX_ERRNO_H
+#ifndef __ASM_X86_TDX_ERRNO_H
+#define __ASM_X86_TDX_ERRNO_H
 
 #define TDX_SEAMCALL_STATUS_MASK		0xFFFFFFFF00000000ULL
 
@@ -37,4 +37,4 @@
 #define TDX_OPERAND_ID_SEPT			0x92
 #define TDX_OPERAND_ID_TD_EPOCH			0xa9
 
-#endif /* __KVM_X86_TDX_ERRNO_H */
+#endif /* __ASM_X86_TDX_ERRNO_H */
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index ca39a9391db1..f4e609a745ee 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -3,7 +3,6 @@
 #define __KVM_X86_VMX_TDX_H
 
 #include "tdx_arch.h"
-#include "tdx_errno.h"
 
 #ifdef CONFIG_KVM_INTEL_TDX
 #include "common.h"
-- 
2.51.0


