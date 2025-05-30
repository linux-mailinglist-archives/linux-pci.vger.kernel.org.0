Return-Path: <linux-pci+bounces-28699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB5CAC89EE
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 10:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EA74A3348
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C67E21772B;
	Fri, 30 May 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkccf+mD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED8213E69;
	Fri, 30 May 2025 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748594014; cv=none; b=SkKVQ4IXd/FUcwviHk4hNVOKX1Ge9dekBTQinefaHGjVFc/fbrXsyoJCUK7QEHJlVVUTXNCSxvEz/3Bb9grPbKW+N+NKhqv/hYx3oF1MH0bsd4/Hlz3yb36OhKuYjxu/FaXlnUP+plmnABUaM2E8lusv0u6dTIPZXyHijpa0pfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748594014; c=relaxed/simple;
	bh=QXVscUcr/48On5CEM4Kbuz2GFCrTXt9ytwBWpLuN57k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h/9AQgcqhYrcvi0+dSy12Lci6jv7Ib3rBIwz7oVY4BaXRqdD8YokGCuyU31xassE0T+WQX2X74ggZEX58c1PbGwBFCMVa0K5bV5ewfMDUHK5zDRepdDlyyHLMJPwZzKg7uGGzNgszB3ejXWVG0pqB4vF0LwtNuMaRGWKQdeH5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkccf+mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC4DC4CEE9;
	Fri, 30 May 2025 08:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748594013;
	bh=QXVscUcr/48On5CEM4Kbuz2GFCrTXt9ytwBWpLuN57k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mkccf+mD2MgAomCFq41vRwz2gB5Cnbj1SGnpHG2Eqy5C4QFZo+vOmO1vejdaLND+d
	 MKTd/FuK91yZpctLTZc2WgrciT9vmf8Hp/e4i4AdD3YBdoQ4Abhr8lNdrN7pDw4TEj
	 EKHfnCO+oJl7UPiCpvoiPNNrrMTMg0D7NujeBnOWo7WNK52JWky10vFrYAGNm3uneX
	 oea+LHX2MEgyV4cbhKvMGl12MFFocGLUz4TIt4dJPiYzmBNnUpJIGooWXD1dlKFHCJ
	 Ki32jg9luRvyZMrZkSzKhmmiBoptzcuGSf98KIRZj0PQsCgVinPs4t6iMPvWuWICCs
	 RR1g3k3k4w7/w==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
In-Reply-To: <20250529143237.GF192531@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <20250529143237.GF192531@nvidia.com>
Date: Fri, 30 May 2025 14:03:00 +0530
Message-ID: <yq5a34cmjy6b.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Thu, May 29, 2025 at 07:07:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
>
>> +static struct mutex *vdev_lock(struct iommufd_vdevice *vdev)
>> +{
>> +
>> +	if (device_lock_interruptible(vdev->dev) !=3D 0)
>> +		return NULL;
>> +	return &vdev->dev->mutex;
>> +}
>> +DEFINE_FREE(vdev_unlock, struct mutex *, if (_T) mutex_unlock(_T))
>
> I know I suggested this, but maybe it would be happier to use a mutex
> in the viommu?
>
> What is the locking model you need for TSM calls here anyhow? Can you
> concurrently call tsms for vommu creation with bind/unbind or so on?
>

Thinking about this more, I guess we likely don=E2=80=99t need a lock here.=
 I
initially added it to handle vdevice->tsm_bind, but concurrent TSM calls
are already serialized via tsm_ops_lock.

Additionally, if tsm_bind is invoked on an already bound TDI, the TSM
layer handles it gracefully. This suggests that maintaining
vdevice->tsm_bound is unnecessary.

Since we're not modifying any vdevice state here, it appears safe to
remove the vdev_lock() call?

>> +/**
>> + * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
>> + * @size: sizeof(struct iommu_vdevice_id)
>> + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEV=
ICE_ALLOC
>> + */
>> +struct iommu_vdevice_id {
>> +	__u32 size;
>> +	__u32 vdevice_id;
>> +} __packed;
>
> ???
> Why is it called vdevice_id?
> Why is it packed?
>
> The struct should be per-ioctl. Does anyone need a TSM specific argument
> blob for bind?

For both tsm_bind and tsm_unbind, we need the vdevice id. How do we pass
that?=20

