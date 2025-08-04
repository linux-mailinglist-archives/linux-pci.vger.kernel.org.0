Return-Path: <linux-pci+bounces-33348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E00B19BD4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 08:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8027A45CE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 06:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CC022D4C0;
	Mon,  4 Aug 2025 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/jdK+ut"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653E154BF5;
	Mon,  4 Aug 2025 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290720; cv=none; b=cKD+BxGF+ZKBruUS5m/KK8dTko+sdJ+Qm8MIc/VLmn7w1dn8xhOoroCwz2/dD4riMl1pnBfu6U7SUYj73kW4t8zuf5nUKk11n2CV1jb5Ceicte+DJaUd1QmHl20gLwQEaM/qBQix0Mb4nXOCt4qfPnOM7/tr7KvKLjnhRd2dPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290720; c=relaxed/simple;
	bh=v9xHj22hdbHBZDlVa+VuQOMIt2QxRwUCOV+GzKrIJhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oqmgLd/4FAZNZNx+BShuZ3fl8Q3JkNEHe/bnlUpnT37xEK1LYQMx5InnaO+Pq/xQ0ES+AJ16I7HEakhLNfsx/VRILAO8gcjku3JU3J9xfgJvjQyc74vhnBR9ZUEMeqzZ4rYIYVC8HDAFWWPYWpgFNk3oWnOSEgPqSppacZ12EAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/jdK+ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505DEC4CEE7;
	Mon,  4 Aug 2025 06:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754290720;
	bh=v9xHj22hdbHBZDlVa+VuQOMIt2QxRwUCOV+GzKrIJhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y/jdK+ut68wZ5ohu3wdskfRvZyF3bu6qBSWXqMLqfml+LqgNX5ezRTNOo9kpWScYQ
	 J2koYnAyY6AWUeMG0PORloDMlUkATt9dURYjg/SkGx8Hizx++TJq7FeANZlGAazH91
	 y6GPS7zWa/qZQ0g98dJp51ZqXKK4waE5MHDPtMltTzNfIX601Tjnv/JPCQobZdo58g
	 ZU6lDm13A2Qb9XBHampfiYuOMuUaNmJ7gO3yj2g4JEyXf3Kdm8t5tK/6TnKXcHshKQ
	 yjBZ+hYsNSgLj/S/7yokaDCafy2QcqHHjzfCADFeSO1Izx2iuloBKg2uxJYGofi6Jf
	 m2II9zTbLrTTQ==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
In-Reply-To: <20250802134154.GI26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca> <yq5a5xfbbe35.fsf@kernel.org>
 <20250729143339.GH26511@ziepe.ca> <yq5aikj69kpn.fsf@kernel.org>
 <20250802134154.GI26511@ziepe.ca>
Date: Mon, 04 Aug 2025 12:28:33 +0530
Message-ID: <yq5aldnz8teu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Sat, Aug 02, 2025 at 02:14:20PM +0530, Aneesh Kumar K.V wrote:
>> Jason Gunthorpe <jgg@ziepe.ca> writes:
>>=20
>> > On Tue, Jul 29, 2025 at 01:53:10PM +0530, Aneesh Kumar K.V wrote:
>> >> Jason Gunthorpe <jgg@ziepe.ca> writes:
>> >>=20
>> >> > On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wr=
ote:
>> >> >> @@ -48,3 +49,12 @@ int set_memory_decrypted(unsigned long addr, in=
t numpages)
>> >> >>  	return crypt_ops->decrypt(addr, numpages);
>> >> >>  }
>> >> >>  EXPORT_SYMBOL_GPL(set_memory_decrypted);
>> >> >> +
>> >> >> +bool force_dma_unencrypted(struct device *dev)
>> >> >> +{
>> >> >> +	if (dev->tdi_enabled)
>> >> >> +		return false;
>> >> >
>> >> > Is this OK? I see code like this:
>> >> >
>> >> > static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>> >> > 		phys_addr_t phys)
>> >> > {
>> >> > 	if (force_dma_unencrypted(dev))
>> >> > 		return phys_to_dma_unencrypted(dev, phys);
>> >> > 	return phys_to_dma(dev, phys);
>> >> >
>> >> > What are the ARM rules for generating dma addreses?
>> >> >
>> >> > 1) Device is T=3D0, memory is unencrypted, call dma_addr_unencrypte=
d()
>> >> >    and do "top bit IBA set"
>> >> >
>> >> > 2) Device is T=3D1, memory is encrypted, use the phys_to_dma() norm=
ally
>> >> >
>> >> > 3) Device it T=3D1, memory is uncrypted, use the phys_to_dma()
>> >> >    normally??? Seems odd, I would have guessed the DMA address sould
>> >> >    be the same as case #1?
>> >> >
>> >> > Can you document this in a comment?
>> >> >
>> >>=20
>> >> If a device is operating in secure mode (T=3D1), it is currently assu=
med
>> >> that only access to private (encrypted) memory is supported.
>> >
>> > No, this is no how the PCI specs were written as far as I
>> > understand. The XT bit thing is supposed to add more fine grained
>> > device side control over what memory the DMA can target. T alone does
>> > not do that.
>> >
>> >> It is unclear whether devices would need to perform DMA to shared
>> >> (unencrypted) memory while operating in this mode, as TLPs with T=3D1
>> >> are generally expected to target private memory.
>> >
>> > PCI SIG supports it, kernel should support it.
>> >
>>=20
>> Would we also need a separate DMA allocation API for allocating
>> addresses intended to be shared with the non-secure hypervisor?
>>=20
>> Are there any existing drivers in the kernel that already require such
>> shared allocations, which I could use as a reference?
>
> The most likely case in the near term is PCI P2P to shared MMIO.
>
> I don't know any way to allocate shared memory in a driver??
>
> At the bare minimum this patch should be documenting the correct
> architecture and outlining any gaps in the current implementation.
>
> I also don't really understand what the above code is even
> doing.. Isn't the design on ARM that the IPA always encodes the
> shared/private in the top bit?
>
> How do we get a shared page that does not already have a phys_addr_t
> in the shared IPA? Shouldn't the kernel have switched to the shared
> IPA alias when it returned the swiotlb buffer? eg why do we need to do:
>
> #define dma_addr_unencrypted(x)		((x) | PROT_NS_SHARED)
>

swiotlb virt addr is updated in the direct map page table such that we
have the correct attribute set. For ex: swiotlb_update_mem_attributes
uses set_memory_decrypted() to mark the memory as shared.

	set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);

However, when mapping swiotlb regions to obtain a `dma_addr_t`, we still
need to explicitly convert the physical address:

swiotlb_map()
	swiotlb_addr =3D swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
        ...

	/* Ensure that the address returned is DMA'ble */
	dma_addr =3D phys_to_dma_unencrypted(dev, swiotlb_addr);

Note that we don=E2=80=99t update the phys_addr_t to set the top
bit. For reference:

	tlb_addr =3D slot_addr(pool->start, index) + offset;

-aneesh

