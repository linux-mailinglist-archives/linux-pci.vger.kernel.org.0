Return-Path: <linux-pci+bounces-36220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC45B58CB0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 06:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CA51BC0DC6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 04:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECA8125A0;
	Tue, 16 Sep 2025 04:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqtgAytF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977E17597;
	Tue, 16 Sep 2025 04:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757996135; cv=none; b=ld50h3xdzf6vcwWDQcs0oM6YMqrzv+pls/6d44vhAYkFriLJdqncuaHzgnpUibdMZGL/8UOUNd7gTs+1tE5OSCmsKIuac/hWXM3lJsSNJpbe0ripzmfsj5Qe9N7jZzVS9peQ+yxOHPgfBRK76QBuICGu4MzKVIZUIZIZnFLeslY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757996135; c=relaxed/simple;
	bh=1ft42GUI2i/4wLsklECh7vuZmtIyF9e4qe7fg1cifg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iUu7OoqwcJTWrUQAstLEUOOB65fv9HxlpK9N+cF3HerDTREMQKfiOJu6fyIgeE2mNT5i1HR7AGQwDkI34I1hgBodc+NmOnjMHriVrtSX3fdG2LKvtMDdcIx/8ZaIZ3vmh66PEmEnTdFrPEvvxqARsO1kTxGA/tL0zhvYYavxanI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqtgAytF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE26FC4CEEB;
	Tue, 16 Sep 2025 04:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757996134;
	bh=1ft42GUI2i/4wLsklECh7vuZmtIyF9e4qe7fg1cifg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JqtgAytFrRwIzZgM7XZw0fBBL3vRq4GksafV1liBdeGVbhWuqEljxsopqd3iGzNBX
	 3BmHFNIbJIbin+Gfh3Mj1iZ9c2FIy2ize5l5OrSvUMZrbtbcyNafFp9cuJe61pYnQY
	 QxtfQdioAfXEgbVCEmBQPF5nDSTtXl4v3tvp80oeqR42XoGMNdJo4sgrqnlNQy3BrB
	 35v4gXCgw2mJgV+OJFQ0/2dJzAwAdQ3n/R9+PtMQpEzwHJvgA1oAbgU+2OG6UFg2aq
	 u5C6BRYeMYOUhhdpZsNSTaVCxkSRT0aqaCGFhII1PBD3CpATj7fl154XaRwmZOFrsP
	 U6maYVDasIVFw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
In-Reply-To: <aMfQCoLuVeR0nf02@google.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <aMfQCoLuVeR0nf02@google.com>
Date: Tue, 16 Sep 2025 09:45:18 +0530
Message-ID: <yq5a348n823t.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

> Hi Aneesh,
>
> On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Currently, we enforce the use of bounce buffers to ensure that memory
>> accessed by non-secure devices is explicitly shared with the host [1].
>> However, for secure devices, this approach must be avoided.
>
>
> Sorry this might be a basic question, I just started looking into this.
> I see that =E2=80=9Cforce_dma_unencrypted=E2=80=9D and =E2=80=9Cis_swiotl=
b_force_bounce=E2=80=9D are only
> used from DMA-direct, but it seems in your case it involves an IOMMU.
> How does it influence bouncing in that case?
>

With the current patchset, the guest does not have an assigned IOMMU (no
Stage1 SMMU), so guest DMA operations use DMA-direct.

For non-secure devices:
 - Streaming DMA uses swiotlb, which is a shared pool with the hypervisor.
 - Non-streaming DMA uses DMA-direct, and the attributes of the allocated
   memory are updated with dma_set_decrypted().

For secure devices, neither of these mechanisms is needed.

-aneesh

