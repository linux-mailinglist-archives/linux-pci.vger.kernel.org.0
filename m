Return-Path: <linux-pci+bounces-33193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FA6B1632F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 16:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CCB3AA622
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 14:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9BF2DBF7C;
	Wed, 30 Jul 2025 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="S+AevKxR"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1172DAFD2;
	Wed, 30 Jul 2025 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753887108; cv=none; b=Efm00fPKrCkpBpVdp9g2M1D5iAruLIuboVmPQeSSmEvuWIoYWlBcgwjA5uvBYIUUNHnabzcAowf/nnhm9CrwLMS7THN1VQZBYtncXLzEwCYi30hvIiYKxLjt4CM0hw8P1wdp1HuNJrDQLa+3JJC0ZCUWIv0YIYuJN1J3PxqseBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753887108; c=relaxed/simple;
	bh=q5UBGjR9V0TiCXYMpVi0Vb0FvsZJoTTs2TRMwSYwVUs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMjde1HUP014B4TLov1bHGTGvCDnmTAp0j2wmNsC3PrZInoBUKmZlNzk8NmHFhAZp9+JMCYgHAWad4oEc6y8gWLqw4X+pz6jQr0C9FhoEGWAjJ8doUglaefQspNFFBGYa13DIm8lKdKVe+mtFgTCp/gldJ2x2THHwKE5FlQCsXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=S+AevKxR; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3e5XihT0AEvE9k2vfKg6bdeeRMsMb3oRVgdt3JCiDtM=;
	b=S+AevKxRi9MUVpn74t6kjeavWhdteQg51A15oj30m5JwwkjOl5PC/1Y607tYITqkBiQXWAiED
	fV7vQhvClARLa59CSv/85rVK0fSuTOgfv+1mmxjf6MIGKPzJfXpW4T8WOwExmI7nRVKNJPJg6c6
	xrMD/2lZi/pqrz5Lc5s1WuY=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bsZrK4g6XzN0s6;
	Wed, 30 Jul 2025 22:50:09 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsZrC0pGdz6M4Zg;
	Wed, 30 Jul 2025 22:50:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DFD01402EA;
	Wed, 30 Jul 2025 22:51:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 16:51:38 +0200
Date: Wed, 30 Jul 2025 15:51:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 32/38] coco: guest: arm64: Add support for guest
 initiated TDI bind/unbind
Message-ID: <20250730155136.00003d5f@huawei.com>
In-Reply-To: <20250728135216.48084-33-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-33-aneesh.kumar@kernel.org>
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

On Mon, 28 Jul 2025 19:22:09 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Add RHI for VDEV_SET_TDI_STATE
> 
> Note: This is not part of RHI spec. This is a POC implementation
> and will be later switced to correct interface defined by RHI.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

A few minor comments. 

Maybe we need some discussion of how this is used.

> diff --git a/arch/arm64/kernel/rhi.c b/arch/arm64/kernel/rhi.c
> new file mode 100644
> index 000000000000..3685b50c2e94
> --- /dev/null
> +++ b/arch/arm64/kernel/rhi.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 ARM Ltd.
> + */
> +
> +#include <asm/memory.h>
> +#include <asm/string.h>
> +#include <asm/rsi.h>
> +#include <asm/rhi.h>
> +
> +#include <linux/slab.h>
> +
> +long rhi_da_vdev_set_tdi_state(unsigned long guest_rid, unsigned long target_state)
> +{
> +	long ret;
> +	struct rsi_host_call *rhi_call;
> +
> +	rhi_call = kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
	struct rsi_host_call *rhi_call __free(kfree) =
		kmalloc(sizeof(*rhi_call), GFP_KERNEL);

then direct returns on errors.

> +	if (!rhi_call)
> +		return -ENOMEM;
> +
> +	rhi_call->imm = 0;
> +	rhi_call->gprs[0] = RHI_DA_VDEV_SET_TDI_STATE;
> +	rhi_call->gprs[1] = guest_rid;
> +	rhi_call->gprs[2] = target_state;
> +
> +	ret = rsi_host_call(virt_to_phys(rhi_call));
> +	if (ret != RSI_SUCCESS)
> +		ret =  -EIO;
> +	else
> +		ret = rhi_call->gprs[0];
> +
> +	kfree(rhi_call);
> +	return ret;
> +}
> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
> index 2c0190bcb2a9..de70fba09e92 100644
> --- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
> @@ -222,11 +222,20 @@ static void cca_tsm_pci_remove(struct pci_tsm *tsm)
>  
>  static int cca_tsm_lock(struct pci_dev *pdev)
>  {
> -	unsigned long ret;
> +	long ret;

Push this earlier. It doesn't do any harm that I can see and will reduce churn

> +	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
> +		PCI_DEVID(pdev->bus->number, pdev->devfn);
>  
> +	ret = rhi_da_vdev_set_tdi_state(vdev_id, RHI_DA_TDI_CONFIG_LOCKED);
> +	if (ret) {
> +		pci_err(pdev, "failed to TSM bind the device (%ld)\n", ret);
> +		return -EIO;
> +	}
> +
> +	/* This will be done by above rhi in later spec */
>  	ret = rsi_device_lock(pdev);
>  	if (ret) {
> -		pci_err(pdev, "failed to lock the device (%lu)\n", ret);
> +		pci_err(pdev, "failed to lock the device (%ld)\n", ret);
>  		return -EIO;
>  	}
>  	return 0;

>  
>  static const struct pci_tsm_ops cca_pci_ops = {
> diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
> index 0807fcf8d222..18d0a627baa4 100644
> --- a/drivers/virt/coco/arm-cca-host/arm-cca.c
> +++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
> @@ -254,9 +254,13 @@ static struct pci_tdi *cca_tsm_bind(struct pci_dev *pdev, struct pci_dev *pf0_de
>  static void cca_tsm_unbind(struct pci_tdi *tdi)
>  {
>  	struct realm *realm = &tdi->kvm->arch.realm;
> -
> +	/*
> +	 * FIXME!!
> +	 * All the related DEV RIPAS regions should be unmapped by now.
> +	 * For now we handle them during stage2 teardown. There is no
> +	 * bound IPA address available here. Possibly dmabuf can help
> +	 */
>  	rme_unbind_vdev(realm, tdi->pdev, tdi->pdev->tsm->dsm_dev);
> -

Tidy up these whitespace changes.  Just adds noise.

>  	module_put(THIS_MODULE);
>  }
>  


