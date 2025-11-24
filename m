Return-Path: <linux-pci+bounces-41926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B1DC7EFAB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 06:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3983C3A42F5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 05:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1432C17A1;
	Mon, 24 Nov 2025 05:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0F0/ZZ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A15E2BEC26;
	Mon, 24 Nov 2025 05:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763960842; cv=none; b=WlvoXrno4SKyieZF0FBlO7yu94iIZzqzrRfxNvgbLOuQQQkGOzWoL9l9o/U98LEM4XJgL1key7WIBUe1LQn1kS4A+fQsUyuJuVTeRR2BaqGKY8PHrq5seRiWb5tyB2jFwXNMCVp3IlpQlMIpLOQc/tKl0hHqkggwYfd18byp2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763960842; c=relaxed/simple;
	bh=i/ORBS/wiaR7Mbf8wwlgeQGhxEoGjP119KQP1bMn3e4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bXYJvqwZHuz9SHbYIvEkSKXyVW+f0Vsifrsa2ttkSViu0aCw3I70ICn5DjVwawBNLkw2RmYrKZLwB1n5VUhHbymJumVHpXtIUthfG1MFNuhHhavcqe6yRsVDYSM7+7INWQOmT+Tgp2ydlvSnya/SErbq06Y5BDgqPFK/TtS2XFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0F0/ZZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9532C4CEF1;
	Mon, 24 Nov 2025 05:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763960841;
	bh=i/ORBS/wiaR7Mbf8wwlgeQGhxEoGjP119KQP1bMn3e4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s0F0/ZZ5qiyNjcOLkSZKCuFKXHjql+1Ursvt1uwRIHv7E6fvciFb9VnRiq4vcW1Qj
	 rP0CLsdPW4WSKHP3bQ+m325Rix8Pu94oYQvRS65OIY7vd6hsY0CuSIGpe6T28L06pf
	 rc3lkLtfyXFntBD5aLIXg3FOVp6U6ih1dUYomT3gAFTMt+8cG789BcIfdptedRFTyt
	 5ISFVTRGxtAIyV68qcNYN8LiwZanicNCPUMtiR+wLLt5VhsMsGq9oCoO3c5Zhgse+J
	 hqSaBvjzFagM8W0pWCRQ56M5EeGmuNJnMbiZynBtHD2k5HmjKqvCDB0GebXnXEZYYZ
	 7byL1FKcKvTlQ==
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
Subject: Re: [PATCH v2 02/11] coco: guest: arm64: Add Realm Host Interface
 and guest DA helper
In-Reply-To: <20251119153200.00007fd0@huawei.com>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
 <20251117140007.122062-3-aneesh.kumar@kernel.org>
 <20251119153200.00007fd0@huawei.com>
Date: Mon, 24 Nov 2025 10:37:13 +0530
Message-ID: <yq5aa50cm326.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Mon, 17 Nov 2025 19:29:58 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>
>> - describe the Realm Host Interface SMC IDs and result codes in a new
>>   `asm/rhi.h` header
>> - expose `struct rsi_host_call` plus an `rsi_host_call()` helper so we c=
an
>>   invoke `SMC_RSI_HOST_CALL` from C code
>> - build a guest-side `rhi-da` helper that drives the vdev TDI state mach=
ine
>>   via RHI host calls and translates the firmware status codes
>>=20
>> This provides the basic RHI plumbing that later DA features rely on.
>>=20
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Hi Aneesh, minor comments follow.
>
>> diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.c b/drivers/virt/coc=
o/arm-cca-guest/rhi-da.c
>> new file mode 100644
>> index 000000000000..3430d8df4424
>> --- /dev/null
>> +++ b/drivers/virt/coco/arm-cca-guest/rhi-da.c
> ...
>
>> +
>> +bool rhi_has_da_support(void)
>> +{
>> +	int ret;
>> +	struct rsi_host_call *rhicall;
>> +
>> +	rhicall =3D kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
>
> Doesn't look to be passed out anywhere, so not obvious why the lifetime
> of this extends beyond this function.  Maybe I'm missing something.
>

This should be similar to other calls

	struct rsi_host_call *rhicall __free(kfree) =3D
		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);

I=E2=80=99ll update the code to reflect that. Thanks for pointing it out.

>
>> +	if (!rhicall)
>> +		return -ENOMEM;
>> +
>> +	rhicall->imm =3D 0;
>> +	rhicall->gprs[0] =3D RHI_DA_FEATURES;
>> +
>> +	ret =3D rsi_host_call(virt_to_phys(rhicall));
>> +	if (ret !=3D RSI_SUCCESS || rhicall->gprs[0] =3D=3D SMCCC_RET_NOT_SUPP=
ORTED)
>> +		return false;
>> +
>> +	/* For base DA to work we need these to be supported */
>> +	if ((rhicall->gprs[0] & RHI_DA_BASE_FEATURE) =3D=3D RHI_DA_BASE_FEATUR=
E)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +static inline int rhi_vdev_continue(unsigned long vdev_id, unsigned lon=
g cookie)
>> +{
>> +	unsigned long ret;
>> +
>> +	struct rsi_host_call *rhi_call __free(kfree) =3D
>> +		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
>
> sizeof(*rhi_call)  Same for all other cases of this.
>
>> +	if (!rhi_call)
>> +		return -ENOMEM;
>> +
>> +	rhi_call->imm =3D 0;
>> +	rhi_call->gprs[0] =3D RHI_DA_VDEV_CONTINUE;
>> +	rhi_call->gprs[1] =3D vdev_id;
>> +	rhi_call->gprs[2] =3D cookie;
>> +
>> +	ret =3D rsi_host_call(virt_to_phys(rhi_call));
>> +	if (ret !=3D RSI_SUCCESS)
>> +		return -EIO;
>> +
>> +	return map_rhi_da_error(rhi_call->gprs[0]);
>> +}
>> +
>> +static int __rhi_vdev_abort(unsigned long vdev_id, unsigned long *da_er=
ror)
>> +{
>> +	unsigned long ret;
>> +	struct rsi_host_call *rhi_call __free(kfree) =3D
>> +		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
>
> sizeof(*rhi_call) probably preferred.
>
>> +	if (!rhi_call)
>> +		return -ENOMEM;
>> +
>> +	rhi_call->imm =3D 0;
>> +	rhi_call->gprs[0] =3D RHI_DA_VDEV_ABORT;
>> +	rhi_call->gprs[1] =3D vdev_id;
>> +
>> +	ret =3D rsi_host_call(virt_to_phys(rhi_call));
>> +	if (ret !=3D RSI_SUCCESS)
>> +		return -EIO;
>> +
>> +	return *da_error =3D rhi_call->gprs[0];
>> +	return 0;
>
> ?  Run builds after each patch and you may catch stuff like this.
>
>> +}
>> +
>> +static bool should_abort_rhi_call_loop(unsigned long vdev_id)
>> +{
>> +	int ret;
>> +
>> +	cond_resched();
>> +	if (signal_pending(current)) {
>> +		unsigned long da_error;
>> +
>> +		ret =3D __rhi_vdev_abort(vdev_id, &da_error);
>> +		/* consider all kind of error as not aborted */
>> +		if (!ret && (da_error =3D=3D RHI_DA_SUCCESS))
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +static int __rhi_vdev_set_tdi_state(unsigned long vdev_id,
>> +				    unsigned long target_state,
>
> Maybe use an enum for target state? Can name it to align with the
> RHIDAVDevTDIState used as the type for this in the RHI spec.
>

how about enum rhi_tdi_state ?

>
>
>> +				    unsigned long *cookie)
>> +{
>> +	unsigned long ret;
>> +
>> +	struct rsi_host_call *rhi_call __free(kfree) =3D
>> +		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
>> +	if (!rhi_call)
>> +		return -ENOMEM;
>> +
>> +	rhi_call->imm =3D 0;
>> +	rhi_call->gprs[0] =3D RHI_DA_VDEV_SET_TDI_STATE;
>> +	rhi_call->gprs[1] =3D vdev_id;
>> +	rhi_call->gprs[2] =3D target_state;
>> +
>> +	ret =3D rsi_host_call(virt_to_phys(rhi_call));
>> +	if (ret !=3D RSI_SUCCESS)
>> +		return -EIO;
>> +
>> +	*cookie =3D rhi_call->gprs[1];
>> +	return map_rhi_da_error(rhi_call->gprs[0]);
>> +}
>
>> diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.h b/drivers/virt/coc=
o/arm-cca-guest/rhi-da.h
>> new file mode 100644
>> index 000000000000..8dd77c7ed645
>> --- /dev/null
>> +++ b/drivers/virt/coco/arm-cca-guest/rhi-da.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2024 ARM Ltd.
>
> Possibly update if this has changed much this year.
>
>> + */
>> +
>> +#ifndef _VIRT_COCO_RHI_DA_H_
>> +#define _VIRT_COCO_RHI_DA_H_
>> +
>> +#include <asm/rhi.h>
>> +
>> +struct pci_dev;
>> +bool rhi_has_da_support(void);
>> +int rhi_vdev_set_tdi_state(struct pci_dev *pdev, unsigned long target_s=
tate);
>> +#endif

-aneesh

