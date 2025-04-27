Return-Path: <linux-pci+bounces-26857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40861A9E270
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 12:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDEF57A80FE
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CA222172E;
	Sun, 27 Apr 2025 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KroMEyYh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19691C54A2;
	Sun, 27 Apr 2025 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745749214; cv=none; b=EXsoBEXRY5flzInyX/gnVsCZ1l9XzJpfu1oE/0QXqI+o/4Eiwm2tJAdFr3vryklk8e9YG5s+BTheJc2CFrAMeYl26+PRyQloNl2QwM4DdApr3vUTi0Ic+Gid4yzy4xswgk1ELV1/RcB03w20J9RPkvP4rF/hnPgmAZOE0iH99KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745749214; c=relaxed/simple;
	bh=rO9yvrRMS4fVoUd43WSIQgQh+yAB8RwSauej7gzYZlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2qkpRxxcZ7JVSsc4IVZG40TxDZnX5FW5YI+mCi486UWmdmr6XgSoj3YBgRV6UhrCdWg8TQJgTPjlVDUlY/8vS7mZ++KlOR4ohUsaI6U8BxpZKQa+SWCtzxVDY4jrcBa0L+GrSI+k9AketdGXrFP0oT+ACMt+jEo47qyczW0Yfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KroMEyYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FBDC4CEE3;
	Sun, 27 Apr 2025 10:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745749214;
	bh=rO9yvrRMS4fVoUd43WSIQgQh+yAB8RwSauej7gzYZlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KroMEyYhTOKykzhhb+Mhkp4qgOVKnwYCGdPx8IkZfCq99k0ZzBwOMW1KbePtWAIND
	 E/1FznEWwXH1reWBIwWERTzEJi5CyWOvuaE1ixw8Ys2iIs5vhiWnkcWeQXb1kjRr83
	 fDb/q+Wsj0IuCGSgGDkvTBKp09WUe/YkdRE105075hrrwE/kl7WtkQn7wiVE8pI4/d
	 3/oW+oJ1ApsQ4TywKjOjjrPw/LBvvkauA++DlW1YbDPtdKOxo2aL4J1QsKqUp7KgkJ
	 ZXazzyg9IBI1KGAttQtdrrlg/UckH8xt8fukEGnobsO0pzuMHRvhFp3S2+Or8pRh2u
	 ZOLolzdwRVV/g==
Date: Sun, 27 Apr 2025 12:20:06 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] samples: rust: pci: take advantage of
 Devres::access_with()
Message-ID: <aA4E1itCT7RczSD6@pollux>
References: <20250426133254.61383-1-dakr@kernel.org>
 <20250426133254.61383-4-dakr@kernel.org>
 <D9GUSVZY3ZT7.O3RTG4N0ZIK0@proton.me>
 <aA1PjHrG4yT7XpCI@pollux>
 <D9HAO06XMT9X.1NL63T3GBQG7B@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9HAO06XMT9X.1NL63T3GBQG7B@proton.me>

On Sun, Apr 27, 2025 at 08:56:29AM +0000, Benno Lossin wrote:
> On Sat Apr 26, 2025 at 11:26 PM CEST, Danilo Krummrich wrote:
> > On Sat, Apr 26, 2025 at 08:30:39PM +0000, Benno Lossin wrote:
> >> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
> >> > For the I/O operations executed from the probe() method, take advantage
> >> > of Devres::access_with(), avoiding the atomic check and RCU read lock
> >> > required otherwise entirely.
> >> >
> >> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >> > ---
> >> >  samples/rust/rust_driver_pci.rs | 12 ++++++------
> >> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >> >
> >> > diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
> >> > index 9ce3a7323a16..3e1569e5096e 100644
> >> > --- a/samples/rust/rust_driver_pci.rs
> >> > +++ b/samples/rust/rust_driver_pci.rs
> >> > @@ -83,12 +83,12 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
> >> >              GFP_KERNEL,
> >> >          )?;
> >> >  
> >> > -        let res = drvdata
> >> > -            .bar
> >> > -            .try_access_with(|b| Self::testdev(info, b))
> >> > -            .ok_or(ENXIO)??;
> >> > -
> >> > -        dev_info!(pdev.as_ref(), "pci-testdev data-match count: {}\n", res);
> >> > +        let bar = drvdata.bar.access_with(pdev.as_ref())?;
> >> 
> >> Since this code might inspire other code, I don't think that we should
> >> return `EINVAL` here (bubbled up from `access_with`). Not sure what the
> >> correct thing here would be though...
> >
> > I can't think of any other error code that would match better, EINVAL seems to
> > be the correct thing. Maybe one could argue for ENODEV, but I still think EINVAL
> > fits better.
> 
> The previous iteration of the sample used the ENXIO error code.

Yes, because the cause of error for try_access_with() failing would have been
that the device was unbound already, hence a different error code.

> In this sample it should be impossible to trigger the error path. But
> others might copy the code into a context where that is not the case and
> then might have a horrible time debugging where the `EINVAL` came from.

I think it should always pretty unlikely design wise to supply a non-matching
device.

> I don't know if our answer to that should be "improve debugging errors
> in general" or "improve the error handling in this case". I have no
> idea how the former could look like, maybe something around
> `#[track_caller]` and noting the lines where an error was created? For
> the latter case, we could do:
> 
>     let bar = match drvdata.bar.access_with(pdev.as_ref()) {
>         Ok(bar) => bar,
>         Err(_) => {
>             // `bar` was just created using the `pdev` above, so this should never happen.
>             return Err(ENXIO);

If the caller really put in a non-matching device we can't say for sure that the
cause is ENXIO, the only thing we know is that the code author confused device
instances, so I think EINVAL is still the correct thing to return.

The problem that it might be difficult to figure out the source of the error
code has always been present in the kernel, and while I'm not saying we
shouldn't aim for improving this, I don't think this patch is quite the place
for this.

