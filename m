Return-Path: <linux-pci+bounces-24799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52584A723B1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 23:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B72D189CBC6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 22:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165EF25A2CF;
	Wed, 26 Mar 2025 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NfmhZFGn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DA716C69F;
	Wed, 26 Mar 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743027355; cv=none; b=OgiFYQs2SasDJByFPT+s3JAOvXpnP3xCWhAdLNZ3XOxhxnpoPhf3URxIsNRp0YSiKTD5yAq3uCePjkQOkHn8UystQA7MEWep5hWrT4zj1BkYMQ2wWdFqdZEURwjY0x5GU/DB8rW5X9d6kddUe1BvA+F/1uCygmSnXmHdHttEUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743027355; c=relaxed/simple;
	bh=to6Tsfx7WaJmCqvucS0jsS/ayq4WMOWhnETk19VRfdE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMju6WGh3tNRhQ0d+wLxGgo0yrSj0C2S+oitt4+2vCdMFjh01iBBGzbpETTqWlhu6ScW2l5803psizo95gmQGYBx4rjbU1GQWK2FHF38OTOcbPlBcpyMW6D7KcX1dWMGw8q2smGVWmit0v+5ToMr/ZqTe3b0dLIEp74W82aPeXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NfmhZFGn; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1743027350; x=1743286550;
	bh=9oUH4nV7QWQ54U20IxphlyDvPRuA4nnGHt2VBGcRbbw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=NfmhZFGnZRbbdqlbfPwEKd/ANRL+wlFC9YDrN0Ocytq9tNKX28ozucbnFQZO06h4A
	 6bp4EJwQEGWQs+vJ20ZYU/ylXbKQXav5uZljiSFbf2HJzHtVxY3KH7BZ6KaO4v9GG6
	 ODNyZAT49Y1XeMXKHT7KvLLy2J9CkWVhB3HsD+ZUrWuZR0PUeh9vsHjiUNkKhcA8e2
	 G+aKEPyabTNhQmVRkg9pLTTTgls9QAfZ2qsAMu+RlEDatw+wGMe4oevr5frzJgWhwI
	 RMzWu7EteG8oYB3njlaRNRwAPsZ6DT+m5ybUsoU2gdPSloc2RgOkZSRju2yiIvP6qL
	 HGLYeu1DORYJQ==
Date: Wed, 26 Mar 2025 22:15:43 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 7/7] rust: enable `clippy::ref_as_ptr` lint
Message-ID: <D8QJMH5UR6VG.2OT5MXJJQU5QT@proton.me>
In-Reply-To: <CAJ-ks9mA5QDeZ3EvOD3THayFt4TtDysgm0jp2aiSF2mQCrhWiQ@mail.gmail.com>
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com> <D8Q4MSXXZ7OI.1NC226MO02VSN@proton.me> <CAJ-ks9nHKpQPuSBypXTSATYhbAFkQTJzUq8jN0nu4t=Kw+0xxg@mail.gmail.com> <D8QCK3CQES3Y.3LTZ4MVO5B3KT@proton.me> <CAJ-ks9nKT2PUDm6=b4AB1QUWwwvcqPn7Vz60=c0B+uFMZrqPew@mail.gmail.com> <D8QDOBUM6NF0.CGJY7ZA5KD9S@proton.me> <CAJ-ks9ntTxBM=c5nUZWGv3MoRt-LveBchn-c1Xy-DGap7fLVRA@mail.gmail.com> <D8QI804Q3DAS.2BV4WSL81H52Z@proton.me> <CAJ-ks9mA5QDeZ3EvOD3THayFt4TtDysgm0jp2aiSF2mQCrhWiQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9b3e0eaf59f5bd85b3b1266b193b59b5e33ec08b
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 26, 2025 at 11:09 PM CET, Tamir Duberstein wrote:
> On Wed, Mar 26, 2025 at 5:09=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>> On Wed Mar 26, 2025 at 8:06 PM CET, Tamir Duberstein wrote:
>> > On Wed, Mar 26, 2025 at 1:36=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>> >> On Wed Mar 26, 2025 at 5:57 PM CET, Tamir Duberstein wrote:
>> >> >
>> >> > Yeah, we should do this - but again: not relevant in this discussio=
n.
>> >>
>> >> I think it's pretty relevant.
>> >
>> > It's not relevant because we're no longer talking about transmuting
>> > pointer to pointer. The two options are:
>> > 1. transmute reference to reference.
>> > 2. coerce reference to pointer, `as` cast pointer to pointer (triggers
>> > `ptr_as_ptr`), reborrow pointer to reference.
>> >
>> > If anyone can help me understand why (2) is better than (1), I'd
>> > certainly appreciate it.
>>
>> I am very confident that (2) is correct. With (1) I'm not sure (see
>> above), so that's why I mentioned it.
>
> Can you help me understand why you're confident about (2) but not (1)?

My explanation from above explains why I'm not confident about (1):

    For ptr-to-int transmutes, I know that they will probably remove
    provenance, hence I am a bit cautious about using them for ptr-to-ptr o=
r
    ref-to-ref.

The reason I'm confident about (2) is that that is the canonical way to
cast the type of a reference pointing to an `!Sized` value.

---
Cheers,
Benno


