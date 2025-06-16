Return-Path: <linux-pci+bounces-29872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 201BBADB27B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 15:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97C57A4D7D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C14C2877F1;
	Mon, 16 Jun 2025 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="A8V7qrDQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1211D63F8;
	Mon, 16 Jun 2025 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081758; cv=pass; b=D/sZy8wjj9iWUjw1+b/n7GtYzWvcxf0NCz/T1siqXQiwCjCKLmzUjAxN+xpkTNF8dB/S4vkjgCPvdKrDfMNmpAa/36stpHtOeXUegSmOIqPOJwv728yd39mZEF+tTogIazwGU0NMdPfQWw4RvuT5hWeCAhSk+VJQMU2qtTrJmJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081758; c=relaxed/simple;
	bh=suG/XmN64poiwvdjtYlhbYfxNOYfNnN19diIXR+URYY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YNGktZj4eAPYLZP5V01Z/QC2PcwFWaziIZtczQo7QGIcNpQE7K06Hn1nzT0HjU8DKSey9XrOEQUoYKMPSH1a9SoT9b7yHsah5jpFx1rUXpGX4WUVX3Bk5eCEYYOxwH++PV3hsvusIdUrXIiNYhiFdiHBKKJoEdrRVrfGF6b5kW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=A8V7qrDQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750081736; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QOkFke+WYRdhFdoWYsFwbcjyaLKzKNw5qOZVzhtwMnkC8aHMsPHoCw/QiCXEp/9Ypa1VT7dBHA12lhloN7qHviAL3wTRkjorBOPpcflZK2Fl4f22aTVf3R+x2LOoxpbob/rTd0J5odSv6Cvwa1oerNYVx1ToYkntyST4iItDleM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750081736; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=F/rH2WrCUQ484FUFlRj5siQ69daSzn6eYUq3Oh+TEoA=; 
	b=DcMPcGCrew6QaLYGsiLfH3eXLW7MKhjOEbGXzk9JdIz6BBTP64jDYKkt63VC4NkX5qSZD9ftmb9otDVDKQR9uQAWImdPnUMCJjfrKUoGAfe8qOwy56ODAJRUKWJTzhThQ9qjqFu6rkazbgso0qVaNYMvmzJrdVBhDN5nvZx0LsE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750081736;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=F/rH2WrCUQ484FUFlRj5siQ69daSzn6eYUq3Oh+TEoA=;
	b=A8V7qrDQFujNu15YNu5iHvvHPfx9ilP21fKxk0qxc48bCSQezHjtuRu3sAE8HmQs
	ifHB+BeziJgMEUeUNra2Ay39jCpSs+Vy3V59m4LjPzpheE9dG9W51P8+susyRO89MiL
	OMC6NF0j3DrBPOVEbxtSK3mvkdm0J3r7YXrI3vwQ=
Received: by mx.zohomail.com with SMTPS id 1750081733380228.17260193114203;
	Mon, 16 Jun 2025 06:48:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 4/6] rust: irq: add support for threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <5B3865E5-E343-4B5D-9BF7-7B9086AA9857@collabora.com>
Date: Mon, 16 Jun 2025 10:48:37 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Benno Lossin <lossin@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4E43744-D3F5-4720-BC75-29C092BAF7A6@collabora.com>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-4-81cb81fb8073@collabora.com>
 <aEbTOhdfmYmhPiiS@pollux>
 <5B3865E5-E343-4B5D-9BF7-7B9086AA9857@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Danilo,

> On 9 Jun 2025, at 13:24, Daniel Almeida <daniel.almeida@collabora.com> =
wrote:
>=20
> Hi Danilo,
>=20
>> On 9 Jun 2025, at 09:27, Danilo Krummrich <dakr@kernel.org> wrote:
>>=20
>> On Sun, Jun 08, 2025 at 07:51:09PM -0300, Daniel Almeida wrote:
>>> +/// Callbacks for a threaded IRQ handler.
>>> +pub trait ThreadedHandler: Sync {
>>> +    /// The actual handler function. As usual, sleeps are not =
allowed in IRQ
>>> +    /// context.
>>> +    fn handle_irq(&self) -> ThreadedIrqReturn;
>>> +
>>> +    /// The threaded handler function. This function is called from =
the irq
>>> +    /// handler thread, which is automatically created by the =
system.
>>> +    fn thread_fn(&self) -> IrqReturn;
>>> +}
>>> +
>>> +impl<T: ?Sized + ThreadedHandler + Send> ThreadedHandler for Arc<T> =
{
>>> +    fn handle_irq(&self) -> ThreadedIrqReturn {
>>> +        T::handle_irq(self)
>>> +    }
>>> +
>>> +    fn thread_fn(&self) -> IrqReturn {
>>> +        T::thread_fn(self)
>>> +    }
>>> +}
>>=20
>> In case you intend to be consistent with the function pointer names =
in
>> request_threaded_irq(), it'd need to be handler() and thread_fn(). =
But I don't
>> think there's a need for that, both aren't really nice for names of =
trait
>> methods.
>>=20
>> What about irq::Handler::handle() and irq::Handler::handle_threaded() =
for
>> instance?
>>=20
>> Alternatively, why not just
>>=20
>> trait Handler {
>>  fn handle(&self);
>> }
>>=20
>> trait ThreadedHandler {
>>  fn handle(&self);
>> }
>>=20
>> and then we ask for `T: Handler + ThreadedHandler`.
>=20
> Sure, I am totally OK with renaming things, but IIRC I've tried  =
Handler +
> ThreadedHandler in the past and found it to be problematic. I don't =
recall why,
> though, so maybe it's worth another attempt.

Handler::handle() returns IrqReturn and ThreadedHandler::handle() =
returns
ThreadedIrqReturn, which includes WakeThread, so these had to be =
separate
traits.

I'd say lets keep it this way. This really looks like the discussion on
de-duplicating code, and as I said (IMHO) it just complicates the
implementation for no gain.

=E2=80=94 Daniel=

