Return-Path: <linux-pci+bounces-31571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 878AEAFA204
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 23:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF177B17D2
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983B32080C1;
	Sat,  5 Jul 2025 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRp+9aKX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6930717CA1B;
	Sat,  5 Jul 2025 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751751492; cv=none; b=R+IjKP6X7ZZ26rO0hdVGeAPANLms+UJuI5FTWDs/zgakiE6X5pod6MeOhGQJc2JwhPI0L7+kNbag/6sSFzenvGMHj0Dtjwo4vBnuPvhE1LCshV/axaJ8a352O079vPam+cuI2m5wXA54mgLZa8dKenMR2oi48UAXy4F2QuDZlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751751492; c=relaxed/simple;
	bh=ZllOyk54xQwbxPRWURsJ81GR0mKn/E3sFfg4xPWg/AU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ja72bki8eGa0OFYn49kqMOIJUwfJ7vjtMxVKymV5uLASaMBCGg9r1AFTjovpRVcv8yKaS20ZvrMqJjtDd6fljyvMS88tcBm1R69pe6Jw4r+vbUkFUaCF+knw0zDjVC93a5wzoTUM04FKg+GQJaff/lctQNLYkmJVKQTPK+ljn80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRp+9aKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13C0C4CEE7;
	Sat,  5 Jul 2025 21:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751751491;
	bh=ZllOyk54xQwbxPRWURsJ81GR0mKn/E3sFfg4xPWg/AU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=QRp+9aKX8Y3fYFQN7dSJ5gJleTsdU9k4tS2WEJsxHB/SYj7uKVOrJOgWcbZvWknQ0
	 809zLPFbO21scBaiaUcsQ17zKKbhsvs/rycCJykKMfmS7QDqnGXMS1RkDL0KDp1jrp
	 WJljGA1jDILPqOdFmBCPaIlPnbXAx7A847VLp9jbLAfXOu8DuqDiPsG6SZtk9f1EpG
	 SxH85oz9Ciiit6d1nSbjH8YwyJXc7VCuvtCm8gw7XX8dpahHHQoysOryGNf23z7k7u
	 Bp4xlOlRCeX0NU4HdWol1tHDQIjgig1ppi6wo9y0w5DUyQW64Yp5CFA+O/pm56Tub+
	 p3WLcnVSGbncg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Jul 2025 23:38:04 +0200
Message-Id: <DB4G2QJ8LA5W.384ECLNXUM0CY@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/8] rust: device: add drvdata accessors
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250621195118.124245-1-dakr@kernel.org>
 <20250621195118.124245-3-dakr@kernel.org>
 <DB42TQY2E57U.1PKC16LW38MH9@kernel.org> <aGk_YBCGqrO-A6bG@cassiopeiae>
In-Reply-To: <aGk_YBCGqrO-A6bG@cassiopeiae>

On Sat Jul 5, 2025 at 5:06 PM CEST, Danilo Krummrich wrote:
> On Sat, Jul 05, 2025 at 01:15:06PM +0200, Benno Lossin wrote:
>> On Sat Jun 21, 2025 at 9:43 PM CEST, Danilo Krummrich wrote:
>> > +impl Device<Internal> {
>> > +    /// Store a pointer to the bound driver's private data.
>> > +    pub fn set_drvdata(&self, data: impl ForeignOwnable) {
>> > +        // SAFETY: By the type invariants, `self.as_raw()` is a valid=
 pointer to a `struct device`.
>> > +        unsafe { bindings::dev_set_drvdata(self.as_raw(), data.into_f=
oreign().cast()) }
>> > +    }
>> > +
>> > +    /// Take ownership of the private data stored in this [`Device`].
>> > +    ///
>> > +    /// # Safety
>> > +    ///
>> > +    /// - Must only be called once after a preceding call to [`Device=
::set_drvdata`].
>> > +    /// - The type `T` must match the type of the `ForeignOwnable` pr=
eviously stored by
>> > +    ///   [`Device::set_drvdata`].
>> > +    pub unsafe fn drvdata_obtain<T: ForeignOwnable>(&self) -> T {
>> > +        // SAFETY: By the type invariants, `self.as_raw()` is a valid=
 pointer to a `struct device`.
>> > +        let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw())=
 };
>> > +
>> > +        // SAFETY: By the safety requirements of this function, `ptr`=
 comes from a previous call to
>> > +        // `into_foreign()`.
>>=20
>> Well, you're also relying on `dev_get_drvdata` to return the same
>> pointer that was given to `dev_set_drvdata`.
>>=20
>> Otherwise the safety docs look fine.
>
> Great! What do you think about:
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 146eba147d2f..b01cb8e8dab3 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -80,8 +80,11 @@ pub unsafe fn drvdata_obtain<T: ForeignOwnable>(&self)=
 -> T {
>          // SAFETY: By the type invariants, `self.as_raw()` is a valid po=
inter to a `struct device`.
>          let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw()) };
>
> -        // SAFETY: By the safety requirements of this function, `ptr` co=
mes from a previous call to
> -        // `into_foreign()`.
> +        // SAFETY:
> +        // - By the safety requirements of this function, `ptr` comes fr=
om a previous call to
> +        //   `into_foreign()`.
> +        // - `dev_get_drvdata()` guarantees to return the same pointer g=
iven to `dev_set_drvdata()`
> +        //   in `into_foreign()`.

Looks good, though I haven't done a full review, but you can have my:

Acked-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

>          unsafe { T::from_foreign(ptr.cast()) }
>      }


