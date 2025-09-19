Return-Path: <linux-pci+bounces-36488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E122B89E0C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04CF563DC4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABAD313E31;
	Fri, 19 Sep 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzDuq716"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2C313D62
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291763; cv=none; b=cZB+6NmFT64drSCyxKfKgUPDv64gdjukBkbPrjRlYGds3aafihP1yEn/L4uFOznuiiqnEpC+ArKj3FqizXyLHinO0S96hl/OiQnVFqVnjEhcS0LsRU0qi6wTWc9Tq+lEkZxyFsEBVYgFnMyUUtyW/q/pQHv1Gjqur7dhVIuRgYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291763; c=relaxed/simple;
	bh=saISOgy/aY12ahSOh6X8gb4rifF/7Y+GG05FwdQ7B30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNzgjyo1Ge6nvCINpcFq06xFSWfHhrPBNn3dDALJkf3mAMy2mCGCymATQVQiEIEg5jrYbapBsApZi/yffULbEneL/c26t/whHsSPF4pG/nt65q3EyOPp+0gk46lN1yuEWM4Wp2RkLrSImdP0TLrsfnWy8N66O56ye8VKUvDfdZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzDuq716; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291761; x=1789827761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=saISOgy/aY12ahSOh6X8gb4rifF/7Y+GG05FwdQ7B30=;
  b=AzDuq716TW4lOQABTKdCag8UUNrOvle5LbCP0Rw8Z1yWGd3dSeK4RRCV
   Jqc3V37cMhaSYaG361ou3abBhYO0aVTKzhL/qR5H2q28TlRk8eWQwtCpD
   rYr16OthsN/EChOB4NVEjwvos9LzQTRta/m4T2+Fwd68zhKzBM53dRZ93
   AF8AUqvK3kXSB2JCt2r2a0IaWCI3ZYsopq7w5kP6ZFIe3PIAJeCxro4Dq
   RfMjLGeQlcoXSJJpzvf+Khw/9/WvZdyFje5uy7QDwORkgZgK3404a179T
   mrhYjuCoiF0ryNQDZ3UqwPA0XbK+Drihi5RwtE2D4hOghxHHvh2Nc7IOv
   A==;
X-CSE-ConnectionGUID: h8JVY7d3Ttq8gQi2D22KLQ==
X-CSE-MsgGUID: aLe5ZkycSEmz5LeSJp0TAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750522"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750522"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:37 -0700
X-CSE-ConnectionGUID: S94gtCVEQMKJAUMFEzcR8w==
X-CSE-MsgGUID: TqZdYQRRTZC/6DUTGycz/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655010"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 07/27] TODO: x86/virt/tdx: Read TDX global metadata for TDX Module Extensions
Date: Fri, 19 Sep 2025 07:22:16 -0700
Message-ID: <20250919142237.418648-8-dan.j.williams@intel.com>
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

Add the global metadata for TDX core to enable extensions. They are:

 - "memory_pool_required_pages"
   Specify the required number of memory pool pages for the present
   extensions.

 - "ext_required"
   Specify if TDX.EXT.INIT is required.

Note for these 2 fields, a value of 0 doesn't mean extensions are not
supported.  It means no need to call TDX.EXT.MEM.ADD or TDX.EXT.INIT.

----
TODO: This patch should be auto-generated by script but for now the TDX
Connect part is not published in global_metadata.json so make the patch
manually. The correct way should be:

The code change is auto-generated by re-running the script in [1] after
uncommenting the "td_conf" and "td_ctrl" part to regenerate the
tdx_global_metadata.{hc} and update them to the existing ones in the
kernel.

  #python tdx.py global_metadata.json tdx_global_metadata.h \
        tdx_global_metadata.c

The 'global_metadata.json' can be fetched from [1].

Link: https://cdrdv2.intel.com/v1/dl/getContent/795381 [1]
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/tdx_global_metadata.h  |  6 ++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 060a2ad744bf..2aa741190b93 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -34,11 +34,17 @@ struct tdx_sys_info_td_conf {
 	u64 cpuid_config_values[128][2];
 };
 
+struct tdx_sys_info_ext {
+	u16 memory_pool_required_pages;
+	u8 ext_required;
+};
+
 struct tdx_sys_info {
 	struct tdx_sys_info_features features;
 	struct tdx_sys_info_tdmr tdmr;
 	struct tdx_sys_info_td_ctrl td_ctrl;
 	struct tdx_sys_info_td_conf td_conf;
+	struct tdx_sys_info_ext ext;
 };
 
 #endif
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 13ad2663488b..69be16c1e6ec 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -85,6 +85,19 @@ static int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_td_conf
 	return ret;
 }
 
+static int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
+{
+	int ret = 0;
+	u64 val;
+
+	if (!ret && !(ret = read_sys_metadata_field(0x3100000100000000, &val)))
+		sysinfo_ext->memory_pool_required_pages = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x3100000100000001, &val)))
+		sysinfo_ext->ext_required = val;
+
+	return ret;
+}
+
 static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
 	int ret = 0;
@@ -93,6 +106,7 @@ static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
 	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
 	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
+	ret = ret ?: get_tdx_sys_info_ext(&sysinfo->ext);
 
 	return ret;
 }
-- 
2.51.0


