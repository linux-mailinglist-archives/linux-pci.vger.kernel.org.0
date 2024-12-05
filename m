Return-Path: <linux-pci+bounces-17801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC11F9E6071
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 23:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326C42841A7
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 22:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76661BBBF1;
	Thu,  5 Dec 2024 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvHugNDM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2F1CCEF8
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437405; cv=none; b=TblFfAkI56m5HxACbp3bI8HPgdlNbqOUucGGsUeqke49Ar37RehUI7EHQGN5FRAcQJZkQnGb2/9dBT9xKCjpU/iQ6NkeVKdHDg5ae+Di/28xyCZP3yOMGXecSp/VnA2QJPnnqPApOwM3GNDcErnxWaX3maj01rlx2QlGURIMSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437405; c=relaxed/simple;
	bh=N/yHfUxNx+wHAKz81sl19z55StoOGiF93MdG+BsYVJE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0phxQ9Qg0cNaICH1CD+rp2Cm2P+LBxFI5zlqOurJW5ewP7XQiIpjE9Quq/LpM1raMr0V1imQQUST5VvbsNe549tpuWjANrY1J1YMS5sAxmpbdOS4tUflH1dVM4kqYUrc59ruPXMMRPXXmIfqAhhbqYaS/RETeBa3BkEU81MTQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvHugNDM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733437403; x=1764973403;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N/yHfUxNx+wHAKz81sl19z55StoOGiF93MdG+BsYVJE=;
  b=ZvHugNDMCveTPs1JWRMs0Ta5pMZZn1Mwa0F7Ittjyk2HyOu4j2VRDEzB
   LlBkeLu3oKuPT+Tqk/7ncGah5kg7QNW2bfsTootDC7C1ruVzuCl5WWD44
   o60wH3cE0novP686tBuxtie9tIWdTs1ZRDYpgCcwLjTytmfZUAMOljgOD
   NP2g/Adc15Obj/ZTRB/vqSiLKbgr1UhF+GmhzVt/dYIdOPdQdu8NT3+me
   UAZwf7jzGW2OlkI3uTz13EQwHR4lcz78TjnQFzpasNf/rubnm152fp2vW
   3M+HSdfuRI4cvt4LPRkGlpjd9y7dRfQjRChN0Q2+BEF5BG3F2lbmg4ZwE
   Q==;
X-CSE-ConnectionGUID: 3Lzq5cKtTAeQR9Z0+WY9SA==
X-CSE-MsgGUID: 8kV7gjfuQme4czCci8wBQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33921122"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33921122"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:23 -0800
X-CSE-ConnectionGUID: ucvxB8e9SMmOxQpPNb5HJw==
X-CSE-MsgGUID: tDJCinpKRO2DW13/H11a8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="93905513"
Received: from kcaccard-desk.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:22 -0800
Subject: [PATCH 01/11] configfs-tsm: Namespace TSM report symbols
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Yilun Xu <yilun.xu@intel.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Alexey Kardashevskiy <aik@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Sami Mujawar <sami.mujawar@arm.com>, Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
Date: Thu, 05 Dec 2024 14:23:21 -0800
Message-ID: <173343740180.1074769.15809313632664416174.stgit@dwillia2-xfh.jf.intel.com>
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

In preparation for new + common TSM (TEE Security Manager)
infrastructure, namespace the TSM report symbols in tsm.h with an
_REPORT suffix to differentiate them from other incoming tsm work.

Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Sami Mujawar <sami.mujawar@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/configfs-tsm-report   |    0 
 MAINTAINERS                                     |    2 +
 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |    8 +++---
 drivers/virt/coco/sev-guest/sev-guest.c         |   12 ++++-----
 drivers/virt/coco/tdx-guest/tdx-guest.c         |    8 +++---
 drivers/virt/coco/tsm.c                         |   32 ++++++++++++-----------
 include/linux/tsm.h                             |   22 ++++++++--------
 7 files changed, 42 insertions(+), 42 deletions(-)
 rename Documentation/ABI/testing/{configfs-tsm => configfs-tsm-report} (100%)

diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm-report
similarity index 100%
rename from Documentation/ABI/testing/configfs-tsm
rename to Documentation/ABI/testing/configfs-tsm-report
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..53f04c499705 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23842,7 +23842,7 @@ TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
-F:	Documentation/ABI/testing/configfs-tsm
+F:	Documentation/ABI/testing/configfs-tsm-report
 F:	drivers/virt/coco/tsm.c
 F:	include/linux/tsm.h
 
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
index 488153879ec9..63b9fdb843fa 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
@@ -95,7 +95,7 @@ static int arm_cca_report_new(struct tsm_report *report, void *data)
 	struct arm_cca_token_info info;
 	void *buf;
 	u8 *token __free(kvfree) = NULL;
-	struct tsm_desc *desc = &report->desc;
+	struct tsm_report_desc *desc = &report->desc;
 
 	if (desc->inblob_len < 32 || desc->inblob_len > 64)
 		return -EINVAL;
@@ -180,7 +180,7 @@ static int arm_cca_report_new(struct tsm_report *report, void *data)
 	return ret;
 }
 
-static const struct tsm_ops arm_cca_tsm_ops = {
+static const struct tsm_report_ops arm_cca_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = arm_cca_report_new,
 };
@@ -201,7 +201,7 @@ static int __init arm_cca_guest_init(void)
 	if (!is_realm_world())
 		return -ENODEV;
 
-	ret = tsm_register(&arm_cca_tsm_ops, NULL);
+	ret = tsm_report_register(&arm_cca_tsm_ops, NULL);
 	if (ret < 0)
 		pr_err("Error %d registering with TSM\n", ret);
 
@@ -215,7 +215,7 @@ module_init(arm_cca_guest_init);
  */
 static void __exit arm_cca_guest_exit(void)
 {
-	tsm_unregister(&arm_cca_tsm_ops);
+	tsm_report_unregister(&arm_cca_tsm_ops);
 }
 module_exit(arm_cca_guest_exit);
 
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index fca5c45ed5cd..7eedde61589c 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -701,7 +701,7 @@ struct snp_msg_cert_entry {
 static int sev_svsm_report_new(struct tsm_report *report, void *data)
 {
 	unsigned int rep_len, man_len, certs_len;
-	struct tsm_desc *desc = &report->desc;
+	struct tsm_report_desc *desc = &report->desc;
 	struct svsm_attest_call ac = {};
 	unsigned int retry_count;
 	void *rep, *man, *certs;
@@ -836,7 +836,7 @@ static int sev_svsm_report_new(struct tsm_report *report, void *data)
 static int sev_report_new(struct tsm_report *report, void *data)
 {
 	struct snp_msg_cert_entry *cert_table;
-	struct tsm_desc *desc = &report->desc;
+	struct tsm_report_desc *desc = &report->desc;
 	struct snp_guest_dev *snp_dev = data;
 	struct snp_msg_report_resp_hdr hdr;
 	const u32 report_size = SZ_4K;
@@ -965,7 +965,7 @@ static bool sev_report_bin_attr_visible(int n)
 	return false;
 }
 
-static struct tsm_ops sev_tsm_ops = {
+static struct tsm_report_ops sev_tsm_report_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = sev_report_new,
 	.report_attr_visible = sev_report_attr_visible,
@@ -974,7 +974,7 @@ static struct tsm_ops sev_tsm_ops = {
 
 static void unregister_sev_tsm(void *data)
 {
-	tsm_unregister(&sev_tsm_ops);
+	tsm_report_unregister(&sev_tsm_report_ops);
 }
 
 static int __init sev_guest_probe(struct platform_device *pdev)
@@ -1062,9 +1062,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	mdesc->input.data_gpa = __pa(mdesc->certs_data);
 
 	/* Set the privlevel_floor attribute based on the vmpck_id */
-	sev_tsm_ops.privlevel_floor = vmpck_id;
+	sev_tsm_report_ops.privlevel_floor = vmpck_id;
 
-	ret = tsm_register(&sev_tsm_ops, snp_dev);
+	ret = tsm_report_register(&sev_tsm_report_ops, snp_dev);
 	if (ret)
 		goto e_free_cert_data;
 
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index d7db6c824e13..66ea09207a7c 100644
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
 
@@ -299,7 +299,7 @@ static const struct x86_cpu_id tdx_guest_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
 
-static const struct tsm_ops tdx_tsm_ops = {
+static const struct tsm_report_ops tdx_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = tdx_report_new,
 	.report_attr_visible = tdx_report_attr_visible,
@@ -324,7 +324,7 @@ static int __init tdx_guest_init(void)
 		goto free_misc;
 	}
 
-	ret = tsm_register(&tdx_tsm_ops, NULL);
+	ret = tsm_report_register(&tdx_tsm_ops, NULL);
 	if (ret)
 		goto free_quote;
 
@@ -341,7 +341,7 @@ module_init(tdx_guest_init);
 
 static void __exit tdx_guest_exit(void)
 {
-	tsm_unregister(&tdx_tsm_ops);
+	tsm_report_unregister(&tdx_tsm_ops);
 	free_quote_buf(quote_data);
 	misc_deregister(&tdx_misc_dev);
 }
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index 9432d4e303f1..bcb515b50c68 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -13,7 +13,7 @@
 #include <linux/configfs.h>
 
 static struct tsm_provider {
-	const struct tsm_ops *ops;
+	const struct tsm_report_ops *ops;
 	void *data;
 } provider;
 static DECLARE_RWSEM(tsm_rwsem);
@@ -98,7 +98,7 @@ static ssize_t tsm_report_privlevel_store(struct config_item *cfg,
 	 * SEV-SNP GHCB) and a minimum of a TSM selected floor value no less
 	 * than 0.
 	 */
-	if (provider.ops->privlevel_floor > val || val > TSM_PRIVLEVEL_MAX)
+	if (provider.ops->privlevel_floor > val || val > TSM_REPORT_PRIVLEVEL_MAX)
 		return -EINVAL;
 
 	guard(rwsem_write)(&tsm_rwsem);
@@ -202,7 +202,7 @@ static ssize_t tsm_report_inblob_write(struct config_item *cfg,
 	memcpy(report->desc.inblob, buf, count);
 	return count;
 }
-CONFIGFS_BIN_ATTR_WO(tsm_report_, inblob, NULL, TSM_INBLOB_MAX);
+CONFIGFS_BIN_ATTR_WO(tsm_report_, inblob, NULL, TSM_REPORT_INBLOB_MAX);
 
 static ssize_t tsm_report_generation_show(struct config_item *cfg, char *buf)
 {
@@ -272,7 +272,7 @@ static ssize_t tsm_report_read(struct tsm_report *report, void *buf,
 			       size_t count, enum tsm_data_select select)
 {
 	struct tsm_report_state *state = to_state(report);
-	const struct tsm_ops *ops;
+	const struct tsm_report_ops *ops;
 	ssize_t rc;
 
 	/* try to read from the existing report if present and valid... */
@@ -314,7 +314,7 @@ static ssize_t tsm_report_outblob_read(struct config_item *cfg, void *buf,
 
 	return tsm_report_read(report, buf, count, TSM_REPORT);
 }
-CONFIGFS_BIN_ATTR_RO(tsm_report_, outblob, NULL, TSM_OUTBLOB_MAX);
+CONFIGFS_BIN_ATTR_RO(tsm_report_, outblob, NULL, TSM_REPORT_OUTBLOB_MAX);
 
 static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
 				       size_t count)
@@ -323,7 +323,7 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
 
 	return tsm_report_read(report, buf, count, TSM_CERTS);
 }
-CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
+CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_REPORT_OUTBLOB_MAX);
 
 static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
 					    size_t count)
@@ -332,7 +332,7 @@ static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
 
 	return tsm_report_read(report, buf, count, TSM_MANIFEST);
 }
-CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
+CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_REPORT_OUTBLOB_MAX);
 
 static struct configfs_attribute *tsm_report_attrs[] = {
 	[TSM_REPORT_GENERATION] = &tsm_report_attr_generation,
@@ -448,9 +448,9 @@ static struct configfs_subsystem tsm_configfs = {
 	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
 };
 
-int tsm_register(const struct tsm_ops *ops, void *priv)
+int tsm_report_register(const struct tsm_report_ops *ops, void *priv)
 {
-	const struct tsm_ops *conflict;
+	const struct tsm_report_ops *conflict;
 
 	guard(rwsem_write)(&tsm_rwsem);
 	conflict = provider.ops;
@@ -463,9 +463,9 @@ int tsm_register(const struct tsm_ops *ops, void *priv)
 	provider.data = priv;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(tsm_register);
+EXPORT_SYMBOL_GPL(tsm_report_register);
 
-int tsm_unregister(const struct tsm_ops *ops)
+int tsm_report_unregister(const struct tsm_report_ops *ops)
 {
 	guard(rwsem_write)(&tsm_rwsem);
 	if (ops != provider.ops)
@@ -474,11 +474,11 @@ int tsm_unregister(const struct tsm_ops *ops)
 	provider.data = NULL;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(tsm_unregister);
+EXPORT_SYMBOL_GPL(tsm_report_unregister);
 
 static struct config_group *tsm_report_group;
 
-static int __init tsm_init(void)
+static int __init tsm_report_init(void)
 {
 	struct config_group *root = &tsm_configfs.su_group;
 	struct config_group *tsm;
@@ -499,14 +499,14 @@ static int __init tsm_init(void)
 
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
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 11b0c525be30..431054810dca 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -6,17 +6,17 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 
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
@@ -24,10 +24,10 @@
  * @service_guid: optional service-provider service guid to attest
  * @service_manifest_version: optional service-provider service manifest version requested
  */
-struct tsm_desc {
+struct tsm_report_desc {
 	unsigned int privlevel;
 	size_t inblob_len;
-	u8 inblob[TSM_INBLOB_MAX];
+	u8 inblob[TSM_REPORT_INBLOB_MAX];
 	char *service_provider;
 	guid_t service_guid;
 	unsigned int service_manifest_version;
@@ -44,7 +44,7 @@ struct tsm_desc {
  * @manifestblob: (optional) manifest data associated with the report
  */
 struct tsm_report {
-	struct tsm_desc desc;
+	struct tsm_report_desc desc;
 	size_t outblob_len;
 	u8 *outblob;
 	size_t auxblob_len;
@@ -88,7 +88,7 @@ enum tsm_bin_attr_index {
 };
 
 /**
- * struct tsm_ops - attributes and operations for tsm instances
+ * struct tsm_report_ops - attributes and operations for tsm_report instances
  * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/provider
  * @privlevel_floor: convey base privlevel for nested scenarios
  * @report_new: Populate @report with the report blob and auxblob
@@ -99,7 +99,7 @@ enum tsm_bin_attr_index {
  * Implementation specific ops, only one is expected to be registered at
  * a time i.e. only one of "sev-guest", "tdx-guest", etc.
  */
-struct tsm_ops {
+struct tsm_report_ops {
 	const char *name;
 	unsigned int privlevel_floor;
 	int (*report_new)(struct tsm_report *report, void *data);
@@ -107,6 +107,6 @@ struct tsm_ops {
 	bool (*report_bin_attr_visible)(int n);
 };
 
-int tsm_register(const struct tsm_ops *ops, void *priv);
-int tsm_unregister(const struct tsm_ops *ops);
+int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
+int tsm_report_unregister(const struct tsm_report_ops *ops);
 #endif /* __TSM_H */


