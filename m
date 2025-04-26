Return-Path: <linux-pci+bounces-26833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4629CA9DD13
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 22:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFA9167B00
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 20:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3321F416A;
	Sat, 26 Apr 2025 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OvzA7apG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C040D1F3B9E;
	Sat, 26 Apr 2025 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745698735; cv=none; b=As5VhjdHA7BKXCnNxR39Vmsw7oL1EmDrWfPSQu+cyYDOSMDy0d7k/4OuoxfE3G6AFzDpg7mLj9pxctYtmGuQzGJoOFAimO0gBwBsPwZzONsD8kRoRVsEXEX6rUCTii2O4nC+rQSGoFTtQnvcjoMmXjAcqdZC1UJC/5m5Nd2Kamk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745698735; c=relaxed/simple;
	bh=2vGbCA/0GPQ+a2cVcbBjhlUeb/j9DM9E3nexa0LHANE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhfJX2Jd3N0/xx6k7yYMslzq1AlkIVpxh+4cdq+839We8V6Du6ROxChudFosR4ol7DQ3ges2bdjqhMp7WNJJfWvl9n4m2EBnxIbiF1J5BRh/k9trZ+7b4X6rmdOvgVNzu5aextPjCDBjGXxRXVaNawZO7Hcu8mQbJrP+jCf4O2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OvzA7apG; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1745698725; x=1745957925;
	bh=QZPkJsafjKMhe6Qtp58doq4pwYWbn6MnQzCYXsM+OOA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OvzA7apGLS9NeiDu5/tfkeiqZTN8fpW36g49KGg50Nl8hyIpuJYbUPgRfKK4HvJRT
	 Cx4lTABNdwsjNTZ3CIuQqSnn7ta+aib2BsM77zhk6mBnMmh+gK4E1EX/zTe5DQoIak
	 ZEt+tgHFuDXJZoNHWA7M5Oj8DvCrI9VrYYuisA+dfPqja9mfpBXBeX6UAu//5j9wgh
	 yorCVyhZCMp6G2BCo/MLlM6flV1A3HkQvA7Ik1gkNkEBW5q7QnlrjO8apB+ceyrPu6
	 EyMP4lIsFVVvLZUko0+DfsojKyKpm67oI/KWzVPa2z6CZT++bcpDrx2tcdtkjjCijY
	 jPkMi9tjHwjRw==
Date: Sat, 26 Apr 2025 20:18:39 +0000
To: Christian Schrefl <chrisi.schrefl@gmail.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: devres: implement Devres::access_with()
Message-ID: <D9GUJPGAOB21.3UTRD7M9OPLFJ@proton.me>
In-Reply-To: <78853ac7-c9d2-4485-bbb3-859d2425e729@gmail.com>
References: <20250426133254.61383-1-dakr@kernel.org> <20250426133254.61383-3-dakr@kernel.org> <ce224b78-5c26-46d9-9b69-6bceb1bda62d@gmail.com> <aA0TIWj50RYogLxj@pollux> <78853ac7-c9d2-4485-bbb3-859d2425e729@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 224823809a2d2f8e90e8047e6daa2bedf3b62381
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Apr 26, 2025 at 7:18 PM CEST, Christian Schrefl wrote:
> On 26.04.25 7:08 PM, Danilo Krummrich wrote:
>> On Sat, Apr 26, 2025 at 06:53:10PM +0200, Christian Schrefl wrote:
>>> On 26.04.25 3:30 PM, Danilo Krummrich wrote:
>>>> Implement a direct accessor for the data stored within the Devres for
>>>> cases where we can proof that we own a reference to a Device<Bound>
>>>> (i.e. a bound device) of the same device that was used to create the
>>>> corresponding Devres container.
>>>>
>>>> Usually, when accessing the data stored within a Devres container, it =
is
>>>> not clear whether the data has been revoked already due to the device
>>>> being unbound and, hence, we have to try whether the access is possibl=
e
>>>> and subsequently keep holding the RCU read lock for the duration of th=
e
>>>> access.
>>>>
>>>> However, when we can proof that we hold a reference to Device<Bound>
>>>> matching the device the Devres container has been created with, we can
>>>> guarantee that the device is not unbound for the duration of the
>>>> lifetime of the Device<Bound> reference and, hence, it is not possible
>>>> for the data within the Devres container to be revoked.
>>>>
>>>> Therefore, in this case, we can bypass the atomic check and the RCU re=
ad
>>>> lock, which is a great optimization and simplification for drivers.
>>>>
>>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>>> ---
>>>>  rust/kernel/devres.rs | 35 +++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 35 insertions(+)
>>>>
>>>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>>>> index 1e58f5d22044..ec2cd9cdda8b 100644
>>>> --- a/rust/kernel/devres.rs
>>>> +++ b/rust/kernel/devres.rs
>>>> @@ -181,6 +181,41 @@ pub fn new_foreign_owned(dev: &Device<Bound>, dat=
a: T, flags: Flags) -> Result {
>>>> =20
>>>>          Ok(())
>>>>      }
>>>> +
>>>> +    /// Obtain `&'a T`, bypassing the [`Revocable`].
>>>> +    ///
>>>> +    /// This method allows to directly obtain a `&'a T`, bypassing th=
e [`Revocable`], by presenting
>>>> +    /// a `&'a Device<Bound>` of the same [`Device`] this [`Devres`] =
instance has been created with.
>>>> +    ///
>>>> +    /// An error is returned if `dev` does not match the same [`Devic=
e`] this [`Devres`] instance
>>>> +    /// has been created with.
>>>
>>> I would prefer this as a `# Errors` section.
>>=20
>> I can make this an # Errors section.
>>=20
>>> Also are there any cases where this is actually wanted as an error?
>>> I'm not very familiar with the `Revocable` infrastructure,
>>> but I would assume a mismatch here to be a bug in almost every case,
>>> so a panic here might be reasonable.
>>=20
>> Passing in a device reference that doesn't match the device the Devres i=
nstance
>> was created with would indeed be a bug, but a panic isn't the solution, =
since we
>> can handle this error just fine.
>>=20
>> We never panic the whole kernel unless things go so utterly wrong that w=
e can't
>> can't recover from it; e.g. if otherwise we'd likely corrupt memory, etc=
.
>>> (I would be fine with a reason for using an error here in the=20
>>> commit message or documentation/comments)
>>=20
>> I don't think we need this in this commit or the method's documentation,=
 it's a
>> general kernel rule not to panic unless there's really no other way.
>
> Alright I'm fine with it then.
>
> I just don't think that most users of the function would be able to
> gracefully recover from that other than failing the probe
> or whatever, but it makes sense to allow the caller to deal with this.

Failing the probe *is* "gracefully" handling the error. As Danilo said,
a panic is the last resort when the whole world is on fire and you want
to avoid doing more damage to the system.

---
Cheers,
Benno


