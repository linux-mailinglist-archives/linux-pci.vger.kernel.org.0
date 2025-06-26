Return-Path: <linux-pci+bounces-30745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9D2AE9C27
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 13:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9BD4A226A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 11:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514D3219E93;
	Thu, 26 Jun 2025 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDKSfYvA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA811A5BBE;
	Thu, 26 Jun 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936046; cv=none; b=L0E+9LdD+YcVxkqprZYg4wd0vkD9X6SAeDnltudCOhb0yPH1MdgSaUIOXwFb+ciL2ChtUlHFxK5iinKw7ueudU8WlGelhatIjZHfJNGzNiVreWMIQsizmQrNR0xt1nu3aezes8/rgD1WzLr59Sjb3W9X2sHMEsV+DNKPBjbPZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936046; c=relaxed/simple;
	bh=H3NtjDQKMRud6AxOd8vIbeE02iNl7L2m8PqYMVpRcD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0bdQxfYp9VnSZGFRaOCBuZz9Qw0zW0uMIBVfQj2b2j6wFrwokuY2/9lEkIjhASPNP/HT2dWlu5OIQLKxkXSYYLDEImuT+jvn3CLUEwHMTCzLCwVdsCi3v+muD7EbnhOtsgL3B9ZEs+HnCEy1N0BYeudDfdtkF2mUWEJrgFEYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDKSfYvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F93C4CEEB;
	Thu, 26 Jun 2025 11:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750936045;
	bh=H3NtjDQKMRud6AxOd8vIbeE02iNl7L2m8PqYMVpRcD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDKSfYvAxPwNyRbvDmcpN4bsRkt1xUXXuRwATpncZnD/rBmZy4qXhzdEg6iDmPCcp
	 rXmgd9jYziqd2Yqq5AtPtjVmYdKSBN5AzJWFvaLq9H5K5eMOt1Zli9CCjxfJTQHrrn
	 4w1dw/PFWE1e4ea6pw/WpYQJfZsc1q3wAA07lz2Jp5e2MPuYBXRQ0khkGqsVuHNYJj
	 InHV3aYAf8G2trsolWLNc7FKQlpKObcaya7Zh7Ts1pkZGSvQ7kzYPomgqbMrkM6+mg
	 XmcgxR45aaZ9r1zYn/ELJFo0YYaU7bGv2bDWh9E4FH4IZf1nyoitbl2NF+MryavDn9
	 7YddblOSBWXNQ==
Date: Thu, 26 Jun 2025 13:07:18 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/4] rust: devres: get rid of Devres' inner Arc
Message-ID: <aF0p5vIcL_4PBJCG@pollux>
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-4-dakr@kernel.org>
 <aFzI5L__OcB9hqdG@Mac.home>
 <aF0aiHhCuHjLFIij@pollux>
 <DAWE690DWP9A.10I5FIJSZDSR6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAWE690DWP9A.10I5FIJSZDSR6@kernel.org>

On Thu, Jun 26, 2025 at 12:27:18PM +0200, Benno Lossin wrote:
> On Thu Jun 26, 2025 at 12:01 PM CEST, Danilo Krummrich wrote:
> > On Wed, Jun 25, 2025 at 09:13:24PM -0700, Boqun Feng wrote:
> >> On Tue, Jun 24, 2025 at 11:54:01PM +0200, Danilo Krummrich wrote:
> >> [...]
> >> > +#[pin_data(PinnedDrop)]
> >> > +pub struct Devres<T> {
> >> 
> >> It makes me realize: I think we need to make `T` being `Send`? Because
> >> the devm callback can happen on a different thread other than
> >> `Devres::new()` and the callback may drop `T` because of revoke(), so we
> >> are essientially sending `T`. Alternatively we can make `Devres::new()`
> >> and its friend require `T` being `Send`.
> >> 
> >> If it's true, we need a separate patch that "Fixes" this.
> >
> > Indeed, that needs a fix.
> 
> Oh and we have no `'static` bound on `T` either... We should require
> that as well.

I don't think we actually need that, The Devres instance can't out-live a &T
passed into it. And the &T can't out-live the &Device<Bound>, hence we're
guaranteed that devres_callback() is never called because Devres::drop() will be
able successfully unregister the callback given that we're still in the
&Device<Bound> scope.

The only thing that could technically out-live the &Device<Bound> would be
&'static T, but that would obviously be fine.

Do I miss anything?

