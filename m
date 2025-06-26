Return-Path: <linux-pci+bounces-30756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E033AAE9E40
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 15:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DBA169124
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 13:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292142E5405;
	Thu, 26 Jun 2025 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1quAzko"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D62E427B;
	Thu, 26 Jun 2025 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943376; cv=none; b=tthV9d0jnLGFw5swnfNIfSbCvgerDSmI8Y7nPW0mM6OAJrqBcIU3zK64qcFBUsXk1M1Rcy0x+MnEx2gA083cHZzDkdUeF9XsXdLL137YvWB2zjvTQbZIeRT9iHb9qzWVtY+YRQJqK/8/Hmi48BBvWdGhGVzSmTA5KQzPgfwNXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943376; c=relaxed/simple;
	bh=4kYQMayMrWVmvStoGOZmLUJ6A52n1HD9otIp1Mp471s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=M6NcabjuGDdcAduSQFwE8i6eVb9Wkb92IIQOL0h6XHCRYnKnBSrkpMHue4wGMkvHrE9SD5+kdOW9A2CQTv8P0niUAXlQ4j00J8DDxiGoE2Or95Xwd0KCiqcoaGbjDVISvfV8ZbxSj4IeuabZJRqPz5ZCmFdwdbRBWM/yIpOI/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1quAzko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA520C4CEEB;
	Thu, 26 Jun 2025 13:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750943375;
	bh=4kYQMayMrWVmvStoGOZmLUJ6A52n1HD9otIp1Mp471s=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=L1quAzkoF1xDsNXcp1cvVr9Sq3NPGXGI+jSqqBX5EhC30mewCUJbX7z6qh787ceNe
	 xIXfT/vmZ3yMfpcneA/GOQk3OxRA/BLixNOejVZiHy9WXzYwlWsQ/eR+rOCvILSeWB
	 4w00WxqA6ThIURlznchENNUByFbwcxv8X2wma9wce92G/V5b4wCvQj3q2q2nU9TKNT
	 JRjBqDi6R5TzJrpIXI6PUoc2LTdGqXbC7q77CZMHf8O389jDbfZOepFl/6HGGbcife
	 3ZGhUyQN0q3T/eXCUMao0Nu49PTuYVfQ/0+R4Jr6r6sj8weHFhRWsUjVQUfJnTUa5/
	 jPt80Wal21xUA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Jun 2025 15:09:30 +0200
Message-Id: <DAWHMFWA2FZB.2III53VFXATS4@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <kwilczynski@kernel.org>,
 <bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] rust: devres: get rid of Devres' inner Arc
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-4-dakr@kernel.org> <aFzI5L__OcB9hqdG@Mac.home>
 <aF0aiHhCuHjLFIij@pollux> <DAWE690DWP9A.10I5FIJSZDSR6@kernel.org>
 <aF0p5vIcL_4PBJCG@pollux> <aF0xp4ZKP_a7cJsc@pollux>
In-Reply-To: <aF0xp4ZKP_a7cJsc@pollux>

On Thu Jun 26, 2025 at 1:40 PM CEST, Danilo Krummrich wrote:
> On Thu, Jun 26, 2025 at 01:07:25PM +0200, Danilo Krummrich wrote:
>> On Thu, Jun 26, 2025 at 12:27:18PM +0200, Benno Lossin wrote:
>> > On Thu Jun 26, 2025 at 12:01 PM CEST, Danilo Krummrich wrote:
>> > > On Wed, Jun 25, 2025 at 09:13:24PM -0700, Boqun Feng wrote:
>> > >> On Tue, Jun 24, 2025 at 11:54:01PM +0200, Danilo Krummrich wrote:
>> > >> [...]
>> > >> > +#[pin_data(PinnedDrop)]
>> > >> > +pub struct Devres<T> {
>> > >>=20
>> > >> It makes me realize: I think we need to make `T` being `Send`? Beca=
use
>> > >> the devm callback can happen on a different thread other than
>> > >> `Devres::new()` and the callback may drop `T` because of revoke(), =
so we
>> > >> are essientially sending `T`. Alternatively we can make `Devres::ne=
w()`
>> > >> and its friend require `T` being `Send`.
>> > >>=20
>> > >> If it's true, we need a separate patch that "Fixes" this.
>> > >
>> > > Indeed, that needs a fix.
>> >=20
>> > Oh and we have no `'static` bound on `T` either... We should require
>> > that as well.
>>=20
>> I don't think we actually need that, The Devres instance can't out-live =
a &T
>> passed into it. And the &T can't out-live the &Device<Bound>, hence we'r=
e
>> guaranteed that devres_callback() is never called because Devres::drop()=
 will be
>> able successfully unregister the callback given that we're still in the
>> &Device<Bound> scope.
>>=20
>> The only thing that could technically out-live the &Device<Bound> would =
be
>> &'static T, but that would obviously be fine.
>>=20
>> Do I miss anything?
>
> Thinking a bit more about it, a similar argumentation is true for not nee=
ding
> T: Send. The only way to leave the &Device<Bound> scope and hence the thr=
ead
> would be to stuff the Devres into a ForeignOwnable container, no?

I think `T: Send` is required, since we drop the `T` in the other thread
when `devres_callback` is called from the device unbinding.

> Analogous to Benno asking for ForeignOwnable: 'static, should we also req=
uire
> ForeignOwnable: Send + Sync?

I don't think so, you could have a type that stores the pointer in C,
but only ever allows access from the same thread.

> Alternatively, the safety requirements of ForeignOwnable:::from_foreign()=
 and
> ForeignOwnable::borrow() would need to cover this, which they currently t=
hey
> are not.

Oh right, yeah they should cover that.

---
Cheers,
Benno

