Return-Path: <linux-pci+bounces-24553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF6A6E164
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 18:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513187A6F0E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 17:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BFB265CB2;
	Mon, 24 Mar 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aJxFE3Z+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E137262815;
	Mon, 24 Mar 2025 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837822; cv=none; b=uKCWr6ocimRny7tt/L/o2SRdXaSLw83Td2yvQetCZVCBevfkYZrJ0sODOeBsOyKsQGkFy5aMc9OwAWPoEIoD5sbI6l6B+fybs1+oVDzQUQSDuJknax3BzYl6hUAImLZMOSubS42vLmsORCHbSgXRPUaXYgDgv4r+9cZIWW1ARUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837822; c=relaxed/simple;
	bh=pr+TErMsVxDlfkiS5MHu/5LIlKend1IEbpzReT3WRCs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kajCA8wnUcf/9Zum6aWdfhp47Un8kRymG4e/gKQnqMGkv7p58tqzSodFEnU5Cz+3A5ao7xDbBV4tL56p4OYbYLgaS4hAcEfUK78cykeA63oVDKJT40bCSvWW2Z5fuafzdVuSx2Ff/INefxhXpPj7rJoD4WGqVEi6dPOti9ixbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aJxFE3Z+; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742837812; x=1743097012;
	bh=gzjWOjpOta91XnfdGX5MvAMkuzEnujIhqjARpEPjTIo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=aJxFE3Z+1qsqYa3hVJ+gBJHED1dcKaiGpxcPPASqawq7u9fCjBjapsb5WGUMFycMj
	 I/OUrTVXk78LCc7c9XCkoRuCttvY/jd+9oSgWYxmBS+RNQnk8jEQ6JX4qgvnQfXvDx
	 s+ImhioG9IujYnHdT4pOPrdVoc9tsOjqNn3urNqJX495wQ83BuXeaPgRh5n7zQATB7
	 +fgar0I4BpwxMH8LlpexwncDpnGctNqumtgLr7ZAhr+P3+Z6lCfR8nFqlNt6Xe9PLO
	 t5rGfkzHzqVebkMBjHsCJePn3RRm/7D+JI1jKhAuRX15tGoyuIDNY35ch3Ingow1oV
	 yUSNuW+WGM/xw==
Date: Mon, 24 Mar 2025 17:36:45 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <D8OOFRRSLHP4.1B2FHQRGH3LKW@proton.me>
In-Reply-To: <Z-GNDE68vwhk0gaV@cassiopeiae>
References: <20250321214826.140946-1-dakr@kernel.org> <20250321214826.140946-3-dakr@kernel.org> <2025032158-embezzle-life-8810@gregkh> <Z96MrGQvpVrFqWYJ@pollux> <Z-CG01QzSJjp46ad@pollux> <D8ON7WC8WMFG.2S2JRK6G9TOSL@proton.me> <Z-GNDE68vwhk0gaV@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9c1e69920ada344c286ef23456f72788df8f151c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 24, 2025 at 5:49 PM CET, Danilo Krummrich wrote:
> On Mon, Mar 24, 2025 at 04:39:25PM +0000, Benno Lossin wrote:
>> On Sun Mar 23, 2025 at 11:10 PM CET, Danilo Krummrich wrote:
>> > On Sat, Mar 22, 2025 at 11:10:57AM +0100, Danilo Krummrich wrote:
>> >> On Fri, Mar 21, 2025 at 08:25:07PM -0700, Greg KH wrote:
>> >> > Along these lines, if you can convince me that this is something th=
at we
>> >> > really should be doing, in that we should always be checking every =
time
>> >> > someone would want to call to_pci_dev(), that the return value is
>> >> > checked, then why don't we also do this in C if it's going to be
>> >> > something to assure people it is going to be correct?  I don't want=
 to
>> >> > see the rust and C sides get "out of sync" here for things that can=
 be
>> >> > kept in sync, as that reduces the mental load of all of us as we tr=
avers
>> >> > across the boundry for the next 20+ years.
>> >>=20
>> >> I think in this case it is good when the C and Rust side get a bit
>> >> "out of sync":
>> >
>> > A bit more clarification on this:
>> >
>> > What I want to say with this is, since we can cover a lot of the commo=
n cases
>> > through abstractions and the type system, we're left with the not so c=
ommon
>> > ones, where the "upcasts" are not made in the context of common and we=
ll
>> > established patterns, but, for instance, depend on the semantics of th=
e driver;
>> > those should not be unsafe IMHO.
>>=20
>> I don't think that we should use `TryFrom` for stuff that should only be
>> used seldomly. A function that we can document properly is a much better
>> fit, since we can point users to the "correct" API.
>
> Most of the cases where drivers would do this conversion should be covere=
d by
> the abstraction to already provide that actual bus specific device, rathe=
r than
> a generic one or some priv pointer, etc.
>
> So, the point is that the APIs we design won't leave drivers with a reaso=
n to
> make this conversion in the first place. For the cases where they have to
> (which should be rare), it's the right thing to do. There is not an alter=
native
> API to point to.

Yes, but for such a case, I wouldn't want to use `TryFrom`, since that
trait to me is a sign of a canonical way to convert a value. So if it
shouldn't be used lightly, then I would prefer a normal method. Even if
there is no alternative API, we could say that it is unusual to use it
and the correct type should normally be available. This kind of
documentation is not possible with `TryFrom`.

For a user it won't make a big difference, they'll just call a method
not named `try_from`.

---
Cheers,
Benno


