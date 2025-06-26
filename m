Return-Path: <linux-pci+bounces-30746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA07AE9C47
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 13:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882433BA451
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 11:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38AF27510D;
	Thu, 26 Jun 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn6h0K88"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AAE21D3E6;
	Thu, 26 Jun 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936534; cv=none; b=TdKi7di5lcEYqV64ICMVtAHXUxlckXFBl37xcAQj4RXNAEKh8uu4teptMJncgAeHGPuiIGnLkSUuZrGjcxt3EzoNt7icXZ2Di7PM3xx35i436CDtPX6omRtICxDPCas5nkbgmcrPktBypiNmfKZ4Li2mEM7mhyoli5iwLzR8Mp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936534; c=relaxed/simple;
	bh=k9/ShOVquPbX5tWTzTzRgRfj/vtw5/rrGx32oNlRBgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jjs/iXNuue5ZIP7cP0kOCjnJYWnhHKdSXuj04h3wPql1KIwCsKXhjQeh2091M2OILi9P+gvZDGTUAN0KJHs+YDy+rGu1elM4E/GHNV/coGvdtsCknfTLWip37lYKzAThXRei0YwuJjO3VSS64pdEd8Uzbtz75zYBn44UePwEi1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn6h0K88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8D2C4CEEB;
	Thu, 26 Jun 2025 11:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750936534;
	bh=k9/ShOVquPbX5tWTzTzRgRfj/vtw5/rrGx32oNlRBgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dn6h0K88eydQeyAMHZiUNpHm2uHFlbxz34NaJqV2aypVYrtsqXsx9mlXGXjxSlqR7
	 ikO6BiJicyuCuopnW/CmOcQT51S06ZzMQY7b+FCQM5GoJSEvtOZPd3fzwuQRr1SMAn
	 vgR2uezwNK3dCv/LUlw9LHYbuPE0JcKL+dGWuV5gOJfp1HGai9t78rfU0fQlm2x3nE
	 8W5o3mLQYMy6SyCk5AzDviif8Sup17d2/4DX+boOpWP/HJtjWogFTAKvw8beQrUEiP
	 Sk9A+aeUpqEjSrUW2EMmLkd07Kil9FSWthNiizVKg9GUKt0XEKY/k+of9DC5W8waVZ
	 Qe7Gg0Gd3vkmQ==
Date: Thu, 26 Jun 2025 13:15:27 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 4/4] rust: devres: implement register_release()
Message-ID: <aF0rzzlKgwopOVHV@pollux>
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-5-dakr@kernel.org>
 <DAWED7BIC32G.338MXRHK4NSJG@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAWED7BIC32G.338MXRHK4NSJG@kernel.org>

On Thu, Jun 26, 2025 at 12:36:23PM +0200, Benno Lossin wrote:
> Or, we could change `Release` to be:
> 
>     pub trait Release {
>         type Ptr: ForeignOwnable;
> 
>         fn release(this: Self::Ptr);
>     }
> 
> and then `register_release` is:
> 
>     pub fn register_release<T: Release>(dev: &Device<Bound>, data: T::Ptr) -> Result
> 
> This way, one can store a `Box<T>` and get access to the `T` at the end.

I think this was also the case before? Well, it was P::Borrowed instead.

> Or if they store the value in an `Arc<T>`, they have the option to clone
> it and give it to somewhere else.

Anyways, I really like this proposal of implementing the Release trait.

> Related questions:
> 
> * should we implement `ForeignOwnable` for `&'static T`?

There's already a patch on the list doing this in the context of DebugFS [1].

[1] https://lore.kernel.org/lkml/20250624-debugfs-rust-v7-3-9c8835a7a20f@google.com/

> * should we require `'static` in `ForeignOwnable`? At the moment we only
>   have those kinds supported and it only makes sense, a foreign owned
>   object can be owned for any amount of time (so it must stay valid
>   indefinitely).

Sounds reasonable to me.

