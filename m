Return-Path: <linux-pci+bounces-30755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF577AE9E36
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 15:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3065168C48
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C422E427D;
	Thu, 26 Jun 2025 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGb508gb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8892E427B;
	Thu, 26 Jun 2025 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943272; cv=none; b=LSeL+kOsuSTPjmQLBV9zLNihtlhZYrP6kD/Lv7FsUIpX4g33x6XLbA0rgGgIMR0t28GR9GF8VM5ChwtBI3wTb1dY1rthawhr3y2dtmb2cWJwRMWy+TGz4zieKubrHj+DVn1OF3HqM/gfu+nw1KMSq+dctlwKdCkwRa62wt4lbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943272; c=relaxed/simple;
	bh=1cc6i/SKqjjHG+MY0TMZQTCnqXf1errPmHMvb0A9nAA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=PiOgzaEo50WbO53LYrdXUGWRAqXCObyIy8Zj8kHe5ndH9FuwKiUTK85fcNQ90Up5ELprke3vTLOd0ajX1XBjECKhVc9pUH6HE4cOgjrSvGZGJQb97ngS+3gdAL2ZHXlSXwOVeZO9rCEoizsL9zLMRYrPgXayCukXCIBkeXOtBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGb508gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3C9C4CEED;
	Thu, 26 Jun 2025 13:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750943272;
	bh=1cc6i/SKqjjHG+MY0TMZQTCnqXf1errPmHMvb0A9nAA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=oGb508gb7TTQiKkHtPPIkIAEsJ2xdPsrVk4Wi1DqnojoECmpdKQ9Q/dzLvImPHCp8
	 uyBHb9WalDwgJjpCuTmWv5cv/he/4k/K5xTfSxiEEldoQynXwg2g8vb9AYyAxaq4UI
	 rzGBWITVDk//VmjeCjamHDb9GFeUnmxjKpVz2dziO0uMEgwdQGach3ev1vqezCwfCq
	 4b4YZfRTk8LsACT1CJ8R5P8vo5VeJGgkkHobmAv4keft2nwIKl/5gOPhfiyKSP55Ni
	 /3kQFhrxHwpxPvfCCrxSyTlVQWySxZlPGBR8ua4rxYC50n5UsuXCBEiqMzFpzUJTKX
	 bmNqg9iCA5J1A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Jun 2025 15:07:47 +0200
Message-Id: <DAWHL4FKR25G.3PFDJX0SGX00E@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <kwilczynski@kernel.org>,
 <bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] rust: devres: get rid of Devres' inner Arc
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-4-dakr@kernel.org> <aFzI5L__OcB9hqdG@Mac.home>
 <aF0aiHhCuHjLFIij@pollux> <DAWE690DWP9A.10I5FIJSZDSR6@kernel.org>
 <aF0p5vIcL_4PBJCG@pollux>
In-Reply-To: <aF0p5vIcL_4PBJCG@pollux>

On Thu Jun 26, 2025 at 1:07 PM CEST, Danilo Krummrich wrote:
> On Thu, Jun 26, 2025 at 12:27:18PM +0200, Benno Lossin wrote:
>> On Thu Jun 26, 2025 at 12:01 PM CEST, Danilo Krummrich wrote:
>> > On Wed, Jun 25, 2025 at 09:13:24PM -0700, Boqun Feng wrote:
>> >> On Tue, Jun 24, 2025 at 11:54:01PM +0200, Danilo Krummrich wrote:
>> >> [...]
>> >> > +#[pin_data(PinnedDrop)]
>> >> > +pub struct Devres<T> {
>> >>=20
>> >> It makes me realize: I think we need to make `T` being `Send`? Becaus=
e
>> >> the devm callback can happen on a different thread other than
>> >> `Devres::new()` and the callback may drop `T` because of revoke(), so=
 we
>> >> are essientially sending `T`. Alternatively we can make `Devres::new(=
)`
>> >> and its friend require `T` being `Send`.
>> >>=20
>> >> If it's true, we need a separate patch that "Fixes" this.
>> >
>> > Indeed, that needs a fix.
>>=20
>> Oh and we have no `'static` bound on `T` either... We should require
>> that as well.
>
> I don't think we actually need that, The Devres instance can't out-live a=
 &T
> passed into it. And the &T can't out-live the &Device<Bound>, hence we're
> guaranteed that devres_callback() is never called because Devres::drop() =
will be
> able successfully unregister the callback given that we're still in the
> &Device<Bound> scope.

Yeah that's correct, I got confused.

> The only thing that could technically out-live the &Device<Bound> would b=
e
> &'static T, but that would obviously be fine.
>
> Do I miss anything?

Nope :)

---
Cheers,
Benno

