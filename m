Return-Path: <linux-pci+bounces-38447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D37BE831E
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 12:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35533581871
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C931E11C;
	Fri, 17 Oct 2025 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTPJ8dU6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E4B31AF18;
	Fri, 17 Oct 2025 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698601; cv=none; b=RsmR4QgxPXCVcxNZnild+Ah8i0gIj/IcIVxCT5qUJlItlQF3yb1BEIVAZWQpkvAeQ+tWG3SK0p3fIJEZ0l4td6L8dXAapI+7GYYOcAa5u/d13CMpYjkkguw9dxdtjq+WsXy55Mvyc2djWJmteGRJ0p9VDq27m6wMfi+Rs559qN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698601; c=relaxed/simple;
	bh=tyA/LHJlFit5K6PqK6XOjstXqHYpybUs0kAPdQMiMhA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=iCvZhqzv2EgtDKsBSVExnSDQ27yF4z8Q2wUP38QFDcGtftNt2qg+IC+liCrwHQwg5qt6n4mGdIiMBknbhqyrZy5giuJwZbwxE7ztyY38f6FuiMFR6uiTdj7S1XB+dohGxga9VbZXyQyCC/TrGI8iWSOCiN7X/5e8xQfvRB8Bo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTPJ8dU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041D3C4CEE7;
	Fri, 17 Oct 2025 10:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760698600;
	bh=tyA/LHJlFit5K6PqK6XOjstXqHYpybUs0kAPdQMiMhA=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=VTPJ8dU6WcbYUPcgmJO4eOEz9CbPEBuxfrH3aIvi9nacKFwUZPFn8/nvXF2yDNdSC
	 Vl7KULH8FxwarRMsXDzCnOamNPN+D70vPR9ttRAwha2OFr4SGEIiDpYpg+85o+fT/l
	 gXfUNo1lcdXq3zEqHMTmN4uATBQWI+Eo00ePLUBtuTtHoObxaEhqj8/4qsdA/AYazp
	 ZzHDpdNLsYPQa7KSDhC7fYvU1WA0E/+AWNazWf3zCPJjNGIn24qu85AJy1M5ZARGzf
	 D3v0sPgfD6OBqEn6R2y88qMgTcw2bxFCAFS9lUyviKm43m5MCX7VZF4aaDGqQe9bqK
	 Gjf/wdlj9ECLg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 12:56:34 +0200
Message-Id: <DDKJK7SXG83N.2YZYITMDGTHP@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/5] rust/io: factor common I/O helpers into Io trait
 and specialize Mmio<SIZE>
References: <20251016210250.15932-1-zhiw@nvidia.com>
 <20251016210250.15932-2-zhiw@nvidia.com>
In-Reply-To: <20251016210250.15932-2-zhiw@nvidia.com>

On Thu Oct 16, 2025 at 11:02 PM CEST, Zhi Wang wrote:
> diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core=
/regs/macros.rs
> index 8058e1696df9..c2a6547d58cd 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -609,7 +609,7 @@ impl $name {
>              /// Read the register from its address in `io`.
>              #[inline(always)]
>              pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self whe=
re
> -                T: ::core::ops::Deref<Target =3D ::kernel::io::Io<SIZE>>=
,
> +                T: ::core::ops::Deref<Target =3D ::kernel::io::Mmio<SIZE=
>>,

This should be

	T: ::core::ops::Deref<Target =3D I>,
	I: ::kernel::io::Io<SIZE>,

instead, otherwise register!() only works for MMIO, but it should work for =
any
I/O backend.

> +impl<const SIZE: usize> Io<SIZE> for Mmio<SIZE> {
> +    /// Returns the base address of this mapping.
> +    #[inline]
> +    fn addr(&self) -> usize {
> +        self.0.addr()
> +    }
> +
> +    /// Returns the maximum size of this mapping.
> +    #[inline]
> +    fn maxsize(&self) -> usize {
> +        self.0.maxsize()
> +    }
> +}

The I/O trait should contain the corresponding read/write accessors, otherw=
ise
we can't easily wire up the register!() macro with arbitrary I/O backends.

I think more specific things, such as relaxed operations can remain MMIO
specific, but all the {try_}{read,write}{8,16,32,64} accessors should be pa=
rt of
the I/O trait.

