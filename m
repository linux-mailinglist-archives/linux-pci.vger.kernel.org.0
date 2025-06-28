Return-Path: <linux-pci+bounces-30986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E93FAEC55E
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 08:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A2E188B663
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 06:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8DE21C16B;
	Sat, 28 Jun 2025 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3+PMlon"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36D23CB;
	Sat, 28 Jun 2025 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751092735; cv=none; b=AcsLh5AovXZ/NoWymiV+37nS9S0kyjWEjbdOb0Lmm/9MnDFdS9MuKKgxY2SLzLlU0rFWoh8S5KFYkUOG5MmkGK4FU+Okg2xJPkfoVt1Jl7wL7F2Z+0VYtP0z9BRr11JuOt1fDHY561i16QLX7hN9g7bB5JMDoN/ypYM76RmaUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751092735; c=relaxed/simple;
	bh=oP7t6HvsgP8qgMA7aRmI/wAjO9SSAlA+570vBivG8lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvIxpZxfvfxPt/WtyrBhE/o+zPzMbvyejdYvZ+FYmPXKnzXxO1hwA7R51KrCyhvQ7ERO4E7cHpNOM4z1wzpX3YKYXWPSsP3Q17deYLjFGkNYeDL/wp9OyJ2FgNTJ6R89TeIkX45t4RU1w3aY0/+qHFnPWcYZJWb5idpYxkG+QWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3+PMlon; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d44e4d248dso28837185a.2;
        Fri, 27 Jun 2025 23:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751092733; x=1751697533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOUJ6GG0uLmctREkF28ijNPjBM4EJ3ix2IGOKO6Y/9g=;
        b=J3+PMlonaEHLmV7F0MAnXR4fqAC0+5lkmQBgNKUt6CCYbnxTTuVxrG9ANJnSCEisFL
         QKROvUpiKr0v7+n5BRQzAX78CeEtWc8h20/G4RWyccDOYb41Bz+OXouzDmTQdfCSHJNs
         8Jgs2vAh2HMGGyIXC/5fe5hRt1gU8ej5nLe8pg+bQte+lMoIqJ+PW0dxA7ERsWmmC8cv
         g75Gx58590lSf8LSx8kqGyZyr9saxzZ2FGV0GWxFZT51COzlY8meGHB4P0bJdIO+9hD4
         M1hiD3owF77JLw+/02qPQxkxoSxLJVBj9zGwoIAZCgCbCBm6kNH06IvRXTuRj8LCEszU
         f1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751092733; x=1751697533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOUJ6GG0uLmctREkF28ijNPjBM4EJ3ix2IGOKO6Y/9g=;
        b=tOqTrANKm9O2M46PsdR+kT0VOXdySmmPYfrg6pTGy6VEx2yNHQQBIT8OC5U+Jqg7rw
         HXdOr/alr1Kgcl8Kcb6sKQ/flO7yNFFbSLpDOQgeyIRtincEfsM0sg1tWzjlncv5PgYB
         lWuu0X7XsKjfaMDwAir5xVZgHy8xLs/33ZNebR7udUjaUmK0sMYLI77AXUAa0kCGoaip
         zQst/j09WksQPCMHXieN0ATy8wAEeApr8xNKwj/URDSZ2eMhkT/KaJu0HTvxnLcpTKkJ
         L0WyoNOk4jbrH77culM4VOmSGgXfMA4b/bzEF8H5U0NVuOGXb6PQeqd95MOEyLhD4kIr
         KF5A==
X-Forwarded-Encrypted: i=1; AJvYcCUj2CKYRJl1PqGRCfcFFKDS1udIHF3rlXFpUhPIoEzBTG1j6iSOvI5toPk1b7nnu1xi6CGuJli2zXcm/MU=@vger.kernel.org, AJvYcCWUK6GdOF+VLLi+BgeDpbCCSvxX0DD8QBiaYt+6FGsHKe5G+jCG2UKqxVXN1pETMfHY+s+72GrtGSU2oLBtC5k=@vger.kernel.org, AJvYcCXmg8ZAse2jzbudDJiiGYPubJZE2YxQP59hfcN7CYea9JjXYrFrGGSPjQRMdUI+bx/f0EbM0mByvtC5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp0miAnso7ik6GDQqHYpsWyvu72kFQP328g4Uj5ZwqJB/mt/3R
	ZqF5THYIpv0yp07mWy98Xg/9GOT+bEvOd0825M1gPKYfiveZjYSI/BuH
X-Gm-Gg: ASbGnctiEAI/xU8fhyprlzbcJe3EOXlnqpzp3HznTHoyyDFwchkZnydxmkPrBWYzsD5
	PpqZGgag9B6sM1plgye4mQ7yfAA3FS1ZUeZMcXGJMfqT+wqtjtgQcwvHmIwgvqDZ57O6ipx+itV
	09Ubenrc9Gf3bGSgObTOTLgqZlDJQmiDxpywqP6WT86fiA1VXKmOxghDPa0ti3wqzKiEXLKEHZU
	Nz2/o4DOfIvaH5LsK3EHwqKNLcAXLw7Gh9hZQoR0WAN/o++arxQl1Qg8O939H+HcfEAM30Kx0wE
	gxpHoPKB8Fm4MTHNnL+UQf8s5gXct03/3ShbB47m3vZZPpUf3oZNd/7NIAKgV5ILlWRTgLtTV0Y
	Wth1Q4/8btPnvtmUZzWENZudOOsxAIZxjkZfNlGGOZBdDJ8g+BeZR
X-Google-Smtp-Source: AGHT+IF1l4FCRN2WC8+UznV02+AE7WkwSTpaR1igKVCjG0nL2GptpUjVG/DtOcLWj3kdaWRr1N4AKg==
X-Received: by 2002:a05:620a:3728:b0:7d0:9ffd:422f with SMTP id af79cd13be357-7d44398fde2mr1172154385a.54.1751092732776;
        Fri, 27 Jun 2025 23:38:52 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7730acf9sm32823886d6.108.2025.06.27.23.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 23:38:52 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8F04DF40066;
	Sat, 28 Jun 2025 02:38:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 28 Jun 2025 02:38:51 -0400
X-ME-Sender: <xms:-41faG0-kWIJzm5yT21BmJs4d3U1CqEAgeS1P6e-Pe94G0PiRUp49Q>
    <xme:-41faJGeX9DQfK7tNTUlYrmE_Arz_Rn4VyEXJf6AqtnttmXu-4UI8Ey0IOHP7w27f
    lsxuQ5-Y0Zbr9aJVA>
X-ME-Received: <xmr:-41faO4hOYTRCmaVsbe1Wjiux84pMpHbxVu4N-3Akf2oy4gTiCmklrqfaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurght
    ihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhg
    rgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuoh
    drnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtgho
    mhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-41faH2yGpGQN7L07QCk5ppI52ZB9eHWCexYbh0k4zDA1x37RPQ2sA>
    <xmx:-41faJEROvLyfcQ00eX_msvJvnkOkQr6ZsgF1HTZq1uJGEMGy5QllQ>
    <xmx:-41faA9dFL_EmRz4K7lMzknzspf1yHAtIAfLAyAGsJ5vwnvuOIf1ug>
    <xmx:-41faOmquOV7ekifBdniIscEd5YA_-g4JlFGURvmvVymqrATmgy_Dw>
    <xmx:-41faBHoql482q28AqBkAs8TQO91XF1OClzS2THeugUwXK-z_RpiLKTT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Jun 2025 02:38:51 -0400 (EDT)
Date: Fri, 27 Jun 2025 23:38:50 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/5] rust: devres: implement register_release()
Message-ID: <aF-N-luMxFTurl91@Mac.home>
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-6-dakr@kernel.org>
 <aF2vgthQlNA3BsCD@tardis.local>
 <aF2yA9TbeIrTg-XG@cassiopeiae>
 <DAWULS8SIOXS.1O4PLL2WCLX74@kernel.org>
 <aF8V8hqUzjdZMZNe@tardis.local>
 <DAXXVXNTRLYH.1B8O2LKBF4EW1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAXXVXNTRLYH.1B8O2LKBF4EW1@kernel.org>

On Sat, Jun 28, 2025 at 08:06:52AM +0200, Benno Lossin wrote:
> On Sat Jun 28, 2025 at 12:06 AM CEST, Boqun Feng wrote:
> > On Fri, Jun 27, 2025 at 01:19:53AM +0200, Benno Lossin wrote:
> >> On Thu Jun 26, 2025 at 10:48 PM CEST, Danilo Krummrich wrote:
> >> > On Thu, Jun 26, 2025 at 01:37:22PM -0700, Boqun Feng wrote:
> >> >> On Thu, Jun 26, 2025 at 10:00:43PM +0200, Danilo Krummrich wrote:
> >> >> > +/// [`Devres`]-releaseable resource.
> >> >> > +///
> >> >> > +/// Register an object implementing this trait with [`register_release`]. Its `release`
> >> >> > +/// function will be called once the device is being unbound.
> >> >> > +pub trait Release {
> >> >> > +    /// The [`ForeignOwnable`] pointer type consumed by [`register_release`].
> >> >> > +    type Ptr: ForeignOwnable;
> >> >> > +
> >> >> > +    /// Called once the [`Device`] given to [`register_release`] is unbound.
> >> >> > +    fn release(this: Self::Ptr);
> >> >> > +}
> >> >> > +
> >> >> 
> >> >> I would like to point out the limitation of this design, say you have a
> >> >> `Foo` that can ipml `Release`, with this, I think you could only support
> >> >> either `Arc<Foo>` or `KBox<Foo>`. You cannot support both as the input
> >> >> for `register_release()`. Maybe we want:
> >> >> 
> >> >>     pub trait Release<Ptr: ForeignOwnable> {
> >> >>         fn release(this: Ptr);
> >> >>     }
> >> >
> >> > Good catch! I think this wasn't possible without ForeignOwnable::Target.
> >> 
> >> Hmm do we really need that? Normally you either store a type in a shared
> >
> > I think it might be quite common, for example, `Foo` may be a general
> > watchdog for a subsystem, for one driver, there might be multiple
> > devices that could feed the dog, for another driver, there might be only
> > one. For the first case we need Arc<Watchdog> or the second we can do
> > Box<Watchdog>.
> 
> I guess then the original `&self` design is better? Not sure...
> 

This is what you said in v3:

"""
and then `register_release` is:

    pub fn register_release<T: Release>(dev: &Device<Bound>, data: T::Ptr) -> Result

This way, one can store a `Box<T>` and get access to the `T` at the end.
Or if they store the value in an `Arc<T>`, they have the option to clone
it and give it to somewhere else.
"""

I think that's the reason why we think the current version (the
associate type design) is better than `&self`?

The generic type design (i.e. Release<P: ForeignOwnable>) just further
allows this "different behaviors between Box and Arc" for the same type
T. I think it's a natural extension of the current design and provides
some better flexibility.

> > What's the downside?
> 
> You'll need to implement `Release` twice:
> 

Only if you need to support both for `Foo`, right? You can impl only one
if you only need one.

Also you can do:

    impl<P: ForeignOwnable<Target=Foo> + Deref<Target=Foo>> Release<P> for Foo {
        fn release(this: P) {
	    this.deref().do_sth();
	}
    }

if you want Box and Arc case share the similar behavior, right?

>     impl Release<Box<Self>> for Foo {
>         fn release(this: Box<Self>) {
>             /* ... */
>         }
>     }
> 
>     impl Release<Arc<Self>> for Foo {
>         fn release(this: Arc<Self>) {
>             /* ... */
>         }
>     }
> 
> This also means that you can have different behavior for `Box` and
> `Arc`...

That's the point, as one of the benefits you mentioned above for the
associate type design, just extending it to the same type.

Regards,
Boqun

> 
> ---
> Cheers,
> Benno

