Return-Path: <linux-pci+bounces-33772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B606B212BE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FB23E03B0
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091AE7081F;
	Mon, 11 Aug 2025 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Q+634RVf"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2015A18FC91;
	Mon, 11 Aug 2025 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931691; cv=pass; b=i3q8gOIyzdajBNbF7qZJZNhcKd6ZRNU7QZq0pniNnRk65aTvQTLLKPTAn84SmxtxlGjkG0H1iWypvPItRusgwmya+Ukkr46Y9QX8IXCkj7d16+VfuaOV11aukbgsWMMB3IfLkmz8EQXTJTlopAh6B7n6vWtcl3B8UZDRgZx+iX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931691; c=relaxed/simple;
	bh=3lgc9fCKmFCHzJ/DxPKn1Hk5wGollFcmNwXycC72ht4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PWvlrQj0iQDrrxrOrsEP0bMr1/XVicLtcizgCYBu/cw4lo/p+/+wK7TJ44DO6V65wlEPBPYyyT1TNOGxjLmb2x743ji9rd+RaOc7S5Y3wSqL2cZs8eIN1IbEys1CG/tR4taSA2IwL2biGg25BoUn9Z0cc/pzdqSU+v5IL9lNauA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Q+634RVf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754931666; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dy6EvbLqBLQpN91f2dEJ8Z9Tg2hczKJ/tdod4gZNSZ4g9dAGW+BRTSn1P0oYK0etoW2FhWXAg0Hp+no+PPI/Epo1bbqSjZendZdDau0FjE/utO6YO86h3NklYs0Oz+e6T4SCd6fwtCo3ZZIhtYt/MPjTJk33fcJuoBm0CRdDL2M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754931666; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3lgc9fCKmFCHzJ/DxPKn1Hk5wGollFcmNwXycC72ht4=; 
	b=L+VnCQlKEBc01pJHWt0e7TfmQ4QcKi4/gW6iQ3Jzff5TTnQLk+aYeqPZzdIxLRD1/6Q7s4XSa6jAL2MBXooVpz7ifGe5vicOw2Tgtwq+xIxhTyQ6GPhDOmxweM5zRDjr6vn92GZNiwzdcSAGKHpUwgGh/fxTvyJfD06fIdk7FUM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754931666;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=3lgc9fCKmFCHzJ/DxPKn1Hk5wGollFcmNwXycC72ht4=;
	b=Q+634RVfDD0/s2EiHjloiFD+xcZTgXce2ZuZm5CUuhQStz7giK3LxUCGQ9Kd07t9
	TyzaEnWHnHK/PHRyVHoWp3uk6mG8d+l93DD9Nn7oQ4PNy2/WMHgUgYuR3JyM3iPfLM7
	rCxZ7dS2yjC+zlpv0VQGf7VMOgbBlcZV1IMFml4o=
Received: by mx.zohomail.com with SMTPS id 1754931663749724.783897576166;
	Mon, 11 Aug 2025 10:01:03 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v9 7/7] rust: irq: add &Device<Bound> argument to irq
 callbacks
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250811-topics-tyr-request_irq2-v9-7-0485dcd9bcbf@collabora.com>
Date: Mon, 11 Aug 2025 14:00:47 -0300
Cc: linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <32B71539-BF90-4815-9085-2963F5DD69B5@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <20250811-topics-tyr-request_irq2-v9-7-0485dcd9bcbf@collabora.com>
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
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 11 Aug 2025, at 13:03, Daniel Almeida =
<daniel.almeida@collabora.com> wrote:
>=20
> From: Alice Ryhl <aliceryhl@google.com>
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

Sorry. I forgot to add my SOB here.


Perhaps this can be added when the patch is being applied in order to =
cut down on the
number of versions, and therefore avoid the extra noise? Otherwise let =
me know.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>



