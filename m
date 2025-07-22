Return-Path: <linux-pci+bounces-32717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699ACB0D810
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 13:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7724547E22
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2171F2E426B;
	Tue, 22 Jul 2025 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBVbEAzo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA12E425C;
	Tue, 22 Jul 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183313; cv=none; b=GHShF9NJy17SZa/s8gyvSotyUbzawpnhZDMB+yGyuVnmNOZSwRRPVb+og5zpMR8TBuxEeLJMJLcFp1aEZqqLT7ZyZHd88DWIS56aHb+FUKjuZaSaoBBW1aGd6CeGXiNEmQH8bD27G+1NNlPltSjwasNEuF4OfvwdQtzO8WHicWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183313; c=relaxed/simple;
	bh=tzsVfb1kk8DsL7ewK+ArZQHuqErMnKOq7wSuG4wpvUg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YZ/Q9xIQClWzRjcCOc5Iq3k4A8wEfk3ZewhtCeOMmljND4ypfpdAW8Bi2DzNVXRb9DvSwN+ABPWlvGH1Ij5onxWZUb/mLhQacA3ngF3PlFifdCmRlsmoROpxUPqdb5/SlKduHtFhQ3bHOTSGqFHvuj+XYZK7idaB19vCp4aqmYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBVbEAzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E67C4CEF4;
	Tue, 22 Jul 2025 11:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753183312;
	bh=tzsVfb1kk8DsL7ewK+ArZQHuqErMnKOq7wSuG4wpvUg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=RBVbEAzobwbTYs19yr3TB8IbNsRXakQ/UM1Uev57Anq0LYTlc01u0efkcXlsBsjjF
	 CYLht6GR6trBTJHTuw4x2xE9mHtC7J6YDBQFk9ngJChaCkDk0t5/KKtr4dVSV7O3dt
	 tnb2Ejmgo9sED3EJ0z0pMIFJoZHCCdnmLXP62DRmX5CY9ciPrMsVY8U+pIpS+BowQx
	 jX8rAuEjYoKUkkpo+HC0ob7SRQp9YfgdRa9JogLo6D4Zore+mNNEEiTAgDzs+xb60R
	 IrsGal2X8piI1k5g417tUBwb6oHUBx7J9dLdqWQlASK3INbxxvFrKhveeyusbV+nTG
	 Pccvp47GTKd2Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jul 2025 13:21:47 +0200
Message-Id: <DBIJM4PTRHAS.3KXPG1MHNS8K0@kernel.org>
Cc: "Alistair Popple" <apopple@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710022415.923972-1-apopple@nvidia.com>
 <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
 <DB9BF6WK8KMH.1RQOOMYBL6UAO@kernel.org>
 <DB9FUEJUOH3L.14CYPZ8YQT52E@kernel.org>
 <DB9H6HEF9CKG.2SAPXM8F9KOO3@kernel.org>
 <DB9IQAU4WPSP.XZL4ZDPT59KU@kernel.org>
 <bwbern2t7k5fcj6zxze6bjpasu3t26n6dmfptlmhbhd7qmligs@3fgwifsw7qai>
 <DBIHP8IP3OHA.8Y1S9ZV1Y1SZ@kernel.org>
 <DBIJ3POBANNM.KSO1I5557PFV@kernel.org>
 <be42295e-63e1-4e2f-986f-aef962f531bd@kernel.org>
In-Reply-To: <be42295e-63e1-4e2f-986f-aef962f531bd@kernel.org>

On Tue Jul 22, 2025 at 1:02 PM CEST, Danilo Krummrich wrote:
> On 7/22/25 12:57 PM, Benno Lossin wrote:
>> On Tue Jul 22, 2025 at 11:51 AM CEST, Danilo Krummrich wrote:
>>> I think they're good, but we're pretty late in the cycle now. That shou=
ld be
>>> fine though, we can probably take them through the nova tree, or in the=
 worst
>>> case share a tag, if needed.
>>>
>>> Given that, it would probably be good to add the Guarantee section on a=
s_raw(),
>>> as proposed by Benno, right away.
>>>
>>> @Benno: Any proposal on what this section should say?
>>=20
>> At a minimum I'd say "The returned pointer is valid.", but that doesn't
>> really say for what it's valid... AFAIK you're mostly using this pointer
>> to pass it to the C side, in that case, how about:
>
> It is used for for FFI calls and to access fields of the underlying
> struct pci_dev.

By "access fields" you mean read-only?

---
Cheers,
Benno

