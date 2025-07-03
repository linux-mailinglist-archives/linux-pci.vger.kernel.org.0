Return-Path: <linux-pci+bounces-31440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 468FFAF7E6E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 19:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A0F568389
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FFE25A2B2;
	Thu,  3 Jul 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Cf8hxF4l"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FA8231845;
	Thu,  3 Jul 2025 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751562805; cv=pass; b=QzLs11MilKQ5rk0I8Ih7771DbQ1sIgnpir8GL2SgfS2Ws52DV89yWBuf7wi2BnDdFY+MY9Tol2zRVpHSeHjIiOup7bXzD/wuIHBQhbzYHcz3MQI2xEsNI77yYi7i6eTIMbTot8wDYSdL8mCt4YXQFjZ8yaA5jfRe6eDpmeCp/Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751562805; c=relaxed/simple;
	bh=JI1OwOY3zQzLq3yiPV0HEM9Y9NOBVNupb0VeT9yNC8o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fHkUdGG5MntF1l2T7CYIsntwwDI9EOy8A1lw7Vyq+Q/fbgul8VDgN1VmFZ1plq88/aFZamUA9hImjZKVhVmy3pncPBqWgNYCh4nEmj85m5D2QOVTqr3K4LYGfB3fg8V2kE4cBdNLnomyl52udVpQoWsxYUP8+Hj2lx9FuPX9INw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Cf8hxF4l; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751562764; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jSlYWBhqnoM5vAKtIZUNRres8319sqtLN/TC+Bn9u+nul8U9CZm6FcB9GgESdctqvPbN2+XylH2mXWjA+bXj26nQJ7q9V+Q+H4MliDWHIi777IAYQ5Y39vklkvMj5UZt+ngdUkM9eTc31adxZ1TbZPOaOg7Zc4sh2ROcKUwfDkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751562764; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HrNq4UTJ6ttt8LrruX7srwRArgwfAJFCU8Qsuz8S2+s=; 
	b=HEwkIAFWb+/dhzdG5vAncQu8yxBJkwAx3+X9UWnH56/WeAvwNEJMFMyzDSVrAA8KRfma0k75b/8wCUL1wlpeC1LhN0uWGh/91JGmUQfODyYXm+b4G1f+Fiq3VhRRHVL8D/lPQXUmjta2hV4NBbpLNRBaJXQZ44tKQEG3KRw129g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751562764;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=HrNq4UTJ6ttt8LrruX7srwRArgwfAJFCU8Qsuz8S2+s=;
	b=Cf8hxF4lwYzxUQvjFcgdJqtKL5urteCzNGcQAHy6Fun4yiGv/yI0gTIbY/9gydtB
	0zQ4WEdJgPIMCPneeamz/Uxl6vYc9enzAIsfkptnO4JF3sIRQShOBR1VicMacVeiKxW
	7vU4nbIz2kT4CnxWcPwjiDpMJSiaCpViilLidNW8=
Received: by mx.zohomail.com with SMTPS id 1751562761996291.7453668803788;
	Thu, 3 Jul 2025 10:12:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v5 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250627-topics-tyr-request_irq-v5-3-0545ee4dadf6@collabora.com>
Date: Thu, 3 Jul 2025 14:12:24 -0300
Cc: linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <022A0919-37A5-4FF0-B834-333E512EC0C6@collabora.com>
References: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
 <20250627-topics-tyr-request_irq-v5-3-0545ee4dadf6@collabora.com>
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

Hi,

[=E2=80=A6]

> +
> +/// Callbacks for an IRQ handler.
> +pub trait Handler: Sync {

I wonder if we should require =E2=80=99static here too?

Same for the Threaded trait.

> +    /// The actual handler function. As usual, sleeps are not allowed =
in IRQ
> +    /// context.
> +    fn handle(&self) -> IrqReturn;
> +}
> +
> +impl<T: ?Sized + Handler + Send> Handler for Arc<T> {
> +    fn handle(&self) -> IrqReturn {
> +        T::handle(self)
> +    }
> +}
> +
> +impl<T: ?Sized + Handler, A: Allocator> Handler for Box<T, A> {
> +    fn handle(&self) -> IrqReturn {
> +        T::handle(self)
> +    }
> +}
> +

=E2=80=94 Daniel=

