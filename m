Return-Path: <linux-pci+bounces-25414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78675A7E5A1
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 18:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388CF3B17D5
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DCA206F34;
	Mon,  7 Apr 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QVhgxBu0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3E207676
	for <linux-pci@vger.kernel.org>; Mon,  7 Apr 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041186; cv=none; b=YozTgbiiVZlcjjFPJzxUf6l/mC5+rgzUPfwGDz15VHw+E8dUKmC6B0FugA3rE1nyZpoDdotM3BrWGtqmdC17C3wxeGPNMSoJ6Av3Kh7W3onzwnoFUu8CieYyQ/txdIASvGsTG6Vhyq11vVLtfPeCsGhpqJnbQ7bBcaIXEVtwFWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041186; c=relaxed/simple;
	bh=lSRirgD6vmXWR2W+LyxRShb2hqrhF7lTs6ytrW6ttLg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bby6215H2y4CkXatHt9kaNDU/aXAVuWZPsHluF16HHn+TyUq+RLmQa6X7/l1oHZnzlzT2eEYDJI5/L2oz0sI0fTcHPyQQhSt8BFRbohXEMQnvTDKjGeza7NvvdbaxkSLqKXduMsE8bYX7MNb9xbn0VB5OI8xX72bdYEjUglRBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QVhgxBu0; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744041168; x=1744300368;
	bh=UO58uVNVuqrkxontk+bpXoCuz/hQY26JfCS2dLBPfS4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=QVhgxBu03cUpTinM0Iick6X3X3GkWqA974KI2kzDFdH5mi0FU2YANJKNm4iJYYJa7
	 B9qasfCxqu0nRVCnYdO2tosa2m0Vlrfinv6dkSn4pR62xJIGn91dA/U4sHlKaCntEN
	 hGCU41p2o4BVXwBdgz3nLB0q7vWJLTWzRu560Fjdn3UV76D1j5/KkIzDtTWpcgmzwR
	 6Ddutdxcdlyi+EI9JoOnnaivxloLtPcwUTYwMKVxq1XxkpcYSBCeqFOmntIpXc0PX8
	 BNA8BnnhZy+JaJheBLxAOGGmyWeJSxvBSlU3JY3YOxCG5dRUM6bWGb4NP9E3lznlmw
	 KSySkKr8Nx6LA==
Date: Mon, 07 Apr 2025 15:52:42 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <D90IZQSXEDMM.1AKV40R0VB94T@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 308df588d7fde4ef846351eef06d533f1a7121cf
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Apr 2, 2025 at 11:06 AM CEST, Danilo Krummrich wrote:
> On Wed, Apr 02, 2025 at 12:05:56AM +0000, Benno Lossin wrote:
>> On Tue Apr 1, 2025 at 3:51 PM CEST, Danilo Krummrich wrote:
>> > On Mon, Mar 24, 2025 at 06:32:53PM +0000, Benno Lossin wrote:
>> >> On Mon Mar 24, 2025 at 7:13 PM CET, Danilo Krummrich wrote:
>> >> > On Mon, Mar 24, 2025 at 05:36:45PM +0000, Benno Lossin wrote:
>> >> >> On Mon Mar 24, 2025 at 5:49 PM CET, Danilo Krummrich wrote:
>> >> >> > On Mon, Mar 24, 2025 at 04:39:25PM +0000, Benno Lossin wrote:
>> >> >> >> On Sun Mar 23, 2025 at 11:10 PM CET, Danilo Krummrich wrote:
>> >> >> >> > On Sat, Mar 22, 2025 at 11:10:57AM +0100, Danilo Krummrich wr=
ote:
>> >> >> >> >> On Fri, Mar 21, 2025 at 08:25:07PM -0700, Greg KH wrote:
>> >> >> >> >> > Along these lines, if you can convince me that this is som=
ething that we
>> >> >> >> >> > really should be doing, in that we should always be checki=
ng every time
>> >> >> >> >> > someone would want to call to_pci_dev(), that the return v=
alue is
>> >> >> >> >> > checked, then why don't we also do this in C if it's going=
 to be
>> >> >> >> >> > something to assure people it is going to be correct?  I d=
on't want to
>> >> >> >> >> > see the rust and C sides get "out of sync" here for things=
 that can be
>> >> >> >> >> > kept in sync, as that reduces the mental load of all of us=
 as we travers
>> >> >> >> >> > across the boundry for the next 20+ years.
>> >> >> >> >>=20
>> >> >> >> >> I think in this case it is good when the C and Rust side get=
 a bit
>> >> >> >> >> "out of sync":
>> >> >> >> >
>> >> >> >> > A bit more clarification on this:
>> >> >> >> >
>> >> >> >> > What I want to say with this is, since we can cover a lot of =
the common cases
>> >> >> >> > through abstractions and the type system, we're left with the=
 not so common
>> >> >> >> > ones, where the "upcasts" are not made in the context of comm=
on and well
>> >> >> >> > established patterns, but, for instance, depend on the semant=
ics of the driver;
>> >> >> >> > those should not be unsafe IMHO.
>> >> >> >>=20
>> >> >> >> I don't think that we should use `TryFrom` for stuff that shoul=
d only be
>> >> >> >> used seldomly. A function that we can document properly is a mu=
ch better
>> >> >> >> fit, since we can point users to the "correct" API.
>> >> >> >
>> >> >> > Most of the cases where drivers would do this conversion should =
be covered by
>> >> >> > the abstraction to already provide that actual bus specific devi=
ce, rather than
>> >> >> > a generic one or some priv pointer, etc.
>> >> >> >
>> >> >> > So, the point is that the APIs we design won't leave drivers wit=
h a reason to
>> >> >> > make this conversion in the first place. For the cases where the=
y have to
>> >> >> > (which should be rare), it's the right thing to do. There is not=
 an alternative
>> >> >> > API to point to.
>> >> >>=20
>> >> >> Yes, but for such a case, I wouldn't want to use `TryFrom`, since =
that
>> >> >> trait to me is a sign of a canonical way to convert a value.
>> >> >
>> >> > Well, it is the canonical way to convert, it's just that by the des=
ign of other
>> >> > abstractions drivers should very rarely get in the situation of nee=
ding it in
>> >> > the first place.
>> >>=20
>> >> I'd still prefer it though, since one can spot a
>> >>=20
>> >>     let dev =3D CustomDevice::checked_from(dev)?
>> >>=20
>> >> much better in review than the `try_from` conversion. It also prevent=
s
>> >> one from giving it to a generic interface expecting the `TryFrom` tra=
it.
>> >
>> > (I plan to rebase this on my series introducing the Bound device conte=
xt [1].)
>> >
>> > I thought about this for a while and I still think TryFrom is fine her=
e.
>>=20
>> What reasoning do you have?
>
> The concern in terms of abuse is that one could try to randomly guess the
> "outer" device type (if any), which obiously indicates a fundamental desi=
gn
> issue.
>
> But that's not specific to devices; it is a common anti-pattern in OOP to
> randomly guess the subclass type of an object instance.
>
> So, I don't think the situation here is really that special such that it =
needs
> an extra highlight.

I re-read the docs on `TryFrom` and I have some new thoughts:
`TryFrom<device::Device> for pci::Device` is indeed similar to
`TryFrom<i64> for i32`. If the `device::Device` is embedded in a
`pci::Device`, then the `Ok` value is obvious. If not, then the error is
also clear and the user should do something in that case. So in this
regard, it's pretty natural to use `TryFrom`.

Now my initial thoughts were more on the side of if people should avoid
it, then it shouldn't be named `try_from`. But IIUC, most of the time
they won't be able to call `try_from`, since they already have the
correct type to begin with.

Ultimately this is your call to make, if you think that it's unlikely
that people will use the `try_from` in the wrong places, then go for it.

>> > At some point I want to replace this implementation with a macro, sinc=
e the code
>> > is pretty similar for bus specific devices. I think that's a bit clean=
er with
>> > TryFrom compared to with a custom method, since we'd need the bus spec=
ific
>> > device to call the macro from the generic impl, i.e.
>> >
>> > =09impl<Ctx: DeviceContext> Device<Ctx>
>> >
>> > rather than a specific one, which we can't control. We can control it =
for
>> > TryFrom though.
>>=20
>> We could have our own trait for that.
>
> I don't think we should have a trait specific for devices for this. If we=
 really
> think the above anti-pattern deserves special attention, then we should h=
ave a
> generic trait (e.g. FromSuper<T>) instead.
>
> But I'm not sure that we really need to put special attention on that.

That's fair, but I think then it would lose the `Device` specific docs
about not using it if there are other options.

---
Cheers,
Benno


