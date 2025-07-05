Return-Path: <linux-pci+bounces-31557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3DFAF9E96
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 09:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5369C7AE653
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 07:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E44315C;
	Sat,  5 Jul 2025 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="h36uczKm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB4D18C31;
	Sat,  5 Jul 2025 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751699148; cv=none; b=IaxFght6qVM7FWPOoa8azUzVaqfG9u6POUv+j0EiXtleZzds7Inxi2t+fkwBcD4+8E39TXJEISwfvLutyRK9jaCXm1xgnHcFpVZehGhBaTI6uJRFBRkfHls6JPkU+F3Zl1NYkaJ2Ca7mK63yPxhZwdxmLnn8HgoA/uw5MzZakFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751699148; c=relaxed/simple;
	bh=c0yPK2qi3aMbOXUEzuaqa0eXAMlIXuWfoYKTwJWiU/0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqLCwFUDHPyohsOvNnf3UdeVEAG5shwzwvEElYJmvDdeGkF3kNKfSBxBif4u6OKWlIVjIYjk+w0O11Z3CBvTNVIykm72UzyT8Rn4zE5Bj5YiTuCi7cNGUMH1uXBTRhQ27DGzwN9F7NdjU9a1vRDt/Lpm8PnaRtsSATvoyGGpchk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=h36uczKm; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1751699138; x=1751958338;
	bh=pDDVT0J53yssnmK+K39Xfz1t/T50bxi9dCd7/B+xsXU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=h36uczKmp2RgiYJHPsvxYgDX7LPqm+yyxoe6ZFFALZoty295QpC4sbxS+Tyc8Vd3B
	 MRmEil8QCpaGJS9gpcDV1Wz678EkWH+flZmjGUR3RontFtJejzc49XIkFmkhx5PhO1
	 tX8BY/i+qItFUs4n87VgCQIDssIcTJgeYlMoIojGaeLwkRlAd1+39W9qfZEqnAMX8j
	 gvwQOiVfPoMHmTmLjz2Tv0ubPbL/TJCbf4HNAmMg3+SpdLLiSDQ6BA8AiSifshM85K
	 T5hthcqnEqSbS07Ar4jMBmx1qQ04FOy6AW2RKRG/+oOxQk3OP4E7VbqoWnxlQrHVg4
	 y3xKhEjboxJJA==
Date: Sat, 05 Jul 2025 07:05:33 +0000
To: Wren Turkal <wt@penguintechs.org>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Subject: Re: [PATCH] rust: pci: fix documentation related to Device instances
Message-ID: <87ldp3kthk.fsf@protonmail.com>
In-Reply-To: <954c0915-25d9-4bc3-ac82-452650902a3c@penguintechs.org>
References: <20250629055729.94204-2-sergeantsagara@protonmail.com> <954c0915-25d9-4bc3-ac82-452650902a3c@penguintechs.org>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: 15e123e953ee8fb71684dc4554f9e42dfb2b359f
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 29 Jun, 2025 00:14:18 -0700 "Wren Turkal" <wt@penguintechs.org> wro=
te:
> On 6/28/25 10:57 PM, Rahul Rameshbabu wrote:
>> Device instances in the pci crate represent a valid struct pci_dev, not =
a struct
>> device.
>>
>> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
>> ---
>>
>> Notes:
>>      Notes:
>>
>>      I noticed this while working on my HID abstraction work and figured=
 it would be
>>      a small fixup I could send afterwards.
>>
>>      Link: https://lore.kernel.org/rust-for-linux/20250629045031.92358-2=
-sergeantsagara@protonmail.com/
>>
>>   rust/kernel/pci.rs | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index 6b94fd7a3ce9..af25a3fe92e5 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -254,7 +254,7 @@ pub trait Driver: Send {
>>   ///
>>   /// # Invariants
>>   ///
>> -/// A [`Device`] instance represents a valid `struct device` created by=
 the C portion of the kernel.
>> +/// A [`Device`] instance represents a valid `struct pci_dev` created b=
y the C portion of the kernel.
>
> Should this not just be a "a valid pci device" and let the type in the
> function definition speak for the type instead of duplicating the type
> name in the  doc comment?
>

My theory is that this comment is explicitly done for folks reading this
code from the C side. Rust tuple structs are not exactly a common
semantic in other programming languages. That said, I am open to
changing the comments if Danillo or others think that would be better as
well. Either way, I appreciate you taking the time to respond.

>>   #[repr(transparent)]
>>   pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
>>       Opaque<bindings::pci_dev>,

--=20
Thanks,

Rahul Rameshbabu


