Return-Path: <linux-pci+bounces-30985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA31CAEC545
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 08:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3913B23EC
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 06:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7E321A434;
	Sat, 28 Jun 2025 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fExvWjv8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDBA199E9D;
	Sat, 28 Jun 2025 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751090817; cv=none; b=e2+wV7r/RxzTnnDsz0ckZNpbv/ShX2GYw3r0K+qeQA8+Da8m6qwbFkxTLdOYd4Mg4kHdO6+S/Tik2Cmr8VMgZTyGRjpuc5QkdlildXC1EHCYPJhVVbFMqacNmbwqp9RUQzfFJrdD3YA0niCZ1h94JCY8juWUEcMr8cFEQi4qy1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751090817; c=relaxed/simple;
	bh=Buards44X/HUpjs0dh2wtqcXeyk5PePTU+S46Uqp6NU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sZC3GG8PalZM32KCAfSMu81R/BfjuNA02QujncypatLAXNtDZokW7HHS/yeAif2dcLbwdWaP7r1cKgnQn+i91vdBtgfjpjF0p+oq249RkkZbwR+TSxaIedJCj+R/7IUA1YIoOyzo4lzorY2o0briYnmx346WyT1d/pPlfpWabTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fExvWjv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBF2C4CEEA;
	Sat, 28 Jun 2025 06:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751090817;
	bh=Buards44X/HUpjs0dh2wtqcXeyk5PePTU+S46Uqp6NU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fExvWjv831PoWwhZph592qqIEKqleCNVIB01Cb3QEQ/wriEWbq/0iy4jPI4cCjAKg
	 t86vbh0nOtl5r5TgIcrqmt634s27/ATTiu010qRSaku1f8BMsRR9vSaCtN5OgNb6X4
	 Ed4PizLnpXuonzO4J+uz7ZBvHpYrSmR8AnVxUP1931XUY9cBxQyh3ByBmRGiHfcr1q
	 fyslPgMIamGpdWAVVEfsw16e3RKq1AR6NmRBD4p97Z4yM0QXIrzzCPQTUNEZ9R+pS2
	 EeLYkwEQ1ugUP+IH9TT09Oq/Qz3zyiPuM5OJtF+t72qzaF9tCQlws0WgyCNmclV+Ep
	 /m8y8eYD4h00A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Jun 2025 08:06:52 +0200
Message-Id: <DAXXVXNTRLYH.1B8O2LKBF4EW1@kernel.org>
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
 <aF8V8hqUzjdZMZNe@tardis.local>
In-Reply-To: <aF8V8hqUzjdZMZNe@tardis.local>

On Sat Jun 28, 2025 at 12:06 AM CEST, Boqun Feng wrote:
> On Fri, Jun 27, 2025 at 01:19:53AM +0200, Benno Lossin wrote:
>> On Thu Jun 26, 2025 at 10:48 PM CEST, Danilo Krummrich wrote:
>> > On Thu, Jun 26, 2025 at 01:37:22PM -0700, Boqun Feng wrote:
>> >> On Thu, Jun 26, 2025 at 10:00:43PM +0200, Danilo Krummrich wrote:
>> >> > +/// [`Devres`]-releaseable resource.
>> >> > +///
>> >> > +/// Register an object implementing this trait with [`register_rel=
ease`]. Its `release`
>> >> > +/// function will be called once the device is being unbound.
>> >> > +pub trait Release {
>> >> > +    /// The [`ForeignOwnable`] pointer type consumed by [`register=
_release`].
>> >> > +    type Ptr: ForeignOwnable;
>> >> > +
>> >> > +    /// Called once the [`Device`] given to [`register_release`] i=
s unbound.
>> >> > +    fn release(this: Self::Ptr);
>> >> > +}
>> >> > +
>> >>=20
>> >> I would like to point out the limitation of this design, say you have=
 a
>> >> `Foo` that can ipml `Release`, with this, I think you could only supp=
ort
>> >> either `Arc<Foo>` or `KBox<Foo>`. You cannot support both as the inpu=
t
>> >> for `register_release()`. Maybe we want:
>> >>=20
>> >>     pub trait Release<Ptr: ForeignOwnable> {
>> >>         fn release(this: Ptr);
>> >>     }
>> >
>> > Good catch! I think this wasn't possible without ForeignOwnable::Targe=
t.
>>=20
>> Hmm do we really need that? Normally you either store a type in a shared
>
> I think it might be quite common, for example, `Foo` may be a general
> watchdog for a subsystem, for one driver, there might be multiple
> devices that could feed the dog, for another driver, there might be only
> one. For the first case we need Arc<Watchdog> or the second we can do
> Box<Watchdog>.

I guess then the original `&self` design is better? Not sure...

> What's the downside?

You'll need to implement `Release` twice:

    impl Release<Box<Self>> for Foo {
        fn release(this: Box<Self>) {
            /* ... */
        }
    }

    impl Release<Arc<Self>> for Foo {
        fn release(this: Arc<Self>) {
            /* ... */
        }
    }

This also means that you can have different behavior for `Box` and
`Arc`...

---
Cheers,
Benno

