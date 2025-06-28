Return-Path: <linux-pci+bounces-30992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972DFAEC5B3
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 09:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC116E1774
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 07:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A43A221F0E;
	Sat, 28 Jun 2025 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiAykm51"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF791A23B5;
	Sat, 28 Jun 2025 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751097192; cv=none; b=YMRaksN+dgA4Z5ZlddQlL5BKMybA0iw1cw7mIWELDWdMh/zETjgPq+B9U68MYwvIGuGeAnbSVO6G1zfLpGDz/p0bdPVjxQq87JvCtRsXUcEQQUFEtiNHEmMRsaYsSV07eBLEPhYIlKcVpA7xkkCxf4KrxAg+IBFQS3fhJfMjbVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751097192; c=relaxed/simple;
	bh=Wt7l/DfLPgfPEwp0qS2mUttKAMudGoB0UoZ0ax3W/fM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=S9Xm6HDwvRz2rgm3/fFGQH6YkpGIpvfNvaZt2kkGt6iOwDflaeQ85g0uP8JM6BOZvTrsjmCOdrqcWaEeiuwt+3MIQT1OZgWgTg8G7AJNAzn5CSBlVJ+JE5IUNmIidMvaiyFo4kgjTRVVugvpSts/Lwc1jcQugm655uVT1kaV220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiAykm51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C83C4CEEA;
	Sat, 28 Jun 2025 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751097191;
	bh=Wt7l/DfLPgfPEwp0qS2mUttKAMudGoB0UoZ0ax3W/fM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=GiAykm51isvLyV2Pccs7N91t+eHej+hLyUkmjx1mzDbd+/VrpHVR17B8q2eRFUsmC
	 7/MWgqTEstp2zDWVPX9bVT+an4M7Sg6UUkVY9mlHwpPNpV4DSHG2VWC20zGFrsuu/Q
	 F8gv2rvAXh8lBpp+gDP6HGp2FoUq2J5thqdOYhiQZ+wC+9LM+9IypUX5125/zN4Qeu
	 ++FJ5QWjir6vvO1MitZnhhmdkOP2geUCf6hr1K8G2BZRb+7h02MByRPARzbnxKdOuj
	 E51SDl4+k9NkRrVrY/Ovn4yVzwIvHKqQHJgzUrnv2oHlCJ95KDmwvAa3jMHXStZA40
	 zRPuetMhdJAHw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Jun 2025 09:53:06 +0200
Message-Id: <DAY059Y669BX.2GVKH6RBG80B6@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <kwilczynski@kernel.org>,
 <bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] rust: devres: implement register_release()
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-6-dakr@kernel.org> <aF2vgthQlNA3BsCD@tardis.local>
 <aF2yA9TbeIrTg-XG@cassiopeiae> <DAWULS8SIOXS.1O4PLL2WCLX74@kernel.org>
 <aF8V8hqUzjdZMZNe@tardis.local> <DAXXVXNTRLYH.1B8O2LKBF4EW1@kernel.org>
 <aF-N-luMxFTurl91@Mac.home>
In-Reply-To: <aF-N-luMxFTurl91@Mac.home>

On Sat Jun 28, 2025 at 8:38 AM CEST, Boqun Feng wrote:
> On Sat, Jun 28, 2025 at 08:06:52AM +0200, Benno Lossin wrote:
>> On Sat Jun 28, 2025 at 12:06 AM CEST, Boqun Feng wrote:
>> > On Fri, Jun 27, 2025 at 01:19:53AM +0200, Benno Lossin wrote:
>> >> On Thu Jun 26, 2025 at 10:48 PM CEST, Danilo Krummrich wrote:
>> >> > On Thu, Jun 26, 2025 at 01:37:22PM -0700, Boqun Feng wrote:
>> >> >> On Thu, Jun 26, 2025 at 10:00:43PM +0200, Danilo Krummrich wrote:
>> >> >> > +/// [`Devres`]-releaseable resource.
>> >> >> > +///
>> >> >> > +/// Register an object implementing this trait with [`register_=
release`]. Its `release`
>> >> >> > +/// function will be called once the device is being unbound.
>> >> >> > +pub trait Release {
>> >> >> > +    /// The [`ForeignOwnable`] pointer type consumed by [`regis=
ter_release`].
>> >> >> > +    type Ptr: ForeignOwnable;
>> >> >> > +
>> >> >> > +    /// Called once the [`Device`] given to [`register_release`=
] is unbound.
>> >> >> > +    fn release(this: Self::Ptr);
>> >> >> > +}
>> >> >> > +
>> >> >>=20
>> >> >> I would like to point out the limitation of this design, say you h=
ave a
>> >> >> `Foo` that can ipml `Release`, with this, I think you could only s=
upport
>> >> >> either `Arc<Foo>` or `KBox<Foo>`. You cannot support both as the i=
nput
>> >> >> for `register_release()`. Maybe we want:
>> >> >>=20
>> >> >>     pub trait Release<Ptr: ForeignOwnable> {
>> >> >>         fn release(this: Ptr);
>> >> >>     }
>> >> >
>> >> > Good catch! I think this wasn't possible without ForeignOwnable::Ta=
rget.
>> >>=20
>> >> Hmm do we really need that? Normally you either store a type in a sha=
red
>> >
>> > I think it might be quite common, for example, `Foo` may be a general
>> > watchdog for a subsystem, for one driver, there might be multiple
>> > devices that could feed the dog, for another driver, there might be on=
ly
>> > one. For the first case we need Arc<Watchdog> or the second we can do
>> > Box<Watchdog>.
>>=20
>> I guess then the original `&self` design is better? Not sure...
>>=20
>
> This is what you said in v3:
>
> """
> and then `register_release` is:
>
>     pub fn register_release<T: Release>(dev: &Device<Bound>, data: T::Ptr=
) -> Result
>
> This way, one can store a `Box<T>` and get access to the `T` at the end.
> Or if they store the value in an `Arc<T>`, they have the option to clone
> it and give it to somewhere else.
> """
>
> I think that's the reason why we think the current version (the
> associate type design) is better than `&self`?

Yeah and I'd still say that that statement is true.

> The generic type design (i.e. Release<P: ForeignOwnable>) just further
> allows this "different behaviors between Box and Arc" for the same type
> T. I think it's a natural extension of the current design and provides
> some better flexibility.

I think that extension is going to end up being too verbose.

>> > What's the downside?
>>=20
>> You'll need to implement `Release` twice:
>>=20
>
> Only if you need to support both for `Foo`, right? You can impl only one
> if you only need one.
>
> Also you can do:
>
>     impl<P: ForeignOwnable<Target=3DFoo> + Deref<Target=3DFoo>> Release<P=
> for Foo {
>         fn release(this: P) {
> 	    this.deref().do_sth();
> 	}
>     }

Please no. If this is a regular pattern, then let's go back to `&self`.
You lose all benefits of the generic design if you do it like this,
because you don't know the concrete type of the foreign ownable.

> if you want Box and Arc case share the similar behavior, right?
>
>>     impl Release<Box<Self>> for Foo {
>>         fn release(this: Box<Self>) {
>>             /* ... */
>>         }
>>     }
>>=20
>>     impl Release<Arc<Self>> for Foo {
>>         fn release(this: Arc<Self>) {
>>             /* ... */
>>         }
>>     }
>>=20
>> This also means that you can have different behavior for `Box` and
>> `Arc`...
>
> That's the point, as one of the benefits you mentioned above for the
> associate type design, just extending it to the same type.

I'd say that's too verbose for something that's rather supposed to be
simple.

Hmm @Danilo, do you have any use-cases in mind or already done?

---
Cheers,
Benno

