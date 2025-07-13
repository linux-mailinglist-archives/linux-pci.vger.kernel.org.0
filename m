Return-Path: <linux-pci+bounces-32022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC2B0319F
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 16:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6AC1772FF
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA74279DB8;
	Sun, 13 Jul 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="JQNNuHFh"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0592797B5;
	Sun, 13 Jul 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752418176; cv=pass; b=qO2WGJePiE1jo1W40rar6E4VXi4b5raaJg3zZeUjAjp9vZZNeOthGqEppCzxslYVfapMyqJAnLk2NulA5YJSfIRkfZv9Yt5VTM/mfFH5nK18YrafzGStYy3r5kMgyT7VXxxF6v7YUHT7UU0t78W0m5tXiNUkSyuStm5KPR2crvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752418176; c=relaxed/simple;
	bh=Cs1jkwPsognhRmvjOTkU3B9F1YgxJGlhwxGU4P6f/hg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W2L/2tMREkMfJHIBWNprQ7PgMGRxjknmszdpelHc1vfBgbw3IsWtVvtSisqFy9eBlqWlYrogy4NEm1wC5Vr2L7KX9jzM+pyHI+q6EcZpD3AYHU5Mg5MtEPZr43sQde82cZmnwgrx3bG3hpD400L5bx2fDUgg/986H9DXCbwp/L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=JQNNuHFh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752418156; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KRRM8YeE1/PTvQGnts8Bi+1Q13m5Vb98Zo+44iAvKo7nA5Z0HkoHoJln8smtmmuqN8DnlXuj6I8nCMhVdUDERy08ojf/gfuI0nQBFTFtABynkzBLgDD9ZfEHlmxxlago2Svy7RhIKCqZUcVJRjmzOQ0DYKTNE1hyZGRhTnHrJYw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752418156; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8HuFwyIJWhmeawFZKh8tqUr8d7V3s0YizoLn1Uir9cQ=; 
	b=cD3rtKzC0jPdbHo2Z9ei0KauzNKzSI1abkVq/UPXLPV1USmEXKz1FxBwzz0qJgYLXLJnS2orpdHCwjXx0W85KcaeCUxsgyEU/xPhzgjIsl4ERvD1kGpBSYHY8mUEpRt9SE7vZZCH9WaWE5f3fvdD9n0lmovy3u/TdlaXOsfrBLc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752418156;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=8HuFwyIJWhmeawFZKh8tqUr8d7V3s0YizoLn1Uir9cQ=;
	b=JQNNuHFhKFaHN6u1zs9Y09DRmQ3x1h1nrhN7webTDJqROoBUiD9i89LTE1fGUuD/
	kQvhsFPxJbmCJVPBe3i3jMA7sWATkedU2EsDWKk90u2ZaiL1he25N1l+A5BSws7bOfH
	W6ONlp7Ou+U9p9HXE9IrH0k+lWlfDjmEngg+3sUk=
Received: by mx.zohomail.com with SMTPS id 1752418152811147.7251410187963;
	Sun, 13 Jul 2025 07:49:12 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DBAZXDRPYWPC.14RI91KYE16RM@kernel.org>
Date: Sun, 13 Jul 2025 11:48:53 -0300
Cc: Benno Lossin <lossin@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
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
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <18B23FD3-56E9-4531-A50C-F204616E7D17@collabora.com>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org>
 <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com>
 <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org>
 <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org>
 <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org>
 <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org>
 <C4A101A7-282D-4A67-A966-CF39850952EA@collabora.com>
 <DBAZRNHGIGL8.3L2NGPCVXLI25@kernel.org>
 <DBAZXDRPYWPC.14RI91KYE16RM@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 13 Jul 2025, at 11:27, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Sun Jul 13, 2025 at 4:19 PM CEST, Danilo Krummrich wrote:
>> On Sun Jul 13, 2025 at 4:09 PM CEST, Daniel Almeida wrote:
>>> On a second look, I wonder how useful this will be.
>>>=20
>>> fn handle(&self, dev: &Device<Bound>) -> IrqReturn
>>>=20
>>> Sorry for borrowing this terminology, but here we offer =
Device<Bound>, while I
>>> suspect that most drivers will be looking for the most derived =
Device type
>>> instead. So for drm drivers this will be drm::Device, for example, =
not the base
>>> dev::Device type. I assume that this pattern will hold for other =
subsystems as
>>> well.
>>>=20
>>> Which brings me to my second point: drivers can store an =
ARef<drm::Device> on
>>> the handler itself, and I assume that the same will be possible in =
other
>>> subsystems.
>>=20
>> Well, the whole point is that you can use a &Device<Bound> to =
directly access
>> device resources without any overhead, i.e.
>>=20
>> fn handle(&self, dev: &Device<Bound>) -> IrqReturn {
>>   let io =3D self.iomem.access(dev);
>>=20
>>   io.write32(...);
>> }
>=20
> So, yes, you can store anything in your handler, but the =
&Device<Bound> is a
> cookie for the scope.

Fine, but can=E2=80=99t you get a &Device<Bound> from a =
ARef<drm::Device>, for example?
Perhaps a nicer solution would be to offer this capability instead?=

