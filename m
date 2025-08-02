Return-Path: <linux-pci+bounces-33325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C2FB18B67
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 10:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1ACC188C851
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8458A1F9F7A;
	Sat,  2 Aug 2025 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUL6bTsC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D59418D;
	Sat,  2 Aug 2025 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754124269; cv=none; b=ZwxzpUBHsBYTYN3eRgWkB74TZRne72ZyAI1uGLhqkgEUOQ49D96jWX656AXCtJ7iZcSHPzpckyk1ttcLrL0X9da3/2DrVOrN5pFqAEv+rpjVXxxXGyBbHyEphAkyE6AnT1fl+xnlwg7LQTfsyk7PUu3OIlyCDdhQmEipJdKp26g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754124269; c=relaxed/simple;
	bh=wBEtzqfOArmGIa6wBAiWTsUuLYnBTu+8vKyqUAylFH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UiBRbjDCnxa3axT+zNS/0Nz5Va3Rw5neWoNPNUyusr6zdkaypYyFloQkPGk7Eog3dZ82LnW+wcruF/FfoKKutKhq9o/NkWujbJQrFECVqrmh/5m5nI40IpW9OYrik3bXpMnbrfObpo5/nLNOD3EcS9B4SSjOv/YXw3ks9JbmYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUL6bTsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79CBC4CEEF;
	Sat,  2 Aug 2025 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754124268;
	bh=wBEtzqfOArmGIa6wBAiWTsUuLYnBTu+8vKyqUAylFH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oUL6bTsC3i2VUEIZLouAIm5ctnrSZMfafZE68/b4A8hEHKneyKAX11tfWuQuCTyiA
	 nqyxxxIVEdyCJPsTJn7eBb1xzZJ2U1E28h2koAfWc4EHyuojT1gGrbne+YClTSdEjW
	 nvQMYZfxdlMpsYT1nMJOTeauBTyeafGsPWTJ4vnKIFq4Yp9iId2Rge1Qtnnwn0ZJGy
	 dRWdRJCHe1URNRrtCCupVhgtQwZ/mCLE6cmGYIjYg9bGviOPlYWSLVU10M1ncBk2lh
	 ZIxJNO/qTMJGseBmp35ZVjL24epAXO4QyO4lcxS5fdA3WBLhTbN3XCY7Aa7cWTdWc8
	 GGOV5l3LBApCA==
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
In-Reply-To: <20250729143339.GH26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca> <yq5a5xfbbe35.fsf@kernel.org>
 <20250729143339.GH26511@ziepe.ca>
Date: Sat, 02 Aug 2025 14:14:20 +0530
Message-ID: <yq5aikj69kpn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Tue, Jul 29, 2025 at 01:53:10PM +0530, Aneesh Kumar K.V wrote:
>> Jason Gunthorpe <jgg@ziepe.ca> writes:
>> 
>> > On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> >> @@ -48,3 +49,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
>> >>  	return crypt_ops->decrypt(addr, numpages);
>> >>  }
>> >>  EXPORT_SYMBOL_GPL(set_memory_decrypted);
>> >> +
>> >> +bool force_dma_unencrypted(struct device *dev)
>> >> +{
>> >> +	if (dev->tdi_enabled)
>> >> +		return false;
>> >
>> > Is this OK? I see code like this:
>> >
>> > static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>> > 		phys_addr_t phys)
>> > {
>> > 	if (force_dma_unencrypted(dev))
>> > 		return phys_to_dma_unencrypted(dev, phys);
>> > 	return phys_to_dma(dev, phys);
>> >
>> > What are the ARM rules for generating dma addreses?
>> >
>> > 1) Device is T=0, memory is unencrypted, call dma_addr_unencrypted()
>> >    and do "top bit IBA set"
>> >
>> > 2) Device is T=1, memory is encrypted, use the phys_to_dma() normally
>> >
>> > 3) Device it T=1, memory is uncrypted, use the phys_to_dma()
>> >    normally??? Seems odd, I would have guessed the DMA address sould
>> >    be the same as case #1?
>> >
>> > Can you document this in a comment?
>> >
>> 
>> If a device is operating in secure mode (T=1), it is currently assumed
>> that only access to private (encrypted) memory is supported.
>
> No, this is no how the PCI specs were written as far as I
> understand. The XT bit thing is supposed to add more fine grained
> device side control over what memory the DMA can target. T alone does
> not do that.
>
>> It is unclear whether devices would need to perform DMA to shared
>> (unencrypted) memory while operating in this mode, as TLPs with T=1
>> are generally expected to target private memory.
>
> PCI SIG supports it, kernel should support it.
>

Would we also need a separate DMA allocation API for allocating
addresses intended to be shared with the non-secure hypervisor?

Are there any existing drivers in the kernel that already require such
shared allocations, which I could use as a reference?

-aneesh

