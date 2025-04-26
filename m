Return-Path: <linux-pci+bounces-26839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E42A9DD3C
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 23:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D6118981EA
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 21:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A7F1F4CAF;
	Sat, 26 Apr 2025 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktzsYGbE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616301DDA31;
	Sat, 26 Apr 2025 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745702804; cv=none; b=ajGJjRzlrEcggRefl1UVwfar+szk7MJEieOIie0xCSWaV4ZHcew0zViKJqiXTdYU2sksCz90ubkF8m9SLGOg9Zvm6KM7Z2Y+vYKtQMYGbPfnBLTJXj8QRISXc/a5f4pn7g5mfH4YgYrdMi1QErrm7HXIajpcKPXbiuS7efswvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745702804; c=relaxed/simple;
	bh=Yby1Mo/3EYqLTXwzUGNMJNPfcTdhTI0E8a0Pj9oSi4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYuRUJl9OA/zRQQcvkYrxMJd35IIunfS1I0yw1sYvbGI1A1IiXUtK68U49YI3imdeoUn+NKPZT59Jz+4h/MFVAgHBRT2b6aXh36M9WFSRgeMgWpxZrf0JCLYN6PEq+o4cilTnfBvNpdwg9cGtegWOm4ZlQap7Gc2MgDm1rOm+BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktzsYGbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D87C4CEE2;
	Sat, 26 Apr 2025 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745702803;
	bh=Yby1Mo/3EYqLTXwzUGNMJNPfcTdhTI0E8a0Pj9oSi4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktzsYGbEAaYSwQxvzpKSNvrbGqkD1wBrvJTKckiliahIu1+eeIIeTYHJuj+kGjuyC
	 EInspB4YzfLkFUTOwuRNw36KFBRblG7xPX5RDIjtzcUPQBmlfMIW5jMNteNXJmG/mP
	 Lc3jP28V32NvMHZr7cY4t9qoBUNlQe4uXA6gJAHD7AtM37+LDRpPpYJAW1DVeWzzZ+
	 rc0tdlhrN7egZPfGDqFOtOCoeFgCbp49vIO3oV/ycXy8VM1lWzegAlD6OW8Ds/+24Q
	 Hn4YfqfUGuYzQuDDgk1sNfTLrJLyFpyWzE/w5pMGe/mAZ+es2sf6c6vrvAz8n8gahb
	 Csh7yU1IcQEUQ==
Date: Sat, 26 Apr 2025 23:26:36 +0200
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
Message-ID: <aA1PjHrG4yT7XpCI@pollux>
References: <20250426133254.61383-1-dakr@kernel.org>
 <20250426133254.61383-4-dakr@kernel.org>
 <D9GUSVZY3ZT7.O3RTG4N0ZIK0@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9GUSVZY3ZT7.O3RTG4N0ZIK0@proton.me>

On Sat, Apr 26, 2025 at 08:30:39PM +0000, Benno Lossin wrote:
> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
> > For the I/O operations executed from the probe() method, take advantage
> > of Devres::access_with(), avoiding the atomic check and RCU read lock
> > required otherwise entirely.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  samples/rust/rust_driver_pci.rs | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
> > index 9ce3a7323a16..3e1569e5096e 100644
> > --- a/samples/rust/rust_driver_pci.rs
> > +++ b/samples/rust/rust_driver_pci.rs
> > @@ -83,12 +83,12 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
> >              GFP_KERNEL,
> >          )?;
> >  
> > -        let res = drvdata
> > -            .bar
> > -            .try_access_with(|b| Self::testdev(info, b))
> > -            .ok_or(ENXIO)??;
> > -
> > -        dev_info!(pdev.as_ref(), "pci-testdev data-match count: {}\n", res);
> > +        let bar = drvdata.bar.access_with(pdev.as_ref())?;
> 
> Since this code might inspire other code, I don't think that we should
> return `EINVAL` here (bubbled up from `access_with`). Not sure what the
> correct thing here would be though...

I can't think of any other error code that would match better, EINVAL seems to
be the correct thing. Maybe one could argue for ENODEV, but I still think EINVAL
fits better.

