Return-Path: <linux-pci+bounces-30869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3567DAEAA78
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 01:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D43256807C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CE721CA02;
	Thu, 26 Jun 2025 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsNi3yTz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644415990C;
	Thu, 26 Jun 2025 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750980000; cv=none; b=DdfuzpLrwdZoTobVMgUguczOgK7XVEGAniNz7FXt0KfgQcCuL4R/4X7LZeN4NQPhmplzoxxD+oSDcRdnWaydE/6ROXnrUzJ4xZenIuaMCw/JYVJJmYsTWnThmoBYo0mBdaz6TV5fUvl2P7bYGquWAGrUeHWKkOwaAkKbBYv7GCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750980000; c=relaxed/simple;
	bh=z3+6X/6kDgnhdF5uoFmXZehMXMvOdnvxsXCMWsI66A0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cJ84NhIS8CWBAslZPA+vlkLlBscWtiwPVAp2Ooik8xYbhoGI2C+3dP0ohFCgdhhsBByapNq8M5BCGqljELOUypVDOkAUEEVo04P3ps/9R2l4GalaKW3QEXTy26BLkJT3V4kI9skruUBf9IoxI4cMlNgwF365N4NGlQIunr93tn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsNi3yTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE74C4CEEF;
	Thu, 26 Jun 2025 23:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750979999;
	bh=z3+6X/6kDgnhdF5uoFmXZehMXMvOdnvxsXCMWsI66A0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZsNi3yTzdyk5zwyp3gEiWV8KUnFUpTLPdXiRy+To3mWmqhBnZ3R0ldRNKKUzRMoPR
	 JdQ5C/eGzeyQi+fTWkoVoW5Wca03KXfFIX2xobuYySyS8iyz0jAjvQvyUUb57Irgkj
	 GZWtL5apLLX8WpXSLh0LjUdgtUO/z+dcjgxvsVyqhntOF6u/ZSjjiPvaVwUWyk71y6
	 uqRuAtNCT9E0oUI8d0wp6iFL8omhoWqMrTIVKGG9Qrfyauc4H93mtax6oFmJP5GAkz
	 QFRKm1IW95YUedefkFvpqMlTQJt+TO3mHrJbNM3BowQcuqRH4bF4OzuZAjwFiX2pOy
	 KfcnxrNqsdLBA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 01:19:53 +0200
Message-Id: <DAWULS8SIOXS.1O4PLL2WCLX74@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] rust: devres: implement register_release()
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-6-dakr@kernel.org> <aF2vgthQlNA3BsCD@tardis.local>
 <aF2yA9TbeIrTg-XG@cassiopeiae>
In-Reply-To: <aF2yA9TbeIrTg-XG@cassiopeiae>

On Thu Jun 26, 2025 at 10:48 PM CEST, Danilo Krummrich wrote:
> On Thu, Jun 26, 2025 at 01:37:22PM -0700, Boqun Feng wrote:
>> On Thu, Jun 26, 2025 at 10:00:43PM +0200, Danilo Krummrich wrote:
>> > +/// [`Devres`]-releaseable resource.
>> > +///
>> > +/// Register an object implementing this trait with [`register_releas=
e`]. Its `release`
>> > +/// function will be called once the device is being unbound.
>> > +pub trait Release {
>> > +    /// The [`ForeignOwnable`] pointer type consumed by [`register_re=
lease`].
>> > +    type Ptr: ForeignOwnable;
>> > +
>> > +    /// Called once the [`Device`] given to [`register_release`] is u=
nbound.
>> > +    fn release(this: Self::Ptr);
>> > +}
>> > +
>>=20
>> I would like to point out the limitation of this design, say you have a
>> `Foo` that can ipml `Release`, with this, I think you could only support
>> either `Arc<Foo>` or `KBox<Foo>`. You cannot support both as the input
>> for `register_release()`. Maybe we want:
>>=20
>>     pub trait Release<Ptr: ForeignOwnable> {
>>         fn release(this: Ptr);
>>     }
>
> Good catch! I think this wasn't possible without ForeignOwnable::Target.

Hmm do we really need that? Normally you either store a type in a shared
or a non-shared manner and not both...

---
Cheers,
Benno

