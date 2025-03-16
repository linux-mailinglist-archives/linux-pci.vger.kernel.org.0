Return-Path: <linux-pci+bounces-23894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE764A636D8
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 18:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188D616BC2E
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 17:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877701B042F;
	Sun, 16 Mar 2025 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="l+3UZqp/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B65614D2A0
	for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2025 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742147040; cv=none; b=Jr9SE2krKb//CyL2vEtOkpWs5wAytST+54Zk7HJD8yFb88fOk1kFx7QcXP9CLyUehwPJDZ5risTXw1AsZNv53nX/ZwG+fUvCZd0HRH6YFEX7ec5flNhDK+0qjajYPDKNCLt2q/gmvizfxUwNS6FNDp6niDxHRrEUFAsEZaEFqds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742147040; c=relaxed/simple;
	bh=o64eLVoVog4ME4YWMUmN5sAS9sQJ8sYQ3gIuGlJTMgE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YckJ8cG+1Oib2ZtaAhWTuL4cId5+iQoPRUu+ybJaF3eI9shcXXholTtf7q+/w9izxwZkEhEaORVSAu3N/Kk5yBDVR8//wqeKpkMQgb7CG5mycNKTWV4ZK+pyEuQhkaXxZ5TkkXChX9+M+M4zzPTlJ2ZAm79RWvdVKupqMXdfBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=l+3UZqp/; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742147029; x=1742406229;
	bh=kPw1f22H6ZHfTADi1LEXHxhp3GVsoW26GbykzG2hgu0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=l+3UZqp/QeesG8Z9WzEWF+a9xHrqkYqL7X8dfFehQYOVHqOV7GoGMnP70RCvZcnmb
	 6qywnVepjHzMnZVjT9AAmcGhQFmezKjCGSMdZuBk/yIfIAcLupXDHTCyKOkGU9TYBt
	 SltEpyOImPtWhec9ZPCKdgDiItVLMUUxvC9SaW3glBbLHr8jUHinjTogyVXpb17clq
	 HkAdCkxxf6SGRsZaZ4zAjpcFkyOiIZmsjEQIwQUE/x5L3POOn5lpbzUxm92VWfCrBl
	 6s0OEyN8i/Ddbv9Dj7aYC/Lu1doNR8owYOCvWj0511teGv/y5hDBE7iZ19DuOtzM8u
	 uQOqwlimXRJ9Q==
Date: Sun, 16 Mar 2025 17:43:45 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: workqueue: remove HasWork::OFFSET
Message-ID: <D8HVKRW45ESG.3NP8BPWF76RYT@proton.me>
In-Reply-To: <CAJ-ks9=AKR+LUMBjLNrC9NZst9+18Q3HTrWn4q+baz87BbG6Rw@mail.gmail.com>
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com> <20250307-no-offset-v1-2-0c728f63b69c@gmail.com> <D8G8DV3PX8VX.2WHSM0TWH8JWV@proton.me> <CAJ-ks9m2ZHguB9N9-WM0EsO5MjaZ9yRamo_9NytAdzaDdb9aWQ@mail.gmail.com> <D8GQGCVTK0IL.16YO67C0IKLHA@proton.me> <CAJ-ks9mUPkP=QDGekbi1PRfpKKigXj87-_a25JBGHVRSiEe_AA@mail.gmail.com> <D8H1FFDMNLR3.STRVYQI7J496@proton.me> <CAJ-ks9m-ab9Y5RD01higxZxbowZi_0tsSmCCw2umJLxBLH4dEw@mail.gmail.com> <CAJ-ks9=AKR+LUMBjLNrC9NZst9+18Q3HTrWn4q+baz87BbG6Rw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: bb3f7db5462249942b49d555054b3196c99d5a46
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 16, 2025 at 1:55 PM CET, Tamir Duberstein wrote:
> On Sat, Mar 15, 2025 at 2:12=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
>>
>> On Sat, Mar 15, 2025 at 2:06=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>> >
>> > On Sat Mar 15, 2025 at 4:37 PM CET, Tamir Duberstein wrote:
>> > > On Sat, Mar 15, 2025 at 5:30=E2=80=AFAM Benno Lossin <benno.lossin@p=
roton.me> wrote:
>> > >>
>> > >> On Fri Mar 14, 2025 at 9:44 PM CET, Tamir Duberstein wrote:
>> > >> > On Fri, Mar 14, 2025 at 3:20=E2=80=AFPM Benno Lossin <benno.lossi=
n@proton.me> wrote:
>> > >> >>
>> > >> >> On Fri Mar 7, 2025 at 10:58 PM CET, Tamir Duberstein wrote:
>> > >> >> >      /// Returns a pointer to the struct containing the [`Work=
<T, ID>`] field.
>> > >> >> >      ///
>> > >> >> >      /// # Safety
>> > >> >> >      ///
>> > >> >> >      /// The pointer must point at a [`Work<T, ID>`] field in =
a struct of type `Self`.
>> > >> >> > -    #[inline]
>> > >> >> > -    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mu=
t Self
>> > >> >> > -    where
>> > >> >> > -        Self: Sized,
>> > >> >>
>> > >> >> This bound is required in order to allow the usage of `dyn HasWo=
rk` (ie
>> > >> >> object safety), so it should stay.
>> > >> >>
>> > >> >> Maybe add a comment explaining why it's there.
>> > >> >
>> > >> > I guess a doctest would be better, but I still don't understand w=
hy
>> > >> > the bound is needed. Sorry, can you cite something or explain in =
more
>> > >> > detail please?
>> > >>
>> > >> Here is a link: https://doc.rust-lang.org/reference/items/traits.ht=
ml#dyn-compatibility
>> > >>
>> > >> But I realized that the trait wasn't object safe to begin with due =
to
>> > >> the `OFFSET` associated constant. So I'm not sure we need this. Ali=
ce,
>> > >> do you need `dyn HasWork`?
>> > >
>> > > I wrote a simple test:
>> >
>> > [...]
>> >
>> > > so I don't think adding the Sized bound makes sense - we'd end up
>> > > adding it on every item in the trait.
>> >
>> > Yeah the `Sized` bound was probably to make the cast work, so let's
>> > remove it.
>>
>> It's already removed, right?
>
> Ping. Can you help me understand what change, if any, you think is requir=
ed?

No change required, with my reply above I intended to take my
complaint away :)

---
Cheers,
Benno


