Return-Path: <linux-pci+bounces-33683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FD3B1FD58
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 02:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9F03B81A8
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 00:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BB582866;
	Mon, 11 Aug 2025 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="UII5RW0Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85A14AA9;
	Mon, 11 Aug 2025 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754872829; cv=pass; b=oKl/CzWSi6+qZAbKycG7dk06Ao7Q+8oNblzB0AyDXTGSVznbErZauSAU4lntUyYt6K1jq91FwLbH0CwWA0M9EX52EAHog+5YkBqmixB4m0XlLbziY5BgZBlpQ547NT3rwzshOdbSeukZqEbTkZrRMPaU2qR9PPzOz9kyW80p9KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754872829; c=relaxed/simple;
	bh=A0ipEN40Au2x9JCuDrOO0F3Npvwn1/7h3yZR3/tVfZA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qjiR9LOtjPSba3IFZ8JFmG4GDTH5vL7PfCWsc9TILFk/HERpzvu5OiDWMO05JEykWO2cSOpwaaYHbD1dhiRQwSF14G6dDjch10fo1SFozyzVarxBusU8ck7iK5EHKrBsOVZ5GOY1OjTsU7mA/fRY7RN1t9MmAnzyyAdhg0MPdjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=UII5RW0Y; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754872792; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CMccxIfR8xB8llNrPnl2fxtzW+q/9moGWgHMOwsIZNdpJzZiwGmoGXSJrf9Jxsr+YYcaA5Zk8K3aOSnGCZEPP3oNS2BQxiqm+X70P+ajC57Cb3YdZ+xI/VAGEnhHY9NgHH/EGP+jOVRRs8cPBNwTpd9lVOKXSHBiFrJNlgxaW2k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754872792; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A0ipEN40Au2x9JCuDrOO0F3Npvwn1/7h3yZR3/tVfZA=; 
	b=DbjfOtzrXc2axDg9EUX466BEMBF59bMWceeS+fY74HDZMkiUM/1Qar81HJrJksCgUWfojIZf2g1bVuQXap5ZO9JsWxYX8UGiQ8CZPSnIuLQZEx9V9gcO5HV2Ngx5+hqRw9wZhS4CTNa409gvj4Lo+mNconFkX/I/WNnkh84VM6A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754872792;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=A0ipEN40Au2x9JCuDrOO0F3Npvwn1/7h3yZR3/tVfZA=;
	b=UII5RW0Y+IiT05LlztfQ1TsaYM/PELzwtMDiZso/XWwoM2PpLxcBStVNPUBuBTRo
	dA6PQXhH6ZLbkRcrceTZtkv8xL4Sz23cVliPx58N8amE/nKyN6aPPGpRXXZQeqGdT55
	yCnwvdjg6tA4kuyET6Y4Pt02zGCVXqONR/BD341E=
Received: by mx.zohomail.com with SMTPS id 1754872790323302.60131062492883;
	Sun, 10 Aug 2025 17:39:50 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] rust: irq: add &Device<Bound> argument to irq callbacks
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250721-irq-bound-device-v1-1-4fb2af418a63@google.com>
Date: Sun, 10 Aug 2025 21:39:34 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 Dirk Behme <dirk.behme@gmail.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FF68E31-94B8-4DD4-8A2D-A6FB44444110@collabora.com>
References: <20250721-irq-bound-device-v1-1-4fb2af418a63@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Alice,

> On 21 Jul 2025, at 11:38, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> When working with a bus device, many operations are only possible =
while
> the device is still bound. The &Device<Bound> type represents a proof =
in
> the type system that you are in a scope where the device is guaranteed
> to still be bound. Since we deregister irq callbacks when unbinding a
> device, if an irq callback is running, that implies that the device =
has
> not yet been unbound.
>=20
> To allow drivers to take advantage of that, add an additional argument
> to irq callbacks.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> This patch is a follow-up to Daniel's irq series [1] that adds a
> &Device<Bound> argument to all irq callbacks. This allows you to use
> operations that are only safe on a bound device inside an irq =
callback.
>=20
> The patch is otherwise based on top of driver-core-next.
>=20
> [1]: =
https://lore.kernel.org/r/20250715-topics-tyr-request_irq2-v7-0-d469c0f37c=
07@collabora.com
> ---
>=20

I tried to rebase this so we could send it together with v8 of the =
request_irq
series. However, is it me or this doesn't apply on v7?

> ---
> base-commit: d860d29e91be18de62b0f441edee7d00f6cb4972

Yeah, I couldn=E2=80=99t find this, sorry.

> change-id: 20250721-irq-bound-device-c9fdbfdd8cd9
>=20
> Best regards,
> --=20
> Alice Ryhl <aliceryhl@google.com>
>=20
>=20


My apologies.

=E2=80=94 Daniel


