Return-Path: <linux-pci+bounces-32243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A94B06FD6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 10:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9499C500182
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 08:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC8528A1C8;
	Wed, 16 Jul 2025 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZQ6Cde4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931F92459E5;
	Wed, 16 Jul 2025 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653072; cv=none; b=ZKp1yeCbWaQeXqzUgNy8AXIt0RNl7NL9CpfOSOMPQQvMH++L+2epBWh3C3cwAYRTLOUYNoQWU0g3qjgEGQWVEp7BWdC4iIaR0xLqThwLX53E94TG5xchi8IDgNiloESgSdCIy91uK0+UxPs7YwxnsfU9ja0chbahzp4siFnAOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653072; c=relaxed/simple;
	bh=ppdzzBKFjI7kQ1+tfDKaU9iIioZYEueihsIby5RUlvM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CrYEgU86Ie6GFfKlqbR6oRnyvSL9K/v9x9zNFxmKowNYNzrhk0E+WpbSUPuViwkG7hZSE0JjvH44F7qXzdxPFF5jq0N6mFJcg8aHs/Qe4oj8Ud2z6aR/8M5AukmWjdK0OhOMKUpiLhf8ct8i7aEc1Bke8dhidp+Yq9C/Ft2kuYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZQ6Cde4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F2DC4CEF5;
	Wed, 16 Jul 2025 08:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752653072;
	bh=ppdzzBKFjI7kQ1+tfDKaU9iIioZYEueihsIby5RUlvM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=SZQ6Cde4tKBs5gp02BFQ9EVkSWglErefqVfDkCkMu8lWX5LeLWDJX8ktww+9bfn2R
	 9ww66zZqY5Z7F6cHKIQwMes6P1Voz0xw/dXWqeF34w3A3j5paM7yO1cHGd//BvSCBA
	 SZ91RBqh0y40lVQ/DFnLLjufTvUlDJqKkdFQVYOUi6qrDbqZsyk9tPM/MLNkbnQHEb
	 +/kejUWStkPBocshqEvZ602J6qxil6UPml7SV8SPFFdnI6M/Sz1tFhVl9ewWSFYhwA
	 fLJMpOiwHwlVtgG+IQEojJ9WFAMQUk5VrbiE2L5FnD6UrV89JVpSUsp2Pb3IfVO4rh
	 zQ3/OHTrxL03A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 10:04:26 +0200
Message-Id: <DBDBNRC9VEU5.2MXQF7KLR2HA7@kernel.org>
Subject: Re: [PATCH 2/5] rust: dma: add DMA addressing capabilities
Cc: <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250710194556.62605-1-dakr@kernel.org>
 <20250710194556.62605-3-dakr@kernel.org>
 <DBD5KXIOSD22.L4RPVLDQ7WDQ@nvidia.com>
In-Reply-To: <DBD5KXIOSD22.L4RPVLDQ7WDQ@nvidia.com>

On Wed Jul 16, 2025 at 5:18 AM CEST, Alexandre Courbot wrote:
> On Fri Jul 11, 2025 at 4:45 AM JST, Danilo Krummrich wrote:
>> @@ -18,7 +18,83 @@
>>  /// The [`dma::Device`](Device) trait should be implemented by bus spec=
ific device representations,
>>  /// where the underlying bus is DMA capable, such as [`pci::Device`](::=
kernel::pci::Device) or
>>  /// [`platform::Device`](::kernel::platform::Device).
>> -pub trait Device: AsRef<device::Device<Core>> {}
>> +pub trait Device: AsRef<device::Device<Core>> {
>> +    /// Set up the device's DMA streaming addressing capabilities.
>> +    ///
>> +    /// This method is usually called once from `probe()` as soon as th=
e device capabilities are
>> +    /// known.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This method must not be called concurrently with any DMA alloca=
tion or mapping primitives,
>> +    /// such as [`CoherentAllocation::alloc_attrs`].
>
> I'm a bit confused by the use of "concurrently" in this sentence. Do you
> mean that it must be called *before* any DMA allocation of mapping
> primitives? In this case, wouldn't it be clearer to make the order
> explicit?

Setting the mask before any DMA allocations might only be relevant from a
semantical point of view, but not safety wise.

We need to prevent concurrent accesses to dev->dma_mask and
dev->coherent_dma_mask.

>> +    unsafe fn dma_set_mask(&self, mask: u64) -> Result {
>
> Do we want to allow any u64 as a valid mask? If not, shall we restrict
> the accepted values by taking either the parameter to give to
> `dma_bit_mask`, or a bit range (similarly to Daniel's bitmask series
> [1], which it might make sense to leverage)?
>
> [1]
> https://lore.kernel.org/rust-for-linux/20250714-topics-tyr-genmask2-v9-1-=
9e6422cbadb6@collabora.com/

I think it would make sense to make dma_bit_mask() return a new type, e.g.
DmaMask and take this instead.

Taking the parameter dma_bit_mask() takes directly in dma_set_mask() etc. m=
akes
sense, but changes the semantics of the mask parameter *subtly* compared to=
 the
C versions, which I want to avoid.

Using the infrastructure in [1] doesn't seem to provide much value, since w=
e
don't want a range [M..N], but [0..N], so we should rather only ask for N.

