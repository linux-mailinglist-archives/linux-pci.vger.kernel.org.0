Return-Path: <linux-pci+bounces-22812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59737A4D4AE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DAD189AEE9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0111FBCA1;
	Tue,  4 Mar 2025 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJk2Xd8O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D238E1F666B
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072469; cv=none; b=AtyxCadp+CtTzjt9Jplog+rXfSJyY5BYIf3uG+DUvVYuDYMgwBLsTrunQX+O9PfwccU98WAqakFAO0JJUgGZ+cs6NE+7/IsR92ZZbiYz3+svlwt3oNGXiS8pNYPxo5N7e9LdISqARUQjt9fw3ZBaERDLFkr8gXqLkwWvOQO/JXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072469; c=relaxed/simple;
	bh=cxrLZ2/18pEvKe1uAi2YT+TyrD5ziAEkEVKwG75MW/8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILoadMwvl0yvfiunVuQT39yrv27NMkRZiHErUSI5m6bbgqHNYr7gRcEV1EVxyYyHHKA4MlFWkrIW6ZdfNt4x/k13TA4UWy5omyDGBz+zilbOyTS+l7LORegCMRisgsuQ7jgGOGBzueLzF1wOSUDKiWak4fLcN8ScztPCqtEnznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJk2Xd8O; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741072468; x=1772608468;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cxrLZ2/18pEvKe1uAi2YT+TyrD5ziAEkEVKwG75MW/8=;
  b=aJk2Xd8O3n7tOEsBHuBihf+EZ4jPd/oOVo/KiZryTfe114infW5r5SHb
   YQ9K9Ngp0HiJOGPUgZbaMkY6FN7rEe29ZOy9FeFHRPkUrPhWppeq1S0wj
   kWVXv2AlPN+ksmDMgtbDBecmvwA/LVUMKpjCCCuQWlMu3QQhcfNYSfQMu
   Lrh/VakaIdCtJIB18mfwVjkRxITYzXakZyFGxyZnKCicXLSk7lqoFW7T/
   Mmfrizjh8rZOTyCZ9wowIZSfaNHDG0Mg+rwdrusjZ6yTSTV3riuT/Dw1v
   ZP+PJzZYQYvjzAUcipqyAkTDXa4wsBAxn8n9L2xSws1mvQVeKPBb6hKFt
   Q==;
X-CSE-ConnectionGUID: ZuKs03mjQxOuuDvg1rTFrw==
X-CSE-MsgGUID: hKX73qiwRaWwNZDRAxc0Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="29565102"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="29565102"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:14:28 -0800
X-CSE-ConnectionGUID: nq2w/vTAQC6JQEh18ET36Q==
X-CSE-MsgGUID: XVwYco9IQ8u0+XaKQgAg3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="122905505"
Received: from inaky-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.47])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:14:27 -0800
Subject: [PATCH v2 02/11] coco/guest: Move shared guest CC infrastructure to
 drivers/virt/coco/guest/
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Alexey Kardashevskiy <aik@amd.com>, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, aik@amd.com, lukas@wunner.de
Date: Mon, 03 Mar 2025 23:14:26 -0800
Message-ID: <174107246641.1288555.208426916259466774.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In preparation for creating a new drivers/virt/coco/host/ directory to
house shared host driver infrastructure for confidential computing, move
configfs-tsm to a guest/ sub-directory. The tsm.ko module is renamed to
tsm_reports.ko. The old tsm.ko module was only ever demand loaded by
kernel internal dependencies, so it should not affect existing userspace
module install scripts.

The new drivers/virt/coco/guest/ is also a preparatory landing spot for
new / optional TSM Report mechanics like a TCB stability enumeration /
watchdog mechanism. To be added later.

Cc: Wu Hao <hao.wu@intel.com>
Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 MAINTAINERS                      |    2 +-
 drivers/virt/coco/Kconfig        |    6 ++----
 drivers/virt/coco/Makefile       |    2 +-
 drivers/virt/coco/guest/Kconfig  |    7 +++++++
 drivers/virt/coco/guest/Makefile |    3 +++
 drivers/virt/coco/guest/report.c |    0 
 6 files changed, 14 insertions(+), 6 deletions(-)
 create mode 100644 drivers/virt/coco/guest/Kconfig
 create mode 100644 drivers/virt/coco/guest/Makefile
 rename drivers/virt/coco/{tsm.c => guest/report.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38bcf530c2ae..6a1d705c8eac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24116,7 +24116,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm-report
-F:	drivers/virt/coco/tsm.c
+F:	drivers/virt/coco/guest/
 F:	include/linux/tsm.h
 
 TRUSTED SERVICES TEE DRIVER
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index ff869d883d95..819a97e8ba99 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -3,10 +3,6 @@
 # Confidential computing related collateral
 #
 
-config TSM_REPORTS
-	select CONFIGFS_FS
-	tristate
-
 source "drivers/virt/coco/efi_secret/Kconfig"
 
 source "drivers/virt/coco/pkvm-guest/Kconfig"
@@ -16,3 +12,5 @@ source "drivers/virt/coco/sev-guest/Kconfig"
 source "drivers/virt/coco/tdx-guest/Kconfig"
 
 source "drivers/virt/coco/arm-cca-guest/Kconfig"
+
+source "drivers/virt/coco/guest/Kconfig"
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index c3d07cfc087e..885c9ef4e9fc 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -2,9 +2,9 @@
 #
 # Confidential computing related collateral
 #
-obj-$(CONFIG_TSM_REPORTS)	+= tsm.o
 obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
 obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
 obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
+obj-$(CONFIG_TSM_REPORTS)	+= guest/
diff --git a/drivers/virt/coco/guest/Kconfig b/drivers/virt/coco/guest/Kconfig
new file mode 100644
index 000000000000..ed9bafbdd854
--- /dev/null
+++ b/drivers/virt/coco/guest/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Confidential computing shared guest collateral
+#
+config TSM_REPORTS
+	select CONFIGFS_FS
+	tristate
diff --git a/drivers/virt/coco/guest/Makefile b/drivers/virt/coco/guest/Makefile
new file mode 100644
index 000000000000..b3b217af77cf
--- /dev/null
+++ b/drivers/virt/coco/guest/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_TSM_REPORTS)	+= tsm_report.o
+tsm_report-y := report.o
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/guest/report.c
similarity index 100%
rename from drivers/virt/coco/tsm.c
rename to drivers/virt/coco/guest/report.c


