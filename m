Return-Path: <linux-pci+bounces-32822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B110B0F67E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 17:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB281CC5880
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996D6309DB2;
	Wed, 23 Jul 2025 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="U8G1ZLbh"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264D2FF465;
	Wed, 23 Jul 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282560; cv=pass; b=WCi9lcZk3M5qL1pa0m1wSwhQKHHstjxCT4InOwbbzzHFzjPkGxPwu1pxm9oM3b9eqY0MaqJKZvbdzOtk719xfyPUfs+Um4URRx6evbu++imHN8Oxd/0GB/oYxYtLXqR594DJJrEUgP4OUWzMUdNYAe3z2vLKtDgP5cxbfoskVxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282560; c=relaxed/simple;
	bh=lSQrmhEgwu7KF7VuYErPsVcaycifpb4w2sf/ZlD88HU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=knN92aifVOrUGefqOpwfosMOAg6C7vKToSPJ3YF15dlsnIsWBen1A3dk0rVEqip/9/7bAEZLizxeGBUieinaJEGXwNA14HMIq2cNqH4xEWNBCwXaXLnUBx5Af/Hw+CtfcTf2DBVwbjV3tfhoj6wKhWuhvKj7pUeejwJIvWCBjDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=U8G1ZLbh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753282467; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CAbV/6nAU+BRyql8bLADOQcgzaqK2Gub+7grQv1ddt3gU2BMkocUTJxx3cavyxm24NQ9pnWqQWklc9lX+GF9ZkFKCEhAgmyeTQ1ugD/42V5GkAtJq300oRxgCczAQXp6GC2sQ7+eVo633XHpmtqkV1CvaoIyVO7+Yx3iTkWt5GE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753282467; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2lwWCq9zBGsw0LGnOcqUCoqzVzvg7jHi7JcvSLbMDS0=; 
	b=DeYo5R/hO2+8FBrJ865Bg1F4hp+yopt21Oq9x3kVvigq6HPkkYThZ2CCHgXnEVBWBuOxKFBaB4z9H4x3MtOMF9iKHKyK7k8epZwsUnzzlWmIESWC7qqOiBh0A1SVzn2I0UKCr41XtKtBW5YZQptAUPQfHnHKaTjCzwUMiybD/u4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753282467;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=2lwWCq9zBGsw0LGnOcqUCoqzVzvg7jHi7JcvSLbMDS0=;
	b=U8G1ZLbhJb+wlJOANZPzZ++HXHQ4A4K2n9kv0BoziLe/o019jxj30zffuq8YWyGY
	fnH/Q18GwZmlgrAjiamasdE1ZGW5kOiMncCQMqfqD4olLsMMii8PwabmIoM0L7dpHAl
	LDX1Q6JZ9JIEk2ADWQKO+SGlbEFaIccPO3ZdVKOo=
Received: by mx.zohomail.com with SMTPS id 1753282465210288.77001923495413;
	Wed, 23 Jul 2025 07:54:25 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aIDxFoQV_fRLjt3h@tardis-2.local>
Date: Wed, 23 Jul 2025 11:54:09 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <95A7ACD9-8D0D-41FB-A0C0-691B699CBA17@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <aIBl6JPh4MQq-0gu@tardis-2.local>
 <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com>
 <aIDxFoQV_fRLjt3h@tardis-2.local>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 23 Jul 2025, at 11:26, Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
> On Wed, Jul 23, 2025 at 10:55:20AM -0300, Daniel Almeida wrote:
>> Hi Boqun,
>>=20
>> [...]
>>=20
>>>> +        IrqRequest { dev, irq }
>>>> +    }
>>>> +
>>>> +    /// Returns the IRQ number of an [`IrqRequest`].
>>>> +    pub fn irq(&self) -> u32 {
>>>> +        self.irq
>>>> +    }
>>>> +}
>>>> +
>>>> +/// A registration of an IRQ handler for a given IRQ line.
>>>> +///
>>>> +/// # Examples
>>>> +///
>>>> +/// The following is an example of using `Registration`. It uses a
>>>> +/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior =
mutability.
>>>=20
>>> We are going to remove all usage of core::sync::Atomic* when the =
LKMM
>>> atomics [1] land. You can probably use `Completion` here (handler =
does
>>> complete_all(), and registration uses wait_for_completion()) because
>>> `Completion` is irq-safe. And this brings my next comment..
>>=20
>> How are completions equivalent to atomics? I am trying to highlight =
interior
>> mutability in this example.
>>=20
>=20
> Well, `Completion` also has interior mutability.
>=20
>> Is the LKMM atomic series getting merged during the upcoming merge =
window? Because my
>> understanding was that the IRQ series was ready to go in 6.17, =
pending a reply
>=20
> Nope, it's likely to be in 6.18.
>=20
>> from Thomas and some minor comments that have been mentioned in v7.
>>=20
>> If the LKMM series is not ready yet, my proposal is to leave the
>> Atomics->Completion change for a future patch (or really, to just use =
the new
>> Atomic types introduced by your series, because again, I don't think =
Completion
>> is the right thing to have there).
>>=20
>=20
> Why? I can find a few examples that an irq handler does a
> complete_all(), e.g. gpi_process_ch_ctrl_irq() in
> drivers/dma/qcom/gpi.c. I think it's very normal for a driver thread =
to
> use completions to wait for an irq to happen.
>=20
> But sure, this and the handler pinned initializer thing is not a =
blocker
> issue. However, I would like to see them resolved as soon as possible
> once merged.
>=20
> Regards,
> Boqun
>=20
>>=20
>> - Daniel


Because it is not as explicit. The main thing we should be conveying to =
users
here is how to get a &mut or otherwise mutate the data when running the
handler. When people see AtomicU32, it's a quick jump to "I can make =
this work
by using other locks, like SpinLockIrq". Completions hide this, IMHO.

It's totally possible for someone to see this and say "ok, I can call
complete() on this, but how can I mutate the data in some random T =
struct?",
even though these are essentially the same thing from an interior =
mutability
point of view.

-- Daniel



