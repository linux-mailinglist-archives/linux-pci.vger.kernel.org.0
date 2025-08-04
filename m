Return-Path: <linux-pci+bounces-33352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EC7B19D9C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 10:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314FD172784
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB40241674;
	Mon,  4 Aug 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpagILEA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF71C5D59;
	Mon,  4 Aug 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296141; cv=none; b=oaDOo2rG2wAHLXLwHTSKnGiuH1uF8HLpiXPe+w2nDT8dQj45J9dTUSRQHeMUuKrhC4toHij7toH7BN6X1fah4a81nzgHO4/6zjCByl7W7KWRRRh6pFiEljrQ3WjXL1NZcG8Koqd4uWJagaV0jv030rVs7C8tLnroCAHtWkWXTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296141; c=relaxed/simple;
	bh=DwOZcfM/c4GuDZJmEoD7EL7622q+//Noz+SL9yl0crc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BEV5RGi9NyzoHnV5dck62rj+AETLU6mHsgBHcUDloEPyQBMp4tvL7+dpkzVMX9Hp6z3vqUre/DKfGfYXD22XDrY5BqqIODHkIiBWgIqZ3d9pxXXhfkkx5zUK64Owe316zurGT0TJA3xFKLM1i+kJXtqjBwXQu1yCCVnIUPEZGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpagILEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8998C4CEE7;
	Mon,  4 Aug 2025 08:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754296141;
	bh=DwOZcfM/c4GuDZJmEoD7EL7622q+//Noz+SL9yl0crc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HpagILEA7gkYNsLZm0Bv8HzL64baPebYPjFllMETO/c0GOZi9K+zwAWKiiFjPq67U
	 4FbMqDBpQABKMYxSRP8/mQndLaSdew0ux4N+mSl61oxDw+FJozL/Ecbfo50pqTUD/6
	 ibPeSBPpnpVy6Uxh+jsjCDMO6qlR/ikmSuFIrwaYFkJYYHOCEtISRIk1Mh5X2p/2Qr
	 Xrae55a2D+ovzA3t9t6V8IuedpbrpX/ZhYmKodBSMhSuJErLAVwyjufFaYXw6wqT2Z
	 miC3msw+hG+O2AbbYMVinPft9CGYv1/n6oy/+y0Er7YXjGqivdyd6ZqIhSNZqIj2YY
	 poIa7+jC2ZAJA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 10/38] iommufd/vdevice: Add TSM map ioctl
In-Reply-To: <bfac9ab6-9115-44d5-90c8-e22c3dbdb607@amd.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-11-aneesh.kumar@kernel.org>
 <20250728141701.GC26511@ziepe.ca>
 <bfac9ab6-9115-44d5-90c8-e22c3dbdb607@amd.com>
Date: Mon, 04 Aug 2025 13:58:53 +0530
Message-ID: <yq5aikj38p8a.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexey Kardashevskiy <aik@amd.com> writes:

> On 28/7/25 19:47, Jason Gunthorpe wrote:
>> On Mon, Jul 28, 2025 at 07:21:47PM +0530, Aneesh Kumar K.V (Arm) wrote:
>>> With passthrough devices, we need to make sure private memory is
>>> allocated and assigned to the secure guest before we can issue the DMA.
>>> For ARM RMM, we only need to map and the secure SMMU management is
>>> internal to RMM. For shared IPA, vfio/iommufd DMA MAP/UNMAP interface
>>> does the equivalent
>>=20
>> I'm not really sure what this is about? It is about getting KVM to pin
>> all the memory and commit it to the RMM so it can be used for DMA?
>>=20
>> But it looks really strange to have an iommufd ioctl that just calls a
>> KVM function. Feeling this should be a KVM function, or a guestmfd
>> behavior??
>
>
> I ended up exporting the guestmemfd's kvm_gmem_get_folio() for gfn->pfn a=
nd its fd a bit differently in iommufd - "no extra referencing":
> https://github.com/AMDESE/linux-kvm/commit/f1ebd358327f026f413f8d3d64d46d=
ecfd6ab7f6
>
> It is a new iommufd->kvm dependency though.
>

Was the motivation for that design choice the fact that in case of AMD
VFIO/IOMMUFD manages both private memory allocation and updates to the
IOMMU page tables?

On the ARM side, the requirement is to ensure that pages are present in
the stage-2 page table, which is managed by the firmware (RMM). Because
of this, we need an interface that VFIO/IOMMUFD can use to trigger
stage-2 mappings within KVM.

Alternatively, we could introduce a dedicated KVM ioctl for this
purpose, avoiding the need to rely on IOMMUFD.

For reference, TDX uses a similar ioctl=E2=80=94`KVM_TDX_INIT_MEM_REGION`=
=E2=80=94to
initialize guest memory. However, that interface isn=E2=80=99t well-suited =
for
dynamic updates to stage-2 mappings during shared-to-private or
private-to-shared transitions.


>
>> I was kind of thinking it would be nice to have a guestmemfd mode that
>> was "pinned", meaning the memory is allocated and remains almost
>> always mapped into the TSM's page tables automatically. VFIO using
>> guests would set things this way.
>
> Yeah while doing the above, I was wondering if I want to pass the fd type=
 when DMA-mapping from an fd or "detect" it as I do in the above commit or =
have some iommufd_fdmap_ops in this fd saying "(no) pinning needed" (or mak=
e this a flag of IOMMU_IOAS_MAP_FILE).
>
> The "detection" is (mapping_inaccessible(mapping) && mapping_unevictable(=
mapping)), works for now.
>
> btw in the AMD case, here it does not matter as much if it is private or =
shared, I map everything and let RMP and the VM deal with the permissions. =
Thanks,
>
>

-aneesh

