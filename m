Return-Path: <linux-pci+bounces-6174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8928A2A2B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 11:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E742D289ACA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 09:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F93537EE;
	Fri, 12 Apr 2024 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHdrSZof"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E9338DF1
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911914; cv=none; b=R6TnoG6ih1CwJb0ECEOoObt+gceRmY5hRUVXwY+LhN2K+I2uwj1o+RCZeILVC67TXjBZ0dP+Wp6cH6bJ8+umJBHPhj8N+Ti7yMk5EvdtmdKf9UJW1v0H4r2zRlSQ7dEY25rVXmDjE+cEEwwSmgqBNzMlFDc8nNMsYneKfxatNCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911914; c=relaxed/simple;
	bh=a93AulBcyEqWNiBjOtzYqeE6Y4ih+at1eYZ4nF1/qx8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAgptYUTZrUIudm3o48Seglb8agLPi8FgYyGAHMxQLfwH7u4t8XtnwEa/H2txPm5v/5PxtdxKMWdWrJqXL+XYVhBKfLdmuo+moFHvUcaMzmgrH3BbDMvvL/DjJyD8xx/y2SS01/GiASUggcKV4UZjIJK5VSOlFRegVEt5sxtqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHdrSZof; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712911911; x=1744447911;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a93AulBcyEqWNiBjOtzYqeE6Y4ih+at1eYZ4nF1/qx8=;
  b=OHdrSZofGztFcFh6RQ3/dxgnc14rbAVi3AV9VRzopWxgAfi4BhYgwjYY
   olKA/d0Taz5TF84G8/EnAEbICy4qVPYdRr56hA4cK9zPNg8dCSFH/folV
   p45HJWWLU2LdPCzJGRunFRp1KaVcU3acIcLOk60o2eQBRMoKCi8iMfIR3
   CNLyrn+yxSEPLPHDH9/NArREYqYKkqDtVDl0wzUIt664jBBsPqqs2d+tY
   ASd0J6iXNiK49+3LvNQOMrzkniIXv9pqUjMomZ9S33m2JWD8AVfThqJL7
   uPCgW29UZAmhS6iGbPAAg+ToPLzp5EoCvvmvO3amY3XBFtEilnlVVQ40t
   g==;
X-CSE-ConnectionGUID: eIXn0AMlTlyZngGdxQ8X0w==
X-CSE-MsgGUID: IEwwwVRtR2iXHkYTs6JSuw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8468316"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8468316"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:51:50 -0700
X-CSE-ConnectionGUID: 41qW8OeURV6sw/szJi9J3Q==
X-CSE-MsgGUID: evYZ0QH0SNaDNPU6ZoeyaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21226709"
Received: from aclausch-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.15.202])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:51:50 -0700
Subject: [RFC PATCH v2 1/6] configfs-tsm: Namespace TSM report symbols
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, bhelgaas@google.com,
 kevin.tian@intel.com, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 lukas@wunner.de
Date: Fri, 12 Apr 2024 01:51:49 -0700
Message-ID: <171291190916.3532867.5159124454566889624.stgit@dwillia2-xfh.jf.intel.com>
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

In preparation for new + common TSM (TEE Security Manager)
infrastructure, namespace the TSM report symbols in tsm.h with an
_REPORT suffix to differentiate them from other incoming tsm symbols.

Cc: Wu Hao <hao.wu@intel.com>
Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c |    8 ++++----
 drivers/virt/coco/tdx-guest/tdx-guest.c |    8 ++++----
 drivers/virt/coco/tsm.c                 |   24 ++++++++++++------------
 include/linux/tsm.h                     |   24 ++++++++++++------------
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 87f241825bc3..ce60e3ce8aa3 100644
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
+static const struct tsm_report_ops sev_tsm_report_ops = {
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
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index d1c2db83a8ca..6cb0a0e6783d 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
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
index de8324a2223c..9bbb1d130d01 100644
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
+ * struct tsm_report_ops - attributes and operations for tsm_report instances
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


