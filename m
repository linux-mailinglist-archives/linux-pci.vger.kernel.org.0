Return-Path: <linux-pci+bounces-39691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8FDC1C96A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748F962511C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDAD34B41C;
	Wed, 29 Oct 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eKHN5ZZc"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379634A764;
	Wed, 29 Oct 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757892; cv=none; b=S9DiEDGeddz3uoorlu8G+tIQO9RpmS5TnC/qd+H0kXXgCGs8MMR4C+7noMUpgTQe7PI4uhtadPdBfUEHm7h5N2KU9HHnkqi9hmG0kMRXv8OfkpgDDcl1RCLzoMCnwFeJxYIKCeitFeyciux/rlbHNKApbASdiFFUfsZDPUGtSlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757892; c=relaxed/simple;
	bh=3rK+2Lf2CS8bJ6cBhy6SBGNQ1yb3I/wHVyymNKzVbOI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ol7iy416qkejWSHru1HhgcuA7gTcTbzIN8TJA3ViGgosjwHdS5x+HnUHhknKWOVnh/hPm6kXJzMkMFLRIg2LZS0q/hmUaS6ToUDxRqyrjMwLngKtXsJNk4hvq41WWdAp2BodWb5k8lm1eh6lIgPSfq7acHCmdkFg12LN4vffFGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eKHN5ZZc; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jeo6LUzggibCHIvEM7dRLIdNLfBAoszSPLv8+HQ7B9I=;
	b=eKHN5ZZcCa11i6mBcZaZdFwuAv3pds/X8idkrPZx8vkUiuHTonBZKI4bxI1dD92M3ns9Ezcod
	WWxvwqDdfE7JYB7JwI/4HnfbSF0E4aYVbeWnyaufm9lrP3BpdxfF8M4ROfwpPZ8/1UPYeHWBtVJ
	1nkffR6+UIIUx+xOUtGdfoc=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cxYDY30j9zMxvm;
	Thu, 30 Oct 2025 00:51:41 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cxY8x6l2cz6M4Zj;
	Thu, 30 Oct 2025 00:48:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E028514025A;
	Thu, 30 Oct 2025 00:52:24 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 16:52:23 +0000
Date: Wed, 29 Oct 2025 16:52:22 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Jeremy Linton
	<jeremy.linton@arm.com>, Greg KH <gregkh@linuxfoundation.org>, Mark Rutland
	<mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Sudeep
 Holla" <sudeep.holla@arm.com>
Subject: Re: [PATCH RESEND v2 02/12] firmware: smccc: coco: Manage arm-smccc
 platform device and CCA auxiliary drivers
Message-ID: <20251029165222.00004c06@huawei.com>
In-Reply-To: <20251027095602.1154418-3-aneesh.kumar@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
	<20251027095602.1154418-3-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 27 Oct 2025 15:25:52 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Make the SMCCC driver responsible for registering the arm-smccc platform
> device and after confirming the relevant SMCCC function IDs, create
> the arm_cca_guest auxiliary device.
> 
> Also update the arm-cca-guest driver to use the auxiliary device
> interface instead of the platform device (arm-cca-dev). The removal of
> the platform device registration will follow in a subsequent patch,
> allowing this change to be applied without immediately breaking existing
> userspace dependencies [1].
> 
> [1] https://lore.kernel.org/all/4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm64/include/asm/rsi.h                  |  2 +-
>  arch/arm64/kernel/rsi.c                       |  2 +-
>  drivers/firmware/smccc/Kconfig                |  1 +
>  drivers/firmware/smccc/smccc.c                | 37 ++++++++++++
>  drivers/virt/coco/arm-cca-guest/Kconfig       |  1 +
>  drivers/virt/coco/arm-cca-guest/Makefile      |  2 +
>  .../{arm-cca-guest.c => arm-cca.c}            | 57 +++++++++----------
>  7 files changed, 71 insertions(+), 31 deletions(-)
>  rename drivers/virt/coco/arm-cca-guest/{arm-cca-guest.c => arm-cca.c} (85%)
> 

> diff --git a/drivers/firmware/smccc/Kconfig b/drivers/firmware/smccc/Kconfig
> index 15e7466179a6..2b6984757241 100644
> --- a/drivers/firmware/smccc/Kconfig
> +++ b/drivers/firmware/smccc/Kconfig
> @@ -8,6 +8,7 @@ config HAVE_ARM_SMCCC
>  config HAVE_ARM_SMCCC_DISCOVERY
>  	bool
>  	depends on ARM_PSCI_FW
> +	select AUXILIARY_BUS
>  	default y
>  	help
>  	 SMCCC v1.0 lacked discoverability and hence PSCI v1.0 was updated
> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
> index bdee057db2fd..3dbf0d067cc5 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
> @@ -10,7 +10,12 @@
>  #include <linux/arm-smccc.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
> +#include <linux/auxiliary_bus.h>
> +
>  #include <asm/archrandom.h>
> +#ifdef CONFIG_ARM64
> +#include <asm/rsi_cmds.h>
> +#endif
>  
>  static u32 smccc_version = ARM_SMCCC_VERSION_1_0;
>  static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
> @@ -81,10 +86,42 @@ bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
>  }
>  EXPORT_SYMBOL_GPL(arm_smccc_hypervisor_has_uuid);
>  
> +#ifdef CONFIG_ARM64

I'm not keen on seeing ifdefs in a file where it isn't already local style.
This is probably better done with a second c file, appropriate header
and Kconfig / Makefile magic to control whether it is built.

> +static void __init register_rsi_device(struct platform_device *pdev)
> +{
> +	unsigned long ver_lower, ver_higher;
> +	unsigned long ret = rsi_request_version(RSI_ABI_VERSION,
> +						&ver_lower,
> +						&ver_higher);
> +
> +	if (ret == RSI_SUCCESS)
Better to have error case out of line.
	if (ret != RSI_SUCCESS)
		return;

	__devm_auxiliary_device_create(

It's both more natural for reviewers of the code and makes it easier to stick
other things after this code later if that makes sense.

> +		__devm_auxiliary_device_create(&pdev->dev,
> +					"arm_cca_guest", RSI_DEV_NAME, NULL, 0);
> +
> +}
> +#else
> +static void __init register_rsi_device(struct platform_device *pdev)
> +{
> +
> +}
> +#endif

> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
> similarity index 85%
> rename from drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> rename to drivers/virt/coco/arm-cca-guest/arm-cca.c
> index 0c9ea24a200c..dc96171791db 100644
> --- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c


> +static int cca_devsec_tsm_probe(struct auxiliary_device *adev,
> +				const struct auxiliary_device_id *id)
>  {
>  	int ret;
>  
>  	if (!is_realm_world())
>  		return -ENODEV;
>  
> -	ret = tsm_report_register(&arm_cca_tsm_ops, NULL);
> -	if (ret < 0)
> +	ret = tsm_report_register(&arm_cca_tsm_report_ops, NULL);
> +	if (ret < 0) {
>  		pr_err("Error %d registering with TSM\n", ret);

We have a device, so maybe flip to dev_err() or better yet

		return dev_err_probe(&adev->dev, ret, "Error registering with TSM\n");

That's convenient to use in a probe() even if the deferral bits are relevant and
it prints a nice string for the ret.

> +		return ret;
> +	}
>  
> -	return ret;
> -}
> -module_init(arm_cca_guest_init);
> +	ret = devm_add_action_or_reset(&adev->dev, unregister_cca_tsm_report, NULL);
> +	if (ret < 0) {
> +		pr_err("Error %d registering devm action\n", ret);

 return dev_err_probe() here as well.


> +		return ret;




