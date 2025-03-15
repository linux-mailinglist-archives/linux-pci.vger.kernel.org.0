Return-Path: <linux-pci+bounces-23818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C5EA62A5E
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 10:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777AF17D7B7
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 09:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CC91E7C20;
	Sat, 15 Mar 2025 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RjD2trdW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87CA32;
	Sat, 15 Mar 2025 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031881; cv=none; b=VwpQaDHRndRfMfSp248GNZLZdONrQGskFWYt59sVAnU/OibXec/pQyX/YNOw5vmCYvQ5jT2Wkmt+kJ99D/ey6v1OQzg/kgMRIILNwzuHFCl2EAE2fvUi8Xh1NFmBqLxObGEroM4HJy6OvbQ7KQuVuueyQkC/RSEJqUcGmcnog0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031881; c=relaxed/simple;
	bh=9o+XY6imgq6zaQDxE/bPz6kfIxurI0uiJIyhQ04e950=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKbGy9pRWaTJnpTBBGBu9J6nx5m/N7MMEKf1ZY33x4Me+xYemk6KskfaNRPgZsYHeEwbDLD4VKAkjYX6Hi1+4zRq3UxdomIEcLnEG/rXReo4cGUzXXSWgePhDyyUD+e7GArnOhWahCL2nqYrdasf/CfJ1xJlnc2RWIFzuvKsMsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RjD2trdW; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=apypmejo2zdgdad4cw5ld4bjgu.protonmail; t=1742031877; x=1742291077;
	bh=9o+XY6imgq6zaQDxE/bPz6kfIxurI0uiJIyhQ04e950=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=RjD2trdWilavDargEPJh31BaRD1d0iE94K1WTsJ/ad1+eb36FAPT3fUI7TMqp4+vp
	 BRA4qDvo3Xlw2DAHsB34qIikjLUkuGU49IhcV0xUeYfrGe+MIGFT6dyGOlcXorpdI+
	 13NdK8Gh63jNwYmwhfJges7p1LmFjkOzxniQnd7B3GsO+5ig20muHxlw1o4vm2pSyP
	 hncsfKqglFrsdmvUhR9/jlpxZlSWpm3w+aRulnnpDSv1gLMX3icQ5oNoRII6ZsZnwY
	 XOFgkjwdW0YJsEYhHa08PG3v8bxHheqxyMyHsixf+18F5nEKuGXSU12m23q8WB89W4
	 sTQ7jsUBA5SUA==
Date: Sat, 15 Mar 2025 09:44:33 +0000
To: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/6] rust: use strict provenance APIs
Message-ID: <D8GQRANRVU11.SI7SZ8RAXXF@proton.me>
In-Reply-To: <CAJ-ks9=Ec0xLg81GUYJ07uDzwtwhFkoEdxaa3kNtV6xSjZ57MQ@mail.gmail.com>
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com> <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com> <D8G9LZCS7ETL.9UPPQ73CAUQM@proton.me> <CANiq72=JCgdmd+h4_2VguOO9kxdx3OuTqUmpLix3mTLLHLKbZw@mail.gmail.com> <CAJ-ks9=Ec0xLg81GUYJ07uDzwtwhFkoEdxaa3kNtV6xSjZ57MQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3cfde2319760f064666ce8d81b7235df8b240a00
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 14, 2025 at 11:20 PM CET, Tamir Duberstein wrote:
> On Fri, Mar 14, 2025 at 6:00=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> On Fri, Mar 14, 2025 at 9:18=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>> >
>> > I don't know when we'll be bumping the minimum version. IIRC 1.85.0 is
>> > going to be in debian trixie, so eventually we could bump it to that,
>> > but I'm not sure what the time frame will be for that.
>> >
>> > Maybe we can salvage this effort by gating both the lint and the
>> > unstable features on the versions where it works? @Miguel, what's your
>> > opinion?
>> >
>> > We could even make it simple, requiring 1.84 and not bothering with th=
e
>> > older versions.
>>
>> Regarding Debian Trixie: unknown, since my understanding is that it
>> does not have a release date yet, but apparently mid May is the Hard
>> Freeze and then it may take e.g. a month or two to the release.
>>
>> And when it releases, we may want to wait a while before bumping it,
>> depending on how much time has passed since Rust 1.85.0 and depending
>> on whether we managed to get e.g. Ubuntu LTSs to provide a versioned
>> package etc.

Yeah that's what I thought, thanks for confirming.

>> If something simple works, then let's just go for that -- we do not
>> care too much about older versions for linting purposes, since people
>> should be testing with the latest stable too anyway.
>
> It's not going to be simple because `rust_common_flags` is defined
> before the config is read, which means I'll have to sprinkle
> conditional logic in even more places to enable the lints.
>
> The most minimal version of this patch would drop all the build system
> changes and just have conditionally compiled polyfills for the strict
> provenance APIs. Are folks OK with that?

So you'd not enable the lint, but fix all occurrences? I think we should
still have the lint (if it's too cumbersome, then let's only enable it
in the kernel crate).

---
Cheers,
Benno


