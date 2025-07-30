Return-Path: <linux-pci+bounces-33183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F37B16264
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 16:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B8A1758CB
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D2B2D9792;
	Wed, 30 Jul 2025 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="d49OAesV"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715FD293B73;
	Wed, 30 Jul 2025 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884742; cv=none; b=UvvhyXp8L8M2XoeWJtgDkHlpyBztbp3hT6wfCL0TIMqG+v8bVWfoGlv3eNIdBOsilG6Rkj2bGRk3bxuSHEoUQF0qYO8T3onwWEETTTXkUGE2s0tgOgDbMgeqy2AgCn034tF9g5N+Bxmu1lLeLwU2acG66ziKfPep3wjGJH5auUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884742; c=relaxed/simple;
	bh=FnF8VVXpsf0elTtW1MVrpsaBFVw5HQtUAi1uoTrL/bM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HoG7nhOIx4uv+d23EkWrtF8LW6HbesSRxOJU7qM6t8DBJdgru/+6p9JPPxiKesdObgXq/9ox89+X5alDNHJ8dflJC6ggvdaBaqrfxgn1diqJoBfhP8ugRi5WUjktXWRnCHJe8O3Sb9+N4A0dGpVX6hlkoQ9RVb+15Am3vwDatW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=d49OAesV; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rnKJOemjuP5Xg5HbHXYLFZEKz9QtU6z3Nm8VAYS2Rxs=;
	b=d49OAesV1hJFADPPK6DUoa2HCz4eYDscv8fBUcrom6MKN3zW2XE1kDnw+dVbQgJhFsoivt66p
	tAK6BUycGsekDHR8KXXb158Nq3GjhuCS8og8DXa9MC8SrJ8WL7jO9uKf4gA3/cg0AUtJQVURmRz
	pISFBlfKb9m/YFLegvOi77Y=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bsYyq6mJlzMksT;
	Wed, 30 Jul 2025 22:10:43 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsYyj2j5kz6M4T9;
	Wed, 30 Jul 2025 22:10:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7239A1401DC;
	Wed, 30 Jul 2025 22:12:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 16:12:12 +0200
Date: Wed, 30 Jul 2025 15:12:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 20/38] coco: host: arm64: Add support for
 creating a virtual device
Message-ID: <20250730151210.00002ead@huawei.com>
In-Reply-To: <20250728135216.48084-21-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-21-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Jul 2025 19:21:57 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Changes to support the creation of virtual device objects with RMM.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Hi Aneesh,

Really trivial stuff in this one.

> diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
> index 4a5ba98c1c0d..e5238b271493 100644
> --- a/arch/arm64/include/asm/rmi_smc.h
> +++ b/arch/arm64/include/asm/rmi_smc.h
> @@ -53,6 +53,8 @@
>  #define SMC_RMI_PDEV_GET_STATE		SMC_RMI_CALL(0x0178)
>  #define SMC_RMI_PDEV_SET_PUBKEY		SMC_RMI_CALL(0x017b)
>  #define SMC_RMI_PDEV_STOP		SMC_RMI_CALL(0x017c)
> +#define SMC_RMI_VDEV_CREATE		SMC_RMI_CALL(0x0187)
> +

One blankl line probably enough.

>  
>  #define RMI_ABI_MAJOR_VERSION	1

t/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
> index c65b81f0706f..2da513f45974 100644
> --- a/drivers/virt/coco/arm-cca-host/arm-cca.c
> +++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
> @@ -10,6 +10,8 @@
>  #include <linux/pci.h>
>  #include <linux/tsm.h>
>  #include <linux/vmalloc.h>
> +#include <linux/kvm_host.h>
> +#include <linux/pci.h>
>  
>  #include "rmm-da.h"
>  
> @@ -221,11 +223,39 @@ static void cca_tsm_disconnect(struct pci_dev *pdev)
>  	free_dev_communication_buffers(&dsc_pf0->comm_data);
>  }
>  
> +static struct pci_tdi *cca_tsm_bind(struct pci_dev *pdev, struct pci_dev *pf0_dev,
> +				    struct kvm *kvm, u64 tdi_id)
> +{
> +	void *rmm_vdev;
> +	struct cca_host_tdi *host_tdi __free(kfree) = NULL;

Move declaration and registration of destructor down to where it's
constructed. (Follow guidance in cleanup.h.

> +	struct realm *realm = &kvm->arch.realm;
> +
> +	if (pdev->is_virtfn)
> +		return ERR_PTR(-ENXIO);
> +
> +	if (!try_module_get(THIS_MODULE))
> +		return ERR_PTR(-ENXIO);
> +
> +	host_tdi = kmalloc(sizeof(struct cca_host_tdi), GFP_KERNEL);
> +	if (!host_tdi)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rmm_vdev = rme_create_vdev(realm, pdev, pf0_dev, tdi_id);
> +	if (!IS_ERR_OR_NULL(rmm_vdev)) {
> +		host_tdi->rmm_vdev = rmm_vdev;
> +		return &no_free_ptr(host_tdi)->tdi;
> +	}
> +
> +	module_put(THIS_MODULE);
> +	return rmm_vdev;
> +}
> +
>  static const struct pci_tsm_ops cca_pci_ops = {
>  	.probe = cca_tsm_pci_probe,
>  	.remove = cca_tsm_pci_remove,
>  	.connect = cca_tsm_connect,
>  	.disconnect = cca_tsm_disconnect,
> +	.bind	= cca_tsm_bind,
Odd spacing.  Seems just bind is using a tab.

>  };


