Return-Path: <linux-pci+bounces-33097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D49BB14A39
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 10:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D50B1AA029B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 08:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147FE257444;
	Tue, 29 Jul 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhCd94wB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6602284B5D;
	Tue, 29 Jul 2025 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778284; cv=none; b=FAizCSm624pU6IhzVniYZFBEFEujjPjj45xBTbPXMH+czFqi791knCYBYTUuuCv2YltmyUoANd0gtI7u2Ds9rn+FCgp7P8oFL+kyBMIryCn86ahh1kCP99aDc4DAwNMvGNdIdR0GcIgkY9IA0E0aORXOX920OBWR6xmFjgRxle4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778284; c=relaxed/simple;
	bh=GzjAI0O7ojbXo38gpspYvV7Y5E/eT31eMvZ+D0juiUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dG1CXlqjOT0JZTkEuu2wnqZ7IC8/V3TRJ4XRpkbQgApFGotKysEIB3zrieUvlRNXFNFq/5JBgxpDlglHW0xJaoHP4sIQA8z3NzaU0W4Gdb6Yyb++HD1X/UNEDbIMofbhNu61mf4thcEYp2NT9kc9hO8h59a7AEWQv/ST7NM8jCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhCd94wB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A344C4CEEF;
	Tue, 29 Jul 2025 08:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753778283;
	bh=GzjAI0O7ojbXo38gpspYvV7Y5E/eT31eMvZ+D0juiUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YhCd94wB7Gtd2cJ29zu+Q5kuJJD3xmm3I2mpMUS8vEl6/fMPRo6UIs6cS8fZFpltw
	 3sb4mfsWtQDB/V9cFj3B4YG2sotC9XwrFB0RJFpcMxpOsND4qluntuWZYOU77gcbnO
	 m9lmdbv0PKQxO2JeKu2SKhZywzWgzw71Rb+d6n82UyliS8gmXe0W25remPIOUmhCOS
	 SZUSyRXzDFt/PZR1gRTiJDhZkW2OLMrM7aNUA2ztrzZzJWGJtBa8vDXupGvXY6kpiU
	 HtmqO88W8ALC1WCr3lQlJaljvZ4JRKouOYHUDoNYJDozvIs+m28SxwqYXhNSAepveI
	 4M2JRw0gqTuqw==
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
Subject: Re: [RFC PATCH v1 10/38] iommufd/vdevice: Add TSM map ioctl
In-Reply-To: <20250728141701.GC26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-11-aneesh.kumar@kernel.org>
 <20250728141701.GC26511@ziepe.ca>
Date: Tue, 29 Jul 2025 14:07:55 +0530
Message-ID: <yq5awm7r9yu4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Jul 28, 2025 at 07:21:47PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> With passthrough devices, we need to make sure private memory is
>> allocated and assigned to the secure guest before we can issue the DMA.
>> For ARM RMM, we only need to map and the secure SMMU management is
>> internal to RMM. For shared IPA, vfio/iommufd DMA MAP/UNMAP interface
>> does the equivalent
>
> I'm not really sure what this is about? It is about getting KVM to pin
> all the memory and commit it to the RMM so it can be used for DMA?
>

That is correct.

>
> But it looks really strange to have an iommufd ioctl that just calls a
> KVM function. Feeling this should be a KVM function, or a guestmfd
> behavior??
>
This functionality is equivalent to `IOMMU_IOAS_MAP`, but in the
presence of firmware like RMM, we also need to supply the realm
descriptor associated with the KVM instance.

Initially, I attempted to handle this within the `map_pages` callback in
`iommu_domain_ops`, but that path lacks any awareness of the associated
KVM context, making it unsuitable for this purpose.


> I was kind of thinking it would be nice to have a guestmemfd mode that
> was "pinned", meaning the memory is allocated and remains almost
> always mapped into the TSM's page tables automatically. VFIO using
> guests would set things this way.
>

We need to allocate and free these pages dynamically as they are
converted between private and shared states.

-aneesh

