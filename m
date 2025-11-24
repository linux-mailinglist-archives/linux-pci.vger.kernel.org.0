Return-Path: <linux-pci+bounces-41925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F9CC7EF3E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 05:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDF83A4036
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 04:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF1729DB61;
	Mon, 24 Nov 2025 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODMg/sye"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD91FF7BC;
	Mon, 24 Nov 2025 04:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763959261; cv=none; b=n2zNpdWcIcmYJ4zbHOsTJIYq0lbzu7Kb3g0y3AG+Cuq9IV+e0td2MVgtabrBgr20DyutuIThNLEUzmHaOACbizY24jUN1W9gCOuXnUXWOaECzFH/Qzgfk/te9FffJkQqeOsBc+pMpZpsYG1EJD/Ncw3IHhyarO2UPap1p1Rgi5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763959261; c=relaxed/simple;
	bh=q9L+mFCqqi7OtLGPXEUseU0UCKPzyxnW6nIpa0CKEWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nTF6arRAB5m49j6ZMpghNHcFZCj1AZXLzc3mQUOb/8VYyGthRaNKVaV8lxJvNamGNiGlWU255b8lkLJB91+QpDM7Vzk63Z3I+/Y57bOEmiVFmlOYBOWYkxSJdoTtI1Mqyd+1c9qraGthdfUQfgJWsPYbEL2viOEOIivT36h5ehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODMg/sye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9491CC4CEFB;
	Mon, 24 Nov 2025 04:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763959259;
	bh=q9L+mFCqqi7OtLGPXEUseU0UCKPzyxnW6nIpa0CKEWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ODMg/syevllHhEnzaKfGzjSEJpEOc/Ue7UpzAHQ+v0IzF4+tStxbRm9BzaGdm2o3g
	 N0R9Zonj4rD6G1zKO6eaStxv0d64aHrcw4YJg+pkU+2a9SelEH0geeg06LDSDwy8uM
	 nTvhxRLzwDgWnj2etz0mRVJK7NhyByRJjy81tbw1MeejXIubSX9Z2+xjvOaLzgzn9G
	 woRvybjg8h3VxWowQzUX/OwClH8WFEuTGnle5/r8UBp9y6uuWFpdBUpckZ9qG8YjTF
	 ipUOb+D7nZ68A0WtOrjDPu7M2/qUv2tqCiobffTzSaHdtoMzpBjZ4Loh9+kfwAgIpp
	 Jsg/hrkzl0KVQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH v2 01/11] coco: guest: arm64: Guest TSM callback and
 realm device lock support
In-Reply-To: <20251119152201.00000876@huawei.com>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
 <20251117140007.122062-2-aneesh.kumar@kernel.org>
 <20251119152201.00000876@huawei.com>
Date: Mon, 24 Nov 2025 10:10:50 +0530
Message-ID: <yq5acy58m4a5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Mon, 17 Nov 2025 19:29:57 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>
>> Register the TSM callback when the DA feature is supported by RSI. The
>> build order is also adjusted so that the TSM class is created before the
>> arm-cca-guest driver is initialized.
>> 
>> In addition, add support for the TDISP lock sequence. Writing a TSM
>> (TEE Security Manager) device name from `/sys/class/tsm` into `tsm/lock`
>> triggers the realm device lock operation.
>> 
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Hi Aneesh,
>
> Some minor stuff in here.   One general comment is that there
> are some fixlets for the CCA code surrounding what this patch
> should focus on. Break those out as separate cleanup or base
> this on top of the fixed up version of that code.
>
> Thanks,
>
> Jonathan
>
>> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
>> index 1b716d18b80e..2ec0f5dff02e 100644
>> --- a/arch/arm64/kernel/rsi.c
>> +++ b/arch/arm64/kernel/rsi.c
>> @@ -15,6 +15,7 @@
>>  #include <asm/rsi.h>
>>  
>>  static struct realm_config config;
>> +static unsigned long rsi_feat_reg0;
>>  
>>  unsigned long prot_ns_shared;
>>  EXPORT_SYMBOL(prot_ns_shared);
>> @@ -22,6 +23,12 @@ EXPORT_SYMBOL(prot_ns_shared);
>>  DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
>>  EXPORT_SYMBOL(rsi_present);
>>  
>> +bool rsi_has_da_feature(void)
>> +{
>> +	return u64_get_bits(rsi_feat_reg0, RSI_FEATURE_REGISTER_0_DA);
>
> I'm not keen on mixing explicit size of a u64 with the implicit
> fact an unsigned long is effectively a u64.  Can we tidy up the types
> to match?
>

will switch rsi_feat_reg0 to static u64

>> +}
>> +EXPORT_SYMBOL_GPL(rsi_has_da_feature);
>
>> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
>> index cb52021912b3..57556d7c1cec 100644
>> --- a/drivers/virt/coco/Makefile
>> +++ b/drivers/virt/coco/Makefile
>> @@ -6,6 +6,6 @@ obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
>>  obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
>>  obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
>>  obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
>> -obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
>>  obj-$(CONFIG_TSM) 		+= tsm-core.o
>>  obj-$(CONFIG_TSM_GUEST)		+= guest/
>> +obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
>
> Check all patches for noise like this.  It may be a valid change but in this series
> it's just adding confusion.
>

This is required for the patch to work as intended. This patch adds
registration with TSM, which depends on the TSM class being created
before the arm_cca_guest driver is initialized. The commit message
provides further details.

"Register the TSM callback when the DA feature is supported by RSI. The
build order is also adjusted so that the TSM class is created before the
arm-cca-guest driver is initialized.""


>
>> diff --git a/drivers/virt/coco/arm-cca-guest/Kconfig b/drivers/virt/coco/arm-cca-guest/Kconfig
>> index a42359a90558..66b2d9202b66 100644
>> --- a/drivers/virt/coco/arm-cca-guest/Kconfig
>> +++ b/drivers/virt/coco/arm-cca-guest/Kconfig
>> @@ -1,11 +1,17 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +
>>  config ARM_CCA_GUEST
>>  	tristate "Arm CCA Guest driver"
>>  	depends on ARM64
>> +	depends on PCI_TSM
>>  	select TSM_REPORTS
>>  	select AUXILIARY_BUS
>> +	select TSM
>>  	help
>> -	  The driver provides userspace interface to request and
>> +	  The driver provides userspace interface to request an
>
> Push this fixlet to the series adding this or a follow up if that isn't being respun.
> Definitely shouldn't be in here.
>
>
>>  	  attestation report from the Realm Management Monitor(RMM).
>> +	  If the DA feature is supported, it also register with TSM framework.
>>  
>>  	  If you choose 'M' here, this module will be called
>>  	  arm-cca-guest.
>> diff --git a/drivers/virt/coco/arm-cca-guest/Makefile b/drivers/virt/coco/arm-cca-guest/Makefile
>> index 75a120e24fda..bc3b2be4019f 100644
>> --- a/drivers/virt/coco/arm-cca-guest/Makefile
>> +++ b/drivers/virt/coco/arm-cca-guest/Makefile
>> @@ -1,4 +1,5 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>> +#
>
> Stray change.
>
>>  obj-$(CONFIG_ARM_CCA_GUEST) += arm-cca-guest.o
>>  
>>  arm-cca-guest-y +=  arm-cca.o
>> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
>> index dc96171791db..288fa53ad0af 100644
>> --- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
>> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
>> @@ -1,6 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>>  /*
>> - * Copyright (C) 2023 ARM Ltd.
>> + * Copyright (C) 2025 ARM Ltd.
> Usually we just extend the date span rather than claiming everything is
> 2025. e.g.
>  * Copyright (C) 2023-2025 ARM Ltd.
>
>>   */
>
>> @@ -192,6 +194,57 @@ static void unregister_cca_tsm_report(void *data)
>>  	tsm_report_unregister(&arm_cca_tsm_report_ops);
>>  }
>>  
>> +static struct pci_tsm *cca_tsm_lock(struct tsm_dev *tsm_dev, struct pci_dev *pdev)
>> +{
>> +	int ret;
>> +
>> +	struct cca_guest_dsc *cca_dsc __free(kfree) =
>> +		kzalloc(sizeof(*cca_dsc), GFP_KERNEL);
>> +	if (!cca_dsc)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret = pci_tsm_devsec_constructor(pdev, &cca_dsc->pci, tsm_dev);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	return ERR_PTR(-EIO);
>
> Perhaps add a comment so you have something like
>
> 	return ERR_PTR(-EIO); /* For now always return an error */
>
> Just makes it a tiny bit easier to review as no need to go check this
> is removed in a later patch.
>
>
>> +}
>> +
>> +static void cca_tsm_unlock(struct pci_tsm *tsm)
>> +{
>> +	struct cca_guest_dsc *cca_dsc = to_cca_guest_dsc(tsm->pdev);
>> +
>> +	kfree(cca_dsc);
>> +}
>> +
>> +static struct pci_tsm_ops cca_devsec_pci_ops = {
>> +	.lock = cca_tsm_lock,
>> +	.unlock = cca_tsm_unlock,
>> +};
>> +
>> +static void cca_devsec_tsm_remove(void *tsm_dev)
>> +{
>> +	tsm_unregister(tsm_dev);
>> +}
>> +
>> +static int cca_devsec_tsm_register(struct auxiliary_device *adev)
>> +{
>> +	struct tsm_dev *tsm_dev;
>> +	int rc;
>> +
>> +	tsm_dev = tsm_register(&adev->dev, &cca_devsec_pci_ops);
>> +	if (IS_ERR(tsm_dev))
>> +		return PTR_ERR(tsm_dev);
>> +
>> +	rc = devm_add_action_or_reset(&adev->dev, cca_devsec_tsm_remove, tsm_dev);
>> +	if (rc) {
>> +		cca_devsec_tsm_remove(tsm_dev);
>
> Take a look at what the _or_reset() does in the devm_add_action_or_reset().
> Short story, you should not need this call if the devm machinery has returned
> an error.
>
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>
>> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
>> new file mode 100644
>> index 000000000000..5ad3b740710e
>> --- /dev/null
>> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
>
>> +static inline int rsi_vdev_id(struct pci_dev *pdev)
>> +{
>> +	return (pci_domain_nr(pdev->bus) << 16) |
>> +	       PCI_DEVID(pdev->bus->number, pdev->devfn);
>
> I'm struggling to find where this is actually defined in the various specs
> so good to have a reference in a comment here.
>

The vdev_id is provided by the host during the rmi_vdev_create
operation. In the Linux implementation, we use the guest_rid as the
vdev_id.

https://git.gitlab.arm.com/linux-arm/linux-cca/-/commit/3c55fc14480183f18c694e3d6054578830719d00#152a2139b6b88b07ff1e0f53e408a1d4158076a4_643_715


>> +}
>> +
>> +#endif

-aneesh

