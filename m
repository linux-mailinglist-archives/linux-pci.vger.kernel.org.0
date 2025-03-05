Return-Path: <linux-pci+bounces-22957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B8A4FB5D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 11:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC821884987
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 10:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945D7205AA0;
	Wed,  5 Mar 2025 10:11:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D40F2063E9
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169478; cv=none; b=MLDy/Ze5EVTMOtNsfZ9NlyLkkmPv2eVLm7yog2EIiot85EXAcVhij9WzujyuPDgXnHoyZjaeMINuwr3X0cBT9N4/i/T0mbgX69eDFUodKmB2Ee+xiRN/mCUr/O+Op4IY1aJSlZjG2bTZwsezKj5TdBeIXYmpMX7rNVfmfUnwua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169478; c=relaxed/simple;
	bh=w6ofQ3sQKiGe7AyArQE6iBm/xeGsF/xefSCZ/hL4NFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrzXy3yYbYYXdW0Eg3nRbpcW13lIUhNq3m70kPnkdfUVxj4ZYxyxu6BxV2fXGrLRuUY3kRlUKITuuptF15I4HV9jJ7lnxrAqkSGp/F0YWKe3+iFvlbBFarIxBxbtxhOjOzSbqixR+T+SpSgFKTjakTjTe9cihPh35RZ9AgF/jgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47464FEC;
	Wed,  5 Mar 2025 02:11:28 -0800 (PST)
Received: from [10.57.67.16] (unknown [10.57.67.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DCC83F673;
	Wed,  5 Mar 2025 02:11:12 -0800 (PST)
Message-ID: <96591703-e269-4da4-a5cd-0fd48c5f5181@arm.com>
Date: Wed, 5 Mar 2025 10:11:10 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] configfs-tsm: Namespace TSM report symbols
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Yilun Xu <yilun.xu@intel.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Sami Mujawar <sami.mujawar@arm.com>,
 Alexey Kardashevskiy <aik@amd.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, lukas@wunner.de
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107246021.1288555.7203769833791489618.stgit@dwillia2-xfh.jf.intel.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <174107246021.1288555.7203769833791489618.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2025 07:14, Dan Williams wrote:
> In preparation for new + common TSM (TEE Security Manager)
> infrastructure, namespace the TSM report symbols in tsm.h with an
> _REPORT suffix to differentiate them from other incoming tsm work.
> 
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Sami Mujawar <sami.mujawar@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  Documentation/ABI/testing/configfs-tsm-report   |    0 
>  MAINTAINERS                                     |    2 +
>  drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |    8 +++---
>  drivers/virt/coco/sev-guest/sev-guest.c         |   12 ++++-----
>  drivers/virt/coco/tdx-guest/tdx-guest.c         |    8 +++---
>  drivers/virt/coco/tsm.c                         |   32 ++++++++++++-----------
>  include/linux/tsm.h                             |   22 ++++++++--------
>  7 files changed, 42 insertions(+), 42 deletions(-)
>  rename Documentation/ABI/testing/{configfs-tsm => configfs-tsm-report} (100%)
> 
> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm-report
> similarity index 100%
> rename from Documentation/ABI/testing/configfs-tsm
> rename to Documentation/ABI/testing/configfs-tsm-report
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0736dc2ee0..38bcf530c2ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24115,7 +24115,7 @@ TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
>  M:	Dan Williams <dan.j.williams@intel.com>
>  L:	linux-coco@lists.linux.dev
>  S:	Maintained
> -F:	Documentation/ABI/testing/configfs-tsm
> +F:	Documentation/ABI/testing/configfs-tsm-report
>  F:	drivers/virt/coco/tsm.c
>  F:	include/linux/tsm.h
>  
> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> index 87f162736b2e..0c9ea24a200c 100644
> --- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> @@ -96,7 +96,7 @@ static int arm_cca_report_new(struct tsm_report *report, void *data)
>  	struct arm_cca_token_info info;
>  	void *buf;
>  	u8 *token __free(kvfree) = NULL;
> -	struct tsm_desc *desc = &report->desc;
> +	struct tsm_report_desc *desc = &report->desc;
>  
>  	if (desc->inblob_len < 32 || desc->inblob_len > 64)
>  		return -EINVAL;
> @@ -181,7 +181,7 @@ static int arm_cca_report_new(struct tsm_report *report, void *data)
>  	return ret;
>  }
>  
> -static const struct tsm_ops arm_cca_tsm_ops = {
> +static const struct tsm_report_ops arm_cca_tsm_ops = {
>  	.name = KBUILD_MODNAME,
>  	.report_new = arm_cca_report_new,
>  };
> @@ -202,7 +202,7 @@ static int __init arm_cca_guest_init(void)
>  	if (!is_realm_world())
>  		return -ENODEV;
>  
> -	ret = tsm_register(&arm_cca_tsm_ops, NULL);
> +	ret = tsm_report_register(&arm_cca_tsm_ops, NULL);
>  	if (ret < 0)
>  		pr_err("Error %d registering with TSM\n", ret);
>  
> @@ -216,7 +216,7 @@ module_init(arm_cca_guest_init);
>   */
>  static void __exit arm_cca_guest_exit(void)
>  {
> -	tsm_unregister(&arm_cca_tsm_ops);
> +	tsm_report_unregister(&arm_cca_tsm_ops);
>  }
>  module_exit(arm_cca_guest_exit);
>  
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 264b6523fe52..964ac8ed8fde 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -317,7 +317,7 @@ struct snp_msg_cert_entry {
>  static int sev_svsm_report_new(struct tsm_report *report, void *data)
>  {
>  	unsigned int rep_len, man_len, certs_len;
> -	struct tsm_desc *desc = &report->desc;
> +	struct tsm_report_desc *desc = &report->desc;
>  	struct svsm_attest_call ac = {};
>  	unsigned int retry_count;
>  	void *rep, *man, *certs;
> @@ -452,7 +452,7 @@ static int sev_svsm_report_new(struct tsm_report *report, void *data)
>  static int sev_report_new(struct tsm_report *report, void *data)
>  {
>  	struct snp_msg_cert_entry *cert_table;
> -	struct tsm_desc *desc = &report->desc;
> +	struct tsm_report_desc *desc = &report->desc;
>  	struct snp_guest_dev *snp_dev = data;
>  	struct snp_msg_report_resp_hdr hdr;
>  	const u32 report_size = SZ_4K;
> @@ -581,7 +581,7 @@ static bool sev_report_bin_attr_visible(int n)
>  	return false;
>  }
>  
> -static struct tsm_ops sev_tsm_ops = {
> +static struct tsm_report_ops sev_tsm_report_ops = {
>  	.name = KBUILD_MODNAME,
>  	.report_new = sev_report_new,
>  	.report_attr_visible = sev_report_attr_visible,
> @@ -590,7 +590,7 @@ static struct tsm_ops sev_tsm_ops = {
>  
>  static void unregister_sev_tsm(void *data)
>  {
> -	tsm_unregister(&sev_tsm_ops);
> +	tsm_report_unregister(&sev_tsm_report_ops);
>  }
>  
>  static int __init sev_guest_probe(struct platform_device *pdev)
> @@ -627,9 +627,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>  	misc->fops = &snp_guest_fops;
>  
>  	/* Set the privlevel_floor attribute based on the vmpck_id */
> -	sev_tsm_ops.privlevel_floor = mdesc->vmpck_id;
> +	sev_tsm_report_ops.privlevel_floor = mdesc->vmpck_id;
>  
> -	ret = tsm_register(&sev_tsm_ops, snp_dev);
> +	ret = tsm_report_register(&sev_tsm_report_ops, snp_dev);
>  	if (ret)
>  		goto e_msg_init;
>  
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index 224e7dde9cde..bd043838ab2e 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -161,7 +161,7 @@ static int tdx_report_new(struct tsm_report *report, void *data)
>  {
>  	u8 *buf, *reportdata = NULL, *tdreport = NULL;
>  	struct tdx_quote_buf *quote_buf = quote_data;
> -	struct tsm_desc *desc = &report->desc;
> +	struct tsm_report_desc *desc = &report->desc;
>  	int ret;
>  	u64 err;
>  
> @@ -297,7 +297,7 @@ static const struct x86_cpu_id tdx_guest_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>  
> -static const struct tsm_ops tdx_tsm_ops = {
> +static const struct tsm_report_ops tdx_tsm_ops = {
>  	.name = KBUILD_MODNAME,
>  	.report_new = tdx_report_new,
>  	.report_attr_visible = tdx_report_attr_visible,
> @@ -322,7 +322,7 @@ static int __init tdx_guest_init(void)
>  		goto free_misc;
>  	}
>  
> -	ret = tsm_register(&tdx_tsm_ops, NULL);
> +	ret = tsm_report_register(&tdx_tsm_ops, NULL);
>  	if (ret)
>  		goto free_quote;
>  
> @@ -339,7 +339,7 @@ module_init(tdx_guest_init);
>  
>  static void __exit tdx_guest_exit(void)
>  {
> -	tsm_unregister(&tdx_tsm_ops);
> +	tsm_report_unregister(&tdx_tsm_ops);
>  	free_quote_buf(quote_data);
>  	misc_deregister(&tdx_misc_dev);
>  }
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> index 9432d4e303f1..bcb515b50c68 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm.c
> @@ -13,7 +13,7 @@
>  #include <linux/configfs.h>
>  
>  static struct tsm_provider {
> -	const struct tsm_ops *ops;
> +	const struct tsm_report_ops *ops;
>  	void *data;
>  } provider;
>  static DECLARE_RWSEM(tsm_rwsem);
> @@ -98,7 +98,7 @@ static ssize_t tsm_report_privlevel_store(struct config_item *cfg,
>  	 * SEV-SNP GHCB) and a minimum of a TSM selected floor value no less
>  	 * than 0.
>  	 */
> -	if (provider.ops->privlevel_floor > val || val > TSM_PRIVLEVEL_MAX)
> +	if (provider.ops->privlevel_floor > val || val > TSM_REPORT_PRIVLEVEL_MAX)
>  		return -EINVAL;
>  
>  	guard(rwsem_write)(&tsm_rwsem);
> @@ -202,7 +202,7 @@ static ssize_t tsm_report_inblob_write(struct config_item *cfg,
>  	memcpy(report->desc.inblob, buf, count);
>  	return count;
>  }
> -CONFIGFS_BIN_ATTR_WO(tsm_report_, inblob, NULL, TSM_INBLOB_MAX);
> +CONFIGFS_BIN_ATTR_WO(tsm_report_, inblob, NULL, TSM_REPORT_INBLOB_MAX);
>  
>  static ssize_t tsm_report_generation_show(struct config_item *cfg, char *buf)
>  {
> @@ -272,7 +272,7 @@ static ssize_t tsm_report_read(struct tsm_report *report, void *buf,
>  			       size_t count, enum tsm_data_select select)
>  {
>  	struct tsm_report_state *state = to_state(report);
> -	const struct tsm_ops *ops;
> +	const struct tsm_report_ops *ops;
>  	ssize_t rc;
>  
>  	/* try to read from the existing report if present and valid... */
> @@ -314,7 +314,7 @@ static ssize_t tsm_report_outblob_read(struct config_item *cfg, void *buf,
>  
>  	return tsm_report_read(report, buf, count, TSM_REPORT);
>  }
> -CONFIGFS_BIN_ATTR_RO(tsm_report_, outblob, NULL, TSM_OUTBLOB_MAX);
> +CONFIGFS_BIN_ATTR_RO(tsm_report_, outblob, NULL, TSM_REPORT_OUTBLOB_MAX);
>  
>  static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
>  				       size_t count)
> @@ -323,7 +323,7 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
>  
>  	return tsm_report_read(report, buf, count, TSM_CERTS);
>  }
> -CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
> +CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_REPORT_OUTBLOB_MAX);
>  
>  static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
>  					    size_t count)
> @@ -332,7 +332,7 @@ static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
>  
>  	return tsm_report_read(report, buf, count, TSM_MANIFEST);
>  }
> -CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
> +CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_REPORT_OUTBLOB_MAX);
>  
>  static struct configfs_attribute *tsm_report_attrs[] = {
>  	[TSM_REPORT_GENERATION] = &tsm_report_attr_generation,
> @@ -448,9 +448,9 @@ static struct configfs_subsystem tsm_configfs = {
>  	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
>  };
>  
> -int tsm_register(const struct tsm_ops *ops, void *priv)
> +int tsm_report_register(const struct tsm_report_ops *ops, void *priv)
>  {
> -	const struct tsm_ops *conflict;
> +	const struct tsm_report_ops *conflict;
>  
>  	guard(rwsem_write)(&tsm_rwsem);
>  	conflict = provider.ops;
> @@ -463,9 +463,9 @@ int tsm_register(const struct tsm_ops *ops, void *priv)
>  	provider.data = priv;
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(tsm_register);
> +EXPORT_SYMBOL_GPL(tsm_report_register);
>  
> -int tsm_unregister(const struct tsm_ops *ops)
> +int tsm_report_unregister(const struct tsm_report_ops *ops)
>  {
>  	guard(rwsem_write)(&tsm_rwsem);
>  	if (ops != provider.ops)
> @@ -474,11 +474,11 @@ int tsm_unregister(const struct tsm_ops *ops)
>  	provider.data = NULL;
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(tsm_unregister);
> +EXPORT_SYMBOL_GPL(tsm_report_unregister);
>  
>  static struct config_group *tsm_report_group;
>  
> -static int __init tsm_init(void)
> +static int __init tsm_report_init(void)
>  {
>  	struct config_group *root = &tsm_configfs.su_group;
>  	struct config_group *tsm;
> @@ -499,14 +499,14 @@ static int __init tsm_init(void)
>  
>  	return 0;
>  }
> -module_init(tsm_init);
> +module_init(tsm_report_init);
>  
> -static void __exit tsm_exit(void)
> +static void __exit tsm_report_exit(void)
>  {
>  	configfs_unregister_default_group(tsm_report_group);
>  	configfs_unregister_subsystem(&tsm_configfs);
>  }
> -module_exit(tsm_exit);
> +module_exit(tsm_report_exit);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Provide Trusted Security Module attestation reports via configfs");
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 11b0c525be30..431054810dca 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -6,17 +6,17 @@
>  #include <linux/types.h>
>  #include <linux/uuid.h>
>  
> -#define TSM_INBLOB_MAX 64
> -#define TSM_OUTBLOB_MAX SZ_32K
> +#define TSM_REPORT_INBLOB_MAX 64
> +#define TSM_REPORT_OUTBLOB_MAX SZ_32K
>  
>  /*
>   * Privilege level is a nested permission concept to allow confidential
>   * guests to partition address space, 4-levels are supported.
>   */
> -#define TSM_PRIVLEVEL_MAX 3
> +#define TSM_REPORT_PRIVLEVEL_MAX 3
>  
>  /**
> - * struct tsm_desc - option descriptor for generating tsm report blobs
> + * struct tsm_report_desc - option descriptor for generating tsm report blobs
>   * @privlevel: optional privilege level to associate with @outblob
>   * @inblob_len: sizeof @inblob
>   * @inblob: arbitrary input data
> @@ -24,10 +24,10 @@
>   * @service_guid: optional service-provider service guid to attest
>   * @service_manifest_version: optional service-provider service manifest version requested
>   */
> -struct tsm_desc {
> +struct tsm_report_desc {
>  	unsigned int privlevel;
>  	size_t inblob_len;
> -	u8 inblob[TSM_INBLOB_MAX];
> +	u8 inblob[TSM_REPORT_INBLOB_MAX];
>  	char *service_provider;
>  	guid_t service_guid;
>  	unsigned int service_manifest_version;
> @@ -44,7 +44,7 @@ struct tsm_desc {
>   * @manifestblob: (optional) manifest data associated with the report
>   */
>  struct tsm_report {
> -	struct tsm_desc desc;
> +	struct tsm_report_desc desc;
>  	size_t outblob_len;
>  	u8 *outblob;
>  	size_t auxblob_len;
> @@ -88,7 +88,7 @@ enum tsm_bin_attr_index {
>  };
>  
>  /**
> - * struct tsm_ops - attributes and operations for tsm instances
> + * struct tsm_report_ops - attributes and operations for tsm_report instances
>   * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/provider
>   * @privlevel_floor: convey base privlevel for nested scenarios
>   * @report_new: Populate @report with the report blob and auxblob
> @@ -99,7 +99,7 @@ enum tsm_bin_attr_index {
>   * Implementation specific ops, only one is expected to be registered at
>   * a time i.e. only one of "sev-guest", "tdx-guest", etc.
>   */
> -struct tsm_ops {
> +struct tsm_report_ops {
>  	const char *name;
>  	unsigned int privlevel_floor;
>  	int (*report_new)(struct tsm_report *report, void *data);
> @@ -107,6 +107,6 @@ struct tsm_ops {
>  	bool (*report_bin_attr_visible)(int n);
>  };
>  
> -int tsm_register(const struct tsm_ops *ops, void *priv);
> -int tsm_unregister(const struct tsm_ops *ops);
> +int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
> +int tsm_report_unregister(const struct tsm_report_ops *ops);
>  #endif /* __TSM_H */
> 


