Return-Path: <linux-pci+bounces-33133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FFFB1519A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 18:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062883BCA14
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB8D227B83;
	Tue, 29 Jul 2025 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vWje3sxd"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06A0220F36;
	Tue, 29 Jul 2025 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807598; cv=none; b=tAXQM8HFMkZczCj8AEBOj7Q7jwmIRqO+RICAK/wyBW5TXm3+pJTjktwj9PUvEO/bL9jh368HJ96DojW5L/4LkHkv7b8AUEV3Zt8Z+RoBzym2SVpJ0qHz6F0tpyJ6VAMacRgZjGEPyMKfpwUFdL3ojvTqC5pC9amKr80QGlOMdF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807598; c=relaxed/simple;
	bh=XfV9U757F5SWpS2wnRxcpkAv+nxMq3qw2d8jQ0oRxI0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skOqcPv75SOkCNCS6h2JKPXU2xiYgB5LVIWk2U+0LvmpCHkb28u9qgxVCYFh4QBbPYvJNLgSpnacQXeJlL9l89VcAhSaZLqUS6hnN7+tiSJsU8Fn+FyhY7MGdVKoRdvCxxuKCgai+r4tQ8iZtBBehgaYhxDQE1+sHpwxfkHX2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vWje3sxd; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Npn5Ah8PAw6fNiXtXhHXUfjg5csWz/60SorhwBN4vyM=;
	b=vWje3sxdNJvVdik1CWixLNkOCQ3onRhSINZOQOp/OUhmdh/keDwDBbbYt6anZwvx1nGNpXi0F
	MIdToAMHZJRqZkpNBDuy02GcsN9O5kkkn80yDym09SgsCKVGrAk/E0G0gAn+MiE84Xi1r1PetJQ
	R1zGfRQnoh1L+gxeGAEYmbI=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4bs10J6hVFz1P6lQ;
	Wed, 30 Jul 2025 00:25:04 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bs1015Q1Wz6H7HH;
	Wed, 30 Jul 2025 00:24:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6987B140427;
	Wed, 30 Jul 2025 00:26:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 18:26:23 +0200
Date: Tue, 29 Jul 2025 17:26:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 07/38] iommufd/viommu: Add support to associate
 viommu with kvm instance
Message-ID: <20250729172621.00006344@huawei.com>
In-Reply-To: <20250728135216.48084-8-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-8-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Jul 2025 19:21:44 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> The associated kvm instance will be used in later patch by iommufd to
> bind a tdi to kvm.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/iommufd/viommu.c | 45 +++++++++++++++++++++++++++++++++-
>  include/linux/iommufd.h        |  3 +++
>  include/uapi/linux/iommufd.h   | 12 +++++++++
>  3 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 2ca5809b238b..59f1e1176f7f 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -2,6 +2,36 @@
>  /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
>   */
>  #include "iommufd_private.h"
> +#include "linux/tsm.h"
> +
> +#if IS_ENABLED(CONFIG_KVM)
> +#include <linux/kvm_host.h>
> +
> +static int viommu_get_kvm(struct iommufd_viommu *viommu, int kvm_vm_fd)
> +{
> +	int rc = -EBADF;
> +	struct file *filp;
> +
> +	filp = fget(kvm_vm_fd);
> +
> +	if (!file_is_kvm(filp))
> +		goto err_out;
> +
> +	/* hold the kvm reference via file descriptor */
> +	viommu->kvm_filp = filp;
> +	return 0;
> +err_out:
> +	viommu->kvm_filp = NULL;

Is this to undo side effects from this function on error?

kvm_filp is only set after all error paths so maybe this isn't
needed?

If this isn't needed then use __free(fput) and no_free_ptr() to
deal with filp more simply and in teh erorr path can just return -EBADF
directly rather than the goto.

Or are we avoiding that stuff in iommufd?

> +	fput(filp);
> +	return rc;
> +}
> +
> +static void viommu_put_kvm(struct iommufd_viommu *viommu)
> +{
> +	fput(viommu->kvm_filp);
> +	viommu->kvm_filp = NULL;
> +}
> +#endif

