Return-Path: <linux-pci+bounces-6175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B428A2A2C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 11:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7AF41C209E5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 09:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BF738FBC;
	Fri, 12 Apr 2024 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GM2dwu9p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250357863
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911918; cv=none; b=GnFkigqst8bI50CO2lPdR0WULdRcza6LCvQo5c4gwiHjKRIgbM02gtFIvUvx72BN/PoHXfu3UJP7vAJCV7oJArTfKHghzxj1f17F/HVs0DbPJDr6zbHjc3lSCaQgdMxrRJX9BzwR140mElgZbOAMX3Grej+msQYcJpVK7GMBFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911918; c=relaxed/simple;
	bh=XnLZwFM5Yg78rZOPvBQ10RgNKXhx2UIdSDE0BfeVmUU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBlXDczJP2/pCieeyFZQzN4ey570v8RY8x3oEUDOuT7dyrlyEC7Y23H73nnkCXrRxCVv8AL0NpnOlIRpJxGhAz6n9YM6Fjp/yuqmd9MHTEtWz0mZxKm6k53flUIXRG3NuyjKt6Fp97vdHsUyYWsMt/J/gl9OILwhZAoq+4I+mjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GM2dwu9p; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712911917; x=1744447917;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XnLZwFM5Yg78rZOPvBQ10RgNKXhx2UIdSDE0BfeVmUU=;
  b=GM2dwu9pp7b5W/6AIt44pVmUSQNiW22W1LXZtzgf+jlZ0tQgEZ2RrogV
   ANGs4uT3z6D0kmGGSYdoBPSreJOJiSAett6urlJw9CltNV4fslAMXCObA
   5FeJbcmXza1shZp639j/aIMoW1461s1t/DaZpSBb+dGk+AbqT/kXLkxUF
   AdBIsfljIQQ9F2ywRC6cCh93A+eiUTbMiKpfAi8xdg37vZaC8Z+16oS/a
   MEhrVyLKsX62jz5BoCcETRRm7v9lO4Njl5knSuh35zX5dLUp2IUBchxfl
   FA+JgpFyb5gOYym9Yn8y9+Sizh164XX49M9+LqggqkePxiypQ/BxdSRvv
   Q==;
X-CSE-ConnectionGUID: 9HZb/e3aSNKQisG0/ijTxg==
X-CSE-MsgGUID: oCZyJsnqQT2jpKxrWTptlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8468325"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8468325"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:51:57 -0700
X-CSE-ConnectionGUID: aDWJvb3bSe2kAzvkHc6i8w==
X-CSE-MsgGUID: QvsA1rhgTH+dPP45MQ3pgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21226717"
Received: from aclausch-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.15.202])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:51:56 -0700
Subject: [RFC PATCH v2 2/6] coco/guest: Move shared guest CC infrastructure
 to drivers/virt/coco/guest/
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, bhelgaas@google.com,
 kevin.tian@intel.com, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 lukas@wunner.de
Date: Fri, 12 Apr 2024 01:51:55 -0700
Message-ID: <171291191515.3532867.11605732628846703149.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
References: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
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

Cc: Wu Hao <hao.wu@intel.com>
Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 MAINTAINERS                             |    2 +-
 drivers/virt/coco/Kconfig               |    6 ++----
 drivers/virt/coco/Makefile              |    2 +-
 drivers/virt/coco/guest/Kconfig         |    7 +++++++
 drivers/virt/coco/guest/Makefile        |    2 ++
 drivers/virt/coco/guest/tsm_report.c    |    8 ++++----
 drivers/virt/coco/sev-guest/sev-guest.c |    4 ++--
 7 files changed, 19 insertions(+), 12 deletions(-)
 create mode 100644 drivers/virt/coco/guest/Kconfig
 create mode 100644 drivers/virt/coco/guest/Makefile
 rename drivers/virt/coco/{tsm.c => guest/tsm_report.c} (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..65beba4e704a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22466,7 +22466,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm
-F:	drivers/virt/coco/tsm.c
+F:	drivers/virt/coco/guest/tsm_report.c
 F:	include/linux/tsm.h
 
 TTY LAYER AND SERIAL DRIVERS
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index 87d142c1f932..7c41e0abd423 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -3,12 +3,10 @@
 # Confidential computing related collateral
 #
 
-config TSM_REPORTS
-	select CONFIGFS_FS
-	tristate
-
 source "drivers/virt/coco/efi_secret/Kconfig"
 
 source "drivers/virt/coco/sev-guest/Kconfig"
 
 source "drivers/virt/coco/tdx-guest/Kconfig"
+
+source "drivers/virt/coco/guest/Kconfig"
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index 18c1aba5edb7..621111811a76 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -2,7 +2,7 @@
 #
 # Confidential computing related collateral
 #
-obj-$(CONFIG_TSM_REPORTS)	+= tsm.o
 obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
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
index 000000000000..1f5fad59fc96
--- /dev/null
+++ b/drivers/virt/coco/guest/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_TSM_REPORTS)	+= tsm_report.o
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/guest/tsm_report.c
similarity index 98%
rename from drivers/virt/coco/tsm.c
rename to drivers/virt/coco/guest/tsm_report.c
index 6cb0a0e6783d..272077a02da5 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/guest/tsm_report.c
@@ -391,7 +391,7 @@ EXPORT_SYMBOL_GPL(tsm_report_unregister);
 
 static struct config_group *tsm_report_group;
 
-static int __init tsm_init(void)
+static int __init tsm_report_init(void)
 {
 	struct config_group *root = &tsm_configfs.su_group;
 	struct config_group *tsm;
@@ -412,14 +412,14 @@ static int __init tsm_init(void)
 
 	return 0;
 }
-module_init(tsm_init);
+module_init(tsm_report_init);
 
-static void __exit tsm_exit(void)
+static void __exit tsm_report_exit(void)
 {
 	configfs_unregister_default_group(tsm_report_group);
 	configfs_unregister_subsystem(&tsm_configfs);
 }
-module_exit(tsm_exit);
+module_exit(tsm_report_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Provide Trusted Security Module attestation reports via configfs");
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index ce60e3ce8aa3..dc0e3ad21cbf 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -892,7 +892,7 @@ static const struct tsm_report_ops sev_tsm_report_ops = {
 
 static void unregister_sev_tsm(void *data)
 {
-	tsm_report_unregister(&sev_tsm_ops);
+	tsm_report_unregister(&sev_tsm_report_ops);
 }
 
 static int __init sev_guest_probe(struct platform_device *pdev)
@@ -968,7 +968,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
 	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
-	ret = tsm_report_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
+	ret = tsm_report_register(&sev_tsm_report_ops, snp_dev, &tsm_report_extra_type);
 	if (ret)
 		goto e_free_cert_data;
 


