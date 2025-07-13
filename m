Return-Path: <linux-pci+bounces-32013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372A3B030A4
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 12:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CDA7A44DF
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0468F25A328;
	Sun, 13 Jul 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioAK7M8I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6A4A00;
	Sun, 13 Jul 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752402274; cv=none; b=bD0aFstDeex4xj22bAErQ6Bv/O0HG+DDS7MTi4Rf0srGVv1o2U4YlB4oZhCayIyhIxaB46oKFGRsvWYI76va+9LCYrRpbH96pILAbsWRGri0qvPSUVH1d2b/8RrOFUOtM9w68HdDzg/ZvAtvPJ/4ULftQE34JRdGaHWzP9me/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752402274; c=relaxed/simple;
	bh=KR/f9WSoeyMeCEi914nzYR+kgzKbA9YtbzQh4WHJuOk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=XnFFww8blUulqdNjBOwS0kKwbrguM7DBAYVzhMNtAVmcKxp2463nvh3abqkImdVRNmf9IHDig2C43R0USfAVOxlbN6NDiiof/ojIgweVzbRE4mg9/BODRjc1Vy4lk7gz/Jdv7DKwuFtZNdgP7SsejFFhRkm3LiUuNCDqwgEFl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioAK7M8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF02BC4CEE3;
	Sun, 13 Jul 2025 10:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752402274;
	bh=KR/f9WSoeyMeCEi914nzYR+kgzKbA9YtbzQh4WHJuOk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ioAK7M8IZy4y/A4fPY8yWUOm8uackE21W1Xu67AaSioq/8T8xqB6MP6bmrCbtH2dv
	 08fccUtb+lkp+YEiIOUXq9iX2ZgCirs6Y0LpwGo5xLy4QGoVHyDqHhsT3DlV1MrLmm
	 Y73gW00D/57e863Os5EVHi1lvWfcXoGPs+TQEwwv0CotepqVyeFMn4O8FwjXq9z0wF
	 TUa/bRZ7ZuwTufnPfA6bPQZihY1tZMIlCo8z6VaQfuU2cTA2kt0puOUC2Uj6hnUhQE
	 WLTQatWeoohq9BKyKQnb9y/ipXVL1VlGhN7f74+JqCLITcSWcD8TB/eC7VVTUmNkvK
	 jr41PGDIsYSnw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 12:24:28 +0200
Message-Id: <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Benno Lossin"
 <lossin@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com>
In-Reply-To: <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com>

On Sun Jul 13, 2025 at 1:32 AM CEST, Daniel Almeida wrote:
>
>
>> On 12 Jul 2025, at 18:24, Danilo Krummrich <dakr@kernel.org> wrote:
>>=20
>> On Thu Jul 3, 2025 at 9:30 PM CEST, Daniel Almeida wrote:
>>> +/// Callbacks for an IRQ handler.
>>> +pub trait Handler: Sync {
>>> +    /// The hard IRQ handler.
>>> +    ///
>>> +    /// This is executed in interrupt context, hence all corresponding
>>> +    /// limitations do apply.
>>> +    ///
>>> +    /// All work that does not necessarily need to be executed from
>>> +    /// interrupt context, should be deferred to a threaded handler.
>>> +    /// See also [`ThreadedRegistration`].
>>> +    fn handle(&self) -> IrqReturn;
>>> +}
>>=20
>> One thing I forgot, the IRQ handlers should have a &Device<Bound> argume=
nt,
>> i.e.:
>>=20
>> fn handle(&self, dev: &Device<Bound>) -> IrqReturn
>>=20
>> IRQ registrations naturally give us this guarantee, so we should take ad=
vantage
>> of that.
>>=20
>> - Danilo
>
> Hi Danilo,
>
> I do not immediately see a way to get a Device<Bound> from here:
>
> unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut=
 c_void) -> c_uint {
>
> Refall that we've established `ptr` to be the address of the handler. Thi=
s
> came after some back and forth and after the extensive discussion that Be=
nno
> and Boqun had w.r.t to pinning in request_irq().

You can just wrap the Handler in a new type and store the pointer there:

	#[pin_data]
	struct Wrapper {
	   #[pin]
	   handler: T,
	   dev: NonNull<Device<Bound>>,
	}

And then pass a pointer to the Wrapper field to request_irq();
handle_irq_callback() can construct a &T and a &Device<Bound> from this.

Note that storing a device pointer, without its own reference count, is
perfectly fine, since inner (Devres<RegistrationInner>) already holds a
reference to the device and guarantees the bound scope for the handler
callbacks.

It makes sense to document this as an invariant of Wrapper (or whatever we =
end
up calling it).

