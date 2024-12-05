Return-Path: <linux-pci+bounces-17802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E199E6072
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 23:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1569418854BA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED891C878E;
	Thu,  5 Dec 2024 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjEvO+Lz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D0C1CCEF8
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437411; cv=none; b=DQf7M5kmXlfJuEN8B7sJqViJniy804NdoMNkEKisYfKElLQLniPEcwsN7iL4+n2uYaupkxCPy9uVZZsnMpIf03hWwmBmPvEitQfcqDdvbY8tJIlIT8jq431VhIOb9eswgQahopStkkz5nfr36wxueHyR6KxrqcXOTMW6ABzZOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437411; c=relaxed/simple;
	bh=LiJbKNs0v4zJbWcVmgIaWJfTF8G2NAh9EzD9TZKTjOU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRluOkIMW6w1MjTt/1zuWNukjenQMBpOmBKE/rI0XRl5SaiCvLDyDQg0jVEAXa9gmKAOEd0PhuO+snLIDI1dyJC9FJWu069LosFGsIdiOm0A+5X2I4phR/tzjzQyv6nFAA3P4VhcHTcVbOhkKxkqReSBF6OkuygDDPHtl//2dwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjEvO+Lz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733437409; x=1764973409;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LiJbKNs0v4zJbWcVmgIaWJfTF8G2NAh9EzD9TZKTjOU=;
  b=UjEvO+LzHxYiKWX5IpVfPZl8r0gJM2Tv1Xo0dSNS20QdJr4ZTtpDArK/
   mKym0+crM+0/0k3qZEtYiia2beOV66jVGs/OHz36NzjFCmN0NP36c6k1Q
   ZEDS8uInGSD6myUWRxwWZ8fXeVnBrzRcQRFLFoagyktPGbIIXvmQZ6zsg
   gUUZRB+TJ34FhT80e6bRQ0m0o/PRoE2j2U53IYLRdpJFHkyb10qnz85HV
   gjX0mog63OYwB/tCg7OvMN2VYnyDukcr5OuaV4WNrN2aW41w0ZMZyOqM6
   HEn0Z+vPCBAJAnfGx25v6Mtt40ugzQqjxs1BwBJcohFSoJU7bTFuVwJEe
   g==;
X-CSE-ConnectionGUID: uOGhj8YBQlGENKCNGQ/UNw==
X-CSE-MsgGUID: 9rUP/RidSWijZZcHbMtZQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33921137"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33921137"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:28 -0800
X-CSE-ConnectionGUID: YaD2eBlxQh2LzW5EpjezgA==
X-CSE-MsgGUID: 3GbcJXqrRU2BNebIBZYSkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="93905549"
Received: from kcaccard-desk.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:28 -0800
Subject: [PATCH 02/11] coco/guest: Move shared guest CC infrastructure to
 drivers/virt/coco/guest/
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
Date: Thu, 05 Dec 2024 14:23:27 -0800
Message-ID: <173343740777.1074769.15850350070210009497.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
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
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
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
index 53f04c499705..0c8f61662836 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23843,7 +23843,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
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


