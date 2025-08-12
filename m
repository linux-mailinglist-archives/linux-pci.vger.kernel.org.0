Return-Path: <linux-pci+bounces-33881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752DAB2380B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 21:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA3F623B86
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBCB285C89;
	Tue, 12 Aug 2025 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="HMlKFjFo"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC521A43B;
	Tue, 12 Aug 2025 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026303; cv=pass; b=h+SSi1HNh+WnvozUXL0iapGoarDHb2dhNaN0MALCCa+dmGs1l1cHdqJop0f/Q96aRj72Bg7xudF8QgcDLfrOBUcHAvnLJ8V09XUptyUOGAhvkm08gkn6N63I8WDejLtysYxC3dk3RoEQ+3wr+8BOtc6G3cOR9lSHVPfgZcHCPe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026303; c=relaxed/simple;
	bh=X010dt4M8kjVw5H5fDuTg6LtyzcPSDUVqnJXHPbf7ww=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=L4YytclMUE4ydLOn1YgPjUdFactpbz4rzOdxK6ro10YDicUeTQdGCjBOYNSLhMsJprisicdrsm3X5bF+zw/GCMo8vLFt2QG+Hj2C0rmK0kr0Al6I4lpJyZpdhzPkoVyZPBMvNz//Jb+8c/jMMAz75GHg4LGSbYKTyFhugYHVshQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=HMlKFjFo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755026265; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xgve4pZ3Z9RZS3TnrHT+xexKlq9WGDiFyqgzjTjoZJDp1HsBVfJYQ3UxR/jl6rQrH6mBKelFOuiq2OeZrA+ZJhIVK81NtL7TASS4dM3Rpl19ErZySHuz8Ju/6xucfQy8x5a2HSbj7gPZJ4m8/K+9UCA/ZHovyFf2QZjRka7IwZ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755026265; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HowzcOhqi3O6roTmvdhGX/VDaG77s7UCCc3lDRQ8ukg=; 
	b=hX+ct7aqbxiLx84COZ3G9EXXnWGfpLPicpQIPVP4RLViAdWRN0lqdWUl/dSmGJ9DxbtTS0SbqWo+gOKw+6sCckAco7hkm1Bi812Y6I1XrPkfrmDBb4uZlJadc7G3AhiERUKm6fIRRlH/octl5aA79B51qlqWVGulx9Qu2U3WpSw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755026264;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=HowzcOhqi3O6roTmvdhGX/VDaG77s7UCCc3lDRQ8ukg=;
	b=HMlKFjFo1xVVaNLjZiG3rMkQHRke1w+fV0x+a/EMaiZY+ChPzo0CXOHnU5HmqFPN
	BHoQWEBGfSb4A/PuykK38vPEtTqjwNUkQ8GPpzpJSsVojPwV0UsgzhKS7VflW9rV/pN
	9xaLjggn480sDhbjG4ZzwdpCbGO7dkNuJCy+LFw8=
Received: by mx.zohomail.com with SMTPS id 1755026262500131.7242334577868;
	Tue, 12 Aug 2025 12:17:42 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v9 0/7] rust: add support for request_irq
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DC0OOFT2RTO7.2PCAP981HCCN3@kernel.org>
Date: Tue, 12 Aug 2025 16:17:25 -0300
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
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Dirk Behme <dirk.behme@de.bosch.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B887813-8FA6-4627-9527-76547508E66A@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <DC0OOFT2RTO7.2PCAP981HCCN3@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Danilo,

> On 12 Aug 2025, at 16:07, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Mon Aug 11, 2025 at 6:03 PM CEST, Daniel Almeida wrote:
>=20
> Applied to driver-core-testing, thanks!

Awesome, thanks everyone involved here :)

>=20
>> Alice Ryhl (1):
>>      rust: irq: add &Device<Bound> argument to irq callbacks
>>=20
>> Daniel Almeida (6):
>>      rust: irq: add irq module
>>      rust: irq: add flags module
>=20
>    [ Use expect(dead_code) for into_inner(), fix broken intra-doc link =
and
>      typo. - Danilo ]

Right, I=E2=80=99ll consider inter-patch issues like this in the future, =
sorry.

[=E2=80=A6]

>=20
>    [ Remove expect(dead_code) from IrqRequest::new(), re-format macros =
and
>      macro invocations to not exceed 100 characters line length. - =
Danilo ]
>=20
>>      rust: pci: add irq accessors
>=20

How? rustfmt doesn=E2=80=99t format this, so I assume that you just =
manually
wrapped the lines in a suitable way?

=E2=80=94 Daniel=

