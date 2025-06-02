Return-Path: <linux-pci+bounces-28798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C4ACACFA
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 13:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0063A5BDF
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197901E47BA;
	Mon,  2 Jun 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8WMp5Bv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515A1B412A;
	Mon,  2 Jun 2025 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862498; cv=none; b=HC1fiAu8Ky4btXFwO8msov0wKBKt6CX6hflpKrfYjIhCv7v8WH/dkiQyaX0Z1HtmFAfSXNn8uxf6lq6eOQn55cpzm9co6zdunnUu2WG4SqmhfiNBqlyJlYE5+VpQh+bvU2zD6ZB06uQ/SkRNKHOHfemSGaYwS4cTXTmAl5SqAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862498; c=relaxed/simple;
	bh=bbcAduJnWusTrZNUnraWUxM+FUh78FuCLZfN8+aO7Ls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Git78yCGnlQq77QXPEB/uwIyBsV4X4sIbQjTo07W6Vem1Q9sisjuRC3vPW3/VT0deFWNq5MqEkrnxPQvFzSgpHjCZlOltvzx8brb+fiNbwtB/DXh5oziX4tb5rVF3DF9hR35K6pVUdEqkVi8cDna1GgkddAnjlm1zYEp366cGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8WMp5Bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649C0C4CEEB;
	Mon,  2 Jun 2025 11:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748862497;
	bh=bbcAduJnWusTrZNUnraWUxM+FUh78FuCLZfN8+aO7Ls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=m8WMp5BvHJ4TfanL/zerpkPvvfpopAiTB7EYXM9YvbfeShRSX2vW9NTE+QaOmBLhF
	 lb+WGfpb2c8s4HgJuyvgVpXdqnESO99IZ1v1FZj7GOXghGWfyHoUn257VBhmH0ZZIP
	 5XdEv/buarpRscYOchHDZdqw0q2KCyrtSDad7mLcvL2CrE5tNngvQae29UOKDj2QjG
	 3C4gVaQtuLKEvcoeGsBtXl5eNlVBk6MfsPUVBQglQVCjNGDOOZGS5Dli2zGmryDBPK
	 aBRW6PEqA2r7nWYDW32wmcT2NDeNYOXKFNjwUmGzqnLJz5oR4HFz04sA3c6FxfFCuC
	 r3ro+Nc4UZnag==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
In-Reply-To: <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
Date: Mon, 02 Jun 2025 16:38:09 +0530
Message-ID: <yq5azfeqjt9i.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xu Yilun <yilun.xu@linux.intel.com> writes:

>> + * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
>> + * @size: sizeof(struct iommu_vdevice_id)
>> + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEV=
ICE_ALLOC
>> + */
>> +struct iommu_vdevice_id {
>> +	__u32 size;
>> +	__u32 vdevice_id;
>> +} __packed;
>> +#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TS=
M_BIND)
>> +#define IOMMU_VDEVICE_TSM_UNBIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_=
TSM_UNBIND)
>
> Hello, I see you are talking about the detailed implementation. But
> could we firstly address the confusing whether this TSM Bind/Unbind
> should be a VFIO uAPI or IOMMUFD uAPI?
>
> In this thread [1], I was talking about TSM Bind/Unbind affects VFIO
> behavior so they cannot be iommufd uAPIs which VFIO is not aware of.
> At least TDX Connect cares about this problem now. And the conclusion
> seems to be "have a VFIO_DEVICE_BIND(iommufd vdevice id), then have
> VFIO reach into iommufd".
>
> And some further findings [2] indicate this problem may also exist on
> AMD when p2p is involved.
>
> [1]: https://lore.kernel.org/all/20250515175658.GR382960@nvidia.com/
> [2]: https://lore.kernel.org/all/aDnXxk46kwrOcl0i@yilunxu-OptiPlex-7050/
>

Looking at your patch series, I understand the reason you need a vfio
ioctl is to call pci_request_regions_exclusive=E2=80=94is that correct?

In another thread, I asked whether this might be better handled by
pci_tsm instead of vfio. I'd be interested in your thoughts on that.

I also noticed you want to unbind the TDI before unmapping the BAR in
vfio. From what I understand, this should still be possible if we use an
iommufd ioctl. Either approach=E2=80=94a vfio or iommufd ioctl=E2=80=94work=
s fine for my
needs. We can continue that discussion in your patch series thread.

-aneesh

