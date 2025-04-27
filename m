Return-Path: <linux-pci+bounces-26885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4980FA9E416
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 19:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4AF171075
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 17:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81151D6195;
	Sun, 27 Apr 2025 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjyHKQaU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B1372;
	Sun, 27 Apr 2025 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745775058; cv=none; b=hVSb2rKe0P1TZ3VHRYAf1mpaoK9pNtolECgMmNiZZmw+6H9pSuwstZBQY6UWFVSIWBlU/ISpyPU9iiq4/dgB0cxnYE22iOGPymh6eYsenwB0dXviP4h6szPCA3m3lExe7JgU2aja4cYudeczVi0l0rgzmrsnMC2lWsKKJWQYbRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745775058; c=relaxed/simple;
	bh=PbH0f94Jlgdyrw1x4nNOQFJty6pKloglJl3k4JG0sf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhYml3Njlgp5NYasp3ChtnEnLFRC+Q5e3MOKS8G40XfvhQaEwH4c03iqHMAvBoTsSsqeCCDp/V7kZWWhzuysbLDB8sBEEbbt+aJ117YhkzQ1j5e+WvwhEimuhTHsskXcwf9K63IkU4XQtf4yZHOkD9FhDXxyYwdVLPEJT/Nq6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjyHKQaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851EAC4CEE3;
	Sun, 27 Apr 2025 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745775058;
	bh=PbH0f94Jlgdyrw1x4nNOQFJty6pKloglJl3k4JG0sf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjyHKQaU/GFDQojs89xx6MEJN8vCwPKiNs/IpY2N/uF2wxpk6y/uoU9Omivh+hz72
	 u6dRt+CLum6cFmCtot4XPYIX0Dzfw0zR3IaOV4wcpZe1SfUu3FHXNr6UDqlfygENSo
	 h5HO4SChk8PdEukJeUlnQId5GhWNCU2AS6Rs/xUlrPSISwav3DWdfjpJCYKzGhSG/w
	 nl2VMZs8WvA1Labwe7qqiTaIHiraDQFUTVzdpJ5xMgH2stfuaRip3gmqr20EsaAEc6
	 633igJrKY6ZxZLkLxdr5arc1R756/MdYME+wqCcbmLHe+kRjZj8fPfiPmTPGm7IFoq
	 mDmacPmcHB+HA==
Date: Sun, 27 Apr 2025 19:30:50 +0200
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
Subject: Re: [PATCH 2/3] rust: devres: implement Devres::access_with()
Message-ID: <aA5pypMSKFtJ7kaD@pollux>
References: <D9GUR8Y08PQ6.2ULV6V4UJAGQB@proton.me>
 <aA1O8Wem1FhyybF5@pollux>
 <D9HAC6KW2GTG.ICOFCQX4A2U3@proton.me>
 <aA4ChLR5xf0I7YJY@pollux>
 <D9HL6SERYCVX.24AUGLK06TV41@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9HL6SERYCVX.24AUGLK06TV41@proton.me>

On Sun, Apr 27, 2025 at 05:11:12PM +0000, Benno Lossin wrote:
> On Sun Apr 27, 2025 at 12:10 PM CEST, Danilo Krummrich wrote:
> > On Sun, Apr 27, 2025 at 08:41:02AM +0000, Benno Lossin wrote:
> >> On Sat Apr 26, 2025 at 11:24 PM CEST, Danilo Krummrich wrote:
> >> > On Sat, Apr 26, 2025 at 08:28:30PM +0000, Benno Lossin wrote:
> >> >> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
> >> >> > +    pub fn access_with<'s, 'd: 's>(&'s self, dev: &'d Device<Bound>) -> Result<&'s T> {
> >> >> 
> >> >> I don't think that we need the `'d` lifetime here (if not, we should
> >> >> remove it).
> >> >
> >> > If the returned reference out-lives dev it can become invalid, since it means
> >> > that the device could subsequently be unbound. Hence, I think we indeed need to
> >> > require that the returned reference cannot out-live dev.
> >> 
> >> I meant the following signature:
> >> 
> >>     pub fn access_with<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T>
> >> 
> >> You don't need to specify the additional `'d` one, since lifetimes allow
> >> subtyping [1]. So if I have a `&'s self` and a `&'d Device<Bound>` and
> >> `'d: 's`, then I can supply those arguments to my suggested function and
> >> the compiler will shorten `'d` to be `'s` or whatever is correct in the
> >> context.
> >> 
> >> [1]: https://doc.rust-lang.org/nomicon/subtyping.html#subtyping
> >
> > Makes sense, and I don't mind changing it, but I still think the orignal version
> > makes the actual requirement more obvious to the reader, i.e. dev must live *at
> > least* as long as self, but not dev must live *exactly* as long as self.
> 
> I think it makes the function harder to read, since you have multiple
> lifetimes around. Once one gets used to the subtyping rule, it's much
> better to reduce the total amount of lifetimes. Otherwise it seems to me
> as if it's more complicated.

As mentioned above, I don't mind changing it, so I'll drop the 'd lifetime.

