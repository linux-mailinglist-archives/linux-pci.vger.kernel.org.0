Return-Path: <linux-pci+bounces-31913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3944CB015B9
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 10:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4655B1C84F9E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D2A202F79;
	Fri, 11 Jul 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTTboOzr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7E1FE470;
	Fri, 11 Jul 2025 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221498; cv=none; b=lx2+sHbGrSxWFax204Di1PWdTd4Et3G2LPTkX+YSbOZYmSbi+GNtyStTTaz2WUdjcwwqeAp5FAbNsxKQkCHVj/skU0Q+FYf6MdyT3irRYioP5c8FbDfa3FGyFzSxRnFj8yYtEPf9Zz9M3bSS3Vg9GS863IFtw3dRjbq7BGrTCxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221498; c=relaxed/simple;
	bh=NYMZKphf96SaACDAe3JOHuWxhHs54wMKot7UA1Cf+W4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=sjEIvLNMQ51BfbXeH1ZmIX+wDNZW6MjLS+aYd3tUJuH+NvPyQf3ynUqSXw5uTOEDFv1oF2bCFeLRyKhissJ/agVn9BjvAz7G5Tl1xvrOinrOADPqzZ2WeQVEFEcg1ASaQk1f8+K7xR7FQ5kFVUOmttk4p3jwkfe2Z4vBWWrp/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTTboOzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E026CC4CEED;
	Fri, 11 Jul 2025 08:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752221498;
	bh=NYMZKphf96SaACDAe3JOHuWxhHs54wMKot7UA1Cf+W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTTboOzrT3xIHW5CFqTcS3I3Y8Xc9QzbyfTOEl4EvtSCpkHjNr9HlgNA892bGsKaP
	 n3t+tF++oeVpoTnNrOgzJuB9MZNF8EfMKQbF2bIVqUJcuQ1vDqYOYMAQh/PgPzQNG4
	 WT17cS1K8u718+Lq83ypLsod06qp2yflWGZxwgJMF77NIa/RSnBss44o+mYvOK7mTA
	 r3ykAd4trXpDRbsJccxrWBtTi3Ftwds2MMzZ50WGqfP0lfxlmQ5X3pDSsku6XVK11S
	 vJOPe0C/RmNAvTTHONMvOOkCV1Z5LBFz3O97DMmoc92LKpmqHmuRtSMIWjI9ROBrH8
	 up0C6d1SYFXFw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 10:11:33 +0200
Message-Id: <DB92OHEUBB06.2VTHW9KQVV52X@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
X-Mailer: aerc 0.20.1
References: <20250710022415.923972-1-apopple@nvidia.com>
 <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
 <cgh5cj42vkxc66f2utpa3eznvqaqtdo3gszahfhempujj3kxdc@zaor2sx4cosp>
In-Reply-To: <cgh5cj42vkxc66f2utpa3eznvqaqtdo3gszahfhempujj3kxdc@zaor2sx4cosp>

On Fri Jul 11, 2025 at 1:22 AM CEST, Alistair Popple wrote:
> On Thu, Jul 10, 2025 at 10:01:05AM +0200, Benno Lossin wrote:
>> On Thu Jul 10, 2025 at 4:24 AM CEST, Alistair Popple wrote:
>> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> > index 8435f8132e38..5c35a66a5251 100644
>> > --- a/rust/kernel/pci.rs
>> > +++ b/rust/kernel/pci.rs
>> > @@ -371,14 +371,18 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
>> > =20
>> >  impl Device {
>> >      /// Returns the PCI vendor ID.
>> > +    #[inline]
>> >      pub fn vendor_id(&self) -> u16 {
>> > -        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_=
dev`.
>> > +        // SAFETY: by its type invariant `self.as_raw` is always a va=
lid pointer to a
>>=20
>> s/by its type invariant/by the type invariants of `Self`,/
>> s/always//
>>=20
>> Also, which invariant does this refer to? The only one that I can see
>> is:
>>=20
>>     /// A [`Device`] instance represents a valid `struct device` created=
 by the C portion of the kernel.
>
> Actually isn't that wrong? Shouldn't that read for "a valid `struct pci_d=
ev`"?

Yeah it should probably be changed, I'm not sure what exactly is
required here, but this already would be an improvement:

    /// `self.0` is a valid `struct pci_dev`.

>> And this doesn't say anything about the validity of `self.as_raw()`...
>
> Isn't it up to whatever created this pci::Device to ensure the underlying=
 struct
> pci_dev remains valid for at least the lifetime of `Self`?

Well yes and no. It is up to the creator of this specific `pci::Device`
to ensure that it is valid, but that is true for all creators of
`pci::Device`. In other words this property doesn't change while the
`pci::Device` is alive so we call it an "invariant".

When creating a `pci::Device`, you have to ensure all invariants are met
and then anyone using it can rely on them being true.

Now in this particular instance the `as_raw` function is just calling
`self.0.get()`. I'm not sure that's worth it, since it isn't even
shorter and it makes the safety docs a bit worse. So my suggestion would
be to remove it.

> Sorry I'm quite new to Rust (and especially Rust in the kernel), so
> not sure what the best way to express that in a SAFETY style comment
> would be. Are you saying the list of invariants for pci::Device also
> needs expanding?

No worries, safety documentation is pretty hard :)

---
Cheers,
Benno

>
> Thanks.
>
>> > +        // `struct pci_dev`.
>> >          unsafe { (*self.as_raw()).vendor }
>> >      }
>> > =20
>> >      /// Returns the PCI device ID.
>> > +    #[inline]
>> >      pub fn device_id(&self) -> u16 {
>> > -        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_=
dev`.
>> > +        // SAFETY: by its type invariant `self.as_raw` is always a va=
lid pointer to a
>> > +        // `struct pci_dev`.
>>=20
>> Ditto here.
>>=20
>> ---
>> Cheers,
>> Benno
>>=20
>> >          unsafe { (*self.as_raw()).device }
>> >      }
>> > =20
>>=20


