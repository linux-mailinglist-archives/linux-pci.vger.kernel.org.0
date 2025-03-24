Return-Path: <linux-pci+bounces-24543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A224FA6DFF0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 17:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D97E3B0688
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 16:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA10B263C85;
	Mon, 24 Mar 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="JpDdT+ey"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72F9262813
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834375; cv=none; b=kcXEydvvqigOHJ39CT/GAj7Wjpg9Ggtr7JKxolySgLp8Ezub2rlXiTRPb/OgTrArLj1JVOMJDEC8QicfxBYXaabSzyWoFTUFi5okvVTC1bF5LZNs8cC4X6dnct9A8MKnwH0px8yHV/rOnM7ESZtbgE5DOK2etmY2UuTFtwEqtWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834375; c=relaxed/simple;
	bh=M/tu2Elne1pWCI/q5zOSWCRw9rqFQ6EcGfnZYmdRtps=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oImnMhlFxNSJVy8gnfTZxM5kumg17D2ZTPYxy38efpsRqidG+P6Nik2/n/pGMjbId1JqNOHdwY12bpYDgGk+5i8gZMtcxZoEayCL58KK76Tripw3LBzAjVRW+/KQwobT5yQonjadPIF7V98oAJW6276xwRfqBklhv75CKRJBDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=JpDdT+ey; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=p6yri6f4p5ayrdaj5tyc2fv74e.protonmail; t=1742834371; x=1743093571;
	bh=ifYKmdtaNhgtRfXf0+4J1IB0aZUSdquuIytSMsdwDBw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=JpDdT+eypr4OP96ZK64A5HYyRjzFlQDDZ9EX6uSqBqEQl1gPc6F5N1Pb6APbYhZuU
	 rF8KHQ4TKNCP7PT5JQzuAtOlGdGn5kwPsgzZPIXloLCeT2k8KhsBDxdwkk06IbfLV8
	 L4fOwUalBfKtJ8WfWS5g1GU7clcfQO4yfS8yJ1Kd/EspvHv2WctBGyVaK2EaaURw0J
	 pCNSKzlHqQdsiT0Cbx3PWsUa6vrK6TEI8DMR6oknMXuaqn7ndSLz9gujAbEo4UzxGw
	 KZ1O7Afyjo0S2iCTh0V84x2jOSS2MFAonAhOLWUqAlFqaiwYbw6Xs+4ROfZOWxwmZM
	 1hjUQ8hDWE58A==
Date: Mon, 24 Mar 2025 16:39:25 +0000
To: Danilo Krummrich <dakr@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <D8ON7WC8WMFG.2S2JRK6G9TOSL@proton.me>
In-Reply-To: <Z-CG01QzSJjp46ad@pollux>
References: <20250321214826.140946-1-dakr@kernel.org> <20250321214826.140946-3-dakr@kernel.org> <2025032158-embezzle-life-8810@gregkh> <Z96MrGQvpVrFqWYJ@pollux> <Z-CG01QzSJjp46ad@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 990da4dcde6434a006d722b52b205a8f1cadb5ec
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 23, 2025 at 11:10 PM CET, Danilo Krummrich wrote:
> On Sat, Mar 22, 2025 at 11:10:57AM +0100, Danilo Krummrich wrote:
>> On Fri, Mar 21, 2025 at 08:25:07PM -0700, Greg KH wrote:
>> > Along these lines, if you can convince me that this is something that =
we
>> > really should be doing, in that we should always be checking every tim=
e
>> > someone would want to call to_pci_dev(), that the return value is
>> > checked, then why don't we also do this in C if it's going to be
>> > something to assure people it is going to be correct?  I don't want to
>> > see the rust and C sides get "out of sync" here for things that can be
>> > kept in sync, as that reduces the mental load of all of us as we trave=
rs
>> > across the boundry for the next 20+ years.
>>=20
>> I think in this case it is good when the C and Rust side get a bit
>> "out of sync":
>
> A bit more clarification on this:
>
> What I want to say with this is, since we can cover a lot of the common c=
ases
> through abstractions and the type system, we're left with the not so comm=
on
> ones, where the "upcasts" are not made in the context of common and well
> established patterns, but, for instance, depend on the semantics of the d=
river;
> those should not be unsafe IMHO.

I don't think that we should use `TryFrom` for stuff that should only be
used seldomly. A function that we can document properly is a much better
fit, since we can point users to the "correct" API.

---
Cheers,
Benno


