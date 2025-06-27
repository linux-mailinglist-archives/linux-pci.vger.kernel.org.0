Return-Path: <linux-pci+bounces-30949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5B1AEBD72
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 18:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564C5567F7F
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C231D5CDE;
	Fri, 27 Jun 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="K18JUEzi"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163E01C1741;
	Fri, 27 Jun 2025 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041812; cv=pass; b=RPdLTP83DXtKmKysIRy5kbhrmNghqIsR+6nXu4DqTb7+XrfqNUdVjmB0MdcxPhVDo7C1jjaD8CfAy4Vyj4lBTMCKQydZS+7JxIrCidJlJirJrD7EBgiZUNLlKW6b9e+YUh1eAfbQSm2pXwVUlL9IEj4rAkbwxIyh3ebuGOPbm68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041812; c=relaxed/simple;
	bh=uZOpiqDnsPeN80lkYsgZGsg3XngV1n4ZEp+gMiBSaLo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i/GhkyYEba4XXVGz6CqA+3fE/hDxlsT0xouHS3453uMLfA4BYNkbye8b4wxPge3apV9ky7vYrePkGJMgPuplwXJX3IvYrnatJp4iOss4xxlbYHniF4sEqgQBl4LbfN15LGzyEQ0XZraw+h2DVKe5hDsKvwVRPzBXFmWD0uROoRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=K18JUEzi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751041789; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kybPJYkwMmG8BMGNFyE8OOoidf5kSHfCd7oOzb00Z5/iXMZGfd3WAHFvoMaD2oWKkcT/5ionolbmCph4fETBIAKkCtPEwpHLj5OW9QMwE6YJildn1NKHXktHXdIcAZNSoL/8Pf0hdibHVEWtcsxz9XREjvFuuMLVv3T4ozN3ZBI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751041789; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1UYgOu06ruRDAYOcp4JfazG4HIO4Q2KaS4cnFmSM66M=; 
	b=aCruIxIdxItIKw2gwoarURCrKaR/IQQsnwRvLgMagk0Kl2dT/0pos3tfL6UkuqcKTXXE3ZRx678tRATyyQVhDrAtufRzQB2NXa6DK6bLqw6p9tFkMuLLV6BXczLBLlmSC1qgjpYPTy1OGvVVtTH0XXwuUu9DT81nvP0f74M6yJ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751041789;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=1UYgOu06ruRDAYOcp4JfazG4HIO4Q2KaS4cnFmSM66M=;
	b=K18JUEziMCfx3B/fRsaqyjFHGgBMBxOzzmRMWCtx65njiyUlkxEtfa0kRFBXmIOk
	L9LQ71GMnfOin7/wmUXxKJyyCmmmRe8lzC9VcqSlAJs4GBSSrdsKtXl9nMBqhhY55Kn
	ejY41ZOUux89RkVtxTXrD0b3/NcvvvN8uzYcvynk=
Received: by mx.zohomail.com with SMTPS id 1751041787930194.57928858422827;
	Fri, 27 Jun 2025 09:29:47 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v5 0/6] rust: add support for request_irq
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
Date: Fri, 27 Jun 2025 13:29:31 -0300
Cc: linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FF34F9D-4FA6-4463-8922-3894E088CDD2@collabora.com>
References: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Benno Lossin <lossin@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 27 Jun 2025, at 13:21, Daniel Almeida =
<daniel.almeida@collabora.com> wrote:
>=20
>=20
> ---
> Changes in v5:
>=20
> Thanks, Danilo {
>  - Removed extra scope in the examples.
>  - Renamed Registration::register() to Registration::new(),
>  - Switched to try_pin_init! in Registration::new() (thanks for the
>    code and the help, Boqun and Benno)
>  - Renamed the trait functions to handle() and handle_on_thread().
>  - Introduced IrqRequest with an unsafe pub(crate) constructor
>  - Made both register() and the accessors that return IrqRequest =
public
>    the idea is to allow both of these to work:
> // `irq` is an `irq::Registration`
> let irq =3D pdev.threaded_irq_by_name()?
>  and
> // `req` is an `IrqRequest`.
> let req =3D pdev.irq_by_name()?;
> // `irq` is an `irq::Registration`
> let irq =3D irq::ThreadedRegistration::new(req)?;
>=20
>  - Added another name in the byname variants. There's now one for the
>    request part and the other one to register()
>  - Reworked the examples in request.rs
>  - Implemented the irq accessors in place for pci.rs
>  - Split the platform accessor macros into two
> }
>=20
> - Added a rust helper for pci_irq_vectors if !CONFIG_PCI_MSI (thanks,
> Intel 0day bot)
> - Link to v4: =
https://lore.kernel.org/r/20250608-topics-tyr-request_irq-v4-0-81cb81fb807=
3@collabora.com
>=20

Sorry, I forgot to mention that this now depends on the new Devres =
series at [0].

[0]  =
https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=3Dru=
st/devres



