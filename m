Return-Path: <linux-pci+bounces-24682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43B1A70538
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 16:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B7F3A823F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF4B19F487;
	Tue, 25 Mar 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ISiwgb3d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454E618C903;
	Tue, 25 Mar 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916836; cv=none; b=NHccXu96N0CPl++JTdndUWTR0YLjxe7XgQu6ejG73s9BMPAkmqVhFw6PUYJmqeXwd+iLTdyn17tlZ6yXG1aGNziWXfx2q1w8qMxrAn8z3mhmQVTnCo3tgow9QzMdfSUfTVYLX5WMJrq9opZAPKyn4wLUyJgmU0KZc6foL1WI44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916836; c=relaxed/simple;
	bh=NXENBimpOC5uHN+lh1DBMOj1AqfWo8oTaujcGaqeYX0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cy3H/49H8RQJAoAjri0kbUUu61vjCHjaNXq3fKMHO2vzZr/aNwpU9O0tkYmmne9lQ1M//7zz4QTAdtLN4LPIuFxyie20S9NP3o/pVtouWsUFOsOKshIdsrCpeLJOyDTZ8uAevGOWPloMnVfMri+558QcOtUBAVrO5cDjSr2hDEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ISiwgb3d; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742916833; x=1743176033;
	bh=ArxhSHha9/Qen+fEGX8KXzYMZVlNdNjiofaeqo+ocNc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ISiwgb3dN7ivBGn7nO/A2OWlnhdY09jCcWA/b4wE6o4d/sbcYc3R+0up4nGe3q1/3
	 VhvRSQ+1cnPhWkOqdbexwdMVcO8A1gi6kMRvn7Uwd7bVT+sRnTbcHBMTxIAYxkDcdL
	 5bMGYocJQw7kHwd4EBeMwNhYWVV6+QrcBs9qJkLPCdctXK98aXZNAL82EMcXN5b+t9
	 ONuM5Cvl97DtnOEyAjiZDBBh3T3Pd6fagLxKj4+AAe8Hk2plvNT21y4PIINN04gy+A
	 1RsB68RcqOldfq+ycAwEBB6YCupgqaUvbHRFxoA35XTTZ3A/p7t4SHJ+UZ0G5GxpGb
	 5pjISaWiRHH9w==
Date: Tue, 25 Mar 2025 15:33:48 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
Message-ID: <D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me>
In-Reply-To: <CAJ-ks9kuG8SyybioKQ0+bYwjnCQFMhip+4A1WnMhsdgnNZGiZQ@mail.gmail.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com> <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me> <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com> <D8OTXLDQCOKI.34R1U5R0JSB8H@proton.me> <CAJ-ks9nc0ptzfh+tHj47aTCMqoaKB0SnGpZOLQ06upt7x8EBMQ@mail.gmail.com> <D8PAQXHJDVQE.36QKQGBVVL4QU@proton.me> <CAJ-ks9kuG8SyybioKQ0+bYwjnCQFMhip+4A1WnMhsdgnNZGiZQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: cf56dbe605b88fc3577b2bf3f99caf40cad5d047
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 25, 2025 at 2:34 PM CET, Tamir Duberstein wrote:
> On Tue, Mar 25, 2025 at 7:05=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>> On Mon Mar 24, 2025 at 10:59 PM CET, Tamir Duberstein wrote:
>> > On Mon, Mar 24, 2025 at 5:55=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>> >> On Mon Mar 24, 2025 at 9:55 PM CET, Tamir Duberstein wrote:
>> >> > On Mon, Mar 24, 2025 at 4:16=E2=80=AFPM Benno Lossin <benno.lossin@=
proton.me> wrote:
>> >> >> I'll leave it up to you what you want to do with this: add it to t=
his
>> >> >> series, make a new one, or let someone else handle it. If you don'=
t want
>> >> >> to handle it, let me know, then I'll create a good-first-issue :)
>> >> >
>> >> > I'll add a patch for `cast_lossless` -- the rest should probably go
>> >> > into an issue.
>> >>
>> >> Do you mind filing the issue? Then you can decide yourself what you w=
ant
>> >> to do yourself vs what you want to leave for others. Feel free to cop=
y
>> >> from my mail summary.
>> >
>> > Well, I don't really know what's left to do. We're pretty close at
>> > this point to having enabled everything but the nukes. Then there's
>> > the strict provenance thing, which I suppose we can write down.
>>
>> Yes, but there are also these from my original mail:
>> * `shared_ref as *const _` (for example in rust/kernel/uaccess.rs:247,
>>   rust/kernel/str.rs:32 and rust/kernel/fs/file.rs:367), these we can
>>   replace with `let ptr: *const ... =3D shared_ref;`. Don't know if ther=
e
>>   is a clippy lint for this.
>
> I don't think we should go fixing things for which we don't have a
> clippy lint. That way lies madness, particularly as patches begin to
> be carried by other trees.

There already exists a lint for that: `clippy::ref_as_ptr` (almost
created an issue asking for one :)

Here is another lint that we probably want to enable (after the `&raw
{const,mut}` series lands): `clippy::borrow_as_ptr`.

---
Cheers,
Benno


