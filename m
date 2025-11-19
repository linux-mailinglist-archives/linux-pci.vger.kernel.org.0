Return-Path: <linux-pci+bounces-41657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B55FC6FF11
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 17:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BBF4366CAC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559BD327C09;
	Wed, 19 Nov 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iUTHAB35"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4242636E548;
	Wed, 19 Nov 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567537; cv=none; b=qkzUQQREDEUZ1/h1HhmfZHbULQAVFlk+hyYR9y2jp2S0mYGeVronYkvLMOknBUPSRGlHT9a+in467SmZL50wejNKKEM6KZHKLzYwQgIRy/O0bQH3PIjG4+6DdKH+QydfeRO5iePiJRQMx9YF4DF6Y5B5xDN3CwWxBnaF0fEUhLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567537; c=relaxed/simple;
	bh=bSdaB7lW1lSi0E0gZSaghl+2XjuxCB5jAB+RWuHLNLM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iC7d7lqNjdMFAuQnrWpYoBk/TrZGpkNBx7oA27MZNiL8h4PjH4RROixdUOPkvHAHVFbLyaZawyu8BUxR3J2Eaxif+JQwUapHzmRFqCXlD2qKJXp6azZnz+GUmUY9NobxqCTJFh07WEd5PJtT0mqbOyiPIUCNc3AFd4QRwlZCuPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iUTHAB35; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=q3clo3KyFTEVc2h7pK2fYPAaOgWyuzbjKCRKWYR9BsM=;
	b=iUTHAB35Yh/j/CFTThTRZUBtsSSPrLIPJKaAAERqScHT9wanJafLG8Yj/CVg2EvEO+K+6soID
	HMO0JIU7KRXMpp0pw8XFLn7IIVyAurdy4sWSFT1OqLFF8OO7CHUoB+IygjGIdX8pG1MCez2i8h1
	Cea/8ZF59AKmPkbHvMQK3rk=
Received: from frasgout.his.huawei.com (unknown [172.18.146.32])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dBQRd1dkpz1vnLd;
	Wed, 19 Nov 2025 23:30:53 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dBQSK2DhDzHnGgk;
	Wed, 19 Nov 2025 23:31:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F53A14033C;
	Wed, 19 Nov 2025 23:32:02 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 19 Nov
 2025 15:32:01 +0000
Date: Wed, 19 Nov 2025 15:32:00 +0000
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
Subject: Re: [PATCH v2 02/11] coco: guest: arm64: Add Realm Host Interface
 and guest DA helper
Message-ID: <20251119153200.00007fd0@huawei.com>
In-Reply-To: <20251117140007.122062-3-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
	<20251117140007.122062-3-aneesh.kumar@kernel.org>
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

On Mon, 17 Nov 2025 19:29:58 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> - describe the Realm Host Interface SMC IDs and result codes in a new
>   `asm/rhi.h` header
> - expose `struct rsi_host_call` plus an `rsi_host_call()` helper so we can
>   invoke `SMC_RSI_HOST_CALL` from C code
> - build a guest-side `rhi-da` helper that drives the vdev TDI state machine
>   via RHI host calls and translates the firmware status codes
> 
> This provides the basic RHI plumbing that later DA features rely on.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Hi Aneesh, minor comments follow.

> diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.c b/drivers/virt/coco/arm-cca-guest/rhi-da.c
> new file mode 100644
> index 000000000000..3430d8df4424
> --- /dev/null
> +++ b/drivers/virt/coco/arm-cca-guest/rhi-da.c
...

> +
> +bool rhi_has_da_support(void)
> +{
> +	int ret;
> +	struct rsi_host_call *rhicall;
> +
> +	rhicall = kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);

Doesn't look to be passed out anywhere, so not obvious why the lifetime
of this extends beyond this function.  Maybe I'm missing something.

> +	if (!rhicall)
> +		return -ENOMEM;
> +
> +	rhicall->imm = 0;
> +	rhicall->gprs[0] = RHI_DA_FEATURES;
> +
> +	ret = rsi_host_call(virt_to_phys(rhicall));
> +	if (ret != RSI_SUCCESS || rhicall->gprs[0] == SMCCC_RET_NOT_SUPPORTED)
> +		return false;
> +
> +	/* For base DA to work we need these to be supported */
> +	if ((rhicall->gprs[0] & RHI_DA_BASE_FEATURE) == RHI_DA_BASE_FEATURE)
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline int rhi_vdev_continue(unsigned long vdev_id, unsigned long cookie)
> +{
> +	unsigned long ret;
> +
> +	struct rsi_host_call *rhi_call __free(kfree) =
> +		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);

sizeof(*rhi_call)  Same for all other cases of this.

> +	if (!rhi_call)
> +		return -ENOMEM;
> +
> +	rhi_call->imm = 0;
> +	rhi_call->gprs[0] = RHI_DA_VDEV_CONTINUE;
> +	rhi_call->gprs[1] = vdev_id;
> +	rhi_call->gprs[2] = cookie;
> +
> +	ret = rsi_host_call(virt_to_phys(rhi_call));
> +	if (ret != RSI_SUCCESS)
> +		return -EIO;
> +
> +	return map_rhi_da_error(rhi_call->gprs[0]);
> +}
> +
> +static int __rhi_vdev_abort(unsigned long vdev_id, unsigned long *da_error)
> +{
> +	unsigned long ret;
> +	struct rsi_host_call *rhi_call __free(kfree) =
> +		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);

sizeof(*rhi_call) probably preferred.

> +	if (!rhi_call)
> +		return -ENOMEM;
> +
> +	rhi_call->imm = 0;
> +	rhi_call->gprs[0] = RHI_DA_VDEV_ABORT;
> +	rhi_call->gprs[1] = vdev_id;
> +
> +	ret = rsi_host_call(virt_to_phys(rhi_call));
> +	if (ret != RSI_SUCCESS)
> +		return -EIO;
> +
> +	return *da_error = rhi_call->gprs[0];
> +	return 0;

?  Run builds after each patch and you may catch stuff like this.

> +}
> +
> +static bool should_abort_rhi_call_loop(unsigned long vdev_id)
> +{
> +	int ret;
> +
> +	cond_resched();
> +	if (signal_pending(current)) {
> +		unsigned long da_error;
> +
> +		ret = __rhi_vdev_abort(vdev_id, &da_error);
> +		/* consider all kind of error as not aborted */
> +		if (!ret && (da_error == RHI_DA_SUCCESS))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static int __rhi_vdev_set_tdi_state(unsigned long vdev_id,
> +				    unsigned long target_state,

Maybe use an enum for target state? Can name it to align with the
RHIDAVDevTDIState used as the type for this in the RHI spec.


> +				    unsigned long *cookie)
> +{
> +	unsigned long ret;
> +
> +	struct rsi_host_call *rhi_call __free(kfree) =
> +		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
> +	if (!rhi_call)
> +		return -ENOMEM;
> +
> +	rhi_call->imm = 0;
> +	rhi_call->gprs[0] = RHI_DA_VDEV_SET_TDI_STATE;
> +	rhi_call->gprs[1] = vdev_id;
> +	rhi_call->gprs[2] = target_state;
> +
> +	ret = rsi_host_call(virt_to_phys(rhi_call));
> +	if (ret != RSI_SUCCESS)
> +		return -EIO;
> +
> +	*cookie = rhi_call->gprs[1];
> +	return map_rhi_da_error(rhi_call->gprs[0]);
> +}

> diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.h b/drivers/virt/coco/arm-cca-guest/rhi-da.h
> new file mode 100644
> index 000000000000..8dd77c7ed645
> --- /dev/null
> +++ b/drivers/virt/coco/arm-cca-guest/rhi-da.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 ARM Ltd.

Possibly update if this has changed much this year.

> + */
> +
> +#ifndef _VIRT_COCO_RHI_DA_H_
> +#define _VIRT_COCO_RHI_DA_H_
> +
> +#include <asm/rhi.h>
> +
> +struct pci_dev;
> +bool rhi_has_da_support(void);
> +int rhi_vdev_set_tdi_state(struct pci_dev *pdev, unsigned long target_state);
> +#endif


