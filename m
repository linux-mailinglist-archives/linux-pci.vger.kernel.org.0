Return-Path: <linux-pci+bounces-41652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD044C6FB89
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A686C2DC2F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7BD2E92B3;
	Wed, 19 Nov 2025 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Q6XYebHb"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0F42E92D0;
	Wed, 19 Nov 2025 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566975; cv=none; b=SMTQRzwFdNr5pErZE+M3fkF2NgVb0OMV7ADH1dbGT7Xz7HFVAPe/ltZtpFtQYNsEfvD30Le01h3V5wyg8blUN186uS5xtS+3OfwAEk7EelsCYUTng4k5ammSZYt+SFObHDbHCRjDEbEbfg0NaJkEZpt25oZ1IviL0eepIIy6YHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566975; c=relaxed/simple;
	bh=35vOJPyrgKb+9cfdez7P0ePWSzUKBrJup9U4Y+XzUhU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8ugphzLd/9R/oHa5ijz8lNROcErroNK2fvBoKMujnY1otc6aOhiNmjBeS8RYYh05o4Zm/68YZbNuxJGd0oaHpD85doVu/k20VCjOsf1GhUOlNMsfN8ZLQ9mNzHSJFP3btkoGSF1og5L9onSKhO1VNfVEsLSD06oZayAMAaCutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Q6XYebHb; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4KQ60AZkRR436n3z62l8wSAm4xK4aGrP18HCQEaGmFI=;
	b=Q6XYebHbPap5JMYIPqzRsnJ0QvPVtJvZHbN2hIehZnC6wg1n94G2W6lCweazDWEVFr+nUIDUR
	jaMCNXyMHIVgELx9VoVzTuCPm1H/aAfEp8lPKvKw+4Sod7xAadtW/ESkE3Nbjby+7qmrqUH5/to
	GKTFGP5Mr5INoRWoVKDwG9c=
Received: from frasgout.his.huawei.com (unknown [172.18.146.32])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dBQD415Jjz1P7G1;
	Wed, 19 Nov 2025 23:20:51 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dBQDq3W4VzHnH4l;
	Wed, 19 Nov 2025 23:21:31 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B0B81402ED;
	Wed, 19 Nov 2025 23:22:04 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 19 Nov
 2025 15:22:03 +0000
Date: Wed, 19 Nov 2025 15:22:01 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH v2 01/11] coco: guest: arm64: Guest TSM callback and
 realm device lock support
Message-ID: <20251119152201.00000876@huawei.com>
In-Reply-To: <20251117140007.122062-2-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
	<20251117140007.122062-2-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 17 Nov 2025 19:29:57 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Register the TSM callback when the DA feature is supported by RSI. The
> build order is also adjusted so that the TSM class is created before the
> arm-cca-guest driver is initialized.
> 
> In addition, add support for the TDISP lock sequence. Writing a TSM
> (TEE Security Manager) device name from `/sys/class/tsm` into `tsm/lock`
> triggers the realm device lock operation.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Hi Aneesh,

Some minor stuff in here.   One general comment is that there
are some fixlets for the CCA code surrounding what this patch
should focus on. Break those out as separate cleanup or base
this on top of the fixed up version of that code.

Thanks,

Jonathan

> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
> index 1b716d18b80e..2ec0f5dff02e 100644
> --- a/arch/arm64/kernel/rsi.c
> +++ b/arch/arm64/kernel/rsi.c
> @@ -15,6 +15,7 @@
>  #include <asm/rsi.h>
>  
>  static struct realm_config config;
> +static unsigned long rsi_feat_reg0;
>  
>  unsigned long prot_ns_shared;
>  EXPORT_SYMBOL(prot_ns_shared);
> @@ -22,6 +23,12 @@ EXPORT_SYMBOL(prot_ns_shared);
>  DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
>  EXPORT_SYMBOL(rsi_present);
>  
> +bool rsi_has_da_feature(void)
> +{
> +	return u64_get_bits(rsi_feat_reg0, RSI_FEATURE_REGISTER_0_DA);

I'm not keen on mixing explicit size of a u64 with the implicit
fact an unsigned long is effectively a u64.  Can we tidy up the types
to match?
 
> +}
> +EXPORT_SYMBOL_GPL(rsi_has_da_feature);

> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> index cb52021912b3..57556d7c1cec 100644
> --- a/drivers/virt/coco/Makefile
> +++ b/drivers/virt/coco/Makefile
> @@ -6,6 +6,6 @@ obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
>  obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
>  obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
>  obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
> -obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
>  obj-$(CONFIG_TSM) 		+= tsm-core.o
>  obj-$(CONFIG_TSM_GUEST)		+= guest/
> +obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/

Check all patches for noise like this.  It may be a valid change but in this series
it's just adding confusion.

> diff --git a/drivers/virt/coco/arm-cca-guest/Kconfig b/drivers/virt/coco/arm-cca-guest/Kconfig
> index a42359a90558..66b2d9202b66 100644
> --- a/drivers/virt/coco/arm-cca-guest/Kconfig
> +++ b/drivers/virt/coco/arm-cca-guest/Kconfig
> @@ -1,11 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +
>  config ARM_CCA_GUEST
>  	tristate "Arm CCA Guest driver"
>  	depends on ARM64
> +	depends on PCI_TSM
>  	select TSM_REPORTS
>  	select AUXILIARY_BUS
> +	select TSM
>  	help
> -	  The driver provides userspace interface to request and
> +	  The driver provides userspace interface to request an

Push this fixlet to the series adding this or a follow up if that isn't being respun.
Definitely shouldn't be in here.

>  	  attestation report from the Realm Management Monitor(RMM).
> +	  If the DA feature is supported, it also register with TSM framework.
>  
>  	  If you choose 'M' here, this module will be called
>  	  arm-cca-guest.
> diff --git a/drivers/virt/coco/arm-cca-guest/Makefile b/drivers/virt/coco/arm-cca-guest/Makefile
> index 75a120e24fda..bc3b2be4019f 100644
> --- a/drivers/virt/coco/arm-cca-guest/Makefile
> +++ b/drivers/virt/coco/arm-cca-guest/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +#

Stray change.

>  obj-$(CONFIG_ARM_CCA_GUEST) += arm-cca-guest.o
>  
>  arm-cca-guest-y +=  arm-cca.o
> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
> index dc96171791db..288fa53ad0af 100644
> --- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (C) 2023 ARM Ltd.
> + * Copyright (C) 2025 ARM Ltd.
Usually we just extend the date span rather than claiming everything is
2025. e.g.
 * Copyright (C) 2023-2025 ARM Ltd.

>   */

> @@ -192,6 +194,57 @@ static void unregister_cca_tsm_report(void *data)
>  	tsm_report_unregister(&arm_cca_tsm_report_ops);
>  }
>  
> +static struct pci_tsm *cca_tsm_lock(struct tsm_dev *tsm_dev, struct pci_dev *pdev)
> +{
> +	int ret;
> +
> +	struct cca_guest_dsc *cca_dsc __free(kfree) =
> +		kzalloc(sizeof(*cca_dsc), GFP_KERNEL);
> +	if (!cca_dsc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = pci_tsm_devsec_constructor(pdev, &cca_dsc->pci, tsm_dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return ERR_PTR(-EIO);

Perhaps add a comment so you have something like

	return ERR_PTR(-EIO); /* For now always return an error */

Just makes it a tiny bit easier to review as no need to go check this
is removed in a later patch.

> +}
> +
> +static void cca_tsm_unlock(struct pci_tsm *tsm)
> +{
> +	struct cca_guest_dsc *cca_dsc = to_cca_guest_dsc(tsm->pdev);
> +
> +	kfree(cca_dsc);
> +}
> +
> +static struct pci_tsm_ops cca_devsec_pci_ops = {
> +	.lock = cca_tsm_lock,
> +	.unlock = cca_tsm_unlock,
> +};
> +
> +static void cca_devsec_tsm_remove(void *tsm_dev)
> +{
> +	tsm_unregister(tsm_dev);
> +}
> +
> +static int cca_devsec_tsm_register(struct auxiliary_device *adev)
> +{
> +	struct tsm_dev *tsm_dev;
> +	int rc;
> +
> +	tsm_dev = tsm_register(&adev->dev, &cca_devsec_pci_ops);
> +	if (IS_ERR(tsm_dev))
> +		return PTR_ERR(tsm_dev);
> +
> +	rc = devm_add_action_or_reset(&adev->dev, cca_devsec_tsm_remove, tsm_dev);
> +	if (rc) {
> +		cca_devsec_tsm_remove(tsm_dev);

Take a look at what the _or_reset() does in the devm_add_action_or_reset().
Short story, you should not need this call if the devm machinery has returned
an error.

> +		return rc;
> +	}
> +
> +	return 0;
> +}

> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
> new file mode 100644
> index 000000000000..5ad3b740710e
> --- /dev/null
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h

> +static inline int rsi_vdev_id(struct pci_dev *pdev)
> +{
> +	return (pci_domain_nr(pdev->bus) << 16) |
> +	       PCI_DEVID(pdev->bus->number, pdev->devfn);

I'm struggling to find where this is actually defined in the various specs
so good to have a reference in a comment here.

> +}
> +
> +#endif


