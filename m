Return-Path: <linux-pci+bounces-2784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E07B841F98
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 10:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29933B2AA37
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 09:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C59059165;
	Tue, 30 Jan 2024 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="br0HQuhx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53392605AC
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606641; cv=none; b=CHAe3++JcW4XaMXkeWL56JwHIF3IeTYg3aPGAaqEAXsajsl4g4FLMUBzaEbzWtKYRMIf0GAB1N/HwMldrVJQEsIGFgdn1CLKWkPouyC5y5aqxvhBHulju63OVA5Wqd+LQZwwPN1Un7ONpFXuZXws27GMHQmi9THfYLtWgtd/6IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606641; c=relaxed/simple;
	bh=kAQEKNTOi0wauDH56Q45XINuqYS7KpML6MmMrA9UxTc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uom3gh4Jb8T2b3FJSoMBgXSiHWPhj76N80waQV6Xh2yH0R0ldCyg82pvOgPrUoPMEBMVW8WRH0O/uU7OAo2s/WAYpNn+plYA95FsTv2IxeDjfulO3TaDjJhtJjYVuvaGPaUUPoGw0klc96m66wZ+roXXT9tPc4nEw9Jw70KlvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=br0HQuhx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706606638; x=1738142638;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kAQEKNTOi0wauDH56Q45XINuqYS7KpML6MmMrA9UxTc=;
  b=br0HQuhx1C5Uq2RrhnZymtOU7jf4lvKOD1GpzJkNXzK4tQqDSWDBGok9
   wkxEo3lWtJ8ScIEAs1YZZrjoW05v2Z5hy/N5A6tZJZ7ilTALcKDN4M0AB
   FhUbsJE3BIHN4HHKhG4U9a2Jg9l/nVCQ3U1qn+htbSHspaqnaASC9cdzC
   KrwfcDneuIG2eJlzKyZKdGaQnrfSxPgBOg4h/hpdWnvbUhiBRGBMxjiOr
   X3U2Cllplp0PDzV+W9k3qYYXaKi6MUFVZeY4sYzNkJMj29oeeak4xawrL
   juMb+5MiJ6rDD2Px3SrKI4De6uZox2ylDcCPiAoB9+mqdo3QtV1Y5QLYm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="24699881"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="24699881"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:23:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3738933"
Received: from djayasin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.72.104])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:23:58 -0800
Subject: [RFC PATCH 2/5] coco/tsm: Establish a new coco/tsm subdirectory
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
Date: Tue, 30 Jan 2024 01:23:57 -0800
Message-ID: <170660663734.224441.8533201007071291342.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In preparation for new + common TSM infrastructure, establish
drivers/virt/coco/tsm/. The tsm.ko module is renamed to tsm_reports.ko,
and some of its symbols moved to the "tsm_report_" namespace to separate
it from more generic "tsm" objects / symbols. The old tsm.ko module was
only ever demand loaded by kernel internal dependencies, so it should
not affect existing userspace module install scripts.

Cc: Wu Hao <hao.wu@intel.com>
Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/Kconfig               |    6 ++----
 drivers/virt/coco/Makefile              |    4 ++--
 drivers/virt/coco/sev-guest/sev-guest.c |    8 ++++----
 drivers/virt/coco/tdx-guest/tdx-guest.c |    8 ++++----
 drivers/virt/coco/tsm/Kconfig           |    7 +++++++
 drivers/virt/coco/tsm/Makefile          |    6 ++++++
 drivers/virt/coco/tsm/reports.c         |   24 ++++++++++++------------
 include/linux/tsm.h                     |   24 ++++++++++++------------
 8 files changed, 49 insertions(+), 38 deletions(-)
 create mode 100644 drivers/virt/coco/tsm/Kconfig
 create mode 100644 drivers/virt/coco/tsm/Makefile
 rename drivers/virt/coco/{tsm.c => tsm/reports.c} (94%)

diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index 87d142c1f932..1e2eb5e768f9 100644
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
+source "drivers/virt/coco/tsm/Kconfig"
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index 18c1aba5edb7..2c9d0a178678 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # Confidential computing related collateral
-#
-obj-$(CONFIG_TSM_REPORTS)	+= tsm.o
+
 obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
+obj-y				+= tsm/
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 87f241825bc3..d058cb8f9708 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -786,7 +786,7 @@ struct snp_msg_cert_entry {
 static int sev_report_new(struct tsm_report *report, void *data)
 {
 	struct snp_msg_cert_entry *cert_table;
-	struct tsm_desc *desc = &report->desc;
+	struct tsm_report_desc *desc = &report->desc;
 	struct snp_guest_dev *snp_dev = data;
 	struct snp_msg_report_resp_hdr hdr;
 	const u32 report_size = SZ_4K;
@@ -885,14 +885,14 @@ static int sev_report_new(struct tsm_report *report, void *data)
 	return 0;
 }
 
-static const struct tsm_ops sev_tsm_ops = {
+static const struct tsm_report_ops sev_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = sev_report_new,
 };
 
 static void unregister_sev_tsm(void *data)
 {
-	tsm_unregister(&sev_tsm_ops);
+	tsm_report_unregister(&sev_tsm_ops);
 }
 
 static int __init sev_guest_probe(struct platform_device *pdev)
@@ -968,7 +968,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
 	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
-	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
+	ret = tsm_report_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
 	if (ret)
 		goto e_free_cert_data;
 
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 1253bf76b570..904f16461492 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -163,7 +163,7 @@ static int tdx_report_new(struct tsm_report *report, void *data)
 {
 	u8 *buf, *reportdata = NULL, *tdreport = NULL;
 	struct tdx_quote_buf *quote_buf = quote_data;
-	struct tsm_desc *desc = &report->desc;
+	struct tsm_report_desc *desc = &report->desc;
 	int ret;
 	u64 err;
 
@@ -278,7 +278,7 @@ static const struct x86_cpu_id tdx_guest_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
 
-static const struct tsm_ops tdx_tsm_ops = {
+static const struct tsm_report_ops tdx_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = tdx_report_new,
 };
@@ -301,7 +301,7 @@ static int __init tdx_guest_init(void)
 		goto free_misc;
 	}
 
-	ret = tsm_register(&tdx_tsm_ops, NULL, NULL);
+	ret = tsm_report_register(&tdx_tsm_ops, NULL, NULL);
 	if (ret)
 		goto free_quote;
 
@@ -318,7 +318,7 @@ module_init(tdx_guest_init);
 
 static void __exit tdx_guest_exit(void)
 {
-	tsm_unregister(&tdx_tsm_ops);
+	tsm_report_unregister(&tdx_tsm_ops);
 	free_quote_buf(quote_data);
 	misc_deregister(&tdx_misc_dev);
 }
diff --git a/drivers/virt/coco/tsm/Kconfig b/drivers/virt/coco/tsm/Kconfig
new file mode 100644
index 000000000000..69f04461c83e
--- /dev/null
+++ b/drivers/virt/coco/tsm/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TSM (TEE Security Manager) Common infrastructure
+
+config TSM_REPORTS
+	select CONFIGFS_FS
+	tristate
diff --git a/drivers/virt/coco/tsm/Makefile b/drivers/virt/coco/tsm/Makefile
new file mode 100644
index 000000000000..b48504a3ccfd
--- /dev/null
+++ b/drivers/virt/coco/tsm/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TSM (TEE Security Manager) Common infrastructure
+
+obj-$(CONFIG_TSM_REPORTS) += tsm_reports.o
+tsm_reports-y := reports.o
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm/reports.c
similarity index 94%
rename from drivers/virt/coco/tsm.c
rename to drivers/virt/coco/tsm/reports.c
index d1c2db83a8ca..6cb0a0e6783d 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm/reports.c
@@ -13,7 +13,7 @@
 #include <linux/configfs.h>
 
 static struct tsm_provider {
-	const struct tsm_ops *ops;
+	const struct tsm_report_ops *ops;
 	const struct config_item_type *type;
 	void *data;
 } provider;
@@ -98,7 +98,7 @@ static ssize_t tsm_report_privlevel_store(struct config_item *cfg,
 	 * SEV-SNP GHCB) and a minimum of a TSM selected floor value no less
 	 * than 0.
 	 */
-	if (provider.ops->privlevel_floor > val || val > TSM_PRIVLEVEL_MAX)
+	if (provider.ops->privlevel_floor > val || val > TSM_REPORT_PRIVLEVEL_MAX)
 		return -EINVAL;
 
 	guard(rwsem_write)(&tsm_rwsem);
@@ -134,7 +134,7 @@ static ssize_t tsm_report_inblob_write(struct config_item *cfg,
 	memcpy(report->desc.inblob, buf, count);
 	return count;
 }
-CONFIGFS_BIN_ATTR_WO(tsm_report_, inblob, NULL, TSM_INBLOB_MAX);
+CONFIGFS_BIN_ATTR_WO(tsm_report_, inblob, NULL, TSM_REPORT_INBLOB_MAX);
 
 static ssize_t tsm_report_generation_show(struct config_item *cfg, char *buf)
 {
@@ -201,7 +201,7 @@ static ssize_t tsm_report_read(struct tsm_report *report, void *buf,
 			       size_t count, enum tsm_data_select select)
 {
 	struct tsm_report_state *state = to_state(report);
-	const struct tsm_ops *ops;
+	const struct tsm_report_ops *ops;
 	ssize_t rc;
 
 	/* try to read from the existing report if present and valid... */
@@ -241,7 +241,7 @@ static ssize_t tsm_report_outblob_read(struct config_item *cfg, void *buf,
 
 	return tsm_report_read(report, buf, count, TSM_REPORT);
 }
-CONFIGFS_BIN_ATTR_RO(tsm_report_, outblob, NULL, TSM_OUTBLOB_MAX);
+CONFIGFS_BIN_ATTR_RO(tsm_report_, outblob, NULL, TSM_REPORT_OUTBLOB_MAX);
 
 static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
 				       size_t count)
@@ -250,7 +250,7 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
 
 	return tsm_report_read(report, buf, count, TSM_CERTS);
 }
-CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
+CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_REPORT_OUTBLOB_MAX);
 
 #define TSM_DEFAULT_ATTRS() \
 	&tsm_report_attr_generation, \
@@ -353,10 +353,10 @@ static struct configfs_subsystem tsm_configfs = {
 	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
 };
 
-int tsm_register(const struct tsm_ops *ops, void *priv,
-		 const struct config_item_type *type)
+int tsm_report_register(const struct tsm_report_ops *ops, void *priv,
+			const struct config_item_type *type)
 {
-	const struct tsm_ops *conflict;
+	const struct tsm_report_ops *conflict;
 
 	if (!type)
 		type = &tsm_report_default_type;
@@ -375,9 +375,9 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
 	provider.type = type;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(tsm_register);
+EXPORT_SYMBOL_GPL(tsm_report_register);
 
-int tsm_unregister(const struct tsm_ops *ops)
+int tsm_report_unregister(const struct tsm_report_ops *ops)
 {
 	guard(rwsem_write)(&tsm_rwsem);
 	if (ops != provider.ops)
@@ -387,7 +387,7 @@ int tsm_unregister(const struct tsm_ops *ops)
 	provider.type = NULL;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(tsm_unregister);
+EXPORT_SYMBOL_GPL(tsm_report_unregister);
 
 static struct config_group *tsm_report_group;
 
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index de8324a2223c..28753608fcf5 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -5,25 +5,25 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 
-#define TSM_INBLOB_MAX 64
-#define TSM_OUTBLOB_MAX SZ_32K
+#define TSM_REPORT_INBLOB_MAX 64
+#define TSM_REPORT_OUTBLOB_MAX SZ_32K
 
 /*
  * Privilege level is a nested permission concept to allow confidential
  * guests to partition address space, 4-levels are supported.
  */
-#define TSM_PRIVLEVEL_MAX 3
+#define TSM_REPORT_PRIVLEVEL_MAX 3
 
 /**
- * struct tsm_desc - option descriptor for generating tsm report blobs
+ * struct tsm_report_desc - option descriptor for generating tsm report blobs
  * @privlevel: optional privilege level to associate with @outblob
  * @inblob_len: sizeof @inblob
  * @inblob: arbitrary input data
  */
-struct tsm_desc {
+struct tsm_report_desc {
 	unsigned int privlevel;
 	size_t inblob_len;
-	u8 inblob[TSM_INBLOB_MAX];
+	u8 inblob[TSM_REPORT_INBLOB_MAX];
 };
 
 /**
@@ -35,7 +35,7 @@ struct tsm_desc {
  * @auxblob: (optional) auxiliary data to the report (e.g. certificate data)
  */
 struct tsm_report {
-	struct tsm_desc desc;
+	struct tsm_report_desc desc;
 	size_t outblob_len;
 	u8 *outblob;
 	size_t auxblob_len;
@@ -43,7 +43,7 @@ struct tsm_report {
 };
 
 /**
- * struct tsm_ops - attributes and operations for tsm instances
+ * struct tsm_report_ops - attributes and operations for tsm instances
  * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/provider
  * @privlevel_floor: convey base privlevel for nested scenarios
  * @report_new: Populate @report with the report blob and auxblob
@@ -52,7 +52,7 @@ struct tsm_report {
  * Implementation specific ops, only one is expected to be registered at
  * a time i.e. only one of "sev-guest", "tdx-guest", etc.
  */
-struct tsm_ops {
+struct tsm_report_ops {
 	const char *name;
 	const unsigned int privlevel_floor;
 	int (*report_new)(struct tsm_report *report, void *data);
@@ -63,7 +63,7 @@ extern const struct config_item_type tsm_report_default_type;
 /* publish @privlevel, @privlevel_floor, and @auxblob attributes */
 extern const struct config_item_type tsm_report_extra_type;
 
-int tsm_register(const struct tsm_ops *ops, void *priv,
-		 const struct config_item_type *type);
-int tsm_unregister(const struct tsm_ops *ops);
+int tsm_report_register(const struct tsm_report_ops *ops, void *priv,
+			const struct config_item_type *type);
+int tsm_report_unregister(const struct tsm_report_ops *ops);
 #endif /* __TSM_H */


