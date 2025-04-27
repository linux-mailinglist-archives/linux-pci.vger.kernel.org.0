Return-Path: <linux-pci+bounces-26855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD40DA9E25C
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 12:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003B23BD7A4
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CADC2405E5;
	Sun, 27 Apr 2025 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPmh0aTR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBEF1AA1E0;
	Sun, 27 Apr 2025 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745748621; cv=none; b=OXvdqoZxhPHcyNZ7JS1UZelzqDWC6js+wPozmzkJlNllbDAjlCLT1sB6X1pjmVBhqTcg0vVnV/+VUbboYbGKJmnj9kAN343nB96wFJNSD4+IKFiKSAGZ/s5gxByp/ab6gLKr3QW2Zrutaofmjrthx+ecEk8K++3QWxo7LpqjS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745748621; c=relaxed/simple;
	bh=LmDoB/y/g1bdzjAapvVCYn6JmM5/tIwS924XhVIG9LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRT5jgzK0E75OwxZ1M/+Nqw8XlWdVEW5Iyl+k2QBiEUwnFWDot9b4vvq6Eska79jL9g10IGAS69yhl4ty0mI6T+LMkSjSMu4l/7F7qDQp/QLd1RUeH0BhQji3Kgsfc+C+hvjok+k5v2R2u+g+iZ3Ajj1TyeXbULKiYg7J9Ykk7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPmh0aTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E756EC4CEE3;
	Sun, 27 Apr 2025 10:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745748619;
	bh=LmDoB/y/g1bdzjAapvVCYn6JmM5/tIwS924XhVIG9LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPmh0aTRh7wrs7iTIVCj28MZ/dSZhj96rprOfXQkBASNBIMmoXp1zUqcK5xO9p93v
	 9NKBXJ+eqCKBvtPR7BGmwV14Wp/he2/i1QkF/iGqq5k98xB6Zrolzw2QPhNZhLChFH
	 m7lCy27/qWLe1ZfKw8wszZNUgrwbWHK1JlOaBXXKbsjtkKfsgPlv/GhisRN0ITVqR5
	 SCInFD3mkOKmEuwqf9vuoF6+x+jjz4ZaJsk3gN9lcTdkKboJh9f+ViJ1zBuniSHlIt
	 4KZuVCcV0sSbe96t1okyz/Ac5w1mEqnUfurO447BqFXoxEuXCiXtc17ZgyWgnTFMJh
	 9/gOflF8ltPFQ==
Date: Sun, 27 Apr 2025 12:10:12 +0200
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
Message-ID: <aA4ChLR5xf0I7YJY@pollux>
References: <D9GUR8Y08PQ6.2ULV6V4UJAGQB@proton.me>
 <aA1O8Wem1FhyybF5@pollux>
 <D9HAC6KW2GTG.ICOFCQX4A2U3@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9HAC6KW2GTG.ICOFCQX4A2U3@proton.me>

On Sun, Apr 27, 2025 at 08:41:02AM +0000, Benno Lossin wrote:
> On Sat Apr 26, 2025 at 11:24 PM CEST, Danilo Krummrich wrote:
> > On Sat, Apr 26, 2025 at 08:28:30PM +0000, Benno Lossin wrote:
> >> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
> >> > +    pub fn access_with<'s, 'd: 's>(&'s self, dev: &'d Device<Bound>) -> Result<&'s T> {
> >> 
> >> I don't think that we need the `'d` lifetime here (if not, we should
> >> remove it).
> >
> > If the returned reference out-lives dev it can become invalid, since it means
> > that the device could subsequently be unbound. Hence, I think we indeed need to
> > require that the returned reference cannot out-live dev.
> 
> I meant the following signature:
> 
>     pub fn access_with<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T>
> 
> You don't need to specify the additional `'d` one, since lifetimes allow
> subtyping [1]. So if I have a `&'s self` and a `&'d Device<Bound>` and
> `'d: 's`, then I can supply those arguments to my suggested function and
> the compiler will shorten `'d` to be `'s` or whatever is correct in the
> context.
> 
> [1]: https://doc.rust-lang.org/nomicon/subtyping.html#subtyping

Makes sense, and I don't mind changing it, but I still think the orignal version
makes the actual requirement more obvious to the reader, i.e. dev must live *at
least* as long as self, but not dev must live *exactly* as long as self.

