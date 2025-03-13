Return-Path: <linux-pci+bounces-23602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C27A5F199
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75844177A23
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA2A2676C4;
	Thu, 13 Mar 2025 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LLa0YVkw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C854265CCF
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863163; cv=none; b=CxzAP3330O3s5gUtOrc6m3NO9U2JdTXAWQC4gI+pQFP0y59tZMQUG5XKmwk0WXqFCQw1ijvF4mL++HyAd50vLkOxVnKjVWXNkvv9qd/TT0dqMN5nuOw2F/ZXVcAwuGUQiIiB6FJLvNgXhsGQLfKCuJkW3zd5aVFXqUpwj72evj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863163; c=relaxed/simple;
	bh=SMlqtJQIiBvNiW3snRb9OrOG9IbLmh4UpJ3FD32ol0M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuoZl7PrcVAfdFT2qqnvCNYa+0UrapRqDnxh4EdU8v51YCjxeYdBIJ3rdmgvHnXvqprcYCJA5+nrXTUpUG0t5umt8fx9XJVCFpg0ddD3OteRUcp+brUSPLzT+P/dGg16Yt7Ssny8rX0X95grwzl8OP9Ax3mxya/dBxE+BOGdMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LLa0YVkw; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741863159; x=1742122359;
	bh=nrPlHJ4v3ZNQyWRzzyvVL0yvd3474f+tE2cEaFpBUMc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=LLa0YVkw1QPQBaWerRKSFuw44p4w9BNebJawbPTyYmk+m/eqTTp6mH6ZsEkoCWAKM
	 p7L1HSsnuH426EK4CUDpNHiP8c7E8CSy6cbF3/EurzqzMTY1wsWyOphAEY0L/YB6To
	 HzbibgfXQ5Xay1oCZJokm6NAff2RXO2MvI0sCUr9BqwsTLEsjRGKlkzrtWUrevx9Fx
	 FVgJL2CA8qv/prTcGZVrfoAOukHO9BzW5EOimneUZb1hmKjFdvJYpRMZzCyakEq1Dc
	 D7KHL+JIvuarPqIkC6aF0BTjsxUhKCLihTqhy4ESlFgAYDXbezegec8bzy5u0mzd1k
	 Z2HLf20vXOFnw==
Date: Thu, 13 Mar 2025 10:52:34 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: device: implement device context marker
Message-ID: <D8F2YBFHCTFL.3TH1E0TB11EHU@proton.me>
In-Reply-To: <Z9K2PJEoymuhamT-@pollux>
References: <20250313021550.133041-1-dakr@kernel.org> <20250313021550.133041-3-dakr@kernel.org> <D8F2GQ4WYT7Z.172Z7R7V8BIGR@proton.me> <Z9K2PJEoymuhamT-@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b297e6af7bf959966f08e2f649a842decb9c2b32
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 11:41 AM CET, Danilo Krummrich wrote:
> On Thu, Mar 13, 2025 at 10:29:35AM +0000, Benno Lossin wrote:
>> On Thu Mar 13, 2025 at 3:13 AM CET, Danilo Krummrich wrote:
>> > +/// Marker trait for the context of a bus specific device.
>> > +///
>> > +/// Some functions of a bus specific device should only be called fro=
m a certain context, i.e. bus
>> > +/// callbacks, such as `probe()`.
>> > +///
>> > +/// This is the marker trait for structures representing the context =
of a bus specific device.
>> > +pub trait DeviceContext {}
>>=20
>> I would make this trait sealed. ie:
>>=20
>>     pub trait DeviceContext: private::Sealed {}
>>    =20
>>     mod private {
>>         pub trait Sealed {}
>>=20
>>         impl Sealed for super::Core {}
>>         impl Sealed for super::Normal {}
>>     }
>>=20
>> Since currently a user can create a custom context (it will be useless,
>> but then I think it still is better to give them a compile error).
>
> That is intentional, some busses have bus specific callbacks, hence we ma=
y want
> a bus specific context at some point.

Then it's even better we went with the generics vs using mutable
references :)

> However, we can always change visibility as needed, so I'm fine making it=
 sealed
> for now.

Couldn't you just add them here? Then sealing wouldn't be a problem.

---
Cheers,
Benno


